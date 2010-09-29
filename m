From: =?UTF-8?q?Diego=20Elio=20Petten=C3=B2?= <flameeyes@gmail.com>
Subject: [PATCH] ALSA: HDA: Enable internal mic on Dell E6410 and Dell E6510
Date: Wed, 29 Sep 2010 04:09:01 +0200
Message-ID: <1285726141-26448-2-git-send-email-flameeyes@gmail.com>
References: <1285726141-26448-1-git-send-email-flameeyes@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1285726141-26448-1-git-send-email-flameeyes@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

=46rom: David Henningsson <david.henningsson@canonical.com>

BugLink: http://launchpad.net/bugs/628961
BugLink: http://launchpad.net/bugs/605047

CC: Diego Elio Petten=C3=B2 <flameeyes@gmail.com>
---
 sound/pci/hda/patch_sigmatel.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigma=
tel.c
index b8d730c..d2e2706 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -93,6 +93,7 @@ enum {
 	STAC_92HD83XXX_REF,
 	STAC_92HD83XXX_PWR_REF,
 	STAC_DELL_S14,
+	STAC_DELL_E6410,
 	STAC_92HD83XXX_HP,
 	STAC_92HD83XXX_MODELS
 };
@@ -1632,10 +1633,18 @@ static unsigned int dell_s14_pin_configs[10] =3D=
 {
 	0x40f000f0, 0x40f000f0,
 };
=20
+/* Deliberately turn off 0x0f (Dock Mic) to make it choose Int Mic ins=
tead */
+static unsigned int dell_e6410_pin_configs[10] =3D {
+	0x04a11020, 0x0421101f, 0x400000f0, 0x90170110,
+	0x23011050, 0x40f000f0, 0x400000f0, 0x90a60130,
+	0x40f000f0, 0x40f000f0,
+};
+
 static unsigned int *stac92hd83xxx_brd_tbl[STAC_92HD83XXX_MODELS] =3D =
{
 	[STAC_92HD83XXX_REF] =3D ref92hd83xxx_pin_configs,
 	[STAC_92HD83XXX_PWR_REF] =3D ref92hd83xxx_pin_configs,
 	[STAC_DELL_S14] =3D dell_s14_pin_configs,
+	[STAC_DELL_E6410] =3D dell_e6410_pin_configs,
 };
=20
 static const char *stac92hd83xxx_models[STAC_92HD83XXX_MODELS] =3D {
@@ -1643,6 +1652,7 @@ static const char *stac92hd83xxx_models[STAC_92HD=
83XXX_MODELS] =3D {
 	[STAC_92HD83XXX_REF] =3D "ref",
 	[STAC_92HD83XXX_PWR_REF] =3D "mic-ref",
 	[STAC_DELL_S14] =3D "dell-s14",
+	[STAC_DELL_E6410] =3D "dell-e6410",
 	[STAC_92HD83XXX_HP] =3D "hp",
 };
=20
@@ -1654,6 +1664,10 @@ static struct snd_pci_quirk stac92hd83xxx_cfg_tb=
l[] =3D {
 		      "DFI LanParty", STAC_92HD83XXX_REF),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x02ba,
 		      "unknown Dell", STAC_DELL_S14),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x040a,
+		      "Dell E6410", STAC_DELL_E6410),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x040b,
+		      "Dell E6510", STAC_DELL_E6410),
 	SND_PCI_QUIRK_MASK(PCI_VENDOR_ID_HP, 0xff00, 0x3600,
 		      "HP", STAC_92HD83XXX_HP),
 	{} /* terminator */
--=20
1.7.3
