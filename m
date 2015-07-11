From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH 34/37] ALSA: firewire-motu: add proc node
	to show the status of internal clock
Date: Sat, 11 Jul 2015 23:12:45 +0900
Message-ID: <1436623968-10780-35-git-send-email-o-takashi@sakamocchi.jp>
References: <1436623968-10780-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id BAB302605BD
 for <alsa-devel@alsa-project.org>; Sat, 11 Jul 2015 16:13:06 +0200 (CEST)
In-Reply-To: <1436623968-10780-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

This commit adds a proc node for debugging purpose.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/motu/Makefile    |  3 +-
 sound/firewire/motu/motu-proc.c | 73 +++++++++++++++++++++++++++++++++++++++++
 sound/firewire/motu/motu.c      |  2 ++
 sound/firewire/motu/motu.h      |  3 ++
 4 files changed, 80 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/motu/motu-proc.c

diff --git a/sound/firewire/motu/Makefile b/sound/firewire/motu/Makefile
index e41c693..de6ca3b 100644
--- a/sound/firewire/motu/Makefile
+++ b/sound/firewire/motu/Makefile
@@ -1,2 +1,3 @@
-snd-firewire-motu-objs := amdtp-motu.o motu-stream.o motu-transaction.o motu.o
+snd-firewire-motu-objs := amdtp-motu.o motu-stream.o motu-transaction.o \
+			  motu-proc.o motu.o
 obj-m += snd-firewire-motu.o
diff --git a/sound/firewire/motu/motu-proc.c b/sound/firewire/motu/motu-proc.c
new file mode 100644
index 0000000..bc84537
--- /dev/null
+++ b/sound/firewire/motu/motu-proc.c
@@ -0,0 +1,73 @@
+/*
+ * motu-proc.c - a part of driver for MOTU FireWire series
+ *
+ * Copyright (c) 2015 Takashi Sakamoto
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "./motu.h"
+
+static const char *const clock_names[] = {
+	[SND_MOTU_CLOCK_INTERNAL] = "internal",
+	[SND_MOTU_CLOCK_OPT] = "optical interface with ADAT or S/PDIF",
+	[SND_MOTU_CLOCK_SPDIF_COAX] = "coaxial interface with S/PDIF",
+	[SND_MOTU_CLOCK_SPH] = "SMPTE in SPH",
+	[SND_MOTU_CLOCK_ADAT_DSUB] = "D-Sub interface with ADAT",
+	[SND_MOTU_CLOCK_AESEBU_XLR] = "XLR interface with AES/EBU",
+	[SND_MOTU_CLOCK_WORD_BNC] = "BNC interface with Word",
+};
+
+static void proc_read_clock(struct snd_info_entry *entry,
+			    struct snd_info_buffer *buffer)
+{
+
+	struct snd_motu *motu = entry->private_data;
+	unsigned int rate;
+	enum snd_motu_clock src;
+
+	if (snd_motu_stream_get_rate(motu, &rate) < 0)
+		return;
+	if (snd_motu_stream_get_clock(motu, &src) < 0)
+		return;
+
+	snd_iprintf(buffer, "Rate:\t%d\n", rate);
+	snd_iprintf(buffer, "Source:\t%s\n", clock_names[src]);
+}
+
+static void add_node(struct snd_motu *motu, struct snd_info_entry *root,
+		     const char *name,
+		     void (*op)(struct snd_info_entry *e,
+				struct snd_info_buffer *b))
+{
+	struct snd_info_entry *entry;
+
+	entry = snd_info_create_card_entry(motu->card, name, root);
+	if (entry == NULL)
+		return;
+
+	snd_info_set_text_ops(entry, motu, op);
+	if (snd_info_register(entry) < 0)
+		snd_info_free_entry(entry);
+}
+
+void snd_motu_proc_init(struct snd_motu *motu)
+{
+	struct snd_info_entry *root;
+
+	/*
+	 * All nodes are automatically removed at snd_card_disconnect(),
+	 * by following to link list.
+	 */
+	root = snd_info_create_card_entry(motu->card, "firewire",
+					  motu->card->proc_root);
+	if (root == NULL)
+		return;
+	root->mode = S_IFDIR | S_IRUGO | S_IXUGO;
+	if (snd_info_register(root) < 0) {
+		snd_info_free_entry(root);
+		return;
+	}
+
+	add_node(motu, root, "clock", proc_read_clock);
+}
diff --git a/sound/firewire/motu/motu.c b/sound/firewire/motu/motu.c
index 3c7a51f..5717854 100644
--- a/sound/firewire/motu/motu.c
+++ b/sound/firewire/motu/motu.c
@@ -76,6 +76,8 @@ static int motu_probe(struct fw_unit *unit, const struct ieee1394_device_id *id)
 	if (err < 0)
 		goto error;
 
+	snd_motu_proc_init(motu);
+
 	err = snd_card_register(card);
 	if (err < 0)
 		goto error;
diff --git a/sound/firewire/motu/motu.h b/sound/firewire/motu/motu.h
index 1597e99..8486dd8 100644
--- a/sound/firewire/motu/motu.h
+++ b/sound/firewire/motu/motu.h
@@ -23,6 +23,7 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/rawmidi.h>
+#include <sound/info.h>
 
 #include "../amdtp-stream.h"
 #include "../iso-resources.h"
@@ -105,4 +106,6 @@ int snd_motu_transaction_register(struct snd_motu *motu);
 int snd_motu_transaction_reregister(struct snd_motu *motu);
 void snd_motu_transaction_unregister(struct snd_motu *motu);
 
+void snd_motu_proc_init(struct snd_motu *motu);
+
 #endif
-- 
2.1.4
