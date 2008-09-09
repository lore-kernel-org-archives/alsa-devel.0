From: Harald Welte <HaraldWelte@viatech.com>
Subject: [PATCH 5/7] HDA patch_via.c: Mute on headphone plug-in
Date: Tue, 9 Sep 2008 15:57:32 +0800
Message-ID: <20080909075732.GH9638@prithivi.gnumonks.org>
References: <20080909073717.GC9638@prithivi.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id BCAF310383F
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Sep 2008 10:02:43 +0200 (CEST)
Received: from uucp by ganesha.gnumonks.org with local-bsmtp (Exim 4.63)
	(envelope-from <HaraldWelte@viatech.com>) id 1KcyBP-0007uj-Ci
	for alsa-devel@alsa-project.org; Tue, 09 Sep 2008 10:02:43 +0200
Received: from laforge by prithivi.gnumonks.org with local (Exim 4.69)
	(envelope-from <HaraldWelte@viatech.com>) id 1Kcy6O-0004z3-Oj
	for alsa-devel@alsa-project.org; Tue, 09 Sep 2008 15:57:32 +0800
Content-Disposition: inline
In-Reply-To: <20080909073717.GC9638@prithivi.gnumonks.org>
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

[ALSA] HDA VIA: Automatically mute front speaker on headphone plug-in

Signed-off-by: Harald Welte <HaraldWelte@viatech.com>

Index: linux-2.6/sound/pci/hda/patch_via.c
===================================================================
--- linux-2.6.orig/sound/pci/hda/patch_via.c
+++ linux-2.6/sound/pci/hda/patch_via.c
@@ -32,6 +32,7 @@
 /* 2007-11-14  Lydia Wang  Add VT1708A codec HP and CD pin connect config    */
 /* 2008-02-03  Lydia Wang  Fix Rear channels and Back channels inverse issue */
 /* 2008-03-06  Lydia Wang  Add VT1702 codec and VT1708S codec support        */
