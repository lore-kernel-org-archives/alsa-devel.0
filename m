From: Connor McAdams <conmanx360@gmail.com>
Subject: [PATCH 07/11] ALSA: hda/ca0132 - Add Recon3D startup functions and setup
Date: Wed,  8 Aug 2018 13:34:18 -0400
Message-ID: <1533749663-8200-8-git-send-email-conmanx360@gmail.com>
References: <1533749663-8200-1-git-send-email-conmanx360@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533749663-8200-1-git-send-email-conmanx360@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Connor McAdams <conmanx360@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Alastair Bridgewater <alastair.bridgewater@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch adds functions for Recon3D startup, and sets values for
things such as use_pci_mmio. It also renames some functions and tables
from the sbz prefix into ca0132, as the Recon3D uses them as well.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 49 ++++++++++++++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 13 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index b35b179..cb84648 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -897,7 +897,7 @@ struct ca0132_spec {
 	const struct hda_verb *base_init_verbs;
 	const struct hda_verb *base_exit_verbs;
 	const struct hda_verb *chip_init_verbs;
-	const struct hda_verb *sbz_init_verbs;
+	const struct hda_verb *desktop_init_verbs;
 	struct hda_verb *spec_init_verbs;
 	struct auto_pin_cfg autocfg;
 
@@ -6840,8 +6840,8 @@ static struct hda_verb ca0132_init_verbs0[] = {
 	{}
 };
 
-/* Extra init verbs for SBZ */
-static struct hda_verb sbz_init_verbs[] = {
+/* Extra init verbs for desktop cards. */
+static struct hda_verb ca0132_init_verbs1[] = {
 	{0x15, 0x70D, 0x20},
 	{0x15, 0x70E, 0x19},
 	{0x15, 0x707, 0x00},
@@ -7136,9 +7136,27 @@ static void sbz_pre_dsp_setup(struct hda_codec *codec)
 			AC_VERB_SET_PIN_WIDGET_CONTROL, 0x44);
 }
 
-/*
- * Extra commands that don't really fit anywhere else.
- */
+static void r3d_pre_dsp_setup(struct hda_codec *codec)
+{
+
+	snd_hda_codec_write(codec, 0x15, 0, 0xd00, 0xfc);
+	snd_hda_codec_write(codec, 0x15, 0, 0xd00, 0xfd);
+	snd_hda_codec_write(codec, 0x15, 0, 0xd00, 0xfe);
+	snd_hda_codec_write(codec, 0x15, 0, 0xd00, 0xff);
+
+	chipio_write(codec, 0x18b0a4, 0x000000c2);
+
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+			    VENDOR_CHIPIO_8051_ADDRESS_LOW, 0x1E);
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+			    VENDOR_CHIPIO_8051_ADDRESS_HIGH, 0x1C);
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+			    VENDOR_CHIPIO_8051_DATA_WRITE, 0x5B);
+
+	snd_hda_codec_write(codec, 0x11, 0,
+			AC_VERB_SET_PIN_WIDGET_CONTROL, 0x44);
+}
+
 static void r3di_pre_dsp_setup(struct hda_codec *codec)
 {
 	chipio_write(codec, 0x18b0a4, 0x000000c2);
@@ -7163,13 +7181,12 @@ static void r3di_pre_dsp_setup(struct hda_codec *codec)
 			AC_VERB_SET_PIN_WIDGET_CONTROL, 0x04);
 }
 
-
 /*
  * These are sent before the DSP is downloaded. Not sure
  * what they do, or if they're necessary. Could possibly
  * be removed. Figure they're better to leave in.
  */
-static void sbz_region2_startup(struct hda_codec *codec)
+static void ca0132_mmio_init(struct hda_codec *codec)
 {
 	struct ca0132_spec *spec = codec->spec;
 
@@ -7209,7 +7226,7 @@ static void ca0132_alt_init(struct hda_codec *codec)
 		ca0132_gpio_init(codec);
 		sbz_pre_dsp_setup(codec);
 		snd_hda_sequence_write(codec, spec->chip_init_verbs);
-		snd_hda_sequence_write(codec, spec->sbz_init_verbs);
+		snd_hda_sequence_write(codec, spec->desktop_init_verbs);
 		break;
 	case QUIRK_R3DI:
 		codec_dbg(codec, "R3DI alt_init");
@@ -7220,6 +7237,11 @@ static void ca0132_alt_init(struct hda_codec *codec)
 		snd_hda_sequence_write(codec, spec->chip_init_verbs);
 		snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0, 0x6FF, 0xC4);
 		break;
+	case QUIRK_R3D:
+		r3d_pre_dsp_setup(codec);
+		snd_hda_sequence_write(codec, spec->chip_init_verbs);
+		snd_hda_sequence_write(codec, spec->desktop_init_verbs);
+		break;
 	}
 }
 
@@ -7256,8 +7278,8 @@ static int ca0132_init(struct hda_codec *codec)
 		spec->dsp_state = DSP_DOWNLOAD_INIT;
 	spec->curr_chip_addx = INVALID_CHIP_ADDRESS;
 
-	if (spec->quirk == QUIRK_SBZ)
-		sbz_region2_startup(codec);
+	if (spec->use_pci_mmio)
+		ca0132_mmio_init(codec);
 
 	snd_hda_power_up_pm(codec);
 
@@ -7508,8 +7530,8 @@ static int ca0132_prepare_verbs(struct hda_codec *codec)
 	struct ca0132_spec *spec = codec->spec;
 
 	spec->chip_init_verbs = ca0132_init_verbs0;
-	if (spec->quirk == QUIRK_SBZ)
-		spec->sbz_init_verbs = sbz_init_verbs;
+	if (spec->quirk == QUIRK_SBZ || spec->quirk == QUIRK_R3D)
+		spec->desktop_init_verbs = ca0132_init_verbs1;
 	spec->spec_init_verbs = kcalloc(NUM_SPEC_VERBS,
 					sizeof(struct hda_verb),
 					GFP_KERNEL);
@@ -7586,6 +7608,7 @@ static int patch_ca0132(struct hda_codec *codec)
 	/* Setup whether or not to use alt functions/controls/pci_mmio */
 	switch (spec->quirk) {
 	case QUIRK_SBZ:
+	case QUIRK_R3D:
 		spec->use_alt_controls = true;
 		spec->use_alt_functions = true;
 		spec->use_pci_mmio = true;
-- 
2.7.4
