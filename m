From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH] ALSA: hda/realtek - Enable the ALC292 dock fixup on the Thinkpad T460s
Date: Fri,  1 Apr 2016 14:59:08 +0200
Message-ID: <1459515548-3267-1-git-send-email-sven@narfation.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Simon Wunderlich <sw@simonwunderlich.de>, Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org, Sven Eckelmann <sven@narfation.org>
List-Id: alsa-devel@alsa-project.org

The Lenovo Thinkpad T460s requires the alc_fixup_tpt440_dock as well in
order to get working sound output on the docking stations headphone jack.

Patch tested on a Thinkpad T460s (20F9CT01WW) using a ThinkPad Ultradock
on kernel 4.4.6.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Tested-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 sound/pci/hda/patch_realtek.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 73978c7..5b85019 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4759,6 +4759,8 @@ enum {
 	ALC255_FIXUP_DELL_SPK_NOISE,
 	ALC225_FIXUP_DELL1_MIC_NO_PRESENCE,
 	ALC280_FIXUP_HP_HEADSET_MIC,
+	ALC292_FIXUP_TPT460_DOCK,
+	ALC292_FIXUP_TPT460,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -5401,6 +5403,18 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC269_FIXUP_HEADSET_MIC,
 	},
+	[ALC292_FIXUP_TPT460_DOCK] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc_fixup_tpt440_dock,
+		.chained = true,
+		.chain_id = ALC269_FIXUP_THINKPAD_ACPI
+	},
+	[ALC292_FIXUP_TPT460] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc_fixup_disable_aamix,
+		.chained = true,
+		.chain_id = ALC292_FIXUP_TPT460_DOCK,
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -5554,7 +5568,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x2218, "Thinkpad X1 Carbon 2nd", ALC292_FIXUP_TPT440_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x2223, "ThinkPad T550", ALC292_FIXUP_TPT440_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x2226, "ThinkPad X250", ALC292_FIXUP_TPT440_DOCK),
-	SND_PCI_QUIRK(0x17aa, 0x2233, "Thinkpad", ALC293_FIXUP_LENOVO_SPK_NOISE),
+	SND_PCI_QUIRK(0x17aa, 0x2233, "Thinkpad", ALC292_FIXUP_TPT460),
 	SND_PCI_QUIRK(0x17aa, 0x30bb, "ThinkCentre AIO", ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY),
 	SND_PCI_QUIRK(0x17aa, 0x30e2, "ThinkCentre AIO", ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY),
 	SND_PCI_QUIRK(0x17aa, 0x3902, "Lenovo E50-80", ALC269_FIXUP_DMIC_THINKPAD_ACPI),
@@ -5649,6 +5663,8 @@ static const struct hda_model_fixup alc269_fixup_models[] = {
 	{.id = ALC283_FIXUP_SENSE_COMBO_JACK, .name = "alc283-sense-combo"},
 	{.id = ALC292_FIXUP_TPT440_DOCK, .name = "tpt440-dock"},
 	{.id = ALC292_FIXUP_TPT440, .name = "tpt440"},
+	{.id = ALC292_FIXUP_TPT460_DOCK, .name = "tpt460-dock"},
+	{.id = ALC292_FIXUP_TPT460, .name = "tpt460"},
 	{}
 };
 #define ALC225_STANDARD_PINS \
-- 
2.8.0.rc3
