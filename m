From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] Four patches to fixup surround internal
 speakers on Realtek 88x
Date: Mon, 07 Mar 2011 09:22:42 +0100
Message-ID: <4D7495D2.80605@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070904000204070302040307"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 79759103807
	for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2011 09:22:47 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
Cc: nusch88@gmail.com
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------070904000204070302040307
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

I spend last Friday together with Bart=C5=82omiej =C5=BBoga=C5=82a fixing=
 up a long=20
standing issue with Lenovo Y530, which has 4+1 internal speakers on a=20
Realtek 888. And we all want that supported by the auto parser, don't=20
we? So here comes the patches. Would be nice to have in 2.6.38.


--=20
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------070904000204070302040307
Content-Type: text/x-patch;
 name="0001-ALSA-HDA-Enable-surround-and-subwoofer-on-Lenovo-Ide.patch"
Content-Disposition: attachment;
 filename*0="0001-ALSA-HDA-Enable-surround-and-subwoofer-on-Lenovo-Ide.pa";
 filename*1="tch"
Content-Transfer-Encoding: quoted-printable

>From 869a246337ece559ea0792ae853ee75daf328f40 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Fri, 4 Mar 2011 13:37:50 +0100
Subject: [PATCH 1/4] ALSA: HDA: Enable surround and subwoofer on Lenovo I=
deapad Y530
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

The pin config values would change the association instead of the
sequence, this commit fixes that up.

Tested-by: Bart=C5=82omiej =C5=BBoga=C5=82a <nusch88@gmail.com>
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.=
c
index f721a18..ed4873c 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10747,6 +10747,7 @@ static struct alc_config_preset alc882_presets[] =
=3D {
  */
 enum {
 	PINFIX_ABIT_AW9D_MAX,
+	PINFIX_LENOVO_Y530,
 	PINFIX_PB_M5210,
 	PINFIX_ACER_ASPIRE_7736,
 };
@@ -10761,6 +10762,14 @@ static const struct alc_fixup alc882_fixups[] =3D=
 {
 			{ }
 		}
 	},
