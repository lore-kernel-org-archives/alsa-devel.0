From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 11/25] ALSA: firewire-digi00x: add proc node to
	show clock status
Date: Thu, 13 Aug 2015 09:20:07 +0900
Message-ID: <1439425221-30826-12-git-send-email-o-takashi@sakamocchi.jp>
References: <1439425221-30826-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id BB224261569
 for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2015 02:20:36 +0200 (CEST)
In-Reply-To: <1439425221-30826-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, Robin Gareus <robin@gareus.org>, Damien Zammit <damien@zamaudio.com>, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

This commit adds proc node to show current clock status for debugging.

As long as testing Digi 002 rack, registers can show local clock rate,
local clock source. When external clock input such as S/PDIF is
connected, the registers show detection and external clock rate.

Additionally, the registers show the mode of optical digital input
interface. On the other hand, a tester with Digi 003 rack reports
this makes no sence. Further investigation is required.

Besides, in Digi 002 rack, the S/PDIF format must be IEC 60958-4,
so-called professional.

Cc: Damien Zammit <damien@zamaudio.com>
Cc: Robin Gareus <robin@gareus.org>
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/digi00x/Makefile       |  3 +-
 sound/firewire/digi00x/digi00x-proc.c | 99 +++++++++++++++++++++++++++++++++++
 sound/firewire/digi00x/digi00x.c      |  2 +
 sound/firewire/digi00x/digi00x.h      |  2 +
 4 files changed, 105 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/digi00x/digi00x-proc.c

diff --git a/sound/firewire/digi00x/Makefile b/sound/firewire/digi00x/Makefile
index b7c783d..6c9bc37 100644
--- a/sound/firewire/digi00x/Makefile
+++ b/sound/firewire/digi00x/Makefile
@@ -1,2 +1,3 @@
-snd-firewire-digi00x-objs := amdtp-dot.o digi00x-stream.o digi00x.o
+snd-firewire-digi00x-objs := amdtp-dot.o digi00x-stream.o digi00x-proc.o \
+			     digi00x.o
 obj-m += snd-firewire-digi00x.o
diff --git a/sound/firewire/digi00x/digi00x-proc.c b/sound/firewire/digi00x/digi00x-proc.c
new file mode 100644
index 0000000..280d621
--- /dev/null
+++ b/sound/firewire/digi00x/digi00x-proc.c
@@ -0,0 +1,99 @@
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
+	enum snd_dg00x_optical_mode mode;
+	unsigned int rate;
+	enum snd_dg00x_clock clock;
+	bool detect;
+
+	if (get_optical_iface_mode(dg00x, &mode) < 0)
+		return;
+	if (snd_dg00x_stream_get_local_rate(dg00x, &rate) < 0)
+		return;
+	if (snd_dg00x_stream_get_clock(dg00x, &clock) < 0)
+		return;
+
+	snd_iprintf(buf, "Optical mode: %s\n", optical_name[mode]);
+	snd_iprintf(buf, "Sampling Rate: %d\n", rate);
+	snd_iprintf(buf, "Clock Source: %s\n", source_name[clock]);
+
+	if (clock == SND_DG00X_CLOCK_INTERNAL)
+		return;
+
+	if (snd_dg00x_stream_check_external_clock(dg00x, &detect) < 0)
+		return;
+	snd_iprintf(buf, "External source: %s\n", detect ? "detected" : "not");
+	if (!detect)
+		return;
+
+	if (snd_dg00x_stream_get_external_rate(dg00x, &rate) >= 0)
+		snd_iprintf(buf, "External sampling rate: %d\n", rate);
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
index 2c517ec..130f569 100644
--- a/sound/firewire/digi00x/digi00x.c
+++ b/sound/firewire/digi00x/digi00x.c
@@ -83,6 +83,8 @@ static int snd_dg00x_probe(struct fw_unit *unit,
 	if (err < 0)
 		goto error;
 
+	snd_dg00x_proc_init(dg00x);
+
 	err = snd_card_register(card);
 	if (err < 0)
 		goto error;
diff --git a/sound/firewire/digi00x/digi00x.h b/sound/firewire/digi00x/digi00x.h
index f4ce90e..e8eadc9 100644
--- a/sound/firewire/digi00x/digi00x.h
+++ b/sound/firewire/digi00x/digi00x.h
@@ -19,6 +19,7 @@
 
 #include <sound/core.h>
 #include <sound/initval.h>
+#include <sound/info.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/rawmidi.h>
@@ -121,4 +122,5 @@ void snd_dg00x_stream_stop_duplex(struct snd_dg00x *dg00x);
 void snd_dg00x_stream_update_duplex(struct snd_dg00x *dg00x);
 void snd_dg00x_stream_destroy_duplex(struct snd_dg00x *dg00x);
 
+void snd_dg00x_proc_init(struct snd_dg00x *dg00x);
 #endif
-- 
2.1.4
