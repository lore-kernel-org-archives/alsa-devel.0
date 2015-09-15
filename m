From: han.lu@intel.com
Subject: [PATCH BAT V1 7/7] BAT: Add Makefile and configures
Date: Tue, 15 Sep 2015 15:00:23 +0800
Message-ID: <e7f25b9f56056656354681ddedacadbb3425dcf9.1442298607.git.han.lu@intel.com>
References: <cover.1442298607.git.han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 2903826071A
 for <alsa-devel@alsa-project.org>; Tue, 15 Sep 2015 09:01:49 +0200 (CEST)
In-Reply-To: <cover.1442298607.git.han.lu@intel.com>
In-Reply-To: <cover.1442298607.git.han.lu@intel.com>
References: <cover.1442298607.git.han.lu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.com, liam.r.girdwood@intel.com, bernard.gautier@intel.com, alsa-devel@alsa-project.org
Cc: "Lu, Han" <han.lu@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Lu, Han" <han.lu@intel.com>

Add Makefile and configures that enable BAT on alsa-utils

Signed-off-by: Lu, Han <han.lu@intel.com>
Signed-off-by: Liam Girdwood <liam.r.girdwood@intel.com>
Signed-off-by: Bernard Gautier <bernard.gautier@intel.com>

diff --git a/Makefile.am b/Makefile.am
index 613f62d..3d24b87 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -18,6 +18,9 @@ SUBDIRS += aplay iecset speaker-test
 if ALSALOOP
 SUBDIRS += alsaloop
 endif
+if BAT
+SUBDIRS += bat
+endif
 endif
 if HAVE_SEQ
 SUBDIRS += seq
diff --git a/bat/Makefile.am b/bat/Makefile.am
new file mode 100644
index 0000000..0849d0d
--- /dev/null
+++ b/bat/Makefile.am
@@ -0,0 +1,14 @@
+bin_PROGRAMS = bat
+
+bat_SOURCES = \
+	bat.c \
+	common.c \
+	analyze.c \
+	signal.c \
+	convert.c \
+	alsa.c
+
+AM_CPPFLAGS = \
+	      -Wall -I$(top_srcdir)/include
+
+bat_LDADD = -lasound
diff --git a/configure.ac b/configure.ac
index 4c279a9..8c2d1a5 100644
--- a/configure.ac
+++ b/configure.ac
@@ -63,6 +63,23 @@ AM_CONDITIONAL(HAVE_UCM, test "$have_ucm" = "yes")
 AM_CONDITIONAL(HAVE_TOPOLOGY, test "$have_topology" = "yes")
 AM_CONDITIONAL(HAVE_SAMPLERATE, test "$have_samplerate" = "yes")
 
+AC_CHECK_LIB([fftw3], [fftw_malloc], , [AC_MSG_ERROR([Error: need FFTW3 library])])
+AC_CHECK_LIB([m], [sqrtf], , [AC_MSG_ERROR([Error: Need sqrtf])])
+AC_CHECK_LIB([pthread], [pthread_create], , [AC_MSG_ERROR([Error: need PTHREAD library])])
+
+dnl Disable bat
+bat=
+if test "$have_pcm" = "yes"; then
+AC_ARG_ENABLE(bat,
+     AS_HELP_STRING([--disable-bat], [Disable bat compilation]),
+     [case "${enableval}" in
+       yes) bat=true ;;
+       no)  bat=false ;;
+       *) AC_MSG_ERROR(bad value ${enableval} for --enable-bat) ;;
+     esac],[bat=true])
+fi
+AM_CONDITIONAL(BAT, test x$bat = xtrue)
+
 dnl Check for librt
 LIBRT=""
 AC_MSG_CHECKING(for librt)
@@ -361,7 +378,7 @@ AC_OUTPUT(Makefile alsactl/Makefile alsactl/init/Makefile \
 	  m4/Makefile po/Makefile.in \
 	  alsaconf/alsaconf alsaconf/Makefile \
 	  alsaconf/po/Makefile \
-	  alsaucm/Makefile topology/Makefile \
+	  alsaucm/Makefile topology/Makefile bat/Makefile \
 	  aplay/Makefile include/Makefile iecset/Makefile utils/Makefile \
 	  utils/alsa-utils.spec seq/Makefile seq/aconnect/Makefile \
 	  seq/aplaymidi/Makefile seq/aseqdump/Makefile seq/aseqnet/Makefile \
-- 
1.9.1
