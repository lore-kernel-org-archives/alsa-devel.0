From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 32/38] ALSA: hda/realtek - Remove the last
	static quirks for ALC882
Date: Fri, 24 Feb 2012 17:36:25 +0100
Message-ID: <1330101391-8788-33-git-send-email-tiwai@suse.de>
References: <1330101391-8788-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 6D31510B8C0
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 17:36:34 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id ABF8B92B66
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 17:36:33 +0100 (CET)
In-Reply-To: <1330101391-8788-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Resitance is futile.  The remaining static model quirks for Apple
machines with ALC882-compatible codecs are converted to the auto-parser
now.  We can remove all alc*_quirks.c finally.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c |  143 ++++++++++++++++++++++++++---------------
 1 files changed, 92 insertions(+), 51 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 3c6f5b5..c5216b5 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4808,21 +4808,6 @@ static const struct alc_model_fixup alc880_fixup_models[] = {
 
 
 /*
- * board setups
- */
-#ifdef CONFIG_SND_HDA_ENABLE_REALTEK_QUIRKS
-#define alc_board_config \
-	snd_hda_check_board_config
-#define alc_board_codec_sid_config \
-	snd_hda_check_board_codec_sid_config
-#include "alc_quirks.c"
-#else
-#define alc_board_config(codec, nums, models, tbl)	-1
-#define alc_board_codec_sid_config(codec, nums, models, tbl)	-1
-#define setup_preset(codec, x)	/* NOP */
-#endif
-
-/*
  * OK, here we have finally the patch for ALC880
  */
 static int patch_alc880(struct hda_codec *codec)
@@ -5091,6 +5076,8 @@ enum {
 	ALC882_FIXUP_EAPD,
 	ALC883_FIXUP_EAPD,
 	ALC883_FIXUP_ACER_EAPD,
+	ALC882_FIXUP_GPIO1,
+	ALC882_FIXUP_GPIO2,
 	ALC882_FIXUP_GPIO3,
 	ALC889_FIXUP_COEF,
 	ALC882_FIXUP_ASUS_W2JC,
@@ -5099,6 +5086,8 @@ enum {
 	ALC882_FIXUP_ASPIRE_8930G_VERBS,
 	ALC885_FIXUP_MACPRO_GPIO,
 	ALC889_FIXUP_DAC_ROUTE,
+	ALC889_FIXUP_MBP_VREF,
+	ALC889_FIXUP_IMAC91_VREF,
 };
 
 static void alc889_fixup_coef(struct hda_codec *codec,
@@ -5169,6 +5158,51 @@ static void alc889_fixup_dac_route(struct hda_codec *codec,
 	}
 }
 
+/* Set VREF on HP pin */
+static void alc889_fixup_mbp_vref(struct hda_codec *codec,
+				  const struct alc_fixup *fix, int action)
+{
+	struct alc_spec *spec = codec->spec;
+	static hda_nid_t nids[2] = { 0x14, 0x15 };
+	int i;
+
+	if (action != ALC_FIXUP_ACT_INIT)
+		return;
+	for (i = 0; i < ARRAY_SIZE(nids); i++) {
+		unsigned int val = snd_hda_codec_get_pincfg(codec, nids[i]);
+		if (get_defcfg_device(val) != AC_JACK_HP_OUT)
+			continue;
+		val = snd_hda_codec_read(codec, nids[i], 0,
+					 AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
+		val |= AC_PINCTL_VREF_80;
+		snd_hda_codec_write(codec, nids[i], 0,
+				    AC_VERB_SET_PIN_WIDGET_CONTROL, val);
+		spec->keep_vref_in_automute = 1;
+		break;
+	}
+}
+
+/* Set VREF on speaker pins on imac91 */
+static void alc889_fixup_imac91_vref(struct hda_codec *codec,
+				     const struct alc_fixup *fix, int action)
+{
+	struct alc_spec *spec = codec->spec;
+	static hda_nid_t nids[2] = { 0x18, 0x1a };
+	int i;
+
+	if (action != ALC_FIXUP_ACT_INIT)
+		return;
+	for (i = 0; i < ARRAY_SIZE(nids); i++) {
+		unsigned int val;
+		val = snd_hda_codec_read(codec, nids[i], 0,
+					 AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
+		val |= AC_PINCTL_VREF_50;
+		snd_hda_codec_write(codec, nids[i], 0,
+				    AC_VERB_SET_PIN_WIDGET_CONTROL, val);
+	}
+	spec->keep_vref_in_automute = 1;
+}
+
 static const struct alc_fixup alc882_fixups[] = {
 	[ALC882_FIXUP_ABIT_AW9D_MAX] = {
 		.type = ALC_FIXUP_PINS,
@@ -5247,6 +5281,14 @@ static const struct alc_fixup alc882_fixups[] = {
 			{ }
 		}
 	},
+	[ALC882_FIXUP_GPIO1] = {
+		.type = ALC_FIXUP_VERBS,
+		.v.verbs = alc_gpio1_init_verbs,
+	},
+	[ALC882_FIXUP_GPIO2] = {
+		.type = ALC_FIXUP_VERBS,
+		.v.verbs = alc_gpio2_init_verbs,
+	},
 	[ALC882_FIXUP_GPIO3] = {
 		.type = ALC_FIXUP_VERBS,
 		.v.verbs = alc_gpio3_init_verbs,
@@ -5320,6 +5362,18 @@ static const struct alc_fixup alc882_fixups[] = {
 		.type = ALC_FIXUP_FUNC,
 		.v.func = alc889_fixup_dac_route,
 	},
+	[ALC889_FIXUP_MBP_VREF] = {
+		.type = ALC_FIXUP_FUNC,
+		.v.func = alc889_fixup_mbp_vref,
+		.chained = true,
+		.chain_id = ALC882_FIXUP_GPIO1,
+	},
+	[ALC889_FIXUP_IMAC91_VREF] = {
+		.type = ALC_FIXUP_FUNC,
+		.v.func = alc889_fixup_imac91_vref,
+		.chained = true,
+		.chain_id = ALC882_FIXUP_GPIO1,
+	},
 };
 
 static const struct snd_pci_quirk alc882_fixup_tbl[] = {
@@ -5353,11 +5407,26 @@ static const struct snd_pci_quirk alc882_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x104d, 0x9047, "Sony Vaio TT", ALC889_FIXUP_VAIO_TT),
 
 	/* All Apple entries are in codec SSIDs */
+	SND_PCI_QUIRK(0x106b, 0x00a0, "MacBookPro 3,1", ALC889_FIXUP_MBP_VREF),
+	SND_PCI_QUIRK(0x106b, 0x00a1, "Macbook", ALC889_FIXUP_MBP_VREF),
+	SND_PCI_QUIRK(0x106b, 0x00a4, "MacbookPro 4,1", ALC889_FIXUP_MBP_VREF),
 	SND_PCI_QUIRK(0x106b, 0x0c00, "Mac Pro", ALC885_FIXUP_MACPRO_GPIO),
 	SND_PCI_QUIRK(0x106b, 0x1000, "iMac 24", ALC885_FIXUP_MACPRO_GPIO),
 	SND_PCI_QUIRK(0x106b, 0x2800, "AppleTV", ALC885_FIXUP_MACPRO_GPIO),
+	SND_PCI_QUIRK(0x106b, 0x2c00, "MacbookPro rev3", ALC889_FIXUP_MBP_VREF),
+	SND_PCI_QUIRK(0x106b, 0x3000, "iMac", ALC889_FIXUP_MBP_VREF),
 	SND_PCI_QUIRK(0x106b, 0x3200, "iMac 7,1 Aluminum", ALC882_FIXUP_EAPD),
+	SND_PCI_QUIRK(0x106b, 0x3400, "MacBookAir 1,1", ALC889_FIXUP_MBP_VREF),
+	SND_PCI_QUIRK(0x106b, 0x3500, "MacBookAir 2,1", ALC889_FIXUP_MBP_VREF),
+	SND_PCI_QUIRK(0x106b, 0x3600, "Macbook 3,1", ALC889_FIXUP_MBP_VREF),
+	SND_PCI_QUIRK(0x106b, 0x3800, "MacbookPro 4,1", ALC889_FIXUP_MBP_VREF),
 	SND_PCI_QUIRK(0x106b, 0x3e00, "iMac 24 Aluminum", ALC885_FIXUP_MACPRO_GPIO),
+	SND_PCI_QUIRK(0x106b, 0x3f00, "Macbook 5,1", ALC889_FIXUP_IMAC91_VREF),
+	SND_PCI_QUIRK(0x106b, 0x4000, "MacbookPro 5,1", ALC889_FIXUP_IMAC91_VREF),
+	SND_PCI_QUIRK(0x106b, 0x4100, "Macmini 3,1", ALC889_FIXUP_IMAC91_VREF),
+	SND_PCI_QUIRK(0x106b, 0x4600, "MacbookPro 5,2", ALC889_FIXUP_IMAC91_VREF),
+	SND_PCI_QUIRK(0x106b, 0x4900, "iMac 9,1 Aluminum", ALC889_FIXUP_IMAC91_VREF),
+	SND_PCI_QUIRK(0x106b, 0x4a00, "Macbook 5,2", ALC889_FIXUP_IMAC91_VREF),
 
 	SND_PCI_QUIRK(0x1071, 0x8258, "Evesham Voyaeger", ALC882_FIXUP_EAPD),
 	SND_PCI_QUIRK_VENDOR(0x1462, "MSI", ALC882_FIXUP_GPIO3),
@@ -5382,14 +5451,10 @@ static int alc882_parse_auto_config(struct hda_codec *codec)
 
 /*
  */
-#ifdef CONFIG_SND_HDA_ENABLE_REALTEK_QUIRKS
-#include "alc882_quirks.c"
-#endif
-
 static int patch_alc882(struct hda_codec *codec)
 {
 	struct alc_spec *spec;
-	int err, board_config;
+	int err;
 
 	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
 	if (spec == NULL)
@@ -5413,36 +5478,15 @@ static int patch_alc882(struct hda_codec *codec)
 	if (err < 0)
 		goto error;
 
-	board_config = alc_board_config(codec, ALC882_MODEL_LAST,
-					alc882_models, NULL);
-	if (board_config < 0)
-		board_config = alc_board_codec_sid_config(codec,
-			ALC882_MODEL_LAST, alc882_models, alc882_ssid_cfg_tbl);
-
-	if (board_config < 0) {
-		printk(KERN_INFO "hda_codec: %s: BIOS auto-probing.\n",
-		       codec->chip_name);
-		board_config = ALC_MODEL_AUTO;
-	}
-
-	if (board_config == ALC_MODEL_AUTO) {
-		alc_pick_fixup(codec, NULL, alc882_fixup_tbl, alc882_fixups);
-		alc_apply_fixup(codec, ALC_FIXUP_ACT_PRE_PROBE);
-	}
+	alc_pick_fixup(codec, NULL, alc882_fixup_tbl, alc882_fixups);
+	alc_apply_fixup(codec, ALC_FIXUP_ACT_PRE_PROBE);
 
 	alc_auto_parse_customize_define(codec);
 
-	if (board_config == ALC_MODEL_AUTO) {
-		/* automatic parse from the BIOS config */
-		err = alc882_parse_auto_config(codec);
-		if (err < 0)
-			goto error;
-	}
-
-	if (board_config != ALC_MODEL_AUTO) {
-		setup_preset(codec, &alc882_presets[board_config]);
-		spec->vmaster_nid = 0x0c;
-	}
+	/* automatic parse from the BIOS config */
+	err = alc882_parse_auto_config(codec);
+	if (err < 0)
+		goto error;
 
 	if (!spec->no_analog && !spec->adc_nids) {
 		alc_auto_fill_adc_caps(codec);
@@ -5461,10 +5505,7 @@ static int patch_alc882(struct hda_codec *codec)
 	}
 
 	codec->patch_ops = alc_patch_ops;
-	if (board_config == ALC_MODEL_AUTO)
-		spec->init_hook = alc_auto_init_std;
-	else
-		codec->patch_ops.build_controls = __alc_build_controls;
+	spec->init_hook = alc_auto_init_std;
 
 #ifdef CONFIG_SND_HDA_POWER_SAVE
 	if (!spec->loopback.amplist)
-- 
1.7.9
