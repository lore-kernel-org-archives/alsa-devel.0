From: Yves-Alexis Perez <corsac@debian.org>
Subject: [PATCH] ALSA: hda - Add dock support for ThinkPad X250 (17aa:2226)
Date: Sat, 11 Apr 2015 09:31:35 +0200
Message-ID: <1428737495-9906-2-git-send-email-corsac@debian.org>
References: <1428737495-9906-1-git-send-email-corsac@debian.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428737495-9906-1-git-send-email-corsac@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Arnaud Ebalard <arno@natisbad.org>, Yves-Alexis Perez <corsac@debian.org>
List-Id: alsa-devel@alsa-project.org

This model uses the same dock port as the previous generation.

Signed-off-by: Yves-Alexis Perez <corsac@debian.org>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 7438213..2087728 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5030,6 +5030,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x2212, "Thinkpad T440", ALC292_FIXUP_TPT440_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x2214, "Thinkpad X240", ALC292_FIXUP_TPT440_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x2215, "Thinkpad", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
+	SND_PCI_QUIRK(0x17aa, 0x2226, "ThinkPad X250", ALC292_FIXUP_TPT440_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x3977, "IdeaPad S210", ALC283_FIXUP_INT_MIC),
 	SND_PCI_QUIRK(0x17aa, 0x3978, "IdeaPad Y410P", ALC269_FIXUP_NO_SHUTUP),
 	SND_PCI_QUIRK(0x17aa, 0x5013, "Thinkpad", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
-- 
2.1.4
