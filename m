From: Julian Wollrath <jwollrath@web.de>
Subject: Re: Fix internal mic on Dell Vostro 3500
Date: Wed, 9 Nov 2011 10:54:53 +0100
Message-ID: <201111091054.53548.jwollrath@web.de>
References: <201111081124.02671.jwollrath@web.de>
	<s5hr51hlou9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_t3kuOYa6A9vegaB"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fmmailgate04.web.de (fmmailgate04.web.de [217.72.192.242])
	by alsa0.perex.cz (Postfix) with ESMTP id 912B21039C9
	for <alsa-devel@alsa-project.org>; Wed,  9 Nov 2011 10:55:12 +0100 (CET)
Received: from moweb001.kundenserver.de (moweb001.kundenserver.de
	[172.19.20.114])
	by fmmailgate04.web.de (Postfix) with ESMTP id 7F6DD6ECF88C
	for <alsa-devel@alsa-project.org>; Wed,  9 Nov 2011 10:54:54 +0100 (CET)
In-Reply-To: <s5hr51hlou9.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_t3kuOYa6A9vegaB
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Am Mittwoch 09 November 2011, 08:47:10 schrieb Takashi Iwai:
> It's a PCI SSID value (not the codec's one).  Take a look at "lspci
> -nv" output, and fill the subsystem device number of the corresponding
> entry.
Thank you, the device number is filled in.


With best regards
Julian

--Boundary-00=_t3kuOYa6A9vegaB
Content-Type: text/x-patch;
  charset="UTF-8";
  name="0001-fix-internal-mic-on-Dell-Vostro-3500-laptop.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-fix-internal-mic-on-Dell-Vostro-3500-laptop.patch"

=46rom 881a81936c84b5d4462a952130f746bbf7be7a83 Mon Sep 17 00:00:00 2001
=46rom: Julian Wollrath <jwollrath@web.de>
Date: Wed, 9 Nov 2011 10:02:40 +0100
Subject: [PATCH] fix internal mic on Dell Vostro 3500 laptop

=46ix the not working internal mic on Dell Vostro 3500 laptop by introducin=
g the
new model dell-vostro-3500.

Signed-off-by: Julian Wollrath <jwollrath@web.de>
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
index 4e715fe..edc2b7b 100644
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
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x1028,
+		      "Dell Vostro 3500", STAC_DELL_VOSTRO_3500),
 	SND_PCI_QUIRK_MASK(PCI_VENDOR_ID_HP, 0xff00, 0x3600,
 			  "HP", STAC_92HD83XXX_HP),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x1656,
=2D-=20
1.7.7.2


--Boundary-00=_t3kuOYa6A9vegaB
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--Boundary-00=_t3kuOYa6A9vegaB--
