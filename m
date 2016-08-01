From: Shrirang Bagul <shrirang.bagul@canonical.com>
Subject: [PATCH] ALSA: hda - On-board speaker fixup on ACER Veriton
Date: Mon,  1 Aug 2016 13:02:55 +0800
Message-ID: <1470027775-12816-1-git-send-email-shrirang.bagul@canonical.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Acer Veriton machines, codec with subsystem-id 0x1b0a01b8 the port at
0x15 is configured by default as an Internal Speaker (0x90170120).
However, no physical is speaker installed on-board. This patch adds a quirk
which disables the physical connection on this pin.

BugLink: https://bugs.launchpad.net/bugs/1607647

Signed-off-by: Shrirang Bagul <shrirang.bagul@canonical.com>
---
 sound/pci/hda/patch_realtek.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index ddd29b9..498f199 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6549,6 +6549,7 @@ enum {
 	ALC668_FIXUP_ASUS_Nx51,
 	ALC891_FIXUP_HEADSET_MODE,
 	ALC891_FIXUP_DELL_MIC_NO_PRESENCE,
+	ALC662_FIXUP_ACER_VERITON,
 };
 
 static const struct hda_fixup alc662_fixups[] = {
@@ -6818,6 +6819,13 @@ static const struct hda_fixup alc662_fixups[] = {
 		.chained = true,
 		.chain_id = ALC891_FIXUP_HEADSET_MODE
 	},
+	[ALC662_FIXUP_ACER_VERITON] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x15, 0x50170120 }, /* no internal speaker */
+			{ }
+		}
+	},
 };
 
 static const struct snd_pci_quirk alc662_fixup_tbl[] = {
@@ -6857,6 +6865,7 @@ static const struct snd_pci_quirk alc662_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3a0d, "Lenovo Ideapad Y550", ALC662_FIXUP_IDEAPAD),
 	SND_PCI_QUIRK(0x19da, 0xa130, "Zotac Z68", ALC662_FIXUP_ZOTAC_Z68),
 	SND_PCI_QUIRK(0x1b35, 0x2206, "CZC P10T", ALC662_FIXUP_CZC_P10T),
+	SND_PCI_QUIRK(0x1b0a, 0x01b8, "ACER Veriton", ALC662_FIXUP_ACER_VERITON),
 
 #if 0
 	/* Below is a quirk table taken from the old code.
-- 
1.7.9.5
