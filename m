From: Jordi Mallach <jordi@debian.org>
Subject: [PATCH 3/8] Set firmware location to /lib/firmware,
	as expected with modern udev.
Date: Wed, 15 May 2013 19:19:06 +0200
Message-ID: <1368638351-29200-4-git-send-email-jordi@debian.org>
References: <1368638351-29200-1-git-send-email-jordi@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tempesta.oskuro.net (tempesta.oskuro.net [92.243.30.96])
 by alsa0.perex.cz (Postfix) with ESMTP id 9FA562652BF
 for <alsa-devel@alsa-project.org>; Wed, 15 May 2013 19:19:21 +0200 (CEST)
Received: from penyagolosa.oskuro.net (169.219.14.37.dynamic.jazztel.es
 [37.14.219.169])
 by tempesta.oskuro.net (Postfix) with ESMTPSA id ECC0C62A0B
 for <alsa-devel@alsa-project.org>; Wed, 15 May 2013 19:19:20 +0200 (CEST)
In-Reply-To: <1368638351-29200-1-git-send-email-jordi@debian.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Jordi Mallach <jordi@debian.org>
---
 hdsploader/Makefile.am   |    2 +-
 mixartloader/Makefile.am |    2 +-
 pcxhrloader/Makefile.am  |    2 +-
 usx2yloader/Makefile.am  |    2 +-
 vxloader/Makefile.am     |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hdsploader/Makefile.am b/hdsploader/Makefile.am
index 17cedc7..a7abefb 100644
--- a/hdsploader/Makefile.am
+++ b/hdsploader/Makefile.am
@@ -3,7 +3,7 @@ MYNAME = hdsploader
 
 bin_PROGRAMS = hdsploader
 
-AM_CFLAGS = -DDATAPATH=\"$(datadir)/alsa/firmware/$(MYNAME)\"
+AM_CFLAGS = -DDATAPATH=\"/lib/firmware/$(MYNAME)\"
 
 hdsploader_SOURCES = hdsploader.c
 
diff --git a/mixartloader/Makefile.am b/mixartloader/Makefile.am
index 1b488c4..2b7ca3b 100644
--- a/mixartloader/Makefile.am
+++ b/mixartloader/Makefile.am
@@ -3,7 +3,7 @@ AUTOMAKE_OPTIONS = 1.3 foreign
 
 MYNAME = mixartloader
 
-AM_CFLAGS = -DDATAPATH=\"$(datadir)/alsa/firmware/$(MYNAME)\"
+AM_CFLAGS = -DDATAPATH=\"/lib/firmware/$(MYNAME)\"
 
 bin_PROGRAMS = mixartloader
 
diff --git a/pcxhrloader/Makefile.am b/pcxhrloader/Makefile.am
index e6a0107..ab0b07d 100644
--- a/pcxhrloader/Makefile.am
+++ b/pcxhrloader/Makefile.am
@@ -3,7 +3,7 @@ AUTOMAKE_OPTIONS = 1.3 foreign
 
 MYNAME = pcxhrloader
 
-AM_CFLAGS = -DDATAPATH=\"$(datadir)/alsa/firmware/$(MYNAME)\"
+AM_CFLAGS = -DDATAPATH=\"/lib/firmware/$(MYNAME)\"
 
 bin_PROGRAMS = pcxhrloader
 
diff --git a/usx2yloader/Makefile.am b/usx2yloader/Makefile.am
index 4dd26a2..9ac7ba3 100644
--- a/usx2yloader/Makefile.am
+++ b/usx2yloader/Makefile.am
@@ -3,7 +3,7 @@ AUTOMAKE_OPTIONS = 1.3 foreign
 
 MYNAME = usx2yloader
 
-AM_CFLAGS = -DDATAPATH=\"$(datadir)/alsa/firmware/$(MYNAME)\"
+AM_CFLAGS = -DDATAPATH=\"/lib/firmware/$(MYNAME)\"
 
 bin_PROGRAMS = usx2yloader
 
diff --git a/vxloader/Makefile.am b/vxloader/Makefile.am
index 415d776..0316722 100644
--- a/vxloader/Makefile.am
+++ b/vxloader/Makefile.am
@@ -3,7 +3,7 @@ AUTOMAKE_OPTIONS = 1.3 foreign
 
 MYNAME = vxloader
 
-AM_CFLAGS = -DDATAPATH=\"$(datadir)/alsa/firmware/$(MYNAME)\"
+AM_CFLAGS = -DDATAPATH=\"/lib/firmware/$(MYNAME)\"
 
 bin_PROGRAMS = vxloader
 
-- 
1.7.10.4
