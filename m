From: Melvin Vermeeren <mail@mel.vin>
Subject: [PATCH] ALSA: dice: add stream format parameters for
	Mytek devices
Date: Thu, 17 May 2018 21:00:00 +0200
Message-ID: <20632004.ST2tKRhYS0@melvin-pc>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6869424006721087767=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
 by alsa0.perex.cz (Postfix) with ESMTP id 22F2F266F44
 for <alsa-devel@alsa-project.org>; Thu, 17 May 2018 21:00:02 +0200 (CEST)
Received: from melvin-pc.localnet (unknown [213.152.161.133])
 (Authenticated sender: melvin@mel.vin)
 by relay11.mail.gandi.net (Postfix) with ESMTPSA id 6136A100003
 for <alsa-devel@alsa-project.org>; Thu, 17 May 2018 21:00:02 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============6869424006721087767==
Content-Type: multipart/signed; boundary="nextPart3916812.EicPReet6m"; micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart3916812.EicPReet6m
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Mytek manufactures some equipment with DICE-based firewire ports. These
devices contain old versions of DICE firmware which lacks detailed
stream format reporting for all sampling clock modes.

Building upon the recent work by Takashi Sakamoto, hard-coded parameters
are added for the Stereo 192 DSD-DAC. When the device vendor and model
match the coded parameters are copied into the stream format cache.

Signed-off-by: Melvin Vermeeren <mail@mel.vin>
---
 sound/firewire/dice/Makefile     |  2 +-
 sound/firewire/dice/dice-mytek.c | 46 ++++++++++++++++++++++++++++++++
 sound/firewire/dice/dice.c       |  9 +++++++
 sound/firewire/dice/dice.h       |  1 +
 4 files changed, 57 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/dice/dice-mytek.c

diff --git a/sound/firewire/dice/Makefile b/sound/firewire/dice/Makefile
index 7b7997a5754c..37062a233f6a 100644
--- a/sound/firewire/dice/Makefile
+++ b/sound/firewire/dice/Makefile
@@ -1,4 +1,4 @@
 snd-dice-objs := dice-transaction.o dice-stream.o dice-proc.o dice-midi.o \
 		 dice-pcm.o dice-hwdep.o dice.o dice-tcelectronic.o \
-		 dice-alesis.o dice-extension.o
+		 dice-alesis.o dice-extension.o dice-mytek.o
 obj-$(CONFIG_SND_DICE) += snd-dice.o
diff --git a/sound/firewire/dice/dice-mytek.c b/sound/firewire/dice/dice-mytek.c
new file mode 100644
index 000000000000..eb7d5492d10b
--- /dev/null
+++ b/sound/firewire/dice/dice-mytek.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * dice-mytek.c - a part of driver for DICE based devices
+ *
+ * Copyright (c) 2018 Melvin Vermeeren
+ */
+
+#include "dice.h"
+
+struct dice_mytek_spec {
+	unsigned int tx_pcm_chs[MAX_STREAMS][SND_DICE_RATE_MODE_COUNT];
+	unsigned int rx_pcm_chs[MAX_STREAMS][SND_DICE_RATE_MODE_COUNT];
+};
+
+static const struct dice_mytek_spec stereo_192_dsd_dac = {
+	/* AES, TOSLINK, SPDIF, ADAT inputs on device */
+	.tx_pcm_chs = {{8, 8, 8}, {0, 0, 0} },
+	/* PCM 44.1-192, native DSD64/DSD128 to device */
+	.rx_pcm_chs = {{4, 4, 4}, {0, 0, 0} }
+};
+
+/*
+ * Mytek has a few other firewire-capable devices, though newer models appear
+ * to lack the port more often than not. As I don't have access to any of them
+ * they are missing here. An example is the Mytek 8x192 ADDA, which is DICE.
+ */
+
+int snd_dice_detect_mytek_formats(struct snd_dice *dice)
+{
+	int i;
+	const struct dice_mytek_spec *dev;
+
+	dev = &stereo_192_dsd_dac;
+
+	memcpy(dice->tx_pcm_chs, dev->tx_pcm_chs,
+	       MAX_STREAMS * SND_DICE_RATE_MODE_COUNT * sizeof(unsigned int));
+	memcpy(dice->rx_pcm_chs, dev->rx_pcm_chs,
+	       MAX_STREAMS * SND_DICE_RATE_MODE_COUNT * sizeof(unsigned int));
+
+	for (i = 0; i < MAX_STREAMS; ++i) {
+		dice->tx_midi_ports[i] = 0;
+		dice->rx_midi_ports[i] = 0;
+	}
+
+	return 0;
+}
diff --git a/sound/firewire/dice/dice.c b/sound/firewire/dice/dice.c
index 40f7a32e4893..beeef62581ba 100644
--- a/sound/firewire/dice/dice.c
+++ b/sound/firewire/dice/dice.c
@@ -17,6 +17,7 @@ MODULE_LICENSE("GPL v2");
 #define OUI_TCELECTRONIC	0x000166
 #define OUI_ALESIS		0x000595
 #define OUI_MAUDIO		0x000d6c
