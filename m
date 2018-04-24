From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 08/11] ALSA: dice: add parameters of stream
	formats for models produced by TC Electronic
Date: Wed, 25 Apr 2018 08:42:31 +0900
Message-ID: <20180424234234.6063-9-o-takashi@sakamocchi.jp>
References: <20180424234234.6063-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f66.google.com (mail-pg0-f66.google.com [74.125.83.66])
 by alsa0.perex.cz (Postfix) with ESMTP id C30FD267729
 for <alsa-devel@alsa-project.org>; Wed, 25 Apr 2018 01:43:26 +0200 (CEST)
Received: by mail-pg0-f66.google.com with SMTP id b9so11985386pgf.6
 for <alsa-devel@alsa-project.org>; Tue, 24 Apr 2018 16:43:26 -0700 (PDT)
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
 sound/firewire/dice/dice.c              |  74 ++++++++++++++++++++---
 sound/firewire/dice/dice.h              |   6 ++
 4 files changed, 172 insertions(+), 10 deletions(-)
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
index 000000000000..71cc85b5a7c4
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
+	unsigned int tx_channels[MAX_STREAMS][3];
+	unsigned int rx_channels[MAX_STREAMS][3];
+	bool has_midi;
+};
+
+static const struct dice_tc_spec desktop_konnekt6 = {
+	.tx_channels = {{6, 6, 2}, {0, 0, 0} },
+	.rx_channels = {{6, 6, 4}, {0, 0, 0} },
+	.has_midi = false,
+};
+
+static const struct dice_tc_spec impact_twin = {
+	.tx_channels = {{14, 10, 6}, {0, 0, 0} },
+	.rx_channels = {{14, 10, 6}, {0, 0, 0} },
+	.has_midi = true,
+};
+
+static const struct dice_tc_spec konnekt_8 = {
+	.tx_channels = {{4, 4, 3}, {0, 0, 0} },
+	.rx_channels = {{4, 4, 3}, {0, 0, 0} },
+	.has_midi = true,
+};
+
+static const struct dice_tc_spec konnekt_24d = {
+	.tx_channels = {{16, 16, 6}, {0, 0, 0} },
+	.rx_channels = {{16, 16, 6}, {0, 0, 0} },
+	.has_midi = true,
+};
+
+static const struct dice_tc_spec konnekt_live = {
+	.tx_channels = {{16, 16, 16}, {0, 0, 0} },
+	.rx_channels = {{16, 16, 16}, {0, 0, 0} },
+	.has_midi = true,
+};
+
+static const struct dice_tc_spec studio_konnekt_48 = {
+	.tx_channels = {{16, 16, 16}, {16, 16, 0} },
+	.rx_channels = {{16, 16, 16}, {16, 16, 0} },
+	.has_midi = true,
+};
+
+int snd_dice_detect_tcelectronic_spec(struct snd_dice *dice)
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
+	memcpy(dice->tx_channels, entry->spec->tx_channels,
+	       MAX_STREAMS * 3 * sizeof(unsigned int));
+	memcpy(dice->rx_channels, entry->spec->rx_channels,
+	       MAX_STREAMS * 3 * sizeof(unsigned int));
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
index 002f3f3cbc6a..4530370b1f8c 100644
--- a/sound/firewire/dice/dice.c
+++ b/sound/firewire/dice/dice.c
@@ -199,7 +199,7 @@ static void do_registration(struct work_struct *work)
 
 	dice_card_strings(dice);
 
-	err = snd_dice_stream_detect_current_formats(dice);
+	err = dice->detect_spec(dice);
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
@@ -260,6 +263,11 @@ static int dice_probe(struct fw_unit *unit, const struct ieee1394_device_id *id)
 	dice->unit = fw_unit_get(unit);
 	dev_set_drvdata(&unit->device, dice);
 
+	if (!entry->driver_data)
+		dice->detect_spec = snd_dice_stream_detect_current_formats;
+	else
+		dice->detect_spec = (snd_dice_detect_spec_t)entry->driver_data;
+
 	spin_lock_init(&dice->lock);
 	mutex_init(&dice->mutex);
 	init_completion(&dice->clock_accepted);
