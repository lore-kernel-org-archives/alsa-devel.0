From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH] ALSA: hda - enable mute led quirk for one more hp machine.
Date: Fri, 13 Feb 2015 11:14:41 +0800
Message-ID: <1423797281-18666-1-git-send-email-hui.wang@canonical.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: taihsiang.ho@canonical.com, stable@vger.kernel.org, hui.wang@canonical.com
List-Id: alsa-devel@alsa-project.org

Otherwise, the mute led can't work at all.

Tested-by: Taihsiang Ho <taihsiang.ho@canonical.com>
Cc: <stable@vger.kernel.org>
BugLink: https://bugs.launchpad.net/bugs/1410704
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index ddb9308..b2b24a8 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4937,6 +4937,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x218b, "HP", ALC269_FIXUP_LIMIT_INT_MIC_BOOST_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x225f, "HP", ALC280_FIXUP_HP_GPIO2_MIC_HOTKEY),
 	/* ALC282 */
+	SND_PCI_QUIRK(0x103c, 0x21f9, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x2210, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x2214, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x2236, "HP", ALC269_FIXUP_HP_LINE1_MIC1_LED),
-- 
1.9.1
