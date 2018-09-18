From: Connor McAdams <conmanx360@gmail.com>
Subject: [PATCH 11/15] ALSA: hda/ca0132 - Clean up ca0132_alt_out_select
Date: Tue, 18 Sep 2018 14:33:39 -0400
Message-ID: <1537295625-8082-12-git-send-email-conmanx360@gmail.com>
References: <1537295625-8082-1-git-send-email-conmanx360@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537295625-8082-1-git-send-email-conmanx360@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Alastair Bridgewater <alastair.bridgewater@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch cleans up ca0132_alt_out_select by moving the card specific
output commands into a separate function. As more cards are added, the
function ca0132_alt_out_select is going to get more bloated with these,
so moving into a separate function tries to keep that from happening.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 121 +++++++++++++++++++++++++------------------
 1 file changed, 70 insertions(+), 51 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index a625e9d..4de94d7 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -4026,6 +4026,73 @@ static int ca0132_select_out(struct hda_codec *codec)
 }
 
 /*
+ * These are the commands needed to setup output on each of the different card
+ * types.
+ */
+static void ca0132_alt_select_out_quirk_handler(struct hda_codec *codec)
+{
+	struct ca0132_spec *spec = codec->spec;
+	unsigned int tmp;
+
+	switch (spec->cur_out_type) {
+	case SPEAKER_OUT:
+		switch (spec->quirk) {
+		case QUIRK_SBZ:
+			ca0113_mmio_gpio_set(codec, 7, false);
+			ca0113_mmio_gpio_set(codec, 4, true);
+			ca0113_mmio_gpio_set(codec, 1, true);
+			chipio_set_control_param(codec, 0x0D, 0x18);
+			break;
+		case QUIRK_R3DI:
+			chipio_set_control_param(codec, 0x0D, 0x24);
+			r3di_gpio_out_set(codec, R3DI_LINE_OUT);
+			break;
+		case QUIRK_R3D:
+			chipio_set_control_param(codec, 0x0D, 0x24);
+			ca0113_mmio_gpio_set(codec, 1, true);
+			break;
+		}
+		break;
+	case HEADPHONE_OUT:
+		switch (spec->quirk) {
+		case QUIRK_SBZ:
+			ca0113_mmio_gpio_set(codec, 7, true);
+			ca0113_mmio_gpio_set(codec, 4, true);
+			ca0113_mmio_gpio_set(codec, 1, false);
+			chipio_set_control_param(codec, 0x0D, 0x12);
+			break;
+		case QUIRK_R3DI:
+			chipio_set_control_param(codec, 0x0D, 0x21);
+			r3di_gpio_out_set(codec, R3DI_HEADPHONE_OUT);
+			break;
+		case QUIRK_R3D:
+			chipio_set_control_param(codec, 0x0D, 0x21);
+			ca0113_mmio_gpio_set(codec, 0x1, false);
+			break;
+		}
+		break;
+	case SURROUND_OUT:
+		switch (spec->quirk) {
+		case QUIRK_SBZ:
+			ca0113_mmio_gpio_set(codec, 7, false);
+			ca0113_mmio_gpio_set(codec, 4, true);
+			ca0113_mmio_gpio_set(codec, 1, true);
+			chipio_set_control_param(codec, 0x0D, 0x18);
+			break;
+		case QUIRK_R3DI:
+			chipio_set_control_param(codec, 0x0D, 0x24);
+			r3di_gpio_out_set(codec, R3DI_LINE_OUT);
+			break;
+		case QUIRK_R3D:
+			ca0113_mmio_gpio_set(codec, 1, true);
+			chipio_set_control_param(codec, 0x0D, 0x24);
+			break;
+		}
+		break;
+	}
+}
+
+/*
  * This function behaves similarly to the ca0132_select_out funciton above,
  * except with a few differences. It adds the ability to select the current
  * output with an enumerated control "output source" if the auto detect
@@ -4075,26 +4142,11 @@ static int ca0132_alt_select_out(struct hda_codec *codec)
 	if (err < 0)
 		goto exit;
 
+	ca0132_alt_select_out_quirk_handler(codec);
+
 	switch (spec->cur_out_type) {
 	case SPEAKER_OUT:
 		codec_dbg(codec, "%s speaker\n", __func__);
-		/*speaker out config*/
-		switch (spec->quirk) {
-		case QUIRK_SBZ:
-			ca0113_mmio_gpio_set(codec, 7, false);
-			ca0113_mmio_gpio_set(codec, 4, true);
-			ca0113_mmio_gpio_set(codec, 1, true);
-			chipio_set_control_param(codec, 0x0D, 0x18);
-			break;
-		case QUIRK_R3DI:
-			chipio_set_control_param(codec, 0x0D, 0x24);
-			r3di_gpio_out_set(codec, R3DI_LINE_OUT);
-			break;
-		case QUIRK_R3D:
-			chipio_set_control_param(codec, 0x0D, 0x24);
-			ca0113_mmio_gpio_set(codec, 1, true);
-			break;
-		}
 
 		/* disable headphone node */
 		pin_ctl = snd_hda_codec_read(codec, spec->out_pins[1], 0,
@@ -4118,23 +4170,6 @@ static int ca0132_alt_select_out(struct hda_codec *codec)
 		break;
 	case HEADPHONE_OUT:
 		codec_dbg(codec, "%s hp\n", __func__);
-		/* Headphone out config*/
-		switch (spec->quirk) {
-		case QUIRK_SBZ:
-			ca0113_mmio_gpio_set(codec, 7, true);
-			ca0113_mmio_gpio_set(codec, 4, true);
-			ca0113_mmio_gpio_set(codec, 1, false);
-			chipio_set_control_param(codec, 0x0D, 0x12);
-			break;
-		case QUIRK_R3DI:
-			chipio_set_control_param(codec, 0x0D, 0x21);
-			r3di_gpio_out_set(codec, R3DI_HEADPHONE_OUT);
-			break;
-		case QUIRK_R3D:
-			chipio_set_control_param(codec, 0x0D, 0x21);
-			ca0113_mmio_gpio_set(codec, 0x1, false);
-			break;
-		}
 
 		snd_hda_codec_write(codec, spec->out_pins[0], 0,
 			AC_VERB_SET_EAPD_BTLENABLE, 0x00);
@@ -4164,23 +4199,7 @@ static int ca0132_alt_select_out(struct hda_codec *codec)
 		break;
 	case SURROUND_OUT:
 		codec_dbg(codec, "%s surround\n", __func__);
-		/* Surround out config*/
-		switch (spec->quirk) {
-		case QUIRK_SBZ:
-			ca0113_mmio_gpio_set(codec, 7, false);
-			ca0113_mmio_gpio_set(codec, 4, true);
-			ca0113_mmio_gpio_set(codec, 1, true);
-			chipio_set_control_param(codec, 0x0D, 0x18);
-			break;
-		case QUIRK_R3DI:
-			chipio_set_control_param(codec, 0x0D, 0x24);
-			r3di_gpio_out_set(codec, R3DI_LINE_OUT);
-			break;
-		case QUIRK_R3D:
-			ca0113_mmio_gpio_set(codec, 1, true);
-			chipio_set_control_param(codec, 0x0D, 0x24);
-			break;
-		}
+
 		/* enable line out node */
 		pin_ctl = snd_hda_codec_read(codec, spec->out_pins[0], 0,
 				AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
-- 
2.7.4
