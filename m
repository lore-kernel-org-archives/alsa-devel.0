From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 28/52] bebob: Add proc interface for debugging purpose
Date: Wed, 29 Jan 2014 22:44:35 +0900
Message-ID: <1391003099-7109-29-git-send-email-o-takashi@sakamocchi.jp>
References: <1391003099-7109-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1391003099-7109-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

This commit adds proc interface to get information for debugging.
 - firmware information
 - stream formation
 - current clock source and sampling rate

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/Makefile     |   2 +-
 sound/firewire/bebob/bebob.c      |   2 +
 sound/firewire/bebob/bebob.h      |   3 +
 sound/firewire/bebob/bebob_proc.c | 136 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 142 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/bebob/bebob_proc.c

diff --git a/sound/firewire/bebob/Makefile b/sound/firewire/bebob/Makefile
index 5cece62..757c40e 100644
--- a/sound/firewire/bebob/Makefile
+++ b/sound/firewire/bebob/Makefile
@@ -1,2 +1,2 @@
-snd-bebob-objs := bebob_command.o bebob_stream.o bebob.o
+snd-bebob-objs := bebob_command.o bebob_stream.o bebob_proc.o bebob.o
 obj-m += snd-bebob.o
diff --git a/sound/firewire/bebob/bebob.c b/sound/firewire/bebob/bebob.c
index 273ef39..b19d7c5 100644
--- a/sound/firewire/bebob/bebob.c
+++ b/sound/firewire/bebob/bebob.c
@@ -167,6 +167,8 @@ bebob_probe(struct fw_unit *unit,
 	if (err < 0)
 		goto error;
 
+	snd_bebob_proc_init(bebob);
+
 	snd_card_set_dev(card, &unit->device);
 	err = snd_card_register(card);
 	if (err < 0) {
diff --git a/sound/firewire/bebob/bebob.h b/sound/firewire/bebob/bebob.h
index 0dce92b..e513fd3 100644
--- a/sound/firewire/bebob/bebob.h
+++ b/sound/firewire/bebob/bebob.h
@@ -20,6 +20,7 @@
 
 #include <sound/core.h>
 #include <sound/initval.h>
+#include <sound/info.h>
 
 #include "../lib.h"
 #include "../fcp.h"
@@ -175,6 +176,8 @@ int snd_bebob_stream_stop_duplex(struct snd_bebob *bebob);
 void snd_bebob_stream_update_duplex(struct snd_bebob *bebob);
 void snd_bebob_stream_destroy_duplex(struct snd_bebob *bebob);
 
+void snd_bebob_proc_init(struct snd_bebob *bebob);
+
 #define SND_BEBOB_DEV_ENTRY(vendor, model) \
 { \
 	.match_flags	= IEEE1394_MATCH_VENDOR_ID | \
diff --git a/sound/firewire/bebob/bebob_proc.c b/sound/firewire/bebob/bebob_proc.c
new file mode 100644
index 0000000..40099a5
--- /dev/null
+++ b/sound/firewire/bebob/bebob_proc.c
@@ -0,0 +1,136 @@
+/*
+ * bebob_proc.c - a part of driver for BeBoB based devices
+ *
+ * Copyright (c) 2013 Takashi Sakamoto
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
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
+	err = snd_bebob_read_block(bebob->unit, 0,
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
+	for (i = 0; i < SND_BEBOB_STRM_FMT_ENTRIES; i++) {
+		snd_iprintf(buffer,
+			"\t%d\t%d\t%d\n", snd_bebob_rate_table[i],
+			formation[i].pcm, formation[i].midi);
+	}
+
+	snd_iprintf(buffer, "Input Stream to device:\n");
+	snd_iprintf(buffer, "\tRate\tPCM\tMIDI\n");
+	formation = bebob->rx_stream_formations;
+	for (i = 0; i < SND_BEBOB_STRM_FMT_ENTRIES; i++) {
+		snd_iprintf(buffer,
+			"\t%d\t%d\t%d\n", snd_bebob_rate_table[i],
+			formation[i].pcm, formation[i].midi);
+	}
+
+	return;
+}
+
+static void
+proc_read_clock(struct snd_info_entry *entry,
+		struct snd_info_buffer *buffer)
+{
+	struct snd_bebob *bebob = entry->private_data;
+	unsigned int rate;
+	bool internal;
+
+	if (snd_bebob_stream_get_rate(bebob, &rate) < 0)
+		return;
+	if (snd_bebob_stream_check_internal_clock(bebob, &internal) < 0)
+		return;
+
+	snd_iprintf(buffer, "Clock Source: %s (MSU-dest: %d)",
+		    (internal) ? "Internal" : "External",
+		    bebob->sync_input_plug);
+	snd_iprintf(buffer, "Sampling rate: %d\n", rate);
+}
+
+void snd_bebob_proc_init(struct snd_bebob *bebob)
+{
+	struct snd_info_entry *entry;
+
+	if (!snd_card_proc_new(bebob->card, "#firmware", &entry))
+		snd_info_set_text_ops(entry, bebob, proc_read_hw_info);
+
+	if (!snd_card_proc_new(bebob->card, "#formation", &entry))
+		snd_info_set_text_ops(entry, bebob, proc_read_formation);
+
+	if (!snd_card_proc_new(bebob->card, "#clock", &entry))
+		snd_info_set_text_ops(entry, bebob, proc_read_clock);
+
+	return;
+}
-- 
1.8.3.2


------------------------------------------------------------------------------
WatchGuard Dimension instantly turns raw network data into actionable 
security intelligence. It gives you real-time visual feedback on key
security issues and trends.  Skip the complicated setup - simply import
a virtual appliance and go from zero to informed in seconds.
http://pubads.g.doubleclick.net/gampad/clk?id=123612991&iu=/4140/ostg.clktrk
