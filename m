From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Intel HDA on Mac Pro
Date: Thu, 07 Dec 2006 15:46:40 -0800
Message-ID: <1165535200.7530.63.camel@razman>
References: <4574866D.5070506@sourcegear.com>
	<1165265511.32312.86.camel@razman>	<45748CF5.8040800@sourcegear.com>
	<1165275957.32312.103.camel@razman>	<4574BB17.1020807@sourcegear.com>
	<1165278602.32312.110.camel@razman> <4574EF72.8020207@sourcegear.com>
	<457828D7.4020908@teamprise.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-kdoecNitXFfIaqXEKw7t"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <457828D7.4020908@teamprise.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Shaw Terwilliger <sterwill@teamprise.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-kdoecNitXFfIaqXEKw7t
Content-Type: multipart/alternative; boundary="=-aAvLNoHp3MvZQ6FBtT6z"


--=-aAvLNoHp3MvZQ6FBtT6z
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I've been looking over the spec for the Realtek ALC885 and comparing it
with an earlier patch for the Mac Mini in the Sigmatel code.  I'm
wondering if Apple is using the same GPIO mute function as on the Mini.
Attached is a patch to test that theory.  It essentially sets the system
up as a 3 stack audio (which may be wrong as it is), but also unmutes
the gpio registers.

To test it, start with either the alsa-driver-hg20061130.tar.bz2 or
download the recent 1.0.14rc1 and follow these instructions:
tar -jxvf alsa-driver-<version>.tar.bz2   # <version> == hg20061130 or
1.0.14rc1
cd alsa-driver-<version>/alsa-kernel
patch -p1 <macpro.patch.1
cd ..
./configure --with-cards=hda-intel --with-debug=detect ; make ; make
install
dmesg -c
modprobe -r snd-hda-intel
modprobe snd-hda-intel model=macpro
dmesg >dmesg.out

Send me a copy of dmesg.out along with any differences that you see.  I
may need to tweak which pins get enabled.

Tobin


On Thu, 2006-12-07 at 08:44 -0600, Shaw Terwilliger wrote:

> Shaw Terwilliger wrote:
> >> This is actually good info.  Interesting that sound is coming out from
> >> the Surround channels.  The low volume could mean that EAPD still needs
> >> to be set.
> >>
> >> I'll look more into this tomorrow.  Hopefully I can get a patch for you
> >> to test.
> > 
> > Thanks for all your help.  I'm happy to test any patches you come up with.
> 
> Have you had a chance too cook up any patches for the Mac Pro HDA
> hardware?  I fooled around with different models yesterday, and the
> "auto" model detects very few output channels (PCM, Front, Line-in), but
> correctly assigns the front channel.  It's still incredibly quiet.
> 

-- 
Tobin Davis <tdavis@dsl-only.net>

--=-aAvLNoHp3MvZQ6FBtT6z
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.6.2">
</HEAD>
<BODY>
I've been looking over the spec for the Realtek ALC885 and comparing it with an earlier patch for the Mac Mini in the Sigmatel code.&nbsp; I'm wondering if Apple is using the same GPIO mute function as on the Mini.&nbsp; Attached is a patch to test that theory.&nbsp; It essentially sets the system up as a 3 stack audio (which may be wrong as it is), but also unmutes the gpio registers.<BR>
<BR>
To test it, start with either the alsa-driver-hg20061130.tar.bz2 or download the recent 1.0.14rc1 and follow these instructions:<BR>
tar -jxvf alsa-driver-&lt;version&gt;.tar.bz2&nbsp;&nbsp; # &lt;version&gt; == hg20061130 or 1.0.14rc1<BR>
cd alsa-driver-&lt;version&gt;/alsa-kernel<BR>
patch -p1 &lt;macpro.patch.1<BR>
cd ..<BR>
./configure --with-cards=hda-intel --with-debug=detect ; make ; make install<BR>
dmesg -c<BR>
modprobe -r snd-hda-intel<BR>
modprobe snd-hda-intel model=macpro<BR>
dmesg &gt;dmesg.out<BR>
<BR>
Send me a copy of dmesg.out along with any differences that you see.&nbsp; I may need to tweak which pins get enabled.<BR>
<BR>
Tobin<BR>
<BR>
<BR>
On Thu, 2006-12-07 at 08:44 -0600, Shaw Terwilliger wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">Shaw Terwilliger wrote:</FONT>
<FONT COLOR="#000000">&gt;&gt; This is actually good info.  Interesting that sound is coming out from</FONT>
<FONT COLOR="#000000">&gt;&gt; the Surround channels.  The low volume could mean that EAPD still needs</FONT>
<FONT COLOR="#000000">&gt;&gt; to be set.</FONT>
<FONT COLOR="#000000">&gt;&gt;</FONT>
<FONT COLOR="#000000">&gt;&gt; I'll look more into this tomorrow.  Hopefully I can get a patch for you</FONT>
<FONT COLOR="#000000">&gt;&gt; to test.</FONT>
<FONT COLOR="#000000">&gt; </FONT>
<FONT COLOR="#000000">&gt; Thanks for all your help.  I'm happy to test any patches you come up with.</FONT>

