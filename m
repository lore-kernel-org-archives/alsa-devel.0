From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] alsa-tools: Add a small "hdajacksensetest"
	helper
Date: Mon,  6 Oct 2014 11:30:52 +0200
Message-ID: <1412587852-14203-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 78D5A260493
 for <alsa-devel@alsa-project.org>; Mon,  6 Oct 2014 11:30:54 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

I previously had a small python script doing the same thing,
but it depended on hda-analyzer, which always breaks when something
new is added to the codec proc file.

I got tired and rewrote it as a small C program instead, which I
hope will be a useful addition to alsa-tools.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 Makefile                            |   2 +-
 hdajacksensetest/Makefile.am        |  12 +++
 hdajacksensetest/configure.ac       |  10 +++
 hdajacksensetest/gitcompile         |  13 ++++
 hdajacksensetest/hdajacksensetest.c | 145 ++++++++++++++++++++++++++++++++++++
 5 files changed, 181 insertions(+), 1 deletion(-)
 create mode 100644 hdajacksensetest/Makefile.am
 create mode 100644 hdajacksensetest/configure.ac
 create mode 100755 hdajacksensetest/gitcompile
 create mode 100644 hdajacksensetest/hdajacksensetest.c

diff --git a/Makefile b/Makefile
index b2da046..72f95e2 100644
--- a/Makefile
+++ b/Makefile
@@ -3,7 +3,7 @@ TOP = .
 SUBDIRS = as10k1 envy24control hdsploader hdspconf hdspmixer \
 	  mixartloader pcxhrloader rmedigicontrol sb16_csp seq sscape_ctl \
 	  us428control usx2yloader vxloader echomixer ld10k1 qlo10k1 \
-	  hwmixvolume hdajackretask hda-verb
+	  hwmixvolume hdajackretask hda-verb hdajacksensetest
 
 all:
 	@for i in $(SUBDIRS); do \
