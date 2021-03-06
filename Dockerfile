FROM ubuntu:16.04

ENV DEBIAN_FRONTEND noninteractive

WORKDIR /tmp
RUN apt-get update
RUN apt-get install -y wget curl git


#Install kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
RUN chmod +x ./kubectl
RUN mv ./kubectl /usr/bin/kubectl

#Install kubectx
COPY install-kubectx.sh .
RUN ./install-kubectx.sh

##Install Kustomize
RUN wget https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv3.2.3/kustomize_kustomize.v3.2.3_linux_amd64
RUN mv kustomize_kustomize.v3.2.3_linux_amd64 kustomize
RUN chmod +x kustomize
RUN mv kustomize /usr/bin/kustomize

#install AZ
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Install Envsubst
RUN apt-get install -y gettext-base

#Setup entrypoint
COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

CMD [ "version" ]
