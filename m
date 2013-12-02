From: Kailang <kailang@realtek.com>
Subject: Independent of model for HP
Date: Mon, 2 Dec 2013 17:21:43 +0800
Message-ID: <74730F8D6F404E9E8DC22BB9462E306E@realtek.com.tw>
Reply-To: Kailang <kailang@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="----=_NextPart_000_0019_01CEEF82.F8663D80"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 7CE332619F9
 for <alsa-devel@alsa-project.org>; Mon,  2 Dec 2013 10:21:59 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

------=_NextPart_000_0019_01CEEF82.F8663D80
Content-Type: text/plain; format=flowed; charset="big5"; reply-type=original
Content-Transfer-Encoding: 7bit

Hi Takashi,

HP Chrome Book, the headset jack was difference between other chrome book.
It need to manual control Mic jack detect.

Thanks.
Kailang
------=_NextPart_000_0019_01CEEF82.F8663D80
Content-Type: application/octet-stream;
	name="0000-independent-of-model-hp.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0000-independent-of-model-hp.patch"

>From 2179dd75bdde86ad3ef6c09a434dd46bd157684d Mon Sep 17 00:00:00 2001=0A=
From: Kailang Yang <kailang@realtek.com>=0A=
Date: Mon, 2 Dec 2013 15:20:15 +0800=0A=
Subject: [PATCH] ALSA: hda/realtek - Independent of model for HP=0A=
=0A=
Create single model for HP.=0A=
=0A=
Signed-off-by: Kailang Yang <kailang@realtek.com>=0A=
=0A=
diff --git a/sound/pci/hda/patch_realtek.c =
b/sound/pci/hda/patch_realtek.c=0A=
index 537991c..1805ee9 100644=0A=
--- a/sound/pci/hda/patch_realtek.c=0A=
+++ b/sound/pci/hda/patch_realtek.c=0A=
@@ -3651,11 +3651,6 @@ static void alc283_hp_automute_hook(struct =
hda_codec *codec,=0A=
 			    vref);=0A=
 }=0A=
 =0A=
-static void alc283_chromebook_caps(struct hda_codec *codec)=0A=
-{=0A=
-	snd_hda_override_wcaps(codec, 0x03, 0);=0A=
-}=0A=
-=0A=
 static void alc283_fixup_chromebook(struct hda_codec *codec,=0A=
 				    const struct hda_fixup *fix, int action)=0A=
 {=0A=
@@ -3664,19 +3659,34 @@ static void alc283_fixup_chromebook(struct =
hda_codec *codec,=0A=
 =0A=
 	switch (action) {=0A=
 	case HDA_FIXUP_ACT_PRE_PROBE:=0A=
-		alc283_chromebook_caps(codec);=0A=
+		snd_hda_override_wcaps(codec, 0x03, 0);=0A=
 		/* Disable AA-loopback as it causes white noise */=0A=
 		spec->gen.mixer_nid =3D 0;=0A=
 		spec->gen.hp_automute_hook =3D alc283_hp_automute_hook;=0A=
 		break;=0A=
 	case HDA_FIXUP_ACT_INIT:=0A=
+		/* Enable Line1 input control by verb */=0A=
+		val =3D alc_read_coef_idx(codec, 0x1a);=0A=
+		alc_write_coef_idx(codec, 0x1a, val | (1 << 4));=0A=
+		break;=0A=
+	}=0A=
+}=0A=
+=0A=
+static void alc283_fixup_sense_combo_jack(struct hda_codec *codec,=0A=
+				    const struct hda_fixup *fix, int action)=0A=
+{=0A=
+	struct alc_spec *spec =3D codec->spec;=0A=
+	int val;=0A=
+=0A=
+	switch (action) {=0A=
+	case HDA_FIXUP_ACT_PRE_PROBE:=0A=
+		spec->gen.hp_automute_hook =3D alc283_hp_automute_hook;=0A=
+		break;=0A=
+	case HDA_FIXUP_ACT_INIT:=0A=
 		/* MIC2-VREF control */=0A=
 		/* Set to manual mode */=0A=
 		val =3D alc_read_coef_idx(codec, 0x06);=0A=
 		alc_write_coef_idx(codec, 0x06, val & ~0x000c);=0A=
-		/* Enable Line1 input control by verb */=0A=
-		val =3D alc_read_coef_idx(codec, 0x1a);=0A=
-		alc_write_coef_idx(codec, 0x1a, val | (1 << 4));=0A=
 		break;=0A=
 	}=0A=
 }=0A=
@@ -3872,6 +3882,7 @@ enum {=0A=
 	ALC269_FIXUP_LIMIT_INT_MIC_BOOST_MUTE_LED,=0A=
 	ALC269VB_FIXUP_ORDISSIMO_EVE2,=0A=
 	ALC283_FIXUP_CHROME_BOOK,=0A=
+	ALC283_FIXUP_SENSE_COMBO_JACK,=0A=
 	ALC282_FIXUP_ASUS_TX300,=0A=
 	ALC283_FIXUP_INT_MIC,=0A=
 	ALC290_FIXUP_MONO_SPEAKERS,=0A=
@@ -4171,6 +4182,12 @@ static const struct hda_fixup alc269_fixups[] =3D =
{=0A=
 		.type =3D HDA_FIXUP_FUNC,=0A=
 		.v.func =3D alc283_fixup_chromebook,=0A=
 	},=0A=
+	[ALC283_FIXUP_SENSE_COMBO_JACK] =3D {=0A=
+		.type =3D HDA_FIXUP_FUNC,=0A=
+		.v.func =3D alc283_fixup_sense_combo_jack,=0A=
+		.chained =3D true,=0A=
+		.chain_id =3D ALC283_FIXUP_CHROME_BOOK,=0A=
+	},=0A=
 	[ALC282_FIXUP_ASUS_TX300] =3D {=0A=
 		.type =3D HDA_FIXUP_FUNC,=0A=
 		.v.func =3D alc282_fixup_asus_tx300,=0A=
@@ -4370,6 +4387,8 @@ static const struct hda_model_fixup =
alc269_fixup_models[] =3D {=0A=
 	{.id =3D ALC269_FIXUP_HP_GPIO_LED, .name =3D "hp-gpio-led"},=0A=
 	{.id =3D ALC269_FIXUP_DELL1_MIC_NO_PRESENCE, .name =3D =
"dell-headset-multi"},=0A=
 	{.id =3D ALC269_FIXUP_DELL2_MIC_NO_PRESENCE, .name =3D =
"dell-headset-dock"},=0A=
+	{.id =3D ALC283_FIXUP_CHROME_BOOK, .name =3D "alc283-chrome"},=0A=
+	{.id =3D ALC283_FIXUP_SENSE_COMBO_JACK, .name =3D =
"alc283-sense-combo"},=0A=
 	{}=0A=
 };=0A=
 =0A=

------=_NextPart_000_0019_01CEEF82.F8663D80
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_NextPart_000_0019_01CEEF82.F8663D80--
