From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 06/11] fireface: add proc node to help debugging
Date: Sun, 20 Dec 2015 21:28:38 +0900
Message-ID: <1450614523-9367-7-git-send-email-o-takashi@sakamocchi.jp>
References: <1450614523-9367-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C8ED2606FE
 for <alsa-devel@alsa-project.org>; Sun, 20 Dec 2015 13:28:50 +0100 (CET)
In-Reply-To: <1450614523-9367-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Drivers retrieve the state and configuration of clock by read transactions.

This commit adds proc node to dump the information for debugging.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireface/Makefile        |   3 +-
 sound/firewire/fireface/fireface-proc.c | 237 ++++++++++++++++++++++++++++++++
 sound/firewire/fireface/fireface.c      |   2 +
 sound/firewire/fireface/fireface.h      |   2 +
 4 files changed, 243 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/fireface/fireface-proc.c

diff --git a/sound/firewire/fireface/Makefile b/sound/firewire/fireface/Makefile
index 2174b4b..c9d1f4e 100644
--- a/sound/firewire/fireface/Makefile
+++ b/sound/firewire/fireface/Makefile
@@ -1,2 +1,3 @@
-snd-fireface-objs := fireface.o fireface-transaction.o fireface-midi.o
+snd-fireface-objs := fireface.o fireface-transaction.o fireface-midi.o \
+		     fireface-proc.o
 obj-$(CONFIG_SND_FIREFACE) += snd-fireface.o
