FROM registry.access.redhat.com/ubi8/ubi:8.0

MAINTAINER abc.example.com

ENV DOCROOT=/var/www/html 


RUN   yum install -y --nodocs --disableplugin=subscription-manager httpd 
RUN   yum install php
RUN  yum install java*
RUN   yum clean all --disableplugin=subscription-manager -y 
RUN  echo "Hello OpenShift from the httpd-parent container!" > ${DOCROOT}/index.html

ONBUILD COPY src/ ${DOCROOT}/

EXPOSE 80

RUN rm -rf /run/httpd && mkdir /run/httpd

USER root

CMD /usr/sbin/httpd -DFOREGROUND
