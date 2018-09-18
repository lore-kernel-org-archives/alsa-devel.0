From: Connor McAdams <conmanx360@gmail.com>
Subject: [PATCH 12/15] ALSA: hda/ca0132 - Add output set commands for AE-5
Date: Tue, 18 Sep 2018 14:33:40 -0400
Message-ID: <1537295625-8082-13-git-send-email-conmanx360@gmail.com>
References: <1537295625-8082-1-git-send-email-conmanx360@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537295625-8082-1-git-send-email-conmanx360@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Alastair Bridgewater <alastair.bridgewater@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch adds output selection commands for the AE-5.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 79 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 69 insertions(+), 10 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 4de94d7..364c3fe 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -666,6 +666,29 @@ static const struct ct_dsp_volume_ctl ca0132_alt_vol_ctls[] = {
 	}
 };
 
+/* Values for ca0113_mmio_command_set for selecting output. */
+#define AE5_CA0113_OUT_SET_COMMANDS 6
+struct ae5_ca0113_output_set {
+	unsigned int group[AE5_CA0113_OUT_SET_COMMANDS];
+	unsigned int target[AE5_CA0113_OUT_SET_COMMANDS];
+	unsigned int vals[AE5_CA0113_OUT_SET_COMMANDS];
+};
+
+static const struct ae5_ca0113_output_set ae5_ca0113_output_presets[] = {
+	{ .group =  { 0x30, 0x30, 0x48, 0x48, 0x48, 0x30 },
+	  .target = { 0x2e, 0x30, 0x0d, 0x17, 0x19, 0x32 },
+	  .vals =   { 0x00, 0x00, 0x40, 0x00, 0x00, 0x3f }
+	},
+	{ .group =  { 0x30, 0x30, 0x48, 0x48, 0x48, 0x30 },
+	  .target = { 0x2e, 0x30, 0x0d, 0x17, 0x19, 0x32 },
+	  .vals =   { 0x3f, 0x3f, 0x00, 0x00, 0x00, 0x00 }
+	},
+	{ .group =  { 0x30, 0x30, 0x48, 0x48, 0x48, 0x30 },
+	  .target = { 0x2e, 0x30, 0x0d, 0x17, 0x19, 0x32 },
+	  .vals =   { 0x00, 0x00, 0x40, 0x00, 0x00, 0x3f }
+	}
+};
+
 enum hda_cmd_vendor_io {
 	/* for DspIO node */
 	VENDOR_DSPIO_SCP_WRITE_DATA_LOW      = 0x000,
@@ -4025,6 +4048,18 @@ static int ca0132_select_out(struct hda_codec *codec)
 	return err < 0 ? err : 0;
 }
 
