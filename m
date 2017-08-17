From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH 17/23] aplay: add a sub-command to print
	list of PCMs/devices
Date: Thu, 17 Aug 2017 20:59:58 +0900
Message-ID: <20170817120004.15326-18-o-takashi@sakamocchi.jp>
References: <20170817120004.15326-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id F105C266EF9
 for <alsa-devel@alsa-project.org>; Thu, 17 Aug 2017 14:00:15 +0200 (CEST)
In-Reply-To: <20170817120004.15326-1-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

In current implementation of aplay, available PCM nodes and devices are
listed by options '--list-pcms' (-L) and '--list-devices' (-l).

This commit adds a file to handle the action. In future commit, this is
handled by 'list' sub-command.
---
 aplay/Makefile.am   |   7 +-
 aplay/main.h        |  32 ++++++++
 aplay/subcmd-list.c | 233 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 270 insertions(+), 2 deletions(-)
 create mode 100644 aplay/main.h
 create mode 100644 aplay/subcmd-list.c

diff --git a/aplay/Makefile.am b/aplay/Makefile.am
index c55fac7..0113b5c 100644
--- a/aplay/Makefile.am
+++ b/aplay/Makefile.am
@@ -12,7 +12,8 @@ noinst_HEADERS = \
 	waiter.h \
 	options.h \
 	xfer.h \
-	xfer-alsa.h
+	xfer-alsa.h \
+	main.h
 
 aplay_SOURCES = \
 	formats.h \
@@ -39,7 +40,9 @@ aplay_SOURCES = \
 	xfer-alsa-io-mmap.c \
 	xfer-alsa-io-rw.c \
 	xfer-alsa-sched-irq.c \
-	xfer-alsa-sched-timer.c
+	xfer-alsa-sched-timer.c \
+	main.h \
+	subcmd-list.c
 
 EXTRA_DIST = aplay.1 arecord.1
 EXTRA_CLEAN = arecord
