From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH] ALSA: hda/realtek - Enable mic-mute hotkey for several Lenovo AIOs
Date: Wed, 30 May 2018 12:33:07 +0800
Message-ID: <1527654787-8229-1-git-send-email-hui.wang@canonical.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, stable@vger.kernel.org, hui.wang@canonical.com
List-Id: alsa-devel@alsa-project.org

We have several Lenovo AIOs like M810z, M820z and M920z, they have
the same design for mic-mute hotkey and led and they use the same
codec with the same pin configuration, so use the pin conf table to
apply fix to all of them.

Cc: <stable@vger.kernel.org>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 240a1a4..d64dcb9 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6603,7 +6603,6 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x312f, "ThinkCentre Station", ALC294_FIXUP_LENOVO_MIC_LOCATION),
 	SND_PCI_QUIRK(0x17aa, 0x3138, "ThinkCentre Station", ALC294_FIXUP_LENOVO_MIC_LOCATION),
 	SND_PCI_QUIRK(0x17aa, 0x313c, "ThinkCentre Station", ALC294_FIXUP_LENOVO_MIC_LOCATION),
-	SND_PCI_QUIRK(0x17aa, 0x3112, "ThinkCentre AIO", ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY),
 	SND_PCI_QUIRK(0x17aa, 0x3902, "Lenovo E50-80", ALC269_FIXUP_DMIC_THINKPAD_ACPI),
 	SND_PCI_QUIRK(0x17aa, 0x3977, "IdeaPad S210", ALC283_FIXUP_INT_MIC),
 	SND_PCI_QUIRK(0x17aa, 0x3978, "IdeaPad Y410P", ALC269_FIXUP_NO_SHUTUP),
@@ -6775,6 +6774,11 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
 		{0x1b, 0x01111010},
 		{0x1e, 0x01451130},
 		{0x21, 0x02211020}),
+	SND_HDA_PIN_QUIRK(0x10ec0235, 0x17aa, "Lenovo", ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY,
+		{0x12, 0x90a60140},
+		{0x14, 0x90170110},
+		{0x19, 0x02a11030},
+		{0x21, 0x02211020}),
 	SND_HDA_PIN_QUIRK(0x10ec0236, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
 		{0x12, 0x90a60140},
 		{0x14, 0x90170110},
-- 
2.7.4
