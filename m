From: nokos@gmx.net
Subject: [PATCH] ALSA: Reduce stall detection timeout in
	riptide.c
Date: Wed, 03 Dec 2008 15:32:15 +0100
Message-ID: <1228314735.17236.21.camel@earth.gruber.myown>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net
	[151.189.21.49])
	by alsa0.perex.cz (Postfix) with ESMTP id 181271037F4
	for <alsa-devel@alsa-project.org>; Wed,  3 Dec 2008 15:32:23 +0100 (CET)
Received: from mail-in-13-z2.arcor-online.net (mail-in-13-z2.arcor-online.net
	[151.189.8.30])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id 1A7993029FB
	for <alsa-devel@alsa-project.org>; Wed,  3 Dec 2008 15:32:22 +0100 (CET)
Received: from mail-in-16.arcor-online.net (mail-in-16.arcor-online.net
	[151.189.21.56])
	by mail-in-13-z2.arcor-online.net (Postfix) with ESMTP id 04EC61B8E4A
	for <alsa-devel@alsa-project.org>; Wed,  3 Dec 2008 15:32:22 +0100 (CET)
Received: from [0.0.0.0] (dslb-084-056-101-250.pools.arcor-ip.net
	[84.56.101.250]) (Authenticated sender: nokos@arcor.de)
	by mail-in-16.arcor-online.net (Postfix) with ESMTP id DE094236E43
	for <alsa-devel@alsa-project.org>; Wed,  3 Dec 2008 15:32:21 +0100 (CET)
Received: from 127.0.0.1 (ident=fxsthYTdFwF) by earth.gruber.myown with
	esmtp (masqmail 0.2.21) id 1L7sm0-0JM-00 for
	<alsa-devel@alsa-project.org>; Wed, 03 Dec 2008 15:32:16 +0100
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Reduce the command timeout to 0.5sec. Should be enough to allow a
working command interface but removes a RCU stall and slow resume on
some revisions where the AC97 revision detection stalls in resume. 

Signed-off-by: Peter Gruber <nokos@gmx.net>
---


diff --git a/sound/pci/riptide/riptide.c b/sound/pci/riptide/riptide.c
index e9f0706..d0ccfc6 100644
--- a/sound/pci/riptide/riptide.c
+++ b/sound/pci/riptide/riptide.c
@@ -172,7 +172,7 @@
 
 #define MAX_WRITE_RETRY  10    /* cmd interface limits */
 #define MAX_ERROR_COUNT  10
-#define CMDIF_TIMEOUT    500000
+#define CMDIF_TIMEOUT    50000
 #define RESET_TRIES      5
 
 #define READ_PORT_ULONG(p)     inl((unsigned long)&(p))
