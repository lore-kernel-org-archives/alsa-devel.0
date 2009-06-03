From: Hector Martin <hector@marcansoft.com>
Subject: [PATCH] More Aspire 8930G fixes
Date: Wed, 03 Jun 2009 23:50:02 +0200
Message-ID: <4A26F00A.6040709@marcansoft.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000707060501080602080100"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.marcansoft.com (marcansoft.com [80.68.93.119])
	by alsa0.perex.cz (Postfix) with ESMTP id 2CD4F1038C3
	for <alsa-devel@alsa-project.org>;
	Wed,  3 Jun 2009 23:50:09 +0200 (CEST)
Received: from [192.168.3.171] (49.Red-88-25-157.staticIP.rima-tde.net
	[88.25.157.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.marcansoft.com (Postfix) with ESMTPSA id 872C6A8001
	for <alsa-devel@alsa-project.org>;
	Wed,  3 Jun 2009 23:50:04 +0200 (CEST)
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

This is a multi-part message in MIME format.
--------------000707060501080602080100
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Enable all three capture channels, including the missing nid 7 which is
the only one capable of capturing DMIC input

Enable Headphone amp for the HP jack. This causes a volume boost for
headphones, but does not cause any noticeable effect for light loads
like other amps, so there is no need to make it configurable.

Add Input Mix capture mux setting to capture the output of the playback
input mux (that is, what goes out the speakers except for PCM)

Hack another coef register because the stereo DMIC for some reason
produces a nonstandard sum/difference signal. I found a bit to make it
just use the sum signal for both channels, which makes it behave like a
standard mono microphone. The stereo is useless anyway (they're 1cm apart).

Tested working: Three capture channels, mic in, line in, DMIC.

Tested not working: CD. Not sure why, might be unconnected in the actual
hardware or a CD drive issue.

Also looked at SPDIF. It appears to work (emitter lights up inside the
HP out jack) but I lack a proper miniTOSLINK cable to test it.

-- 
Hector Martin (hector@marcansoft.com)
Public Key: http://www.marcansoft.com/marcan.asc


--------------000707060501080602080100
Content-Type: text/plain;
 name="alsa-more-aspire-8930g.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-more-aspire-8930g.patch"

Signed-off-by: Hector Martin <hector@marcansoft.com>
--- alsa-driver-1.0.20.10.g955ee.233.gf65b3/sound/pci/hda/patch_realtek.c.orig	2009-06-03 23:17:55.000000000 +0200
+++ alsa-driver-1.0.20.10.g955ee.233.gf65b3/sound/pci/hda/patch_realtek.c	2009-06-03 23:45:40.000000000 +0200
@@ -1469,10 +1469,10 @@
 };
 
 /*
- * ALC888 Acer Aspire 8930G model
+ * ALC889 Acer Aspire 8930G model
  */
 
-static struct hda_verb alc888_acer_aspire_8930g_verbs[] = {
+static struct hda_verb alc889_acer_aspire_8930g_verbs[] = {
 /* Front Mic: set to PIN_IN (empty by default) */
 	{0x12, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN},
 /* Unselect Front Mic by default in input mixer 3 */
@@ -1492,7 +1492,7 @@
 	{0x16, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
 	{0x16, AC_VERB_SET_CONNECT_SEL, 0x02},
 /* Connect HP out to Front */
-	{0x15, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
+	{0x15, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT | PIN_HP},
 	{0x15, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
 	{0x15, AC_VERB_SET_CONNECT_SEL, 0x00},
 /* Enable all DACs */
@@ -1507,6 +1507,17 @@
 /* Enable amplifiers */
 	{0x14, AC_VERB_SET_EAPD_BTLENABLE, 0x02},
 	{0x15, AC_VERB_SET_EAPD_BTLENABLE, 0x02},
+/* DMIC fix
+ * This laptop has a stereo digital microphone. The mics are only 1cm apart
+ * which makes the stereo useless. However, either the mic or the ALC889
+ * makes the signal become a difference/sum signal instead of standard
+ * stereo, which is annoying. So instead we flip this bit which makes the
+ * codec replicate the sum signal to both channels, turning it into a
+ * normal mono mic.
+ */
+/*  DMIC_CONTROL? Init value = 0x0001 */
+	{0x20, AC_VERB_SET_COEF_INDEX, 0x0b},
+	{0x20, AC_VERB_SET_PROC_COEF, 0x0003},
 	{ }
 };
 
@@ -1531,6 +1542,38 @@
 	}
 };
 
+static struct hda_input_mux alc889_capture_sources[3] = {
+	/* Digital mic only available on first "ADC" */
+	{
+		.num_items = 5,
+		.items = {
+			{ "Mic", 0x0 },
+			{ "Line", 0x2 },
+			{ "CD", 0x4 },
+			{ "Front Mic", 0xb },
+			{ "Input Mix", 0xa },
+		},
+	},
+	{
+		.num_items = 4,
+		.items = {
+			{ "Mic", 0x0 },
+			{ "Line", 0x2 },
+			{ "CD", 0x4 },
+			{ "Input Mix", 0xa },
+		},
+	},
+	{
+		.num_items = 4,
+		.items = {
+			{ "Mic", 0x0 },
+			{ "Line", 0x2 },
+			{ "CD", 0x4 },
+			{ "Input Mix", 0xa },
+		},
+	}
+};
+
 static struct snd_kcontrol_new alc888_base_mixer[] = {
 	HDA_CODEC_VOLUME("Front Playback Volume", 0x0c, 0x0, HDA_OUTPUT),
 	HDA_BIND_MUTE("Front Playback Switch", 0x0c, 2, HDA_INPUT),
@@ -1562,7 +1605,7 @@
 	alc_automute_amp(codec);
 }
 
-static void alc888_acer_aspire_8930g_init_hook(struct hda_codec *codec)
+static void alc889_acer_aspire_8930g_init_hook(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
 
@@ -9081,22 +9124,22 @@
 		.mixers = { alc888_base_mixer,
 				alc883_chmode_mixer },
 		.init_verbs = { alc883_init_verbs, alc880_gpio1_init_verbs,
-				alc888_acer_aspire_8930g_verbs },
+				alc889_acer_aspire_8930g_verbs },
 		.num_dacs = ARRAY_SIZE(alc883_dac_nids),
 		.dac_nids = alc883_dac_nids,
-		.num_adc_nids = ARRAY_SIZE(alc883_adc_nids_rev),
-		.adc_nids = alc883_adc_nids_rev,
-		.capsrc_nids = alc883_capsrc_nids_rev,
+		.num_adc_nids = ARRAY_SIZE(alc889_adc_nids),
+		.adc_nids = alc889_adc_nids,
+		.capsrc_nids = alc889_capsrc_nids,
 		.dig_out_nid = ALC883_DIGOUT_NID,
 		.num_channel_mode = ARRAY_SIZE(alc883_3ST_6ch_modes),
 		.channel_mode = alc883_3ST_6ch_modes,
 		.need_dac_fix = 1,
 		.const_channel_count = 6,
 		.num_mux_defs =
-			ARRAY_SIZE(alc888_2_capture_sources),
-		.input_mux = alc888_2_capture_sources,
+			ARRAY_SIZE(alc889_capture_sources),
+		.input_mux = alc889_capture_sources,
 		.unsol_event = alc_automute_amp_unsol_event,
-		.init_hook = alc888_acer_aspire_8930g_init_hook,
+		.init_hook = alc889_acer_aspire_8930g_init_hook,
 	},
 	[ALC883_MEDION] = {
 		.mixers = { alc883_fivestack_mixer,

--------------000707060501080602080100
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------000707060501080602080100--
