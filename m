From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: hda - Add quirk for external mic on Lifebook U904
Date: Fri, 13 Jun 2014 11:15:44 +0200
Message-ID: <1402650944-26327-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: tiwai@suse.de, alsa-devel@alsa-project.org, 1328587@bugs.launchpad.net
Cc: David Henningsson <david.henningsson@canonical.com>, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

According to the bug reporter (=D0=94=D0=B0=D0=BD=D0=B8=D0=BB=D0=BE =D0=
=A8=D0=B5=D0=B3=D0=B0=D0=BD), the external mic
starts to work and has proper jack detection if only pin 0x19
is marked properly as an external headset mic.

AlsaInfo at https://bugs.launchpad.net/ubuntu/+source/pulseaudio/+bug/1=
328587/+attachment/4128991/+files/AlsaInfo.txt

Cc: stable@vger.kernel.org
BugLink: https://bugs.launchpad.net/bugs/1328587
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realte=
k.c
index 9c095fa..89af62f 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4246,6 +4246,7 @@ enum {
 	ALC269_FIXUP_HEADSET_MIC,
 	ALC269_FIXUP_QUANTA_MUTE,
 	ALC269_FIXUP_LIFEBOOK,
+	ALC269_FIXUP_LIFEBOOK_EXTMIC,
 	ALC269_FIXUP_AMIC,
 	ALC269_FIXUP_DMIC,
 	ALC269VB_FIXUP_AMIC,
@@ -4383,6 +4384,13 @@ static const struct hda_fixup alc269_fixups[] =3D=
 {
 		.chained =3D true,
 		.chain_id =3D ALC269_FIXUP_QUANTA_MUTE
 	},
+	[ALC269_FIXUP_LIFEBOOK_EXTMIC] =3D {
+		.type =3D HDA_FIXUP_PINS,
+		.v.pins =3D (const struct hda_pintbl[]) {
+			{ 0x19, 0x01a1903c }, /* headset mic, with jack detect */
+			{ }
+		},
+	},
 	[ALC269_FIXUP_AMIC] =3D {
 		.type =3D HDA_FIXUP_PINS,
 		.v.pins =3D (const struct hda_pintbl[]) {
@@ -4844,6 +4852,7 @@ static const struct snd_pci_quirk alc269_fixup_tb=
l[] =3D {
 	SND_PCI_QUIRK(0x104d, 0x9099, "Sony VAIO S13", ALC275_FIXUP_SONY_DISA=
BLE_AAMIX),
 	SND_PCI_QUIRK_VENDOR(0x104d, "Sony VAIO", ALC269_FIXUP_SONY_VAIO),
 	SND_PCI_QUIRK(0x10cf, 0x1475, "Lifebook", ALC269_FIXUP_LIFEBOOK),
+	SND_PCI_QUIRK(0x10cf, 0x1845, "Lifebook U904", ALC269_FIXUP_LIFEBOOK_=
EXTMIC),
 	SND_PCI_QUIRK(0x17aa, 0x20f2, "Thinkpad SL410/510", ALC269_FIXUP_SKU_=
IGNORE),
 	SND_PCI_QUIRK(0x17aa, 0x215e, "Thinkpad L512", ALC269_FIXUP_SKU_IGNOR=
E),
 	SND_PCI_QUIRK(0x17aa, 0x21b8, "Thinkpad Edge 14", ALC269_FIXUP_SKU_IG=
NORE),
--=20
1.9.1
