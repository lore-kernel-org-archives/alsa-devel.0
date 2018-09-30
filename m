From: Connor McAdams <conmanx360@gmail.com>
Subject: [PATCH 11/11] ALSA: hda/ca0132 - Add ZxR exit commands
Date: Sat, 29 Sep 2018 23:03:26 -0400
Message-ID: <1538276607-30234-12-git-send-email-conmanx360@gmail.com>
References: <1538276607-30234-1-git-send-email-conmanx360@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1538276607-30234-1-git-send-email-conmanx360@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Alastair Bridgewater <alastair.bridgewater@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch adds exit operations for the Sound Blaster ZxR.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 90e6a96..b098504 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -7869,6 +7869,36 @@ static void ae5_exit_chip(struct hda_codec *codec)
 	snd_hda_codec_write(codec, 0x01, 0, 0x724, 0x83);
 }
 
+static void zxr_exit_chip(struct hda_codec *codec)
+{
+	chipio_set_stream_control(codec, 0x03, 0);
+	chipio_set_stream_control(codec, 0x04, 0);
+	chipio_set_stream_control(codec, 0x14, 0);
+	chipio_set_stream_control(codec, 0x0C, 0);
+
+	chipio_set_conn_rate(codec, 0x41, SR_192_000);
+	chipio_set_conn_rate(codec, 0x91, SR_192_000);
+
+	chipio_write(codec, 0x18a020, 0x00000083);
+
+	snd_hda_codec_write(codec, 0x01, 0, 0x793, 0x00);
+	snd_hda_codec_write(codec, 0x01, 0, 0x794, 0x53);
+
+	ca0132_clear_unsolicited(codec);
+	sbz_set_pin_ctl_default(codec);
+	snd_hda_codec_write(codec, 0x0B, 0, AC_VERB_SET_EAPD_BTLENABLE, 0x00);
+
+	ca0113_mmio_gpio_set(codec, 5, false);
+	ca0113_mmio_gpio_set(codec, 2, false);
+	ca0113_mmio_gpio_set(codec, 3, false);
+	ca0113_mmio_gpio_set(codec, 0, false);
+	ca0113_mmio_gpio_set(codec, 4, true);
+	ca0113_mmio_gpio_set(codec, 0, true);
+	ca0113_mmio_gpio_set(codec, 5, true);
+	ca0113_mmio_gpio_set(codec, 2, false);
+	ca0113_mmio_gpio_set(codec, 3, false);
+}
+
 static void ca0132_exit_chip(struct hda_codec *codec)
 {
 	/* put any chip cleanup stuffs here. */
@@ -8333,6 +8363,9 @@ static void ca0132_free(struct hda_codec *codec)
 	case QUIRK_SBZ:
 		sbz_exit_chip(codec);
 		break;
+	case QUIRK_ZXR:
+		zxr_exit_chip(codec);
+		break;
 	case QUIRK_R3D:
 		r3d_exit_chip(codec);
 		break;
-- 
2.7.4
