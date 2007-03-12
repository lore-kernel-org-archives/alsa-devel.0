From: Tobin Davis <tdavis@dsl-only.net>
Subject: hda-codec:  more systems for Analog Devices
Date: Mon, 12 Mar 2007 14:02:24 -0700
Message-ID: <1173733344.27164.27.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-H7Hh74oGPdF9V8R8CVyX"
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


--=-H7Hh74oGPdF9V8R8CVyX
Content-Type: multipart/alternative; boundary="=-eZakfZQvg9vyOcW6S639"


--=-eZakfZQvg9vyOcW6S639
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch adds support for more systems using Analog Devices codecs.

        Asus P5B-DLX - AD1988
        Toshiba U205 - AD1981
        Lenovo M55 - AD1986
        Samsung R55 - AD1986


Signed off by Tobin Davis <tdavis@dsl-only.net>

--=-eZakfZQvg9vyOcW6S639
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.12.0">
</HEAD>
<BODY>
This patch adds support for more systems using Analog Devices codecs.<BR>
<BLOCKQUOTE>
    Asus P5B-DLX - AD1988<BR>
    Toshiba U205 - AD1981<BR>
    Lenovo M55 - AD1986<BR>
    Samsung R55 - AD1986<BR>
</BLOCKQUOTE>
<TABLE CELLSPACING="0" CELLPADDING="0" WIDTH="100%">
<TR>
<TD>
<BR>
Signed off by Tobin Davis &lt;tdavis@dsl-only.net&gt;
</TD>
</TR>
</TABLE>
</BODY>
</HTML>

--=-eZakfZQvg9vyOcW6S639--

--=-H7Hh74oGPdF9V8R8CVyX
Content-Disposition: attachment; filename=Analog.patch
Content-Type: text/x-patch; name=Analog.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r e87b2114ceae pci/hda/patch_analog.c
--- a/pci/hda/patch_analog.c	Mon Mar 12 12:54:23 2007 +0100
+++ b/pci/hda/patch_analog.c	Mon Mar 12 13:56:02 2007 -0700
@@ -833,12 +833,14 @@ static struct snd_pci_quirk ad1986a_cfg_
 	SND_PCI_QUIRK(0x1043, 0x81b3, "ASUS P5", AD1986A_3STACK),
 	SND_PCI_QUIRK(0x1043, 0x81cb, "ASUS M2N", AD1986A_3STACK),
 	SND_PCI_QUIRK(0x1043, 0x8234, "ASUS M2N", AD1986A_3STACK),
+	SND_PCI_QUIRK(0x144d, 0xb03c, "Samsung R55", AD1986A_3STACK),
 	SND_PCI_QUIRK(0x144d, 0xc01e, "FSC V2060", AD1986A_LAPTOP),
 	SND_PCI_QUIRK(0x144d, 0xc023, "Samsung X60", AD1986A_LAPTOP_EAPD),
 	SND_PCI_QUIRK(0x144d, 0xc024, "Samsung R65", AD1986A_LAPTOP_EAPD),
 	SND_PCI_QUIRK(0x144d, 0xc026, "Samsung X11", AD1986A_LAPTOP_EAPD),
 	SND_PCI_QUIRK(0x144d, 0xc504, "Samsung Q35", AD1986A_3STACK),
 	SND_PCI_QUIRK(0x144d, 0xc027, "Samsung Q1", AD1986A_ULTRA),
+	SND_PCI_QUIRK(0x17aa, 0x1011, "Lenovo M55", AD1986A_LAPTOP),
 	SND_PCI_QUIRK(0x17aa, 0x1017, "Lenovo A60", AD1986A_3STACK),
 	SND_PCI_QUIRK(0x17aa, 0x2066, "Lenovo N100", AD1986A_LAPTOP_EAPD),
 	SND_PCI_QUIRK(0x17c0, 0x2017, "Samsung M50", AD1986A_LAPTOP),
