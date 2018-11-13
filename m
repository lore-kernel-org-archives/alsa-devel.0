From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 02/35] axfer: add a sub-command to print list
	of PCMs/devices
Date: Tue, 13 Nov 2018 15:41:14 +0900
Message-ID: <20181113064147.13577-2-o-takashi@sakamocchi.jp>
References: <20181113062459.DD8F7267A5C@alsa0.perex.cz>
 <20181113064147.13577-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com
 [209.85.214.194])
 by alsa0.perex.cz (Postfix) with ESMTP id AF7492678F7
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2018 07:41:57 +0100 (CET)
Received: by mail-pl1-f194.google.com with SMTP id f12-v6so5528611plo.1
 for <alsa-devel@alsa-project.org>; Mon, 12 Nov 2018 22:41:57 -0800 (PST)
In-Reply-To: <20181113064147.13577-1-o-takashi@sakamocchi.jp>
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

Original aplay implementation has a feature to output two types of list;
devices and PCMs. The list of devices is a result to query sound card and
pcm component structured maintained in kernel land. The list of PCMs is a
result to parse runtime configuration files in alsa-lib. Entries in the
former list is corresponding to ALSA PCM character device
('/dev/snd/pcm%uC%uD[p|c]'), while entries in the latter list includes
some 'virtual' instances in application runtime.

This commit adds an implementation for the above functionality. This is
executed by taking 'list' sub-command. A 'device' option has the same
effect as '--list-devices' and '-L' of aplay. A 'pcm' option has the same
effect as '--list-pcms' and '-l' of aplay. In both cases, an additional
option is required for stream direction. Below is examples of new command
system for this sub-command.

$ axfer list device -C (= arecord --list-devices)
$ axfer list pcm -P    (= aplay -l)

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 axfer/Makefile.am   |   3 +-
 axfer/main.c        |   2 +-
 axfer/subcmd-list.c | 234 ++++++++++++++++++++++++++++++++++++++++++++
 axfer/subcmd.h      |   2 +
 4 files changed, 239 insertions(+), 2 deletions(-)
 create mode 100644 axfer/subcmd-list.c

diff --git a/axfer/Makefile.am b/axfer/Makefile.am
index b48b9c5..4e37b92 100644
--- a/axfer/Makefile.am
+++ b/axfer/Makefile.am
@@ -20,4 +20,5 @@ noinst_HEADERS = \
 axfer_SOURCES = \
 	misc.h \
 	subcmd.h \
-	main.c
+	main.c \
+	subcmd-list.c
diff --git a/axfer/main.c b/axfer/main.c
index 1e92941..c9cf104 100644
--- a/axfer/main.c
+++ b/axfer/main.c
@@ -181,7 +181,7 @@ int main(int argc, char *const *argv)
 	if (subcmd == SUBCMD_TRANSFER)
 		printf("execute 'transfer' subcmd.\n");
 	else if (subcmd == SUBCMD_LIST)
-		printf("execute 'list' subcmd.\n");
+		err = subcmd_list(argc, argv, direction);
 	else if (subcmd == SUBCMD_VERSION)
 		print_version(argv[0]);
 	else
diff --git a/axfer/subcmd-list.c b/axfer/subcmd-list.c
new file mode 100644
index 00000000..f4fd18b
--- /dev/null
+++ b/axfer/subcmd-list.c
@@ -0,0 +1,234 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// subcmd-list.c - operations for list sub command.
+//
+// Copyright (c) 2018 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+//
+// Licensed under the terms of the GNU General Public License, version 2.
+
+#include "subcmd.h"
+#include "misc.h"
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
+	printf("card %i: %s [%s], device %i: %s [%s]\n",
+	       snd_pcm_info_get_card(info), id, name,
+	       snd_pcm_info_get_device(info), snd_pcm_info_get_id(info),
+	       snd_pcm_info_get_name(info));
+
+	count = snd_pcm_info_get_subdevices_count(info);
+	printf("  Subdevices: %i/%i\n",
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
+		printf("  Subdevice #%i: %s\n",
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
+	// Not found.
+	if (snd_card_next(&card) < 0 || card < 0)
+		goto end;
+
+	printf("**** List of %s Hardware Devices ****\n",
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
+		// Go to next.
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
+	// Renewed command system.
+	if (argc > 2 && !strcmp(argv[1], "list")) {
+		for (i = 0; i < ARRAY_SIZE(ops); ++i) {
+			if (!strcmp(ops[i].category, argv[2]))
+				return ops[i].func(direction);
+		}
+	}
+
+	// Original command system.
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
+	return 0;
+}
diff --git a/axfer/subcmd.h b/axfer/subcmd.h
index 470a415..f78b766 100644
--- a/axfer/subcmd.h
+++ b/axfer/subcmd.h
@@ -11,4 +11,6 @@
 
 #include <alsa/asoundlib.h>
 
+int subcmd_list(int argc, char *const *argv, snd_pcm_stream_t direction);
+
 #endif
-- 
2.19.1
