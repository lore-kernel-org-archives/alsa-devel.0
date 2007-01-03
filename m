From: Tobin Davis <tdavis@dsl-only.net>
Subject: hda-codec:  Add support for Samsung Q1 Ultra
Date: Tue, 02 Jan 2007 20:14:25 -0800
Message-ID: <1167797665.28242.22.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-3dSZXPyU9XoGPZo/YYpf"
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


--=-3dSZXPyU9XoGPZo/YYpf
Content-Type: multipart/alternative; boundary="=-mhjRjtoETPPkwnyqpO37"


--=-mhjRjtoETPPkwnyqpO37
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Summary:  hda-codec:  Add support for Samsung Q1 Ultra to AD1986A

        This adds support for the Samsung Q1 Ultra tablet pc.



Signed off by Tobin Davis <tdavis@dsl-only.net>

--=-mhjRjtoETPPkwnyqpO37
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.12.0">
</HEAD>
<BODY>
Summary:&nbsp; hda-codec:&nbsp; Add support for Samsung Q1 Ultra to AD1986A<BR>
<BLOCKQUOTE>
    This adds support for the Samsung Q1 Ultra tablet pc.<BR>
</BLOCKQUOTE>
<BR>
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

--=-mhjRjtoETPPkwnyqpO37--

--=-3dSZXPyU9XoGPZo/YYpf
Content-Disposition: attachment; filename=SamsungQ1.patch
Content-Type: text/x-patch; name=SamsungQ1.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r 9998aa91f5da pci/hda/patch_analog.c
--- a/pci/hda/patch_analog.c	Fri Dec 22 12:44:25 2006 +0100
+++ b/pci/hda/patch_analog.c	Tue Jan 02 19:39:16 2007 -0800
@@ -782,8 +782,19 @@ static struct hda_channel_mode ad1986a_m
 
 /* eapd initialization */
 static struct hda_verb ad1986a_eapd_init_verbs[] = {
-	{0x1b, AC_VERB_SET_EAPD_BTLENABLE, 0x00},
+	{0x1b, AC_VERB_SET_EAPD_BTLENABLE, 0x00 },
 	{}
+};
+
+/* Ultra initialization */
+static struct hda_verb ad1986a_ultra_init[] = {
+	/* eapd initialization */
+	{ 0x1b, AC_VERB_SET_EAPD_BTLENABLE, 0x00 },
+	/* CLFE -> Mic in */
+	{ 0x0f, AC_VERB_SET_CONNECT_SEL, 0x2 },
+	{ 0x1d, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x24 },
+	{ 0x1d, AC_VERB_SET_AMP_GAIN_MUTE, 0xb080 },
+	{ } /* end */
 };
 
 /* models */
@@ -792,6 +803,7 @@ enum {
 	AD1986A_3STACK,
 	AD1986A_LAPTOP,
 	AD1986A_LAPTOP_EAPD,
+	AD1986A_ULTRA,
 	AD1986A_MODELS
 };
 
@@ -800,6 +812,7 @@ static const char *ad1986a_models[AD1986
 	[AD1986A_3STACK]	= "3stack",
 	[AD1986A_LAPTOP]	= "laptop",
 	[AD1986A_LAPTOP_EAPD]	= "laptop-eapd",
+	[AD1986A_ULTRA]		= "ultra",
 };
 
 static struct snd_pci_quirk ad1986a_cfg_tbl[] = {
@@ -821,6 +834,8 @@ static struct snd_pci_quirk ad1986a_cfg_
 	SND_PCI_QUIRK(0x144d, 0xc023, "Samsung X60", AD1986A_LAPTOP_EAPD),
 	SND_PCI_QUIRK(0x144d, 0xc024, "Samsung R65", AD1986A_LAPTOP_EAPD),
 	SND_PCI_QUIRK(0x144d, 0xc026, "Samsung X11", AD1986A_LAPTOP_EAPD),
+	SND_PCI_QUIRK(0x144d, 0xc504, "Samsung Q35", AD1986A_3STACK),
+	SND_PCI_QUIRK(0x144d, 0xc027, "Samsung Q1", AD1986A_ULTRA),
 	SND_PCI_QUIRK(0x17aa, 0x1017, "Lenovo A60", AD1986A_3STACK),
 	SND_PCI_QUIRK(0x17aa, 0x2066, "Lenovo N100", AD1986A_LAPTOP_EAPD),
 	SND_PCI_QUIRK(0x17c0, 0x2017, "Samsung M50", AD1986A_LAPTOP),
@@ -886,6 +901,15 @@ static int patch_ad1986a(struct hda_code
 		spec->multiout.dac_nids = ad1986a_laptop_dac_nids;
 		spec->multiout.dig_out_nid = 0;
 		spec->input_mux = &ad1986a_laptop_eapd_capture_source;
+		break;
+	case AD1986A_ULTRA:
+		spec->mixers[0] = ad1986a_laptop_eapd_mixers;
+		spec->num_init_verbs = 2;
+		spec->init_verbs[1] = ad1986a_ultra_init;
+		spec->multiout.max_channels = 2;
+		spec->multiout.num_dacs = 1;
+		spec->multiout.dac_nids = ad1986a_laptop_dac_nids;
+		spec->multiout.dig_out_nid = 0;
 		break;
 	}
 

--=-3dSZXPyU9XoGPZo/YYpf
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-3dSZXPyU9XoGPZo/YYpf
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-3dSZXPyU9XoGPZo/YYpf--