+	[PINFIX_LENOVO_Y530] =3D {
+		.type =3D ALC_FIXUP_PINS,
+		.v.pins =3D (const struct alc_pincfg[]) {
+			{ 0x15, 0x99130112 }, /* rear int speakers */
+			{ 0x16, 0x99130111 }, /* subwoofer */
+			{ }
+		}
+	},
 	[PINFIX_PB_M5210] =3D {
 		.type =3D ALC_FIXUP_VERBS,
 		.v.verbs =3D (const struct hda_verb[]) {
@@ -10776,6 +10785,7 @@ static const struct alc_fixup alc882_fixups[] =3D=
 {
=20
 static struct snd_pci_quirk alc882_fixup_tbl[] =3D {
 	SND_PCI_QUIRK(0x1025, 0x0155, "Packard-Bell M5120", PINFIX_PB_M5210),
+	SND_PCI_QUIRK(0x17aa, 0x3a0d, "Lenovo Y530", PINFIX_LENOVO_Y530),
 	SND_PCI_QUIRK(0x147b, 0x107a, "Abit AW9D-MAX", PINFIX_ABIT_AW9D_MAX),
 	SND_PCI_QUIRK(0x1025, 0x0296, "Acer Aspire 7736z", PINFIX_ACER_ASPIRE_7=
736),
 	{}
--=20
1.7.1


--------------070904000204070302040307
Content-Type: text/x-patch;
 name="0002-ALSA-HDA-Fix-volume-control-naming-for-surround-spea.patch"
Content-Disposition: attachment;
 filename*0="0002-ALSA-HDA-Fix-volume-control-naming-for-surround-spea.pa";
 filename*1="tch"
Content-Transfer-Encoding: quoted-printable

>From 36a9f29b1de6a101dfd2d083b619cc55fbcf38ae Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Fri, 4 Mar 2011 14:08:30 +0100
Subject: [PATCH 2/4] ALSA: HDA: Fix volume control naming for surround sp=
eakers on Realtek auto-parser

When more than one pair of internal speakers is present, allow names
according to their channels.

Tested-by: Bart=C5=82omiej =C5=BBoga=C5=82a <nusch88@gmail.com>
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.=
c
index ed4873c..fe45c61 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5150,7 +5150,9 @@ static const char *alc_get_line_out_pfx(const struc=
t auto_pin_cfg *cfg,
=20
 	switch (cfg->line_out_type) {
 	case AUTO_PIN_SPEAKER_OUT:
-		return "Speaker";
+		if (cfg->line_outs =3D=3D 1)
+			return "Speaker";
+		break;
 	case AUTO_PIN_HP_OUT:
 		return "Headphone";
 	default:
--=20
1.7.1


--------------070904000204070302040307
Content-Type: text/x-patch;
 name="0003-ALSA-HDA-Fixup-unnecessary-volume-control-index-on-R.patch"
Content-Disposition: attachment;
 filename*0="0003-ALSA-HDA-Fixup-unnecessary-volume-control-index-on-R.pa";
 filename*1="tch"
Content-Transfer-Encoding: quoted-printable

>From 59ffe41f2ea198787be49996e36c43f32cc794a7 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Fri, 4 Mar 2011 14:22:25 +0100
Subject: [PATCH 3/4] ALSA: HDA: Fixup unnecessary volume control index on=
 Realtek ALC88x

Without this change, a volume control named "Surround" or "Side" would
get an unnecessary index, causing it to be ignored by the vmaster and
PulseAudio.

Tested-by: Bart=C5=82omiej =C5=BBoga=C5=82a <nusch88@gmail.com>
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.=
c
index fe45c61..f94b12f 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5206,16 +5206,19 @@ static int alc880_auto_create_multi_out_ctls(stru=
ct alc_spec *spec,
 				return err;
 		} else {
 			const char *name =3D pfx;
-			if (!name)
+			int index =3D i;
+			if (!name) {
 				name =3D chname[i];
+				index =3D 0;
+			}
 			err =3D __add_pb_vol_ctrl(spec, ALC_CTL_WIDGET_VOL,
-						name, i,
+						name, index,
 					  HDA_COMPOSE_AMP_VAL(nid, 3, 0,
 							      HDA_OUTPUT));
 			if (err < 0)
 				return err;
 			err =3D __add_pb_sw_ctrl(spec, ALC_CTL_BIND_MUTE,
-					       name, i,
+					       name, index,
 					  HDA_COMPOSE_AMP_VAL(nid, 3, 2,
 							      HDA_INPUT));
 			if (err < 0)
--=20
1.7.1


--------------070904000204070302040307
Content-Type: text/x-patch;
 name="0004-ALSA-HDA-Realtek-ALC88x-Do-not-over-initialize-speak.patch"
Content-Disposition: attachment;
 filename*0="0004-ALSA-HDA-Realtek-ALC88x-Do-not-over-initialize-speak.pa";
 filename*1="tch"
Content-Transfer-Encoding: quoted-printable

>From 247b0dbb5c5df7cdb8d9d5b08f48577c33c0afee Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Fri, 4 Mar 2011 16:54:52 +0100
Subject: [PATCH 4/4] ALSA: HDA: Realtek ALC88x: Do not over-initialize sp=
eakers and hp that are primary outputs

Do not initialize again the what has already been initialized as
multi outs, as this breaks surround speakers.

Tested-by: Bart=C5=82omiej =C5=BBoga=C5=82a <nusch88@gmail.com>
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c |   37 +++++++++++++++++++++--------------=
--
 1 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.=
c
index f94b12f..3dc88ba 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10843,23 +10843,28 @@ static void alc882_auto_init_hp_out(struct hda_=
codec *codec)
 	hda_nid_t pin, dac;
 	int i;
=20
-	for (i =3D 0; i < ARRAY_SIZE(spec->autocfg.hp_pins); i++) {
-		pin =3D spec->autocfg.hp_pins[i];
-		if (!pin)
-			break;
-		dac =3D spec->multiout.hp_nid;
-		if (!dac)
-			dac =3D spec->multiout.dac_nids[0]; /* to front */
-		alc882_auto_set_output_and_unmute(codec, pin, PIN_HP, dac);
+	if (spec->autocfg.line_out_type !=3D AUTO_PIN_HP_OUT) {
+		for (i =3D 0; i < ARRAY_SIZE(spec->autocfg.hp_pins); i++) {
+			pin =3D spec->autocfg.hp_pins[i];
+			if (!pin)
+				break;
+			dac =3D spec->multiout.hp_nid;
+			if (!dac)
+				dac =3D spec->multiout.dac_nids[0]; /* to front */
+			alc882_auto_set_output_and_unmute(codec, pin, PIN_HP, dac);
+		}
 	}
-	for (i =3D 0; i < ARRAY_SIZE(spec->autocfg.speaker_pins); i++) {
-		pin =3D spec->autocfg.speaker_pins[i];
-		if (!pin)
-			break;
-		dac =3D spec->multiout.extra_out_nid[0];
-		if (!dac)
-			dac =3D spec->multiout.dac_nids[0]; /* to front */
-		alc882_auto_set_output_and_unmute(codec, pin, PIN_OUT, dac);
+
+	if (spec->autocfg.line_out_type !=3D AUTO_PIN_SPEAKER_OUT) {
+		for (i =3D 0; i < ARRAY_SIZE(spec->autocfg.speaker_pins); i++) {
+			pin =3D spec->autocfg.speaker_pins[i];
+			if (!pin)
+				break;
+			dac =3D spec->multiout.extra_out_nid[0];
+			if (!dac)
+				dac =3D spec->multiout.dac_nids[0]; /* to front */
+			alc882_auto_set_output_and_unmute(codec, pin, PIN_OUT, dac);
+		}
 	}
 }
=20
--=20
1.7.1


--------------070904000204070302040307
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------070904000204070302040307--
