From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 2/2] ALSA: hda - Fix microphone for Sony VAIO Pro 13 (Haswell model)
Date: Thu, 10 Oct 2013 12:19:24 +0200
Message-ID: <1381400364-6067-2-git-send-email-david.henningsson@canonical.com>
References: <1381400364-6067-1-git-send-email-david.henningsson@canonical.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1381400364-6067-1-git-send-email-david.henningsson@canonical.com>
Sender: stable-owner@vger.kernel.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: 1227093@bugs.launchpad.net, David Henningsson <david.henningsson@canonical.com>, stable@vger.kernel.org
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
 sound/pci/hda/patch_realtek.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

Note: when doing stable backports, the two lines ".chained = true" and
".chain_id = ALC269_FIXUP_HEADSET_MIC" can be dropped.

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 8cb3350..ec47681 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3556,6 +3556,7 @@ enum {
 	ALC282_FIXUP_ASUS_TX300,
 	ALC283_FIXUP_INT_MIC,
 	ALC290_FIXUP_MONO_SPEAKERS,
+	ALC286_FIXUP_SONY_MIC_NO_PRESENCE,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -3844,6 +3845,15 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC269_FIXUP_DELL3_MIC_NO_PRESENCE,
 	},
+	[ALC286_FIXUP_SONY_MIC_NO_PRESENCE] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x18, 0x01a1913c }, /* use as headset mic, without its own jack detect */
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC269_FIXUP_HEADSET_MIC,
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -3908,6 +3918,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x8398, "ASUS P1005", ALC269_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x83ce, "ASUS P1005", ALC269_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x8516, "ASUS X101CH", ALC269_FIXUP_ASUS_X101),
+	SND_PCI_QUIRK(0x104d, 0x90b6, "Sony VAIO Pro 13", ALC286_FIXUP_SONY_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x104d, 0x9073, "Sony VAIO", ALC275_FIXUP_SONY_VAIO_GPIO2),
 	SND_PCI_QUIRK(0x104d, 0x907b, "Sony VAIO", ALC275_FIXUP_SONY_HWEQ),
 	SND_PCI_QUIRK(0x104d, 0x9084, "Sony VAIO", ALC275_FIXUP_SONY_HWEQ),
-- 
1.7.9.5
