From: Hui Wang <hui.wang@canonical.com>
Subject: [V2 PATCH] ALSA: hda - Add Dell headset detection quirk for one more laptop model
Date: Wed, 18 Dec 2013 18:09:56 +0800
Message-ID: <1387361396-10755-1-git-send-email-hui.wang@canonical.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: david.henningsson@canonical.com, stable@vger.kernel.org, hui.wang@canonical.com
List-Id: alsa-devel@alsa-project.org

On the Dell machines with codec whose Subsystem Id is 0x10280640,
no external microphone can be detected when plugging a 3-ring headset.
Using ALC255_FIXUP_DELL1_MIC_NO_PRESENCE can fix this problem.

The codec (Vendor ID: 0x10ec0255) on the machine belongs to alc_269
family.

BugLink: https://bugs.launchpad.net/bugs/1260303
Cc: David Henningsson <david.henningsson@canonical.com>
Cc: stable@vger.kernel.org
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 3578f11..5b96698 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4309,6 +4309,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1028, 0x0638, "Dell Inspiron 5439", ALC290_FIXUP_MONO_SPEAKERS),
 	SND_PCI_QUIRK(0x1028, 0x063e, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x063f, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1028, 0x0640, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x15cc, "Dell X5 Precision", ALC269_FIXUP_DELL2_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x15cd, "Dell X5 Precision", ALC269_FIXUP_DELL2_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x1586, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC2),
-- 
1.8.1.2
