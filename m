From: joseph.salisbury@canonical.com
Subject: [PATCH 1/1] ALSA: hda - add quirk for Thinkpad T430
Date: Fri, 19 Oct 2012 10:32:30 -0400
Message-ID: <fe78ea8daff3d5a41b6e1c78fb527894da6ad71e.1350570761.git.joseph.salisbury__3890.21763480759$1350657176$gmane$org@canonical.com>
References: <cover.1350570761.git.joseph.salisbury@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1350570761.git.joseph.salisbury@canonical.com>
In-Reply-To: <cover.1350570761.git.joseph.salisbury@canonical.com>
References: <cover.1350570761.git.joseph.salisbury@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, perex@perex.cz, tiwai@suse.de, david.henningsson@canonical.com, alsa-devel@alsa-project.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Joseph Salisbury <joseph.salisbury@canonical.com>


Signed-off-by: Joseph Salisbury <joseph.salisbury@canonical.com>
---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 739f968..18fce01 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6172,6 +6172,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x21e9, "Thinkpad Edge 15", ALC269_FIXUP_SKU_IGNORE),
 	SND_PCI_QUIRK(0x17aa, 0x21f6, "Thinkpad T530", ALC269_FIXUP_LENOVO_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x21fa, "Thinkpad X230", ALC269_FIXUP_LENOVO_DOCK),
+	SND_PCI_QUIRK(0x17aa, 0x21f3, "Thinkpad T430", ALC269_FIXUP_LENOVO_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x21fb, "Thinkpad T430s", ALC269_FIXUP_LENOVO_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x2203, "Thinkpad X230 Tablet", ALC269_FIXUP_LENOVO_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x3bf8, "Quanta FL1", ALC269_FIXUP_PCM_44K),
-- 
1.7.9.5