@@ -317,10 +325,6 @@ static void dice_bus_reset(struct fw_unit *unit)
 #define DICE_INTERFACE	0x000001
 
 static const struct ieee1394_device_id dice_id_table[] = {
-	{
-		.match_flags = IEEE1394_MATCH_VERSION,
-		.version     = DICE_INTERFACE,
-	},
 	/* M-Audio Profire 610/2626 has a different value in version field. */
 	{
 		.match_flags	= IEEE1394_MATCH_VENDOR_ID |
@@ -328,6 +332,58 @@ static const struct ieee1394_device_id dice_id_table[] = {
 		.vendor_id	= 0x000d6c,
 		.specifier_id	= 0x000d6c,
 	},
+	/* TC Electronic Konnekt 24D. */
+	{
+		.match_flags	= IEEE1394_MATCH_VENDOR_ID |
+				  IEEE1394_MATCH_MODEL_ID,
+		.vendor_id	= OUI_TCELECTRONIC,
+		.model_id	= 0x000020,
+		.driver_data = (kernel_ulong_t)snd_dice_detect_tcelectronic_spec,
+	},
+	/* TC Electronic Konnekt 8. */
+	{
+		.match_flags	= IEEE1394_MATCH_VENDOR_ID |
+				  IEEE1394_MATCH_MODEL_ID,
+		.vendor_id	= OUI_TCELECTRONIC,
+		.model_id	= 0x000021,
+		.driver_data = (kernel_ulong_t)snd_dice_detect_tcelectronic_spec,
+	},
+	/* TC Electronic Studio Konnekt 48. */
+	{
+		.match_flags	= IEEE1394_MATCH_VENDOR_ID |
+				  IEEE1394_MATCH_MODEL_ID,
+		.vendor_id	= OUI_TCELECTRONIC,
+		.model_id	= 0x000022,
+		.driver_data = (kernel_ulong_t)snd_dice_detect_tcelectronic_spec,
+	},
+	/* TC Electronic Konnekt Live. */
+	{
+		.match_flags	= IEEE1394_MATCH_VENDOR_ID |
+				  IEEE1394_MATCH_MODEL_ID,
+		.vendor_id	= OUI_TCELECTRONIC,
+		.model_id	= 0x000023,
+		.driver_data = (kernel_ulong_t)snd_dice_detect_tcelectronic_spec,
+	},
+	/* TC Electronic Desktop Konnekt 6. */
+	{
+		.match_flags	= IEEE1394_MATCH_VENDOR_ID |
+				  IEEE1394_MATCH_MODEL_ID,
+		.vendor_id	= OUI_TCELECTRONIC,
+		.model_id	= 0x000024,
+		.driver_data = (kernel_ulong_t)snd_dice_detect_tcelectronic_spec,
+	},
+	/* TC Electronic Impact Twin. */
+	{
+		.match_flags	= IEEE1394_MATCH_VENDOR_ID |
+				  IEEE1394_MATCH_MODEL_ID,
+		.vendor_id	= OUI_TCELECTRONIC,
+		.model_id	= 0x000027,
+		.driver_data = (kernel_ulong_t)snd_dice_detect_tcelectronic_spec,
+	},
+	{
+		.match_flags = IEEE1394_MATCH_VERSION,
+		.version     = DICE_INTERFACE,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(ieee1394, dice_id_table);
diff --git a/sound/firewire/dice/dice.h b/sound/firewire/dice/dice.h
index f7ee3ef7a942..31d46ea53a31 100644
--- a/sound/firewire/dice/dice.h
+++ b/sound/firewire/dice/dice.h
@@ -63,6 +63,9 @@
  */
 #define MAX_STREAMS	2
 
+struct snd_dice;
+typedef int (*snd_dice_detect_spec_t)(struct snd_dice *dice);
+
 struct snd_dice {
 	struct snd_card *card;
 	struct fw_unit *unit;
@@ -84,6 +87,7 @@ struct snd_dice {
 	unsigned int rx_channels[MAX_STREAMS][3];
 	unsigned int tx_midi_ports[MAX_STREAMS];
 	unsigned int rx_midi_ports[MAX_STREAMS];
+	snd_dice_detect_spec_t detect_spec;
 
 	struct fw_address_handler notification_handler;
 	int owner_generation;
@@ -214,4 +218,6 @@ void snd_dice_create_proc(struct snd_dice *dice);
 
 int snd_dice_create_midi(struct snd_dice *dice);
 
+int snd_dice_detect_tcelectronic_spec(struct snd_dice *dice);
+
 #endif
-- 
2.14.1
