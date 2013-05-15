From: Jordi Mallach <jordi@debian.org>
Subject: [PATCH 2/3] Check for and include libavutil.h to avoid
	unresolved symbols.
Date: Wed, 15 May 2013 19:11:47 +0200
Message-ID: <1368637908-29042-3-git-send-email-jordi@debian.org>
References: <1368637908-29042-1-git-send-email-jordi@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tempesta.oskuro.net (tempesta.oskuro.net [92.243.30.96])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B44E2616DD
 for <alsa-devel@alsa-project.org>; Wed, 15 May 2013 19:12:07 +0200 (CEST)
Received: from penyagolosa.oskuro.net (169.219.14.37.dynamic.jazztel.es
 [37.14.219.169])
 by tempesta.oskuro.net (Postfix) with ESMTPSA id 94B5462838
 for <alsa-devel@alsa-project.org>; Wed, 15 May 2013 19:12:06 +0200 (CEST)
In-Reply-To: <1368637908-29042-1-git-send-email-jordi@debian.org>
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

The a52 plugin uses av_free(), but does not check for libavutil
availability. Patch configure.in to check for the module, and include
libavutil.h.

Signed-off-by: Jordi Mallach <jordi@debian.org>
---
 a52/pcm_a52.c |    1 +
 configure.in  |    2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/a52/pcm_a52.c b/a52/pcm_a52.c
index c40aadc..75c68bd 100644
--- a/a52/pcm_a52.c
+++ b/a52/pcm_a52.c
@@ -26,6 +26,7 @@
 #include <alsa/pcm_external.h>
 #include <alsa/pcm_plugin.h>
 #include AVCODEC_HEADER
+#include <libavutil/avutil.h>
 
 #if LIBAVCODEC_VERSION_MAJOR >= 53 && LIBAVCODEC_VERSION_MINOR >= 34
 #include <libavutil/audioconvert.h>
diff --git a/configure.in b/configure.in
index 6f345f5..bf8676b 100644
--- a/configure.in
+++ b/configure.in
@@ -67,7 +67,7 @@ AC_ARG_ENABLE([avcodec],
       AS_HELP_STRING([--disable-avcodec], [Don't build plugins depending on avcodec (a52)]))
 
 if test "x$enable_avcodec" != "xno"; then
-  PKG_CHECK_MODULES(AVCODEC, [libavcodec], [HAVE_AVCODEC=yes], [HAVE_AVCODEC=no])
+  PKG_CHECK_MODULES(AVCODEC, [libavcodec libavutil], [HAVE_AVCODEC=yes], [HAVE_AVCODEC=no])
 fi
 
 if test "x$HAVE_AVCODEC" = "xno"; then
-- 
1.7.10.4
