From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: 1.0.15rc3 patch_analog.s bug + fix
Date: Tue, 16 Oct 2007 10:39:55 +0300
Message-ID: <200710161039.55191.anarsoul@gmail.com>
References: <20071015025303.GA17664@jay.phy.queensu.ca>
	<s5hsl4c62fl.wl%tiwai@suse.de>
	<20071015203421.GA6047@jay.phy.queensu.ca>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_LrGFHGI+DHlFi8u"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from outbound.mailhop.org (outbound.mailhop.org [63.208.196.171])
	by alsa0.perex.cz (Postfix) with ESMTP id C83BE2449B
	for <alsa-devel@alsa-project.org>;
	Tue, 16 Oct 2007 09:39:58 +0200 (CEST)
Received: from [84.201.228.58] (helo=anarsoul)
	by outbound.mailhop.org with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68) (envelope-from <anarsoul@gmail.com>) id 1Ihh1w-0003cx-SD
	for alsa-devel@alsa-project.org; Tue, 16 Oct 2007 03:39:57 -0400
In-Reply-To: <20071015203421.GA6047@jay.phy.queensu.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_LrGFHGI+DHlFi8u
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 15 October 2007 23:34:21 Peter Skensved wrote:
> > Hmm, the code logic looks correct to me. =A0If HP jack is present, the
> > internal speaker should be muted. =A0Otherwise it follows the state of
> > HP jack (muted/unmuted, that acts as a master switch)

Code logic is broken.
Internal speakers muted while jack unplugged and unmuted while it's plugged.

See attached original patch.



--Boundary-00=_LrGFHGI+DHlFi8u
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="hdaintel-laptop-eapd-updated.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="hdaintel-laptop-eapd-updated.patch"

--- alsa-driver-1.0.14-orig/alsa-kernel/pci/hda/patch_analog.c	2007-06-04 02:28:53.000000000 +0000
+++ alsa-driver-1.0.14/alsa-kernel/pci/hda/patch_analog.c	2007-08-29 00:32:52.000000000 +0000
@@ -497,6 +497,7 @@
 /*
  * mixers
  */
+
 static struct snd_kcontrol_new ad1986a_mixers[] = {
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
@@ -628,18 +629,65 @@
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
 	long *valp = ucontrol->value.integer.value;
 	int change;
+	unsigned int present;
+
+	present = snd_hda_codec_read(codec, 0x1a, 0,
+				     AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
 
+	/* HP (0x1a) */
 	change = snd_hda_codec_amp_update(codec, 0x1a, 0, HDA_OUTPUT, 0,
 					  0x80, valp[0] ? 0 : 0x80);
 	change |= snd_hda_codec_amp_update(codec, 0x1a, 1, HDA_OUTPUT, 0,
 					   0x80, valp[1] ? 0 : 0x80);
+
+	/* Line-Out (0x1b) */
 	snd_hda_codec_amp_update(codec, 0x1b, 0, HDA_OUTPUT, 0,
-				 0x80, valp[0] ? 0 : 0x80);
+				 0x80, (valp[0] && present) ? 0 : 0x80);
 	snd_hda_codec_amp_update(codec, 0x1b, 1, HDA_OUTPUT, 0,
-				 0x80, valp[1] ? 0 : 0x80);
+				 0x80, (valp[1] && present) ? 0 : 0x80);
+
 	return change;
 }
 
+/* mute internal speakers if HP is plugged */
+static void ad1986a_laptop_eapd_automute(struct hda_codec *codec)
+{
+	unsigned int present, sw;
+
+	present = snd_hda_codec_read(codec, 0x1a, 0,
+				     AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
+
+	/*
+	 * TODO: get kcontrol value for "Master Playback Switch" and
+	 * enable Line-Out only if (present && sw), where sw means "unmute"
+	 *
+	 * Currently the Line-Out is unmuted when we unplug HP jack, even if we
+	 * asked to mute Master Volume.
+	 */
+	sw = 1;
+
+	/* Line-Out */
+	snd_hda_codec_amp_update(codec, 0x1b, 0, HDA_OUTPUT, 0,
+				 0x80, (present && sw) ? 0 : 0x80);
+	snd_hda_codec_amp_update(codec, 0x1b, 1, HDA_OUTPUT, 0,
+				 0x80, (present && sw) ? 0 : 0x80);
+}
+
+/* unsolicited event for HP jack sensing */
+static void ad1986a_laptop_eapd_unsol_event(struct hda_codec *codec,
+					    unsigned int res)
+{
+	ad1986a_laptop_eapd_automute(codec);
+}
+
+/* initialize jack-sensing, too */
+static int ad1986a_laptop_eapd_init(struct hda_codec *codec)
+{
+	ad198x_init(codec);
+	ad1986a_laptop_eapd_automute(codec);
+	return 0;
+}
+
 static struct hda_input_mux ad1986a_laptop_eapd_capture_source = {
 	.num_items = 3,
 	.items = {
@@ -749,6 +797,8 @@
 	{0x22, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x20 },
 	{0x23, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x20 },
 	{0x24, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x20 },
+	/* HP pin event */
+	{0x1a, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN},
 	{ } /* end */
 };
 
@@ -913,6 +963,10 @@
 		spec->multiout.dac_nids = ad1986a_laptop_dac_nids;
 		spec->multiout.dig_out_nid = 0;
 		spec->input_mux = &ad1986a_laptop_eapd_capture_source;
+
+		/* add some ad1986a specific operations */
+		codec->patch_ops.init = ad1986a_laptop_eapd_init;
+		codec->patch_ops.unsol_event = ad1986a_laptop_eapd_unsol_event;
 		break;
 	case AD1986A_ULTRA:
 		spec->mixers[0] = ad1986a_laptop_eapd_mixers;

--Boundary-00=_LrGFHGI+DHlFi8u
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_LrGFHGI+DHlFi8u--
