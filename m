From: Ansgar Hegerfeld <linux@hegerfeld.org>
Subject: [PATCH] ALSA: hda/realtek - ALC292 dock fix for Thinkpad L450
Date: Thu, 14 May 2015 12:31:32 +0200
Message-ID: <55547984.9050003@hegerfeld.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.de, hui.wang@canonical.com, kailang@realtek.com, david.henningsson@canonical.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The Lenovo ThinkPad L450 requires the ALC292_FIXUP_TPT440_DOCK fix in
order to get sound output on the docking stations audio port.

This patch was tested using a ThinkPad L450 (20DSS00B00) using kernel
4.0.3 and a ThinkPad Pro Dock.

Signed-off-by: Ansgar Hegerfeld <linux@hegerfeld.org>
---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index e2afd53..a9f41a4 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5148,6 +5148,7 @@ static const struct snd_pci_quirk
alc269_fixup_tbl[] = {
        SND_PCI_QUIRK(0x17aa, 0x5026, "Thinkpad",
ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
        SND_PCI_QUIRK(0x17aa, 0x5034, "Thinkpad T450",
ALC292_FIXUP_TPT440_DOCK),
        SND_PCI_QUIRK(0x17aa, 0x5036, "Thinkpad T450s",
ALC292_FIXUP_TPT440_DOCK),
+      SND_PCI_QUIRK(0x17aa, 0x503c, "Thinkpad L450",
ALC292_FIXUP_TPT440_DOCK),
        SND_PCI_QUIRK(0x17aa, 0x5109, "Thinkpad",
ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
        SND_PCI_QUIRK(0x17aa, 0x3bf8, "Quanta FL1", ALC269_FIXUP_PCM_44K),
        SND_PCI_QUIRK(0x17aa, 0x9e54, "LENOVO NB",
ALC269_FIXUP_LENOVO_EAPD),
