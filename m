From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Intel HDA on Mac Pro
Date: Thu, 14 Dec 2006 08:51:29 -0800
Message-ID: <1166115089.4142.141.camel@razman>
References: <4574866D.5070506@sourcegear.com>
	<45748CF5.8040800@sourcegear.com> <1165275957.32312.103.camel@razman>
	<4574BB17.1020807@sourcegear.com> <1165278602.32312.110.camel@razman>
	<4574EF72.8020207@sourcegear.com> <457828D7.4020908@teamprise.com>
	<1165535200.7530.63.camel@razman>
	<loom.20061211T231028-61@post.gmane.org>
	<1165877711.7530.253.camel@razman>
	<f0d712d60612111704x14717093p6e038641fc6e94e6@mail.gmail.com>
	<1166023329.4142.86.camel@razman>  <45802C28.1020401@sourcegear.com>
	<1166079716.4142.122.camel@razman>  <4581696B.5010908@sourcegear.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-ntCFzeGKKzJsJ3sDMIOo"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <4581696B.5010908@sourcegear.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Shaw Terwilliger <sterwill@sourcegear.com>
Cc: Richard Anaya <richard.anaya@gmail.com>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-ntCFzeGKKzJsJ3sDMIOo
Content-Type: multipart/alternative; boundary="=-fv/lETTkXs2HUBUnDUDe"


--=-fv/lETTkXs2HUBUnDUDe
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I've been reading the data sheet for that codec, and found that it has 3
gpio pins instead of 2.  This patch reverses the last change, and
enables that third gpio.  If this doesn't work, I'm at a loss.

Wish I had some of these systems here to test with.  Maybe once I win
the lottery.  :)
-- 
Tobin Davis <tdavis@dsl-only.net>

--=-fv/lETTkXs2HUBUnDUDe
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.6.2">
</HEAD>
<BODY>
I've been reading the data sheet for that codec, and found that it has 3 gpio pins instead of 2.&nbsp; This patch reverses the last change, and enables that third gpio.&nbsp; If this doesn't work, I'm at a loss.<BR>
<BR>
Wish I had some of these systems here to test with.&nbsp; Maybe once I win the lottery.&nbsp; :)<BR>
<TABLE CELLSPACING="0" CELLPADDING="0" WIDTH="100%">
<TR>
<TD>
-- <BR>
Tobin Davis &lt;<A HREF="mailto:tdavis@dsl-only.net">tdavis@dsl-only.net</A>&gt;
</TD>
</TR>
</TABLE>
</BODY>
</HTML>

--=-fv/lETTkXs2HUBUnDUDe--

--=-ntCFzeGKKzJsJ3sDMIOo
Content-Disposition: attachment; filename=macpro.patch.6
Content-Type: text/x-patch; name=macpro.patch.6; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff -r 1ede4dc9b6ea pci/hda/patch_realtek.c
--- a/pci/hda/patch_realtek.c	Sun Dec 10 00:00:38 2006 +0000
+++ b/pci/hda/patch_realtek.c	Thu Dec 14 08:50:51 2006 -0800
@@ -112,6 +112,7 @@ enum {
 	ALC882_6ST_DIG,
 	ALC882_ARIMA,
 	ALC882_AUTO,
+	ALC885_MACPRO,
 	ALC882_MODEL_LAST,
 };
 
@@ -4507,6 +4508,100 @@ static struct hda_verb alc882_eapd_verbs
 	{ } 
 };
 
