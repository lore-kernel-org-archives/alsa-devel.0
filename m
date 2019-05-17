From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: dice: add stream format parameters for
	PreSonus FireStudio
Date: Fri, 17 May 2019 11:56:22 +0900
Message-ID: <20190517025622.3401-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C8481F806E7
 for <alsa-devel@alsa-project.org>; Fri, 17 May 2019 04:56:30 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

FireStudio was launched by PreSonus 2009. This model consists of three
ICs for its packet processing on IEEE 1394 bus:

 - Texus Instruments TSB41AB2 for physical layer of IEEE 1394 bus
 - WaveFront semiconductor, Dice II STD ASIC for link layer of IEEE 1394
   bus and protocol layer
 - Xilinx Spartan XG3S500E FPGA for signal processing

This model don't support TCAT extended application protocol. For such
devices, ALSA dice driver needs to have hard-coded parameters for stream
formats.

This commit adds hard-coded table for this model. As a result, sampling
transfer frequencies of 88.2/96.0 kHz are supported. I note that this
patch can be backported to Linux kernel v4.18 and later.

$ python2 crpp < /sys/bus/firewire/devices/fw1/config_rom
               ROM header and bus information block
               -----------------------------------------------------------------
400  04042eda  bus_info_length 4, crc_length 4, crc 11994
404  31333934  bus_name "1394"
408  e0ff8112  irmc 1, cmc 1, isc 1, bmc 0, pmc 0, cyc_clk_acc 255,
               max_rec 8 (512), max_rom 1, gen 1, spd 2 (S400)
40c  000a9204  company_id 000a92     |
410  023a8b7f  device_id 04023a8b7f  | EUI-64 000a9204023a8b7f

               root directory
               -----------------------------------------------------------------
414  000661b6  directory_length 6, crc 25014
418  03000a92  vendor
41c  8100000a  --> descriptor leaf at 444
420  17000008  model
424  8100000d  --> descriptor leaf at 458
428  0c0087c0  node capabilities per IEEE 1394
42c  d1000001  --> unit directory at 430

               unit directory at 430
               -----------------------------------------------------------------
430  00041c75  directory_length 4, crc 7285
434  12000a92  specifier id
438  13000001  version
43c  17000008  model
440  8100000c  --> descriptor leaf at 470

               descriptor leaf at 444
               -----------------------------------------------------------------
444  00047c11  leaf_length 4, crc 31761
448  00000000  textual descriptor
44c  00000000  minimal ASCII
450  50726553  "PreS"
454  6f6e7573  "onus"

               descriptor leaf at 458
               -----------------------------------------------------------------
458  0005d7b3  leaf_length 5, crc 55219
45c  00000000  textual descriptor
460  00000000  minimal ASCII
464  46495245  "FIRE"
468  53545544  "STUD"
46c  494f0000  "IO"

               descriptor leaf at 470
               -----------------------------------------------------------------
470  0005d7b3  leaf_length 5, crc 55219
474  00000000  textual descriptor
478  00000000  minimal ASCII
47c  46495245  "FIRE"
480  53545544  "STUD"
484  494f0000  "IO"

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/Makefile        |  2 +-
 sound/firewire/dice/dice-presonus.c | 62 +++++++++++++++++++++++++++++
 sound/firewire/dice/dice.c          |  9 +++++
 sound/firewire/dice/dice.h          |  1 +
 4 files changed, 73 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/dice/dice-presonus.c

diff --git a/sound/firewire/dice/Makefile b/sound/firewire/dice/Makefile
index 37062a233f6a..7efca3648c6a 100644
--- a/sound/firewire/dice/Makefile
+++ b/sound/firewire/dice/Makefile
@@ -1,4 +1,4 @@
 snd-dice-objs := dice-transaction.o dice-stream.o dice-proc.o dice-midi.o \
 		 dice-pcm.o dice-hwdep.o dice.o dice-tcelectronic.o \
-		 dice-alesis.o dice-extension.o dice-mytek.o
+		 dice-alesis.o dice-extension.o dice-mytek.o dice-presonus.o
 obj-$(CONFIG_SND_DICE) += snd-dice.o
