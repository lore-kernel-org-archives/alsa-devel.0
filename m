From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH v3 05/13] ALSA: dice: add parameters of stream
	formats for models produced by TC Electronic
Date: Wed,  2 May 2018 19:16:43 +0900
Message-ID: <20180502101651.26173-6-o-takashi@sakamocchi.jp>
References: <20180502101651.26173-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f66.google.com (mail-pg0-f66.google.com [74.125.83.66])
 by alsa0.perex.cz (Postfix) with ESMTP id CB8AE2675DF
 for <alsa-devel@alsa-project.org>; Wed,  2 May 2018 12:17:32 +0200 (CEST)
Received: by mail-pg0-f66.google.com with SMTP id j11-v6so10302207pgf.2
 for <alsa-devel@alsa-project.org>; Wed, 02 May 2018 03:17:32 -0700 (PDT)
In-Reply-To: <20180502101651.26173-1-o-takashi@sakamocchi.jp>
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

TC Electronic shipped some models with DICE ASICs. All of them just support
DICE original protocol and drivers can't retrieve all of available stream
formats without changing status of sampling transmission frequency
actually.

This commit puts some hard-coded parameters for the models. When detecting
the models, the corresponding parameters are copied as cache of stream
formats.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/Makefile            |   2 +-
 sound/firewire/dice/dice-tcelectronic.c | 100 ++++++++++++++++++++++++++++++++
 sound/firewire/dice/dice.c              |  76 +++++++++++++++++++++---
 sound/firewire/dice/dice.h              |   6 ++
 4 files changed, 174 insertions(+), 10 deletions(-)
 create mode 100644 sound/firewire/dice/dice-tcelectronic.c

diff --git a/sound/firewire/dice/Makefile b/sound/firewire/dice/Makefile
index 55b4be9b0034..5ffaa366a88c 100644
--- a/sound/firewire/dice/Makefile
+++ b/sound/firewire/dice/Makefile
@@ -1,3 +1,3 @@
 snd-dice-objs := dice-transaction.o dice-stream.o dice-proc.o dice-midi.o \
-		 dice-pcm.o dice-hwdep.o dice.o
+		 dice-pcm.o dice-hwdep.o dice.o dice-tcelectronic.o
 obj-$(CONFIG_SND_DICE) += snd-dice.o
