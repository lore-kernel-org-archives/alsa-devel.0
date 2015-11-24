From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH] ALSA: hda - Fix headphone noise after Dell XPS 13 resume back from S3
Date: Tue, 24 Nov 2015 11:08:18 +0800
Message-ID: <1448334498-29519-1-git-send-email-hui.wang@canonical.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: stable@vger.kernel.org, kailang@realtek.com, hui.wang@canonical.com
List-Id: alsa-devel@alsa-project.org

We have a machine Dell XPS 13 with the codec alc256, after resume back
from S3, the headphone has noise when play sound.

Through comparing with the coeff vaule before and after S3, we found
restoring a coeff register will help remove noise.

BugLink: https://bugs.launchpad.net/bugs/1519168
Cc: Kailang Yang <kailang@realtek.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
Kailang said one of the bits in that register is:
Enable/Disable pass-through path for FRONT 14h

And disable this bit should help remove headphone noise.

 sound/pci/hda/patch_realtek.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 53f6a02..e4f80dc 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4587,6 +4587,7 @@ enum {
 	ALC292_FIXUP_DISABLE_AAMIX,
 	ALC298_FIXUP_DELL1_MIC_NO_PRESENCE,
 	ALC275_FIXUP_DELL_XPS,
+	ALC256_FIXUP_DELL_XPS_13_HEADPHONE_NOISE,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -5167,6 +5168,17 @@ static const struct hda_fixup alc269_fixups[] = {
 			{}
 		}
 	},
+	[ALC256_FIXUP_DELL_XPS_13_HEADPHONE_NOISE] = {
+		.type = HDA_FIXUP_VERBS,
+		.v.verbs = (const struct hda_verb[]) {
+			/* Disable pass-through path for FRONT 14h */
+			{0x20, AC_VERB_SET_COEF_INDEX, 0x36},
+			{0x20, AC_VERB_SET_PROC_COEF, 0x1737},
+			{}
+		},
+		.chained = true,
+		.chain_id = ALC255_FIXUP_DELL1_MIC_NO_PRESENCE
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -5206,6 +5218,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1028, 0x06de, "Dell", ALC292_FIXUP_DISABLE_AAMIX),
 	SND_PCI_QUIRK(0x1028, 0x06df, "Dell", ALC292_FIXUP_DISABLE_AAMIX),
 	SND_PCI_QUIRK(0x1028, 0x06e0, "Dell", ALC292_FIXUP_DISABLE_AAMIX),
+	SND_PCI_QUIRK(0x1028, 0x0704, "Dell XPS 13", ALC256_FIXUP_DELL_XPS_13_HEADPHONE_NOISE),
 	SND_PCI_QUIRK(0x1028, 0x164a, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x164b, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x1586, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC2),
-- 
1.9.1
