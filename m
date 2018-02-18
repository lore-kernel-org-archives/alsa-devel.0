From: Lars Wendler <polynomial-c@gentoo.org>
Subject: [PATCH] Makefile.am: Add missing code for enhanced
	configure option of alsa plugins
Date: Sun, 18 Feb 2018 16:08:24 +0100
Message-ID: <20180218150824.22541-1-polynomial-c@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
 by alsa0.perex.cz (Postfix) with ESMTP id 92754266E78
 for <alsa-devel@alsa-project.org>; Sun, 18 Feb 2018 16:08:36 +0100 (CET)
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
Cc: Lars Wendler <polynomial-c@gentoo.org>
List-Id: alsa-devel@alsa-project.org

Commit 1201e158fb00bf15c353d088c94c1cb3eff9653c added the pieces for
configure but did not do the same for Makefile.
As result all plugins were still built regardless of corresponding
--disable-* option being called with configure.
---
 Makefile.am | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index 69cfe0d..76cefef 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -1,4 +1,4 @@
-SUBDIRS = oss mix usb_stream arcam-av doc
+SUBDIRS = doc
 if HAVE_JACK
 SUBDIRS += jack
 endif
@@ -20,6 +20,18 @@ endif
 if HAVE_SPEEXDSP
 SUBDIRS += speex
 endif
+if HAVE_OSS
+SUBDIRS += oss
+endif
+if HAVE_MIX
+SUBDIRS += mix
+endif
+if HAVE_USBSTREAM
+SUBDIRS += usb_stream
+endif
+if HAVE_ARCAMAV
+SUBDIRS += arcam-av
+endif
 
 EXTRA_DIST = gitcompile version COPYING.GPL m4/attributes.m4
 AUTOMAKE_OPTIONS = foreign
-- 
2.16.2
