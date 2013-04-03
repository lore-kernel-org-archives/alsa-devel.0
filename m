From: Rainer Koenig <Rainer.Koenig@ts.fujitsu.com>
Subject: [PATCH] Enable Realtek ALC671 Codec
Date: Wed, 03 Apr 2013 13:29:29 +0200
Message-ID: <515C1299.4000905@ts.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dgate20.ts.fujitsu.com (dgate20.ts.fujitsu.com [80.70.172.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 87E1E265311
 for <alsa-devel@alsa-project.org>; Wed,  3 Apr 2013 13:28:37 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

working on a new mainboard generation with ALC671 codecs the first tests =

showed that the generic codec parser is just configuring the rear mic in =

for audio input, line-in and front-mic are missing.

I tried to understand the code of patch_realtek.c and after compiling =

with CONFIG_SND_DEBUG I saw that this module is not used at all for the =

ALC671 codec because its device-ID was missing.

So what I did is:
- adding the device id and assigned the ALC662 patches for it.
- Added the device id so that it enables 4 ports in
   alc662_parse_auto_config
- changed the conditional in alc_subsystem_id because it looked so
   strange to me when I tried to understand what is happening. :-)

Here is the patch:

Signed-off-by: Rainer Koenig <Rainer.Koenig@ts.fujitsu.com>

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -1283,7 +1283,7 @@ static int alc_subsystem_id(struct hda_codec *codec,
         }

         ass =3D codec->subsystem_id & 0xffff;
-       if ((ass !=3D codec->bus->pci->subsystem_device) && (ass & 1))
+       if ((ass =3D=3D codec->bus->pci->subsystem_device) && (ass & 1))
                 goto do_sku;

         /* invalid SSID, check the special NID pin defcfg instead */
@@ -6663,7 +6663,8 @@ static int alc662_parse_auto_config(struct =

hda_codec *codec)
         const hda_nid_t *ssids;

         if (codec->vendor_id =3D=3D 0x10ec0272 || codec->vendor_id =3D=3D =

0x10ec0663 ||
-           codec->vendor_id =3D=3D 0x10ec0665 || codec->vendor_id =3D=3D =

0x10ec0670)
+           codec->vendor_id =3D=3D 0x10ec0665 || codec->vendor_id =3D=3D =

0x10ec0670 ||
+           codec->vendor_id =3D=3D 0x10ec0671)
                 ssids =3D alc663_ssids;
         else
                 ssids =3D alc662_ssids;
@@ -7115,6 +7116,7 @@ static const struct hda_codec_preset =

snd_hda_preset_realtek[] =3D {
         { .id =3D 0x10ec0665, .name =3D "ALC665", .patch =3D patch_alc662 =
},
         { .id =3D 0x10ec0668, .name =3D "ALC668", .patch =3D patch_alc662 =
},
         { .id =3D 0x10ec0670, .name =3D "ALC670", .patch =3D patch_alc662 =
},
+       { .id =3D 0x10ec0671, .name =3D "ALC671", .patch =3D patch_alc662 },
         { .id =3D 0x10ec0680, .name =3D "ALC680", .patch =3D patch_alc680 =
},
         { .id =3D 0x10ec0880, .name =3D "ALC880", .patch =3D patch_alc880 =
},
         { .id =3D 0x10ec0882, .name =3D "ALC882", .patch =3D patch_alc882 =
},


-- =

Dipl.-Inf. (FH) Rainer Koenig
Project Manager Linux Clients
Dept. PDG WPS R&D SW OSE

Fujitsu Technology Solutions
B=FCrgermeister-Ullrich-Str. 100
86199 Augsburg
Germany

Telephone: +49-821-804-3321
Telefax:   +49-821-804-2131
Mail:      mailto:Rainer.Koenig@ts.fujitsu.com

Internet         ts.fujtsu.com
Company Details  ts.fujitsu.com/imprint.html