diff --git a/sound/firewire/fireface/fireface-proc.c b/sound/firewire/fireface/fireface-proc.c
new file mode 100644
index 0000000..d642cba
--- /dev/null
+++ b/sound/firewire/fireface/fireface-proc.c
@@ -0,0 +1,237 @@
+/*
+ * fireface-proc.c - a part of driver for RME Fireface series
+ *
+ * Copyright (c) 2015-2016 Takashi Sakamoto
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "./fireface.h"
+
+static void proc_read_clock_status(struct snd_info_entry *entry,
+				   struct snd_info_buffer *buffer)
+{
+	struct snd_ff *ff = entry->private_data;
+	__le32 reg;
+	u32 data;
+	int err;
+
+	err = snd_fw_transaction(ff->unit, TCODE_READ_QUADLET_REQUEST,
+				 0x0000801c0000, &reg, sizeof(reg), 0);
+	if (err < 0)
+		return;
+
+	data = le32_to_cpu(reg);
+
+	snd_iprintf(buffer, "External source detection:\n");
+
+	snd_iprintf(buffer, "Word Clock:");
+	if ((data >> 24) & 0x20) {
+		if ((data >> 24) & 0x40)
+			snd_iprintf(buffer, "sync\n");
+		else
+			snd_iprintf(buffer, "lock\n");
+	} else {
+		snd_iprintf(buffer, "none\n");
+	}
+
+	snd_iprintf(buffer, "S/PDIF:");
+	if ((data >> 16) & 0x10) {
+		if ((data >> 16) & 0x04)
+			snd_iprintf(buffer, "sync\n");
+		else
+			snd_iprintf(buffer, "lock\n");
+	} else {
+		snd_iprintf(buffer, "none\n");
+	}
+
+	snd_iprintf(buffer, "ADAT:");
+	if ((data >> 8) & 0x04) {
+		if ((data >> 8) & 0x10)
+			snd_iprintf(buffer, "sync\n");
+		else
+			snd_iprintf(buffer, "lock\n");
+	} else {
+		snd_iprintf(buffer, "none\n");
+	}
+
+	snd_iprintf(buffer, "\nUsed external source:\n");
+
+	if (((data >> 22) & 0x07) == 0x07) {
+		snd_iprintf(buffer, "None\n");
+	} else {
+		switch ((data >> 22) & 0x07) {
+		case 0x00:
+			snd_iprintf(buffer, "ADAT:");
+			break;
+		case 0x03:
+			snd_iprintf(buffer, "S/PDIF:");
+			break;
+		case 0x04:
+			snd_iprintf(buffer, "Word:");
+			break;
+		case 0x07:
+			snd_iprintf(buffer, "Nothing:");
+			break;
+		case 0x01:
+		case 0x02:
+		case 0x05:
+		case 0x06:
+		default:
+			snd_iprintf(buffer, "unknown:");
+			break;
+		}
+
+		if ((data >> 25) & 0x07) {
+			switch ((data >> 25) & 0x07) {
+			case 0x01:
+				snd_iprintf(buffer, "32000\n");
+				break;
+			case 0x02:
+				snd_iprintf(buffer, "44100\n");
+				break;
+			case 0x03:
+				snd_iprintf(buffer, "48000\n");
+				break;
+			case 0x04:
+				snd_iprintf(buffer, "64000\n");
+				break;
+			case 0x05:
+				snd_iprintf(buffer, "88200\n");
+				break;
+			case 0x06:
+				snd_iprintf(buffer, "96000\n");
+				break;
+			case 0x07:
+				snd_iprintf(buffer, "128000\n");
+				break;
+			case 0x08:
+				snd_iprintf(buffer, "176400\n");
+				break;
+			case 0x09:
+				snd_iprintf(buffer, "192000\n");
+				break;
+			case 0x00:
+				snd_iprintf(buffer, "unknown\n");
+				break;
+			}
+		}
+	}
+
+	snd_iprintf(buffer, "Multiplied:");
+	snd_iprintf(buffer, "%d\n", (data & 0x3ff) * 250);
+}
+
+static void proc_read_clock_config(struct snd_info_entry *entry,
+				   struct snd_info_buffer *buffer)
+{
+	struct snd_ff *ff = entry->private_data;
+	__le32 reg;
+	u32 data;
+	unsigned int rate;
+	const char *src;
+	int err;
+
+	err = snd_fw_transaction(ff->unit, TCODE_READ_BLOCK_REQUEST,
+				 0x0000801c0004, &reg, sizeof(reg), 0);
+	if (err < 0)
+		return;
+
+	data = le32_to_cpu(reg);
+
+	snd_iprintf(buffer, "Output S/PDIF format: %s (Emphasis: %s)\n",
+		    (data & 0x20) ? "Professional" : "Consumer",
+		    (data & 0x40) ? "on" : "off");
+
+	snd_iprintf(buffer, "Optical output interface format: %s\n",
+		    ((data >> 8) & 0x01) ? "S/PDIF" : "ADAT");
+
+	snd_iprintf(buffer, "Word output single speed: %s\n",
+		    ((data >> 8) & 0x20) ? "on" : "off");
+
+	snd_iprintf(buffer, "S/PDIF input interface: %s\n",
+		    ((data >> 8) & 0x02) ? "Optical" : "Coaxial");
+
+	switch ((data >> 1) & 0x03) {
+	case 0x01:
+		rate = 32000;
+		break;
+	case 0x00:
+		rate = 44100;
+		break;
+	case 0x03:
+		rate = 48000;
+		break;
+	case 0x02:
+	default:
+		return;
+	}
+
+	if (data & 0x08)
+		rate *= 2;
+	else if (data & 0x10)
+		rate *= 4;
+
+	snd_iprintf(buffer, "Sampling rate: %d\n", rate);
+
+	if (data & 0x01) {
+		src = "Internal";
+	} else {
+		switch ((data >> 10) & 0x07) {
+		case 0x00:
+			src = "ADAT";
+			break;
+		case 0x03:
+			src = "S/PDIF";
+			break;
+		case 0x04:
+			src = "Word";
+			break;
+		case 0x05:
+			src = "LTC";
+			break;
+		default:
+			return;
+		}
+	}
+
+	snd_iprintf(buffer, "Sync to clock source: %s\n", src);
+}
+
+static void add_node(struct snd_ff *ff, struct snd_info_entry *root,
+		     const char *name,
+		     void (*op)(struct snd_info_entry *e,
+				struct snd_info_buffer *b))
+{
+	struct snd_info_entry *entry;
+
+	entry = snd_info_create_card_entry(ff->card, name, root);
+	if (entry == NULL)
+		return;
+
+	snd_info_set_text_ops(entry, ff, op);
+	if (snd_info_register(entry) < 0)
+		snd_info_free_entry(entry);
+}
+
+void snd_ff_proc_init(struct snd_ff *ff)
+{
+	struct snd_info_entry *root;
+
+	/*
+	 * All nodes are automatically removed at snd_card_disconnect(),
+	 * by following to link list.
+	 */
+	root = snd_info_create_card_entry(ff->card, "firewire",
+					  ff->card->proc_root);
+	if (root == NULL)
+		return;
+	root->mode = S_IFDIR | S_IRUGO | S_IXUGO;
+	if (snd_info_register(root) < 0) {
+		snd_info_free_entry(root);
+		return;
+	}
+
+	add_node(ff, root, "clock-config", proc_read_clock_config);
+	add_node(ff, root, "clock-status", proc_read_clock_status);
+}
diff --git a/sound/firewire/fireface/fireface.c b/sound/firewire/fireface/fireface.c
index 0883cda..2ea84ce 100644
--- a/sound/firewire/fireface/fireface.c
+++ b/sound/firewire/fireface/fireface.c
@@ -108,6 +108,8 @@ static int snd_ff_probe(struct fw_unit *unit,
 	ff->spec = (const struct snd_ff_spec *)entry->driver_data;
 	name_card(ff);
 
+	snd_ff_proc_init(ff);
+
 	/* Register this sound card later. */
 	INIT_DEFERRABLE_WORK(&ff->dwork, do_probe);
 	delay = msecs_to_jiffies(PROBE_DELAY_MS) +
diff --git a/sound/firewire/fireface/fireface.h b/sound/firewire/fireface/fireface.h
index 33d94b8..38a200e 100644
--- a/sound/firewire/fireface/fireface.h
+++ b/sound/firewire/fireface/fireface.h
@@ -76,6 +76,8 @@ int snd_ff_transaction_register(struct snd_ff *ff);
 int snd_ff_transaction_reregister(struct snd_ff *ff);
 void snd_ff_transaction_unregister(struct snd_ff *ff);
 
+void snd_ff_proc_init(struct snd_ff *ff);
+
 int snd_ff_create_midi_devices(struct snd_ff *ff);
 
 #endif
-- 
2.5.0