diff --git a/hdajacksensetest/Makefile.am b/hdajacksensetest/Makefile.am
new file mode 100644
index 0000000..795373c
--- /dev/null
+++ b/hdajacksensetest/Makefile.am
@@ -0,0 +1,12 @@
+MYNAME = hdajacksensetest
+AUTOMAKE_OPTIONS = foreign
+bin_PROGRAMS = hdajacksensetest
+AM_CFLAGS = @GLIB_CFLAGS@ -I "../hdajackretask/" -I "../hda-verb/"
+hdajacksensetest_SOURCES = hdajacksensetest.c ../hdajackretask/sysfs-pin-configs.c
+hdajacksensetest_LDADD = @GLIB_LIBS@
+
+alsa-dist: distdir
+	@rm -rf ../distdir/$(MYNAME)
+	@mkdir -p ../distdir/$(MYNAME)
+	@cp -RLpv $(distdir)/* ../distdir/$(MYNAME)
+	@rm -rf $(distdir)
diff --git a/hdajacksensetest/configure.ac b/hdajacksensetest/configure.ac
new file mode 100644
index 0000000..cc1eb84
--- /dev/null
+++ b/hdajacksensetest/configure.ac
@@ -0,0 +1,10 @@
+AC_INIT(hda-verb, 0.4)
+AM_INIT_AUTOMAKE(subdir-objects)
+AM_MAINTAINER_MODE([enable])
+AC_PROG_CC
+AC_PROG_INSTALL
+AC_HEADER_STDC
+
+PKG_CHECK_MODULES([GLIB], [glib-2.0])
+
+AC_OUTPUT(Makefile)
diff --git a/hdajacksensetest/gitcompile b/hdajacksensetest/gitcompile
new file mode 100755
index 0000000..58328bd
--- /dev/null
+++ b/hdajacksensetest/gitcompile
@@ -0,0 +1,13 @@
+#!/bin/bash
+
+aclocal $ACLOCAL_FLAGS || exit 1
+automake --foreign --add-missing || exit 1
+autoconf || exit 1
+export CFLAGS='-O2 -Wall -pipe -g'
+echo "CFLAGS=$CFLAGS"
+echo "./configure $@"
+./configure $@ || exit 1
+unset CFLAGS
+if [ -z "$GITCOMPILE_NO_MAKE" ]; then
+  make || exit 1
+fi
diff --git a/hdajacksensetest/hdajacksensetest.c b/hdajacksensetest/hdajacksensetest.c
new file mode 100644
index 0000000..0db1d54
--- /dev/null
+++ b/hdajacksensetest/hdajacksensetest.c
@@ -0,0 +1,145 @@
+/*
+ * Checks the current pin/jack status of the codec
+ *
+ * Copyright (c) 2014 David Henningsson, Canonical Ltd. <david.henningsson@canonical.com>
+ * (With some minor pieces copy-pasted from hda-verb by Takashi Iwai)
+ *
+ * Licensed under GPL v2 or later.
+ */
+
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <glib.h>
+#include <errno.h>
+#include "sysfs-pin-configs.h"
+
+#include <sys/ioctl.h>
+#include <stdint.h>
+typedef uint8_t u8;
+typedef uint16_t u16;
+typedef uint32_t u32;
+typedef uint64_t u64;
+#include "hda_hwdep.h"
+
+gint card_index, codec_index;
+gboolean try_all_pins, set_pin_sense;
+
+static GOptionEntry arg_entries[] =
+{
+  { "card", 'c', 0, G_OPTION_ARG_INT, &card_index, "card index (as can be seen in /proc/asound/cards)", "X" },
+  { "codec", 'd', 0, G_OPTION_ARG_INT, &codec_index, "codec device index (as can be seen in /proc/asound/cardX/codecY)", "Y" },
+  { "allpins", 'a', 0, G_OPTION_ARG_NONE, &try_all_pins, "try all pins, even those who (probably) does not have a physical jack", NULL },
+  { "setpinsense", 's', 0, G_OPTION_ARG_NONE, &set_pin_sense, "execute 'Set pin sense' before the pin sense is measured", NULL },
+  { NULL }
+};
+
+static void parse_command_line(int argc, char **argv)
+{
+	GError *error = NULL;
+	GOptionContext *context = g_option_context_new("- check current jack/pin sense");
+	g_option_context_add_main_entries(context, arg_entries, NULL);
+	if (!g_option_context_parse (context, &argc, &argv, &error)) {
+		fprintf(stderr, "Option parsing failed: %s\n", error->message);
+		exit(1);
+	}
+}
+
+
+static gboolean should_check_pin(pin_configs_t *pin)
+{
+	unsigned long defcfg = actual_pin_config(pin);
+	if (try_all_pins)
+		return TRUE;
+	if (get_port_conn(defcfg) != 0)
+		return FALSE; // Not a jack
+	if (defcfg & (1 << 8)) // Jack has NO_PRESENCE set
+		return FALSE;
+	return TRUE;
+}
+
+int fd;
+
+static void codec_open()
+{
+	char filename[64];
+	int version = 0;
+
+	snprintf(filename, 64, "/dev/snd/hwC%dD%d", card_index, codec_index);
+	fd = open(filename, O_RDWR);
+	if (fd < 0) {
+		if (errno == EACCES)
+			fprintf(stderr, "Permission error (hint: this program usually requires root)\n");
+		else
+			fprintf(stderr, "Ioctl call failed with error %d\n", errno);
+		exit(1);
+	}
+
+	if (ioctl(fd, HDA_IOCTL_PVERSION, &version) < 0) {
+		fprintf(stderr, "Ioctl call failed with error %d\n", errno);
+		fprintf(stderr, "Looks like an invalid hwdep device...\n");
+		close(fd);
+		exit(1);
+	}
+	if (version < HDA_HWDEP_VERSION) {
+		fprintf(stderr, "Invalid version number 0x%x\n", version);
+		fprintf(stderr, "Looks like an invalid hwdep device...\n");
+		close(fd);
+		exit(1);
+	}
+}
+
+static unsigned long codec_rw(int nid, int verb, int param)
+{
+	struct hda_verb_ioctl val;
+
+	val.verb = HDA_VERB(nid, verb, param);
+	if (ioctl(fd, HDA_IOCTL_VERB_WRITE, &val) < 0) {
+		fprintf(stderr, "Ioctl call failed with error %d\n", errno);
+		close(fd);
+		exit(1);
+	}
+	return val.res;
+}
+
+#define AC_VERB_GET_PIN_SENSE	0x0f09
+#define AC_VERB_SET_PIN_SENSE	0x709
+
+#define MAX_PINS 32
+
+pin_configs_t pin_configs[MAX_PINS];
+
+int main(int argc, char **argv)
+{
+	int pin_count, i;
+
+	parse_command_line(argc, argv);
+	pin_count = get_pin_configs_list(pin_configs, MAX_PINS, card_index, codec_index);
+	if (pin_count == 0) {
+		fprintf(stderr, "No pins found for card %d codec %d, did you pick the right one?\n", card_index, codec_index);
+		exit(1);
+	}
+
+	codec_open();
+
+	if (set_pin_sense) {
+		for (i = 0; i < pin_count; i++)
+			if (should_check_pin(&pin_configs[i])) {
+				codec_rw(pin_configs[i].nid, AC_VERB_SET_PIN_SENSE, 0);
+			}
+		sleep(1);
+	}
+
+	for (i = 0; i < pin_count; i++)
+		if (should_check_pin(&pin_configs[i])) {
+			gchar *desc = get_config_description(actual_pin_config(&pin_configs[i]));
+			unsigned long present = codec_rw(pin_configs[i].nid, AC_VERB_GET_PIN_SENSE, 0);
+			printf("Pin 0x%.2x (%s): present = %s\n", pin_configs[i].nid, desc, present & 0x80000000 ? "Yes" : "No");
+			g_free(desc);
+		}
+
+	close(fd);
+	return 0;
+}
-- 
1.9.1
