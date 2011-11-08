From: Julian Wollrath <jwollrath@web.de>
Subject: Fix internal mic on Dell Vostro 3500
Date: Tue, 8 Nov 2011 11:24:02 +0100
Message-ID: <201111081124.02671.jwollrath@web.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_CNQuOtTOAspPCxm"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fmmailgate01.web.de (fmmailgate01.web.de [217.72.192.221])
	by alsa0.perex.cz (Postfix) with ESMTP id 3C1B824357
	for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2011 11:27:30 +0100 (CET)
Received: from moweb002.kundenserver.de (moweb002.kundenserver.de
	[172.19.20.108])
	by fmmailgate01.web.de (Postfix) with ESMTP id 713361A3C2E96
	for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2011 11:24:43 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_CNQuOtTOAspPCxm
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

the internal mic of my Dell Vostro 3500 was not working with kernel v3.2-rc1 
(and propably with none of the older kernels).

By choosing dell-s14 as the model I was able to get the internal mic working, 
but now my externel mic jack was a second headphone out jack. So I looked at 
the differences between the pin configurations of the auto model and the dell-
s14 model and found out, that setting the value of on 0x11 from default 
0x400000f6 to 0x90a60160 was responsible for the working internal mic.

I attached a patch that fixes this problem but it has a flaw. Since I did not 
know what value I have to put in the second argument of SND_PCI_QUIRK I put 
0x0000 as dummy in there. It works for me but if anyone could give me a hint 
on how to obtain, what I really have to put in there, I would be happy to fill 
in the right value.


With best regards
Julian Wollrath

--Boundary-00=_CNQuOtTOAspPCxm
Content-Type: text/x-patch;
  charset="UTF-8";
  name="0001-fix-internal-mic-on-Dell-Vostro-3500-laptop.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-fix-internal-mic-on-Dell-Vostro-3500-laptop.patch"

=46rom db0e6ef8e7842d0b3e0c1828c5b5a748593bd04f Mon Sep 17 00:00:00 2001
=46rom: Julian Wollrath <jwollrath@web.de>
Date: Tue, 8 Nov 2011 11:16:40 +0100
Subject: [PATCH] fix internal mic on Dell Vostro 3500 laptop

=46ix the not working internal mic on Dell Vostro 3500 laptop by introducin=
g the
new model dell-vostro-3500.
=2D--
 Documentation/sound/alsa/HD-Audio-Models.txt |    1 +
 sound/pci/hda/patch_sigmatel.c               |   11 +++++++++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/Documentation/sound/alsa/HD-Audio-Models.txt b/Documentation/s=
ound/alsa/HD-Audio-Models.txt
index 4f34432..edad99a 100644
=2D-- a/Documentation/sound/alsa/HD-Audio-Models.txt
+++ b/Documentation/sound/alsa/HD-Audio-Models.txt
@@ -349,6 +349,7 @@ STAC92HD83*
   ref		Reference board
   mic-ref	Reference board with power management for ports
   dell-s14	Dell laptop
+  dell-vostro-3500	Dell Vostro 3500 laptop
   hp		HP laptops with (inverted) mute-LED
   hp-dv7-4000	HP dv-7 4000
   auto		BIOS setup (default)
diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 4e715fe..de3b31f 100644
=2D-- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -95,6 +95,7 @@ enum {
 	STAC_92HD83XXX_REF,
 	STAC_92HD83XXX_PWR_REF,
 	STAC_DELL_S14,
+	STAC_DELL_VOSTRO_3500,
 	STAC_92HD83XXX_HP,
 	STAC_92HD83XXX_HP_cNB11_INTQUAD,
 	STAC_HP_DV7_4000,
@@ -1659,6 +1660,12 @@ static const unsigned int dell_s14_pin_configs[10] =
=3D {
 	0x40f000f0, 0x40f000f0,
 };
=20
+static const unsigned int dell_vostro_3500_pin_configs[10] =3D {
+	0x02a11020, 0x0221101f, 0x400000f0, 0x90170110,
+	0x400000f1, 0x400000f2, 0x400000f3, 0x90a60160,
+	0x400000f4, 0x400000f5,
+};
+
 static const unsigned int hp_dv7_4000_pin_configs[10] =3D {
 	0x03a12050, 0x0321201f, 0x40f000f0, 0x90170110,
 	0x40f000f0, 0x40f000f0, 0x90170110, 0xd5a30140,
@@ -1675,6 +1682,7 @@ static const unsigned int *stac92hd83xxx_brd_tbl[STAC=
_92HD83XXX_MODELS] =3D {
 	[STAC_92HD83XXX_REF] =3D ref92hd83xxx_pin_configs,
 	[STAC_92HD83XXX_PWR_REF] =3D ref92hd83xxx_pin_configs,
 	[STAC_DELL_S14] =3D dell_s14_pin_configs,
+	[STAC_DELL_VOSTRO_3500] =3D dell_vostro_3500_pin_configs,
 	[STAC_92HD83XXX_HP_cNB11_INTQUAD] =3D hp_cNB11_intquad_pin_configs,
 	[STAC_HP_DV7_4000] =3D hp_dv7_4000_pin_configs,
 };
@@ -1684,6 +1692,7 @@ static const char * const stac92hd83xxx_models[STAC_9=
2HD83XXX_MODELS] =3D {
 	[STAC_92HD83XXX_REF] =3D "ref",
 	[STAC_92HD83XXX_PWR_REF] =3D "mic-ref",
 	[STAC_DELL_S14] =3D "dell-s14",
+	[STAC_DELL_VOSTRO_3500] =3D "dell-vostro-3500",
 	[STAC_92HD83XXX_HP] =3D "hp",
 	[STAC_92HD83XXX_HP_cNB11_INTQUAD] =3D "hp_cNB11_intquad",
 	[STAC_HP_DV7_4000] =3D "hp-dv7-4000",
@@ -1697,6 +1706,8 @@ static const struct snd_pci_quirk stac92hd83xxx_cfg_t=
bl[] =3D {
 		      "DFI LanParty", STAC_92HD83XXX_REF),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x02ba,
 		      "unknown Dell", STAC_DELL_S14),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x0000,
+		      "Dell Vostro 3500", STAC_DELL_VOSTRO_3500),
 	SND_PCI_QUIRK_MASK(PCI_VENDOR_ID_HP, 0xff00, 0x3600,
 			  "HP", STAC_92HD83XXX_HP),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x1656,
=2D-=20
1.7.7.1


--Boundary-00=_CNQuOtTOAspPCxm
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--Boundary-00=_CNQuOtTOAspPCxm--