diff --git a/sound/firewire/dice/dice-tcelectronic.c b/sound/firewire/dice/dice-tcelectronic.c
new file mode 100644
index 000000000000..af8203b9d1a6
--- /dev/null
+++ b/sound/firewire/dice/dice-tcelectronic.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * dice-tc_electronic.c - a part of driver for DICE based devices
+ *
+ * Copyright (c) 2018 Takashi Sakamoto
+ */
+
+#include "dice.h"
+
+struct dice_tc_spec {
+	unsigned int tx_pcm_chs[MAX_STREAMS][SND_DICE_RATE_MODE_COUNT];
+	unsigned int rx_pcm_chs[MAX_STREAMS][SND_DICE_RATE_MODE_COUNT];
+	bool has_midi;
+};
+
+static const struct dice_tc_spec desktop_konnekt6 = {
+	.tx_pcm_chs = {{6, 6, 2}, {0, 0, 0} },
+	.rx_pcm_chs = {{6, 6, 4}, {0, 0, 0} },
+	.has_midi = false,
+};
+
+static const struct dice_tc_spec impact_twin = {
+	.tx_pcm_chs = {{14, 10, 6}, {0, 0, 0} },
+	.rx_pcm_chs = {{14, 10, 6}, {0, 0, 0} },
+	.has_midi = true,
+};
+
+static const struct dice_tc_spec konnekt_8 = {
+	.tx_pcm_chs = {{4, 4, 3}, {0, 0, 0} },
+	.rx_pcm_chs = {{4, 4, 3}, {0, 0, 0} },
+	.has_midi = true,
+};
+
+static const struct dice_tc_spec konnekt_24d = {
+	.tx_pcm_chs = {{16, 16, 6}, {0, 0, 0} },
+	.rx_pcm_chs = {{16, 16, 6}, {0, 0, 0} },
+	.has_midi = true,
+};
+
+static const struct dice_tc_spec konnekt_live = {
+	.tx_pcm_chs = {{16, 16, 16}, {0, 0, 0} },
+	.rx_pcm_chs = {{16, 16, 16}, {0, 0, 0} },
+	.has_midi = true,
+};
+
+static const struct dice_tc_spec studio_konnekt_48 = {
+	.tx_pcm_chs = {{16, 16, 16}, {16, 16, 0} },
+	.rx_pcm_chs = {{16, 16, 16}, {16, 16, 0} },
+	.has_midi = true,
+};
+
+int snd_dice_detect_tcelectronic_formats(struct snd_dice *dice)
+{
+	static const struct {
+		u32 model_id;
+		const struct dice_tc_spec *spec;
+	} *entry, entries[] = {
+		{0x00000020, &konnekt_24d},
+		{0x00000021, &konnekt_8},
+		{0x00000022, &studio_konnekt_48},
+		{0x00000023, &konnekt_live},
+		{0x00000024, &desktop_konnekt6},
+		{0x00000027, &impact_twin},
+	};
+	struct fw_csr_iterator it;
+	int key, val, model_id;
+	int i;
+
+	model_id = 0;
+	fw_csr_iterator_init(&it, dice->unit->directory);
+	while (fw_csr_iterator_next(&it, &key, &val)) {
+		if (key == CSR_MODEL) {
+			model_id = val;
+			break;
+		}
+	}
+
+	entry = NULL;
+	for (i = 0; i < ARRAY_SIZE(entries); ++i) {
+		entry = entries + i;
+		if (entry->model_id == model_id)
+			break;
+	}
+	if (!entry)
+		return -ENODEV;
+
+	memcpy(dice->tx_pcm_chs, entry->spec->tx_pcm_chs,
+	       MAX_STREAMS * SND_DICE_RATE_MODE_COUNT * sizeof(unsigned int));
+	memcpy(dice->rx_pcm_chs, entry->spec->rx_pcm_chs,
+	       MAX_STREAMS * SND_DICE_RATE_MODE_COUNT * sizeof(unsigned int));
+
+	for (i = 0; i < MAX_STREAMS; ++i) {
+		if (entry->spec->has_midi) {
+			dice->tx_midi_ports[i] = 1;
+			dice->rx_midi_ports[i] = 1;
+		}
+	}
+
+	return 0;
+}
diff --git a/sound/firewire/dice/dice.c b/sound/firewire/dice/dice.c
index 002f3f3cbc6a..ea112506cc66 100644
--- a/sound/firewire/dice/dice.c
+++ b/sound/firewire/dice/dice.c
@@ -199,7 +199,7 @@ static void do_registration(struct work_struct *work)
 
 	dice_card_strings(dice);
 
-	err = snd_dice_stream_detect_current_formats(dice);
+	err = dice->detect_formats(dice);
 	if (err < 0)
 		goto error;
 
@@ -243,14 +243,17 @@ static void do_registration(struct work_struct *work)
 		 "Sound card registration failed: %d\n", err);
 }
 
