From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH v3 11/13] topology: autotools: Add build
	support for topology core
Date: Wed, 29 Jul 2015 17:45:23 +0100
Message-ID: <1438188325-11553-12-git-send-email-liam.r.girdwood@linux.intel.com>
References: <1438188325-11553-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 3520D2659EA
 for <alsa-devel@alsa-project.org>; Wed, 29 Jul 2015 18:45:59 +0200 (CEST)
In-Reply-To: <1438188325-11553-1-git-send-email-liam.r.girdwood@linux.intel.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 configure.ac             | 11 ++++++++++-
 include/Makefile.am      |  4 ++++
 src/Makefile.am          |  7 +++++++
 src/topology/Makefile.am | 19 +++++++++++++++++++
 4 files changed, 40 insertions(+), 1 deletion(-)
 create mode 100644 src/topology/Makefile.am

diff --git a/configure.ac b/configure.ac
index 9621d4e..a482b3e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -380,6 +380,9 @@ AC_ARG_ENABLE(seq,
 AC_ARG_ENABLE(ucm,
   AS_HELP_STRING([--disable-ucm], [disable the use-case-manager component]),
   [build_ucm="$enableval"], [build_ucm="yes"])
+AC_ARG_ENABLE(topology,
+  AS_HELP_STRING([--disable-topology], [disable the DSP topology component]),
+  [build_topology="$enableval"], [build_topology="yes"])
 AC_ARG_ENABLE(alisp,
   AS_HELP_STRING([--disable-alisp], [disable the alisp component]),
   [build_alisp="$enableval"], [build_alisp="yes"])
@@ -422,6 +425,7 @@ AM_CONDITIONAL([BUILD_RAWMIDI], [test x$build_rawmidi = xyes])
 AM_CONDITIONAL([BUILD_HWDEP], [test x$build_hwdep = xyes])
 AM_CONDITIONAL([BUILD_SEQ], [test x$build_seq = xyes])
 AM_CONDITIONAL([BUILD_UCM], [test x$build_ucm = xyes])
+AM_CONDITIONAL([BUILD_TOPOLOGY], [test x$build_topology = xyes])
 AM_CONDITIONAL([BUILD_ALISP], [test x$build_alisp = xyes])
 AM_CONDITIONAL([BUILD_PYTHON], [test x$build_python = xyes])
 
@@ -443,6 +447,9 @@ fi
 if test "$build_ucm" = "yes"; then
   AC_DEFINE([BUILD_UCM], "1", [Build UCM component])
 fi
+if test "$build_topology" = "yes"; then
+  AC_DEFINE([BUILD_TOPOLOGY], "1", [Build DSP Topology component])
+fi
 
 dnl PCM Plugins
 
@@ -643,7 +650,7 @@ AC_OUTPUT(Makefile doc/Makefile doc/pictures/Makefile doc/doxygen.cfg \
 	  src/pcm/Makefile src/pcm/scopes/Makefile \
 	  src/rawmidi/Makefile src/timer/Makefile \
           src/hwdep/Makefile src/seq/Makefile src/ucm/Makefile \
-          src/alisp/Makefile \
+          src/alisp/Makefile src/topology/Makefile \
 	  src/conf/Makefile src/conf/alsa.conf.d/Makefile \
 	  src/conf/cards/Makefile \
 	  src/conf/pcm/Makefile \
@@ -656,6 +663,8 @@ AC_OUTPUT(Makefile doc/Makefile doc/pictures/Makefile doc/doxygen.cfg \
 	  src/conf/ucm/PAZ00/Makefile \
 	  src/conf/ucm/GoogleNyan/Makefile \
 	  src/conf/ucm/broadwell-rt286/Makefile \
+	  src/conf/topology/Makefile \
+	  src/conf/topology/broadwell/Makefile \
 	  modules/Makefile modules/mixer/Makefile modules/mixer/simple/Makefile \
 	  alsalisp/Makefile aserver/Makefile \
 	  test/Makefile test/lsb/Makefile \
diff --git a/include/Makefile.am b/include/Makefile.am
index 4baa03a..ff931fd 100644
--- a/include/Makefile.am
+++ b/include/Makefile.am
@@ -50,6 +50,10 @@ if BUILD_UCM
 alsainclude_HEADERS += use-case.h
 endif
 
+if BUILD_TOPOLOGY
+alsainclude_HEADERS += topology.h
+endif
+
 if BUILD_ALISP
 alsainclude_HEADERS += alisp.h
 endif
diff --git a/src/Makefile.am b/src/Makefile.am
index fa255ff..57686a6 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -42,6 +42,10 @@ if BUILD_UCM
 SUBDIRS += ucm
 libasound_la_LIBADD += ucm/libucm.la
 endif
+if BUILD_TOPOLOGY
+SUBDIRS += topology
+libasound_la_LIBADD += topology/libtopology.la
+endif
 if BUILD_ALISP
 SUBDIRS += alisp
 libasound_la_LIBADD += alisp/libalisp.la
@@ -81,6 +85,9 @@ seq/libseq.la:
 ucm/libucm.la:
 	$(MAKE) -C ucm libucm.la
 
+topology/libtopology.la:
+	$(MAKE) -C topology libtopology.la
+
 instr/libinstr.la:
 	$(MAKE) -C instr libinstr.la
 
diff --git a/src/topology/Makefile.am b/src/topology/Makefile.am
new file mode 100644
index 0000000..3fb8bf7
--- /dev/null
+++ b/src/topology/Makefile.am
@@ -0,0 +1,19 @@
+EXTRA_LTLIBRARIES = libtopology.la
+
+libtopology_la_SOURCES =\
+	parser.c \
+	builder.c \
+	ctl.c \
+	dapm.c \
+	pcm.c \
+	data.c \
+	text.c \
+	channel.c \
+	ops.c \
+	elem.c
+
+noinst_HEADERS = tplg_local.h
+
+all: libtopology.la
+
+AM_CPPFLAGS=-I$(top_srcdir)/include
-- 
2.1.4
