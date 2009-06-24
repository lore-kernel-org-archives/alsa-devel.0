From: =?ISO-8859-1?Q?Emilio_L=F3pez?= <buhitoescolar@gmail.com>
Subject: Re: Regarding Sound on Acer Aspire 6935G
Date: Tue, 23 Jun 2009 22:32:45 -0300
Message-ID: <d54969c50906231832w48ce7315uc5cf8b3f81534c76@mail.gmail.com>
References: <4b8c423b0905152051w7443e1b4u4080514a560fbb6c@mail.gmail.com>
	<s5hfxdrex0w.wl%tiwai@suse.de> <1245709097.441.7.camel@localhost>
	<1245710676.441.9.camel@localhost>
	<d54969c50906221614k5e12f5edt8973f7bb8e69592c@mail.gmail.com>
	<1245712854.441.11.camel@localhost>
	<d54969c50906221623j4fd17c6yb7fc2c9316d11766@mail.gmail.com>
	<d54969c50906231105k251880eahbf82cf74b699c7d8@mail.gmail.com>
	<1245796809.3640.10.camel@localhost>
	<d54969c50906231800p2f507c48h9e6977cc7d03461f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.147])
	by alsa0.perex.cz (Postfix) with ESMTP id C0F2824594
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Jun 2009 03:32:51 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 5so204330qwf.56
	for <alsa-devel@alsa-project.org>; Tue, 23 Jun 2009 18:32:50 -0700 (PDT)
In-Reply-To: <d54969c50906231800p2f507c48h9e6977cc7d03461f@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tony Vroon <tony@linx.net>
Cc: Takashi Iwai <tiwai@suse.de>, Karthik Ramgopal <applefreakpeeps@gmail.com>, ALSA development ML <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Here is the patch, with jack sensing not working fully. Maybe you can
spot my mistake faster than me

diff -wru alsa-driver/sound/pci/hda/patch_realtek.c
alsa-driver-patched/sound/pci/hda/patch_realtek.c
--- alsa-driver/sound/pci/hda/patch_realtek.c	2009-06-22
12:50:12.000000000 -0300
+++ alsa-driver-patched/sound/pci/hda/patch_realtek.c	2009-06-23
22:28:22.653374751 -0300
@@ -1471,6 +1471,10 @@
 static struct hda_verb alc888_acer_aspire_6530g_verbs[] = {
 /* Bias voltage on for external mic port */
 	{0x18, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN | PIN_VREF80},
+/* Front Mic: set to PIN_IN (empty by default) */
+	{0x12, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN},
+/* Unselect Front Mic by default in input mixer 3 */
+	{0x22, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0xb)},
 /* Enable unsolicited event for HP jack */
 	{0x15, AC_VERB_SET_UNSOLICITED_ENABLE, ALC880_HP_EVENT | AC_USRSP_EN},
 /* Enable speaker output */
@@ -1639,6 +1643,17 @@
 	alc_automute_amp(codec);
 }

+static void alc888_acer_aspire_6530g_init_hook(struct hda_codec *codec)
+{
+	struct alc_spec *spec = codec->spec;
+
+	spec->autocfg.hp_pins[0] = 0x15;
+	spec->autocfg.speaker_pins[0] = 0x14;
+	spec->autocfg.speaker_pins[1] = 0x16;
+	spec->autocfg.speaker_pins[2] = 0x17;
+	alc_automute_amp(codec);
+}
+
 static void alc889_acer_aspire_8930g_init_hook(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
@@ -9317,7 +9332,7 @@
 			ARRAY_SIZE(alc888_2_capture_sources),
 		.input_mux = alc888_acer_aspire_6530_sources,
 		.unsol_event = alc_automute_amp_unsol_event,
-		.init_hook = alc888_acer_aspire_4930g_init_hook,
+		.init_hook = alc888_acer_aspire_6530g_init_hook,
 	},
 	[ALC888_ACER_ASPIRE_8930G] = {
 		.mixers = { alc888_base_mixer,
