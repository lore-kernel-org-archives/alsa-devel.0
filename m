From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Intel HDA on Mac Pro
Date: Mon, 11 Dec 2006 08:33:53 -0800
Message-ID: <1165854833.7530.205.camel@razman>
References: <4574866D.5070506@sourcegear.com>
	<1165265511.32312.86.camel@razman>	<45748CF5.8040800@sourcegear.com>
	<1165275957.32312.103.camel@razman>	<4574BB17.1020807@sourcegear.com>
	<1165278602.32312.110.camel@razman> <4574EF72.8020207@sourcegear.com>
	<457828D7.4020908@teamprise.com> <1165535200.7530.63.camel@razman>
	<4579BF60.8000601@sourcegear.com> <1165767364.7530.148.camel@razman>
	<457D6E99.2000207@sourcegear.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-KSMlK4WqNEuDUiXUBa/3"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <457D6E99.2000207@sourcegear.com>
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-KSMlK4WqNEuDUiXUBa/3
Content-Type: multipart/alternative; boundary="=-CbieeQI6rccxV74z5Uy2"


--=-CbieeQI6rccxV74z5Uy2
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Ok, based on that information, I think I have a working patch.  Give
this a try.  

I'll let the next guy work on the S/PDIF if there is an issue with it.

Tobin

On Mon, 2006-12-11 at 08:43 -0600, Shaw Terwilliger wrote:

> Tobin Davis wrote:
> > modprobe -r snd-hda-intel
> > dmesg -c >/dev/null
> > modprobe snd-hda-intel model=auto
> > dmesg >dmesg.out  # send me this output
> > 
> > This should (hopefully) detect which port the headphones are on.  It
> > won't enable sound, but it is useful for detecting pins from the bios
> > settings.
> 
> File is attached.
> 
> > Also, when you said sound was coming from the surround channels, do you
> > know if the front output was coming from that?  To test this, reload the
> > driver with "model=macpro" and type:
> > speaker-test -c 6 -t wav -Dplug:surround51
> 
> I get:
> 
> Unable to set nperiods 4 for playback: Invalid argument
> Setting of hwparams failed: Invalid argument
> 
> If I change "-c 6" to "-c 8", I can run with the rest of the args (also
> works with 4).  The "rear right" channel in the speaker test comes from
> the actual front right speaker (and "rear left" from the actual front
> left).  Speakers are plugged in the to Mac's rear line-out.  And it's
> the "Surround" mixer strip (alsamixer) that controls these volumes.
> 
> 
> plain text document attachment (hda-model-auto.dmesg.txt)
> 
> [593939.343584] ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 23 (level, low) -> IRQ 225
> [593939.344458] PCI: Setting latency timer of device 0000:00:1b.0 to 64
> [593939.378547] ALSA /data/downloads/alsa-driver-1.0.14rc1/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:696: codec_mask = 0x1
> [593939.556328] ALSA /data/downloads/alsa-driver-1.0.14rc1/pci/hda/hda_codec.c:1743: hda_codec: model 'auto' is selected
> [593939.604812] ALSA /data/downloads/alsa-driver-1.0.14rc1/pci/hda/hda_codec.c:2175: autoconfig: line_outs=1 (0x15/0x0/0x0/0x0/0x0)
> [593939.604817] ALSA /data/downloads/alsa-driver-1.0.14rc1/pci/hda/hda_codec.c:2179:    speaker_outs=1 (0x1a/0x0/0x0/0x0/0x0)
> [593939.604821] ALSA /data/downloads/alsa-driver-1.0.14rc1/pci/hda/hda_codec.c:2183:    hp_outs=1 (0x18/0x0/0x0/0x0/0x0)
> [593939.604824] ALSA /data/downloads/alsa-driver-1.0.14rc1/pci/hda/hda_codec.c:2191:    inputs: mic=0x0, fmic=0x0, line=0x19, fline=0x0, cd=0x0, aux=0x0

-- 
Tobin Davis <tdavis@dsl-only.net>

--=-CbieeQI6rccxV74z5Uy2
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.6.2">
</HEAD>
<BODY>
Ok, based on that information, I think I have a working patch.&nbsp; Give this a try.&nbsp; <BR>
<BR>
I'll let the next guy work on the S/PDIF if there is an issue with it.<BR>
<BR>
Tobin<BR>
<BR>
On Mon, 2006-12-11 at 08:43 -0600, Shaw Terwilliger wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">Tobin Davis wrote:</FONT>
<FONT COLOR="#000000">&gt; modprobe -r snd-hda-intel</FONT>
<FONT COLOR="#000000">&gt; dmesg -c &gt;/dev/null</FONT>
<FONT COLOR="#000000">&gt; modprobe snd-hda-intel model=auto</FONT>
<FONT COLOR="#000000">&gt; dmesg &gt;dmesg.out  # send me this output</FONT>
<FONT COLOR="#000000">&gt; </FONT>
<FONT COLOR="#000000">&gt; This should (hopefully) detect which port the headphones are on.  It</FONT>
<FONT COLOR="#000000">&gt; won't enable sound, but it is useful for detecting pins from the bios</FONT>
<FONT COLOR="#000000">&gt; settings.</FONT>

<FONT COLOR="#000000">File is attached.</FONT>

<FONT COLOR="#000000">&gt; Also, when you said sound was coming from the surround channels, do you</FONT>
<FONT COLOR="#000000">&gt; know if the front output was coming from that?  To test this, reload the</FONT>
<FONT COLOR="#000000">&gt; driver with &quot;model=macpro&quot; and type:</FONT>
<FONT COLOR="#000000">&gt; speaker-test -c 6 -t wav -Dplug:surround51</FONT>

