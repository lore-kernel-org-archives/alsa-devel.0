From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 5/8] oxfw: Add proc interface for debugging
	purpose
Date: Sun,  5 Jan 2014 20:13:34 +0900
Message-ID: <1388920417-5584-6-git-send-email-o-takashi@sakamocchi.jp>
References: <1388920417-5584-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 0DC1D2610C5
 for <alsa-devel@alsa-project.org>; Sun,  5 Jan 2014 12:13:54 +0100 (CET)
In-Reply-To: <1388920417-5584-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

This commit adds proc interface to get information for debugging.
 - stream formation
 - current sampling rate

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/Makefile    |  2 +-
 sound/firewire/oxfw/oxfw.c      |  2 ++
 sound/firewire/oxfw/oxfw.h      |  3 ++
 sound/firewire/oxfw/oxfw_proc.c | 61 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 67 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/oxfw/oxfw_proc.c

diff --git a/sound/firewire/oxfw/Makefile b/sound/firewire/oxfw/Makefile
index 5eb3d87..ab7865d 100644
--- a/sound/firewire/oxfw/Makefile
+++ b/sound/firewire/oxfw/Makefile
@@ -1,2 +1,2 @@
-snd-oxfw-objs := oxfw_command.o oxfw_stream.o oxfw.o
+snd-oxfw-objs := oxfw_command.o oxfw_stream.o oxfw_proc.o oxfw.o
 obj-m += snd-oxfw.o
diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index f8320af..8298cba 100644
--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -142,6 +142,8 @@ oxfw_probe(struct fw_unit *unit,
 	if (err < 0)
 		goto error;
 
+	snd_oxfw_proc_init(oxfw);
+
 	snd_card_set_dev(card, &unit->device);
 	err = snd_card_register(card);
 	if (err < 0) {
diff --git a/sound/firewire/oxfw/oxfw.h b/sound/firewire/oxfw/oxfw.h
index 34ea0c8..7c02448e 100644
--- a/sound/firewire/oxfw/oxfw.h
+++ b/sound/firewire/oxfw/oxfw.h
@@ -20,6 +20,7 @@
 
 #include <sound/core.h>
 #include <sound/initval.h>
+#include <sound/info.h>
 
 #include "../lib.h"
 #include "../fcp.h"
@@ -106,6 +107,8 @@ void snd_oxfw_stream_destroy_duplex(struct snd_oxfw *oxfw);
 
 int snd_oxfw_stream_discover(struct snd_oxfw *oxfw);
 
+void snd_oxfw_proc_init(struct snd_oxfw *oxfw);
+
 #define SND_OXFW_DEV_ENTRY(vendor, model) \
 { \
 	.match_flags	= IEEE1394_MATCH_VENDOR_ID | \
diff --git a/sound/firewire/oxfw/oxfw_proc.c b/sound/firewire/oxfw/oxfw_proc.c
new file mode 100644
index 0000000..3c1aa96
--- /dev/null
+++ b/sound/firewire/oxfw/oxfw_proc.c
@@ -0,0 +1,61 @@
+/*
+ * oxfw_proc.c - a part of driver for OXFW970/971 based devices
+ *
+ * Copyright (c) 2013 Takashi Sakamoto
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "./oxfw.h"
+
+static void
+proc_read_formation(struct snd_info_entry *entry,
+		struct snd_info_buffer *buffer)
+{
+	struct snd_oxfw *oxfw = entry->private_data;
+	struct snd_oxfw_stream_formation *formation;
+	unsigned int i;
+
+	snd_iprintf(buffer, "Output Stream from device:\n");
+	snd_iprintf(buffer, "\tRate\tPCM\tMIDI\n");
+	formation = oxfw->tx_stream_formations;
+	for (i = 0; i < SND_OXFW_RATE_TABLE_ENTRIES; i++) {
+		snd_iprintf(buffer,
+			"\t%d\t%d\t%d\n", snd_oxfw_rate_table[i],
+			formation[i].pcm, formation[i].midi);
+	}
+
+	snd_iprintf(buffer, "Input Stream to device:\n");
+	snd_iprintf(buffer, "\tRate\tPCM\tMIDI\n");
+	formation = oxfw->rx_stream_formations;
+	for (i = 0; i < SND_OXFW_RATE_TABLE_ENTRIES; i++) {
+		snd_iprintf(buffer,
+			"\t%d\t%d\t%d\n", snd_oxfw_rate_table[i],
+			formation[i].pcm, formation[i].midi);
+	}
+}
+
+static void
+proc_read_clock(struct snd_info_entry *entry,
+		struct snd_info_buffer *buffer)
+{
+	struct snd_oxfw *oxfw = entry->private_data;
+	unsigned int rate;
+
+	if (snd_oxfw_stream_get_rate(oxfw, &rate) < 0)
+		return;
+	snd_iprintf(buffer, "Sampling rate: %d\n", rate);
+}
+
+void snd_oxfw_proc_init(struct snd_oxfw *oxfw)
+{
+	struct snd_info_entry *entry;
+
+	if (!snd_card_proc_new(oxfw->card, "#formation", &entry))
+		snd_info_set_text_ops(entry, oxfw, proc_read_formation);
+
+	if (!snd_card_proc_new(oxfw->card, "#clock", &entry))
+		snd_info_set_text_ops(entry, oxfw, proc_read_clock);
+
+	return;
+}
-- 
1.8.3.2
