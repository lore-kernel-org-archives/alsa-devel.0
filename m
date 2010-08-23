From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [PATCH 3/3] ucm: build - add build support for Use
	Case Manager
Date: Mon, 23 Aug 2010 17:17:19 +0100
Message-ID: <1282580239-10549-4-git-send-email-lrg@slimlogic.co.uk>
References: <1282580239-10549-1-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 1FA862441F
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Aug 2010 18:17:36 +0200 (CEST)
Received: by fxm11 with SMTP id 11so3091792fxm.38
	for <alsa-devel@alsa-project.org>; Mon, 23 Aug 2010 09:17:35 -0700 (PDT)
In-Reply-To: <1282580239-10549-1-git-send-email-lrg@slimlogic.co.uk>
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
Cc: Stefan Schmidt <stefan@slimlogic.co.uk>, Justin Xu <justinx@slimlogic.co.uk>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Add doxygen and make support for UCM.

CC: Mark Brown <broonie@opensource.wolfsonmicro.com>
Signed-off-by: Justin Xu <justinx@slimlogic.co.uk>
Signed-off-by: Stefan Schmidt <stefan@slimlogic.co.uk>
Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
---
 doc/doxygen.cfg.in  |    1 +
 include/Makefile.am |    2 +-
 src/Makefile.am     |    2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/doc/doxygen.cfg.in b/doc/doxygen.cfg.in
index 8606c48..3929772 100644
--- a/doc/doxygen.cfg.in
+++ b/doc/doxygen.cfg.in
@@ -28,6 +28,7 @@ INPUT            = @top_srcdir@/doc/index.doxygen \
 		   @top_srcdir@/include/pcm_ioplug.h \
 		   @top_srcdir@/include/control_external.h \
 		   @top_srcdir@/include/mixer.h \
+		   @top_srcdir@/include/use-case.h \
 		   @top_srcdir@/src/error.c \
 		   @top_srcdir@/src/dlmisc.c \
 		   @top_srcdir@/src/async.c \
diff --git a/include/Makefile.am b/include/Makefile.am
index a291503..de37f2c 100644
--- a/include/Makefile.am
+++ b/include/Makefile.am
@@ -5,7 +5,7 @@ alsaincludedir = ${includedir}/alsa
 
 alsainclude_HEADERS = asoundlib.h asoundef.h \
 		      version.h global.h input.h output.h error.h \
-		      conf.h control.h iatomic.h
+		      conf.h control.h iatomic.h use-case.h
 
 if BUILD_CTL_PLUGIN_EXT
 alsainclude_HEADERS += control_external.h
diff --git a/src/Makefile.am b/src/Makefile.am
index 3204fe4..7206dbd 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -14,7 +14,7 @@ SYMFUNCS =
 endif
 
 lib_LTLIBRARIES = libasound.la
-libasound_la_SOURCES = conf.c confmisc.c input.c output.c async.c error.c dlmisc.c socket.c shmarea.c userfile.c names.c
+libasound_la_SOURCES = conf.c confmisc.c input.c output.c async.c error.c dlmisc.c socket.c shmarea.c userfile.c names.c use-case.c
 
 SUBDIRS=control
 libasound_la_LIBADD = control/libcontrol.la
-- 
1.7.0.4
