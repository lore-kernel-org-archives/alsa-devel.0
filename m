From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: hda - remove "Mic Jack Mode" for headset
	jacks (Latitude Exx30)
Date: Tue,  9 Oct 2012 12:48:40 +0200
Message-ID: <1349779720-4679-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id CDC44262630
 for <alsa-devel@alsa-project.org>; Tue,  9 Oct 2012 12:44:35 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Dell Latitude 5x30 and 6x30 series of machines all have
a single 4-pin headset jack. Enabling line in mode for such jack
is very confusing (you would only get mono input, and would have to
use non-standard adapters), so remove the option by default.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_sigmatel.c |   27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index bb6c50e..f60b353 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -104,6 +104,7 @@ enum {
 	STAC_92HD83XXX_HP_LED,
 	STAC_92HD83XXX_HP_INV_LED,
 	STAC_92HD83XXX_HP_MIC_LED,
+	STAC_92HD83XXX_HEADSET_JACK,
 	STAC_92HD83XXX_MODELS
 };
 
@@ -204,6 +205,7 @@ struct sigmatel_spec {
 	unsigned int check_volume_offset:1;
 	unsigned int auto_mic:1;
 	unsigned int linear_tone_beep:1;
+	unsigned int headset_jack:1; /* 4-pin headset jack (hp + mono mic) */
 
 	/* gpio lines */
 	unsigned int eapd_mask;
@@ -1684,6 +1686,7 @@ static const char * const stac92hd83xxx_models[STAC_92HD83XXX_MODELS] = {
 	[STAC_92HD83XXX_HP_LED] = "hp-led",
 	[STAC_92HD83XXX_HP_INV_LED] = "hp-inv-led",
 	[STAC_92HD83XXX_HP_MIC_LED] = "hp-mic-led",
+	[STAC_92HD83XXX_HEADSET_JACK] = "headset-jack",
 };
 
 static const struct snd_pci_quirk stac92hd83xxx_cfg_tbl[] = {
@@ -1694,6 +1697,24 @@ static const struct snd_pci_quirk stac92hd83xxx_cfg_tbl[] = {
 		      "DFI LanParty", STAC_92HD83XXX_REF),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x02ba,
 		      "unknown Dell", STAC_DELL_S14),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x0532,
+		      "Dell Latitude E6230", STAC_92HD83XXX_HEADSET_JACK),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x0533,
+		      "Dell Latitude E6330", STAC_92HD83XXX_HEADSET_JACK),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x0534,
+		      "Dell Latitude E6430", STAC_92HD83XXX_HEADSET_JACK),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x0535,
+		      "Dell Latitude E6530", STAC_92HD83XXX_HEADSET_JACK),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x053c,
+		      "Dell Latitude E5430", STAC_92HD83XXX_HEADSET_JACK),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x053d,
+		      "Dell Latitude E5530", STAC_92HD83XXX_HEADSET_JACK),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x0549,
+		      "Dell Latitude E5430", STAC_92HD83XXX_HEADSET_JACK),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x057d,
+		      "Dell Latitude E6430s", STAC_92HD83XXX_HEADSET_JACK),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x0584,
+		      "Dell Latitude E6430U", STAC_92HD83XXX_HEADSET_JACK),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x1028,
 		      "Dell Vostro 3500", STAC_DELL_VOSTRO_3500),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x1656,
@@ -2855,6 +2876,9 @@ static inline int stac92xx_add_jack_mode_control(struct hda_codec *codec,
 	char name[22];
 
 	if (snd_hda_get_input_pin_attr(def_conf) != INPUT_PIN_ATTR_INT) {
+		if (spec->headset_jack && snd_hda_get_input_pin_attr(def_conf)
+			!= INPUT_PIN_ATTR_DOCK)
+			return 0;
 		if (snd_hda_get_default_vref(codec, nid) == AC_PINCTL_VREF_GRD
 			&& nid == spec->line_switch)
 			control = STAC_CTL_WIDGET_IO_SWITCH;
@@ -5636,6 +5660,9 @@ again:
 	case STAC_92HD83XXX_HP_MIC_LED:
 		spec->mic_mute_led_gpio = 0x08; /* GPIO3 */
 		break;
+	case STAC_92HD83XXX_HEADSET_JACK:
+		spec->headset_jack = 1;
+		break;
 	}
 
 	if (find_mute_led_cfg(codec, default_polarity))
-- 
1.7.9.5