+static void ae5_mmio_select_out(struct hda_codec *codec)
+{
+	struct ca0132_spec *spec = codec->spec;
+	unsigned int i;
+
+	for (i = 0; i < AE5_CA0113_OUT_SET_COMMANDS; i++)
+		ca0113_mmio_command_set(codec,
+			ae5_ca0113_output_presets[spec->cur_out_type].group[i],
+			ae5_ca0113_output_presets[spec->cur_out_type].target[i],
+			ae5_ca0113_output_presets[spec->cur_out_type].vals[i]);
+}
+
 /*
  * These are the commands needed to setup output on each of the different card
  * types.
@@ -4041,16 +4076,24 @@ static void ca0132_alt_select_out_quirk_handler(struct hda_codec *codec)
 			ca0113_mmio_gpio_set(codec, 7, false);
 			ca0113_mmio_gpio_set(codec, 4, true);
 			ca0113_mmio_gpio_set(codec, 1, true);
-			chipio_set_control_param(codec, 0x0D, 0x18);
+			chipio_set_control_param(codec, 0x0d, 0x18);
 			break;
 		case QUIRK_R3DI:
-			chipio_set_control_param(codec, 0x0D, 0x24);
+			chipio_set_control_param(codec, 0x0d, 0x24);
 			r3di_gpio_out_set(codec, R3DI_LINE_OUT);
 			break;
 		case QUIRK_R3D:
-			chipio_set_control_param(codec, 0x0D, 0x24);
+			chipio_set_control_param(codec, 0x0d, 0x24);
 			ca0113_mmio_gpio_set(codec, 1, true);
 			break;
+		case QUIRK_AE5:
+			ae5_mmio_select_out(codec);
+			tmp = FLOAT_ZERO;
+			dspio_set_uint_param(codec, 0x96, 0x29, tmp);
+			dspio_set_uint_param(codec, 0x96, 0x2a, tmp);
+			chipio_set_control_param(codec, 0x0d, 0xa4);
+			chipio_write(codec, 0x18b03c, 0x00000012);
+			break;
 		}
 		break;
 	case HEADPHONE_OUT:
@@ -4059,16 +4102,24 @@ static void ca0132_alt_select_out_quirk_handler(struct hda_codec *codec)
 			ca0113_mmio_gpio_set(codec, 7, true);
 			ca0113_mmio_gpio_set(codec, 4, true);
 			ca0113_mmio_gpio_set(codec, 1, false);
-			chipio_set_control_param(codec, 0x0D, 0x12);
+			chipio_set_control_param(codec, 0x0d, 0x12);
 			break;
 		case QUIRK_R3DI:
-			chipio_set_control_param(codec, 0x0D, 0x21);
+			chipio_set_control_param(codec, 0x0d, 0x21);
 			r3di_gpio_out_set(codec, R3DI_HEADPHONE_OUT);
 			break;
 		case QUIRK_R3D:
-			chipio_set_control_param(codec, 0x0D, 0x21);
+			chipio_set_control_param(codec, 0x0d, 0x21);
 			ca0113_mmio_gpio_set(codec, 0x1, false);
 			break;
+		case QUIRK_AE5:
+			ae5_mmio_select_out(codec);
+			tmp = FLOAT_ONE;
+			dspio_set_uint_param(codec, 0x96, 0x29, tmp);
+			dspio_set_uint_param(codec, 0x96, 0x2a, tmp);
+			chipio_set_control_param(codec, 0x0d, 0xa1);
+			chipio_write(codec, 0x18b03c, 0x00000012);
+			break;
 		}
 		break;
 	case SURROUND_OUT:
@@ -4077,15 +4128,23 @@ static void ca0132_alt_select_out_quirk_handler(struct hda_codec *codec)
 			ca0113_mmio_gpio_set(codec, 7, false);
 			ca0113_mmio_gpio_set(codec, 4, true);
 			ca0113_mmio_gpio_set(codec, 1, true);
-			chipio_set_control_param(codec, 0x0D, 0x18);
+			chipio_set_control_param(codec, 0x0d, 0x18);
 			break;
 		case QUIRK_R3DI:
-			chipio_set_control_param(codec, 0x0D, 0x24);
+			chipio_set_control_param(codec, 0x0d, 0x24);
 			r3di_gpio_out_set(codec, R3DI_LINE_OUT);
 			break;
 		case QUIRK_R3D:
 			ca0113_mmio_gpio_set(codec, 1, true);
-			chipio_set_control_param(codec, 0x0D, 0x24);
+			chipio_set_control_param(codec, 0x0d, 0x24);
+			break;
+		case QUIRK_AE5:
+			ae5_mmio_select_out(codec);
+			tmp = FLOAT_ZERO;
+			dspio_set_uint_param(codec, 0x96, 0x29, tmp);
+			dspio_set_uint_param(codec, 0x96, 0x2a, tmp);
+			chipio_set_control_param(codec, 0x0d, 0xa4);
+			chipio_write(codec, 0x18b03c, 0x00000012);
 			break;
 		}
 		break;
@@ -4231,7 +4290,7 @@ static int ca0132_alt_select_out(struct hda_codec *codec)
 		break;
 	}
 
-	/* run through the output dsp commands for line-out */
+	/* run through the output dsp commands for the selected output. */
 	for (i = 0; i < alt_out_presets[spec->cur_out_type].commands; i++) {
 		err = dspio_set_uint_param(codec,
 		alt_out_presets[spec->cur_out_type].mids[i],
-- 
2.7.4
