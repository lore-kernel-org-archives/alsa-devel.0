From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/7] ALSA: firewire-tascam: add proc node to
	show firmware information
Date: Thu,  1 Oct 2015 22:02:13 +0900
Message-ID: <1443704537-3345-4-git-send-email-o-takashi@sakamocchi.jp>
References: <1443704537-3345-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A7D4266739
 for <alsa-devel@alsa-project.org>; Thu,  1 Oct 2015 15:02:23 +0200 (CEST)
In-Reply-To: <1443704537-3345-1-git-send-email-o-takashi@sakamocchi.jp>
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

TASCAM FireWire series has certain registers for firmware information.

This commit adds proc node to show the information.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/tascam/Makefile      |  2 +-
 sound/firewire/tascam/tascam-proc.c | 88 +++++++++++++++++++++++++++++++++++++
 sound/firewire/tascam/tascam.c      |  2 +
 sound/firewire/tascam/tascam.h      | 10 +++++
 4 files changed, 101 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/tascam/tascam-proc.c

diff --git a/sound/firewire/tascam/Makefile b/sound/firewire/tascam/Makefile
index 627129b..1555206 100644
--- a/sound/firewire/tascam/Makefile
+++ b/sound/firewire/tascam/Makefile
@@ -1,2 +1,2 @@
-snd-firewire-tascam-objs := tascam.o
+snd-firewire-tascam-objs := tascam-proc.o tascam.o
 obj-$(CONFIG_SND_FIREWIRE_TASCAM) += snd-firewire-tascam.o
diff --git a/sound/firewire/tascam/tascam-proc.c b/sound/firewire/tascam/tascam-proc.c
new file mode 100644
index 0000000..bfd4a4c
--- /dev/null
+++ b/sound/firewire/tascam/tascam-proc.c
@@ -0,0 +1,88 @@
+/*
+ * tascam-proc.h - a part of driver for TASCAM FireWire series
+ *
+ * Copyright (c) 2015 Takashi Sakamoto
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "./tascam.h"
+
+static void proc_read_firmware(struct snd_info_entry *entry,
+			       struct snd_info_buffer *buffer)
+{
+	struct snd_tscm *tscm = entry->private_data;
+	__be32 data;
+	unsigned int reg, fpga, arm, hw;
+	int err;
+
+	err = snd_fw_transaction(tscm->unit, TCODE_READ_QUADLET_REQUEST,
+			TSCM_ADDR_BASE + TSCM_OFFSET_FIRMWARE_REGISTER,
+			&data, sizeof(data), 0);
+	if (err < 0)
+		return;
+	reg = be32_to_cpu(data);
+
+	err = snd_fw_transaction(tscm->unit, TCODE_READ_QUADLET_REQUEST,
+			TSCM_ADDR_BASE + TSCM_OFFSET_FIRMWARE_FPGA,
+			&data, sizeof(data), 0);
+	if (err < 0)
+		return;
+	fpga = be32_to_cpu(data);
+
+	err = snd_fw_transaction(tscm->unit, TCODE_READ_QUADLET_REQUEST,
+			TSCM_ADDR_BASE + TSCM_OFFSET_FIRMWARE_ARM,
+			&data, sizeof(data), 0);
+	if (err < 0)
+		return;
+	arm = be32_to_cpu(data);
+
+	err = snd_fw_transaction(tscm->unit, TCODE_READ_QUADLET_REQUEST,
+			TSCM_ADDR_BASE + TSCM_OFFSET_FIRMWARE_HW,
+			&data, sizeof(data), 0);
+	if (err < 0)
+		return;
+	hw = be32_to_cpu(data);
+
+	snd_iprintf(buffer, "Register: %d (0x%08x)\n", reg & 0xffff, reg);
+	snd_iprintf(buffer, "FPGA:     %d (0x%08x)\n", fpga & 0xffff, fpga);
+	snd_iprintf(buffer, "ARM:      %d (0x%08x)\n", arm & 0xffff, arm);
+	snd_iprintf(buffer, "Hardware: %d (0x%08x)\n", hw >> 16, hw);
+}
+
+static void add_node(struct snd_tscm *tscm, struct snd_info_entry *root,
+		     const char *name,
+		     void (*op)(struct snd_info_entry *e,
+				struct snd_info_buffer *b))
+{
+	struct snd_info_entry *entry;
+
+	entry = snd_info_create_card_entry(tscm->card, name, root);
+	if (entry == NULL)
+		return;
+
+	snd_info_set_text_ops(entry, tscm, op);
+	if (snd_info_register(entry) < 0)
+		snd_info_free_entry(entry);
+}
+
+void snd_tscm_proc_init(struct snd_tscm *tscm)
+{
+	struct snd_info_entry *root;
+
+	/*
+	 * All nodes are automatically removed at snd_card_disconnect(),
+	 * by following to link list.
+	 */
+	root = snd_info_create_card_entry(tscm->card, "firewire",
+					  tscm->card->proc_root);
+	if (root == NULL)
+		return;
+	root->mode = S_IFDIR | S_IRUGO | S_IXUGO;
+	if (snd_info_register(root) < 0) {
+		snd_info_free_entry(root);
+		return;
+	}
+
+	add_node(tscm, root, "firmware", proc_read_firmware);
+}
diff --git a/sound/firewire/tascam/tascam.c b/sound/firewire/tascam/tascam.c
index 9ac09cb..d7418c0 100644
--- a/sound/firewire/tascam/tascam.c
+++ b/sound/firewire/tascam/tascam.c
@@ -113,6 +113,8 @@ static int snd_tscm_probe(struct fw_unit *unit,
 	if (err < 0)
 		goto error;
 
+	snd_tscm_proc_init(tscm);
+
 	err = snd_card_register(card);
 	if (err < 0)
 		goto error;
diff --git a/sound/firewire/tascam/tascam.h b/sound/firewire/tascam/tascam.h
index e12f8b5..9ecc550 100644
--- a/sound/firewire/tascam/tascam.h
+++ b/sound/firewire/tascam/tascam.h
@@ -20,6 +20,7 @@
 
 #include <sound/core.h>
 #include <sound/initval.h>
+#include <sound/info.h>
 
 #include "../lib.h"
 
@@ -43,4 +44,13 @@ struct snd_tscm {
 	const struct snd_tscm_spec *spec;
 };
 
+#define TSCM_ADDR_BASE			0xffff00000000ull
+
+#define TSCM_OFFSET_FIRMWARE_REGISTER	0x0000
+#define TSCM_OFFSET_FIRMWARE_FPGA	0x0004
+#define TSCM_OFFSET_FIRMWARE_ARM	0x0008
+#define TSCM_OFFSET_FIRMWARE_HW		0x000c
+
+void snd_tscm_proc_init(struct snd_tscm *tscm);
+
 #endif
-- 
2.1.4
