From: Kai-Heng Feng <kaihengfeng@gmail.com>
Subject: [PATCH] ALSA: hda - Fix headphone noise on Dell XPS 13 9360
Date: Fri, 20 May 2016 15:47:23 +0800
Message-ID: <1463730443-1540-1-git-send-email-kai.heng.feng@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tiwai@suse.com
Cc: hui.wang@canonical.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Kai-Heng Feng <kai.heng.feng@canonical.com>
List-Id: alsa-devel@alsa-project.org

The headphone has noise when playing sound or switching microphone sources.
It uses the same codec on XPS 13 9350, but with different subsystem ID.
Applying the fixup can solve the issue.
Also, changing the model name to better differentiate models.

v2: Reorder by device ID.
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 002f153..10ca900 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5466,8 +5466,9 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1028, 0x06de, "Dell", ALC293_FIXUP_DISABLE_AAMIX_MULTIJACK),
 	SND_PCI_QUIRK(0x1028, 0x06df, "Dell", ALC293_FIXUP_DISABLE_AAMIX_MULTIJACK),
 	SND_PCI_QUIRK(0x1028, 0x06e0, "Dell", ALC293_FIXUP_DISABLE_AAMIX_MULTIJACK),
-	SND_PCI_QUIRK(0x1028, 0x0704, "Dell XPS 13", ALC256_FIXUP_DELL_XPS_13_HEADPHONE_NOISE),
+	SND_PCI_QUIRK(0x1028, 0x0704, "Dell XPS 13 9350", ALC256_FIXUP_DELL_XPS_13_HEADPHONE_NOISE),
 	SND_PCI_QUIRK(0x1028, 0x0725, "Dell Inspiron 3162", ALC255_FIXUP_DELL_SPK_NOISE),
+	SND_PCI_QUIRK(0x1028, 0x075b, "Dell XPS 13 9360", ALC256_FIXUP_DELL_XPS_13_HEADPHONE_NOISE),
 	SND_PCI_QUIRK(0x1028, 0x164a, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x164b, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x1586, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC2),
-- 
2.8.1
