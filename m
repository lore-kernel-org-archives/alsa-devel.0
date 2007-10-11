From: glogow@fbihome.de
Subject: intel-hda patch for Dell Latitude D531
Date: Thu, 11 Oct 2007 18:54:56 +0200
Message-ID: <20071011185456.3qrqlh5dt4hwkwsk@stud.fbi.h-da.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=_5zwye1frjnnk"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fbihome.de (stud.fbi.h-da.de [141.100.40.65])
	by alsa0.perex.cz (Postfix) with ESMTP id 5705024498
	for <alsa-devel@alsa-project.org>;
	Thu, 11 Oct 2007 18:55:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by fbihome.de (Postfix) with ESMTP id 9E8639332B
	for <alsa-devel@alsa-project.org>;
	Thu, 11 Oct 2007 18:54:57 +0200 (CEST)
Received: from fbihome.de ([127.0.0.1])
	by localhost (stud1 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 30696-06 for <alsa-devel@alsa-project.org>;
	Thu, 11 Oct 2007 18:54:57 +0200 (CEST)
Received: from fbihome.de (localhost [127.0.0.1])
	by fbihome.de (Postfix) with ESMTP id 4300A9331B
	for <alsa-devel@alsa-project.org>;
	Thu, 11 Oct 2007 18:54:57 +0200 (CEST)
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

This message is in MIME format.

--=_5zwye1frjnnk
Content-Type: text/plain;
	charset=UTF-8;
	DelSp="Yes";
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi

I have attached three files to this mail:

1. patch_sigmatel.c.diff

I have a Latitude D531 which has a ATI SB600 with a STAC 9205. The =20
chip is detected, but no config was read with the latest drivers. The =20
problems are the dmic_nids arrays, which are ignored for auto config =20
lookup. This calles is_in_nid_list, which expects a 0 terminated list, =20
but these arrays are not.

Additionally I updated the dell_9205_m43_pin_configs with values from =20
the latest win drivers.

2. create_dell_tables.pl

When looking into the ini files and comparing the nids and config =20
values of the various tables, I got really confused, so I wrote a =20
litte script to extract the values and build the table. This is the =20
extended version, after I got my sound working. It extracts all pin =20
infos from all ini files, generates the apropriate tables and prepends =20
the Version.txt from the driver, resultiung in a kind of C header. =20
Maybe it's usefull for you.

3. patch_sigmatel_dell.h

Output from running create_dell_tables.pl on the latest drivers for my =20
D531 from  Dell.

HTH

Jan-Marek Glogowski


----------------------------------------------------------------
This message was sent using IMP, the Internet Messaging Program.


--=_5zwye1frjnnk
Content-Type: text/plain;
	charset=UTF-8;
	name="patch_sigmatel.c.diff"
Content-Disposition: attachment;
	filename="patch_sigmatel.c.diff"
Content-Transfer-Encoding: quoted-printable

--- patch_sigmatel.c.orig=092007-10-10 20:17:29.000000000 +0200
+++ patch_sigmatel.c=092007-10-10 20:18:44.000000000 +0200
@@ -182,8 +182,11 @@
         0x02,
 };
