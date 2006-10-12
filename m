From: Tobin Davis <tdavis@dsl-only.net>
Subject: Patch:  Add support for Medion laptops.
Date: Thu, 12 Oct 2006 12:27:49 -0700
Message-ID: <1160681269.5520.7.camel@razman>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-khClkMa9SSxagYD3ZAEC"
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-khClkMa9SSxagYD3ZAEC
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Summary:  Add support for Medion laptops

Description:
        This patch adds audio support for Medion's line of laptops,
        based on code shipped with the laptops.  Microphone support is
        still being explored.
        
Signed off by: 
-- 
Tobin Davis <tdavis@dsl-only.net>

--=-khClkMa9SSxagYD3ZAEC
Content-Disposition: attachment; filename=medion.patch
Content-Type: text/x-patch; name=medion.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- alsa-driver/alsa-kernel/pci/hda/patch_realtek.c.orig	2006-10-08 10:58:28.000000000 -0700
+++ alsa-driver/alsa-kernel/pci/hda/patch_realtek.c	2006-10-11 11:03:13.000000000 -0700
@@ -112,6 +112,7 @@
 	ALC883_6ST_DIG,
 	ALC888_DEMO_BOARD,
 	ALC883_ACER,
+	ALC883_MEDION,
 	ALC883_AUTO,
 	ALC883_MODEL_LAST,
 };
@@ -4309,7 +4310,7 @@
 static struct hda_verb alc882_eapd_verbs[] = {
 	/* change to EAPD mode */
 	{0x20, AC_VERB_SET_COEF_INDEX, 0x07},
-	{0x20, AC_VERB_SET_PROC_COEF, 0x3060},
+	{0x20, AC_VERB_SET_PROC_COEF, 0x3070},
 	{ } 
 };
 
@@ -4875,6 +4876,41 @@
 	{ } /* end */
 };
 
+static snd_kcontrol_new_t alc883_fivestack_mixer[] = {
+	HDA_CODEC_VOLUME("Front Playback Volume", 0x0c, 0x0, HDA_OUTPUT),
+	HDA_CODEC_MUTE("Front Playback Switch", 0x14, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("Surround Playback Volume", 0x0d, 0x0, HDA_OUTPUT),
+	HDA_CODEC_MUTE("Surround Playback Switch", 0x15, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME_MONO("Center Playback Volume", 0x0e, 1, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME_MONO("LFE Playback Volume", 0x0e, 2, 0x0, HDA_OUTPUT),
+	HDA_CODEC_MUTE_MONO("Center Playback Switch", 0x16, 1, 0x0, HDA_OUTPUT),
+	HDA_CODEC_MUTE_MONO("LFE Playback Switch", 0x16, 2, 0x0, HDA_OUTPUT),
+	HDA_CODEC_MUTE("Headphone Playback Switch", 0x1b, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("CD Playback Volume", 0x0b, 0x04, HDA_INPUT),
+	HDA_CODEC_MUTE("CD Playback Switch", 0x0b, 0x04, HDA_INPUT),
+	HDA_CODEC_VOLUME("Line Playback Volume", 0x0b, 0x02, HDA_INPUT),
+	HDA_CODEC_MUTE("Line Playback Switch", 0x0b, 0x02, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
+	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Front Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
+	HDA_CODEC_MUTE("Front Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
+	HDA_CODEC_VOLUME("PC Speaker Playback Volume", 0x0b, 0x05, HDA_INPUT),
+	HDA_CODEC_MUTE("PC Speaker Playback Switch", 0x0b, 0x05, HDA_INPUT),
+	HDA_CODEC_VOLUME("Capture Volume", 0x08, 0x0, HDA_INPUT),
+	HDA_CODEC_MUTE("Capture Switch", 0x08, 0x0, HDA_INPUT),
+
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		/* .name = "Capture Source", */
+		.name = "Input Source",
+		.count = 1,
+		.info = alc883_mux_enum_info,
+		.get = alc883_mux_enum_get,
+		.put = alc883_mux_enum_put,
+	},
+	{ } /* end */
+};
+
 static struct snd_kcontrol_new alc883_chmode_mixer[] = {
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
@@ -5080,6 +5116,8 @@
 	  .config = ALC883_ACER },
 	{ .pci_subvendor = 0x1025, .pci_subdevice = 0x009f,
 	  .config = ALC883_ACER },
+	{ .pci_subvendor = 0x161f, .pci_subdevice = 0x2054,
+	  .modelname = "medion", .config = ALC883_MEDION }
 	{ .modelname = "auto", .config = ALC883_AUTO },
 	{}
 };
@@ -5167,6 +5205,20 @@
 		.channel_mode = alc883_3ST_2ch_modes,
 		.input_mux = &alc883_capture_source,
 	},
+	[ALC883_MEDION] = {
+		.mixers = { alc883_fivestack_mixer,
+			    alc883_chmode_mixer },
+		.init_verbs = { alc883_init_verbs,
+				alc882_eapd_verbs },
+		.num_dacs = ARRAY_SIZE(alc883_dac_nids),
+		.dac_nids = alc883_dac_nids,
+		.num_adc_nids = ARRAY_SIZE(alc883_adc_nids),
+		.adc_nids = alc883_adc_nids,
+		.num_channel_mode = ARRAY_SIZE(alc883_sixstack_modes),
+		.channel_mode = alc883_sixstack_modes,
+		.input_mux = &alc883_capture_source,
+	}
+
 };
 
 

--=-khClkMa9SSxagYD3ZAEC
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--=-khClkMa9SSxagYD3ZAEC
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-khClkMa9SSxagYD3ZAEC--
