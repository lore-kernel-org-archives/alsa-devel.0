From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 11/18] ALSA: firewire-motu: add proc node to
	show current statuc of clock and packet formats
Date: Wed, 22 Mar 2017 21:30:21 +0900
Message-ID: <20170322123028.24148-12-o-takashi@sakamocchi.jp>
References: <20170322123028.24148-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id EC9562673C4
 for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2017 13:30:42 +0100 (CET)
In-Reply-To: <20170322123028.24148-1-o-takashi@sakamocchi.jp>
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

This commit adds a proc node for debugging purpose.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/motu/Makefile    |   3 +-
 sound/firewire/motu/motu-proc.c | 118 ++++++++++++++++++++++++++++++++++++++++
 sound/firewire/motu/motu.c      |   2 +
 sound/firewire/motu/motu.h      |   3 +
 4 files changed, 125 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/motu/motu-proc.c

diff --git a/sound/firewire/motu/Makefile b/sound/firewire/motu/Makefile
index 504a4f9..0eccbe2 100644
--- a/sound/firewire/motu/Makefile
+++ b/sound/firewire/motu/Makefile
@@ -1,2 +1,3 @@
-snd-firewire-motu-objs := motu.o amdtp-motu.o motu-transaction.o motu-stream.o
+snd-firewire-motu-objs := motu.o amdtp-motu.o motu-transaction.o motu-stream.o \
+			  motu-proc.o
 obj-$(CONFIG_SND_FIREWIRE_MOTU) += snd-firewire-motu.o
diff --git a/sound/firewire/motu/motu-proc.c b/sound/firewire/motu/motu-proc.c
new file mode 100644
index 0000000..4edc064
--- /dev/null
+++ b/sound/firewire/motu/motu-proc.c
@@ -0,0 +1,118 @@
+/*
+ * motu-proc.c - a part of driver for MOTU FireWire series
+ *
+ * Copyright (c) 2015-2017 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "./motu.h"
+
+static const char *const clock_names[] = {
+	[SND_MOTU_CLOCK_SOURCE_INTERNAL] = "Internal",
+	[SND_MOTU_CLOCK_SOURCE_ADAT_ON_DSUB] = "ADAT on Dsub-9pin interface",
+	[SND_MOTU_CLOCK_SOURCE_ADAT_ON_OPT] = "ADAT on optical interface",
+	[SND_MOTU_CLOCK_SOURCE_ADAT_ON_OPT_A] = "ADAT on optical interface A",
+	[SND_MOTU_CLOCK_SOURCE_ADAT_ON_OPT_B] = "ADAT on optical interface B",
+	[SND_MOTU_CLOCK_SOURCE_SPDIF_ON_OPT] = "S/PDIF on optical interface",
+	[SND_MOTU_CLOCK_SOURCE_SPDIF_ON_OPT_A] = "S/PDIF on optical interface A",
+	[SND_MOTU_CLOCK_SOURCE_SPDIF_ON_OPT_B] = "S/PDIF on optical interface B",
+	[SND_MOTU_CLOCK_SOURCE_SPDIF_ON_COAX] = "S/PCIF on coaxial interface",
+	[SND_MOTU_CLOCK_SOURCE_AESEBU_ON_XLR] = "AESEBU on XLR interface",
+	[SND_MOTU_CLOCK_SOURCE_WORD_ON_BNC] = "Word clock on BNC interface",
+};
+
+static void proc_read_clock(struct snd_info_entry *entry,
+			    struct snd_info_buffer *buffer)
+{
+
+	struct snd_motu *motu = entry->private_data;
+	const struct snd_motu_protocol *const protocol = motu->spec->protocol;
+	unsigned int rate;
+	enum snd_motu_clock_source source;
+
+	if (protocol->get_clock_rate(motu, &rate) < 0)
+		return;
+	if (protocol->get_clock_source(motu, &source) < 0)
+		return;
+
+	snd_iprintf(buffer, "Rate:\t%d\n", rate);
+	snd_iprintf(buffer, "Source:\t%s\n", clock_names[source]);
+}
+
+static void proc_read_format(struct snd_info_entry *entry,
+			     struct snd_info_buffer *buffer)
+{
+	struct snd_motu *motu = entry->private_data;
+	const struct snd_motu_protocol *const protocol = motu->spec->protocol;
+	unsigned int mode;
+	struct snd_motu_packet_format *formats;
+	int i;
+
+	if (protocol->cache_packet_formats(motu) < 0)
+		return;
+
+	snd_iprintf(buffer, "tx:\tmsg\tfixed\tdiffered\n");
+	for (i = 0; i < SND_MOTU_CLOCK_RATE_COUNT; ++i) {
+		mode = i >> 1;
+
+		formats = &motu->tx_packet_formats;
+		snd_iprintf(buffer,
+			    "%u:\t%u\t%u\t%u\n",
+			    snd_motu_clock_rates[i],
+			    formats->msg_chunks,
+			    formats->fixed_part_pcm_chunks[mode],
+			    formats->differed_part_pcm_chunks[mode]);
+	}
+
+	snd_iprintf(buffer, "rx:\tmsg\tfixed\tdiffered\n");
+	for (i = 0; i < SND_MOTU_CLOCK_RATE_COUNT; ++i) {
+		mode = i >> 1;
+
+		formats = &motu->rx_packet_formats;
+		snd_iprintf(buffer,
+			    "%u:\t%u\t%u\t%u\n",
+			    snd_motu_clock_rates[i],
+			    formats->msg_chunks,
+			    formats->fixed_part_pcm_chunks[mode],
+			    formats->differed_part_pcm_chunks[mode]);
+	}
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
+	add_node(motu, root, "format", proc_read_format);
+}
diff --git a/sound/firewire/motu/motu.c b/sound/firewire/motu/motu.c
index 9d52238..cbf4ed0 100644
--- a/sound/firewire/motu/motu.c
+++ b/sound/firewire/motu/motu.c
@@ -97,6 +97,8 @@ static void do_registration(struct work_struct *work)
 	if (err < 0)
 		goto error;
 
+	snd_motu_proc_init(motu);
+
 	err = snd_card_register(motu->card);
 	if (err < 0)
 		goto error;
diff --git a/sound/firewire/motu/motu.h b/sound/firewire/motu/motu.h
index 90d2741..4d079d6 100644
--- a/sound/firewire/motu/motu.h
+++ b/sound/firewire/motu/motu.h
@@ -20,6 +20,7 @@
 #include <sound/control.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
+#include <sound/info.h>
 
 #include "../lib.h"
 #include "../amdtp-stream.h"
@@ -128,4 +129,6 @@ int snd_motu_stream_init_duplex(struct snd_motu *motu);
 void snd_motu_stream_destroy_duplex(struct snd_motu *motu);
 int snd_motu_stream_start_duplex(struct snd_motu *motu, unsigned int rate);
 void snd_motu_stream_stop_duplex(struct snd_motu *motu);
+
+void snd_motu_proc_init(struct snd_motu *motu);
 #endif
-- 
2.9.3
