From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 36/49] bebob: Add proc interface for debugging purpose
Date: Fri, 25 Apr 2014 22:45:17 +0900
Message-ID: <1398433530-13136-37-git-send-email-o-takashi@sakamocchi.jp>
References: <1398433530-13136-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1398433530-13136-1-git-send-email-o-takashi@sakamocchi.jp>
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

This commit adds proc interface to get these information for debugging:
 - firmware information
 - stream formation
 - current clock source and sampling rate

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/Makefile     |   2 +-
 sound/firewire/bebob/bebob.c      |   2 +
 sound/firewire/bebob/bebob.h      |   3 +
 sound/firewire/bebob/bebob_proc.c | 151 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 157 insertions(+), 1 deletion(-)
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
index 180284d..0c3f1f6 100644
--- a/sound/firewire/bebob/bebob.c
+++ b/sound/firewire/bebob/bebob.c
@@ -162,6 +162,8 @@ bebob_probe(struct fw_unit *unit,
 	if (err < 0)
 		goto error;
 
+	snd_bebob_proc_init(bebob);
+
 	err = snd_bebob_stream_init_duplex(bebob);
 	if (err < 0)
 		goto error;
diff --git a/sound/firewire/bebob/bebob.h b/sound/firewire/bebob/bebob.h
index 031ca78..1247cca 100644
--- a/sound/firewire/bebob/bebob.h
+++ b/sound/firewire/bebob/bebob.h
@@ -20,6 +20,7 @@
 
 #include <sound/core.h>
 #include <sound/initval.h>
+#include <sound/info.h>
 
 #include "../lib.h"
 #include "../fcp.h"
@@ -171,6 +172,8 @@ void snd_bebob_stream_stop_duplex(struct snd_bebob *bebob);
 void snd_bebob_stream_update_duplex(struct snd_bebob *bebob);
 void snd_bebob_stream_destroy_duplex(struct snd_bebob *bebob);
 
+void snd_bebob_proc_init(struct snd_bebob *bebob);
+
 #define SND_BEBOB_DEV_ENTRY(vendor, model) \
 { \
 	.match_flags	= IEEE1394_MATCH_VENDOR_ID | \
diff --git a/sound/firewire/bebob/bebob_proc.c b/sound/firewire/bebob/bebob_proc.c
new file mode 100644
index 0000000..c31ca4f
--- /dev/null
+++ b/sound/firewire/bebob/bebob_proc.c
@@ -0,0 +1,151 @@
+/*
+ * bebob_proc.c - a part of driver for BeBoB based devices
+ *
+ * Copyright (c) 2013-2014 Takashi Sakamoto
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
+
+	info = kzalloc(sizeof(struct hw_info), GFP_KERNEL);
+	if (info == NULL)
+		return;
+
+	if (snd_bebob_read_block(bebob->unit, 0,
+				   info, sizeof(struct hw_info)) < 0)
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
+			    "\t%d\t%d\t%d\n", snd_bebob_rate_table[i],
+			    formation[i].pcm, formation[i].midi);
+	}
+
+	snd_iprintf(buffer, "Input Stream to device:\n");
+	snd_iprintf(buffer, "\tRate\tPCM\tMIDI\n");
+	formation = bebob->rx_stream_formations;
+	for (i = 0; i < SND_BEBOB_STRM_FMT_ENTRIES; i++) {
+		snd_iprintf(buffer,
+			    "\t%d\t%d\t%d\n", snd_bebob_rate_table[i],
+			    formation[i].pcm, formation[i].midi);
+	}
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
+	if (snd_bebob_stream_get_rate(bebob, &rate) >= 0)
+		snd_iprintf(buffer, "Sampling rate: %d\n", rate);
+
+	if (snd_bebob_stream_check_internal_clock(bebob, &internal) >= 0)
+		snd_iprintf(buffer, "Clock Source: %s (MSU-dest: %d)",
+			    (internal) ? "Internal" : "External",
+			    bebob->sync_input_plug);
+}
+
+static void
+add_node(struct snd_bebob *bebob, struct snd_info_entry *root, const char *name,
+	 void (*op)(struct snd_info_entry *e, struct snd_info_buffer *b))
+{
+	struct snd_info_entry *entry;
+
+	entry = snd_info_create_card_entry(bebob->card, name, root);
+	if (entry == NULL)
+		return;
+
+	snd_info_set_text_ops(entry, bebob, op);
+	if (snd_info_register(entry) < 0)
+		snd_info_free_entry(entry);
+}
+
+void snd_bebob_proc_init(struct snd_bebob *bebob)
+{
+	struct snd_info_entry *root;
+
+	/*
+	 * All nodes are automatically removed at snd_card_disconnect(),
+	 * by following to link list.
+	 */
+	root = snd_info_create_card_entry(bebob->card, "firewire",
+					  bebob->card->proc_root);
+	if (root == NULL)
+		return;
+	root->mode = S_IFDIR | S_IRUGO | S_IXUGO;
+	if (snd_info_register(root) < 0) {
+		snd_info_free_entry(root);
+		return;
+	}
+
+	add_node(bebob, root, "clock", proc_read_clock);
+	add_node(bebob, root, "firmware", proc_read_hw_info);
+	add_node(bebob, root, "formation", proc_read_formation);
+}
-- 
1.8.3.2


------------------------------------------------------------------------------
Start Your Social Network Today - Download eXo Platform
Build your Enterprise Intranet with eXo Platform Software
Java Based Open Source Intranet - Social, Extensible, Cloud Ready
Get Started Now And Turn Your Intranet Into A Collaboration Platform
http://p.sf.net/sfu/ExoPlatform
