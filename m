From: Reimundo Heluani <rheluani@gmail.com>
Subject: Re: Macbook Air 2,1 - no mic nor main speakers
Date: Mon, 22 Feb 2010 18:12:23 -0800
Message-ID: <1266891143.1708.5.camel@vino>
References: <1265480879.2466.21.camel@vino> <1266820258.3074.16.camel@vino>
	<s5h7hq54sd8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-WiOPBfMwgvB5K9Q6OC45"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f185.google.com (mail-qy0-f185.google.com
	[209.85.221.185])
	by alsa0.perex.cz (Postfix) with ESMTP id CD421244C0
	for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2010 03:28:18 +0100 (CET)
Received: by qyk15 with SMTP id 15so1949390qyk.7
	for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2010 18:28:17 -0800 (PST)
In-Reply-To: <s5h7hq54sd8.wl%tiwai@suse.de>
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
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org


--=-WiOPBfMwgvB5K9Q6OC45
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 2010-02-22 at 08:55 +0100, Takashi Iwai wrote:
> Also, please make a patch in a unified diff format.
> 
> If the patch is ready for merge, please post it (and add me to Cc)
> with a proper changelog and your sign-off.
> 


Attached is a patch in unified diff format that adds support for Macbook
Air's 2,1 internal speaker and headphone. Only one mixer control for
both, but at least the main speaker mutes when the jack is connected and
the headphones work fine now (at least in my machine). I couldn't find
the mic yet. I do not know what a proper changelog is nor what my
sign-off would be, I do mathematics for a living (or so I thought).

I'll update the bug I opened over a year ago when I didn't know about
hda-analyzer. 

Cheers,

R.



--=-WiOPBfMwgvB5K9Q6OC45
Content-Disposition: attachment; filename="patch_realtek-headphones-working.patch"
Content-Type: text/x-patch; name="patch_realtek-headphones-working.patch"; charset="us-ascii"
Content-Transfer-Encoding: 7bit

--- patch_realtek.c.orig	2010-02-22 08:40:29.000000000 -0800
+++ patch_realtek.c	2010-02-22 16:26:58.000000000 -0800
@@ -205,6 +205,7 @@
 	ALC882_ASUS_A7J,
 	ALC882_ASUS_A7M,
 	ALC885_MACPRO,
+	ALC885_MBA21,
 	ALC885_MBP3,
 	ALC885_MB5,
 	ALC885_IMAC24,
@@ -6749,6 +6750,13 @@
 	{ 8, alc882_sixstack_ch8_init },
 };
 
+
+/* Macbook Air 2,1 */
+
+static struct hda_channel_mode alc885_mba21_ch_modes[1] = {
+      { 2, NULL },
+};
+
 /*
  * macbook pro ALC885 can switch LineIn to LineOut without losing Mic
  */
@@ -7021,6 +7029,15 @@
 };
 
 
+/* Macbook Air 2,1 same control for HP and internal Speaker */
+
+static struct snd_kcontrol_new alc885_mba21_mixer[] = {
+      HDA_CODEC_VOLUME("Speaker Playback Volume", 0x0c, 0x00, HDA_OUTPUT),
+      HDA_BIND_MUTE   ("Speaker Playback Switch", 0x0c, 0x02, HDA_OUTPUT),
+     { }
+};
+
+
 static struct snd_kcontrol_new alc885_mbp3_mixer[] = {
 	HDA_CODEC_VOLUME("Speaker Playback Volume", 0x0c, 0x00, HDA_OUTPUT),
 	HDA_BIND_MUTE   ("Speaker Playback Switch", 0x0c, 0x02, HDA_INPUT),
@@ -7445,6 +7462,29 @@
 	{ }
 };
 
+
+static struct hda_verb alc885_mba21_init_verbs[] = {
+	/*Internal and HP Speaker Mixer*/
+	{0x0c, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO}, 
+	{0x0c, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+	{0x0c, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},
+	/*Internal Speaker Pin (0x0c)*/
+	{0x18, AC_VERB_SET_PIN_WIDGET_CONTROL, (PIN_OUT | AC_PINCTL_VREF_50) },
+	{0x18, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	{0x18, AC_VERB_SET_CONNECT_SEL, 0x00},
+	/* HP Pin: output 0 (0x0e) */
+	{0x14, AC_VERB_SET_PIN_WIDGET_CONTROL, 0xc4},
+	{0x14, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	{0x14, AC_VERB_SET_CONNECT_SEL, 0x00},
+	{0x14, AC_VERB_SET_UNSOLICITED_ENABLE, (ALC880_HP_EVENT | AC_USRSP_EN)},
+	/* Line in (is hp when jack connected)*/
+	{0x19, AC_VERB_SET_PIN_WIDGET_CONTROL, AC_PINCTL_VREF_50},
+	{0x19, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE},
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
+	[ALC885_MBA21]		= "mba21",
 	[ALC885_MBP3]		= "mbp3",
 	[ALC885_IMAC24]		= "imac24",
 	[ALC883_3ST_2ch_DIG]	= "3stack-2ch-dig",
@@ -8970,6 +9022,18 @@
 		.input_mux = &alc882_capture_source,
 		.dig_out_nid = ALC882_DIGOUT_NID,
 	},
+	   [ALC885_MBA21] = {
+               .mixers = { alc885_mba21_mixer }, 
+               .init_verbs = { alc885_mba21_init_verbs, alc880_gpio1_init_verbs },
+               .num_dacs = 2,
+               .dac_nids = alc882_dac_nids,
+               .channel_mode = alc885_mba21_ch_modes,
+               .num_channel_mode = ARRAY_SIZE(alc885_mba21_ch_modes),
+               .input_mux = &alc882_capture_source,
+               .unsol_event = alc_automute_amp_unsol_event,
+               .setup = alc885_mba21_setup,
+               .init_hook = alc_automute_amp,
+       },
 	[ALC885_MBP3] = {
 		.mixers = { alc885_mbp3_mixer, alc882_chmode_mixer },
 		.init_verbs = { alc885_mbp3_init_verbs,

--=-WiOPBfMwgvB5K9Q6OC45
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-WiOPBfMwgvB5K9Q6OC45--
