From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 03/13] bebob: Add proc interface for debug
Date: Sat, 23 Nov 2013 15:09:15 +0900
Message-ID: <1385186965-8303-4-git-send-email-o-takashi@sakamocchi.jp>
References: <1385186965-8303-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 01C34265307
 for <alsa-devel@alsa-project.org>; Sat, 23 Nov 2013 07:09:34 +0100 (CET)
In-Reply-To: <1385186965-8303-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This commit adds proc interface to get chipset information and stream
formation for debug.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/Makefile     |   2 +-
 sound/firewire/bebob/bebob.c      |   2 +
 sound/firewire/bebob/bebob.h      |   3 +
 sound/firewire/bebob/bebob_proc.c | 123 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 129 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/bebob/bebob_proc.c

diff --git a/sound/firewire/bebob/Makefile b/sound/firewire/bebob/Makefile
index b29ca99..6e44fa0 100644
--- a/sound/firewire/bebob/Makefile
+++ b/sound/firewire/bebob/Makefile
@@ -1,3 +1,3 @@
-snd-bebob-objs := bebob_command.o bebob_stream.o \
+snd-bebob-objs := bebob_command.o bebob_stream.o bebob_proc.o \
 		  bebob.o
 obj-m += snd-bebob.o
diff --git a/sound/firewire/bebob/bebob.c b/sound/firewire/bebob/bebob.c
index 3597a3e..e5aa96e 100644
--- a/sound/firewire/bebob/bebob.c
+++ b/sound/firewire/bebob/bebob.c
@@ -177,6 +177,8 @@ snd_bebob_probe(struct fw_unit *unit,
 	if (err < 0)
 		goto error;
 
+	snd_bebob_proc_init(bebob);
+
 	err = snd_bebob_stream_discover(bebob);
 	if (err < 0)
 		goto error;
diff --git a/sound/firewire/bebob/bebob.h b/sound/firewire/bebob/bebob.h
index f8f3025..2d60165 100644
--- a/sound/firewire/bebob/bebob.h
+++ b/sound/firewire/bebob/bebob.h
@@ -29,6 +29,7 @@
 
 #include <sound/core.h>
 #include <sound/initval.h>
+#include <sound/info.h>
 
 #include "../packets-buffer.h"
 #include "../iso-resources.h"
@@ -146,6 +147,8 @@ int snd_bebob_stream_stop_duplex(struct snd_bebob *bebob);
 void snd_bebob_stream_update_duplex(struct snd_bebob *bebob);
 void snd_bebob_stream_destroy_duplex(struct snd_bebob *bebob);
 
+void snd_bebob_proc_init(struct snd_bebob *bebob);
+
 #define SND_BEBOB_DEV_ENTRY(vendor, model) \
 { \
 	.match_flags	= IEEE1394_MATCH_VENDOR_ID | \
diff --git a/sound/firewire/bebob/bebob_proc.c b/sound/firewire/bebob/bebob_proc.c
new file mode 100644
index 0000000..ca7c1a7
--- /dev/null
+++ b/sound/firewire/bebob/bebob_proc.c
@@ -0,0 +1,123 @@
+/*
+ * bebob_proc.c - a part of driver for BeBoB based devices
+ *
+ * Copyright (c) 2013 Takashi Sakamoto
+ *
+ * This driver is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2.
+ *
+ * This driver is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this driver; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "./bebob.h"
+
+/* contents of information register */
+struct hw_info {
+	u64 manufacturer;
+	u32 protocol_ver;
+	u32 bld_ver;
+	u32 guid[2];
+	u32 model_id;
+	u32 model_rev;
+	u64 fw_date;
+	u64 fw_time;
+	u32 fw_id;
+	u32 fw_ver;
+	u32 base_addr;
+	u32 max_size;
+	u64 bld_date;
+	u64 bld_time;
+/* may not used in product
+	u64 dbg_date;
+	u64 dbg_time;
+	u32 dbg_id;
+	u32 dbg_version;
+*/
+} __packed;
+
+static void
+proc_read_hw_info(struct snd_info_entry *entry,
+		  struct snd_info_buffer *buffer)
+{
+	struct snd_bebob *bebob = entry->private_data;
+	struct hw_info *info;
+	int err;
+
+	info = kzalloc(sizeof(struct hw_info), GFP_KERNEL);
+	if (info == NULL)
+		return;
+
+	err = snd_bebob_read_block(bebob, 0,
+				   info, sizeof(struct hw_info));
+	if (err < 0)
+		goto end;
+
+	snd_iprintf(buffer, "Manufacturer:\t%.8s\n",
+		    (char *)&info->manufacturer);
+	snd_iprintf(buffer, "Protocol Ver:\t%d\n", info->protocol_ver);
+	snd_iprintf(buffer, "Build Ver:\t%d\n", info->bld_ver);
+	snd_iprintf(buffer, "GUID:\t\t0x%.8X%.8X\n",
+		    info->guid[0], info->guid[1]);
+	snd_iprintf(buffer, "Model ID:\t0x%02X\n", info->model_id);
+	snd_iprintf(buffer, "Model Rev:\t%d\n", info->model_rev);
+	snd_iprintf(buffer, "Firmware Date:\t%.8s\n", (char *)&info->fw_date);
+	snd_iprintf(buffer, "Firmware Time:\t%.8s\n", (char *)&info->fw_time);
+	snd_iprintf(buffer, "Firmware ID:\t0x%X\n", info->fw_id);
+	snd_iprintf(buffer, "Firmware Ver:\t%d\n", info->fw_ver);
+	snd_iprintf(buffer, "Base Addr:\t0x%X\n", info->base_addr);
+	snd_iprintf(buffer, "Max Size:\t%d\n", info->max_size);
+	snd_iprintf(buffer, "Loader Date:\t%.8s\n", (char *)&info->bld_date);
+	snd_iprintf(buffer, "Loader Time:\t%.8s\n", (char *)&info->bld_time);
+
+end:
+	kfree(info);
+	return;
+}
+
+static void
+proc_read_formation(struct snd_info_entry *entry,
+		struct snd_info_buffer *buffer)
+{
+	struct snd_bebob *bebob = entry->private_data;
+	struct snd_bebob_stream_formation *formation;
+	unsigned int i;
+
+	snd_iprintf(buffer, "Output Stream from device:\n");
+	snd_iprintf(buffer, "\tRate\tPCM\tMIDI\n");
+	formation = bebob->tx_stream_formations;
+	for (i = 0; i < 9; i += 1) {
+		snd_iprintf(buffer,
+			"\t%d\t%d\t%d\n", snd_bebob_rate_table[i],
+			formation[i].pcm, formation[i].midi);
+	}
+
+	snd_iprintf(buffer, "Input Stream to device:\n");
+	snd_iprintf(buffer, "\tRate\tPCM\tMIDI\n");
+	formation = bebob->rx_stream_formations;
+	for (i = 0; i < 9; i += 1) {
+		snd_iprintf(buffer,
+			"\t%d\t%d\t%d\n", snd_bebob_rate_table[i],
+			formation[i].pcm, formation[i].midi);
+	}
+
+	return;
+}
+
+void snd_bebob_proc_init(struct snd_bebob *bebob)
+{
+	struct snd_info_entry *entry;
+
+	if (!snd_card_proc_new(bebob->card, "#hardware", &entry))
+		snd_info_set_text_ops(entry, bebob, proc_read_hw_info);
+
+	if (!snd_card_proc_new(bebob->card, "#formation", &entry))
+		snd_info_set_text_ops(entry, bebob, proc_read_formation);
+
+	return;
+}
-- 
1.8.3.2
