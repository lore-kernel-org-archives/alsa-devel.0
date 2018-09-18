From: Connor McAdams <conmanx360@gmail.com>
Subject: [PATCH 13/15] ALSA: hda/ca0132 - Add input selection commands for AE-5
Date: Tue, 18 Sep 2018 14:33:41 -0400
Message-ID: <1537295625-8082-14-git-send-email-conmanx360@gmail.com>
References: <1537295625-8082-1-git-send-email-conmanx360@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537295625-8082-1-git-send-email-conmanx360@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Alastair Bridgewater <alastair.bridgewater@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch adds the input selection commands for the Sound BlasterX
AE-5.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 364c3fe..ff80832 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -4523,6 +4523,10 @@ static int ca0132_alt_select_in(struct hda_codec *codec)
 			r3di_gpio_mic_set(codec, R3DI_REAR_MIC);
 			tmp = FLOAT_ONE;
 			break;
+		case QUIRK_AE5:
+			ca0113_mmio_command_set(codec, 0x48, 0x28, 0x00);
+			tmp = FLOAT_THREE;
+			break;
 		default:
 			tmp = FLOAT_ONE;
 			break;
@@ -4537,10 +4541,15 @@ static int ca0132_alt_select_in(struct hda_codec *codec)
 
 		chipio_set_stream_control(codec, 0x03, 1);
 		chipio_set_stream_control(codec, 0x04, 1);
-
-		if (spec->quirk == QUIRK_SBZ) {
+		switch (spec->quirk) {
+		case QUIRK_SBZ:
 			chipio_write(codec, 0x18B098, 0x0000000C);
 			chipio_write(codec, 0x18B09C, 0x0000000C);
+			break;
+		case QUIRK_AE5:
+			chipio_write(codec, 0x18B098, 0x0000000C);
+			chipio_write(codec, 0x18B09C, 0x0000004C);
+			break;
 		}
 		ca0132_alt_mic_boost_set(codec, spec->mic_boost_enum_val);
 		break;
@@ -4554,6 +4563,9 @@ static int ca0132_alt_select_in(struct hda_codec *codec)
 		case QUIRK_R3DI:
 			r3di_gpio_mic_set(codec, R3DI_REAR_MIC);
 			break;
+		case QUIRK_AE5:
+			ca0113_mmio_command_set(codec, 0x48, 0x28, 0x00);
+			break;
 		}
 
 		chipio_set_conn_rate(codec, MEM_CONNID_MICIN1, SR_96_000);
@@ -4564,11 +4576,13 @@ static int ca0132_alt_select_in(struct hda_codec *codec)
 		tmp = FLOAT_ZERO;
 		dspio_set_uint_param(codec, 0x80, 0x00, tmp);
 
-		if (spec->quirk == QUIRK_SBZ) {
+		switch (spec->quirk) {
+		case QUIRK_SBZ:
+		case QUIRK_AE5:
 			chipio_write(codec, 0x18B098, 0x00000000);
 			chipio_write(codec, 0x18B09C, 0x00000000);
+			break;
 		}
-
 		chipio_set_stream_control(codec, 0x03, 1);
 		chipio_set_stream_control(codec, 0x04, 1);
 		break;
@@ -4584,6 +4598,10 @@ static int ca0132_alt_select_in(struct hda_codec *codec)
 			r3di_gpio_mic_set(codec, R3DI_FRONT_MIC);
 			tmp = FLOAT_ONE;
 			break;
+		case QUIRK_AE5:
+			ca0113_mmio_command_set(codec, 0x48, 0x28, 0x3f);
+			tmp = FLOAT_THREE;
+			break;
 		default:
 			tmp = FLOAT_ONE;
 			break;
@@ -4599,9 +4617,15 @@ static int ca0132_alt_select_in(struct hda_codec *codec)
 		chipio_set_stream_control(codec, 0x03, 1);
 		chipio_set_stream_control(codec, 0x04, 1);
 
-		if (spec->quirk == QUIRK_SBZ) {
+		switch (spec->quirk) {
+		case QUIRK_SBZ:
 			chipio_write(codec, 0x18B098, 0x0000000C);
 			chipio_write(codec, 0x18B09C, 0x000000CC);
+			break;
+		case QUIRK_AE5:
+			chipio_write(codec, 0x18B098, 0x0000000C);
+			chipio_write(codec, 0x18B09C, 0x0000004C);
+			break;
 		}
 		ca0132_alt_mic_boost_set(codec, spec->mic_boost_enum_val);
 		break;
@@ -4610,7 +4634,6 @@ static int ca0132_alt_select_in(struct hda_codec *codec)
 
 	snd_hda_power_down_pm(codec);
 	return 0;
-
 }
 
 /*
-- 
2.7.4
