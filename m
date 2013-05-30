From: Ebben Aries <earies@dscp.org>
Subject: [PATCH 1/1] ALSA: hda - add dock support for Thinkpad T431s
Date: Wed, 29 May 2013 22:27:18 -0600
Message-ID: <1369888038-6044-1-git-send-email-earies@dscp.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, David Henningsson <david.henningsson@canonical.com>, Kailang Yang <kailang@realtek.com>, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, Ebben Aries <earies@dscp.org>
List-Id: alsa-devel@alsa-project.org

Add a model/fixup string "lenovo-dock", for Thinkpad T431s, to allow sound in docking station.

Tested on Lenovo T431s with ThinkPad Mini Dock Plus Series 3

Signed-off-by: Ebben Aries <earies@dscp.org>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 59d2e91..9658faf 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3530,6 +3530,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x21fa, "Thinkpad X230", ALC269_FIXUP_LENOVO_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x21f3, "Thinkpad T430", ALC269_FIXUP_LENOVO_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x21fb, "Thinkpad T430s", ALC269_FIXUP_LENOVO_DOCK),
+	SND_PCI_QUIRK(0x17aa, 0x2208, "Thinkpad T431s", ALC269_FIXUP_LENOVO_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x2203, "Thinkpad X230 Tablet", ALC269_FIXUP_LENOVO_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x3bf8, "Quanta FL1", ALC269_FIXUP_PCM_44K),
 	SND_PCI_QUIRK(0x17aa, 0x9e54, "LENOVO NB", ALC269_FIXUP_LENOVO_EAPD),
-- 
1.7.12.1