diff --git a/sound/firewire/dice/dice-presonus.c b/sound/firewire/dice/dice-presonus.c
new file mode 100644
index 000000000000..503f462a83f4
--- /dev/null
+++ b/sound/firewire/dice/dice-presonus.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0
+// dice-presonus.c - a part of driver for DICE based devices
+//
+// Copyright (c) 2019 Takashi Sakamoto
+//
+// Licensed under the terms of the GNU General Public License, version 2.
+
+#include "dice.h"
+
+struct dice_presonus_spec {
+	unsigned int tx_pcm_chs[MAX_STREAMS][SND_DICE_RATE_MODE_COUNT];
+	unsigned int rx_pcm_chs[MAX_STREAMS][SND_DICE_RATE_MODE_COUNT];
+	bool has_midi;
+};
+
+static const struct dice_presonus_spec dice_presonus_firesutio = {
+	.tx_pcm_chs = {{16, 16, 0}, {10, 2, 0} },
+	.rx_pcm_chs = {{16, 16, 0}, {10, 2, 0} },
+	.has_midi = true,
+};
+
+int snd_dice_detect_presonus_formats(struct snd_dice *dice)
+{
+	static const struct {
+		u32 model_id;
+		const struct dice_presonus_spec *spec;
+	} *entry, entries[] = {
+		{0x000008, &dice_presonus_firesutio},
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
+	for (i = 0; i < ARRAY_SIZE(entries); ++i) {
+		entry = entries + i;
+		if (entry->model_id == model_id)
+			break;
+	}
+	if (i == ARRAY_SIZE(entries))
+		return -ENODEV;
+
+	memcpy(dice->tx_pcm_chs, entry->spec->tx_pcm_chs,
+	       MAX_STREAMS * SND_DICE_RATE_MODE_COUNT * sizeof(unsigned int));
+	memcpy(dice->rx_pcm_chs, entry->spec->rx_pcm_chs,
+	       MAX_STREAMS * SND_DICE_RATE_MODE_COUNT * sizeof(unsigned int));
+
+	if (entry->spec->has_midi) {
+		dice->tx_midi_ports[0] = 1;
+		dice->rx_midi_ports[0] = 1;
+	}
+
+	return 0;
+}
diff --git a/sound/firewire/dice/dice.c b/sound/firewire/dice/dice.c
index eee184b05d93..ac600e061d7b 100644
--- a/sound/firewire/dice/dice.c
+++ b/sound/firewire/dice/dice.c
@@ -19,6 +19,7 @@ MODULE_LICENSE("GPL v2");
 #define OUI_MAUDIO		0x000d6c
 #define OUI_MYTEK		0x001ee8
 #define OUI_SSL			0x0050c2	// Actually ID reserved by IEEE.
+#define OUI_PRESONUS		0x000a92
 
 #define DICE_CATEGORY_ID	0x04
 #define WEISS_CATEGORY_ID	0x00
@@ -371,6 +372,14 @@ static const struct ieee1394_device_id dice_id_table[] = {
 		.vendor_id	= OUI_SSL,
 		.model_id	= 0x000070,
 	},
+	// Presonus FireStudio.
+	{
+		.match_flags	= IEEE1394_MATCH_VENDOR_ID |
+				  IEEE1394_MATCH_MODEL_ID,
+		.vendor_id	= OUI_PRESONUS,
+		.model_id	= 0x000008,
+		.driver_data	= (kernel_ulong_t)snd_dice_detect_presonus_formats,
+	},
 	{
 		.match_flags = IEEE1394_MATCH_VERSION,
 		.version     = DICE_INTERFACE,
diff --git a/sound/firewire/dice/dice.h b/sound/firewire/dice/dice.h
index 83353a3559e8..9699adc2a96d 100644
--- a/sound/firewire/dice/dice.h
+++ b/sound/firewire/dice/dice.h
@@ -227,5 +227,6 @@ int snd_dice_detect_tcelectronic_formats(struct snd_dice *dice);
 int snd_dice_detect_alesis_formats(struct snd_dice *dice);
 int snd_dice_detect_extension_formats(struct snd_dice *dice);
 int snd_dice_detect_mytek_formats(struct snd_dice *dice);
+int snd_dice_detect_presonus_formats(struct snd_dice *dice);
 
 #endif
-- 
2.20.1
