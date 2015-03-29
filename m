From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 03/11] ALSA: digi00x: add proc node for clock
	status
Date: Mon, 30 Mar 2015 00:05:23 +0900
Message-ID: <1427641531-9047-4-git-send-email-o-takashi@sakamocchi.jp>
References: <1427641531-9047-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A72726049A
 for <alsa-devel@alsa-project.org>; Sun, 29 Mar 2015 17:05:43 +0200 (CEST)
In-Reply-To: <1427641531-9047-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: damien@zamaudio.com, robin@gareus.org, alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

This commit adds proc node to check current clock status for debugging.

The devices seem to be able to synchronize external clock source such
as S/PDIF, ADAT or word-clock. But even if setting the registers
related to clock source as one of externals, the device can work
without plug-in these sources actually.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/digi00x/Makefile       |  2 +-
 sound/firewire/digi00x/digi00x-proc.c | 86 +++++++++++++++++++++++++++++++++++
 sound/firewire/digi00x/digi00x.c      |  2 +
 sound/firewire/digi00x/digi00x.h      |  2 +
 4 files changed, 91 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/digi00x/digi00x-proc.c

diff --git a/sound/firewire/digi00x/Makefile b/sound/firewire/digi00x/Makefile
index fe8fceb..aaec823 100644
--- a/sound/firewire/digi00x/Makefile
+++ b/sound/firewire/digi00x/Makefile
@@ -1,2 +1,2 @@
-snd-digi00x-objs := digi00x.o digi00x-stream.o
+snd-digi00x-objs := digi00x.o digi00x-stream.o digi00x-proc.o
 obj-m += snd-digi00x.o
diff --git a/sound/firewire/digi00x/digi00x-proc.c b/sound/firewire/digi00x/digi00x-proc.c
new file mode 100644
index 0000000..0b14768
--- /dev/null
+++ b/sound/firewire/digi00x/digi00x-proc.c
@@ -0,0 +1,86 @@
+/*
+ * digi00x-proc.c - a part of driver for Digidesign Digi 002/003 family
+ *
+ * Copyright (c) 2014-2015 Takashi Sakamoto
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "./digi00x.h"
+
+static int get_optical_iface_mode(struct snd_dg00x *dg00x,
+				  enum snd_dg00x_optical_mode *mode)
+{
+	__be32 data;
+	int err;
+
+	err = snd_fw_transaction(dg00x->unit, TCODE_READ_QUADLET_REQUEST,
+				 DG00X_ADDR_BASE + DG00X_OFFSET_OPT_IFACE_MODE,
+				 &data, sizeof(data), 0);
+	if (err >= 0)
+		*mode = be32_to_cpu(data) & 0x01;
+
+	return err;
+}
+
+static void proc_read_clock(struct snd_info_entry *entry,
+			    struct snd_info_buffer *buf)
+{
+	static const char *const source_name[] = {
+		[SND_DG00X_CLOCK_INTERNAL] = "internal",
+		[SND_DG00X_CLOCK_SPDIF] = "s/pdif",
+		[SND_DG00X_CLOCK_ADAT] = "adat",
+		[SND_DG00X_CLOCK_WORD] = "word clock",
+	};
+	static const char *const optical_name[] = {
+		[SND_DG00X_OPT_IFACE_MODE_ADAT] = "adat",
+		[SND_DG00X_OPT_IFACE_MODE_SPDIF] = "s/pdif",
+	};
+	struct snd_dg00x *dg00x = entry->private_data;
+	unsigned int rate;
+	enum snd_dg00x_clock clock;
+	enum snd_dg00x_optical_mode mode;
+
+	if (snd_dg00x_stream_get_rate(dg00x, &rate) < 0)
+		return;
+	if (snd_dg00x_stream_get_clock(dg00x, &clock) < 0)
+		return;
+	if (get_optical_iface_mode(dg00x, &mode) < 0)
+		return;
+
+	snd_iprintf(buf, "Sampling Rate: %d\n", rate);
+	snd_iprintf(buf, "Clock Source: %s\n", source_name[clock]);
+	snd_iprintf(buf, "Optical mode: %s\n", optical_name[mode]);
+}
+
+void snd_dg00x_proc_init(struct snd_dg00x *dg00x)
+{
+	struct snd_info_entry *root, *entry;
+
+	/*
+	 * All nodes are automatically removed at snd_card_disconnect(),
+	 * by following to link list.
+	 */
+	root = snd_info_create_card_entry(dg00x->card, "firewire",
+					  dg00x->card->proc_root);
+	if (root == NULL)
+		return;
+
+	root->mode = S_IFDIR | S_IRUGO | S_IXUGO;
+	if (snd_info_register(root) < 0) {
+		snd_info_free_entry(root);
+		return;
+	}
+
+	entry = snd_info_create_card_entry(dg00x->card, "clock", root);
+	if (entry == NULL) {
+		snd_info_free_entry(root);
+		return;
+	}
+
+	snd_info_set_text_ops(entry, dg00x, proc_read_clock);
+	if (snd_info_register(entry) < 0) {
+		snd_info_free_entry(entry);
+		snd_info_free_entry(root);
+	}
+}
diff --git a/sound/firewire/digi00x/digi00x.c b/sound/firewire/digi00x/digi00x.c
index b82bce7..d9c9e14 100644
--- a/sound/firewire/digi00x/digi00x.c
+++ b/sound/firewire/digi00x/digi00x.c
@@ -84,6 +84,8 @@ static int snd_dg00x_probe(struct fw_unit *unit,
 	if (err < 0)
 		goto error;
 
+	snd_dg00x_proc_init(dg00x);
+
 	err = snd_card_register(card);
 	if (err < 0)
 		goto error;
diff --git a/sound/firewire/digi00x/digi00x.h b/sound/firewire/digi00x/digi00x.h
index 2e960c7..a16a535 100644
--- a/sound/firewire/digi00x/digi00x.h
+++ b/sound/firewire/digi00x/digi00x.h
@@ -20,6 +20,7 @@
 
 #include <sound/core.h>
 #include <sound/initval.h>
+#include <sound/info.h>
 
 #include "../lib.h"
 #include "../packets-buffer.h"
@@ -105,4 +106,5 @@ void snd_dg00x_stream_stop_duplex(struct snd_dg00x *dg00x);
 void snd_dg00x_stream_update_duplex(struct snd_dg00x *dg00x);
 void snd_dg00x_stream_destroy_duplex(struct snd_dg00x *dg00x);
 
+void snd_dg00x_proc_init(struct snd_dg00x *dg00x);
 #endif
-- 
2.1.0
