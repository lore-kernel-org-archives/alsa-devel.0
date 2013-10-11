From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH v2 1/2] ALSA: hda - Fix microphone for Sony VAIO Pro 13 (Haswell model)
Date: Fri, 11 Oct 2013 10:18:45 +0200
Message-ID: <1381479526-3766-2-git-send-email-david.henningsson@canonical.com>
References: <1381479526-3766-1-git-send-email-david.henningsson@canonical.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1381479526-3766-1-git-send-email-david.henningsson@canonical.com>
Sender: stable-owner@vger.kernel.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The external mic showed up with a precense detect of "always present",
essentially disabling the internal mic. Therefore turn off presence
detection for this pin.

Note: The external mic seems not yet working, but an internal mic is
certainly better than no mic at all.

Cc: stable@vger.kernel.org
BugLink: https://bugs.launchpad.net/bugs/1227093
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index ed9deb6..ae847fe 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3528,6 +3528,7 @@ enum {
 	ALC269_FIXUP_HP_GPIO_LED,
 	ALC269_FIXUP_INV_DMIC,
 	ALC269_FIXUP_LENOVO_DOCK,
+	ALC286_FIXUP_SONY_MIC_NO_PRESENCE,
 	ALC269_FIXUP_PINCFG_NO_HP_TO_LINEOUT,
 	ALC269_FIXUP_DELL1_MIC_NO_PRESENCE,
 	ALC269_FIXUP_DELL2_MIC_NO_PRESENCE,
@@ -3740,6 +3741,13 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc_fixup_headset_mode_no_hp_mic,
 	},
+	[ALC286_FIXUP_SONY_MIC_NO_PRESENCE] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x18, 0x01a1913c }, /* use as headset mic, without its own jack detect */
+			{ }
+		},
+	},
 	[ALC269_FIXUP_ASUS_X101_FUNC] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc269_fixup_x101_headset_mic,
@@ -3894,6 +3902,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x8398, "ASUS P1005", ALC269_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x83ce, "ASUS P1005", ALC269_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x8516, "ASUS X101CH", ALC269_FIXUP_ASUS_X101),
+	SND_PCI_QUIRK(0x104d, 0x90b6, "Sony VAIO Pro 13", ALC286_FIXUP_SONY_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x104d, 0x9073, "Sony VAIO", ALC275_FIXUP_SONY_VAIO_GPIO2),
 	SND_PCI_QUIRK(0x104d, 0x907b, "Sony VAIO", ALC275_FIXUP_SONY_HWEQ),
 	SND_PCI_QUIRK(0x104d, 0x9084, "Sony VAIO", ALC275_FIXUP_SONY_HWEQ),
-- 
1.7.9.5