+/* 2008-04-09  Lydia Wang  Add mute front speaker when HP plugin             */
 /*                                                                           */
 /* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
 
@@ -83,6 +84,9 @@
 #define IS_VT1708S_VENDORID(x)		((x) >= 0x11060397 && (x) <= 0x11067397)
 #define IS_VT1702_VENDORID(x)		((x) >= 0x11060398 && (x) <= 0x11067398)
 
+#define VIA_HP_EVENT		0x01
+#define VIA_GPIO_EVENT		0x02
+
 enum {
 	VIA_CTL_WIDGET_VOL,
 	VIA_CTL_WIDGET_MUTE,
@@ -106,7 +110,8 @@
 	struct snd_kcontrol_new *mixers[3];
 	unsigned int num_mixers;
 
-	struct hda_verb *init_verbs;
+	struct hda_verb *init_verbs[5];
+	unsigned int num_iverbs;
 
 	char *stream_name_analog;
 	struct hda_pcm_stream *stream_analog_playback;
@@ -606,10 +611,85 @@
 	kfree(codec->spec);
 }
 
+/* mute internal speaker if HP is plugged */
+static void via_hp_automute(struct hda_codec *codec)
+{
+	unsigned int present;
+	struct via_spec *spec = codec->spec;
+
+	present = snd_hda_codec_read(codec, spec->autocfg.hp_pins[0], 0,
+				     AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
+	snd_hda_codec_amp_stereo(codec, spec->autocfg.line_out_pins[0],
+				 HDA_OUTPUT, 0, HDA_AMP_MUTE,
+				 present ? HDA_AMP_MUTE : 0);
+}
+
+static void via_gpio_control(struct hda_codec *codec)
+{
+	unsigned int gpio_data;
+	unsigned int vol_counter;
+	unsigned int vol;
+	unsigned int master_vol;
+
+	struct via_spec *spec = codec->spec;
+
+	gpio_data = snd_hda_codec_read(codec, codec->afg, 0,
+				       AC_VERB_GET_GPIO_DATA, 0) & 0x03;
+
+	vol_counter = (snd_hda_codec_read(codec, codec->afg, 0,
+					  0xF84, 0) & 0x3F0000) >> 16;
+
+	vol = vol_counter & 0x1F;
+	master_vol = snd_hda_codec_read(codec, 0x1A, 0,
+					AC_VERB_GET_AMP_GAIN_MUTE,
+					AC_AMP_GET_INPUT);
+
+	if (gpio_data == 0x02) {
+		/* unmute line out */
+		snd_hda_codec_amp_stereo(codec, spec->autocfg.line_out_pins[0],
+					 HDA_OUTPUT, 0, HDA_AMP_MUTE, 0);
+
+		if (vol_counter & 0x20) {
+			/* decrease volume */
+			if (vol > master_vol)
+				vol = master_vol;
+			snd_hda_codec_amp_stereo(codec, 0x1A, HDA_INPUT,
+						 0, HDA_AMP_VOLMASK,
+						 master_vol-vol);
+		} else {
+			/* increase volume */
+			snd_hda_codec_amp_stereo(codec, 0x1A, HDA_INPUT, 0,
+					 HDA_AMP_VOLMASK,
+					 ((master_vol+vol) > 0x2A) ? 0x2A :
+					  (master_vol+vol));
+		}
+	} else if (!(gpio_data & 0x02)) {
+		/* mute line out */
+		snd_hda_codec_amp_stereo(codec,
+					 spec->autocfg.line_out_pins[0],
+					 HDA_OUTPUT, 0, HDA_AMP_MUTE,
+					 HDA_AMP_MUTE);
+	}
+}
+
+/* unsolicited event for jack sensing */
+static void via_unsol_event(struct hda_codec *codec,
+				  unsigned int res)
+{
+	res >>= 26;
+	if (res == VIA_HP_EVENT)
+		via_hp_automute(codec);
+	else if (res == VIA_GPIO_EVENT)
+		via_gpio_control(codec);
+}
+
 static int via_init(struct hda_codec *codec)
 {
 	struct via_spec *spec = codec->spec;
-	snd_hda_sequence_write(codec, spec->init_verbs);
+	int i;
+	for (i = 0; i < spec->num_iverbs; i++)
+		snd_hda_sequence_write(codec, spec->init_verbs[i]);
+
 	/* Lydia Add for EAPD enable */
 	if (!spec->dig_in_nid) { /* No Digital In connection */
 		if (IS_VT1708_VENDORID(codec->vendor_id)) {
@@ -925,7 +1005,7 @@
 	if (spec->kctl_alloc)
 		spec->mixers[spec->num_mixers++] = spec->kctl_alloc;
 
-	spec->init_verbs = vt1708_volume_init_verbs;	
+	spec->init_verbs[spec->num_iverbs++] = vt1708_volume_init_verbs;
 
 	spec->input_mux = &spec->private_imux;
 
@@ -1018,6 +1098,11 @@
 	{ } /* end */
 };
 
+static struct hda_verb vt1709_uniwill_init_verbs[] = {
+	{0x20, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | VIA_HP_EVENT},
+	{ }
+};
+
 /*
  * generic initialization of ADC, input mixers and output mixers
  */
@@ -1427,7 +1512,8 @@
 		       "Using genenic mode...\n");
 	}
 
-	spec->init_verbs = vt1709_10ch_volume_init_verbs;	
+	spec->init_verbs[spec->num_iverbs++] = vt1709_10ch_volume_init_verbs;
+	spec->init_verbs[spec->num_iverbs++] = vt1709_uniwill_init_verbs;
 
 	spec->stream_name_analog = "VT1709 Analog";
 	spec->stream_analog_playback = &vt1709_10ch_pcm_analog_playback;
@@ -1448,6 +1534,7 @@
 	codec->patch_ops = via_patch_ops;
 
 	codec->patch_ops.init = via_auto_init;
+	codec->patch_ops.unsol_event = via_unsol_event;
 #ifdef CONFIG_SND_HDA_POWER_SAVE
 	spec->loopback.amplist = vt1709_loopbacks;
 #endif
@@ -1518,7 +1605,8 @@
 		       "Using genenic mode...\n");
 	}
 
-	spec->init_verbs = vt1709_6ch_volume_init_verbs;	
+	spec->init_verbs[spec->num_iverbs++] = vt1709_6ch_volume_init_verbs;
+	spec->init_verbs[spec->num_iverbs++] = vt1709_uniwill_init_verbs;
 
 	spec->stream_name_analog = "VT1709 Analog";
 	spec->stream_analog_playback = &vt1709_6ch_pcm_analog_playback;
@@ -1539,6 +1627,7 @@
 	codec->patch_ops = via_patch_ops;
 
 	codec->patch_ops.init = via_auto_init;
+	codec->patch_ops.unsol_event = via_unsol_event;
 #ifdef CONFIG_SND_HDA_POWER_SAVE
 	spec->loopback.amplist = vt1709_loopbacks;
 #endif
@@ -1639,6 +1728,11 @@
 	{ }
 };
 
+static struct hda_verb vt1708B_uniwill_init_verbs[] = {
+	{0x1D, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | VIA_HP_EVENT},
+	{ }
+};
+
 static struct hda_pcm_stream vt1708B_8ch_pcm_analog_playback = {
 	.substreams = 1,
 	.channels_min = 2,
@@ -1959,7 +2053,8 @@
 		       "from BIOS.  Using genenic mode...\n");
 	}
 