diff --git a/aplay/main.h b/aplay/main.h
new file mode 100644
index 0000000..21f2269
--- /dev/null
+++ b/aplay/main.h
@@ -0,0 +1,32 @@
+/*
+ * main.h - a header for main routine of each sub-commands.
+ *
+ * Copyright (c) 2017 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#ifndef __ALSA_UTILS_APLAY_MAIN__H_
+#define __ALSA_UTILS_APLAY_MAIN__H_
+
+#include <stdbool.h>
+#include <gettext.h>
+
+#include <alsa/asoundlib.h>
+
+#ifndef ARRAY_SIZE
+#define ARRAY_SIZE(array)	(sizeof(array)/sizeof(array[0]))
+#endif
+
+enum subcmds {
+	SUBCMD_TRANSFER = 0,
+	SUBCMD_LIST,
+	SUBCMD_HELP,
+	SUBCMD_VERSION,
+};
+
+int subcmd_list(int argc, char *const *argv, snd_pcm_stream_t direction);
+
+int subcmd_transfer(int argc, char *const *argv, snd_pcm_stream_t direction);
+
+#endif
diff --git a/aplay/subcmd-list.c b/aplay/subcmd-list.c
new file mode 100644
index 0000000..28862e1
--- /dev/null
+++ b/aplay/subcmd-list.c
@@ -0,0 +1,233 @@
+/*
+ * subcmd-list.c - operations for list sub command.
+ *
+ * Copyright (c) 2017 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "main.h"
+
+#include <getopt.h>
+
+static int dump_device(snd_ctl_t *handle, const char *id, const char *name,
+		       snd_pcm_stream_t direction, snd_pcm_info_t *info)
+{
+	unsigned int count;
+	int i;
+	int err;
+
+	printf(_("card %i: %s [%s], device %i: %s [%s]\n"),
+	       snd_pcm_info_get_card(info), id, name,
+	       snd_pcm_info_get_device(info), snd_pcm_info_get_id(info),
+	       snd_pcm_info_get_name(info));
+
+	count = snd_pcm_info_get_subdevices_count(info);
+	printf(_("  Subdevices: %i/%i\n"),
+	       snd_pcm_info_get_subdevices_avail(info), count);
+
+	for (i = 0; i < count; ++i) {
+		snd_pcm_info_set_subdevice(info, i);
+
+		err = snd_ctl_pcm_info(handle, info);
+		if (err < 0) {
+			printf("control digital audio playback info (%i): %s",
+			       snd_pcm_info_get_card(info), snd_strerror(err));
+			continue;
+		}
+
+		printf(_("  Subdevice #%i: %s\n"),
+		       i, snd_pcm_info_get_subdevice_name(info));
+	}
+
+	return 0;
+}
+
+static int dump_devices(snd_ctl_t *handle, const char *id, const char *name,
+			snd_pcm_stream_t direction)
+{
+	snd_pcm_info_t *info;
+	int device = -1;
+	int err;
+
+	err = snd_pcm_info_malloc(&info);
+	if (err < 0)
+		return err;
+
+	while (1) {
+		err = snd_ctl_pcm_next_device(handle, &device);
+		if (err < 0)
+			break;
+		if (device < 0)
+			break;
+
+		snd_pcm_info_set_device(info, device);
+		snd_pcm_info_set_subdevice(info, 0);
+		snd_pcm_info_set_stream(info, direction);
+		err = snd_ctl_pcm_info(handle, info);
+		if (err < 0)
+			continue;
+
+		err = dump_device(handle, id, name, direction, info);
+		if (err < 0)
+			break;
+	}
+
+	free(info);
+	return err;
+}
+
+static int list_devices(snd_pcm_stream_t direction)
+{
+	int card = -1;
+	char name[32];
+	snd_ctl_t *handle;
+	snd_ctl_card_info_t *info;
+	int err;
+
+	err = snd_ctl_card_info_malloc(&info);
+	if (err < 0)
+		return err;
+
+	/* Not found. */
+	if (snd_card_next(&card) < 0 || card < 0)
+		goto end;
+
+	printf(_("**** List of %s Hardware Devices ****\n"),
+	       snd_pcm_stream_name(direction));
+
+	while (card >= 0) {
+		sprintf(name, "hw:%d", card);
+		err = snd_ctl_open(&handle, name, 0);
+		if (err < 0) {
+			printf("control open (%i): %s",
+			       card, snd_strerror(err));
+		} else {
+			err = snd_ctl_card_info(handle, info);
+			if (err < 0) {
+				printf("control hardware info (%i): %s",
+				       card, snd_strerror(err));
+			} else {
+				err = dump_devices(handle,
+					snd_ctl_card_info_get_id(info),
+					snd_ctl_card_info_get_name(info),
+					direction);
+			}
+			snd_ctl_close(handle);
+		}
+
+		if (err < 0)
+			break;
+
+		/* Go to next. */
+		if (snd_card_next(&card) < 0) {
+			printf("snd_card_next");
+			break;
+		}
+	}
+end:
+	free(info);
+	return err;
+}
+
+static int list_pcms(snd_pcm_stream_t direction)
+{
+	static const char *const filters[] = {
+		[SND_PCM_STREAM_CAPTURE]	= "Input",
+		[SND_PCM_STREAM_PLAYBACK]	= "Output",
+	};
+	const char *filter;
+	void **hints;
+	void **n;
+	char *io;
+	char *name;
+	char *desc;
+
+	if (snd_device_name_hint(-1, "pcm", &hints) < 0)
+		return -EINVAL;
+
+	filter = filters[direction];
+
+	n = hints;
+	for (n = hints; *n != NULL; ++n) {
+		io = snd_device_name_get_hint(*n, "IOID");
+		if (io != NULL && strcmp(io, filter) != 0) {
+			free(io);
+			continue;
+		}
+
+		name = snd_device_name_get_hint(*n, "NAME");
+		desc = snd_device_name_get_hint(*n, "DESC");
+
+		printf("%s\n", name);
+		if (desc == NULL) {
+			free(name);
+			free(desc);
+			continue;
+		}
+
+
+		printf("    ");
+		while (*desc) {
+			if (*desc == '\n')
+				printf("\n    ");
+			else
+				putchar(*desc);
+			desc++;
+		}
+		putchar('\n');
+	}
+
+	snd_device_name_free_hint(hints);
+
+	return 0;
+}
+
+static void print_help(void)
+{
+	printf("help for list sub-command.\n");
+}
+
+int subcmd_list(int argc, char *const *argv, snd_pcm_stream_t direction)
+{
+	static const struct {
+		const char *const category;
+		int (*func)(snd_pcm_stream_t direction);
+	} ops[] = {
+		{"device",	list_devices},
+		{"pcm",		list_pcms},
+	};
+	int i;
+	static const char *s_opts = "hlL";
+	static const struct option l_opts[] = {
+		{"list-devices",	0, NULL, 'l'},
+		{"list-pcms",		0, NULL, 'L'},
+		{NULL,			0, NULL, 0}
+	};
+	int c;
+
+	/* Renewed command system. */
+	if (argc > 2 && !strcmp(argv[1], "list")) {
+		for (i = 0; i < ARRAY_SIZE(ops); ++i) {
+			if (!strcmp(ops[i].category, argv[2]))
+				return ops[i].func(direction);
+		}
+	}
+
+	/* Original command system. */
+	optind = 0;
+	opterr = 0;
+	while (1) {
+		c = getopt_long(argc, argv, s_opts, l_opts, NULL);
+		if (c < 0)
+			break;
+		if (c == 'l')
+			return list_devices(direction);
+		if (c == 'L')
+			return list_pcms(direction);
+	}
+
+	print_help();
+
+	return 1;
+}
-- 
2.11.0