-static int dice_probe(struct fw_unit *unit, const struct ieee1394_device_id *id)
+static int dice_probe(struct fw_unit *unit,
+		      const struct ieee1394_device_id *entry)
 {
 	struct snd_dice *dice;
 	int err;
 
-	err = check_dice_category(unit);
-	if (err < 0)
-		return -ENODEV;
+	if (!entry->driver_data) {
+		err = check_dice_category(unit);
+		if (err < 0)
+			return -ENODEV;
+	}
 
 	/* Allocate this independent of sound card instance. */
 	dice = kzalloc(sizeof(struct snd_dice), GFP_KERNEL);
@@ -260,6 +263,13 @@ static int dice_probe(struct fw_unit *unit, const struct ieee1394_device_id *id)
 	dice->unit = fw_unit_get(unit);
 	dev_set_drvdata(&unit->device, dice);
 
+	if (!entry->driver_data) {
+		dice->detect_formats = snd_dice_stream_detect_current_formats;
+	} else {
+		dice->detect_formats =
+				(snd_dice_detect_formats_t)entry->driver_data;
+	}
+
 	spin_lock_init(&dice->lock);
 	mutex_init(&dice->mutex);
 	init_completion(&dice->clock_accepted);
@@ -317,10 +327,6 @@ static void dice_bus_reset(struct fw_unit *unit)
 #define DICE_INTERFACE	0x000001
 
 static const struct ieee1394_device_id dice_id_table[] = {
-	{
-		.match_flags = IEEE1394_MATCH_VERSION,
-		.version     = DICE_INTERFACE,
-	},
 	/* M-Audio Profire 610/2626 has a different value in version field. */
 	{
 		.match_flags	= IEEE1394_MATCH_VENDOR_ID |
@@ -328,6 +334,58 @@ static const struct ieee1394_device_id dice_id_table[] = {
 		.vendor_id	= 0x000d6c,
 		.specifier_id	= 0x000d6c,
 	},
+	/* TC Electronic Konnekt 24D. */
+	{
+		.match_flags	= IEEE1394_MATCH_VENDOR_ID |
+				  IEEE1394_MATCH_MODEL_ID,
+		.vendor_id	= OUI_TCELECTRONIC,
+		.model_id	= 0x000020,
+		.driver_data = (kernel_ulong_t)snd_dice_detect_tcelectronic_formats,
+	},
+	/* TC Electronic Konnekt 8. */
+	{
+		.match_flags	= IEEE1394_MATCH_VENDOR_ID |
+				  IEEE1394_MATCH_MODEL_ID,
+		.vendor_id	= OUI_TCELECTRONIC,
+		.model_id	= 0x000021,
+		.driver_data = (kernel_ulong_t)snd_dice_detect_tcelectronic_formats,
+	},
+	/* TC Electronic Studio Konnekt 48. */
+	{
+		.match_flags	= IEEE1394_MATCH_VENDOR_ID |
+				  IEEE1394_MATCH_MODEL_ID,
+		.vendor_id	= OUI_TCELECTRONIC,
+		.model_id	= 0x000022,
+		.driver_data = (kernel_ulong_t)snd_dice_detect_tcelectronic_formats,
+	},
+	/* TC Electronic Konnekt Live. */
+	{
+		.match_flags	= IEEE1394_MATCH_VENDOR_ID |
+				  IEEE1394_MATCH_MODEL_ID,
+		.vendor_id	= OUI_TCELECTRONIC,
+		.model_id	= 0x000023,
+		.driver_data = (kernel_ulong_t)snd_dice_detect_tcelectronic_formats,
+	},
+	/* TC Electronic Desktop Konnekt 6. */
+	{
+		.match_flags	= IEEE1394_MATCH_VENDOR_ID |
+				  IEEE1394_MATCH_MODEL_ID,
+		.vendor_id	= OUI_TCELECTRONIC,
+		.model_id	= 0x000024,
+		.driver_data = (kernel_ulong_t)snd_dice_detect_tcelectronic_formats,
+	},
+	/* TC Electronic Impact Twin. */
+	{
+		.match_flags	= IEEE1394_MATCH_VENDOR_ID |
+				  IEEE1394_MATCH_MODEL_ID,
+		.vendor_id	= OUI_TCELECTRONIC,
+		.model_id	= 0x000027,
+		.driver_data = (kernel_ulong_t)snd_dice_detect_tcelectronic_formats,
+	},
+	{
+		.match_flags = IEEE1394_MATCH_VERSION,
+		.version     = DICE_INTERFACE,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(ieee1394, dice_id_table);
diff --git a/sound/firewire/dice/dice.h b/sound/firewire/dice/dice.h
index 0c044f28b9e7..a4987dce9e0a 100644
--- a/sound/firewire/dice/dice.h
+++ b/sound/firewire/dice/dice.h
@@ -70,6 +70,9 @@ enum snd_dice_rate_mode {
 	SND_DICE_RATE_MODE_COUNT,
 };
 
+struct snd_dice;
+typedef int (*snd_dice_detect_formats_t)(struct snd_dice *dice);
+
 struct snd_dice {
 	struct snd_card *card;
 	struct fw_unit *unit;
@@ -91,6 +94,7 @@ struct snd_dice {
 	unsigned int rx_pcm_chs[MAX_STREAMS][SND_DICE_RATE_MODE_COUNT];
 	unsigned int tx_midi_ports[MAX_STREAMS];
 	unsigned int rx_midi_ports[MAX_STREAMS];
+	snd_dice_detect_formats_t detect_formats;
 
 	struct fw_address_handler notification_handler;
 	int owner_generation;
@@ -221,4 +225,6 @@ void snd_dice_create_proc(struct snd_dice *dice);
 
 int snd_dice_create_midi(struct snd_dice *dice);
 
+int snd_dice_detect_tcelectronic_formats(struct snd_dice *dice);
+
 #endif
-- 
2.14.1
