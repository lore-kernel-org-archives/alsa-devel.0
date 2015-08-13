From: woodrow.shen@canonical.com
Subject: [alsa-devel][PATCH] ALSA: hda - Fix the white noise on Dell laptop
Date: Thu, 13 Aug 2015 11:20:40 +0800
Message-ID: <1439436040-27771-1-git-send-email-woodrow.shen@canonical.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: 1484334@bugs.launchpad.net, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Woodrow Shen <woodrow.shen@canonical.com>

Dell laptop causes the white noise by login screen and headphone,
and the fixup function ALC292_FIXUP_DISABLE_AAMIX can eliminate this
noise.

Codec: Realtek ALC3235
Vendor Id: 0x10ec0293
Subsystem Id: 0x102806db

Cc: <stable@vger.kernel.org>
BugLink: https://bugs.launchpad.net/bugs/1484334
Signed-off-by: Woodrow Shen <woodrow.shen@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 0e3fe01..1de427a 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5190,6 +5190,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1028, 0x06d9, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x06da, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x06de, "Dell", ALC292_FIXUP_DISABLE_AAMIX),
+	SND_PCI_QUIRK(0x1028, 0x06db, "Dell", ALC292_FIXUP_DISABLE_AAMIX),
 	SND_PCI_QUIRK(0x1028, 0x164a, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x164b, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x1586, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC2),
-- 
2.1.4
