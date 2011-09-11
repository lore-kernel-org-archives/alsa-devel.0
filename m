From: gmane@colin.guthr.ie
Subject: [PATCH] conf: Allow for a directory to be given as a
	config file.
Date: Sun, 11 Sep 2011 13:40:38 +0100
Message-ID: <1315744838-21911-2-git-send-email-gmane@colin.guthr.ie>
References: <1315744838-21911-1-git-send-email-gmane@colin.guthr.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from summit.brent.tribalogic.net (brent.tribalogic.net
	[78.86.109.144])
	by alsa0.perex.cz (Postfix) with ESMTP id B245B103820
	for <alsa-devel@alsa-project.org>;
	Sun, 11 Sep 2011 14:41:02 +0200 (CEST)
In-Reply-To: <1315744838-21911-1-git-send-email-gmane@colin.guthr.ie>
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
Cc: Colin Guthrie <colin@mageia.org>
List-Id: alsa-devel@alsa-project.org

From: Colin Guthrie <colin@mageia.org>

When this is done, *.conf files can be placed in that directory and they
will be processed by as if they were included directly.

A directory (typically /usr/share/alsa/alsa.conf.d/) has been
added into the distribution.
---
 configure.in                     |    4 +-
 src/conf.c                       |   75 ++++-
 src/conf/Makefile.am             |    2 +-
 src/conf/alsa.conf               |  611 -------------------------------------
 src/conf/alsa.conf.d/Makefile.am |    8 +
 src/conf/alsa.conf.d/README      |    3 +
 src/conf/alsa.conf.in            |  612 ++++++++++++++++++++++++++++++++++++++
 7 files changed, 694 insertions(+), 621 deletions(-)
 delete mode 100644 src/conf/alsa.conf
 create mode 100644 src/conf/alsa.conf.d/Makefile.am
 create mode 100644 src/conf/alsa.conf.d/README
 create mode 100644 src/conf/alsa.conf.in

diff --git a/configure.in b/configure.in
index 7ee0ccc..ead0e6f 100644
--- a/configure.in
+++ b/configure.in
@@ -610,13 +610,15 @@ if test ! -L "$srcdir"/include/alsa ; then
   ln -sf . "$srcdir"/include/alsa
 fi
 
