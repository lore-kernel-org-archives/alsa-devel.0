From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 01/35] axfer: add an entry point for this
	command
Date: Tue, 13 Nov 2018 15:41:13 +0900
Message-ID: <20181113064147.13577-1-o-takashi@sakamocchi.jp>
References: <20181113062459.DD8F7267A5C@alsa0.perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
 [209.85.210.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 98DF6267839
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2018 07:41:56 +0100 (CET)
Received: by mail-pf1-f193.google.com with SMTP id c72so861564pfc.6
 for <alsa-devel@alsa-project.org>; Mon, 12 Nov 2018 22:41:56 -0800 (PST)
In-Reply-To: <20181113062459.DD8F7267A5C@alsa0.perex.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This commit adds a new command, 'axfer' ('ALSA transfer'), to transfer data
frames described in asound.h. This command is intended to replace current
aplay. The most of features and command line parameters come from aplay as
much as possible, while it has more better feature and code to maintain.

This commit adds an entry point for this command. Current option system of
aplay is still available, while this command has a sub-command system like
commands in iproute2.

Currently, two sub-commands are supported; 'list' and 'transfer'. The
'list' sub-command has the same effect as '-l' and '-L' options of aplay.
The 'transfer' sub-command has the same effect as the main feature of
aplay. For the sub-command system, an option for stream direction is
required; '-P' for playback and '-C' for capture. If you create symbolic
links to this binary for aplay/arecord, please execute:
$ ln -s axfer aplay
$ ln -s axfer arecord

Actual code for each sub-command will be implemented in later commits.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 Makefile.am       |   2 +-
 axfer/Makefile.am |  23 ++++++
 axfer/main.c      | 193 ++++++++++++++++++++++++++++++++++++++++++++++
 axfer/misc.h      |  16 ++++
 axfer/subcmd.h    |  14 ++++
 configure.ac      |   2 +-
 6 files changed, 248 insertions(+), 2 deletions(-)
 create mode 100644 axfer/Makefile.am
 create mode 100644 axfer/main.c
 create mode 100644 axfer/misc.h
 create mode 100644 axfer/subcmd.h

diff --git a/Makefile.am b/Makefile.am
index 3d24b87..a4e25ae 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -14,7 +14,7 @@ if ALSACONF
 SUBDIRS += alsaconf
 endif
 if HAVE_PCM
-SUBDIRS += aplay iecset speaker-test
+SUBDIRS += aplay iecset speaker-test axfer
 if ALSALOOP
 SUBDIRS += alsaloop
 endif
diff --git a/axfer/Makefile.am b/axfer/Makefile.am
new file mode 100644
index 00000000..b48b9c5
--- /dev/null
+++ b/axfer/Makefile.am
@@ -0,0 +1,23 @@
+bin_PROGRAMS = \
+	axfer
+
+# To include headers for gettext and version.
+AM_CPPFLAGS = \
+	-I$(top_srcdir)/include
+
+# Unit tests.
+SUBDIRS =
+
+LIBRT = @LIBRT@
+LDADD = \
+	$(LIBINTL) \
+	$(LIBRT)
+
+noinst_HEADERS = \
+	misc.h \
+	subcmd.h
+
+axfer_SOURCES = \
+	misc.h \
+	subcmd.h \
+	main.c
diff --git a/axfer/main.c b/axfer/main.c
new file mode 100644
index 00000000..1e92941
--- /dev/null
+++ b/axfer/main.c
@@ -0,0 +1,193 @@
+// SPDX-License-Identifier: GPL-2.0
+// main.c - an entry point for this program.
+//
+// Copyright (c) 2018 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+//
+// Originally written as 'aplay', by Michael Beck and Jaroslav Kysela.
+//
+// Licensed under the terms of the GNU General Public License, version 2.
+
+#include "subcmd.h"
+#include "misc.h"
+
+#include "version.h"
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <string.h>
+
+enum subcmds {
+	SUBCMD_TRANSFER = 0,
+	SUBCMD_LIST,
+	SUBCMD_HELP,
+	SUBCMD_VERSION,
+};
+
+static void print_version(const char *const cmdname)
+{
+	printf("%s: version %s\n", cmdname, SND_UTIL_VERSION_STR);
+}
+
+static void print_help(void)
+{
+	printf("help\n");
+}
+
+static void decide_subcmd(int argc, char *const *argv, enum subcmds *subcmd)
+{
+	static const char *const subcmds[] = {
+		[SUBCMD_TRANSFER] = "transfer",
+		[SUBCMD_LIST] = "list",
+		[SUBCMD_HELP] = "help",
+		[SUBCMD_VERSION] = "version",
+	};
+	static const struct {
+		const char *const name;
+		enum subcmds subcmd;
+	} long_opts[] = {
+		{"--list-devices",	SUBCMD_LIST},
+		{"--list-pcms",		SUBCMD_LIST},
+		{"--help",  		SUBCMD_HELP},
+		{"--version",  		SUBCMD_VERSION},
+	};
+	static const struct {
+		unsigned char c;
+		enum subcmds subcmd;
+	} short_opts[] = {
+		{'l', SUBCMD_LIST},
+		{'L', SUBCMD_LIST},
+		{'h', SUBCMD_HELP},
+	};
+	char *pos;
+	int i, j;
+
+	if (argc == 1) {
+		*subcmd = SUBCMD_HELP;
+		return;
+	}
+
+	// sub-command system.
+	for (i = 0; i < ARRAY_SIZE(subcmds); ++i) {
+		if (!strcmp(argv[1], subcmds[i])) {
+			*subcmd = i;
+			return;
+		}
+	}
+
+	// Original command system. For long options.
+	for (i = 0; i < ARRAY_SIZE(long_opts); ++i) {
+		for (j = 0; j < argc; ++j) {
+			if (!strcmp(long_opts[i].name, argv[j])) {
+				*subcmd = long_opts[i].subcmd;
+				return;
+			}
+		}
+	}
+
+	// Original command system. For short options.
+	for (i = 1; i < argc; ++i) {
+		// Pick up short options only.
+		if (argv[i][0] != '-' || argv[i][0] == '\0' ||
+		    argv[i][1] == '-' || argv[i][1] == '\0')
+			continue;
+		for (pos = argv[i]; *pos != '\0'; ++pos) {
+			for (j = 0; j < ARRAY_SIZE(short_opts); ++j) {
+				if (*pos == short_opts[j].c) {
+					*subcmd = short_opts[j].subcmd;
+					return;
+				}
+			}
+		}
+	}
+
+	*subcmd = SUBCMD_TRANSFER;
+}
+
+static bool decide_direction(int argc, char *const *argv,
+			     snd_pcm_stream_t *direction)
+{
+	static const struct {
+		const char *const name;
+		snd_pcm_stream_t direction;
+	} long_opts[] = {
+		{"--capture",	SND_PCM_STREAM_CAPTURE},
+		{"--playback",	SND_PCM_STREAM_PLAYBACK},
+	};
+	static const struct {
+		unsigned char c;
+		snd_pcm_stream_t direction;
+	} short_opts[] = {
+		{'C',		SND_PCM_STREAM_CAPTURE},
+		{'P',		SND_PCM_STREAM_PLAYBACK},
+	};
+	static const char *const aliases[] = {
+		[SND_PCM_STREAM_CAPTURE] = "arecord",
+		[SND_PCM_STREAM_PLAYBACK] = "aplay",
+	};
+	int i, j;
+	char *pos;
+
+	// Original command system. For long options.
+	for (i = 0; i < ARRAY_SIZE(long_opts); ++i) {
+		for (j = 0; j < argc; ++j) {
+			if (!strcmp(long_opts[i].name, argv[j])) {
+				*direction = long_opts[i].direction;
+				return true;
+			}
+		}
+	}
+
+	// Original command system. For short options.
+	for (i = 1; i < argc; ++i) {
+		// Pick up short options only.
+		if (argv[i][0] != '-' || argv[i][0] == '\0' ||
+		    argv[i][1] == '-' || argv[i][1] == '\0')
+			continue;
+		for (pos = argv[i]; *pos != '\0'; ++pos) {
+			for (j = 0; j < ARRAY_SIZE(short_opts); ++j) {
+				if (*pos == short_opts[j].c) {
+					*direction = short_opts[j].direction;
+					return true;
+				}
+			}
+		}
+	}
+
+	// If not decided yet, judge according to command name.
+	for (i = 0; i < ARRAY_SIZE(aliases); ++i) {
+		for (pos = argv[0] + strlen(argv[0]); pos != argv[0]; --pos) {
+			if (strstr(pos, aliases[i]) != NULL) {
+				*direction = i;
+				return true;
+			}
+		}
+	}
+
+	return false;
+}
+
+int main(int argc, char *const *argv)
+{
+	snd_pcm_stream_t direction;
+	enum subcmds subcmd;
+	int err = 0;
+
+	if (!decide_direction(argc, argv, &direction))
+		subcmd = SUBCMD_HELP;
+	else
+		decide_subcmd(argc, argv, &subcmd);
+
+	if (subcmd == SUBCMD_TRANSFER)
+		printf("execute 'transfer' subcmd.\n");
+	else if (subcmd == SUBCMD_LIST)
+		printf("execute 'list' subcmd.\n");
+	else if (subcmd == SUBCMD_VERSION)
+		print_version(argv[0]);
+	else
+		print_help();
+	if (err < 0)
+		return EXIT_FAILURE;
+
+	return EXIT_SUCCESS;
+}
diff --git a/axfer/misc.h b/axfer/misc.h
new file mode 100644
index 00000000..7c8bfb3
--- /dev/null
+++ b/axfer/misc.h
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// misc.h - a header file for miscellaneous tools.
+//
+// Copyright (c) 2018 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+//
+// Licensed under the terms of the GNU General Public License, version 2.
+
+#ifndef __ALSA_UTILS_AXFER_MISC__H_
+#define __ALSA_UTILS_AXFER_MISC__H_
+
+#include <gettext.h>
+
+#define ARRAY_SIZE(array)	(sizeof(array)/sizeof(array[0]))
+
+#endif
diff --git a/axfer/subcmd.h b/axfer/subcmd.h
new file mode 100644
index 00000000..470a415
--- /dev/null
+++ b/axfer/subcmd.h
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// subcmd.h - a header for each sub-commands.
+//
+// Copyright (c) 2018 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+//
+// Licensed under the terms of the GNU General Public License, version 2.
+
+#ifndef __ALSA_UTILS_AXFER_SUBCMD__H_
+#define __ALSA_UTILS_AXFER_SUBCMD__H_
+
+#include <alsa/asoundlib.h>
+
+#endif
diff --git a/configure.ac b/configure.ac
index c37b8a5..404fa16 100644
--- a/configure.ac
+++ b/configure.ac
@@ -430,4 +430,4 @@ AC_OUTPUT(Makefile alsactl/Makefile alsactl/init/Makefile \
 	  utils/alsa-utils.spec seq/Makefile seq/aconnect/Makefile \
 	  seq/aplaymidi/Makefile seq/aseqdump/Makefile seq/aseqnet/Makefile \
 	  speaker-test/Makefile speaker-test/samples/Makefile \
-	  alsaloop/Makefile alsa-info/Makefile)
+	  alsaloop/Makefile alsa-info/Makefile axfer/Makefile)
-- 
2.19.1
