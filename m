From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 09/11] ALSA: dice: add parameters of stream
	formats for models produced by Alesis
Date: Wed, 25 Apr 2018 08:42:32 +0900
Message-ID: <20180424234234.6063-10-o-takashi@sakamocchi.jp>
References: <20180424234234.6063-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f196.google.com (mail-pf0-f196.google.com
 [209.85.192.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 939DA267704
 for <alsa-devel@alsa-project.org>; Wed, 25 Apr 2018 01:43:28 +0200 (CEST)
Received: by mail-pf0-f196.google.com with SMTP id o76so8856956pfi.5
 for <alsa-devel@alsa-project.org>; Tue, 24 Apr 2018 16:43:28 -0700 (PDT)
In-Reply-To: <20180424234234.6063-1-o-takashi@sakamocchi.jp>
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

Alesis shipped some models with DICE ASICs. All of them just support
DICE original protocol and drivers can't retrieve all of available stream
formats without changing status of sampling transmission frequency
actually.

This commit puts some hard-coded parameters for the models. When detecting
the models, the corresponding parameters are copied as cache of stream
formats.

I note that each of pair of iO14/iO26 and MultiMix 8/12/16 has the same
model ID on their configuration ROM. The MultiMix 8/12/16 just support
one mode for sampling transmission frequency and ALSA dice driver already
handles them correctly. The iO14/iO26 support three modes and need
hard-coded parameters. To distinguish these two models, this commit let
the driver to retrieve current stream formats and compare it to known
parameters, then decide it.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/Makefile      |  3 ++-
 sound/firewire/dice/dice-alesis.c | 48 +++++++++++++++++++++++++++++++++++++++
 sound/firewire/dice/dice.c        | 11 +++++++++
 sound/firewire/dice/dice.h        |  1 +
 4 files changed, 62 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/dice/dice-alesis.c

diff --git a/sound/firewire/dice/Makefile b/sound/firewire/dice/Makefile
index 5ffaa366a88c..5cfe618f45ef 100644
--- a/sound/firewire/dice/Makefile
+++ b/sound/firewire/dice/Makefile
@@ -1,3 +1,4 @@
 snd-dice-objs := dice-transaction.o dice-stream.o dice-proc.o dice-midi.o \
-		 dice-pcm.o dice-hwdep.o dice.o dice-tcelectronic.o
+		 dice-pcm.o dice-hwdep.o dice.o dice-tcelectronic.o \
+		 dice-alesis.o
 obj-$(CONFIG_SND_DICE) += snd-dice.o
diff --git a/sound/firewire/dice/dice-alesis.c b/sound/firewire/dice/dice-alesis.c
new file mode 100644
index 000000000000..b2b29c2b0a8d
--- /dev/null
+++ b/sound/firewire/dice/dice-alesis.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * dice-alesis.c - a part of driver for DICE based devices
+ *
+ * Copyright (c) 2018 Takashi Sakamoto
+ */
+
+#include "dice.h"
+
+static const unsigned int alesis_io14_tx_spec[MAX_STREAMS][3] = {
+	{6, 6, 4},	/* Tx0 = Analog + S/PDIF. */
+	{8, 4, 0},	/* Tx1 = ADAT1. */
+};
+
+static const unsigned int alesis_io26_tx_spec[MAX_STREAMS][3] = {
+	{10, 10, 8},	/* Tx0 = Analog + S/PDIF. */
+	{16, 8, 0},	/* Tx1 = ADAT1 + ADAT2. */
+};
+
+int snd_dice_detect_alesis_spec(struct snd_dice *dice)
+{
+	__be32 reg;
+	u32 data;
+	int i;
+	int err;
+
+	err = snd_dice_transaction_read_tx(dice, TX_NUMBER_AUDIO, &reg,
+					   sizeof(reg));
+	if (err < 0)
+		return err;
+	data = be32_to_cpu(reg);
+
+	if (data == 4 || data == 6) {
+		memcpy(dice->tx_channels, alesis_io14_tx_spec,
+		       MAX_STREAMS * 3 * sizeof(unsigned int));
+	} else {
+		memcpy(dice->tx_channels, alesis_io26_tx_spec,
+		       MAX_STREAMS * 3 * sizeof(unsigned int));
+	}
+
+	for (i = 0; i < 3; ++i)
+		dice->rx_channels[0][i] = 8;
+
+	dice->tx_midi_ports[0] = 1;
+	dice->rx_midi_ports[0] = 1;
+
+	return 0;
+}
diff --git a/sound/firewire/dice/dice.c b/sound/firewire/dice/dice.c
index 4530370b1f8c..dce0d7a33649 100644
--- a/sound/firewire/dice/dice.c
+++ b/sound/firewire/dice/dice.c
@@ -15,11 +15,14 @@ MODULE_LICENSE("GPL v2");
 #define OUI_LOUD		0x000ff2
 #define OUI_FOCUSRITE		0x00130e
 #define OUI_TCELECTRONIC	0x000166
+#define OUI_ALESIS		0x000595
 
 #define DICE_CATEGORY_ID	0x04
 #define WEISS_CATEGORY_ID	0x00
 #define LOUD_CATEGORY_ID	0x10
 
+#define MODEL_ALESIS_IO_BOTH	0x000001
+
 /*
  * Some models support several isochronous channels, while these streams are not
  * always available. In this case, add the model name to this list.
@@ -380,6 +383,14 @@ static const struct ieee1394_device_id dice_id_table[] = {
 		.model_id	= 0x000027,
 		.driver_data = (kernel_ulong_t)snd_dice_detect_tcelectronic_spec,
 	},
+	/* Alesis iO14/iO26. */
+	{
+		.match_flags	= IEEE1394_MATCH_VENDOR_ID |
+				  IEEE1394_MATCH_MODEL_ID,
+		.vendor_id	= OUI_ALESIS,
+		.model_id	= MODEL_ALESIS_IO_BOTH,
+		.driver_data = (kernel_ulong_t)snd_dice_detect_alesis_spec,
+	},
 	{
 		.match_flags = IEEE1394_MATCH_VERSION,
 		.version     = DICE_INTERFACE,
diff --git a/sound/firewire/dice/dice.h b/sound/firewire/dice/dice.h
index 31d46ea53a31..cbb766e17a99 100644
--- a/sound/firewire/dice/dice.h
+++ b/sound/firewire/dice/dice.h
@@ -219,5 +219,6 @@ void snd_dice_create_proc(struct snd_dice *dice);
 int snd_dice_create_midi(struct snd_dice *dice);
 
 int snd_dice_detect_tcelectronic_spec(struct snd_dice *dice);
+int snd_dice_detect_alesis_spec(struct snd_dice *dice);
 
 #endif
-- 
2.14.1