=20
-static hda_nid_t stac925x_dmic_nids[1] =3D {
-=090x15,=20
+// DMic nids are ignored on auto config, so the array has to be NULL=20
+// terminated for is_in_nid_list
+static int stac925x_dmic_nids_len =3D 1;
+static hda_nid_t stac925x_dmic_nids[stac925x_dmic_nids_len + 1] =3D {
+=090x15, 0x00,
 };
=20
 static hda_nid_t stac922x_adc_nids[2] =3D {
@@ -210,8 +213,11 @@
         0x19, 0x1a
 };
=20
-static hda_nid_t stac9205_dmic_nids[2] =3D {
-        0x17, 0x18,
+// DMic nids are ignored on auto config, so the array has to be NULL=20
+// terminated for is_in_nid_list
+static int stac9205_dmic_nids_len =3D 2;
+static hda_nid_t stac9205_dmic_nids[stac9205_dmic_nids_len + 1] =3D {
+        0x17, 0x18, 0x00,
 };
=20
 static hda_nid_t stac9200_pin_nids[8] =3D {
@@ -1146,9 +1152,10 @@
     10280201
 */
 static unsigned int dell_9205_m43_pin_configs[12] =3D {
-=090x0321101f, 0x03a11020, 0x90a70330, 0x90170310,
-=090x400000fe, 0x400000ff, 0x400000fd, 0x40f000f9,
-=090x400000fa, 0x400000fc, 0x0144131f, 0x40c003f8,
+=09/* based on 92XXM4-3.ini from Dell Driver 5.10.0.5401 */
+=090x0321101f, 0x03a1102e, 0x90a70320, 0x90170310,
+=090x400000fe, 0x400000ff, 0x400000fd, 0x400000fb,
+=090x400000fa, 0x400000fc, 0x01441340, 0x400000f9,
 };
=20
 static unsigned int dell_9205_m44_pin_configs[12] =3D {
@@ -2548,8 +2555,8 @@
 =09case 0x83847633: /* STAC9202D */
 =09case 0x83847636: /* STAC9251  */
 =09case 0x83847637: /* STAC9251D */
-=09=09spec->num_dmics =3D 1;
 =09=09spec->dmic_nids =3D stac925x_dmic_nids;
+=09=09spec->num_dmics =3D stac925x_dmic_nids_len;
 =09=09break;
 =09default:
 =09=09spec->num_dmics =3D 0;
@@ -2798,7 +2805,7 @@
 =09spec->mux_nids =3D stac9205_mux_nids;
 =09spec->num_muxes =3D ARRAY_SIZE(stac9205_mux_nids);
 =09spec->dmic_nids =3D stac9205_dmic_nids;
-=09spec->num_dmics =3D ARRAY_SIZE(stac9205_dmic_nids);
+=09spec->num_dmics =3D stac9205_dmic_nids_len;
 =09spec->dmux_nid =3D 0x1d;
=20
 =09spec->init =3D stac9205_core_init;

--=_5zwye1frjnnk
Content-Type: text/x-chdr;
	charset=UTF-8;
	name="patch_sigmatel_dell.h"
Content-Disposition: attachment;
	filename="patch_sigmatel_dell.h"
Content-Transfer-Encoding: quoted-printable

/**
 * This file was generated from the ini files of
 *
 * Title      : Audio: SIGMATEL STAC 92XX C-Major HD Audio Driver
 * Version    : A08
 * OEM Name   : SIGMATEL
 * OEM Ver    : 5.10.0.5401
 * Computers  : Latitude: ATG D630, D430, D531, D630, D631, D830; Precision:=
 M4300; Vostro Notebook: 1000
 * OS         : Windows 2000,Windows XP,Windows XP x64
 * Languages  : Brazilian Portuguese, Chinese-S, Chinese-T, English, French,=
 German, Japanese, Korean, Spanish
 * Created    : Wednesday, July 11, 2007
 **/

#ifndef PATCH_SIGMATEL_DELL_H
#define PATCH_SIGMATEL_DELL_H

// perl nid hash: 0x080x090x0d0x0e0x0f0x100x110x12
// matches to: stac9200
static hda_nid_t stac9200_pin_nids[8] =3D {
=090x08,       0x09,       0x0d,       0x0e,       0x0f,      =20
=090x10,       0x11,       0x12,      =20
};

// perl nid hash: 0x0a0x0b0x0c0x0d0x0e0x0f0x140x160x210x22
// matches to: stac_92xx_dell_m41
static hda_nid_t stac_92xx_dell_m41_pin_nids[10] =3D {
=090x0a,       0x0b,       0x0c,       0x0d,       0x0e,      =20
=090x0f,       0x14,       0x16,       0x21,       0x22,      =20
};

// perl nid hash: 0x0a0x0b0x0c0x0d0x0e0x0f0x140x160x170x180x210x22
// matches to: stac9205
static hda_nid_t stac9205_pin_nids[12] =3D {
=090x0a,       0x0b,       0x0c,       0x0d,       0x0e,      =20
=090x0f,       0x14,       0x16,       0x17,       0x18,      =20
=090x21,       0x22,      =20
};

// perl nid hash: 0x0a0x0b0x0c0x0d0x0e0x0f0x100x110x150x1b
// matches to: stac922x
static hda_nid_t stac922x_pin_nids[10] =3D {
=090x0a,       0x0b,       0x0c,       0x0d,       0x0e,      =20
=090x0f,       0x10,       0x11,       0x15,       0x1b,      =20
};

// perl nid hash: 0x0a0x0b0x0c0x0d0x0e0x0f0x100x110x120x130x140x210x22
// matches to: stac_92xx_dell_m83
static hda_nid_t stac_92xx_dell_m83_pin_nids[13] =3D {
=090x0a,       0x0b,       0x0c,       0x0d,       0x0e,      =20
=090x0f,       0x10,       0x11,       0x12,       0x13,      =20
=090x14,       0x21,       0x22,      =20
};

static unsigned int stac_9200_dell_m21_pin_configs[8] =3D {
=090x40c003fa, 0x03441340, 0x0321121f, 0x90170310, 0x408003fb,=20
=090x03a1102e, 0x401003fc, 0x403003fd,=20
};

static unsigned int stac_9200_dell_m22_pin_configs[8] =3D {
=090x40c003fa, 0x01441340, 0x0321121f, 0x90170310, 0x90a70320,=20
=090x03a1102e, 0x401003fb, 0x403003fc,=20
};

static unsigned int stac_9200_dell_m23_pin_configs[8] =3D {
=090x40c003fa, 0x01441340, 0x0421121f, 0x90170310, 0x408003fb,=20
=090x04a1102e, 0x90170311, 0x403003fc,=20
};

static unsigned int stac_9200_dell_m24_pin_configs[8] =3D {
=090x40c003fa, 0x404003fb, 0x0321121f, 0x90170310, 0x408003fc,=20
=090x03a1102e, 0x401003fd, 0x403003fe,=20
};

static unsigned int stac_9200_dell_m25_pin_configs[8] =3D {
=090x40c003fa, 0x01441340, 0x0421121f, 0x90170310, 0x408003fb,=20
=090x04a1102e, 0x401003fc, 0x403003fd,=20
};

static unsigned int stac_9200_dell_m26_pin_configs[8] =3D {
=090x40c003fa, 0x404003fb, 0x0421121f, 0x90170310, 0x408003fc,=20
=090x04a1102e, 0x401003fd, 0x403003fe,=20
};

static unsigned int stac_9200_dell_m27_pin_configs[8] =3D {
=090x40c003fa, 0x01441340, 0x0421121f, 0x90170310, 0x408003fb,=20
=090x04a1102e, 0x90170311, 0x403003fc,=20
};

static unsigned int stac_9200_dell_m28_pin_configs[8] =3D {
=090x40c003fa, 0x01441340, 0x0321121f, 0x90170310, 0x90a70320,=20
=090x03a1102e, 0x401003fb, 0x403003fc,=20
};

static unsigned int stac_9200_dell_m29_pin_configs[8] =3D {
=090x40c003fa, 0x404003fb, 0x0421121f, 0x90170310, 0x408003fc,=20
=090x04a1102e, 0x401003fd, 0x403003fe,=20
};

static unsigned int stac_9200_dell_nom_m28_pin_configs[8] =3D {
=090x40c003fa, 0x01441340, 0x0321121f, 0x90170310, 0x400003f1,=20
=090x400003f2, 0x401003fb, 0x403003fc,=20
};

static unsigned int stac_92xx_dell_m83_pin_configs[13] =3D {
=090x02211210, 0x400003fa, 0x400003fb, 0x90170310, 0x0281103e,=20
=090x0221122f, 0x400003fc, 0x400003fd, 0x400003fe, 0x90a60330,=20
=090x400003ff, 0x04441340, 0x40c003f1,=20
};

static unsigned int stac_92xx_dell_m84_pin_configs[13] =3D {
=090x02211210, 0x400003fa, 0x400003fb, 0x90170310, 0x0281103e,=20
=090x0221122f, 0x400003fc, 0x400003fd, 0x400003fe, 0x90a60330,=20
=090x400003ff, 0x01441340, 0x40c003f1,=20
};

static unsigned int stac_92xx_dell_m85_pin_configs[13] =3D {
=090x02211210, 0x400003fa, 0x400003fb, 0x90170310, 0x0281103e,=20
=090x0221122f, 0x400003fc, 0x400003fd, 0x400003fe, 0x400003f2,=20
=090x400003ff, 0x01441340, 0x40c003f1,=20
};

static unsigned int stac_92xx_dell_m86_pin_configs[13] =3D {
=090x02211210, 0x400003fa, 0x400003fb, 0x90170310, 0x0281103e,=20
=090x0221122f, 0x400003fc, 0x400003fd, 0x400003fe, 0x90a60330,=20
=090x400003ff, 0x01441340, 0x40c003f1,=20
};

static unsigned int stac_92xx_dell_nom_m83_pin_configs[13] =3D {
=090x02211210, 0x400003fa, 0x400003fb, 0x90170310, 0x02111022,=20
=090x0221122f, 0x400003fc, 0x400003fd, 0x400003fe, 0x400003f2,=20
=090x400003f3, 0x04441340, 0x40c003f1,=20
};

static unsigned int stac_92xx_dell_nom_m84_pin_configs[13] =3D {
=090x02211210, 0x400003fa, 0x400003fb, 0x90170310, 0x02111022,=20
=090x0221122f, 0x400003fc, 0x400003fd, 0x400003fe, 0x400003f2,=20
=090x400003f3, 0x01441340, 0x40c003f1,=20
};

static unsigned int stac_922x_dell_m81_pin_configs[10] =3D {
=090x0321121f, 0x01112024, 0x01111222, 0x91174220, 0x03811032,=20
=090x01116221, 0x01452340, 0x40c003f1, 0x90a70330, 0x405003f0,=20
};

static unsigned int stac_922x_dell_m82_pin_configs[10] =3D {
=090x02211210, 0x408103ff, 0x0281123e, 0x90100310, 0x408003f1,=20
=090x0221122f, 0x03451340, 0x40c003f2, 0x508003f3, 0x405003f4,=20
};

static unsigned int stac_9205_dell_m42_pin_configs[12] =3D {
=090x0421101f, 0x04a1102e, 0x400003fa, 0x90170310, 0x400003fb,=20
=090x400003fc, 0x400003fd, 0x400003fe, 0x90a60320, 0x400003ff,=20
=090x01441340, 0x40c003f1,=20
};

static unsigned int stac_9205_dell_m43_pin_configs[12] =3D {
=090x0321101f, 0x03a1102e, 0x90a70320, 0x90170310, 0x400000fe,=20
=090x400000ff, 0x400000fd, 0x400000fb, 0x400000fa, 0x400000fc,=20
=090x01441340, 0x400000f9,=20
};

static unsigned int stac_9205_dell_m44_pin_configs[12] =3D {
=090x0421101f, 0x04a1102e, 0x400003fa, 0x90170310, 0x400003fb,=20
=090x400003fc, 0x400003fd, 0x400003fe, 0x90a60320, 0x400003ff,=20
=090x01441340, 0x40c003f1,=20
};

static unsigned int stac_9205_dell_m45_pin_configs[12] =3D {
=090x0321101f, 0x03a1102e, 0x90a70320, 0x90170310, 0x400000fe,=20
=090x400000ff, 0x400000fd, 0x400000fb, 0x400000fa, 0x400000fc,=20
=090x01441340, 0x400000f9,=20
};

static unsigned int stac_9205_dell_nom_m42_pin_configs[12] =3D {
=090x0321101f, 0x400003f2, 0x400003fa, 0x90170310, 0x400003fb,=20
=090x400003fc, 0x400003fd, 0x400003fe, 0x400003f3, 0x400003ff,=20
=090x01441340, 0x40c003f1,=20
};

static unsigned int stac_9205_dell_nom_m43_pin_configs[12] =3D {
=090x0321101f, 0x400003f8, 0x400003f7, 0x90170310, 0x400000fe,=20
=090x400000ff, 0x400000fd, 0x400000fb, 0x400000fa, 0x400000fc,=20
=090x01441340, 0x400000f9,=20
};

static unsigned int stac_92xx_dell_m41_pin_configs[10] =3D {
=090x0321101f, 0x03a1102e, 0x90a70320, 0x90170310, 0x400000fe,=20
=090x400000ff, 0x400000fd, 0x400000fb, 0x01441340, 0x400000f9,=20
};

enum {
=09STAC_9200_DELL_M21,
=09STAC_9200_DELL_M22,
=09STAC_9200_DELL_M23,
=09STAC_9200_DELL_M24,
=09STAC_9200_DELL_M25,
=09STAC_9200_DELL_M26,
=09STAC_9200_DELL_M27,
=09STAC_9200_DELL_M28,
=09STAC_9200_DELL_M29,
=09STAC_9200_DELL_NOM_M28,
=09STAC_9200_DELL_MODELS
};

enum {
=09STAC_92XX_DELL_M83,
=09STAC_92XX_DELL_M84,
=09STAC_92XX_DELL_M85,
=09STAC_92XX_DELL_M86,
=09STAC_92XX_DELL_NOM_M83,
=09STAC_92XX_DELL_NOM_M84,
=09STAC_92XX_DELL_M83_MODELS
};

enum {
=09STAC_922X_DELL_M81,
=09STAC_922X_DELL_M82,
=09STAC_922X_DELL_MODELS
};

enum {
=09STAC_9205_DELL_M42,
=09STAC_9205_DELL_M43,
=09STAC_9205_DELL_M44,
=09STAC_9205_DELL_M45,
=09STAC_9205_DELL_NOM_M42,
=09STAC_9205_DELL_NOM_M43,
=09STAC_9205_DELL_MODELS
};

enum {
=09STAC_92XX_DELL_M41,
=09STAC_92XX_DELL_M41_MODELS
};

static unsigned int *stac_9200_dell_brd_tbl[STAC_9200_DELL_MODELS] =3D {
=09[STAC_9200_DELL_M21] =3D stac_9200_dell_m21_pin_config,
=09[STAC_9200_DELL_M22] =3D stac_9200_dell_m22_pin_config,
=09[STAC_9200_DELL_M23] =3D stac_9200_dell_m23_pin_config,
=09[STAC_9200_DELL_M24] =3D stac_9200_dell_m24_pin_config,
=09[STAC_9200_DELL_M25] =3D stac_9200_dell_m25_pin_config,
=09[STAC_9200_DELL_M26] =3D stac_9200_dell_m26_pin_config,
=09[STAC_9200_DELL_M27] =3D stac_9200_dell_m27_pin_config,
=09[STAC_9200_DELL_M28] =3D stac_9200_dell_m28_pin_config,
=09[STAC_9200_DELL_M29] =3D stac_9200_dell_m29_pin_config,
=09[STAC_9200_DELL_NOM_M28] =3D stac_9200_dell_nom_m28_pin_config,
};

static unsigned int *stac_92xx_dell_m83_brd_tbl[STAC_92XX_DELL_M83_MODELS] =
=3D {
=09[STAC_92XX_DELL_M83] =3D stac_92xx_dell_m83_pin_config,
=09[STAC_92XX_DELL_M84] =3D stac_92xx_dell_m84_pin_config,
=09[STAC_92XX_DELL_M85] =3D stac_92xx_dell_m85_pin_config,
=09[STAC_92XX_DELL_M86] =3D stac_92xx_dell_m86_pin_config,
=09[STAC_92XX_DELL_NOM_M83] =3D stac_92xx_dell_nom_m83_pin_config,
=09[STAC_92XX_DELL_NOM_M84] =3D stac_92xx_dell_nom_m84_pin_config,
};

static unsigned int *stac_922x_dell_brd_tbl[STAC_922X_DELL_MODELS] =3D {
=09[STAC_922X_DELL_M81] =3D stac_922x_dell_m81_pin_config,
=09[STAC_922X_DELL_M82] =3D stac_922x_dell_m82_pin_config,
};

static unsigned int *stac_9205_dell_brd_tbl[STAC_9205_DELL_MODELS] =3D {
=09[STAC_9205_DELL_M42] =3D stac_9205_dell_m42_pin_config,
=09[STAC_9205_DELL_M43] =3D stac_9205_dell_m43_pin_config,
=09[STAC_9205_DELL_M44] =3D stac_9205_dell_m44_pin_config,
=09[STAC_9205_DELL_M45] =3D stac_9205_dell_m45_pin_config,
=09[STAC_9205_DELL_NOM_M42] =3D stac_9205_dell_nom_m42_pin_config,
=09[STAC_9205_DELL_NOM_M43] =3D stac_9205_dell_nom_m43_pin_config,
};

static unsigned int *stac_92xx_dell_m41_brd_tbl[STAC_92XX_DELL_M41_MODELS] =
=3D {
=09[STAC_92XX_DELL_M41] =3D stac_92xx_dell_m41_pin_config,
};

static struct snd_pci_quirk stac_9200_dell_cfg_tbl[] =3D {
=09SND_PCI_QUIRK[PCI_VENDOR_ID_DELL, 0x01b5,
=09=09=09"Unknown Dell", STAC_9200_DELL_M21),
=09SND_PCI_QUIRK[PCI_VENDOR_ID_DELL, 0x01d8,
=09=09=09"Unknown Dell", STAC_9200_DELL_M21),
=09SND_PCI_QUIRK[PCI_VENDOR_ID_DELL, 0x01c2,
=09=09=09"Unknown Dell", STAC_9200_DELL_M22),
=09SND_PCI_QUIRK[PCI_VENDOR_ID_DELL, 0x01c8,
=09=09=09"Unknown Dell", STAC_9200_DELL_M22),
=09SND_PCI_QUIRK[PCI_VENDOR_ID_DELL, 0x01cc,
=09=09=09"Unknown Dell", STAC_9200_DELL_M22),
=09SND_PCI_QUIRK[PCI_VENDOR_ID_DELL, 0x01d4,
=09=09=09"Unknown Dell", STAC_9200_DELL_M22),
=09SND_PCI_QUIRK[PCI_VENDOR_ID_DELL, 0x01d6,
=09=09=09"Unknown Dell", STAC_9200_DELL_M22),
=09SND_PCI_QUIRK[PCI_VENDOR_ID_DELL, 0x01ce,
=09=09=09"Unknown Dell", STAC_9200_DELL_M23),
=09SND_PCI_QUIRK[PCI_VENDOR_ID_DELL, 0x01cf,
=09=09=09"Unknown Dell", STAC_9200_DELL_M23),
=09SND_PCI_QUIRK[PCI_VENDOR_ID_DELL, 0x01c9,
=09=09=09"Unknown Dell", STAC_9200_DELL_M24),
=09SND_PCI_QUIRK[PCI_VENDOR_ID_DELL, 0x01ca,
=09=09=09"Unknown Dell", STAC_9200_DELL_M24),
=09SND_PCI_QUIRK[PCI_VENDOR_ID_DELL, 0x01cb,
=09=09=09"Unknown Dell", STAC_9200_DELL_M24),
=09SND_PCI_QUIRK[PCI_VENDOR_ID_DELL, 0x01d3,
=09=09=09"Unknown Dell", STAC_9200_DELL_M24),
=09SND_PCI_QUIRK[PCI_VENDOR_ID_DELL, 0x01bd,
=09=09=09"Unknown Dell", STAC_9200_DELL_M25),
=09SND_PCI_QUIRK[PCI_VENDOR_ID_DELL, 0x01ee,
=09=09=09"Unknown Dell", STAC_9200_DELL_M25),
=09SND_PCI_QUIRK[PCI_VENDOR_ID_DELL, 0x01ef,
=09=09=09"Unknown Dell", STAC_9200_DELL_M25),
=09SND_PCI_QUIRK[PCI_VENDOR_ID_DELL, 0x01f6,
=09=09=09"Unknown Dell", STAC_9200_DELL_M26),
=09SND_PCI_QUIRK[PCI_VENDOR_ID_DELL, 0x01cd,
=09=09=09"Unknown Dell", STAC_9200_DELL_M27),
=09SND_PCI_QUIRK[PCI_VENDOR_ID_DELL, 0x0201,
=09=09=09"Unknown Dell", STAC_9200_DELL_M28),
=09SND_PCI_QUIRK[PCI_VENDOR_ID_DELL, 0x01f5,
=09=09=09"Unknown Dell", STAC_9200_DELL_M29),
=09SND_PCI_QUIRK[PCI_VENDOR_ID_DELL, 0x0218,
=09=09=09"Unknown Dell", STAC_9200_DELL_NOM_M28),
};

static struct snd_pci_quirk stac_92xx_dell_m83_cfg_tbl[] =3D {
=09SND_PCI_QUIRK[PCI_VENDOR_ID_DELL, 0x01f3,
=09=09=09"Unknown Dell", STAC_92XX_DELL_M83),
=09SND_PCI_QUIRK[PCI_VENDOR_ID_DELL, 0x0209,
=09=09=09"Unknown Dell", STAC_92XX_DELL_M83),
=09SND_PCI_QUIRK[PCI_VENDOR_ID_DELL, 0x020a,
=09=09=09"Unknown Dell", STAC_92XX_DELL_M83),
=09SND_PCI_QUIRK[PCI_VENDOR_ID_DELL, 0x020d,
=09=09=09"Unknown Dell", STAC_92XX_DELL_M83),
=09SND_PCI_QUIRK[PCI_VENDOR_ID_DELL, 0x020e,
=09=09=09"Unknown Dell", STAC_92XX_DELL_M83),
=09SND_PCI_QUIRK[PCI_VENDOR_ID_DELL, 0x01f8,
=09=09=09"Unknown Dell", STAC_92XX_DELL_M84),
=09SND_PCI_QUIRK[PCI_VENDOR_ID_DELL, 0x0203,
=09=09=09"Unknown Dell", STAC_92XX_DELL_M85),
=09SND_PCI_QUIRK[PCI_VENDOR_ID_DELL, 0x01f7,
=09=09=09"Unknown Dell", STAC_92XX_DELL_M86),
=09SND_PCI_QUIRK[PCI_VENDOR_ID_DELL, 0x021a,
=09=09=09"Unknown Dell", STAC_92XX_DELL_NOM_M83),
=09SND_PCI_QUIRK[PCI_VENDOR_ID_DELL, 0x021c,
=09=09=09"Unknown Dell", STAC_92XX_DELL_NOM_M84),
};

static struct snd_pci_quirk stac_922x_dell_cfg_tbl[] =3D {
=09SND_PCI_QUIRK[PCI_VENDOR_ID_DELL, 0x01bf,
=09=09=09"Unknown Dell", STAC_922X_DELL_M81),
=09SND_PCI_QUIRK[PCI_VENDOR_ID_DELL, 0x01d7,
=09=09=09"Unknown Dell", STAC_922X_DELL_M82),
};

static struct snd_pci_quirk stac_9205_dell_cfg_tbl[] =3D {
=09SND_PCI_QUIRK[PCI_VENDOR_ID_DELL, 0x0204,
=09=09=09"Unknown Dell", STAC_9205_DELL_M42),
=09SND_PCI_QUIRK[PCI_VENDOR_ID_DELL, 0x01f9,
=09=09=09"Unknown Dell", STAC_9205_DELL_M43),
=09SND_PCI_QUIRK[PCI_VENDOR_ID_DELL, 0x01fa,
=09=09=09"Unknown Dell", STAC_9205_DELL_M43),
=09SND_PCI_QUIRK[PCI_VENDOR_ID_DELL, 0x01fe,
=09=09=09"Unknown Dell", STAC_9205_DELL_M43),
=09SND_PCI_QUIRK[PCI_VENDOR_ID_DELL, 0x01ff,
=09=09=09"Unknown Dell", STAC_9205_DELL_M43),
=09SND_PCI_QUIRK[PCI_VENDOR_ID_DELL, 0x0206,
=09=09=09"Unknown Dell", STAC_9205_DELL_M43),
=09SND_PCI_QUIRK[PCI_VENDOR_ID_DELL, 0x01f1,
=09=09=09"Unknown Dell", STAC_9205_DELL_M44),
=09SND_PCI_QUIRK[PCI_VENDOR_ID_DELL, 0x01f2,
=09=09=09"Unknown Dell", STAC_9205_DELL_M44),
=09SND_PCI_QUIRK[PCI_VENDOR_ID_DELL, 0x01fc,
=09=09=09"Unknown Dell", STAC_9205_DELL_M44),
=09SND_PCI_QUIRK[PCI_VENDOR_ID_DELL, 0x01fd,
=09=09=09"Unknown Dell", STAC_9205_DELL_M44),
=09SND_PCI_QUIRK[PCI_VENDOR_ID_DELL, 0x021f,
=09=09=09"Unknown Dell", STAC_9205_DELL_M44),
=09SND_PCI_QUIRK[PCI_VENDOR_ID_DELL, 0x0200,
=09=09=09"Unknown Dell", STAC_9205_DELL_M45),
=09SND_PCI_QUIRK[PCI_VENDOR_ID_DELL, 0x0217,
=09=09=09"Unknown Dell", STAC_9205_DELL_NOM_M42),
=09SND_PCI_QUIRK[PCI_VENDOR_ID_DELL, 0x0212,
=09=09=09"Unknown Dell", STAC_9205_DELL_NOM_M43),
=09SND_PCI_QUIRK[PCI_VENDOR_ID_DELL, 0x0213,
=09=09=09"Unknown Dell", STAC_9205_DELL_NOM_M43),
=09SND_PCI_QUIRK[PCI_VENDOR_ID_DELL, 0x0216,
=09=09=09"Unknown Dell", STAC_9205_DELL_NOM_M43),
=09SND_PCI_QUIRK[PCI_VENDOR_ID_DELL, 0x0219,
=09=09=09"Unknown Dell", STAC_9205_DELL_NOM_M43),
=09SND_PCI_QUIRK[PCI_VENDOR_ID_DELL, 0x021b,
=09=09=09"Unknown Dell", STAC_9205_DELL_NOM_M43),
};

static struct snd_pci_quirk stac_92xx_dell_m41_cfg_tbl[] =3D {
=09SND_PCI_QUIRK[PCI_VENDOR_ID_DELL, 0x01e9,
=09=09=09"Unknown Dell", STAC_92XX_DELL_M41),
};

#endif


--=_5zwye1frjnnk
Content-Type: text/x-perl;
	charset=UTF-8;
	name="create_dell_tables.pl"
Content-Disposition: attachment;
	filename="create_dell_tables.pl"
Content-Transfer-Encoding: quoted-printable

#!/usr/bin/perl -w

# (c) 2007 Jan-Marek Glogowski <glogow@fbihome.de>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; version 2 of the License.
#=20
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

use strict;
use warnings;

use Config::IniFiles;

print << "EOF";
/**
 * This file was generated from the ini files of
 *
EOF

open( VERSION, "<../Version.txt" ) || die( "Couldn't open ../Version.txt: $!=
\n" );
while( <VERSION> ) {
  print " * $_";
}
close( VERSION );

print << "EOF";
 **/

#ifndef PATCH_SIGMATEL_DELL_H
#define PATCH_SIGMATEL_DELL_H

EOF

my $cfg =3D Config::IniFiles->new( -file =3D> 'Sthda.ini' );

my @models =3D $cfg->Parameters( 'Models' );

my %subini_models;
my %subini_enum; # ini -> enum
my %enum_subini; # enum -> ini

# Map to nid "hash" to alsa table names
my %nid_function_map =3D (
=09'0x080x090x0d0x0e0x0f0x100x110x12' =3D> '9200',
=09'0x0a0x0b0x0c0x0d0x0e0x0f0x140x160x170x180x210x22' =3D> '9205',
=09'0x0a0x0b0x0c0x0d0x0e0x0f0x100x110x150x1b' =3D> '922x',
);

# Parse models in main driver.ini
foreach my $model (@models)
{
=09next if( 'DEFAULT' eq $model );

=09my $arrayref;
=09my $subini =3D $cfg->val( 'Models', $model );
=09if( ! exists $subini_models{ $subini } ) {
=09=09my @tmparray =3D ();
=09=09$subini_models{ $subini } =3D \@tmparray;
=09}
=09$arrayref =3D $subini_models{ $subini };

=09if( $model =3D~ m/VEN_(....)&DEV_(....)&SUBSYS_(....)(....)$/ ) {
=09=09my %id =3D ();
=09=09$id{ 'vendor' } =3D lc( $1 );
=09=09$id{ 'device' } =3D lc( $2 );
=09=09$id{ 'subvendor' } =3D lc( $3 );
=09=09$id{ 'subdevice' } =3D lc( $4 );
=09=09push( @$arrayref, \%id );
=09}
}

# Generate enum from INI values of models
foreach my $ini (sort keys %subini_models) {
=09my $enum;
=09if( $ini =3D~ /^92XX(..)-(.)\.INI/i ) {=20
=09=09$enum =3D "STAC_92XX_DELL_${1}${2}";
=09}
=09elsif( $ini =3D~ /^NOM_(..)-(.)\.INI/i ) {
=09=09$enum =3D "STAC_92XX_DELL_NOM_${1}${2}";
=09}
=09else { next; }
=09$subini_enum{ $ini } =3D $enum;
=09$enum_subini{ $enum } =3D $ini;
}

my %nid_configs;

# Open sub INIs to get pins
foreach my $ini (sort keys %subini_models) {
=09my $subcfg =3D Config::IniFiles->new( -file =3D> $ini, -allowsingles =3D>=
 1 );
=09if( ! defined $subcfg ) {
=09=09print( "Error reading '$ini'\n" . join( "\n  ", @Config::IniFiles::err=
ors ) . "\n" );
=09=09next;
=09}
=09my @sections =3D $subcfg->Sections();
=09my %pins;

=09# Extract pins
=09foreach my $section (@sections) {
=09=09if( $section =3D~ /^HKR\\Settings\\pin\\(.*)$/i ) {
=09=09=09my $pin =3D lc( "0x$1" );
=09=09=09my $confval =3D $subcfg->val( $section, 'CfgDflt' );
=09=09=09$confval =3D~ s/^ *//;
=09=09=09$confval =3D~ s/ *$//;
=09=09=09if( $confval =3D~ /^dword: (0x.{8})$/ ) {
=09=09=09=09$pins{ $pin } =3D lc( $1 );
=09=09=09}
=09=09=09else { print( "Error: '$confval'\n" ); }
=09=09}
=09}

=09if( 0 =3D=3D scalar keys %pins ) {
=09=09print( "Couln't extract pin config from '$ini'\n" );
=09=09next;
=09}

=09# Generate nid tables - catches dups
=09my $nids_hash =3D join( '', sort keys %pins );
=09my $model_config;
=09if( ! exists $nid_configs{ $nids_hash } ) {
=09=09my %new_config =3D ();
=09=09$nid_configs{ $nids_hash } =3D \%new_config;
=09=09my $nid_name =3D lc( $subini_enum{ $ini } );
=09=09if( exists $nid_function_map{ $nids_hash } ) {
=09=09=09$nid_name =3D "stac" . $nid_function_map{ $nids_hash };
=09=09=09$new_config{ 'DEFAULT' } =3D $nids_hash;
=09=09}
=09=09else { $new_config{ 'DEFAULT' } =3D $nid_name; }
=09=09print( "// perl nid hash: $nids_hash\n" );
=09=09print( "// matches to: $nid_name\n" );
=09=09print( "static hda_nid_t " . $nid_name=20
=09=09=09. '_pin_nids[' . scalar keys( %pins ) . '] =3D {' );
=09=09my $i =3D 0;
=09=09for my $pin (sort keys %pins) {
=09=09=09print( "\n\t" ) if( 0 =3D=3D $i % 5 );
=09=09=09print( "$pin,       " );
=09=09=09$i++;
=09=09}
=09=09print( "\n};\n\n" );
=09}

=09$model_config =3D $nid_configs{ $nids_hash };
=09my @config =3D map( $pins{ $_ }, sort keys %pins );

=09# If nid "hash" matches alsa table rename enums
=09if( exists $nid_function_map{ $nids_hash } ) {
=09=09my $enum =3D $subini_enum{ $ini };
=09=09my $name =3D uc( $nid_function_map{ $nids_hash } );
=09=09$enum =3D~ s/^STAC_92XX/STAC_$name/;
=09=09$subini_enum{ $ini } =3D $enum;
=09=09$enum_subini{ $enum } =3D $ini;
=09}
=09$model_config->{ $subini_enum{ $ini } } =3D \@config;=20
}

# Write pin configs for all models
foreach my $nid (sort keys %nid_configs) {
=09foreach my $model (sort keys %{$nid_configs{$nid}}) {
=09=09next if( 'DEFAULT' eq $model );
=09=09my $configs =3D $nid_configs{$nid}->{$model};
=09=09print( "static unsigned int " . lc( $model )
=09=09=09. '_pin_configs[' . scalar @$configs . '] =3D {' );
=09=09my $i =3D 0;
=09=09for my $config (@$configs) {
=09=09=09print( "\n\t" ) if( 0 =3D=3D $i % 5 );
=09=09=09print( "$config, " );
=09=09=09$i++;
=09=09}
=09=09print( "\n};\n\n" );
=09}
}

# Write list of enums
foreach my $nid (sort keys %nid_configs) {
=09my $nids =3D $nid_configs{$nid}->{'DEFAULT'};
=09$nids =3D 'STAC_' . $nid_function_map{ $nids } . '_DELL'
=09=09if( exists $nid_function_map{ $nids } );
=09$nids =3D uc( $nids );
=09print( "enum {\n" );
=09foreach my $model (sort keys %{$nid_configs{$nid}}) {
=09=09next if( 'DEFAULT' eq $model );
=09=09print( "\t$model,\n" );
=09}
=09print( "\t${nids}_MODELS\n" );
=09print( "};\n\n" );
}

# Write table of models per nid=20
foreach my $nid (sort keys %nid_configs) {
=09my $nids =3D $nid_configs{$nid}->{'DEFAULT'};
=09$nids =3D 'STAC_' . $nid_function_map{ $nids } . '_DELL'
=09=09if( exists $nid_function_map{ $nids } );
=09$nids =3D uc( $nids );
=09print( 'static unsigned int *' . lc( $nids )
=09=09. "_brd_tbl[${nids}_MODELS] =3D {\n" );
=09foreach my $model (sort keys %{$nid_configs{$nid}}) {
=09=09next if( 'DEFAULT' eq $model );
=09=09print( "\t[${model}] =3D " . lc($model) . "_pin_config,\n" );
=09}
=09print( "};\n\n" );
}

# Write quirk tables
foreach my $nid (sort keys %nid_configs) {
=09my $nids =3D $nid_configs{$nid}->{'DEFAULT'};
=09$nids =3D 'STAC_' . $nid_function_map{ $nids } . '_DELL'
=09=09if( exists $nid_function_map{ $nids } );
=09print( 'static struct snd_pci_quirk ' . lc( $nids )
=09=09. "_cfg_tbl[] =3D {\n" );
=09foreach my $model (sort keys %{$nid_configs{$nid}}) {
=09=09next if( 'DEFAULT' eq $model );
=09=09my $ini =3D $enum_subini{ $model };
=09=09my $modelids =3D $subini_models{ $ini };
=09=09for my $modelid (@$modelids) {
=09=09=09print( "\tSND_PCI_QUIRK[PCI_VENDOR_ID_DELL, 0x"=20
=09=09=09=09. $modelid->{subdevice} . ",\n"=20
=09=09=09=09. "\t\t\t\"Unknown Dell\", ${model}),\n" );
=09=09}
=09}
=09print( "};\n\n" );
}

print <<"EOF";
#endif

EOF


--=_5zwye1frjnnk
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=_5zwye1frjnnk--
