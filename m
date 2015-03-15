From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 03/11] ALSA: digi00x: add proc node for clock
	status
Date: Mon, 16 Mar 2015 01:01:01 +0900
Message-ID: <1426435269-17059-4-git-send-email-o-takashi@sakamocchi.jp>
References: <1426435269-17059-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A6CF26071E
 for <alsa-devel@alsa-project.org>; Sun, 15 Mar 2015 17:01:19 +0100 (CET)
In-Reply-To: <1426435269-17059-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, robin@gareus.org, damien@zamaudio.com
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

This commit adds proc node to check current clock status for debugging.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/digi00x/Makefile       |  2 +-
 sound/firewire/digi00x/digi00x-proc.c | 71 +++++++++++++++++++++++++++++++++++
 sound/firewire/digi00x/digi00x.c      |  2 +
 sound/firewire/digi00x/digi00x.h      |  2 +
 4 files changed, 76 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/digi00x/digi00x-proc.c

diff --git a/sound/firewire/digi00x/Makefile b/sound/firewire/digi00x/Makefile
index fe8fceb..aaec823 100644
--- a/sound/firewire/digi00x/Makefile
+++ b/sound/firewire/digi00x/Makefile
@@ -1,2 +1,2 @@
-snd-digi00x-objs := digi00x.o digi00x-stream.o
+snd-digi00x-objs := digi00x.o digi00x-stream.o digi00x-proc.o
 obj-m += snd-digi00x.o
diff --git a/sound/firewire/digi00x/digi00x-proc.c b/sound/firewire/digi00x/digi00x-proc.c
new file mode 100644
index 0000000..29b7efe
--- /dev/null
+++ b/sound/firewire/digi00x/digi00x-proc.c
@@ -0,0 +1,71 @@
+/*
+ * digi00x-proc.c - a part of driver for Digidesign Digi 002/003 family
+ *
+ * Copyright (c) 2014-2015 Takashi Sakamoto
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "./digi00x.h"
+
+static void proc_read_clock(struct snd_info_entry *entry,
+			    struct snd_info_buffer *buf)
+{
+	static const char *const source_name[] = {
+		[SND_DG00X_CLOCK_INTERNAL] = "internal",
+		[SND_DG00X_CLOCK_SPDIF] = "s/pdif",
+		[SND_DG00X_CLOCK_ADAT] = "adat",
+		[SND_DG00X_CLOCK_WORD] = "word clock",
+	};
+	static const char *const optical_name[] = {
+		[SND_DG00X_OPTICAL_MODE_ADAT] = "adat",
+		[SND_DG00X_OPTICAL_MODE_SPDIF] = "s/pdif",
+	};
+	struct snd_dg00x *dg00x = entry->private_data;
+	unsigned int rate;
+	enum snd_dg00x_clock clock;
+	enum snd_dg00x_optical_mode mode;
+
+	if (snd_dg00x_stream_get_rate(dg00x, &rate) < 0)
+		return;
+	if (snd_dg00x_stream_get_clock(dg00x, &clock) < 0)
+		return;
+	if (snd_dg00x_stream_get_optical_mode(dg00x, &mode) < 0)
+		return;
+
+	snd_iprintf(buf, "Sampling Rate: %d\n", rate);
+	snd_iprintf(buf, "Clock Source: %s\n", source_name[clock]);
+	snd_iprintf(buf, "Optical mode: %s\n", optical_name[mode]);
+}
+
+void snd_dg00x_proc_init(struct snd_dg00x *dg00x)
+{
+	struct snd_info_entry *root, *entry;
+
+	/*
+	 * All nodes are automatically removed at snd_card_disconnect(),
+	 * by following to link list.
+	 */
+	root = snd_info_create_card_entry(dg00x->card, "firewire",
+					  dg00x->card->proc_root);
+	if (root == NULL)
+		return;
+
+	root->mode = S_IFDIR | S_IRUGO | S_IXUGO;
+	if (snd_info_register(root) < 0) {
+		snd_info_free_entry(root);
+		return;
+	}
+
+	entry = snd_info_create_card_entry(dg00x->card, "clock", root);
+	if (entry == NULL) {
+		snd_info_free_entry(root);
+		return;
+	}
+
+	snd_info_set_text_ops(entry, dg00x, proc_read_clock);
+	if (snd_info_register(entry) < 0) {
+		snd_info_free_entry(entry);
+		snd_info_free_entry(root);
+	}
+}
diff --git a/sound/firewire/digi00x/digi00x.c b/sound/firewire/digi00x/digi00x.c
index b82bce7..d9c9e14 100644
--- a/sound/firewire/digi00x/digi00x.c
+++ b/sound/firewire/digi00x/digi00x.c
@@ -84,6 +84,8 @@ static int snd_dg00x_probe(struct fw_unit *unit,
 	if (err < 0)
 		goto error;
 
+	snd_dg00x_proc_init(dg00x);
+
 	err = snd_card_register(card);
 	if (err < 0)
 		goto error;
diff --git a/sound/firewire/digi00x/digi00x.h b/sound/firewire/digi00x/digi00x.h
index 61cfd6e..dde039f 100644
--- a/sound/firewire/digi00x/digi00x.h
+++ b/sound/firewire/digi00x/digi00x.h
@@ -20,6 +20,7 @@
 
 #include <sound/core.h>
 #include <sound/initval.h>
+#include <sound/info.h>
 
 #include "../lib.h"
 #include "../packets-buffer.h"
@@ -82,4 +83,5 @@ void snd_dg00x_stream_stop_duplex(struct snd_dg00x *dg00x);
 void snd_dg00x_stream_update_duplex(struct snd_dg00x *dg00x);
 void snd_dg00x_stream_destroy_duplex(struct snd_dg00x *dg00x);
 
+void snd_dg00x_proc_init(struct snd_dg00x *dg00x);
 #endif
-- 
2.1.0