@@ -1205,7 +1207,7 @@ static struct hda_verb ad1981_init_verbs
 /*
  * Patch for HP nx6320
  *
- * nx6320 uses EAPD in the reserve way - EAPD-on means the internal
+ * nx6320 uses EAPD in the reverse way - EAPD-on means the internal
  * speaker output enabled _and_ mute-LED off.
  */
 
@@ -1373,6 +1375,21 @@ static int ad1981_hp_init(struct hda_cod
 	return 0;
 }
 
+/* configuration for Toshiba Laptops */
+static struct hda_verb ad1981_toshiba_init_verbs[] = {
+	{0x05, AC_VERB_SET_EAPD_BTLENABLE, 0x01 }, /* default on */
+	/* pin sensing on HP and Mic jacks */
+	{0x06, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | AD1981_HP_EVENT},
+	{0x08, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | AD1981_MIC_EVENT},
+	{}
+};
+
+static struct snd_kcontrol_new ad1981_toshiba_mixers[] = {
+	HDA_CODEC_VOLUME("Amp Volume", 0x1a, 0x0, HDA_OUTPUT),
+	HDA_CODEC_MUTE("Amp Switch", 0x1a, 0x0, HDA_OUTPUT),
+	{ }
+};
+
 /* configuration for Lenovo Thinkpad T60 */
 static struct snd_kcontrol_new ad1981_thinkpad_mixers[] = {
 	HDA_CODEC_VOLUME("Master Playback Volume", 0x05, 0x0, HDA_OUTPUT),
@@ -1418,6 +1435,7 @@ enum {
 	AD1981_BASIC,
 	AD1981_HP,
 	AD1981_THINKPAD,
+	AD1981_TOSHIBA,
 	AD1981_MODELS
 };
 
@@ -1425,6 +1443,7 @@ static const char *ad1981_models[AD1981_
 	[AD1981_HP]		= "hp",
 	[AD1981_THINKPAD]	= "thinkpad",
 	[AD1981_BASIC]		= "basic",
+	[AD1981_TOSHIBA]	= "toshiba"
 };
 
 static struct snd_pci_quirk ad1981_cfg_tbl[] = {
@@ -1435,6 +1454,7 @@ static struct snd_pci_quirk ad1981_cfg_t
 	/* Lenovo Thinkpad T60/X60/Z6xx */
 	SND_PCI_QUIRK(0x17aa, 0, "Lenovo Thinkpad", AD1981_THINKPAD),
 	SND_PCI_QUIRK(0x1014, 0x0597, "Lenovo Z60", AD1981_THINKPAD),
+	SND_PCI_QUIRK(0x1179, 0x0001, "Toshiba U205", AD1981_TOSHIBA),
 	{}
 };
 
@@ -1485,8 +1505,17 @@ static int patch_ad1981(struct hda_codec
 		spec->mixers[0] = ad1981_thinkpad_mixers;
 		spec->input_mux = &ad1981_thinkpad_capture_source;
 		break;
+	case AD1981_TOSHIBA:
+		spec->mixers[0] = ad1981_hp_mixers;
+		spec->mixers[1] = ad1981_toshiba_mixers;
+		spec->num_init_verbs = 2;
+		spec->init_verbs[1] = ad1981_toshiba_init_verbs;
+		spec->multiout.dig_out_nid = 0;
+		spec->input_mux = &ad1981_hp_capture_source;
+		codec->patch_ops.init = ad1981_hp_init;
+		codec->patch_ops.unsol_event = ad1981_hp_unsol_event;
+		break;
 	}
-
 	return 0;
 }
 
@@ -2609,6 +2638,7 @@ static const char *ad1988_models[AD1988_
 
 static struct snd_pci_quirk ad1988_cfg_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x81f6, "Asus M2N-SLI", AD1988_6STACK_DIG),
+	SND_PCI_QUIRK(0x1043, 0x81ec, "Asus P5B-DLX", AD1988_6STACK_DIG),
 	{}
 };
 

--=-H7Hh74oGPdF9V8R8CVyX
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-H7Hh74oGPdF9V8R8CVyX
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-H7Hh74oGPdF9V8R8CVyX--
