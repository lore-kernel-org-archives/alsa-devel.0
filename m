From: =?UTF-8?q?Adrien=20Verg=C3=A9?= <adrienverge@gmail.com>
Subject: [PATCH] ALSA: hda - Fix silent output on MacBook Air 1,1
Date: Fri, 24 Jan 2014 14:56:14 -0500
Message-ID: <1390593374-6592-1-git-send-email-adrienverge@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: Nicolo' <nicolopiazzalunga@gmail.com>, David Henningsson <david.henningsson@canonical.com>, Kailang Yang <kailang@realtek.com>, Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Adrien=20Verg=C3=A9?= <adrienverge@gmail.com>
List-Id: alsa-devel@alsa-project.org

Similarly to other Apple products, MBA 1,1 needs a specific quirk.
Pin 0x18 must be set to VREF_50 to have sound output.  This was no
longer done since commit 1a97b7f, resulting in a mute built-in speaker.

This patch corrects the regression by creating a fixup for the MBA 1,1.

Tested-by: Adrien Verg=C3=A9 <adrienverge@gmail.com>
Signed-off-by: Adrien Verg=C3=A9 <adrienverge@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realte=
k.c
index c564694..723de28 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -1780,6 +1780,7 @@ enum {
 	ALC889_FIXUP_DAC_ROUTE,
 	ALC889_FIXUP_MBP_VREF,
 	ALC889_FIXUP_IMAC91_VREF,
+	ALC889_FIXUP_MBA11_VREF,
 	ALC889_FIXUP_MBA21_VREF,
 	ALC882_FIXUP_INV_DMIC,
 	ALC882_FIXUP_NO_PRIMARY_HP,
@@ -1910,6 +1911,16 @@ static void alc889_fixup_imac91_vref(struct hda_=
codec *codec,
 		alc889_fixup_mac_pins(codec, nids, ARRAY_SIZE(nids));
 }
=20
+/* Set VREF on speaker pins on mba11 */
+static void alc889_fixup_mba11_vref(struct hda_codec *codec,
+				    const struct hda_fixup *fix, int action)
+{
+	static hda_nid_t nids[1] =3D { 0x18 };
+
+	if (action =3D=3D HDA_FIXUP_ACT_INIT)
+		alc889_fixup_mac_pins(codec, nids, ARRAY_SIZE(nids));
+}
+
 /* Set VREF on speaker pins on mba21 */
 static void alc889_fixup_mba21_vref(struct hda_codec *codec,
 				    const struct hda_fixup *fix, int action)
@@ -2119,6 +2130,12 @@ static const struct hda_fixup alc882_fixups[] =3D=
 {
 		.chained =3D true,
 		.chain_id =3D ALC882_FIXUP_GPIO1,
 	},
+	[ALC889_FIXUP_MBA11_VREF] =3D {
+		.type =3D HDA_FIXUP_FUNC,
+		.v.func =3D alc889_fixup_mba11_vref,
+		.chained =3D true,
+		.chain_id =3D ALC889_FIXUP_MBP_VREF,
+	},
 	[ALC889_FIXUP_MBA21_VREF] =3D {
 		.type =3D HDA_FIXUP_FUNC,
 		.v.func =3D alc889_fixup_mba21_vref,
@@ -2194,7 +2211,7 @@ static const struct snd_pci_quirk alc882_fixup_tb=
l[] =3D {
 	SND_PCI_QUIRK(0x106b, 0x2c00, "MacbookPro rev3", ALC889_FIXUP_MBP_VRE=
=46),
 	SND_PCI_QUIRK(0x106b, 0x3000, "iMac", ALC889_FIXUP_MBP_VREF),
 	SND_PCI_QUIRK(0x106b, 0x3200, "iMac 7,1 Aluminum", ALC882_FIXUP_EAPD)=
,
-	SND_PCI_QUIRK(0x106b, 0x3400, "MacBookAir 1,1", ALC889_FIXUP_MBP_VREF=
),
+	SND_PCI_QUIRK(0x106b, 0x3400, "MacBookAir 1,1", ALC889_FIXUP_MBA11_VR=
EF),
 	SND_PCI_QUIRK(0x106b, 0x3500, "MacBookAir 2,1", ALC889_FIXUP_MBA21_VR=
EF),
 	SND_PCI_QUIRK(0x106b, 0x3600, "Macbook 3,1", ALC889_FIXUP_MBP_VREF),
 	SND_PCI_QUIRK(0x106b, 0x3800, "MacbookPro 4,1", ALC889_FIXUP_MBP_VREF=
),
--=20
1.8.5.2
