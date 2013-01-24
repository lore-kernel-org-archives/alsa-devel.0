From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: [PATCH next-20130124] Sound: pci: Fix unused variable warning in
 patch_sigmatel.c
Date: Fri, 25 Jan 2013 00:38:06 +0200
Message-ID: <5101B7CE.4070102@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-next-owner@vger.kernel.org>
Sender: linux-next-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, David Henningsson <david.henningsson@canonical.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

=46ix the following build warnings

sound/pci/hda/patch_sigmatel.c: In function =91stac92hd71bxx_fixup_hp=92=
:
sound/pci/hda/patch_sigmatel.c:2434:24: warning: unused variable =91spe=
c=92 [-Wunused-variable]

Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
---
 sound/pci/hda/patch_sigmatel.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigma=
tel.c
index 0aa0ceb..f269d1f 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -2365,7 +2365,6 @@ static void stac92hd71bxx_fixup_ref(struct hda_co=
dec *codec,
 static void stac92hd71bxx_fixup_hp_m4(struct hda_codec *codec,
 				      const struct hda_fixup *fix, int action)
 {
-	struct sigmatel_spec *spec =3D codec->spec;
 	struct hda_jack_tbl *jack;
=20
 	if (action !=3D HDA_FIXUP_ACT_PRE_PROBE)
@@ -2381,7 +2380,7 @@ static void stac92hd71bxx_fixup_hp_m4(struct hda_=
codec *codec,
 	if (jack)
 		jack->private_data =3D 0x02;
=20
-	spec->gpio_mask |=3D 0x02;
+	((struct sigmatel_spec *)codec->spec)->gpio_mask |=3D 0x02;
=20
 	/* enable internal microphone */
 	snd_hda_codec_set_pincfg(codec, 0x0e, 0x01813040);
@@ -2420,19 +2419,15 @@ static void stac92hd71bxx_fixup_hp_dv5(struct h=
da_codec *codec,
 static void stac92hd71bxx_fixup_hp_hdx(struct hda_codec *codec,
 				       const struct hda_fixup *fix, int action)
 {
-	struct sigmatel_spec *spec =3D codec->spec;
-
 	if (action !=3D HDA_FIXUP_ACT_PRE_PROBE)
 		return;
-	spec->gpio_led =3D 0x08;
+	((struct sigmatel_spec *)codec->spec)->gpio_led =3D 0x08;
 }
=20
=20
 static void stac92hd71bxx_fixup_hp(struct hda_codec *codec,
 				   const struct hda_fixup *fix, int action)
 {
-	struct sigmatel_spec *spec =3D codec->spec;
-
 	if (action !=3D HDA_FIXUP_ACT_PRE_PROBE)
 		return;
=20
@@ -2456,8 +2451,9 @@ static void stac92hd71bxx_fixup_hp(struct hda_cod=
ec *codec,
=20
 	if (find_mute_led_cfg(codec, 1))
 		snd_printd("mute LED gpio %d polarity %d\n",
-				spec->gpio_led,
-				spec->gpio_led_polarity);
+			((struct sigmatel_spec *)codec->spec)->gpio_led,
+			((struct sigmatel_spec *)codec->spec)->
+							gpio_led_polarity);
=20
 }
=20
--=20
1.8.1