+AC_CONFIG_FILES([src/conf/alsa.conf:src/conf/alsa.conf.in])
 AC_OUTPUT(Makefile doc/Makefile doc/pictures/Makefile doc/doxygen.cfg \
 	  include/Makefile include/sound/Makefile src/Versions src/Makefile \
           src/control/Makefile src/mixer/Makefile \
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
index ddefff6..9b1169b 100644
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
@@ -3373,6 +3374,25 @@ static int snd_config_hooks(snd_config_t *config, snd_config_t *private_data)
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
 /**
  * \brief Loads and parses the given configurations files.
  * \param[in] root Handle to the root configuration node.
@@ -3458,18 +3478,57 @@ int snd_config_hook_load(snd_config_t *root, snd_config_t *config, snd_config_t
 	} while (hit);
 	for (idx = 0; idx < fi_count; idx++) {
 		snd_input_t *in;
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
+		if (stat(fi[idx].name, &st) < 0) {
+			SNDERR("cannot stat file/directory %s", fi[idx].name);
+			continue;
+		}
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
+						err = snd_input_stdio_open(&in, filename, "r");
+						if (err >= 0) {
+							err = snd_config_load(root, in);
+							snd_input_close(in);
+							if (err < 0)
+								SNDERR("%s may be old or corrupted: consider to remove or fix it", filename);
+						} else {
+							SNDERR("cannot access file %s", filename);
+						}
+						free(filename);
+					}
+					free(namelist[j]);
+				}
+				free(namelist);
+				if (err < 0)
+					goto _err;
 			}
 		} else {
-			SNDERR("cannot access file %s", fi[idx].name);
+			err = snd_input_stdio_open(&in, fi[idx].name, "r");
+			if (err >= 0) {
+				err = snd_config_load(root, in);
+				snd_input_close(in);
+				if (err < 0) {
+					SNDERR("%s may be old or corrupted: consider to remove or fix it", fi[idx].name);
+					goto _err;
+				}
+			} else {
+				SNDERR("cannot access file %s", fi[idx].name);
+			}
 		}
 	}
 	*dst = NULL;
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
deleted file mode 100644
index a33c24e..0000000
--- a/src/conf/alsa.conf
+++ /dev/null
@@ -1,611 +0,0 @@
-#
-#  ALSA library configuration file
-#
-
-# pre-load the configuration files
-
-@hooks [
-	{
-		func load
-		files [
-			"/etc/asound.conf"
-			"~/.asoundrc"
-		]
-		errors false
-	}
-]
-
-# load card-specific configuration files (on request)
-
-cards.@hooks [
-	{
-		func load
-		files [
-			{
-				@func concat
-				strings [
-					{ @func datadir }
-					"/cards/aliases.conf"
-				]
-			}
-		]
-	}
-	{
-		func load_for_all_cards
-		files [
-			{
-				@func concat
-				strings [
-					{ @func datadir }
-					"/cards/"
-					{ @func private_string }
-					".conf"
-				]
-			}
-		]
-		errors false
-	}
-]
-
-#
-# defaults
-#
-
-# show all name hints also for definitions without hint {} section
-defaults.namehint.showall off
-# show just basic name hints
-defaults.namehint.basic on
-# show extended name hints
-defaults.namehint.extended off
-#
-defaults.ctl.card 0
-defaults.pcm.card 0
-defaults.pcm.device 0
-defaults.pcm.subdevice -1
-defaults.pcm.nonblock 1
-defaults.pcm.compat 0
-defaults.pcm.minperiodtime 5000		# in us
-defaults.pcm.ipc_key 5678293
-defaults.pcm.ipc_gid audio
-defaults.pcm.ipc_perm 0660
-defaults.pcm.dmix.max_periods 0
-defaults.pcm.dmix.rate 48000
-defaults.pcm.dmix.format "unchanged"
-defaults.pcm.dmix.card defaults.pcm.card
-defaults.pcm.dmix.device defaults.pcm.device
-defaults.pcm.dsnoop.card defaults.pcm.card
-defaults.pcm.dsnoop.device defaults.pcm.device
-defaults.pcm.front.card defaults.pcm.card
-defaults.pcm.front.device defaults.pcm.device
-defaults.pcm.rear.card defaults.pcm.card
-defaults.pcm.rear.device defaults.pcm.device
-defaults.pcm.center_lfe.card defaults.pcm.card
-defaults.pcm.center_lfe.device defaults.pcm.device
-defaults.pcm.side.card defaults.pcm.card
-defaults.pcm.side.device defaults.pcm.device
-defaults.pcm.surround40.card defaults.pcm.card
-defaults.pcm.surround40.device defaults.pcm.device
-defaults.pcm.surround41.card defaults.pcm.card
-defaults.pcm.surround41.device defaults.pcm.device
-defaults.pcm.surround50.card defaults.pcm.card
-defaults.pcm.surround50.device defaults.pcm.device
-defaults.pcm.surround51.card defaults.pcm.card
-defaults.pcm.surround51.device defaults.pcm.device
-defaults.pcm.surround71.card defaults.pcm.card
-defaults.pcm.surround71.device defaults.pcm.device
-defaults.pcm.iec958.card defaults.pcm.card
-defaults.pcm.iec958.device defaults.pcm.device
-defaults.pcm.modem.card defaults.pcm.card
-defaults.pcm.modem.device defaults.pcm.device
-# truncate files via file or tee PCM
-defaults.pcm.file_format	"raw"
-defaults.pcm.file_truncate	true
-defaults.rawmidi.card 0
-defaults.rawmidi.device 0
-defaults.rawmidi.subdevice -1
-defaults.hwdep.card 0
-defaults.hwdep.device 0
-defaults.timer.class 2
-defaults.timer.sclass 0
-defaults.timer.card 0
-defaults.timer.device 0
-defaults.timer.subdevice 0
-
-#
-#  PCM interface
-#
-
-# redirect to load-on-demand extended pcm definitions
-pcm.cards cards.pcm
-
-pcm.default cards.pcm.default
-pcm.sysdefault cards.pcm.default
-pcm.front cards.pcm.front
-pcm.rear cards.pcm.rear
-pcm.center_lfe cards.pcm.center_lfe
-pcm.side cards.pcm.side
-pcm.surround40 cards.pcm.surround40
-pcm.surround41 cards.pcm.surround41
-pcm.surround50 cards.pcm.surround50
-pcm.surround51 cards.pcm.surround51
-pcm.surround71 cards.pcm.surround71
-pcm.iec958 cards.pcm.iec958
-pcm.spdif iec958
-pcm.hdmi cards.pcm.hdmi
-pcm.dmix cards.pcm.dmix
-pcm.dsnoop cards.pcm.dsnoop
-pcm.modem cards.pcm.modem
-pcm.phoneline cards.pcm.phoneline
-
-pcm.hw {
-	@args [ CARD DEV SUBDEV ]
-	@args.CARD {
-		type string
-		default {
-			@func getenv
-			vars [
-				ALSA_PCM_CARD
-				ALSA_CARD
-			]
-			default {
-				@func refer
-				name defaults.pcm.card
-			}
-		}
-	}
-	@args.DEV {
-		type integer
-		default {
-			@func igetenv
-			vars [
-				ALSA_PCM_DEVICE
-			]
-			default {
-				@func refer
-				name defaults.pcm.device
-			}
-		}
-	}
-	@args.SUBDEV {
-		type integer
-		default {
-			@func refer
-			name defaults.pcm.subdevice
-		}
-	}		
-	type hw
-	card $CARD
-	device $DEV
-	subdevice $SUBDEV
-	hint {
-		show {
-			@func refer
-			name defaults.namehint.extended
-		}
-		description "Direct hardware device without any conversions"
-	}
-}
-
-pcm.plughw {
-	@args [ CARD DEV SUBDEV ]
-	@args.CARD {
-		type string
-		default {
-			@func getenv
-			vars [
-				ALSA_PCM_CARD
-				ALSA_CARD
-			]
-			default {
-				@func refer
-				name defaults.pcm.card
-			}
-		}
-	}
-	@args.DEV {
-		type integer
-		default {
-			@func igetenv
-			vars [
-				ALSA_PCM_DEVICE
-			]
-			default {
-				@func refer
-				name defaults.pcm.device
-			}
-		}
-	}
-	@args.SUBDEV {
-		type integer
-		default {
-			@func refer
-			name defaults.pcm.subdevice
-		}
-	}		
-	type plug
-	slave.pcm {
-		type hw
-		card $CARD
-		device $DEV
-		subdevice $SUBDEV
-	}
-	hint {
-		show {
-			@func refer
-			name defaults.namehint.extended
-		}
-		description "Hardware device with all software conversions"
-	}
-}
-
-pcm.plug {
-	@args [ SLAVE ]
-	@args.SLAVE {
-		type string
-	}
-	type plug
-	slave.pcm $SLAVE
-}
-
-pcm.shm {
-	@args [ SOCKET PCM ]
-	@args.SOCKET {
-		type string
-	}
-	@args.PCM {
-		type string
-	}
-	type shm
-	server $SOCKET
-	pcm $PCM
-}
-
-pcm.tee {
-	@args [ SLAVE FILE FORMAT ]
-	@args.SLAVE {
-		type string
-	}
-	@args.FILE {
-		type string
-	}
-	@args.FORMAT {
-		type string
-		default {
-			@func refer
-			name defaults.pcm.file_format
-		}
-	}
-	type file
-	slave.pcm $SLAVE
-	file $FILE
-	format $FORMAT
-	truncate {
-		@func refer
-		name defaults.pcm.file_truncate
-	}
-}
-
-pcm.file {
-	@args [ FILE FORMAT ]
-	@args.FILE {
-		type string
-	}
-	@args.FORMAT {
-		type string
-		default {
-			@func refer
-			name defaults.pcm.file_format
-		}
-	}
-	type file
-	slave.pcm null
-	file $FILE
-	format $FORMAT
-	truncate {
-		@func refer
-		name defaults.pcm.file_truncate
-	}
-}
-
-pcm.null {
-	type null
-	hint {
-		show {
-			@func refer
-			name defaults.namehint.basic
-		}
-		description "Discard all samples (playback) or generate zero samples (capture)"
-	}
-}
-
-#
-#  Control interface
-#
-	
-ctl.sysdefault {
-	type hw
-	card {
-		@func getenv
-		vars [
-			ALSA_CTL_CARD
-			ALSA_CARD
-		]
-		default {
-			@func refer
-			name defaults.ctl.card
-		}
-	}
-}
-ctl.default ctl.sysdefault
-
-ctl.hw {
-	@args [ CARD ]
-	@args.CARD {
-		type string
-		default {
-			@func getenv
-			vars [
-				ALSA_CTL_CARD
-				ALSA_CARD
-			]
-			default {
-				@func refer
-				name defaults.ctl.card
-			}
-		}
-	}
-	type hw
-	card $CARD
-}
-
-ctl.shm {
-	@args [ SOCKET CTL ]
-	@args.SOCKET {
-		type string
-	}
-	@args.CTL {
-		type string
-	}
-	type shm
-	server $SOCKET
-	ctl $CTL
-}
-
-#
-#  RawMidi interface
-#
-
-rawmidi.default {
-	type hw
-	card {
-		@func getenv
-		vars [
-			ALSA_RAWMIDI_CARD
-			ALSA_CARD
-		]
-		default {
-			@func refer
-			name defaults.rawmidi.card
-		}
-	}
-	device {
-		@func igetenv
-		vars [
-			ALSA_RAWMIDI_DEVICE
-		]
-		default {
-			@func refer
-			name defaults.rawmidi.device
-		}
-	}
-}
-
-rawmidi.hw {
-	@args [ CARD DEV SUBDEV ]
-	@args.CARD {
-		type string
-		default {
-			@func getenv
-			vars [
-				ALSA_RAWMIDI_CARD
-				ALSA_CARD
-			]
-			default {
-				@func refer
-				name defaults.rawmidi.card
-			}
-		}
-	}
-	@args.DEV {
-		type integer
-		default {
-			@func igetenv
-			vars [
-				ALSA_RAWMIDI_DEVICE
-			]
-			default {
-				@func refer
-				name defaults.rawmidi.device
-			}
-		}
-	}
-	@args.SUBDEV {
-		type integer
-		default -1
-	}
-	type hw
-	card $CARD
-	device $DEV
-	subdevice $SUBDEV
-	hint {
-		description "Direct rawmidi driver device"
-		device $DEV
-	}
-}
-
-rawmidi.virtual {
-	@args [ MERGE ]
-	@args.MERGE {
-		type string
-		default 1
-	}
-	type virtual
-	merge $MERGE
-}
-
-#
-#  Sequencer interface
-#
-
-seq.default {
-	type hw
-}
-
-seq.hw {
-	type hw
-}
-
-#
-#  HwDep interface
-#
-
-hwdep.default {
-	type hw
-	card {
-		@func getenv
-		vars [
-			ALSA_HWDEP_CARD
-			ALSA_CARD
-		]
-		default {
-			@func refer
-			name defaults.hwdep.card
-		}
-	}
-	device {
-		@func igetenv
-		vars [
-			ALSA_HWDEP_DEVICE
-		]
-		default {
-			@func refer
-			name defaults.hwdep.device
-		}
-	}
-}
-
-hwdep.hw {
-	@args [ CARD DEV ]
-	@args.CARD {
-		type string
-		default {
-			@func getenv
-			vars [
-				ALSA_HWDEP_CARD
-				ALSA_CARD
-			]
-			default {
-				@func refer
-				name defaults.hwdep.card
-			}
-		}
-	}
-	@args.DEV {
-		type integer
-		default {
-			@func igetenv
-			vars [
-				ALSA_HWDEP_DEVICE
-			]
-			default {
-				@func refer
-				name defaults.hwdep.device
-			}
-		}
-	}
-	type hw
-	card $CARD
-	device $DEV
-}
-
-#
-#  Timer interface
-#
-
-timer_query.default {
-	type hw
-}
-
-timer_query.hw {
-	type hw
-}
-
-timer.default {
-	type hw
-	class {
-		@func refer
-		name defaults.timer.class
-	}
-	sclass {
-		@func refer
-		name defaults.timer.sclass
-	}
-	card {
-		@func refer
-		name defaults.timer.card
-	}
-	device {
-		@func refer
-		name defaults.timer.device
-	}
-	subdevice {
-		@func refer
-		name defaults.timer.subdevice
-	}
-	hint.description "Default direct hardware timer device"
-}
-
-timer.hw {
-	@args [ CLASS SCLASS CARD DEV SUBDEV ]
-	@args.CLASS {
-		type integer
-		default {
-			@func refer
-			name defaults.timer.class
-		}
-	}
-	@args.SCLASS {
-		type integer
-		default {
-			@func refer
-			name defaults.timer.sclass
-		}
-	}
-	@args.CARD {
-		type string
-		default {
-			@func refer
-			name defaults.timer.card
-		}
-	}
-	@args.DEV {
-		type integer
-		default {
-			@func refer
-			name defaults.timer.device
-		}
-	}
-	@args.SUBDEV {
-		type integer
-		default {
-			@func refer
-			name defaults.timer.subdevice
-		}
-	}
-	type hw
-	class $CLASS
-	sclass $SCLASS
-	card $CARD
-	device $DEV
-	subdevice $SUBDEV
-}
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
index 0000000..04b3fdb
--- /dev/null
+++ b/src/conf/alsa.conf.d/README
@@ -0,0 +1,3 @@
+You can place files named *.conf in this folder and they will be processed
+when initialising alsa-lib
+
diff --git a/src/conf/alsa.conf.in b/src/conf/alsa.conf.in
new file mode 100644
index 0000000..de68bc3
--- /dev/null
+++ b/src/conf/alsa.conf.in
@@ -0,0 +1,612 @@
+#
+#  ALSA library configuration file
+#
+
+# pre-load the configuration files
+
+@hooks [
+	{
+		func load
+		files [
+			"@ALSA_CONFIG_DIR@/alsa.conf.d/"
+			"/etc/asound.conf"
+			"~/.asoundrc"
+		]
+		errors false
+	}
+]
+
+# load card-specific configuration files (on request)
+
+cards.@hooks [
+	{
+		func load
+		files [
+			{
+				@func concat
+				strings [
+					{ @func datadir }
+					"/cards/aliases.conf"
+				]
+			}
+		]
+	}
+	{
+		func load_for_all_cards
+		files [
+			{
+				@func concat
+				strings [
+					{ @func datadir }
+					"/cards/"
+					{ @func private_string }
+					".conf"
+				]
+			}
+		]
+		errors false
+	}
+]
+
+#
+# defaults
+#
+
+# show all name hints also for definitions without hint {} section
+defaults.namehint.showall off
+# show just basic name hints
+defaults.namehint.basic on
+# show extended name hints
+defaults.namehint.extended off
+#
+defaults.ctl.card 0
+defaults.pcm.card 0
+defaults.pcm.device 0
+defaults.pcm.subdevice -1
+defaults.pcm.nonblock 1
+defaults.pcm.compat 0
+defaults.pcm.minperiodtime 5000		# in us
+defaults.pcm.ipc_key 5678293
+defaults.pcm.ipc_gid audio
+defaults.pcm.ipc_perm 0660
+defaults.pcm.dmix.max_periods 0
+defaults.pcm.dmix.rate 48000
+defaults.pcm.dmix.format "unchanged"
+defaults.pcm.dmix.card defaults.pcm.card
+defaults.pcm.dmix.device defaults.pcm.device
+defaults.pcm.dsnoop.card defaults.pcm.card
+defaults.pcm.dsnoop.device defaults.pcm.device
+defaults.pcm.front.card defaults.pcm.card
+defaults.pcm.front.device defaults.pcm.device
+defaults.pcm.rear.card defaults.pcm.card
+defaults.pcm.rear.device defaults.pcm.device
+defaults.pcm.center_lfe.card defaults.pcm.card
+defaults.pcm.center_lfe.device defaults.pcm.device
+defaults.pcm.side.card defaults.pcm.card
+defaults.pcm.side.device defaults.pcm.device
+defaults.pcm.surround40.card defaults.pcm.card
+defaults.pcm.surround40.device defaults.pcm.device
+defaults.pcm.surround41.card defaults.pcm.card
+defaults.pcm.surround41.device defaults.pcm.device
+defaults.pcm.surround50.card defaults.pcm.card
+defaults.pcm.surround50.device defaults.pcm.device
+defaults.pcm.surround51.card defaults.pcm.card
+defaults.pcm.surround51.device defaults.pcm.device
+defaults.pcm.surround71.card defaults.pcm.card
+defaults.pcm.surround71.device defaults.pcm.device
+defaults.pcm.iec958.card defaults.pcm.card
+defaults.pcm.iec958.device defaults.pcm.device
+defaults.pcm.modem.card defaults.pcm.card
+defaults.pcm.modem.device defaults.pcm.device
+# truncate files via file or tee PCM
+defaults.pcm.file_format	"raw"
+defaults.pcm.file_truncate	true
+defaults.rawmidi.card 0
+defaults.rawmidi.device 0
+defaults.rawmidi.subdevice -1
+defaults.hwdep.card 0
+defaults.hwdep.device 0
+defaults.timer.class 2
+defaults.timer.sclass 0
+defaults.timer.card 0
+defaults.timer.device 0
+defaults.timer.subdevice 0
+
+#
+#  PCM interface
+#
+
+# redirect to load-on-demand extended pcm definitions
+pcm.cards cards.pcm
+
+pcm.default cards.pcm.default
+pcm.sysdefault cards.pcm.default
+pcm.front cards.pcm.front
+pcm.rear cards.pcm.rear
+pcm.center_lfe cards.pcm.center_lfe
+pcm.side cards.pcm.side
+pcm.surround40 cards.pcm.surround40
+pcm.surround41 cards.pcm.surround41
+pcm.surround50 cards.pcm.surround50
+pcm.surround51 cards.pcm.surround51
+pcm.surround71 cards.pcm.surround71
+pcm.iec958 cards.pcm.iec958
+pcm.spdif iec958
+pcm.hdmi cards.pcm.hdmi
+pcm.dmix cards.pcm.dmix
+pcm.dsnoop cards.pcm.dsnoop
+pcm.modem cards.pcm.modem
+pcm.phoneline cards.pcm.phoneline
+
+pcm.hw {
+	@args [ CARD DEV SUBDEV ]
+	@args.CARD {
+		type string
+		default {
+			@func getenv
+			vars [
+				ALSA_PCM_CARD
+				ALSA_CARD
+			]
+			default {
+				@func refer
+				name defaults.pcm.card
+			}
+		}
+	}
+	@args.DEV {
+		type integer
+		default {
+			@func igetenv
+			vars [
+				ALSA_PCM_DEVICE
+			]
+			default {
+				@func refer
+				name defaults.pcm.device
+			}
+		}
+	}
+	@args.SUBDEV {
+		type integer
+		default {
+			@func refer
+			name defaults.pcm.subdevice
+		}
+	}		
+	type hw
+	card $CARD
+	device $DEV
+	subdevice $SUBDEV
+	hint {
+		show {
+			@func refer
+			name defaults.namehint.extended
+		}
+		description "Direct hardware device without any conversions"
+	}
+}
+
+pcm.plughw {
+	@args [ CARD DEV SUBDEV ]
+	@args.CARD {
+		type string
+		default {
+			@func getenv
+			vars [
+				ALSA_PCM_CARD
+				ALSA_CARD
+			]
+			default {
+				@func refer
+				name defaults.pcm.card
+			}
+		}
+	}
+	@args.DEV {
+		type integer
+		default {
+			@func igetenv
+			vars [
+				ALSA_PCM_DEVICE
+			]
+			default {
+				@func refer
+				name defaults.pcm.device
+			}
+		}
+	}
+	@args.SUBDEV {
+		type integer
+		default {
+			@func refer
+			name defaults.pcm.subdevice
+		}
+	}		
+	type plug
+	slave.pcm {
+		type hw
+		card $CARD
+		device $DEV
+		subdevice $SUBDEV
+	}
+	hint {
+		show {
+			@func refer
+			name defaults.namehint.extended
+		}
+		description "Hardware device with all software conversions"
+	}
+}
+
+pcm.plug {
+	@args [ SLAVE ]
+	@args.SLAVE {
+		type string
+	}
+	type plug
+	slave.pcm $SLAVE
+}
+
+pcm.shm {
+	@args [ SOCKET PCM ]
+	@args.SOCKET {
+		type string
+	}
+	@args.PCM {
+		type string
+	}
+	type shm
+	server $SOCKET
+	pcm $PCM
+}
+
+pcm.tee {
+	@args [ SLAVE FILE FORMAT ]
+	@args.SLAVE {
+		type string
+	}
+	@args.FILE {
+		type string
+	}
+	@args.FORMAT {
+		type string
+		default {
+			@func refer
+			name defaults.pcm.file_format
+		}
+	}
+	type file
+	slave.pcm $SLAVE
+	file $FILE
+	format $FORMAT
+	truncate {
+		@func refer
+		name defaults.pcm.file_truncate
+	}
+}
+
+pcm.file {
+	@args [ FILE FORMAT ]
+	@args.FILE {
+		type string
+	}
+	@args.FORMAT {
+		type string
+		default {
+			@func refer
+			name defaults.pcm.file_format
+		}
+	}
+	type file
+	slave.pcm null
+	file $FILE
+	format $FORMAT
+	truncate {
+		@func refer
+		name defaults.pcm.file_truncate
+	}
+}
+
+pcm.null {
+	type null
+	hint {
+		show {
+			@func refer
+			name defaults.namehint.basic
+		}
+		description "Discard all samples (playback) or generate zero samples (capture)"
+	}
+}
+
+#
+#  Control interface
+#
+	
+ctl.sysdefault {
+	type hw
+	card {
+		@func getenv
+		vars [
+			ALSA_CTL_CARD
+			ALSA_CARD
+		]
+		default {
+			@func refer
+			name defaults.ctl.card
+		}
+	}
+}
+ctl.default ctl.sysdefault
+
+ctl.hw {
+	@args [ CARD ]
+	@args.CARD {
+		type string
+		default {
+			@func getenv
+			vars [
+				ALSA_CTL_CARD
+				ALSA_CARD
+			]
+			default {
+				@func refer
+				name defaults.ctl.card
+			}
+		}
+	}
+	type hw
+	card $CARD
+}
+
+ctl.shm {
+	@args [ SOCKET CTL ]
+	@args.SOCKET {
+		type string
+	}
+	@args.CTL {
+		type string
+	}
+	type shm
+	server $SOCKET
+	ctl $CTL
+}
+
+#
+#  RawMidi interface
+#
+
+rawmidi.default {
+	type hw
+	card {
+		@func getenv
+		vars [
+			ALSA_RAWMIDI_CARD
+			ALSA_CARD
+		]
+		default {
+			@func refer
+			name defaults.rawmidi.card
+		}
+	}
+	device {
+		@func igetenv
+		vars [
+			ALSA_RAWMIDI_DEVICE
+		]
+		default {
+			@func refer
+			name defaults.rawmidi.device
+		}
+	}
+}
+
+rawmidi.hw {
+	@args [ CARD DEV SUBDEV ]
+	@args.CARD {
+		type string
+		default {
+			@func getenv
+			vars [
+				ALSA_RAWMIDI_CARD
+				ALSA_CARD
+			]
+			default {
+				@func refer
+				name defaults.rawmidi.card
+			}
+		}
+	}
+	@args.DEV {
+		type integer
+		default {
+			@func igetenv
+			vars [
+				ALSA_RAWMIDI_DEVICE
+			]
+			default {
+				@func refer
+				name defaults.rawmidi.device
+			}
+		}
+	}
+	@args.SUBDEV {
+		type integer
+		default -1
+	}
+	type hw
+	card $CARD
+	device $DEV
+	subdevice $SUBDEV
+	hint {
+		description "Direct rawmidi driver device"
+		device $DEV
+	}
+}
+
+rawmidi.virtual {
+	@args [ MERGE ]
+	@args.MERGE {
+		type string
+		default 1
+	}
+	type virtual
+	merge $MERGE
+}
+
+#
+#  Sequencer interface
+#
+
+seq.default {
+	type hw
+}
+
+seq.hw {
+	type hw
+}
+
+#
+#  HwDep interface
+#
+
+hwdep.default {
+	type hw
+	card {
+		@func getenv
+		vars [
+			ALSA_HWDEP_CARD
+			ALSA_CARD
+		]
+		default {
+			@func refer
+			name defaults.hwdep.card
+		}
+	}
+	device {
+		@func igetenv
+		vars [
+			ALSA_HWDEP_DEVICE
+		]
+		default {
+			@func refer
+			name defaults.hwdep.device
+		}
+	}
+}
+
+hwdep.hw {
+	@args [ CARD DEV ]
+	@args.CARD {
+		type string
+		default {
+			@func getenv
+			vars [
+				ALSA_HWDEP_CARD
+				ALSA_CARD
+			]
+			default {
+				@func refer
+				name defaults.hwdep.card
+			}
+		}
+	}
+	@args.DEV {
+		type integer
+		default {
+			@func igetenv
+			vars [
+				ALSA_HWDEP_DEVICE
+			]
+			default {
+				@func refer
+				name defaults.hwdep.device
+			}
+		}
+	}
+	type hw
+	card $CARD
+	device $DEV
+}
+
+#
+#  Timer interface
+#
+
+timer_query.default {
+	type hw
+}
+
+timer_query.hw {
+	type hw
+}
+
+timer.default {
+	type hw
+	class {
+		@func refer
+		name defaults.timer.class
+	}
+	sclass {
+		@func refer
+		name defaults.timer.sclass
+	}
+	card {
+		@func refer
+		name defaults.timer.card
+	}
+	device {
+		@func refer
+		name defaults.timer.device
+	}
+	subdevice {
+		@func refer
+		name defaults.timer.subdevice
+	}
+	hint.description "Default direct hardware timer device"
+}
+
+timer.hw {
+	@args [ CLASS SCLASS CARD DEV SUBDEV ]
+	@args.CLASS {
+		type integer
+		default {
+			@func refer
+			name defaults.timer.class
+		}
+	}
+	@args.SCLASS {
+		type integer
+		default {
+			@func refer
+			name defaults.timer.sclass
+		}
+	}
+	@args.CARD {
+		type string
+		default {
+			@func refer
+			name defaults.timer.card
+		}
+	}
+	@args.DEV {
+		type integer
+		default {
+			@func refer
+			name defaults.timer.device
+		}
+	}
+	@args.SUBDEV {
+		type integer
+		default {
+			@func refer
+			name defaults.timer.subdevice
+		}
+	}
+	type hw
+	class $CLASS
+	sclass $SCLASS
+	card $CARD
+	device $DEV
+	subdevice $SUBDEV
+}
-- 
1.7.6
