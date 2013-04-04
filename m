From: Rainer Koenig <Rainer.Koenig@ts.fujitsu.com>
Subject: [PATCH] Enabling Realtek ALC 671 codec
Date: Thu, 04 Apr 2013 08:40:38 +0200
Message-ID: <515D2066.50500@ts.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dgate10.ts.fujitsu.com (dgate10.ts.fujitsu.com [80.70.172.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 850D4260799
 for <alsa-devel@alsa-project.org>; Thu,  4 Apr 2013 08:39:44 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Changes:

* Added the device ID to the modalias list and assinged ALC662 patches =

for it
* Added 4 port support for the device ID 0671 in alc662_parse_auto_config

Signed-off-by: Rainer Koenig <Rainer.Koenig@ts.fujitsu.com>

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 7743775..fcbf4c9 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6663,7 +6663,8 @@ static int alc662_parse_auto_config(struct =

hda_codec *codec)
  	const hda_nid_t *ssids;

  	if (codec->vendor_id =3D=3D 0x10ec0272 || codec->vendor_id =3D=3D 0x10ec=
0663 ||
-	    codec->vendor_id =3D=3D 0x10ec0665 || codec->vendor_id =3D=3D 0x10ec0=
670)
+	    codec->vendor_id =3D=3D 0x10ec0665 || codec->vendor_id =3D=3D 0x10ec0=
670 ||
+	    codec->vendor_id =3D=3D 0x10ec0671)
  		ssids =3D alc663_ssids;
  	else
  		ssids =3D alc662_ssids;
@@ -7115,6 +7116,7 @@ static const struct hda_codec_preset =

snd_hda_preset_realtek[] =3D {
  	{ .id =3D 0x10ec0665, .name =3D "ALC665", .patch =3D patch_alc662 },
  	{ .id =3D 0x10ec0668, .name =3D "ALC668", .patch =3D patch_alc662 },
  	{ .id =3D 0x10ec0670, .name =3D "ALC670", .patch =3D patch_alc662 },
+	{ .id =3D 0x10ec0671, .name =3D "ALC671", .patch =3D patch_alc662 },
  	{ .id =3D 0x10ec0680, .name =3D "ALC680", .patch =3D patch_alc680 },
  	{ .id =3D 0x10ec0880, .name =3D "ALC880", .patch =3D patch_alc880 },
  	{ .id =3D 0x10ec0882, .name =3D "ALC882", .patch =3D patch_alc882 },

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
