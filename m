From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH] ALSA: hda - adding a DAC/pin preference map for a HP Envy TS machine
Date: Mon, 15 Jun 2015 17:43:39 +0800
Message-ID: <1434361419-16042-1-git-send-email-hui.wang@canonical.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, stable@vger.kernel.org, hui.wang@canonical.com
List-Id: alsa-devel@alsa-project.org

On a HP Envy TouchSmart laptop, there are 2 speakers (main speaker
and subwoofer speaker), 1 headphone and 2 DACs, without this fixup,
the headphone will be assigned to a DAC and the 2 speakers will be
assigned to another DAC, this assignment makes the surround-2.1
channels invalid.

To fix it, here using a DAC/pin preference map to bind the main
speaker to 1 DAC and the subwoofer speaker will be assigned to another
DAC.

Cc: <stable@vger.kernel.org>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/pci/hda/patch_sigmatel.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index bdcda6a..dcc7fe9 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -100,6 +100,7 @@ enum {
 	STAC_HP_ENVY_BASS,
 	STAC_HP_BNB13_EQ,
 	STAC_HP_ENVY_TS_BASS,
+	STAC_HP_ENVY_TS_DAC_BIND,
 	STAC_92HD83XXX_GPIO10_EAPD,
 	STAC_92HD83XXX_MODELS
 };
@@ -2171,6 +2172,22 @@ static void stac92hd83xxx_fixup_gpio10_eapd(struct hda_codec *codec,
 	spec->eapd_switch = 0;
 }
 
+static void hp_envy_ts_fixup_dac_bind(struct hda_codec *codec,
+					    const struct hda_fixup *fix,
+					    int action)
+{
+	struct sigmatel_spec *spec = codec->spec;
+	static hda_nid_t preferred_pairs[] = {
+		0xd, 0x13,
+		0
+	};
+
+	if (action != HDA_FIXUP_ACT_PRE_PROBE)
+		return;
+
+	spec->gen.preferred_dacs = preferred_pairs;
+}
+
 static const struct hda_verb hp_bnb13_eq_verbs[] = {
 	/* 44.1KHz base */
 	{ 0x22, 0x7A6, 0x3E },
@@ -2686,6 +2703,12 @@ static const struct hda_fixup stac92hd83xxx_fixups[] = {
 			{}
 		},
 	},
+	[STAC_HP_ENVY_TS_DAC_BIND] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = hp_envy_ts_fixup_dac_bind,
+		.chained = true,
+		.chain_id = STAC_HP_ENVY_TS_BASS,
+	},
 	[STAC_92HD83XXX_GPIO10_EAPD] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = stac92hd83xxx_fixup_gpio10_eapd,
@@ -2764,6 +2787,8 @@ static const struct snd_pci_quirk stac92hd83xxx_fixup_tbl[] = {
 			  "HP bNB13", STAC_HP_BNB13_EQ),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x190e,
 			  "HP ENVY TS", STAC_HP_ENVY_TS_BASS),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x1967,
+			  "HP ENVY TS", STAC_HP_ENVY_TS_DAC_BIND),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x1940,
 			  "HP bNB13", STAC_HP_BNB13_EQ),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x1941,
-- 
1.9.1
