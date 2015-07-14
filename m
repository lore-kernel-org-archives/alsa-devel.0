From: Keith Packard <keithp@keithp.com>
Subject: [PATCH] ALSA: hda/realtek: Enable headphone amp on HP Folio 9480m
Date: Tue, 14 Jul 2015 09:40:35 -0700
Message-ID: <1436892035-19589-1-git-send-email-keithp@keithp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, Kailang Yang <kailang@realtek.com>, Hui Wang <hui.wang@canonical.com>, David Henningsson <david.henningsson@canonical.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Keith Packard <keithp@keithp.com>
List-Id: alsa-devel@alsa-project.org

This laptop needs GPIO4 pulled high to enable the headphone
amplifier. I modelled the patch on the existing GPIO4 code which pulls
the line low for the same purpose.

Signed-off-by: Keith Packard <keithp@keithp.com>
---
 sound/pci/hda/patch_realtek.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 6d01045..9060f1f 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3436,6 +3436,23 @@ static void alc280_fixup_hp_gpio4(struct hda_codec *codec,
 	}
 }
 
+static void alc280_fixup_hp_gpio4_hp_amp(struct hda_codec *codec,
+					 const struct hda_fixup *fix,
+					 int action)
+{
+	/* Pull GPIO4 high to enable headphone amp */
+	static const struct hda_verb gpio_init[] = {
+		{ 0x01, AC_VERB_SET_GPIO_MASK, 0x10 },
+		{ 0x01, AC_VERB_SET_GPIO_DIRECTION, 0x10 },
+		{ 0x01, AC_VERB_SET_GPIO_DATA, 0x10 },
+		{}
+	};
+
+	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
+		snd_hda_add_verbs(codec, gpio_init);
+	}
+}
+
 static void gpio2_mic_hotkey_event(struct hda_codec *codec,
 				   struct hda_jack_callback *event)
 {
@@ -4512,6 +4529,7 @@ enum {
 	ALC286_FIXUP_HP_GPIO_LED,
 	ALC280_FIXUP_HP_GPIO2_MIC_HOTKEY,
 	ALC280_FIXUP_HP_DOCK_PINS,
+	ALC280_FIXUP_HP_GPIO4_HP_AMP,
 	ALC288_FIXUP_DELL_HEADSET_MODE,
 	ALC288_FIXUP_DELL1_MIC_NO_PRESENCE,
 	ALC288_FIXUP_DELL_XPS_13_GPIO6,
@@ -5012,6 +5030,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC280_FIXUP_HP_GPIO4
 	},
+	[ALC280_FIXUP_HP_GPIO4_HP_AMP] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc280_fixup_hp_gpio4_hp_amp,
+	},
 	[ALC288_FIXUP_DELL_HEADSET_MODE] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc_fixup_headset_mode_dell_alc288,
@@ -5103,6 +5125,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x22b7, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x22bf, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x22cf, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
+	SND_PCI_QUIRK(0x103c, 0x22db, "HP", ALC280_FIXUP_HP_GPIO4_HP_AMP),
 	SND_PCI_QUIRK(0x103c, 0x22dc, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),
 	SND_PCI_QUIRK(0x103c, 0x22fb, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),
 	/* ALC290 */
-- 
2.1.4
