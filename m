From: woodrow.shen@canonical.com
Subject: [alsa-devel] [PATCH] ALSA: hda - Add some FIXUP quirks for white noise on Dell laptop.
Date: Fri,  4 Sep 2015 15:08:12 +0800
Message-ID: <1441350492-24724-1-git-send-email-woodrow.shen@canonical.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: 1492132@bugs.launchpad.net, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Woodrow Shen <woodrow.shen@canonical.com>

Dell laptop has a series model to use the same codec but different subsystem ID.
At the same time they happens the white noise by login screen and headphone;
for fixing them together, I only can add these IDs to FIXUP function ALC292_FIXUP_DISABLE_AAMIX,
then try to solve such the similar issues.

Codec: Realtek ALC3235
Vendor Id: 0x10ec0293
Subsystem Id: 0x102806dd
Subsystem Id: 0x102806df
Subsystem Id: 0x102806e0

Cc: <stable@vger.kernel.org>
BugLink: https://bugs.launchpad.net/bugs/1492132
Signed-off-by: Woodrow Shen <woodrow.shen@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 4e6b090..764dd5b 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5189,8 +5189,11 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1028, 0x06c7, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x06d9, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x06da, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),
-	SND_PCI_QUIRK(0x1028, 0x06de, "Dell", ALC292_FIXUP_DISABLE_AAMIX),
 	SND_PCI_QUIRK(0x1028, 0x06db, "Dell", ALC292_FIXUP_DISABLE_AAMIX),
+	SND_PCI_QUIRK(0x1028, 0x06dd, "Dell", ALC292_FIXUP_DISABLE_AAMIX),
+	SND_PCI_QUIRK(0x1028, 0x06de, "Dell", ALC292_FIXUP_DISABLE_AAMIX),
+	SND_PCI_QUIRK(0x1028, 0x06df, "Dell", ALC292_FIXUP_DISABLE_AAMIX),
+	SND_PCI_QUIRK(0x1028, 0x06e0, "Dell", ALC292_FIXUP_DISABLE_AAMIX),
 	SND_PCI_QUIRK(0x1028, 0x164a, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x164b, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x1586, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC2),
-- 
2.1.4
