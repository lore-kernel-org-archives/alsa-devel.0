From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH] ALSA: hda - Add several entries for enabling HP mute led
Date: Mon,  7 Jul 2014 17:07:43 +0800
Message-ID: <1404724063-8980-1-git-send-email-hui.wang@canonical.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: david.henningsson@canonical.com, kailang@realtek.com, stable@vger.kernel.org, hui.wang@canonical.com
List-Id: alsa-devel@alsa-project.org

BugLink: https://bugs.launchpad.net/bugs/1329580
Cc: David Henningsson <david.henningsson@canonical.com>
Cc: Kailang Yang <kailang@realtek.com>
Cc: stable@vger.kernel.org
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
So far, the mute led DMI string on these machines are HP_Mute_LED_0_0.

 sound/pci/hda/patch_realtek.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 832c225..327413e 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4854,6 +4854,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x1983, "HP Pavilion", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x218b, "HP", ALC269_FIXUP_LIMIT_INT_MIC_BOOST_MUTE_LED),
 	/* ALC282 */
+	SND_PCI_QUIRK(0x103c, 0x21f8, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
+	SND_PCI_QUIRK(0x103c, 0x21f9, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x220d, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x220e, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x220f, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
@@ -4907,6 +4909,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8004, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),
 	/* ALC290 */
 	SND_PCI_QUIRK(0x103c, 0x221b, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),
+	SND_PCI_QUIRK(0x103c, 0x221c, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),
+	SND_PCI_QUIRK(0x103c, 0x221d, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),
 	SND_PCI_QUIRK(0x103c, 0x2220, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),
 	SND_PCI_QUIRK(0x103c, 0x2221, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),
 	SND_PCI_QUIRK(0x103c, 0x2222, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),
-- 
1.8.1.2
