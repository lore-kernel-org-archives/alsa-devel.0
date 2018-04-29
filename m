From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH v2 07/13] ALSA: dice: use extended protocol to
	detect available stream formats
Date: Sun, 29 Apr 2018 15:50:26 +0900
Message-ID: <20180429065032.13869-8-o-takashi@sakamocchi.jp>
References: <20180429065032.13869-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f194.google.com (mail-pf0-f194.google.com
 [209.85.192.194])
 by alsa0.perex.cz (Postfix) with ESMTP id D98EA267621
 for <alsa-devel@alsa-project.org>; Sun, 29 Apr 2018 08:51:16 +0200 (CEST)
Received: by mail-pf0-f194.google.com with SMTP id j5so4452903pfh.2
 for <alsa-devel@alsa-project.org>; Sat, 28 Apr 2018 23:51:16 -0700 (PDT)
In-Reply-To: <20180429065032.13869-1-o-takashi@sakamocchi.jp>
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

TC Applied Technologies (TCAT) have added extension to DICE protocol. This
protocol extension is called as Extended Application Protocol, a.k.a. EAP.

In this protocol extension, units get additional 9 address spaces. One of
it is for current configuration. In this address space, a pair of router
and stream formats are exposed per mode of three sampling transmission
frequencies.

This commit adds support the protocol extension for address space of the
current configuration to generate cache of stream formats.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/Makefile         |   2 +-
 sound/firewire/dice/dice-extension.c | 172 +++++++++++++++++++++++++++++++++++
 sound/firewire/dice/dice-stream.c    |   5 +
 sound/firewire/dice/dice.c           |  18 +++-
 sound/firewire/dice/dice.h           |   1 +
 5 files changed, 193 insertions(+), 5 deletions(-)
 create mode 100644 sound/firewire/dice/dice-extension.c

diff --git a/sound/firewire/dice/Makefile b/sound/firewire/dice/Makefile
index 5cfe618f45ef..7b7997a5754c 100644
--- a/sound/firewire/dice/Makefile
+++ b/sound/firewire/dice/Makefile
@@ -1,4 +1,4 @@
 snd-dice-objs := dice-transaction.o dice-stream.o dice-proc.o dice-midi.o \
 		 dice-pcm.o dice-hwdep.o dice.o dice-tcelectronic.o \
-		 dice-alesis.o
+		 dice-alesis.o dice-extension.o
 obj-$(CONFIG_SND_DICE) += snd-dice.o