<FONT COLOR="#000000">I get:</FONT>

<FONT COLOR="#000000">Unable to set nperiods 4 for playback: Invalid argument</FONT>
<FONT COLOR="#000000">Setting of hwparams failed: Invalid argument</FONT>

<FONT COLOR="#000000">If I change &quot;-c 6&quot; to &quot;-c 8&quot;, I can run with the rest of the args (also</FONT>
<FONT COLOR="#000000">works with 4).  The &quot;rear right&quot; channel in the speaker test comes from</FONT>
<FONT COLOR="#000000">the actual front right speaker (and &quot;rear left&quot; from the actual front</FONT>
<FONT COLOR="#000000">left).  Speakers are plugged in the to Mac's rear line-out.  And it's</FONT>
<FONT COLOR="#000000">the &quot;Surround&quot; mixer strip (alsamixer) that controls these volumes.</FONT>

</PRE>
    <TABLE CELLSPACING="0" CELLPADDING="0" BORDER="1">
<TR>
<TD>
<FONT SIZE="2">plain text document attachment (hda-model-auto.dmesg.txt)</FONT>
</TD>
</TR>
</TABLE>
<PRE>
<FONT COLOR="#000000">[593939.343584] ACPI: PCI Interrupt 0000:00:1b.0[A] -&gt; GSI 23 (level, low) -&gt; IRQ 225</FONT>
<FONT COLOR="#000000">[593939.344458] PCI: Setting latency timer of device 0000:00:1b.0 to 64</FONT>
<FONT COLOR="#000000">[593939.378547] ALSA /data/downloads/alsa-driver-1.0.14rc1/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:696: codec_mask = 0x1</FONT>
<FONT COLOR="#000000">[593939.556328] ALSA /data/downloads/alsa-driver-1.0.14rc1/pci/hda/hda_codec.c:1743: hda_codec: model 'auto' is selected</FONT>
<FONT COLOR="#000000">[593939.604812] ALSA /data/downloads/alsa-driver-1.0.14rc1/pci/hda/hda_codec.c:2175: autoconfig: line_outs=1 (0x15/0x0/0x0/0x0/0x0)</FONT>
<FONT COLOR="#000000">[593939.604817] ALSA /data/downloads/alsa-driver-1.0.14rc1/pci/hda/hda_codec.c:2179:    speaker_outs=1 (0x1a/0x0/0x0/0x0/0x0)</FONT>
<FONT COLOR="#000000">[593939.604821] ALSA /data/downloads/alsa-driver-1.0.14rc1/pci/hda/hda_codec.c:2183:    hp_outs=1 (0x18/0x0/0x0/0x0/0x0)</FONT>
<FONT COLOR="#000000">[593939.604824] ALSA /data/downloads/alsa-driver-1.0.14rc1/pci/hda/hda_codec.c:2191:&nbsp;&nbsp;&nbsp; inputs: mic=0x0, fmic=0x0, line=0x19, fline=0x0, cd=0x0, aux=</FONT>0x0
</PRE>
</BLOCKQUOTE>
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

--=-CbieeQI6rccxV74z5Uy2--

--=-KSMlK4WqNEuDUiXUBa/3
Content-Disposition: attachment; filename=macpro.patch.2
Content-Type: text/x-patch; name=macpro.patch.2; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff -r 1ede4dc9b6ea pci/hda/patch_realtek.c
--- a/pci/hda/patch_realtek.c	Sun Dec 10 00:00:38 2006 +0000
+++ b/pci/hda/patch_realtek.c	Mon Dec 11 08:29:20 2006 -0800
@@ -112,6 +112,7 @@ enum {
 	ALC882_6ST_DIG,
 	ALC882_ARIMA,
 	ALC882_AUTO,
+	ALC885_MACPRO,
 	ALC882_MODEL_LAST,
 };
 
@@ -4507,6 +4508,103 @@ static struct hda_verb alc882_eapd_verbs
 	{ } 
 };
 
+/* Mac Pro test */
+static struct snd_kcontrol_new alc882_macpro_mixer[] = {
+	HDA_CODEC_VOLUME("Front Playback Volume", 0x0d, 0x0, HDA_OUTPUT),
+	HDA_BIND_MUTE("Front Playback Switch", 0x0d, 2, HDA_INPUT),
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
+	/* Mic (rear) pin: input vref at 80% */
+	{0x18, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80},
+	{0x18, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE},
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
@@ -4633,6 +4731,7 @@ static const char *alc882_models[ALC882_
 	[ALC882_3ST_DIG]	= "3stack-dig",
 	[ALC882_6ST_DIG]	= "6stack-dig",
 	[ALC882_ARIMA]		= "arima",
+	[ALC885_MACPRO]		= "macpro",
 	[ALC882_AUTO]		= "auto",
 };
 
@@ -4675,6 +4774,17 @@ static struct alc_config_preset alc882_p
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
@@ -4803,6 +4913,11 @@ static int patch_alc882(struct hda_codec
 
 	if (board_config != ALC882_AUTO)
 		setup_preset(spec, &alc882_presets[board_config]);
+
+	if (board_config == ALC885_MACPRO) {
+		alc882_gpio_mute(codec, 0, 0);
+		alc882_gpio_mute(codec, 1, 0);
+	}
 
 	spec->stream_name_analog = "ALC882 Analog";
 	spec->stream_analog_playback = &alc882_pcm_analog_playback;

--=-KSMlK4WqNEuDUiXUBa/3
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-KSMlK4WqNEuDUiXUBa/3
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-KSMlK4WqNEuDUiXUBa/3--
