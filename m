From: =?ISO-8859-1?Q?Emilio_L=F3pez?= <buhitoescolar@gmail.com>
Subject: Re: Regarding Sound on Acer Aspire 6935G
Date: Wed, 24 Jun 2009 16:33:26 -0300
Message-ID: <d54969c50906241233kc51e746r691bd48c2e961a71@mail.gmail.com>
References: <4b8c423b0905152051w7443e1b4u4080514a560fbb6c@mail.gmail.com>
	<d54969c50906221614k5e12f5edt8973f7bb8e69592c@mail.gmail.com>
	<1245712854.441.11.camel@localhost>
	<d54969c50906221623j4fd17c6yb7fc2c9316d11766@mail.gmail.com>
	<d54969c50906231105k251880eahbf82cf74b699c7d8@mail.gmail.com>
	<1245796809.3640.10.camel@localhost>
	<d54969c50906231800p2f507c48h9e6977cc7d03461f@mail.gmail.com>
	<d54969c50906231832w48ce7315uc5cf8b3f81534c76@mail.gmail.com>
	<s5hbpoem7c3.wl%tiwai@suse.de>
	<d54969c50906241124o456a4938p173b9fbbd9cd46b3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f171.google.com (mail-qy0-f171.google.com
	[209.85.221.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 2C4DF24821
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Jun 2009 21:33:28 +0200 (CEST)
Received: by qyk1 with SMTP id 1so1292283qyk.16
	for <alsa-devel@alsa-project.org>; Wed, 24 Jun 2009 12:33:27 -0700 (PDT)
In-Reply-To: <d54969c50906241124o456a4938p173b9fbbd9cd46b3@mail.gmail.com>
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
Cc: Karthik Ramgopal <applefreakpeeps@gmail.com>, Tony Vroon <tony@linx.net>, ALSA development ML <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Well, I finally got it to work. I had to triplicate the
"spec->autocfg.hp_pins", I don't know why, but it made it work.

Here is the patch:

From: Emilio L=F3pez <buhitoescolar@gmail.com>

Fix recording from internal microphone, make jack sensing mute all the
internal speakers.

Signed-off-by: Emilio L=F3pez <buhitoescolar@gmail.com>
Tested-by: Emilio L=F3pez <buhitoescolar@gmail.com>

---

diff -uprN alsa-driver/sound/pci/hda/patch_realtek.c
alsa-driver-patched/sound/pci/hda/patch_realtek.c
--- alsa-driver/sound/pci/hda/patch_realtek.c	2009-06-22
12:50:12.000000000 -0300
+++ alsa-driver-patched/sound/pci/hda/patch_realtek.c	2009-06-24
16:22:51.258368878 -0300
@@ -1471,6 +1471,10 @@ static struct hda_verb alc888_acer_aspir
 static struct hda_verb alc888_acer_aspire_6530g_verbs[] =3D {
 /* Bias voltage on for external mic port */
 	{0x18, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN | PIN_VREF80},
+/* Front Mic: set to PIN_IN (empty by default) */
+	{0x12, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN},
+/* Unselect Front Mic by default in input mixer 3 */
+	{0x22, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0xb)},
 /* Enable unsolicited event for HP jack */
 	{0x15, AC_VERB_SET_UNSOLICITED_ENABLE, ALC880_HP_EVENT | AC_USRSP_EN},
 /* Enable speaker output */
@@ -1639,6 +1643,19 @@ static void alc888_acer_aspire_4930g_ini
 	alc_automute_amp(codec);
 }

+static void alc888_acer_aspire_6530g_init_hook(struct hda_codec *codec)
+{
+	struct alc_spec *spec =3D codec->spec;
+
+	spec->autocfg.hp_pins[0] =3D 0x15;
+	spec->autocfg.hp_pins[1] =3D 0x15;
+	spec->autocfg.hp_pins[2] =3D 0x15;
+	spec->autocfg.speaker_pins[0] =3D 0x14;
+	spec->autocfg.speaker_pins[1] =3D 0x16;
+	spec->autocfg.speaker_pins[2] =3D 0x17;
+	alc_automute_amp(codec);
+}
+
 static void alc889_acer_aspire_8930g_init_hook(struct hda_codec *codec)
 {
 	struct alc_spec *spec =3D codec->spec;
@@ -9317,7 +9334,7 @@ static struct alc_config_preset alc883_p
 			ARRAY_SIZE(alc888_2_capture_sources),
 		.input_mux =3D alc888_acer_aspire_6530_sources,
 		.unsol_event =3D alc_automute_amp_unsol_event,
-		.init_hook =3D alc888_acer_aspire_4930g_init_hook,
+		.init_hook =3D alc888_acer_aspire_6530g_init_hook,
 	},
 	[ALC888_ACER_ASPIRE_8930G] =3D {
 		.mixers =3D { alc888_base_mixer,
