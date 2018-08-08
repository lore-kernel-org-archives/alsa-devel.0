From: Connor McAdams <conmanx360@gmail.com>
Subject: [PATCH 09/11] ALSA: hda/ca0132 - Add Recon3D input and output select commands
Date: Wed,  8 Aug 2018 13:34:20 -0400
Message-ID: <1533749663-8200-10-git-send-email-conmanx360@gmail.com>
References: <1533749663-8200-1-git-send-email-conmanx360@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533749663-8200-1-git-send-email-conmanx360@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Connor McAdams <conmanx360@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Alastair Bridgewater <alastair.bridgewater@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch adds commands to the alternative input and output select
commands to support the Recon3D.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 0257fb9..18b97df 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -3993,6 +3993,10 @@ static int ca0132_alt_select_out(struct hda_codec *codec)
 			chipio_set_control_param(codec, 0x0D, 0x24);
 			r3di_gpio_out_set(codec, R3DI_LINE_OUT);
 			break;
+		case QUIRK_R3D:
+			chipio_set_control_param(codec, 0x0D, 0x24);
+			ca0132_mmio_gpio_set(codec, 1, true);
+			break;
 		}
 
 		/* disable headphone node */
@@ -4029,6 +4033,10 @@ static int ca0132_alt_select_out(struct hda_codec *codec)
 			chipio_set_control_param(codec, 0x0D, 0x21);
 			r3di_gpio_out_set(codec, R3DI_HEADPHONE_OUT);
 			break;
+		case QUIRK_R3D:
+			chipio_set_control_param(codec, 0x0D, 0x21);
+			ca0132_mmio_gpio_set(codec, 0x1, false);
+			break;
 		}
 
 		snd_hda_codec_write(codec, spec->out_pins[0], 0,
@@ -4071,6 +4079,10 @@ static int ca0132_alt_select_out(struct hda_codec *codec)
 			chipio_set_control_param(codec, 0x0D, 0x24);
 			r3di_gpio_out_set(codec, R3DI_LINE_OUT);
 			break;
+		case QUIRK_R3D:
+			ca0132_mmio_gpio_set(codec, 1, true);
+			chipio_set_control_param(codec, 0x0D, 0x24);
+			break;
 		}
 		/* enable line out node */
 		pin_ctl = snd_hda_codec_read(codec, spec->out_pins[0], 0,
@@ -4328,6 +4340,7 @@ static int ca0132_alt_select_in(struct hda_codec *codec)
 	case REAR_MIC:
 		switch (spec->quirk) {
 		case QUIRK_SBZ:
+		case QUIRK_R3D:
 			ca0132_mmio_gpio_set(codec, 0, false);
 			tmp = FLOAT_THREE;
 			break;
@@ -4360,6 +4373,7 @@ static int ca0132_alt_select_in(struct hda_codec *codec)
 		ca0132_mic_boost_set(codec, 0);
 		switch (spec->quirk) {
 		case QUIRK_SBZ:
+		case QUIRK_R3D:
 			ca0132_mmio_gpio_set(codec, 0, false);
 			break;
 		case QUIRK_R3DI:
@@ -4386,6 +4400,7 @@ static int ca0132_alt_select_in(struct hda_codec *codec)
 	case FRONT_MIC:
 		switch (spec->quirk) {
 		case QUIRK_SBZ:
+		case QUIRK_R3D:
 			ca0132_mmio_gpio_set(codec, 0, true);
 			ca0132_mmio_gpio_set(codec, 5, false);
 			tmp = FLOAT_THREE;
-- 
2.7.4
