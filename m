From: Andre Guedes <andre.guedes@intel.com>
Subject: [PATCH v2 - AAF PCM plugin 1/7] aaf: Introduce plugin
	skeleton
Date: Wed, 24 Oct 2018 18:11:10 -0700
Message-ID: <20181025011116.12360-2-andre.guedes@intel.com>
References: <20181025011116.12360-1-andre.guedes@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 2BEE6267967
 for <alsa-devel@alsa-project.org>; Thu, 25 Oct 2018 03:11:49 +0200 (CEST)
In-Reply-To: <20181025011116.12360-1-andre.guedes@intel.com>
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
Cc: tiwai@suse.de, pierre-louis.bossart@linux.intel.com, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

The patch introduces the skeleton code from the AAF plugin as well as
the buildsystem bits in order to get the plugin built. Following the
approach from other plugins, the AAF plugin is only built if its
dependency (libavtp) is detected by configure.

Follow-up patches implement support for both playback and capture modes.

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 Makefile.am     |  3 ++
 aaf/Makefile.am |  9 ++++++
 aaf/pcm_aaf.c   | 85 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 configure.ac    | 10 +++++++
 doc/aaf.txt     | 18 ++++++++++++
 5 files changed, 125 insertions(+)
 create mode 100644 aaf/Makefile.am
 create mode 100644 aaf/pcm_aaf.c
 create mode 100644 doc/aaf.txt

diff --git a/Makefile.am b/Makefile.am
index 27f61a4..af0e9c4 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -35,6 +35,9 @@ endif
 if HAVE_SPEEXDSP
 SUBDIRS += speex
 endif
+if HAVE_AAF
+SUBDIRS += aaf
+endif
 
 EXTRA_DIST = gitcompile version COPYING.GPL m4/attributes.m4
 AUTOMAKE_OPTIONS = foreign
diff --git a/aaf/Makefile.am b/aaf/Makefile.am
new file mode 100644
index 0000000..492b883
--- /dev/null
+++ b/aaf/Makefile.am
@@ -0,0 +1,9 @@
+asound_module_pcm_aaf_LTLIBRARIES = libasound_module_pcm_aaf.la
+
+asound_module_pcm_aafdir = @ALSA_PLUGIN_DIR@
+
+AM_CFLAGS = @ALSA_CFLAGS@ @AVTP_CFLAGS@
+AM_LDFLAGS = -module -avoid-version -export-dynamic -no-undefined $(LDFLAGS_NOUNDEFINED)
+
+libasound_module_pcm_aaf_la_SOURCES = pcm_aaf.c
+libasound_module_pcm_aaf_la_LIBADD = @ALSA_LIBS@ @AVTP_LIBS@
diff --git a/aaf/pcm_aaf.c b/aaf/pcm_aaf.c
new file mode 100644
index 0000000..31d8759
--- /dev/null
+++ b/aaf/pcm_aaf.c
@@ -0,0 +1,85 @@
+/*
+ * AVTP Audio Format (AAF) PCM Plugin
+ *
+ * Copyright (c) 2018, Intel Corporation
+ *
+ * This library is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU Lesser General Public License as
+ * published by the Free Software Foundation; either version 2.1 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include <alsa/asoundlib.h>
+#include <alsa/pcm_external.h>
+
+typedef struct {
+	snd_pcm_ioplug_t io;
+} snd_pcm_aaf_t;
+
+static int aaf_close(snd_pcm_ioplug_t *io)
+{
+	free(io->private_data);
+	return 0;
+}
+
+static snd_pcm_sframes_t aaf_pointer(snd_pcm_ioplug_t *io)
+{
+	return 0;
+}
+
+static int aaf_start(snd_pcm_ioplug_t *io)
+{
+	return 0;
+}
+
+static int aaf_stop(snd_pcm_ioplug_t *io)
+{
+	return 0;
+}
+
+static const snd_pcm_ioplug_callback_t aaf_callback = {
+	.close = aaf_close,
+	.pointer = aaf_pointer,
+	.start = aaf_start,
+	.stop = aaf_stop,
+};
+
+SND_PCM_PLUGIN_DEFINE_FUNC(aaf)
+{
+	snd_pcm_aaf_t *aaf;
+	int res;
+
+	aaf = calloc(1, sizeof(*aaf));
+	if (!aaf) {
+		SNDERR("Failed to allocate memory");
+		return -ENOMEM;
+	}
+
+	aaf->io.version = SND_PCM_IOPLUG_VERSION;
+	aaf->io.name = "AVTP Audio Format (AAF) Plugin";
+	aaf->io.callback = &aaf_callback;
+	aaf->io.private_data = aaf;
+	res = snd_pcm_ioplug_create(&aaf->io, name, stream, mode);
+	if (res < 0) {
+		SNDERR("Failed to create ioplug instance");
+		goto err;
+	}
+
+	*pcmp = aaf->io.pcm;
+	return 0;
+
+err:
+	free(aaf);
+	return res;
+}
+
+SND_PCM_PLUGIN_SYMBOL(aaf);
diff --git a/configure.ac b/configure.ac
index ecc4c7a..db36f03 100644
--- a/configure.ac
+++ b/configure.ac
@@ -176,6 +176,14 @@ fi
 test "x$prefix" = xNONE && prefix=$ac_default_prefix
 test "x$exec_prefix" = xNONE && exec_prefix=$prefix
 
+AC_ARG_ENABLE([aaf],
+      AS_HELP_STRING([--disable-aaf], [Disable building of AAF plugin]))
+
+if test "x$enable_aaf" != "xno"; then
+  PKG_CHECK_MODULES(AVTP, avtp >= 0.1, [HAVE_AAF=yes], [HAVE_AAF=no])
+fi
+AM_CONDITIONAL(HAVE_AAF, test x$HAVE_AAF = xyes)
+
 dnl ALSA plugin directory
 AC_ARG_WITH(plugindir,
     AS_HELP_STRING([--with-plugindir=dir],
@@ -251,6 +259,7 @@ AC_OUTPUT([
 	usb_stream/Makefile
 	speex/Makefile
 	arcam-av/Makefile
+	aaf/Makefile
 ])
 
 dnl Show the build conditions
@@ -289,3 +298,4 @@ if test "$HAVE_SPEEX" = "yes"; then
   echo "  speexdsp_CFLAGS: $speexdsp_CFLAGS"
   echo "  speexdsp_LIBS: $speexdsp_LIBS"
 fi
+echo "AAF plugin:         $HAVE_AAF"
diff --git a/doc/aaf.txt b/doc/aaf.txt
new file mode 100644
index 0000000..b260a26
--- /dev/null
+++ b/doc/aaf.txt
@@ -0,0 +1,18 @@
+AVTP Audio Format (AAF) Plugin
+==============================
+
+Overview
+--------
+
+The AAF plugin is a PCM plugin that uses Audio Video Transport Protocol (AVTP)
+to transmit/receive audio samples through a Time-Sensitive Network (TSN)
+capable network. The plugin enables media applications to easily implement AVTP
+Talker and Listener functionalities.
+
+Plugin Dependencies
+-------------------
+
+The AAF plugin uses libavtp to handle AVTP packetization. Libavtp source code
+can be found in https://github.com/AVnu/libavtp as well as instructions to
+build and install it. If libavtp isn't detected by configure, the plugin isn't
+built.
-- 
2.14.4
