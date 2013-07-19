From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 08/13] ALSA: hda - Convert the static quirk for
	Samsung Q1 Ultra
Date: Fri, 19 Jul 2013 17:12:17 +0200
Message-ID: <1374246742-14373-9-git-send-email-tiwai@suse.de>
References: <1374246742-14373-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B1704265768
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 17:11:12 +0200 (CEST)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 91327A5396
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

... to a fixup entry.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_analog.c | 33 ++++++++++-----------------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
index 7777a3a..056810c 100644
--- a/sound/pci/hda/patch_analog.c
+++ b/sound/pci/hda/patch_analog.c
@@ -1063,17 +1063,6 @@ static const struct hda_verb ad1986a_automic_verbs[] = {
 	{}
 };
 
-/* Ultra initialization */
-static const struct hda_verb ad1986a_ultra_init[] = {
-	/* eapd initialization */
-	{ 0x1b, AC_VERB_SET_EAPD_BTLENABLE, 0x00 },
-	/* CLFE -> Mic in */
-	{ 0x0f, AC_VERB_SET_CONNECT_SEL, 0x2 },
-	{ 0x1d, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x24 },
-	{ 0x1d, AC_VERB_SET_AMP_GAIN_MUTE, 0xb080 },
-	{ } /* end */
-};
-
 /* pin sensing on HP jack */
 static const struct hda_verb ad1986a_hp_init_verbs[] = {
 	{0x1a, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | AD1986A_HP_EVENT},
@@ -1110,7 +1099,6 @@ enum {
 	AD1986A_LAPTOP,
 	AD1986A_LAPTOP_EAPD,
 	AD1986A_LAPTOP_AUTOMUTE,
-	AD1986A_ULTRA,
 	AD1986A_SAMSUNG,
 	AD1986A_SAMSUNG_P50,
 	AD1986A_MODELS
@@ -1123,7 +1111,6 @@ static const char * const ad1986a_models[AD1986A_MODELS] = {
 	[AD1986A_LAPTOP]	= "laptop",
 	[AD1986A_LAPTOP_EAPD]	= "laptop-eapd",
 	[AD1986A_LAPTOP_AUTOMUTE] = "laptop-automute",
-	[AD1986A_ULTRA]		= "ultra",
 	[AD1986A_SAMSUNG]	= "samsung",
 	[AD1986A_SAMSUNG_P50]	= "samsung-p50",
 };
@@ -1149,7 +1136,6 @@ static const struct snd_pci_quirk ad1986a_cfg_tbl[] = {
 	SND_PCI_QUIRK(0x144d, 0xb03c, "Samsung R55", AD1986A_3STACK),
 	SND_PCI_QUIRK(0x144d, 0xc01e, "FSC V2060", AD1986A_LAPTOP),
 	SND_PCI_QUIRK(0x144d, 0xc024, "Samsung P50", AD1986A_SAMSUNG_P50),
-	SND_PCI_QUIRK(0x144d, 0xc027, "Samsung Q1", AD1986A_ULTRA),
 	SND_PCI_QUIRK_MASK(0x144d, 0xff00, 0xc000, "Samsung", AD1986A_SAMSUNG),
 	SND_PCI_QUIRK(0x144d, 0xc504, "Samsung Q35", AD1986A_3STACK),
 	SND_PCI_QUIRK(0x17aa, 0x1011, "Lenovo M55", AD1986A_LAPTOP),
@@ -1203,6 +1189,7 @@ static void ad_fixup_inv_jack_detect(struct hda_codec *codec,
 
 enum {
 	AD1986A_FIXUP_INV_JACK_DETECT,
+	AD1986A_FIXUP_ULTRA,
 };
 
 static const struct hda_fixup ad1986a_fixups[] = {
@@ -1210,9 +1197,18 @@ static const struct hda_fixup ad1986a_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = ad_fixup_inv_jack_detect,
 	},
+	[AD1986A_FIXUP_ULTRA] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x1b, 0x90170110 }, /* speaker */
+			{ 0x1d, 0x90a7013e }, /* int mic */
+			{}
+		},
+	},
 };
 
 static const struct snd_pci_quirk ad1986a_fixup_tbl[] = {
+	SND_PCI_QUIRK(0x144d, 0xc027, "Samsung Q1", AD1986A_FIXUP_ULTRA),
 	SND_PCI_QUIRK(0x17aa, 0x2066, "Lenovo N100", AD1986A_FIXUP_INV_JACK_DETECT),
 	{}
 };
@@ -1395,15 +1391,6 @@ static int patch_ad1986a(struct hda_codec *codec)
 		 */
 		spec->inv_jack_detect = 1;
 		break;
-	case AD1986A_ULTRA:
-		spec->mixers[0] = ad1986a_laptop_eapd_mixers;
-		spec->num_init_verbs = 2;
-		spec->init_verbs[1] = ad1986a_ultra_init;
-		spec->multiout.max_channels = 2;
-		spec->multiout.num_dacs = 1;
-		spec->multiout.dac_nids = ad1986a_laptop_dac_nids;
-		spec->multiout.dig_out_nid = 0;
-		break;
 	}
 
 	/* AD1986A has a hardware problem that it can't share a stream
-- 
1.8.3.1