+#define OUI_MYTEK		0x001ee8
 
 #define DICE_CATEGORY_ID	0x04
 #define WEISS_CATEGORY_ID	0x00
@@ -365,6 +366,14 @@ static const struct ieee1394_device_id dice_id_table[] = {
 		.model_id	= MODEL_ALESIS_IO_BOTH,
 		.driver_data = (kernel_ulong_t)snd_dice_detect_alesis_formats,
 	},
+	/* Mytek Stereo 192 DSD-DAC. */
+	{
+		.match_flags	= IEEE1394_MATCH_VENDOR_ID |
+				  IEEE1394_MATCH_MODEL_ID,
+		.vendor_id	= OUI_MYTEK,
+		.model_id	= 0x000002,
+		.driver_data = (kernel_ulong_t)snd_dice_detect_mytek_formats,
+	},
 	{
 		.match_flags = IEEE1394_MATCH_VERSION,
 		.version     = DICE_INTERFACE,
diff --git a/sound/firewire/dice/dice.h b/sound/firewire/dice/dice.h
index 505b79fea6d9..83353a3559e8 100644
--- a/sound/firewire/dice/dice.h
+++ b/sound/firewire/dice/dice.h
@@ -226,5 +226,6 @@ int snd_dice_create_midi(struct snd_dice *dice);
 int snd_dice_detect_tcelectronic_formats(struct snd_dice *dice);
 int snd_dice_detect_alesis_formats(struct snd_dice *dice);
 int snd_dice_detect_extension_formats(struct snd_dice *dice);
+int snd_dice_detect_mytek_formats(struct snd_dice *dice);
 
 #endif
-- 
2.17.0


--nextPart3916812.EicPReet6m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEETnzUjuV5O+rCrz6nRiwQnTrHuFkFAlr90TAACgkQRiwQnTrH
uFnyyQ//UX3+Q8xDOKCq+p36F12MsMOgbiL4pFP8g4AWIXqbrmO8Bbbyp+L8x5Dt
QAQWDbX6Xy9vdzyKcAF9XNK/Ge/pLWbXkC2/Jsg+Wf1Cio0eOXd9Z8Vi+ZcIvtM3
XRgWzBXt44cuY46HIIafI9Q7EIriSV/W3wnTiC3xYZ+Yw1K0uA7Vn1AvY4sP2xSN
woBwbq8j5zeJr/XbVaJ+TudybDGqoyOv7GSD1aghgzViiOzrPLzroCdH9KKVsvWV
SSEObIOAuaXXgZQSC83ZuU4Y3/7id3v+UzILTqBLDymvRnGD2Ry0rVdwMU2fpr6/
MdncYk3g5ZRaiSl/P6HwvaJCuC8s2sHZ3QsOd3IMH5XlTmQ1a6nJ1gLHbICoVBM0
u5ubGwTQcZlVqyAkqUQrvs4jDSgYEKJQrCN0/QPL78w6gcWRTbFTuBXpiuQhU7VK
5Rc1nRZE8LMfTZ2ZynK404ME5T9U/Y+nEPpE7SUGhi6d+ld+wP0gjUNG5zichM/J
6aPT5iw+ZXrg0lDCkhEwaSMVwaU0UWCKlowJ4zV7z5wg1tdHmQwvy5Raizdik9kE
W29hw9vezKfwKbMJLUhfkBASpa1DwcnNAA8nkaDMW932bABL87ePXYw92fKoVgwi
tly0KfPg0hGnWPKlByFcUol+zyCpe0sLjk3rxR2ygEZOczHsXZE=
=+AWA
-----END PGP SIGNATURE-----

--nextPart3916812.EicPReet6m--




--===============6869424006721087767==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6869424006721087767==--