+/* Mac Pro test */
+static struct snd_kcontrol_new alc882_macpro_mixer[] = {
+	HDA_CODEC_VOLUME("Front Playback Volume", 0x0c, 0x0, HDA_OUTPUT),
+	HDA_BIND_MUTE("Front Playback Switch", 0x0c, 2, HDA_INPUT),
+	HDA_CODEC_MUTE("Headphone Playback Switch", 0x18, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("Line Playback Volume", 0x0b, 0x01, HDA_INPUT),
+	HDA_CODEC_MUTE("Line Playback Switch", 0x0b, 0x01, HDA_INPUT),
+	HDA_CODEC_VOLUME("PC Speaker Playback Volume", 0x0b, 0x02, HDA_INPUT),
+	HDA_CODEC_MUTE("PC Speaker Playback Switch", 0x0b, 0x02, HDA_INPUT),
+	{ } /* end */
+};
+
+static struct hda_verb alc882_macpro_init_verbs[] = {
+	/* Front mixer: unmute input/output amp left and right (volume = 0) */
+	{0x0c, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO},
+	{0x0c, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+	{0x0c, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
+	/* Front Pin: output 0 (0x0c) */
+	{0x15, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
+	{0x15, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	{0x15, AC_VERB_SET_CONNECT_SEL, 0x00},
+	/* Front Mic pin: input vref at 80% */
+	{0x19, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80},
+	{0x19, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE},
+	/* Speaker:  output */
+	{0x1a, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
+	{0x1a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	{0x1a, AC_VERB_SET_CONNECT_SEL, 0x04},
+	/* Headphone output (output 0 - 0x0c) */
+	{0x18, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_HP},
+	{0x18, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	{0x18, AC_VERB_SET_CONNECT_SEL, 0x00},
+
+	/* FIXME: use matrix-type input source selection */
+	/* Mixer elements: 0x18, 19, 1a, 1b, 1c, 1d, 14, 15, 16, 17, 0b */
+	/* Input mixer1: unmute Mic, F-Mic, Line, CD inputs */
+	{0x24, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+	{0x24, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(3)},
+	{0x24, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(2)},
+	{0x24, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(4)},
+	/* Input mixer2 */
+	{0x23, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+	{0x23, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(3)},
+	{0x23, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(2)},
+	{0x23, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(4)},
+	/* Input mixer3 */
+	{0x22, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+	{0x22, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(3)},
+	{0x22, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(2)},
+	{0x22, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(4)},
+	/* ADC1: mute amp left and right */
+	{0x07, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+	{0x07, AC_VERB_SET_CONNECT_SEL, 0x00},
+	/* ADC2: mute amp left and right */
+	{0x08, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+	{0x08, AC_VERB_SET_CONNECT_SEL, 0x00},
+	/* ADC3: mute amp left and right */
+	{0x09, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+	{0x09, AC_VERB_SET_CONNECT_SEL, 0x00},
+
+	{ }
+};
+static void alc882_gpio_mute(struct hda_codec *codec, int pin, int muted)
+{
+	unsigned int gpiostate, gpiomask, gpiodir;
+
+	gpiostate = snd_hda_codec_read(codec, codec->afg, 0,
+				       AC_VERB_GET_GPIO_DATA, 0);
+
+	if (!muted)
+		gpiostate |= (1 << pin);
+	else
+		gpiostate &= ~(1 << pin);
+
+	gpiomask = snd_hda_codec_read(codec, codec->afg, 0,
+				      AC_VERB_GET_GPIO_MASK, 0);
+	gpiomask |= (1 << pin);
+
+	gpiodir = snd_hda_codec_read(codec, codec->afg, 0,
+				     AC_VERB_GET_GPIO_DIRECTION, 0);
+	gpiodir |= (1 << pin);
+
+
+	snd_hda_codec_write(codec, codec->afg, 0,
+			    AC_VERB_SET_GPIO_MASK, gpiomask);
+	snd_hda_codec_write(codec, codec->afg, 0,
+			    AC_VERB_SET_GPIO_DIRECTION, gpiodir);
+
+	msleep(1);
+
+	snd_hda_codec_write(codec, codec->afg, 0,
+			    AC_VERB_SET_GPIO_DATA, gpiostate);
+}
+
 /*
  * generic initialization of ADC, input mixers and output mixers
  */
@@ -4633,6 +4728,7 @@ static const char *alc882_models[ALC882_
 	[ALC882_3ST_DIG]	= "3stack-dig",
 	[ALC882_6ST_DIG]	= "6stack-dig",
 	[ALC882_ARIMA]		= "arima",
+	[ALC885_MACPRO]		= "macpro",
 	[ALC882_AUTO]		= "auto",
 };
 
@@ -4675,6 +4771,17 @@ static struct alc_config_preset alc882_p
 		.dac_nids = alc882_dac_nids,
 		.num_channel_mode = ARRAY_SIZE(alc882_sixstack_modes),
 		.channel_mode = alc882_sixstack_modes,
+		.input_mux = &alc882_capture_source,
+	},
+	[ALC885_MACPRO] = {
+		.mixers = { alc882_macpro_mixer },
+		.init_verbs = { alc882_macpro_init_verbs },
+		.num_dacs = ARRAY_SIZE(alc882_dac_nids),
+		.dac_nids = alc882_dac_nids,
+		.dig_out_nid = ALC882_DIGOUT_NID,
+		.dig_in_nid = ALC882_DIGIN_NID,
+		.num_channel_mode = ARRAY_SIZE(alc882_ch_modes),
+		.channel_mode = alc882_ch_modes,
 		.input_mux = &alc882_capture_source,
 	},
 };
@@ -4803,6 +4910,12 @@ static int patch_alc882(struct hda_codec
 
 	if (board_config != ALC882_AUTO)
 		setup_preset(spec, &alc882_presets[board_config]);
+
+	if (board_config == ALC885_MACPRO) {
+		alc882_gpio_mute(codec, 0, 0);
+		alc882_gpio_mute(codec, 1, 0);
+		alc882_gpio_mute(codec, 2, 0);
+	}
 
 	spec->stream_name_analog = "ALC882 Analog";
 	spec->stream_analog_playback = &alc882_pcm_analog_playback;

--=-ntCFzeGKKzJsJ3sDMIOo
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-ntCFzeGKKzJsJ3sDMIOo
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-ntCFzeGKKzJsJ3sDMIOo--