diff --git a/sound/firewire/dice/dice-extension.c b/sound/firewire/dice/dice-extension.c
new file mode 100644
index 000000000000..afda705cf722
--- /dev/null
+++ b/sound/firewire/dice/dice-extension.c
@@ -0,0 +1,172 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * dice-extension.c - a part of driver for DICE based devices
+ *
+ * Copyright (c) 2018 Takashi Sakamoto
+ */
+
+#include "dice.h"
+
+/* For TCD2210/2220, TCAT defines extension of application protocol. */
+
+#define DICE_EXT_APP_SPACE		0xffffe0200000uLL
+
+#define DICE_EXT_APP_CAPS_OFFSET	0x00
+#define DICE_EXT_APP_CAPS_SIZE		0x04
+#define DICE_EXT_APP_CMD_OFFSET		0x08
+#define DICE_EXT_APP_CMD_SIZE		0x0c
+#define DICE_EXT_APP_MIXER_OFFSET	0x10
+#define DICE_EXT_APP_MIXER_SIZE		0x14
+#define DICE_EXT_APP_PEAK_OFFSET	0x18
+#define DICE_EXT_APP_PEAK_SIZE		0x1c
+#define DICE_EXT_APP_ROUTER_OFFSET	0x20
+#define DICE_EXT_APP_ROUTER_SIZE	0x24
+#define DICE_EXT_APP_STREAM_OFFSET	0x28
+#define DICE_EXT_APP_STREAM_SIZE	0x2c
+#define DICE_EXT_APP_CURRENT_OFFSET	0x30
+#define DICE_EXT_APP_CURRENT_SIZE	0x34
+#define DICE_EXT_APP_STANDALONE_OFFSET	0x38
+#define DICE_EXT_APP_STANDALONE_SIZE	0x3c
+#define DICE_EXT_APP_APPLICATION_OFFSET	0x40
+#define DICE_EXT_APP_APPLICATION_SIZE	0x44
+
+#define EXT_APP_STREAM_TX_NUMBER	0x0000
+#define EXT_APP_STREAM_RX_NUMBER	0x0004
+#define EXT_APP_STREAM_ENTRIES		0x0008
+#define EXT_APP_STREAM_ENTRY_SIZE	0x010c
+#define  EXT_APP_NUMBER_AUDIO		0x0000
+#define  EXT_APP_NUMBER_MIDI		0x0004
+#define  EXT_APP_NAMES			0x0008
+#define   EXT_APP_NAMES_SIZE		256
+#define  EXT_APP_AC3			0x0108
+
+#define EXT_APP_CONFIG_LOW_ROUTER	0x0000
+#define EXT_APP_CONFIG_LOW_STREAM	0x1000
+#define EXT_APP_CONFIG_MIDDLE_ROUTER	0x2000
+#define EXT_APP_CONFIG_MIDDLE_STREAM	0x3000
+#define EXT_APP_CONFIG_HIGH_ROUTER	0x4000
+#define EXT_APP_CONFIG_HIGH_STREAM	0x5000
+
+static inline int read_transaction(struct snd_dice *dice, u64 section_addr,
+				   u32 offset, void *buf, size_t len)
+{
+	return snd_fw_transaction(dice->unit,
+				  len == 4 ? TCODE_READ_QUADLET_REQUEST :
+					     TCODE_READ_BLOCK_REQUEST,
+				  section_addr + offset, buf, len, 0);
+}
+
+static int read_stream_entries(struct snd_dice *dice, u64 section_addr,
+			       u32 base_offset, unsigned int stream_count,
+			       unsigned int mode,
+			       unsigned int pcm_channels[MAX_STREAMS][3],
+			       unsigned int midi_ports[MAX_STREAMS])
+{
+	u32 entry_offset;
+	__be32 reg[2];
+	int err;
+	int i;
+
+	for (i = 0; i < stream_count; ++i) {
+		entry_offset = base_offset + i * EXT_APP_STREAM_ENTRY_SIZE;
+		err = read_transaction(dice, section_addr,
+				    entry_offset + EXT_APP_NUMBER_AUDIO,
+				    reg, sizeof(reg));
+		if (err < 0)
+			return err;
+		pcm_channels[i][mode] = be32_to_cpu(reg[0]);
+		midi_ports[i] = max(midi_ports[i], be32_to_cpu(reg[1]));
+	}
+
+	return 0;
+}
+
+static int detect_stream_formats(struct snd_dice *dice, u64 section_addr)
+{
+	u32 base_offset;
+	__be32 reg[2];
+	unsigned int stream_count;
+	int mode;
+	int err = 0;
+
+	for (mode = 0; mode < 3; ++mode) {
+		unsigned int cap;
+
+		/*
+		 * Some models report stream formats at highest mode, however
+		 * they don't support the mode. Check clock capabilities.
+		 */
+		if (mode == 2) {
+			cap = CLOCK_CAP_RATE_176400 | CLOCK_CAP_RATE_192000;
+		} else if (mode == 1) {
+			cap = CLOCK_CAP_RATE_88200 | CLOCK_CAP_RATE_96000;
+		} else {
+			cap = CLOCK_CAP_RATE_32000 | CLOCK_CAP_RATE_44100 |
+			      CLOCK_CAP_RATE_48000;
+		}
+		if (!(cap & dice->clock_caps))
+			continue;
+
+		base_offset = 0x2000 * mode + 0x1000;
+
+		err = read_transaction(dice, section_addr,
+				       base_offset + EXT_APP_STREAM_TX_NUMBER,
+				       &reg, sizeof(reg));
+		if (err < 0)
+			break;
+
+		base_offset += EXT_APP_STREAM_ENTRIES;
+		stream_count = be32_to_cpu(reg[0]);
+		err = read_stream_entries(dice, section_addr, base_offset,
+					  stream_count, mode,
+					  dice->tx_pcm_chs,
+					  dice->tx_midi_ports);
+		if (err < 0)
+			break;
+
+		base_offset += stream_count * EXT_APP_STREAM_ENTRY_SIZE;
+		stream_count = be32_to_cpu(reg[1]);
+		err = read_stream_entries(dice, section_addr, base_offset,
+					  stream_count,
+					  mode, dice->rx_pcm_chs,
+					  dice->rx_midi_ports);
+		if (err < 0)
+			break;
+	}
+
+	return err;
+}
+
+int snd_dice_detect_extension_formats(struct snd_dice *dice)
+{
+	__be32 *pointers;
+	unsigned int i;
+	u64 section_addr;
+	int err;
+
+	pointers = kmalloc_array(9, sizeof(__be32) * 2, GFP_KERNEL);
+	if (pointers == NULL)
+		return -ENOMEM;
+
+	err = snd_fw_transaction(dice->unit, TCODE_READ_BLOCK_REQUEST,
+				 DICE_EXT_APP_SPACE, pointers,
+				 9 * sizeof(__be32) * 2, 0);
+	if (err < 0)
+		goto end;
+
+	/* Check two of them for offset have the same value or not. */
+	for (i = 0; i < 9; ++i) {
+		int j;
+
+		for (j = i + 1; j < 9; ++j) {
+			if (pointers[i * 2] == pointers[j * 2])
+				goto end;
+		}
+	}
+
+	section_addr = DICE_EXT_APP_SPACE + be32_to_cpu(pointers[12]) * 4;
+	err = detect_stream_formats(dice, section_addr);
+end:
+	kfree(pointers);
+	return err;
+}
diff --git a/sound/firewire/dice/dice-stream.c b/sound/firewire/dice/dice-stream.c
index 2a9f0cd994a5..da0607832456 100644
--- a/sound/firewire/dice/dice-stream.c
+++ b/sound/firewire/dice/dice-stream.c
@@ -511,6 +511,11 @@ int snd_dice_stream_detect_current_formats(struct snd_dice *dice)
 	int i;
 	int err;
 
