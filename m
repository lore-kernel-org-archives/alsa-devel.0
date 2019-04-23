From: Rob van der Putten <rob@sput.nl>
Subject: [PATCH] Aseqnet, no nagle and dual stack
Date: Tue, 23 Apr 2019 20:25:58 +0200
Message-ID: <q9nlbm$3kqm$1@blaine.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from blaine.gmane.org (unknown [195.159.176.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 05585F80730
 for <alsa-devel@alsa-project.org>; Tue, 23 Apr 2019 20:26:04 +0200 (CEST)
Received: from list by blaine.gmane.org with local (Exim 4.89)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1hJ07H-000VEO-DA
 for alsa-devel@alsa-project.org; Tue, 23 Apr 2019 20:26:03 +0200
Content-Language: en-GB
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi there


Not an ALSA source patch, but a patch for an ALSA related util.
Aseqnet sends ALSA sound_seq MIDI over TCP/IP. The patch below disables 
nagle, enables quickack and makes aseqnet dual-stack.


--- aseqnet.c.bak	2012-01-25 10:43:38.000000000 +0100
+++ aseqnet.c	2017-08-26 14:17:58.261868853 +0200
@@ -3,6 +3,8 @@
   *   ver.0.1
   *
   * Copyright (C) 1999-2000 Takashi Iwai
+ * Modified by Rob van der Putten, Leiden, Holland,
+ * rob at sput dot nl.
   *
   *  This program is free software; you can redistribute it and/or modify
   *  it under the terms of the GNU General Public License version 2 as
@@ -15,18 +17,21 @@
   *
   */

+#include <alsa/asoundlib.h>
+#include <arpa/inet.h>
+#include <assert.h>
+#include <ctype.h>
+#include <getopt.h>
+#include <locale.h>
+#include <netdb.h>
+#include <netinet/in.h>
+#include <netinet/tcp.h>
+#include <signal.h>
  #include <stdio.h>
  #include <stdlib.h>
-#include <ctype.h>
  #include <string.h>
-#include <netinet/in.h>
  #include <sys/socket.h>
-#include <netdb.h>
-#include <locale.h>
-#include <alsa/asoundlib.h>
-#include <getopt.h>
-#include <signal.h>
-#include <assert.h>
+#include <sys/types.h>
  #include "aconfig.h"
  #include "gettext.h"

@@ -327,17 +332,24 @@
   */
  static void init_server(int port)
  {
+	/*
+	*       RvdP, changed to support IPv6
+	*       Dual stack only!
+	*/
  	int i;
  	int curstate = 1;
-	struct sockaddr_in addr;
+	int ipv6only = 0;
+	int nodelay  = 1;
+	int quickack = 1;
+	struct sockaddr_in6 addr;

  	memset(&addr, 0, sizeof(addr));

-	addr.sin_family = AF_INET;
-	addr.sin_addr.s_addr = INADDR_ANY;
-	addr.sin_port = htons(port);
+	addr.sin6_family = AF_INET6;
+	inet_pton(AF_INET6, "::", &(addr.sin6_addr));
+	addr.sin6_port = htons(port);

-	sockfd = socket(AF_INET, SOCK_STREAM, 0);
+	sockfd = socket(PF_INET6, SOCK_STREAM, 0);
  	if (sockfd < 0)  {
  		perror("create socket");
  		exit(1);
@@ -345,7 +357,19 @@
  	setsockopt(sockfd, SOL_SOCKET, SO_REUSEADDR, &curstate, 
sizeof(curstate));
  	/* the return value is ignored.. */

-	if (bind(sockfd, (struct sockaddr *)&addr, sizeof(addr)) < 0)  {
+	/*    Force dual stack    */
+	setsockopt(sockfd, IPPROTO_IPV6, IPV6_V6ONLY, &ipv6only, 
sizeof(ipv6only));
+	/* the return value is ignored.. */
+
+	/*    Nagle and quickack  */
+	if ((setsockopt(sockfd, IPPROTO_TCP, TCP_NODELAY, &nodelay, 
sizeof(nodelay))) < 0) {
+		perror("Error setsockopt tcp_nodelay");
+	}
+	if ((setsockopt(sockfd, IPPROTO_TCP, TCP_QUICKACK, &quickack, 
sizeof(quickack))) < 0) {
+		perror("Error setsockopt tcp_quickack");
+	}
+
+	if (bind(sockfd, (struct sockaddr *) &addr, sizeof(addr)) < 0)  {
  		perror("can't bind");
  		exit(1);
  	}
@@ -394,30 +418,58 @@
   */
  static void init_client(char *server, int port)
  {
-	struct sockaddr_in addr;
-	struct hostent *host;
-	int curstate = 1;
-	int fd;
+	/*
+	*	RvdP, changed to support IPv6
+	*/

-	if ((fd = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP)) < 0){
-		perror("create socket");
+	struct addrinfo hints;
+	struct addrinfo *result, *rp;
+	int curstate = 1;
+	int nodelay  = 1;
+	int quickack = 1;
+	int fd, s;
+	char portstr[8];
+
+	memset(&hints, 0, sizeof(struct addrinfo));
+	hints.ai_family   = AF_UNSPEC;
+	hints.ai_socktype = SOCK_STREAM;
+	/* hints.ai_protocol = IPPROTO_TCP; */
+	hints.ai_flags    = 0;
+
+	memset(portstr, 0, 8);
+	snprintf(portstr, 6, "%d", port);
+
+	s = getaddrinfo(server, portstr, &hints, &result);
+	if (s != 0) {
+		fprintf(stderr, "getaddrinfo: %s\n", gai_strerror(s));
+		exit(1);
+	}
+	for (rp = result; rp != NULL; rp = rp->ai_next) {
+		fd = socket(rp->ai_family, rp->ai_socktype, rp->ai_protocol);
+		if (fd == -1)
+			continue;
+		if (connect(fd, rp->ai_addr, rp->ai_addrlen) != -1)
+			break;
+		close(fd);
+	}
+	if (rp == NULL) {
+		fprintf(stderr, "Could not connect\n");
  		exit(1);
  	}
+
  	if (setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &curstate, 
sizeof(curstate)) < 0) {
  		perror("setsockopt");
  		exit(1);
  	}
-	if ((host = gethostbyname(server)) == NULL){
-		fprintf(stderr, _("can't get address %s\n"), server);
-		exit(1);
+
+	/*  RvdP, nagle and quickack  */
+	if ((setsockopt(fd, IPPROTO_TCP, TCP_NODELAY, &nodelay, 
sizeof(nodelay))) < 0) {
+		perror("Error setsockopt tcp_nodelay");
  	}
-	addr.sin_port = htons(port);
-	addr.sin_family = AF_INET;
-	memcpy(&addr.sin_addr, host->h_addr, host->h_length);
-	if (connect(fd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
-		perror("connect");
-		exit(1);
+	if ((setsockopt(fd, IPPROTO_TCP, TCP_QUICKACK, &quickack, 
sizeof(quickack))) < 0) {
+		perror("Error setsockopt tcp_quickack");
  	}
+
  	if (verbose)
  		fprintf(stderr, _("ok.. connected\n"));
  	netfd[0] = fd;


Regards,
Rob
