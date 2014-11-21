From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH] ALSA: hda - One more HP machine needs to change mute led quirk
Date: Fri, 21 Nov 2014 17:05:01 +0800
Message-ID: <1416560701-3693-1-git-send-email-hui.wang@canonical.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, kailang@realtek.com, tienfu.chen@canonical.com, stable@vger.kernel.org, hui.wang@canonical.com
List-Id: alsa-devel@alsa-project.org

The machine originally use the quirk ALC269_FIXUP_HP_GPIO_MIC1_LED,
but the LED doesn't work at all.

After this change, the machine will change to use
ALC269_FIXUP_HP_MUTE_LED_MIC1 through pin_fixup_tbl[], and the LED
works well.

BugLink: https://bugs.launchpad.net/bugs/1389497
Tested-by: TieFu Chen <tienfu.chen@canonical.com>
Cc: Kailang Yang <kailang@realtek.com>
Cc: stable@vger.kernel.org
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index cd08d8a..2ac9e23 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4831,7 +4831,6 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x221b, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),
 	SND_PCI_QUIRK(0x103c, 0x2221, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),
 	SND_PCI_QUIRK(0x103c, 0x2225, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),
-	SND_PCI_QUIRK(0x103c, 0x2246, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),
 	SND_PCI_QUIRK(0x103c, 0x2253, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),
 	SND_PCI_QUIRK(0x103c, 0x2254, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),
 	SND_PCI_QUIRK(0x103c, 0x2255, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),
-- 
1.9.1
