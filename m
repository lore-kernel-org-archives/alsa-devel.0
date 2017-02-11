From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 07/13] ALSA: fireface: add proc node to help
	debugging
Date: Sat, 11 Feb 2017 23:25:03 +0900
Message-ID: <20170211142509.4795-8-o-takashi@sakamocchi.jp>
References: <20170211142509.4795-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id E6083266C27
 for <alsa-devel@alsa-project.org>; Sat, 11 Feb 2017 15:25:17 +0100 (CET)
In-Reply-To: <20170211142509.4795-1-o-takashi@sakamocchi.jp>
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
 sound/firewire/fireface/Makefile  |  2 +-
 sound/firewire/fireface/ff-proc.c | 63 +++++++++++++++++++++++++++++++++++++++
 sound/firewire/fireface/ff.c      |  2 ++
 sound/firewire/fireface/ff.h      |  2 ++
 4 files changed, 68 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/fireface/ff-proc.c

diff --git a/sound/firewire/fireface/Makefile b/sound/firewire/fireface/Makefile
index 8e465e4..e88ff9e 100644
--- a/sound/firewire/fireface/Makefile
+++ b/sound/firewire/fireface/Makefile
@@ -1,2 +1,2 @@
-snd-fireface-objs := ff.o ff-transaction.o ff-midi.o
+snd-fireface-objs := ff.o ff-transaction.o ff-midi.o ff-proc.o
 obj-$(CONFIG_SND_FIREFACE) += snd-fireface.o
diff --git a/sound/firewire/fireface/ff-proc.c b/sound/firewire/fireface/ff-proc.c
new file mode 100644
index 0000000..69441d1
--- /dev/null
+++ b/sound/firewire/fireface/ff-proc.c
@@ -0,0 +1,63 @@
+/*
+ * ff-proc.c - a part of driver for RME Fireface series
+ *
+ * Copyright (c) 2015-2017 Takashi Sakamoto
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "./ff.h"
+
+static void proc_dump_clock_config(struct snd_info_entry *entry,
+				   struct snd_info_buffer *buffer)
+{
+	struct snd_ff *ff = entry->private_data;
+
+	ff->spec->protocol->dump_clock_config(ff, buffer);
+}
+
+static void proc_dump_sync_status(struct snd_info_entry *entry,
+				  struct snd_info_buffer *buffer)
+{
+	struct snd_ff *ff = entry->private_data;
+
+	ff->spec->protocol->dump_sync_status(ff, buffer);
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
+	add_node(ff, root, "clock-config", proc_dump_clock_config);
+	add_node(ff, root, "sync-status", proc_dump_sync_status);
+}
diff --git a/sound/firewire/fireface/ff.c b/sound/firewire/fireface/ff.c
index 11d76b3..22e7bcb 100644
--- a/sound/firewire/fireface/ff.c
+++ b/sound/firewire/fireface/ff.c
@@ -61,6 +61,8 @@ static void do_registration(struct work_struct *work)
 
 	name_card(ff);
 
+	snd_ff_proc_init(ff);
+
 	err = snd_ff_create_midi_devices(ff);
 	if (err < 0)
 		goto error;
diff --git a/sound/firewire/fireface/ff.h b/sound/firewire/fireface/ff.h
index 2944bde..2d1fab2 100644
--- a/sound/firewire/fireface/ff.h
+++ b/sound/firewire/fireface/ff.h
@@ -99,6 +99,8 @@ int snd_ff_transaction_register(struct snd_ff *ff);
 int snd_ff_transaction_reregister(struct snd_ff *ff);
 void snd_ff_transaction_unregister(struct snd_ff *ff);
 
+void snd_ff_proc_init(struct snd_ff *ff);
+
 int snd_ff_create_midi_devices(struct snd_ff *ff);
 
 #endif
-- 
2.9.3
