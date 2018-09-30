From: Connor McAdams <conmanx360@gmail.com>
Subject: [PATCH 08/11] ALSA: hda/ca0132 - Add ZxR input/output select commands
Date: Sat, 29 Sep 2018 23:03:23 -0400
Message-ID: <1538276607-30234-9-git-send-email-conmanx360@gmail.com>
References: <1538276607-30234-1-git-send-email-conmanx360@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1538276607-30234-1-git-send-email-conmanx360@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Alastair Bridgewater <alastair.bridgewater@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch adds commands for selecting input and output on the Sound
Blaster ZxR. The ZxR has no front panel header, and has line-in on the
separate daughter board, so it only does rear-mic.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 729766a..bc8745f 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -4174,6 +4174,12 @@ static void ca0132_alt_select_out_quirk_handler(struct hda_codec *codec)
 			ca0113_mmio_gpio_set(codec, 1, true);
 			chipio_set_control_param(codec, 0x0d, 0x18);
 			break;
+		case QUIRK_ZXR:
+			ca0113_mmio_gpio_set(codec, 2, true);
+			ca0113_mmio_gpio_set(codec, 3, true);
+			ca0113_mmio_gpio_set(codec, 5, false);
+			chipio_set_control_param(codec, 0x0d, 0x24);
+			break;
 		case QUIRK_R3DI:
 			chipio_set_control_param(codec, 0x0d, 0x24);
 			r3di_gpio_out_set(codec, R3DI_LINE_OUT);
@@ -4201,6 +4207,12 @@ static void ca0132_alt_select_out_quirk_handler(struct hda_codec *codec)
 			ca0113_mmio_gpio_set(codec, 1, false);
 			chipio_set_control_param(codec, 0x0d, 0x12);
 			break;
+		case QUIRK_ZXR:
+			ca0113_mmio_gpio_set(codec, 2, false);
+			ca0113_mmio_gpio_set(codec, 3, false);
+			ca0113_mmio_gpio_set(codec, 5, true);
+			chipio_set_control_param(codec, 0x0d, 0x21);
+			break;
 		case QUIRK_R3DI:
 			chipio_set_control_param(codec, 0x0d, 0x21);
 			r3di_gpio_out_set(codec, R3DI_HEADPHONE_OUT);
@@ -4229,6 +4241,12 @@ static void ca0132_alt_select_out_quirk_handler(struct hda_codec *codec)
 			ca0113_mmio_gpio_set(codec, 1, true);
 			chipio_set_control_param(codec, 0x0d, 0x18);
 			break;
+		case QUIRK_ZXR:
+			ca0113_mmio_gpio_set(codec, 2, true);
+			ca0113_mmio_gpio_set(codec, 3, true);
+			ca0113_mmio_gpio_set(codec, 5, false);
+			chipio_set_control_param(codec, 0x0d, 0x24);
+			break;
 		case QUIRK_R3DI:
 			chipio_set_control_param(codec, 0x0d, 0x24);
 			r3di_gpio_out_set(codec, R3DI_LINE_OUT);
@@ -4625,6 +4643,9 @@ static int ca0132_alt_select_in(struct hda_codec *codec)
 			ca0113_mmio_gpio_set(codec, 0, false);
 			tmp = FLOAT_THREE;
 			break;
+		case QUIRK_ZXR:
+			tmp = FLOAT_THREE;
+			break;
 		case QUIRK_R3DI:
 			r3di_gpio_mic_set(codec, R3DI_REAR_MIC);
 			tmp = FLOAT_ONE;
@@ -4652,6 +4673,10 @@ static int ca0132_alt_select_in(struct hda_codec *codec)
 			chipio_write(codec, 0x18B098, 0x0000000C);
 			chipio_write(codec, 0x18B09C, 0x0000000C);
 			break;
+		case QUIRK_ZXR:
+			chipio_write(codec, 0x18B098, 0x0000000C);
+			chipio_write(codec, 0x18B09C, 0x000000CC);
+			break;
 		case QUIRK_AE5:
 			chipio_write(codec, 0x18B098, 0x0000000C);
 			chipio_write(codec, 0x18B09C, 0x0000004C);
-- 
2.7.4
