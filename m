From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 09/13] ALSA: hda - Convert static quirks for
	AD1986A Samsung laptops
Date: Fri, 19 Jul 2013 17:12:18 +0200
Message-ID: <1374246742-14373-10-git-send-email-tiwai@suse.de>
References: <1374246742-14373-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B4BA1265769
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 17:11:12 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 91213A538E
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 17:11:12 +0200 (CEST)
In-Reply-To: <1374246742-14373-1-git-send-email-tiwai@suse.de>
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

Just need to override some pin-configurations.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_analog.c | 108 +++++--------------------------------------
 1 file changed, 12 insertions(+), 96 deletions(-)

diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
index 056810c..1e4dc98 100644
--- a/sound/pci/hda/patch_analog.c
+++ b/sound/pci/hda/patch_analog.c
@@ -857,33 +857,6 @@ static const struct snd_kcontrol_new ad1986a_laptop_intmic_mixers[] = {
 	{ } /* end */
 };
 
-/* re-connect the mic boost input according to the jack sensing */
-static void ad1986a_automic(struct hda_codec *codec)
-{
-	unsigned int present;
-	present = snd_hda_jack_detect(codec, 0x1f);
-	/* 0 = 0x1f, 2 = 0x1d, 4 = mixed */
-	snd_hda_codec_write(codec, 0x0f, 0, AC_VERB_SET_CONNECT_SEL,
-			    present ? 0 : 2);
-}
-
-#define AD1986A_MIC_EVENT		0x36
-
-static void ad1986a_automic_unsol_event(struct hda_codec *codec,
-					    unsigned int res)
-{
-	if ((res >> 26) != AD1986A_MIC_EVENT)
-		return;
-	ad1986a_automic(codec);
-}
-
-static int ad1986a_automic_init(struct hda_codec *codec)
-{
-	ad198x_init(codec);
-	ad1986a_automic(codec);
-	return 0;
-}
-
 /* laptop-automute - 2ch only */
 
 static void ad1986a_update_hp(struct hda_codec *codec)
@@ -1054,42 +1027,12 @@ static const struct hda_verb ad1986a_eapd_init_verbs[] = {
 	{}
 };
 
-static const struct hda_verb ad1986a_automic_verbs[] = {
-	{0x1d, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80},
-	{0x1f, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80},
-	/*{0x20, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80},*/
-	{0x0f, AC_VERB_SET_CONNECT_SEL, 0x0},
-	{0x1f, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | AD1986A_MIC_EVENT},
-	{}
-};
-
 /* pin sensing on HP jack */
 static const struct hda_verb ad1986a_hp_init_verbs[] = {
 	{0x1a, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | AD1986A_HP_EVENT},
 	{}
 };
 
