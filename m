From: gmane@colin.guthr.ie
Subject: [PATCH] conf: Allow for a directory to be given as a
	config file.
Date: Fri, 16 Sep 2011 10:04:26 +0100
Message-ID: <1316163866-32190-1-git-send-email-gmane@colin.guthr.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from summit.brent.tribalogic.net (brent.tribalogic.net
	[78.86.109.144]) by alsa0.perex.cz (Postfix) with ESMTP id 418FD24373
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Sep 2011 11:04:43 +0200 (CEST)
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

When this is done, *.conf files can be placed in that directory and they
will be processed by as if they were included directly.

A directory (typically /usr/share/alsa/alsa.conf.d/) has been
added into the distribution.

v2: Used existing conf syntax rather than processing via autotools
v3: Split file loading into separate function and made error handling
more consistent.

Signed-off-by: Colin Guthrie <colin@mageia.org>
---
 configure.in                     |    3 +-
 src/conf.c                       |   78 ++++++++++++++++++++++++++++++++-----
 src/conf/Makefile.am             |    2 +-
 src/conf/alsa.conf               |    7 +++
 src/conf/alsa.conf.d/Makefile.am |    8 ++++
 src/conf/alsa.conf.d/README      |    2 +
 6 files changed, 87 insertions(+), 13 deletions(-)
 create mode 100644 src/conf/alsa.conf.d/Makefile.am
 create mode 100644 src/conf/alsa.conf.d/README

diff --git a/configure.in b/configure.in
index 7ee0ccc..13e38b8 100644
--- a/configure.in
+++ b/configure.in
@@ -616,7 +616,8 @@ AC_OUTPUT(Makefile doc/Makefile doc/pictures/Makefile doc/doxygen.cfg \
 	  src/pcm/Makefile src/pcm/scopes/Makefile \
 	  src/rawmidi/Makefile src/timer/Makefile \
           src/hwdep/Makefile src/seq/Makefile src/ucm/Makefile \
-          src/compat/Makefile src/alisp/Makefile src/conf/Makefile \
+          src/compat/Makefile src/alisp/Makefile \
+	  src/conf/Makefile src/conf/alsa.conf.d/Makefile \
 	  src/conf/cards/Makefile \
 	  src/conf/pcm/Makefile \
 	  modules/Makefile modules/mixer/Makefile modules/mixer/simple/Makefile \
diff --git a/src/conf.c b/src/conf.c
index ddefff6..5b1b5a6 100644
--- a/src/conf.c
+++ b/src/conf.c
@@ -417,6 +417,7 @@ beginning:</P>
 #include <stdarg.h>
 #include <limits.h>
 #include <sys/stat.h>
+#include <dirent.h>
 #include <locale.h>
 #include "local.h"
 #ifdef HAVE_LIBPTHREAD
@@ -3373,6 +3374,42 @@ static int snd_config_hooks(snd_config_t *config, snd_config_t *private_data)
 	return err;
 }
 
+static int config_filename_filter(const struct dirent *dirent)
+{
+	size_t flen;
+
+	if (dirent == NULL)
+		return 0;
+	if (dirent->d_type == DT_DIR)
+		return 0;
+
+	flen = strlen(dirent->d_name);
+	if (flen <= 5)
+		return 0;
+
+	if (strncmp(&dirent->d_name[flen-5], ".conf", 5) == 0)
+		return 1;
+
+	return 0;
+}
+
+static int config_file_open(snd_config_t *root, const char *filename)
+{
+	snd_input_t *in;
+	int err;
+
+	err = snd_input_stdio_open(&in, filename, "r");
+	if (err >= 0) {
+		err = snd_config_load(root, in);
+		snd_input_close(in);
+		if (err < 0)
+			SNDERR("%s may be old or corrupted: consider to remove or fix it", filename);
+	} else
+		SNDERR("cannot access file %s", filename);
+
+	return err;
+}
+
 /**
  * \brief Loads and parses the given configurations files.
  * \param[in] root Handle to the root configuration node.
@@ -3457,20 +3494,39 @@ int snd_config_hook_load(snd_config_t *root, snd_config_t *config, snd_config_t
 		}
 	} while (hit);
 	for (idx = 0; idx < fi_count; idx++) {
-		snd_input_t *in;
+		struct stat st;
 		if (!errors && access(fi[idx].name, R_OK) < 0)
 			continue;
-		err = snd_input_stdio_open(&in, fi[idx].name, "r");
-		if (err >= 0) {
-			err = snd_config_load(root, in);
-			snd_input_close(in);
-			if (err < 0) {
-				SNDERR("%s may be old or corrupted: consider to remove or fix it", fi[idx].name);
-				goto _err;
-			}
-		} else {
-			SNDERR("cannot access file %s", fi[idx].name);
+		if (stat(fi[idx].name, &st) < 0) {
+			SNDERR("cannot stat file/directory %s", fi[idx].name);
+			continue;
 		}
+		if (S_ISDIR(st.st_mode)) {
+			struct dirent **namelist;
+			int n;
+
+			n = scandir(fi[idx].name, &namelist, config_filename_filter, versionsort);
+			if (n > 0) {
+				int j;
+				err = 0;
+				for (j = 0; j < n; ++j) {
+					if (err >= 0) {
+						int sl = strlen(fi[idx].name) + strlen(namelist[j]->d_name) + 2;
+						char *filename = malloc(sl);
+						snprintf(filename, sl, "%s/%s", fi[idx].name, namelist[j]->d_name);
+						filename[sl-1] = '\0';
+
+						err = config_file_open(root, filename);
+						free(filename);
+					}
+					free(namelist[j]);
+				}
+				free(namelist);
+				if (err < 0)
+					goto _err;
+			}
+		} else if (config_file_open(root, fi[idx].name) < 0)
+			goto _err;
 	}
 	*dst = NULL;
 	err = 0;
diff --git a/src/conf/Makefile.am b/src/conf/Makefile.am
index 2e5d0bf..456454f 100644
--- a/src/conf/Makefile.am
+++ b/src/conf/Makefile.am
@@ -1,4 +1,4 @@
-SUBDIRS=cards pcm
+SUBDIRS=cards pcm alsa.conf.d
 
 cfg_files = alsa.conf
 if BUILD_ALISP
diff --git a/src/conf/alsa.conf b/src/conf/alsa.conf
index a33c24e..bc91df3 100644
--- a/src/conf/alsa.conf
+++ b/src/conf/alsa.conf
@@ -8,6 +8,13 @@
 	{
 		func load
 		files [
+			{
+				@func concat
+				strings [
+					{ @func datadir }
+					"/alsa.conf.d/"
+				]
+			}
 			"/etc/asound.conf"
 			"~/.asoundrc"
 		]
diff --git a/src/conf/alsa.conf.d/Makefile.am b/src/conf/alsa.conf.d/Makefile.am
new file mode 100644
index 0000000..c91661e
--- /dev/null
+++ b/src/conf/alsa.conf.d/Makefile.am
@@ -0,0 +1,8 @@
+alsaconfigdir = @ALSA_CONFIG_DIR@
+alsadir = $(alsaconfigdir)/alsa.conf.d
+cfg_files = README
+
+alsa_DATA = $(cfg_files)
+
+EXTRA_DIST = \
+	$(cfg_files)
diff --git a/src/conf/alsa.conf.d/README b/src/conf/alsa.conf.d/README
new file mode 100644
index 0000000..9997884
--- /dev/null
+++ b/src/conf/alsa.conf.d/README
@@ -0,0 +1,2 @@
+You can place files named *.conf in this folder and they will be processed
+when initialising alsa-lib.
-- 
1.7.6
