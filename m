From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 09/15] ALSA: oxfw: Add proc interface for
	debugging purpose
Date: Tue,  9 Dec 2014 00:10:43 +0900
Message-ID: <1418051449-18371-10-git-send-email-o-takashi@sakamocchi.jp>
References: <1418051449-18371-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 7FD51260603
 for <alsa-devel@alsa-project.org>; Mon,  8 Dec 2014 16:11:01 +0100 (CET)
In-Reply-To: <1418051449-18371-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This commit adds proc interface to get information about stream
formation. This commit also adds snd_oxfw_stream_get_current_formation()
to get current stream formation.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/Makefile      |  3 +-
 sound/firewire/oxfw/oxfw-proc.c   | 84 +++++++++++++++++++++++++++++++++++++++
 sound/firewire/oxfw/oxfw-stream.c | 27 +++++++++++++
 sound/firewire/oxfw/oxfw.c        |  2 +
 sound/firewire/oxfw/oxfw.h        |  3 ++
 5 files changed, 118 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/oxfw/oxfw-proc.c

diff --git a/sound/firewire/oxfw/Makefile b/sound/firewire/oxfw/Makefile
index b107134..e9297c6 100644
--- a/sound/firewire/oxfw/Makefile
+++ b/sound/firewire/oxfw/Makefile
@@ -1,2 +1,3 @@
-snd-oxfw-objs := oxfw-command.o oxfw-stream.o oxfw-control.o oxfw-pcm.o oxfw.o
+snd-oxfw-objs := oxfw-command.o oxfw-stream.o oxfw-control.o oxfw-pcm.o \
+		 oxfw-proc.o oxfw.o
 obj-m += snd-oxfw.o
diff --git a/sound/firewire/oxfw/oxfw-proc.c b/sound/firewire/oxfw/oxfw-proc.c
new file mode 100644
index 0000000..18e0305
--- /dev/null
+++ b/sound/firewire/oxfw/oxfw-proc.c
@@ -0,0 +1,84 @@
+/*
+ * oxfw_proc.c - a part of driver for OXFW970/971 based devices
+ *
+ * Copyright (c) 2014 Takashi Sakamoto
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "./oxfw.h"
+
+static void proc_read_formation(struct snd_info_entry *entry,
+				struct snd_info_buffer *buffer)
+{
+	struct snd_oxfw *oxfw = entry->private_data;
+	struct snd_oxfw_stream_formation formation, curr;
+	u8 *format;
+	char flag;
+	unsigned int i, err;
+
+	/* Show input. */
+	err = snd_oxfw_stream_get_current_formation(oxfw,
+						    AVC_GENERAL_PLUG_DIR_IN,
+						    &curr);
+	if (err < 0)
+		return;
+
+	snd_iprintf(buffer, "Input Stream to device:\n");
+	snd_iprintf(buffer, "\tRate\tPCM\tMIDI\n");
+	for (i = 0; i < SND_OXFW_STREAM_FORMAT_ENTRIES; i++) {
+		format = oxfw->rx_stream_formats[i];
+		if (format == NULL)
+			continue;
+
+		err = snd_oxfw_stream_parse_format(format, &formation);
+		if (err < 0)
+			continue;
+
+		if (memcmp(&formation, &curr, sizeof(curr)) == 0)
+			flag = '*';
+		else
+			flag = ' ';
+
+		snd_iprintf(buffer, "%c\t%d\t%d\t%d\n", flag,
+			    formation.rate, formation.pcm, formation.midi);
+	}
+
+}
+
+static void add_node(struct snd_oxfw *oxfw, struct snd_info_entry *root,
+		     const char *name,
+		     void (*op)(struct snd_info_entry *e,
+				struct snd_info_buffer *b))
+{
+	struct snd_info_entry *entry;
+
+	entry = snd_info_create_card_entry(oxfw->card, name, root);
+	if (entry == NULL)
+		return;
+
+	snd_info_set_text_ops(entry, oxfw, op);
+	if (snd_info_register(entry) < 0)
+		snd_info_free_entry(entry);
+}
+
+void snd_oxfw_proc_init(struct snd_oxfw *oxfw)
+{
+	struct snd_info_entry *root;
+
+	/*
+	 * All nodes are automatically removed at snd_card_disconnect(),
+	 * by following to link list.
+	 */
+	root = snd_info_create_card_entry(oxfw->card, "firewire",
+					  oxfw->card->proc_root);
+	if (root == NULL)
+		return;
+	root->mode = S_IFDIR | S_IRUGO | S_IXUGO;
+	if (snd_info_register(root) < 0) {
+		snd_info_free_entry(root);
+		return;
+	}
+
+	add_node(oxfw, root, "formation", proc_read_formation);
+}
diff --git a/sound/firewire/oxfw/oxfw-stream.c b/sound/firewire/oxfw/oxfw-stream.c
index 17e3802..210bf5a 100644
--- a/sound/firewire/oxfw/oxfw-stream.c
+++ b/sound/firewire/oxfw/oxfw-stream.c
@@ -108,6 +108,33 @@ void snd_oxfw_stream_update_simplex(struct snd_oxfw *oxfw)
 		amdtp_stream_update(&oxfw->rx_stream);
 }
 
+int snd_oxfw_stream_get_current_formation(struct snd_oxfw *oxfw,
+				enum avc_general_plug_dir dir,
+				struct snd_oxfw_stream_formation *formation)
+{
+	u8 *format;
+	unsigned int len;
+	int err;
+
+	len = AVC_GENERIC_FRAME_MAXIMUM_BYTES;
+	format = kmalloc(len, GFP_KERNEL);
+	if (format == NULL)
+		return -ENOMEM;
+
+	err = avc_stream_get_format_single(oxfw->unit, dir, 0, format, &len);
+	if (err < 0)
+		goto end;
+	if (len < 3) {
+		err = -EIO;
+		goto end;
+	}
+
+	err = snd_oxfw_stream_parse_format(format, formation);
+end:
+	kfree(format);
+	return err;
+}
+
 /*
  * See Table 6.16 - AM824 Stream Format
  *     Figure 6.19 - format_information field for AM824 Compound
diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index a8f9062..a70149a 100644
--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -101,6 +101,8 @@ static int oxfw_probe(struct fw_unit *unit,
 	if (err < 0)
 		goto error;
 
+	snd_oxfw_proc_init(oxfw);
+
 	err = snd_oxfw_stream_init_simplex(oxfw);
 	if (err < 0)
 		goto error;
diff --git a/sound/firewire/oxfw/oxfw.h b/sound/firewire/oxfw/oxfw.h
index 9c3d3e3..8c832ea 100644
--- a/sound/firewire/oxfw/oxfw.h
+++ b/sound/firewire/oxfw/oxfw.h
@@ -18,6 +18,7 @@
 #include <sound/initval.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
+#include <sound/info.h>
 
 #include "../lib.h"
 #include "../fcp.h"
@@ -108,3 +109,5 @@ int snd_oxfw_stream_discover(struct snd_oxfw *oxfw);
 int snd_oxfw_create_pcm(struct snd_oxfw *oxfw);
 
 int snd_oxfw_create_mixer(struct snd_oxfw *oxfw);
+
+void snd_oxfw_proc_init(struct snd_oxfw *oxfw);
-- 
2.1.0
