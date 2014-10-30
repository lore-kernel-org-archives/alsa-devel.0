From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 1/2] ALSA: hda - Set GPIO 4 low for a few HP machines
Date: Thu, 30 Oct 2014 08:26:01 +0100
Message-ID: <1414653962-3912-1-git-send-email-david.henningsson@canonical.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: 1387128@bugs.launchpad.net, David Henningsson <david.henningsson@canonical.com>, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

These HP machines needs GPIO 4 low to enable the headphone amplifier.
In addition, we still need to control LEDs via vref and GPIO.

Cc: stable@vger.kernel.org
BugLink: https://bugs.launchpad.net/bugs/1387128
Tested-by: TienFu Chen <tienfu.chen@canonical.com>
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 9bc0301..d16d8ec 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3350,6 +3350,27 @@ static void alc269_fixup_hp_gpio_mic1_led(struct hda_codec *codec,
 	}
 }
 
+static void alc280_fixup_hp_gpio4(struct hda_codec *codec,
+				   const struct hda_fixup *fix, int action)
+{
+	/* Like hp_gpio_mic1_led, but also needs GPIO4 low to enable headphone amp */
+	struct alc_spec *spec = codec->spec;
+	static const struct hda_verb gpio_init[] = {
+		{ 0x01, AC_VERB_SET_GPIO_MASK, 0x18 },
+		{ 0x01, AC_VERB_SET_GPIO_DIRECTION, 0x18 },
+		{}
+	};
+
+	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
+		spec->gen.vmaster_mute.hook = alc269_fixup_hp_gpio_mute_hook;
+		spec->gen.cap_sync_hook = alc269_fixup_hp_cap_mic_mute_hook;
+		spec->gpio_led = 0;
+		spec->cap_mute_led_nid = 0x18;
+		snd_hda_add_verbs(codec, gpio_init);
+		codec->power_filter = led_power_filter;
+	}
+}
+
 static void alc269_fixup_hp_line1_mic1_led(struct hda_codec *codec,
 				const struct hda_fixup *fix, int action)
 {
@@ -4217,6 +4238,7 @@ enum {
 	ALC283_FIXUP_BXBT2807_MIC,
 	ALC255_FIXUP_DELL_WMI_MIC_MUTE_LED,
 	ALC282_FIXUP_ASPIRE_V5_PINS,
+	ALC280_FIXUP_HP_GPIO4,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -4680,7 +4702,10 @@ static const struct hda_fixup alc269_fixups[] = {
 			{ },
 		},
 	},
-
+	[ALC280_FIXUP_HP_GPIO4] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc280_fixup_hp_gpio4,
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -4728,7 +4753,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x22cf, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x22dc, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),
 	SND_PCI_QUIRK(0x103c, 0x22fb, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),
-	SND_PCI_QUIRK(0x103c, 0x8004, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),
+	SND_PCI_QUIRK(0x103c, 0x8004, "HP", ALC269_FIXUP_HP_GPIO4),
 	/* ALC290 */
 	SND_PCI_QUIRK(0x103c, 0x221b, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),
 	SND_PCI_QUIRK(0x103c, 0x2221, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),
@@ -4742,7 +4767,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x2255, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),
 	SND_PCI_QUIRK(0x103c, 0x2256, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),
 	SND_PCI_QUIRK(0x103c, 0x2257, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),
-	SND_PCI_QUIRK(0x103c, 0x2258, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),
+	SND_PCI_QUIRK(0x103c, 0x2258, "HP", ALC269_FIXUP_HP_GPIO4),
 	SND_PCI_QUIRK(0x103c, 0x2259, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),
 	SND_PCI_QUIRK(0x103c, 0x225a, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),
 	SND_PCI_QUIRK(0x103c, 0x2260, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
@@ -4751,7 +4776,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x2265, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x2272, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),
 	SND_PCI_QUIRK(0x103c, 0x2273, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),
-	SND_PCI_QUIRK(0x103c, 0x2277, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),
+	SND_PCI_QUIRK(0x103c, 0x2277, "HP", ALC269_FIXUP_HP_GPIO4),
 	SND_PCI_QUIRK(0x103c, 0x2278, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),
 	SND_PCI_QUIRK(0x103c, 0x227f, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x2282, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
-- 
1.9.1
