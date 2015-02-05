From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Set up GPIO for Toshiba Satellite
	S50D
Date: Thu,  5 Feb 2015 22:11:35 +0100
Message-ID: <1423170695-22045-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B1211260536
 for <alsa-devel@alsa-project.org>; Thu,  5 Feb 2015 22:11:45 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 72136AAF3
 for <alsa-devel@alsa-project.org>; Thu,  5 Feb 2015 21:11:45 +0000 (UTC)
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

Toshiba Satellite S50D laptop with an IDT codec uses the GPIO4 (0x10)
as the master EAPD.

Bugzilla: https://bugzilla.novell.com/show_bug.cgi?id=915858
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_sigmatel.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 605d14003d25..6d36c5b78805 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -99,6 +99,7 @@ enum {
 	STAC_HP_ENVY_BASS,
 	STAC_HP_BNB13_EQ,
 	STAC_HP_ENVY_TS_BASS,
+	STAC_92HD83XXX_GPIO10_EAPD,
 	STAC_92HD83XXX_MODELS
 };
 
@@ -2141,6 +2142,19 @@ static void stac92hd83xxx_fixup_headset_jack(struct hda_codec *codec,
 		spec->headset_jack = 1;
 }
 
+static void stac92hd83xxx_fixup_gpio10_eapd(struct hda_codec *codec,
+					    const struct hda_fixup *fix,
+					    int action)
+{
+	struct sigmatel_spec *spec = codec->spec;
+
+	if (action != HDA_FIXUP_ACT_PRE_PROBE)
+		return;
+	spec->eapd_mask = spec->gpio_mask = spec->gpio_dir =
+		spec->gpio_data = 0x10;
+	spec->eapd_switch = 0;
+}
+
 static const struct hda_verb hp_bnb13_eq_verbs[] = {
 	/* 44.1KHz base */
 	{ 0x22, 0x7A6, 0x3E },
@@ -2656,6 +2670,10 @@ static const struct hda_fixup stac92hd83xxx_fixups[] = {
 			{}
 		},
 	},
+	[STAC_92HD83XXX_GPIO10_EAPD] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = stac92hd83xxx_fixup_gpio10_eapd,
+	},
 };
 
 static const struct hda_model_fixup stac92hd83xxx_models[] = {
@@ -2861,6 +2879,8 @@ static const struct snd_pci_quirk stac92hd83xxx_fixup_tbl[] = {
 	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x148a,
 		      "HP Mini", STAC_92HD83XXX_HP_LED),
 	SND_PCI_QUIRK_VENDOR(PCI_VENDOR_ID_HP, "HP", STAC_92HD83XXX_HP),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_TOSHIBA, 0xfa91,
+		      "Toshiba Satellite S50D", STAC_92HD83XXX_GPIO10_EAPD),
 	{} /* terminator */
 };
 
-- 
2.2.2