+	/* If extended protocol is available, detect detail spec. */
+	err = snd_dice_detect_extension_formats(dice);
+	if (err >= 0)
+		return err;
+
 	/*
 	 * Available stream format is restricted at current mode of sampling
 	 * clock.
diff --git a/sound/firewire/dice/dice.c b/sound/firewire/dice/dice.c
index cbd1a07e70b9..6d55a62ec89e 100644
--- a/sound/firewire/dice/dice.c
+++ b/sound/firewire/dice/dice.c
@@ -16,6 +16,7 @@ MODULE_LICENSE("GPL v2");
 #define OUI_FOCUSRITE		0x00130e
 #define OUI_TCELECTRONIC	0x000166
 #define OUI_ALESIS		0x000595
+#define OUI_MAUDIO		0x000d6c
 
 #define DICE_CATEGORY_ID	0x04
 #define WEISS_CATEGORY_ID	0x00
@@ -330,12 +331,21 @@ static void dice_bus_reset(struct fw_unit *unit)
 #define DICE_INTERFACE	0x000001
 
 static const struct ieee1394_device_id dice_id_table[] = {
-	/* M-Audio Profire 610/2626 has a different value in version field. */
+	/* M-Audio Profire 2626 has a different value in version field. */
 	{
 		.match_flags	= IEEE1394_MATCH_VENDOR_ID |
-				  IEEE1394_MATCH_SPECIFIER_ID,
-		.vendor_id	= 0x000d6c,
-		.specifier_id	= 0x000d6c,
+				  IEEE1394_MATCH_MODEL_ID,
+		.vendor_id	= OUI_MAUDIO,
+		.model_id	= 0x000010,
+		.driver_data = (kernel_ulong_t)snd_dice_detect_extension_formats,
+	},
+	/* M-Audio Profire 610 has a different value in version field. */
+	{
+		.match_flags	= IEEE1394_MATCH_VENDOR_ID |
+				  IEEE1394_MATCH_MODEL_ID,
+		.vendor_id	= OUI_MAUDIO,
+		.model_id	= 0x000011,
+		.driver_data = (kernel_ulong_t)snd_dice_detect_extension_formats,
 	},
 	/* TC Electronic Konnekt 24D. */
 	{
diff --git a/sound/firewire/dice/dice.h b/sound/firewire/dice/dice.h
index bb89dad5f127..7b1e2396eadc 100644
--- a/sound/firewire/dice/dice.h
+++ b/sound/firewire/dice/dice.h
@@ -220,5 +220,6 @@ int snd_dice_create_midi(struct snd_dice *dice);
 
 int snd_dice_detect_tcelectronic_formats(struct snd_dice *dice);
 int snd_dice_detect_alesis_formats(struct snd_dice *dice);
+int snd_dice_detect_extension_formats(struct snd_dice *dice);
 
 #endif
-- 
2.14.1
