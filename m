From: Reimundo Heluani <rheluani@gmail.com>
Subject: Re: Macbook Air 2,1 - no mic nor main speakers
Date: Mon, 22 Feb 2010 09:58:44 -0800
Message-ID: <1266861524.5086.7.camel@vino>
References: <1265480879.2466.21.camel@vino> <1266820258.3074.16.camel@vino>
	<s5h7hq54sd8.wl%tiwai@suse.de> <1266825733.3074.19.camel@vino>
	<s5h4ol94rwn.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f220.google.com (mail-fx0-f220.google.com
	[209.85.220.220])
	by alsa0.perex.cz (Postfix) with ESMTP id DB375103850
	for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2010 18:58:47 +0100 (CET)
Received: by fxm20 with SMTP id 20so6646412fxm.32
	for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2010 09:58:47 -0800 (PST)
In-Reply-To: <s5h4ol94rwn.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 2010-02-22 at 09:05 +0100, Takashi Iwai wrote:
> At Mon, 22 Feb 2010 00:02:13 -0800,
> > 
> > The headphones are in 0x14 but I couldn't get them to shut the main
> > speakers off yet when the hp jack is connected. As soon as I understand
> > how the other examples in patch_realtek.c work and get this working I'll
> > send you a working patch.
> 
> Then check rather whether the pin 0x18 is really the right pin for the
> speaker output.  This can be checked easily via hda-verb or so.
> The speaker can be 0x15 and/or 0x1a, instead.

The patch below is the best I can do without loosing my day job :) with
this patch I get audio on main speaker letting it be 0x18. At the same
time if I put 0x14 to be the hp pin I get it to mute the main speaker
whenever I plug the jack, but I can't get audio from the hp. 

The funny thing is that in mbp3 mode I get audio from hp but not from
main speaker. Interestingly enough, if I start with mbp3 mode and run
hda-analyzer, the switching pin_out in 0x14 decides whether or not
there's output in the hp and switching pin_out in 0x18 decides wether or
not there's output in the main speaker. 

Cheers,

R.

--- patch_realtek.c.orig	2010-02-22 08:40:29.000000000 -0800
+++ patch_realtek.c	2010-02-22 09:49:13.000000000 -0800
@@ -205,6 +205,7 @@
 	ALC882_ASUS_A7J,
 	ALC882_ASUS_A7M,
 	ALC885_MACPRO,
+	ALC885_MBA21,
 	ALC885_MBP3,
 	ALC885_MB5,
 	ALC885_IMAC24,
@@ -6749,6 +6750,12 @@
 	{ 8, alc882_sixstack_ch8_init },
 };
 
+/* Macbook Air I have no clue how it works yet */
+
+static struct hda_channel_mode alc885_mba21_ch_modes[1] = {
+      { 2, NULL },
+};
+
 /*
  * macbook pro ALC885 can switch LineIn to LineOut without losing Mic
  */
@@ -7021,6 +7028,16 @@
 };
 
 
+
+static struct snd_kcontrol_new alc885_mba21_mixer[] = {
+      HDA_CODEC_VOLUME("Speaker Playback Volume", 0x0c, 0x00,
HDA_OUTPUT),
+      HDA_BIND_MUTE   ("Speaker Playback Switch", 0x0c, 0x02,
HDA_OUTPUT),
+      HDA_CODEC_VOLUME("Headphone Playback Volume", 0x0e, 0x00,
HDA_OUTPUT),
+      HDA_BIND_MUTE   ("Headphone Playback Switch", 0x0e, 0x02,
HDA_OUTPUT),
+      { }
+};
+
+
 static struct snd_kcontrol_new alc885_mbp3_mixer[] = {
 	HDA_CODEC_VOLUME("Speaker Playback Volume", 0x0c, 0x00, HDA_OUTPUT),
 	HDA_BIND_MUTE   ("Speaker Playback Switch", 0x0c, 0x02, HDA_INPUT),
@@ -7445,6 +7462,29 @@
 	{ }
 };
 
+static struct hda_verb alc885_mba21_init_verbs[] = {
+       /*Internal Speaker Mixer*/
+       	{0x0c, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO}, 
+       	{0x0c, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+       	{0x0c, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},
+       	/*Internal Speaker Pin*/
+       	{0x18, AC_VERB_SET_PIN_WIDGET_CONTROL, (PIN_OUT |
AC_PINCTL_VREF_50) },
+       	{0x18, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+       	{0x18, AC_VERB_SET_CONNECT_SEL, 0x00},
+ 	/* HP mixer */
+	{0x0e, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO},
+	{0x0e, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+	{0x0e, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
+	/* HP Pin: output 0 (0x0e) */
+	{0x14, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_HP},
+	{0x14, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	{0x14, AC_VERB_SET_CONNECT_SEL, 0x02},
+	{0x14, AC_VERB_SET_UNSOLICITED_ENABLE, ALC880_HP_EVENT | AC_USRSP_EN},
+       	
+	{ }
+ };
+ 
+
 /* Macbook Pro rev3 */
 static struct hda_verb alc885_mbp3_init_verbs[] = {
 	/* Front mixer: unmute input/output amp left and right (volume = 0) */
@@ -7547,6 +7587,17 @@
 	spec->autocfg.speaker_pins[1] = 0x1a;
 }
 
+/* Macbook Air don't know how this works */
+static void alc885_mba21_setup (struct hda_codec *codec)
+{
+       struct alc_spec *spec = codec->spec;
+ 
+       spec->autocfg.hp_pins[0] = 0x14;
+       spec->autocfg.speaker_pins[0] = 0x18;
+}
+ 
+ 
+
 static void alc885_mbp3_setup(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
@@ -8738,6 +8789,7 @@
 	[ALC882_ASUS_A7M]	= "asus-a7m",
 	[ALC885_MACPRO]		= "macpro",
 	[ALC885_MB5]		= "mb5",
+	[ALC885_MBA21]          = "mba21",
 	[ALC885_MBP3]		= "mbp3",
 	[ALC885_IMAC24]		= "imac24",
 	[ALC883_3ST_2ch_DIG]	= "3stack-2ch-dig",
@@ -8970,6 +9022,21 @@
 		.input_mux = &alc882_capture_source,
 		.dig_out_nid = ALC882_DIGOUT_NID,
 	},
+       [ALC885_MBA21] = {
+               .mixers = { alc885_mba21_mixer }, 
+               .init_verbs = { alc885_mba21_init_verbs,
alc880_gpio1_init_verbs },
+               .num_dacs = 2,
+               .dac_nids = alc882_dac_nids,
+               //.hp_nid = 0x04,
+               .channel_mode = alc885_mba21_ch_modes,
+               .num_channel_mode = ARRAY_SIZE(alc885_mba21_ch_modes),
+               .input_mux = &alc882_capture_source,
+               //.dig_out_nid = ALC882_DIGOUT_NID,
+               //.dig_in_nid = ALC882_DIGIN_NID,
+               .unsol_event = alc_automute_amp_unsol_event,
+               .setup = alc885_mba21_setup,
+               .init_hook = alc_automute_amp,
+       },
 	[ALC885_MBP3] = {
 		.mixers = { alc885_mbp3_mixer, alc882_chmode_mixer },
 		.init_verbs = { alc885_mbp3_init_verbs,
