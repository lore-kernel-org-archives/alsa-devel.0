From: gmane@colin.guthr.ie
Subject: [PATCH] pulse: Install a PulseAudio config snippet
	into alsa.conf.d
Date: Fri, 16 Sep 2011 10:35:17 +0100
Message-ID: <1316165717-9616-1-git-send-email-gmane@colin.guthr.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from summit.brent.tribalogic.net (brent.tribalogic.net
	[78.86.109.144])
	by alsa0.perex.cz (Postfix) with ESMTP id A3CA910385F
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Sep 2011 11:35:19 +0200 (CEST)
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
Cc: tiwai@suse.de, Colin Guthrie <colin@mageia.org>
List-Id: alsa-devel@alsa-project.org

From: Colin Guthrie <colin@mageia.org>

v2: Assing priorities to the config snippets.

Signed-off-by: Colin Guthrie <colin@mageia.org>
---
 configure.in                             |   19 ++++++++++++++++++-
 pulse/50-pulseaudio.conf                 |   13 +++++++++++++
 pulse/99-pulseaudio-default.conf.example |   13 +++++++++++++
 pulse/Makefile.am                        |    2 ++
 4 files changed, 46 insertions(+), 1 deletions(-)
 create mode 100644 pulse/50-pulseaudio.conf
 create mode 100644 pulse/99-pulseaudio-default.conf.example

diff --git a/configure.in b/configure.in
index ccf59ba..3839dd5 100644
--- a/configure.in
+++ b/configure.in
@@ -131,10 +131,10 @@ fi
 AM_CONDITIONAL(HAVE_PPH, test "$PPH" = "builtin" -o "$PPH" = "lib")
 AM_CONDITIONAL(USE_LIBSPEEX, test "$PPH" = "lib")
 
-dnl ALSA plugin directory
 test "x$prefix" = xNONE && prefix=$ac_default_prefix
 test "x$exec_prefix" = xNONE && exec_prefix=$prefix
 
+dnl ALSA plugin directory
 AC_ARG_WITH(plugindir,
     AS_HELP_STRING([--with-plugindir=dir],
 	[path where ALSA plugin files are stored]),
@@ -151,6 +151,23 @@ AC_DEFINE_UNQUOTED(ALSA_PLUGIN_DIR, "$plugindir", [directory containing ALSA add
 ALSA_PLUGIN_DIR="$plugindir"
 AC_SUBST(ALSA_PLUGIN_DIR)
 
+dnl ALSA data directory
+AC_ARG_WITH(alsadatadir,
+    AS_HELP_STRING([--with-alsadatadir=dir],
+	[path where ALSA data files are stored]),
+    alsadatadir="$withval", alsadatadir="")
+if test -z "$alsadatadir"; then
+    eval dir="$datadir"
+    case "$dir" in
+    /*) ;;
+    *) dir="$dir"
+    esac
+    alsadatadir="$dir/alsa"
+fi
+AC_DEFINE_UNQUOTED(ALSA_DATA_DIR, "$alsadatadir", [directory containing ALSA data files])
+ALSA_DATA_DIR="$alsadatadir"
+AC_SUBST(ALSA_DATA_DIR)
+
 SAVE_PLUGINS_VERSION
 
 AC_OUTPUT([
diff --git a/pulse/50-pulseaudio.conf b/pulse/50-pulseaudio.conf
new file mode 100644
index 0000000..dd85dab
--- /dev/null
+++ b/pulse/50-pulseaudio.conf
@@ -0,0 +1,13 @@
+# Add a specific named PulseAudio pcm and ctl (typically useful for testing)
+
+pcm.pulse {
+    type pulse
+    hint {
+        show on
+        description "PulseAudio Sound Server"
+    }
+}
+
+ctl.pulse {
+    type pulse
+}
diff --git a/pulse/99-pulseaudio-default.conf.example b/pulse/99-pulseaudio-default.conf.example
new file mode 100644
index 0000000..4f58858
--- /dev/null
+++ b/pulse/99-pulseaudio-default.conf.example
@@ -0,0 +1,13 @@
+# Default to PulseAudio
+
+pcm.!default {
+    type pulse
+    hint {
+        show on
+        description "Default ALSA Output (currently PulseAudio Sound Server)"
+    }
+}
+
+ctl.!default {
+    type pulse
+}
diff --git a/pulse/Makefile.am b/pulse/Makefile.am
index e89e8ee..e184c62 100644
--- a/pulse/Makefile.am
+++ b/pulse/Makefile.am
@@ -1,10 +1,12 @@
 asound_module_pcm_LTLIBRARIES = libasound_module_pcm_pulse.la
 asound_module_ctl_LTLIBRARIES = libasound_module_ctl_pulse.la
 asound_module_conf_LTLIBRARIES = libasound_module_conf_pulse.la
+asound_module_data_DATA = 50-pulseaudio.conf 99-pulseaudio-default.conf.example
 
 asound_module_pcmdir = @ALSA_PLUGIN_DIR@
 asound_module_ctldir = @ALSA_PLUGIN_DIR@
 asound_module_confdir = @ALSA_PLUGIN_DIR@
+asound_module_datadir = @ALSA_DATA_DIR@/alsa.conf.d
 
 AM_CFLAGS = -Wall -g @ALSA_CFLAGS@ $(PTHREAD_CFLAGS) $(pulseaudio_CFLAGS) -D_GNU_SOURCE
 AM_LDFLAGS = -module -avoid-version -export-dynamic -no-undefined $(LDFLAGS_NOUNDEFINED)
-- 
1.7.6
