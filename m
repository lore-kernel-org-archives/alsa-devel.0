From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH2/2] hda: Add dynamic mono mixer support for
	STAC92xx codecs
Date: Wed, 23 Jan 2008 13:46:18 -0500
Message-ID: <47978B7A.5020006@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp107.biz.mail.re2.yahoo.com (smtp107.biz.mail.re2.yahoo.com
	[206.190.52.176]) by alsa0.perex.cz (Postfix) with SMTP id 8B58124584
	for <alsa-devel@alsa-project.org>; Wed, 23 Jan 2008 19:46:21 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Allows for dynamically creating mono out mixer controls and well as mono mux controls.

Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
---
diff -r 5492010913f0 pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Tue Jan 22 15:37:13 2008 +0100
+++ b/pci/hda/patch_sigmatel.c	Tue Jan 22 21:22:52 2008 -0500
@@ -756,7 +756,6 @@ static struct snd_kcontrol_new stac92hd7
 
 static struct snd_kcontrol_new stac92hd71bxx_analog_mixer[] = {
 	STAC_INPUT_SOURCE(2),
-	STAC_MONO_MUX,
 
 	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x0, 0x1c, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE_IDX("Capture Switch", 0x0, 0x1c, 0x0, HDA_OUTPUT),
@@ -768,15 +767,12 @@ static struct snd_kcontrol_new stac92hd7
 
 	HDA_CODEC_MUTE("Analog Loopback 1", 0x17, 0x3, HDA_INPUT),
 	HDA_CODEC_MUTE("Analog Loopback 2", 0x17, 0x4, HDA_INPUT),
-
-	HDA_CODEC_MUTE_MONO("Mono Playback Switch", 0x14, 0x1, 0, HDA_INPUT),
 	{ } /* end */
 };
 
 static struct snd_kcontrol_new stac92hd71bxx_mixer[] = {
 	STAC_INPUT_SOURCE(2),
 	STAC_ANALOG_LOOPBACK(0xFA0, 0x7A0, 2),
-	STAC_MONO_MUX,
 
 	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x0, 0x1c, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE_IDX("Capture Switch", 0x0, 0x1c, 0x0, HDA_OUTPUT),
@@ -785,8 +781,6 @@ static struct snd_kcontrol_new stac92hd7
 	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x1, 0x1d, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE_IDX("Capture Switch", 0x1, 0x1d, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME_IDX("Capture Mux Volume", 0x1, 0x1b, 0x0, HDA_OUTPUT),
-
-	HDA_CODEC_MUTE_MONO("Mono Playback Switch", 0x14, 0x1, 0, HDA_INPUT),
 	{ } /* end */
 };
 
@@ -1157,7 +1151,7 @@ static struct snd_pci_quirk stac9200_cfg
 
 static unsigned int ref925x_pin_configs[8] = {
 	0x40c003f0, 0x424503f2, 0x01813022, 0x02a19021,
-	0x90a70320, 0x02214210, 0x400003f1, 0x9033032e,
+	0x90a70320, 0x02214210, 0x01019020, 0x9033032e,
 };
 
 static unsigned int stac925x_MA6_pin_configs[8] = {
@@ -1561,7 +1555,7 @@ static struct snd_pci_quirk stac927x_cfg
 
 static unsigned int ref9205_pin_configs[12] = {
 	0x40000100, 0x40000100, 0x01016011, 0x01014010,
-	0x01813122, 0x01a19021, 0x40000100, 0x40000100,
+	0x01813122, 0x01a19021, 0x01019020, 0x40000100,
 	0x90a000f0, 0x90a000f0, 0x01441030, 0x01c41030
 };
 
@@ -2018,6 +2012,7 @@ enum {
 enum {
 	STAC_CTL_WIDGET_VOL,
 	STAC_CTL_WIDGET_MUTE,
+	STAC_CTL_WIDGET_MONO_MUX,
 	STAC_CTL_WIDGET_IO_SWITCH,
 	STAC_CTL_WIDGET_CLFE_SWITCH
 };
@@ -2025,6 +2020,7 @@ static struct snd_kcontrol_new stac92xx_
 static struct snd_kcontrol_new stac92xx_control_templates[] = {
 	HDA_CODEC_VOLUME(NULL, 0, 0, 0),
 	HDA_CODEC_MUTE(NULL, 0, 0, 0),
+	STAC_MONO_MUX,
 	STAC_CODEC_IO_SWITCH(NULL, 0),
 	STAC_CODEC_CLFE_SWITCH(NULL, 0),
 };
@@ -2388,7 +2384,9 @@ static int stac92xx_auto_create_mono_out
 		mono_mux->items[mono_mux->num_items].index = i;
 		mono_mux->num_items++;
 	}
-	return 0;
+
+	return stac92xx_add_control(spec, STAC_CTL_WIDGET_MONO_MUX,
+				"Mono Mux", spec->mono_nid);
 }
 
 /* labels for dmic mux inputs */
@@ -2569,6 +2567,50 @@ static int stac92xx_parse_auto_config(st
 		       sizeof(spec->autocfg.hp_pins));
 		spec->autocfg.line_outs = spec->autocfg.hp_outs;
 		hp_speaker_swap = 1;
+	}
+	if (spec->autocfg.mono_out_pin) {
+		int dir = (get_wcaps(codec, spec->autocfg.mono_out_pin)
+				& AC_WCAP_OUT_AMP) ? HDA_OUTPUT : HDA_INPUT;
+		u32 caps = query_amp_caps(codec,
+				spec->autocfg.mono_out_pin, dir);
+		hda_nid_t conn_list[1];
+
+		/* get the mixer node and then the mono mux if it exists */
+		if (snd_hda_get_connections(codec,
+				spec->autocfg.mono_out_pin, conn_list, 1) &&
+				snd_hda_get_connections(codec, conn_list[0],
+				conn_list, 1)) {
+
+				int wcaps = get_wcaps(codec, conn_list[0]);
+				int wid_type = (wcaps & AC_WCAP_TYPE)
+					>> AC_WCAP_TYPE_SHIFT;
+				/* LR swap check, some stac925x have a mux that
+ 				 * changes the DACs output path instead of the
+ 				 * mono-mux path.
+ 				 */
+				if (wid_type == AC_WID_AUD_SEL &&
+						!(wcaps & AC_WCAP_LR_SWAP))
+					spec->mono_nid = conn_list[0];
+		}
+		/* all mono outs have a least a mute/unmute switch */
+		err = stac92xx_add_control(spec, STAC_CTL_WIDGET_MUTE,
+			"Mono Playback Switch",
+			HDA_COMPOSE_AMP_VAL(spec->autocfg.mono_out_pin,
+					1, 0, dir));
+		if (err < 0)
+			return err;
+		/* check to see if there is volume support for the amp */
+		if ((caps & AC_AMPCAP_NUM_STEPS) >> AC_AMPCAP_NUM_STEPS_SHIFT) {
+			err = stac92xx_add_control(spec, STAC_CTL_WIDGET_VOL,
+				"Mono Playback Volume",
+				HDA_COMPOSE_AMP_VAL(spec->autocfg.mono_out_pin,
+					1, 0, dir));
+			if (err < 0)
+				return err;
+		}
+
+		stac92xx_auto_set_pinctl(codec, spec->autocfg.mono_out_pin,
+					 AC_PINCTL_OUT_EN);
 	}
 
 	if ((err = stac92xx_add_dyn_out_pins(codec, &spec->autocfg)) < 0)
@@ -3317,7 +3359,6 @@ again:
 
 	spec->gpio_mask = spec->gpio_data = 0x00000001; /* GPIO0 High = EAPD */
 
-	spec->mono_nid = 0x15;
 	spec->mux_nids = stac92hd71bxx_mux_nids;
 	spec->adc_nids = stac92hd71bxx_adc_nids;
 	spec->dmic_nids = stac92hd71bxx_dmic_nids;
