From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 08/15] oxfw: Add proc interface for debugging purpose
Date: Tue, 13 May 2014 23:27:45 +0900
Message-ID: <1399991272-5807-9-git-send-email-o-takashi@sakamocchi.jp>
References: <1399991272-5807-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1399991272-5807-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: clemens@ladisch.de
Cc: alsa-devel@alsa-project.org, fenlason@redhat.com, ffado-devel@lists.sf.net, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This commit adds proc interface to get information about:
 - stream formation
 - current sampling rate

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/Makefile    |  2 +-
 sound/firewire/oxfw/oxfw.c      |  2 ++
 sound/firewire/oxfw/oxfw.h      |  3 ++
 sound/firewire/oxfw/oxfw_proc.c | 77 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 83 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/oxfw/oxfw_proc.c

diff --git a/sound/firewire/oxfw/Makefile b/sound/firewire/oxfw/Makefile
index 3eaec6d..53b5572 100644
--- a/sound/firewire/oxfw/Makefile
+++ b/sound/firewire/oxfw/Makefile
@@ -1,2 +1,2 @@
-snd-oxfw-objs := oxfw_stream.o oxfw_control.o oxfw_pcm.o oxfw.o
+snd-oxfw-objs := oxfw_stream.o oxfw_control.o oxfw_proc.o oxfw_pcm.o oxfw.o
 obj-m += snd-oxfw.o
diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index cfdf420..d900718 100644
--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -120,6 +120,8 @@ static int oxfw_probe(struct fw_unit *unit,
 	if (err < 0)
 		goto error;
 
+	snd_oxfw_proc_init(oxfw);
+
 	err = snd_card_register(card);
 	if (err < 0) {
 		snd_oxfw_stream_destroy_simplex(oxfw);
diff --git a/sound/firewire/oxfw/oxfw.h b/sound/firewire/oxfw/oxfw.h
index 000c2af..5d14424 100644
--- a/sound/firewire/oxfw/oxfw.h
+++ b/sound/firewire/oxfw/oxfw.h
@@ -18,6 +18,7 @@
 #include <sound/initval.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
+#include <sound/info.h>
 
 #include "../lib.h"
 #include "../fcp.h"
@@ -69,3 +70,5 @@ int lacie_speakers_stream_discover(struct snd_oxfw *oxfw);
 int snd_oxfw_create_pcm(struct snd_oxfw *oxfw);
 
 int snd_oxfw_create_mixer(struct snd_oxfw *oxfw);
+
+void snd_oxfw_proc_init(struct snd_oxfw *oxfw);
diff --git a/sound/firewire/oxfw/oxfw_proc.c b/sound/firewire/oxfw/oxfw_proc.c
new file mode 100644
index 0000000..dd287dc
--- /dev/null
+++ b/sound/firewire/oxfw/oxfw_proc.c
@@ -0,0 +1,77 @@
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
+	struct snd_oxfw_stream_formation *formation;
+	unsigned int i;
+
+	snd_iprintf(buffer, "Input Stream to device:\n");
+	snd_iprintf(buffer, "\tRate\tPCM\tMIDI\n");
+	formation = oxfw->rx_stream_formations;
+	for (i = 0; i < SND_OXFW_STREAM_FORMAT_ENTRIES; i++) {
+		snd_iprintf(buffer,
+			"\t%d\t%d\t%d\n", formation[i].rate,
+			formation[i].pcm, formation[i].midi);
+	}
+}
+
+static void proc_read_clock(struct snd_info_entry *entry,
+			    struct snd_info_buffer *buffer)
+{
+	struct snd_oxfw *oxfw = entry->private_data;
+	unsigned int rate;
+	int err;
+
+	err = avc_general_get_sig_fmt(oxfw->unit, &rate,
+				      AVC_GENERAL_PLUG_DIR_IN, 0);
+	if (err >= 0)
+		snd_iprintf(buffer, "Sampling rate: %d\n", rate);
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
+	add_node(oxfw, root, "clock", proc_read_clock);
+	add_node(oxfw, root, "formation", proc_read_formation);
+}
-- 
1.8.3.2


------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.
Get unparalleled scalability from the best Selenium testing platform available
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