-static void ad1986a_samsung_p50_unsol_event(struct hda_codec *codec,
-					    unsigned int res)
-{
-	switch (res >> 26) {
-	case AD1986A_HP_EVENT:
-		ad1986a_hp_automute(codec);
-		break;
-	case AD1986A_MIC_EVENT:
-		ad1986a_automic(codec);
-		break;
-	}
-}
-
-static int ad1986a_samsung_p50_init(struct hda_codec *codec)
-{
-	ad198x_init(codec);
-	ad1986a_hp_automute(codec);
-	ad1986a_automic(codec);
-	return 0;
-}
-
 
 /* models */
 enum {
@@ -1099,8 +1042,6 @@ enum {
 	AD1986A_LAPTOP,
 	AD1986A_LAPTOP_EAPD,
 	AD1986A_LAPTOP_AUTOMUTE,
-	AD1986A_SAMSUNG,
-	AD1986A_SAMSUNG_P50,
 	AD1986A_MODELS
 };
 
@@ -1111,8 +1052,6 @@ static const char * const ad1986a_models[AD1986A_MODELS] = {
 	[AD1986A_LAPTOP]	= "laptop",
 	[AD1986A_LAPTOP_EAPD]	= "laptop-eapd",
 	[AD1986A_LAPTOP_AUTOMUTE] = "laptop-automute",
-	[AD1986A_SAMSUNG]	= "samsung",
-	[AD1986A_SAMSUNG_P50]	= "samsung-p50",
 };
 
 static const struct snd_pci_quirk ad1986a_cfg_tbl[] = {
@@ -1135,8 +1074,6 @@ static const struct snd_pci_quirk ad1986a_cfg_tbl[] = {
 	SND_PCI_QUIRK(0x1179, 0xff40, "Toshiba Satellite L40-10Q", AD1986A_3STACK),
 	SND_PCI_QUIRK(0x144d, 0xb03c, "Samsung R55", AD1986A_3STACK),
 	SND_PCI_QUIRK(0x144d, 0xc01e, "FSC V2060", AD1986A_LAPTOP),
-	SND_PCI_QUIRK(0x144d, 0xc024, "Samsung P50", AD1986A_SAMSUNG_P50),
-	SND_PCI_QUIRK_MASK(0x144d, 0xff00, 0xc000, "Samsung", AD1986A_SAMSUNG),
 	SND_PCI_QUIRK(0x144d, 0xc504, "Samsung Q35", AD1986A_3STACK),
 	SND_PCI_QUIRK(0x17aa, 0x1011, "Lenovo M55", AD1986A_LAPTOP),
 	SND_PCI_QUIRK(0x17aa, 0x1017, "Lenovo A60", AD1986A_3STACK),
@@ -1190,6 +1127,7 @@ static void ad_fixup_inv_jack_detect(struct hda_codec *codec,
 enum {
 	AD1986A_FIXUP_INV_JACK_DETECT,
 	AD1986A_FIXUP_ULTRA,
+	AD1986A_FIXUP_SAMSUNG,
 };
 
 static const struct hda_fixup ad1986a_fixups[] = {
@@ -1205,9 +1143,20 @@ static const struct hda_fixup ad1986a_fixups[] = {
 			{}
 		},
 	},
+	[AD1986A_FIXUP_SAMSUNG] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x1b, 0x90170110 }, /* speaker */
+			{ 0x1d, 0x90a7013e }, /* int mic */
+			{ 0x20, 0x411111f0 }, /* N/A */
+			{ 0x24, 0x411111f0 }, /* N/A */
+			{}
+		},
+	},
 };
 
 static const struct snd_pci_quirk ad1986a_fixup_tbl[] = {
+	SND_PCI_QUIRK_MASK(0x144d, 0xff00, 0xc000, "Samsung", AD1986A_FIXUP_SAMSUNG),
 	SND_PCI_QUIRK(0x144d, 0xc027, "Samsung Q1", AD1986A_FIXUP_ULTRA),
 	SND_PCI_QUIRK(0x17aa, 0x2066, "Lenovo N100", AD1986A_FIXUP_INV_JACK_DETECT),
 	{}
@@ -1337,39 +1286,6 @@ static int patch_ad1986a(struct hda_codec *codec)
 			spec->multiout.dig_out_nid = 0;
 		spec->input_mux = &ad1986a_laptop_eapd_capture_source;
 		break;
-	case AD1986A_SAMSUNG:
-		spec->num_mixers = 2;
-		spec->mixers[0] = ad1986a_laptop_master_mixers;
-		spec->mixers[1] = ad1986a_laptop_eapd_mixers;
-		spec->num_init_verbs = 3;
-		spec->init_verbs[1] = ad1986a_eapd_init_verbs;
-		spec->init_verbs[2] = ad1986a_automic_verbs;
-		spec->multiout.max_channels = 2;
-		spec->multiout.num_dacs = 1;
-		spec->multiout.dac_nids = ad1986a_laptop_dac_nids;
-		if (!is_jack_available(codec, 0x25))
-			spec->multiout.dig_out_nid = 0;
-		spec->input_mux = &ad1986a_automic_capture_source;
-		codec->patch_ops.unsol_event = ad1986a_automic_unsol_event;
-		codec->patch_ops.init = ad1986a_automic_init;
-		break;
-	case AD1986A_SAMSUNG_P50:
-		spec->num_mixers = 2;
-		spec->mixers[0] = ad1986a_automute_master_mixers;
-		spec->mixers[1] = ad1986a_laptop_eapd_mixers;
-		spec->num_init_verbs = 4;
-		spec->init_verbs[1] = ad1986a_eapd_init_verbs;
-		spec->init_verbs[2] = ad1986a_automic_verbs;
-		spec->init_verbs[3] = ad1986a_hp_init_verbs;
-		spec->multiout.max_channels = 2;
-		spec->multiout.num_dacs = 1;
-		spec->multiout.dac_nids = ad1986a_laptop_dac_nids;
-		if (!is_jack_available(codec, 0x25))
-			spec->multiout.dig_out_nid = 0;
-		spec->input_mux = &ad1986a_automic_capture_source;
-		codec->patch_ops.unsol_event = ad1986a_samsung_p50_unsol_event;
-		codec->patch_ops.init = ad1986a_samsung_p50_init;
-		break;
 	case AD1986A_LAPTOP_AUTOMUTE:
 		spec->num_mixers = 3;
 		spec->mixers[0] = ad1986a_automute_master_mixers;
-- 
1.8.3.1