-	spec->init_verbs = vt1708B_8ch_volume_init_verbs;
+	spec->init_verbs[spec->num_iverbs++] = vt1708B_8ch_volume_init_verbs;
+	spec->init_verbs[spec->num_iverbs++] = vt1708B_uniwill_init_verbs;
 
 	spec->stream_name_analog = "VT1708B Analog";
 	spec->stream_analog_playback = &vt1708B_8ch_pcm_analog_playback;
@@ -1979,6 +2074,7 @@
 	codec->patch_ops = via_patch_ops;
 
 	codec->patch_ops.init = via_auto_init;
+	codec->patch_ops.unsol_event = via_unsol_event;
 #ifdef CONFIG_SND_HDA_POWER_SAVE
 	spec->loopback.amplist = vt1708B_loopbacks;
 #endif
@@ -2008,7 +2104,8 @@
 		       "from BIOS.  Using genenic mode...\n");
 	}
 
-	spec->init_verbs = vt1708B_4ch_volume_init_verbs;
+	spec->init_verbs[spec->num_iverbs++] = vt1708B_4ch_volume_init_verbs;
+	spec->init_verbs[spec->num_iverbs++] = vt1708B_uniwill_init_verbs;
 
 	spec->stream_name_analog = "VT1708B Analog";
 	spec->stream_analog_playback = &vt1708B_4ch_pcm_analog_playback;
@@ -2028,6 +2125,7 @@
 	codec->patch_ops = via_patch_ops;
 
 	codec->patch_ops.init = via_auto_init;
+	codec->patch_ops.unsol_event = via_unsol_event;
 #ifdef CONFIG_SND_HDA_POWER_SAVE
 	spec->loopback.amplist = vt1708B_loopbacks;
 #endif
@@ -2082,6 +2180,11 @@
 	{ }
 };
 
+static struct hda_verb vt1708S_uniwill_init_verbs[] = {
+	{0x1D, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | VIA_HP_EVENT},
+	{ }
+};
+
 static struct hda_pcm_stream vt1708S_pcm_analog_playback = {
 	.substreams = 2,
 	.channels_min = 2,
@@ -2391,7 +2494,8 @@
 		       "from BIOS.  Using genenic mode...\n");
 	}
 
-	spec->init_verbs = vt1708S_volume_init_verbs;
+	spec->init_verbs[spec->num_iverbs++] = vt1708S_volume_init_verbs;
+	spec->init_verbs[spec->num_iverbs++] = vt1708S_uniwill_init_verbs;
 
 	spec->stream_name_analog = "VT1708S Analog";
 	spec->stream_analog_playback = &vt1708S_pcm_analog_playback;
@@ -2410,7 +2514,7 @@
 	codec->patch_ops = via_patch_ops;
 
 	codec->patch_ops.init = via_auto_init;
-
+	codec->patch_ops.unsol_event = via_unsol_event;
 #ifdef CONFIG_SND_HDA_POWER_SAVE
 	spec->loopback.amplist = vt1708S_loopbacks;
 #endif
@@ -2473,6 +2577,12 @@
 	{ }
 };
 
+static struct hda_verb vt1702_uniwill_init_verbs[] = {
+	{0x01, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | VIA_GPIO_EVENT},
+	{0x17, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | VIA_HP_EVENT},
+	{ }
+};
+
 static struct hda_pcm_stream vt1702_pcm_analog_playback = {
 	.substreams = 1,
 	.channels_min = 2,
@@ -2699,7 +2809,8 @@
 		       "from BIOS.  Using genenic mode...\n");
 	}
 
-	spec->init_verbs = vt1702_volume_init_verbs;
+	spec->init_verbs[spec->num_iverbs++] = vt1702_volume_init_verbs;
+	spec->init_verbs[spec->num_iverbs++] = vt1702_uniwill_init_verbs;
 
 	spec->stream_name_analog = "VT1702 Analog";
 	spec->stream_analog_playback = &vt1702_pcm_analog_playback;
@@ -2718,7 +2829,7 @@
 	codec->patch_ops = via_patch_ops;
 
 	codec->patch_ops.init = via_auto_init;
-
+	codec->patch_ops.unsol_event = via_unsol_event;
 #ifdef CONFIG_SND_HDA_POWER_SAVE
 	spec->loopback.amplist = vt1702_loopbacks;
 #endif
-- 
- Harald Welte <HaraldWelte@viatech.com>	    http://linux.via.com.tw/
============================================================================
VIA Open Source Liaison
