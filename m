From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: [PATCH] alsa-utils: Allow building in subdirectory.
Date: Wed,  7 Jul 2010 15:54:20 +0200
Message-ID: <1278510860-14272-1-git-send-email-thierry.reding@avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.9])
	by alsa0.perex.cz (Postfix) with ESMTP id 8E646244E4
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Jul 2010 15:52:46 +0200 (CEST)
Received: from mailbox.adnet.avionic-design.de
	(add-virt-zarafa.adnet.avionic-design.de [172.20.129.9])
	by benhur.adnet.avionic-design.de (Postfix) with ESMTP id 3FC852C4112
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Jul 2010 15:52:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mailbox.adnet.avionic-design.de (Postfix) with ESMTP id 48F972A280B8
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Jul 2010 15:52:45 +0200 (CEST)
Received: from mailbox.adnet.avionic-design.de ([127.0.0.1])
	by localhost (mailbox.avionic-design.de [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id XVIgpWar3Cxr for <alsa-devel@alsa-project.org>;
	Wed,  7 Jul 2010 15:52:45 +0200 (CEST)
Received: from localhost (avionic-0027.adnet.avionic-design.de [172.20.13.224])
	(Authenticated sender: thierry.reding)
	by mailbox.adnet.avionic-design.de (Postfix) with ESMTPA id
	2326F2A2809C for <alsa-devel@alsa-project.org>;
	Wed,  7 Jul 2010 15:52:45 +0200 (CEST)
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

This patch allows building alsa-utils in a separate subdirectory.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
 alsactl/Makefile.am   |    2 ++
 alsamixer/Makefile.am |    2 +-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/alsactl/Makefile.am b/alsactl/Makefile.am
index 359f73a..945a54c 100644
--- a/alsactl/Makefile.am
+++ b/alsactl/Makefile.am
@@ -1,5 +1,7 @@
 SUBDIRS = init
 
+INCLUDES = -I$(top_srcdir)/include
+
 sbin_PROGRAMS=alsactl
 man_MANS=alsactl.1
 if USE_XMLTO
diff --git a/alsamixer/Makefile.am b/alsamixer/Makefile.am
index 1de47c6..d01b1e4 100644
--- a/alsamixer/Makefile.am
+++ b/alsamixer/Makefile.am
@@ -1,4 +1,5 @@
 AM_CFLAGS = @CURSES_CFLAGS@ -DCURSESINC="@CURSESINC@"
+INCLUDES = -I$(top_srcdir)/include
 LDADD = @CURSESLIB@
 
 bin_PROGRAMS = alsamixer
@@ -18,7 +19,6 @@ alsamixer_SOURCES = card_select.c card_select.h \
 		widget.c widget.h
 man_MANS = alsamixer.1
 EXTRA_DIST = alsamixer.1
-alsamixer_INCLUDES = -I$(top_srcdir)/include
 
 #LDFLAGS = -static
 #CFLAGS += -g -Wall
-- 
1.7.1
