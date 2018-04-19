From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH 2/2] ALSA: hda/realtek - adjust the location of one mic
Date: Thu, 19 Apr 2018 13:29:05 +0800
Message-ID: <1524115745-7868-2-git-send-email-hui.wang@canonical.com>
References: <1524115745-7868-1-git-send-email-hui.wang@canonical.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1524115745-7868-1-git-send-email-hui.wang@canonical.com>
Sender: stable-owner@vger.kernel.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, stable@vger.kernel.org, hui.wang@canonical.com
List-Id: alsa-devel@alsa-project.org

There are two front mics on this machine, if we don't adjust the
location for one of them, they will have the same mixer name,
pulseaudio can't handle this situation.

After applying this FIXUP, they will have different mixer name,
then pulseaudio can handle them correctly.

Cc: <stable@vger.kernel.org>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index c3b63b7..fc77bf7 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6575,6 +6575,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x30bb, "ThinkCentre AIO", ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY),
 	SND_PCI_QUIRK(0x17aa, 0x30e2, "ThinkCentre AIO", ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY),
 	SND_PCI_QUIRK(0x17aa, 0x310c, "ThinkCentre Station", ALC294_FIXUP_LENOVO_MIC_LOCATION),
+	SND_PCI_QUIRK(0x17aa, 0x3138, "ThinkCentre Station", ALC294_FIXUP_LENOVO_MIC_LOCATION),
 	SND_PCI_QUIRK(0x17aa, 0x313c, "ThinkCentre Station", ALC294_FIXUP_LENOVO_MIC_LOCATION),
 	SND_PCI_QUIRK(0x17aa, 0x3112, "ThinkCentre AIO", ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY),
 	SND_PCI_QUIRK(0x17aa, 0x3902, "Lenovo E50-80", ALC269_FIXUP_DMIC_THINKPAD_ACPI),
-- 
2.7.4
