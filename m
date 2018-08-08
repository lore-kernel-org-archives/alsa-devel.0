From: Connor McAdams <conmanx360@gmail.com>
Subject: [PATCH 11/11] ALSA: hda/ca0132 - Add exit commands for Recon3D
Date: Wed,  8 Aug 2018 13:34:22 -0400
Message-ID: <1533749663-8200-12-git-send-email-conmanx360@gmail.com>
References: <1533749663-8200-1-git-send-email-conmanx360@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533749663-8200-1-git-send-email-conmanx360@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Connor McAdams <conmanx360@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Alastair Bridgewater <alastair.bridgewater@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch adds exit functions for the Recon3D, and cleans up the
current exit function.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 6f288d7..61ab735 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -6969,7 +6969,7 @@ static void sbz_set_pin_ctl_default(struct hda_codec *codec)
 				AC_VERB_SET_PIN_WIDGET_CONTROL, 0x00);
 }
 
-static void sbz_clear_unsolicited(struct hda_codec *codec)
+static void ca0132_clear_unsolicited(struct hda_codec *codec)
 {
 	hda_nid_t pins[7] = {0x0B, 0x0E, 0x0F, 0x10, 0x11, 0x12, 0x13};
 	unsigned int i;
@@ -7022,21 +7022,22 @@ static void sbz_exit_chip(struct hda_codec *codec)
 
 	chipio_set_control_param(codec, 0x0D, 0x24);
 
-	sbz_clear_unsolicited(codec);
+	ca0132_clear_unsolicited(codec);
 	sbz_set_pin_ctl_default(codec);
 
 	snd_hda_codec_write(codec, 0x0B, 0,
 		AC_VERB_SET_EAPD_BTLENABLE, 0x00);
 
-	if (dspload_is_loaded(codec))
-		dsp_reset(codec);
-
-	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-		VENDOR_CHIPIO_CT_EXTENSIONS_ENABLE, 0x00);
-
 	sbz_region2_exit(codec);
 }
 
+static void r3d_exit_chip(struct hda_codec *codec)
+{
+	ca0132_clear_unsolicited(codec);
+	snd_hda_codec_write(codec, 0x01, 0, 0x793, 0x00);
+	snd_hda_codec_write(codec, 0x01, 0, 0x794, 0x5b);
+}
+
 static void ca0132_exit_chip(struct hda_codec *codec)
 {
 	/* put any chip cleanup stuffs here. */
@@ -7382,16 +7383,17 @@ static void ca0132_free(struct hda_codec *codec)
 	case QUIRK_SBZ:
 		sbz_exit_chip(codec);
 		break;
+	case QUIRK_R3D:
+		r3d_exit_chip(codec);
+		break;
 	case QUIRK_R3DI:
 		r3di_gpio_shutdown(codec);
-		snd_hda_sequence_write(codec, spec->base_exit_verbs);
-		ca0132_exit_chip(codec);
-		break;
-	default:
-		snd_hda_sequence_write(codec, spec->base_exit_verbs);
-		ca0132_exit_chip(codec);
 		break;
 	}
+
+	snd_hda_sequence_write(codec, spec->base_exit_verbs);
+	ca0132_exit_chip(codec);
+
 	snd_hda_power_down(codec);
 	if (spec->mem_base)
 		iounmap(spec->mem_base);
-- 
2.7.4
