From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: [Hda-intel] Toshiba U205 / HP nx6320 whitepaper
Date: Sat, 21 Oct 2006 12:00:09 -0700
Message-ID: <1161457209.26400.60.camel@razman>
References: <6aca78dd0610210942j6eb530e7xb5bd635d8b0d920b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-m4B4OfF5JetldZgiztQr"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <6aca78dd0610210942j6eb530e7xb5bd635d8b0d920b@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Ali Shah <caffein@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-m4B4OfF5JetldZgiztQr
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Here's a wild guess.  The HP patch code implies that the eapd bit
function is reversed.  This patch should change that behavior to logical
norm.  Test it with "model=toshiba" and let me know if there is any
improvement.  If it works, I'll add your device id and submit an
official patch.

Also, post the output from "lspci -s 0:1b -vn", as this will give us the
proper sub-vendor and sub-device id's for the driver.

Tobin

On Sat, 2006-10-21 at 12:42 -0400, Ali Shah wrote:
> Hey guys, 
> I am new to alsa development and I am in the midst of trying to debug
> the sound on my Toshiba Satellite u205 (no sound of the speakers, very
> very quiet sound of the headphone jack- it is an AD1981 chipset). My
> initial assumption is that the internal amplifier is not kicking in to
> boost the sound. So I have been reading the source code for the HP
> nx6320 patch to understand ALSA better and I was wondering if anyone
> would know if I could find the whitepaper for the chipset that the
> nx6320 uses (so i can figure out why certain structures are coded the
> way they are). 
> So far I have tried to define new volume and mute definitions in the
> snd_kcontrol_new ad1981_mixers[] ranging from 0x00 to 0x15 to "guess
> and check" if i can some how raise the volume or unmute the amplifier
> out. However there is something wrong with this approach that is not
> working and I am not familiar with alsa enough to figure out why :). 
> Attached is the results of #cat /proc/asound/card0/codec#0 for my
> codec, if anyone has any hints as to how to proceed please let me
> know!
> Ali
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________ Alsa-devel mailing list Alsa-devel@lists.sourceforge.net https://lists.sourceforge.net/lists/listinfo/alsa-devel
-- 
Tobin Davis <tdavis@dsl-only.net>

--=-m4B4OfF5JetldZgiztQr
Content-Disposition: attachment; filename=toshiba-analog-test1.patch
Content-Type: text/x-patch; name=toshiba-analog-test1.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff -r d7fe584f7395 pci/hda/patch_analog.c
--- a/pci/hda/patch_analog.c	Thu Oct 19 20:35:56 2006 +0200
+++ b/pci/hda/patch_analog.c	Sat Oct 21 11:29:12 2006 -0700
@@ -1346,6 +1346,15 @@ static int ad1981_hp_init(struct hda_cod
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
 /* configuration for Lenovo Thinkpad T60 */
 static struct snd_kcontrol_new ad1981_thinkpad_mixers[] = {
 	HDA_CODEC_VOLUME("Master Playback Volume", 0x05, 0x0, HDA_OUTPUT),
@@ -1386,12 +1395,17 @@ static struct hda_input_mux ad1981_think
 	},
 };
 
-/* models */
-enum { AD1981_BASIC, AD1981_HP, AD1981_THINKPAD };
+/* AD1981 models */
+enum {  AD1981_BASIC,
+	AD1981_HP,
+	AD1981_THINKPAD,
+	AD1981_TOSHIBA };
 
 static struct hda_board_config ad1981_cfg_tbl[] = {
+	/* Basic AD1981 Configuration */
+	{ .modelname = "basic", .config = AD1981_BASIC },
+	/* All HP models */
 	{ .modelname = "hp", .config = AD1981_HP },
-	/* All HP models */
 	{ .pci_subvendor = 0x103c, .config = AD1981_HP },
 	{ .pci_subvendor = 0x30b0, .pci_subdevice = 0x103c,
 	  .config = AD1981_HP }, /* HP nx6320 (reversed SSID, H/W bug) */
@@ -1400,7 +1414,8 @@ static struct hda_board_config ad1981_cf
 	{ .pci_subvendor = 0x17aa, .config = AD1981_THINKPAD },
 	{ .pci_subvendor = 0x1014, .pci_subdevice = 0x0597,
 	  .config = AD1981_THINKPAD }, /* Z60m/t */
-	{ .modelname = "basic", .config = AD1981_BASIC },
+	/* Toshiba Laptops */
+	{ .modelname="toshiba", .config = AD1981_TOSHIBA },
 	{}
 };
 
@@ -1449,8 +1464,16 @@ static int patch_ad1981(struct hda_codec
 		spec->mixers[0] = ad1981_thinkpad_mixers;
 		spec->input_mux = &ad1981_thinkpad_capture_source;
 		break;
+	case AD1981_TOSHIBA:
+		spec->mixers[0] = ad1981_hp_mixers;
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
 

--=-m4B4OfF5JetldZgiztQr
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--=-m4B4OfF5JetldZgiztQr
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-m4B4OfF5JetldZgiztQr--