<FONT COLOR="#000000">Have you had a chance too cook up any patches for the Mac Pro HDA</FONT>
<FONT COLOR="#000000">hardware?  I fooled around with different models yesterday, and the</FONT>
<FONT COLOR="#000000">&quot;auto&quot; model detects very few output channels (PCM, Front, Line-in), but</FONT>
<FONT COLOR="#000000">correctly assigns the front channel.  It's still incredibly quiet.</FONT>

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

--=-aAvLNoHp3MvZQ6FBtT6z--

--=-kdoecNitXFfIaqXEKw7t
Content-Disposition: attachment; filename=macpro.patch.1
Content-Type: text/x-patch; name=macpro.patch.1; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff -r b201c63fc4b3 pci/hda/patch_realtek.c
--- a/pci/hda/patch_realtek.c	Mon Dec 04 18:03:53 2006 +0100
+++ b/pci/hda/patch_realtek.c	Thu Dec 07 15:37:34 2006 -0800
@@ -112,6 +112,7 @@ enum {
 	ALC882_6ST_DIG,
 	ALC882_ARIMA,
 	ALC882_AUTO,
+	ALC885_MACPRO,
 	ALC882_MODEL_LAST,
 };
 
@@ -4507,6 +4508,39 @@ static struct hda_verb alc882_eapd_verbs
 	{ } 
 };
 
+/* Mac Pro test */
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
@@ -4633,6 +4667,7 @@ static const char *alc882_models[ALC882_
 	[ALC882_3ST_DIG]	= "3stack-dig",
 	[ALC882_6ST_DIG]	= "6stack-dig",
 	[ALC882_ARIMA]		= "arima",
+	[ALC885_MACPRO]		= "macpro",
 	[ALC882_AUTO]		= "auto",
 };
 
@@ -4675,6 +4710,17 @@ static struct alc_config_preset alc882_p
 		.dac_nids = alc882_dac_nids,
 		.num_channel_mode = ARRAY_SIZE(alc882_sixstack_modes),
 		.channel_mode = alc882_sixstack_modes,
+		.input_mux = &alc882_capture_source,
+	},
+	[ALC885_MACPRO] = {
+		.mixers = { alc882_base_mixer },
+		.init_verbs = { alc882_init_verbs },
+		.num_dacs = ARRAY_SIZE(alc882_dac_nids),
+		.dac_nids = alc882_dac_nids,
+		.dig_out_nid = ALC882_DIGOUT_NID,
+		.dig_in_nid = ALC882_DIGIN_NID,
+		.num_channel_mode = ARRAY_SIZE(alc882_ch_modes),
+		.channel_mode = alc882_ch_modes,
 		.input_mux = &alc882_capture_source,
 	},
 };
@@ -4803,6 +4849,11 @@ static int patch_alc882(struct hda_codec
 
 	if (board_config != ALC882_AUTO)
 		setup_preset(spec, &alc882_presets[board_config]);
+
+	if (board_config == ALC885_MACPRO) {
+		alc882_gpio_mute(codec, 0, 0);
+		alc882_gpio_mute(codec, 1, 0);
+	}
 
 	spec->stream_name_analog = "ALC882 Analog";
 	spec->stream_analog_playback = &alc882_pcm_analog_playback;

--=-kdoecNitXFfIaqXEKw7t
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-kdoecNitXFfIaqXEKw7t
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-kdoecNitXFfIaqXEKw7t--
