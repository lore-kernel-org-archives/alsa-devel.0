From: Tobin Davis <gruemaster@email.uophx.edu>
Subject: Add support for Fujitsu PI1556 Realtek ALC880
Date: Tue, 06 Feb 2007 15:05:21 -0800
Message-ID: <1170803121.28278.305.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=-iX+tmvk3lMtDvT58Ypp8"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-iX+tmvk3lMtDvT58Ypp8
Content-Type: multipart/alternative; boundary="=-kwmkBc5H0GtuzKYPLjL7"


--=-kwmkBc5H0GtuzKYPLjL7
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch adds support for the Fujitsu PI1556 laptop.

Issue:  Volume knob on system maxes out lower than alsamixer (0x35 vs
0x40).  Everything else works, and audio quality is good at 0x35.


Signed off by Tobin Davis <tdavis@dsl-only.net>


--=-kwmkBc5H0GtuzKYPLjL7
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.12.0">
</HEAD>
<BODY>
This patch adds support for the Fujitsu PI1556 laptop.<BR>
<BR>
Issue:&nbsp; Volume knob on system maxes out lower than alsamixer (0x35 vs 0x40).&nbsp; Everything else works, and audio quality is good at 0x35.<BR>
<BR>
<TABLE CELLSPACING="0" CELLPADDING="0" WIDTH="100%">
<TR>
<TD>
<BR>
Signed off by Tobin Davis &lt;<A HREF="mailto:tdavis@dsl-only.net">tdavis@dsl-only.net</A>&gt;<BR>
<BR>
</TD>
</TR>
</TABLE>
</BODY>
</HTML>

--=-kwmkBc5H0GtuzKYPLjL7--

--=-iX+tmvk3lMtDvT58Ypp8
Content-Disposition: attachment; filename=fujitsu_pi1536.patch.5
Content-Type: text/x-patch; name=fujitsu_pi1536.patch.5; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r a42a457ae20c pci/hda/patch_realtek.c
--- a/pci/hda/patch_realtek.c	Mon Feb 05 14:56:20 2007 +0100
+++ b/pci/hda/patch_realtek.c	Tue Feb 06 09:53:58 2007 -0800
@@ -52,6 +52,7 @@ enum {
 	ALC880_ASUS_DIG,
 	ALC880_ASUS_W1V,
 	ALC880_ASUS_DIG2,
+	ALC880_FUJITSU,
 	ALC880_UNIWILL_DIG,
 	ALC880_UNIWILL,
 	ALC880_UNIWILL_P53,
@@ -1073,6 +1074,20 @@ static struct snd_kcontrol_new alc880_un
 	{ } /* end */
 };
 
+static struct snd_kcontrol_new alc880_fujitsu_mixer[] = {
+	HDA_CODEC_VOLUME("Headphone Playback Volume", 0x0c, 0x0, HDA_OUTPUT),
+	HDA_BIND_MUTE("Headphone Playback Switch", 0x0c, 2, HDA_INPUT),
+	HDA_CODEC_VOLUME("Speaker Playback Volume", 0x0d, 0x0, HDA_OUTPUT),
+	HDA_BIND_MUTE("Speaker Playback Switch", 0x0d, 2, HDA_INPUT),
+	HDA_CODEC_VOLUME("CD Playback Volume", 0x0b, 0x04, HDA_INPUT),
+	HDA_CODEC_MUTE("CD Playback Switch", 0x0b, 0x04, HDA_INPUT),
+	HDA_CODEC_VOLUME("Ext Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
+	HDA_CODEC_MUTE("Ext Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Int Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
+	HDA_CODEC_MUTE("Int Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
+	{ } /* end */
+};
+
 static struct snd_kcontrol_new alc880_uniwill_p53_mixer[] = {
 	HDA_CODEC_VOLUME("HPhone Playback Volume", 0x0c, 0x0, HDA_OUTPUT),
 	HDA_BIND_MUTE("HPhone Playback Switch", 0x0c, 2, HDA_INPUT),
@@ -1385,6 +1400,11 @@ static struct hda_verb alc880_uniwill_p5
 	{0x14, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | ALC880_HP_EVENT},
 	{0x21, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | ALC880_DCVOL_EVENT},
 
+	{ }
+};
+
+static struct hda_verb alc880_beep_init_verbs[] = {
+	{ 0x0b, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(5) },
 	{ }
 };
 
@@ -2357,6 +2377,8 @@ static const char *alc880_models[ALC880_
 	[ALC880_ASUS_DIG]	= "asus-dig",
 	[ALC880_ASUS_DIG2]	= "asus-dig2",
 	[ALC880_UNIWILL_DIG]	= "uniwill",
+	[ALC880_UNIWILL_P53]	= "uniwill-p53",
+	[ALC880_FUJITSU]	= "fujitsu",
 	[ALC880_F1734]		= "F1734",
 	[ALC880_LG]		= "lg",
 	[ALC880_LG_LW]		= "lg-lw",
@@ -2427,6 +2449,7 @@ static struct snd_pci_quirk alc880_cfg_t
 	SND_PCI_QUIRK(0x1695, 0x4012, "EPox EP-5LDA", ALC880_5ST_DIG),
 	SND_PCI_QUIRK(0x1734, 0x10ac, "FSC", ALC880_UNIWILL),
 	SND_PCI_QUIRK(0x1734, 0x107c, "FSC F1734", ALC880_F1734),
+	SND_PCI_QUIRK(0x1734, 0x10b0, "Fujitsu", ALC880_FUJITSU),
 
 	SND_PCI_QUIRK(0x1854, 0x003b, "LG", ALC880_LG),
 	SND_PCI_QUIRK(0x1854, 0x0068, "LG w1", ALC880_LG),
@@ -2635,7 +2658,21 @@ static struct alc_config_preset alc880_p
 		.num_dacs = ARRAY_SIZE(alc880_asus_dac_nids),
 		.dac_nids = alc880_asus_dac_nids,
 		.num_channel_mode = ARRAY_SIZE(alc880_w810_modes),
-		.channel_mode = alc880_w810_modes,
+		.channel_mode = alc880_threestack_modes,
+		.input_mux = &alc880_capture_source,
+		.unsol_event = alc880_uniwill_p53_unsol_event,
+		.init_hook = alc880_uniwill_p53_hp_automute,
+	},
+	[ALC880_FUJITSU] = {
+		.mixers = { alc880_fujitsu_mixer, 
+			    alc880_pcbeep_mixer, },
+		.init_verbs = { alc880_volume_init_verbs,
+				alc880_uniwill_p53_init_verbs,
+	       			alc880_beep_init_verbs },
+		.num_dacs = ARRAY_SIZE(alc880_dac_nids),
+		.dac_nids = alc880_dac_nids,
+		.num_channel_mode = ARRAY_SIZE(alc880_2_jack_modes),
+		.channel_mode = alc880_2_jack_modes,
 		.input_mux = &alc880_capture_source,
 		.unsol_event = alc880_uniwill_p53_unsol_event,
 		.init_hook = alc880_uniwill_p53_hp_automute,

--=-iX+tmvk3lMtDvT58Ypp8
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--=-iX+tmvk3lMtDvT58Ypp8
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-iX+tmvk3lMtDvT58Ypp8--
