From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: Advanced power management for codecs.
Date: Mon, 07 Jan 2008 11:44:08 -0500
Message-ID: <478256D8.1050007@embeddedalley.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070706050107060601070403"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp101.biz.mail.mud.yahoo.com (smtp101.biz.mail.mud.yahoo.com
	[68.142.200.236]) by alsa0.perex.cz (Postfix) with SMTP id 21C8224946
	for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2008 17:44:06 +0100 (CET)
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

This is a multi-part message in MIME format.
--------------070706050107060601070403
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Added support for advanced power management features in new IDT codecs. 
Inactive ADCs and DACs are changed to D3 mode when not in playback or 
capture, also inactive line-out/headphone ports are disabled when jack 
detect does not sense a connection.
---
Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>

--------------070706050107060601070403
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
 name="stac92hd7xxx_power_save.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="stac92hd7xxx_power_save.patch"

diff -r 5b03c0176aa5 pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Mon Jan 07 13:33:45 2008 +0100
+++ b/pci/hda/patch_sigmatel.c	Mon Jan 07 11:22:56 2008 -0500
@@ -160,6 +160,7 @@ struct sigmatel_spec {
 
 	/* i/o switches */
 	unsigned int io_switch[2];
+	unsigned int io_state[2];
 	unsigned int clfe_swap;
 	unsigned int aloopback;
 
@@ -438,6 +439,52 @@ static int stac92xx_aloopback_put(struct
 		kcontrol->private_value >> 16, dac_mode);
 
 	return 1;
+}
+
+static int is_in_dac_nids(struct sigmatel_spec *spec, hda_nid_t nid)
+{
+	int i;
+
+	for (i = 0; i < spec->multiout.num_dacs; i++) {
+		if (spec->multiout.dac_nids[i] == nid)
+			return 1;
+	}
+
+	return 0;
+}
+
+static int stac92xx_mixer_amp_switch_put(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct sigmatel_spec *spec = codec->spec;
+	hda_nid_t nid = kcontrol->private_value & 0xffff;
+	int idx = (kcontrol->private_value >> 19) & 0xf;
+	int chs = (kcontrol->private_value >> 16) & 0x3;
+	long *valp = ucontrol->value.integer.value;
+	unsigned int wid_caps, val, change;
+
+	change = snd_hda_mixer_amp_switch_put(kcontrol, ucontrol);
+#ifdef CONFIG_SND_HDA_POWER_SAVE
+	if (!is_in_dac_nids(spec, nid))
+		nid = spec->adc_nids[idx];
+
+	val  = *valp++;
+	wid_caps = get_wcaps(codec, nid);
+	if (wid_caps & AC_WCAP_POWER) {
+		if (chs == 3)
+			val |= *valp;
+		else { /* Center/LFE mixers workaround */
+			spec->io_state[--chs] = val;
+			val |= spec->io_state[chs ? 0 : 1];
+		}
+
+		/* set to power state D3 mode if DAC/ADC isn't being used */
+		snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_POWER_STATE,
+							val ? 0: AC_PWRST_D3);
+	}
+#endif
+	return change;
 }
 
 static struct hda_verb stac9200_core_init[] = {
@@ -622,6 +669,20 @@ static struct hda_verb stac9205_core_ini
 		.private_value = verb_read | (verb_write << 16), \
 	}
 
+#define STAC_CODEC_MUTE_IDX(xname, xcidx, nid, xindex, direction) \
+	{ \
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+		.name = xname, \
+		.index = xcidx, \
+		.info = snd_hda_mixer_amp_switch_info, \
+		.get = snd_hda_mixer_amp_switch_get, \
+		.put = stac92xx_mixer_amp_switch_put, \
+		.private_value = HDA_COMPOSE_AMP_VAL(nid, 3, xindex, direction), \
+	}
+
+#define STAC_CODEC_MUTE(xname, nid, xindex, direction) \
+	STAC_CODEC_MUTE_IDX(xname, 0, nid, xindex, direction)
+
 static struct snd_kcontrol_new stac9200_mixer[] = {
 	HDA_CODEC_VOLUME("Master Playback Volume", 0xb, 0, HDA_OUTPUT),
 	HDA_CODEC_MUTE("Master Playback Switch", 0xb, 0, HDA_OUTPUT),
@@ -640,10 +701,10 @@ static struct snd_kcontrol_new stac92hd7
 	HDA_CODEC_VOLUME_IDX("Digital Mic Volume", 0x1, 0x14, 0x0, HDA_INPUT),
 
 	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x0, 0x20, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE_IDX("Capture Switch", 0x0, 0x20, 0x0, HDA_OUTPUT),
-
-	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x1, 0x21, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE_IDX("Capture Switch", 0x1, 0x21, 0x0, HDA_OUTPUT),
+	STAC_CODEC_MUTE_IDX("Capture Switch", 0x0, 0x20, 0x0, HDA_OUTPUT),
+
+	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x1, 0x21, 0x1, HDA_OUTPUT),
+	STAC_CODEC_MUTE_IDX("Capture Switch", 0x1, 0x21, 0x1, HDA_OUTPUT),
 
 	HDA_CODEC_VOLUME("Front Mic Mixer Capture Volume", 0x1d, 0, HDA_INPUT),
 	HDA_CODEC_MUTE("Front Mic Mixer Capture Switch", 0x1d, 0, HDA_INPUT),
@@ -670,10 +731,10 @@ static struct snd_kcontrol_new stac92hd7
 	HDA_CODEC_VOLUME_IDX("Digital Mic Volume", 0x1, 0x14, 0x0, HDA_INPUT),
 
 	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x0, 0x20, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE_IDX("Capture Switch", 0x0, 0x20, 0x0, HDA_OUTPUT),
-
-	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x1, 0x21, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE_IDX("Capture Switch", 0x1, 0x21, 0x0, HDA_OUTPUT),
+	STAC_CODEC_MUTE_IDX("Capture Switch", 0x0, 0x20, 0x0, HDA_OUTPUT),
+
+	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x1, 0x21, 0x1, HDA_OUTPUT),
+	STAC_CODEC_MUTE_IDX("Capture Switch", 0x1, 0x21, 0x1, HDA_OUTPUT),
 
 	HDA_CODEC_VOLUME("Front Mic Mixer Capture Volume", 0x1d, 0, HDA_INPUT),
 	HDA_CODEC_MUTE("Front Mic Mixer Capture Switch", 0x1d, 0, HDA_INPUT),
@@ -700,10 +761,10 @@ static struct snd_kcontrol_new stac92hd7
 	HDA_CODEC_VOLUME_IDX("Digital Mic Volume", 0x1, 0x14, 0x0, HDA_INPUT),
 
 	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x0, 0x20, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE_IDX("Capture Switch", 0x0, 0x20, 0x0, HDA_OUTPUT),
-
-	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x1, 0x21, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE_IDX("Capture Switch", 0x1, 0x21, 0x0, HDA_OUTPUT),
+	STAC_CODEC_MUTE_IDX("Capture Switch", 0x0, 0x20, 0x0, HDA_OUTPUT),
+
+	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x1, 0x21, 0x1, HDA_OUTPUT),
+	STAC_CODEC_MUTE_IDX("Capture Switch", 0x1, 0x21, 0x1, HDA_OUTPUT),
 
 	HDA_CODEC_VOLUME("Front Mic Mixer Capture Volume", 0x1d, 0, HDA_INPUT),
 	HDA_CODEC_MUTE("Front Mic Mixer Capture Switch", 0x1d, 0, HDA_INPUT),
@@ -730,12 +791,12 @@ static struct snd_kcontrol_new stac92hd7
 	HDA_CODEC_VOLUME_IDX("Digital Mic Volume", 0x1, 0x19, 0x0, HDA_OUTPUT),
 
 	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x0, 0x1c, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE_IDX("Capture Switch", 0x0, 0x1c, 0x0, HDA_OUTPUT),
+	STAC_CODEC_MUTE_IDX("Capture Switch", 0x0, 0x1c, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME_IDX("Capture Mux Volume", 0x0, 0x1a, 0x0, HDA_OUTPUT),
 
-	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x1, 0x1d, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE_IDX("Capture Switch", 0x1, 0x1d, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME_IDX("Capture Mux Volume", 0x1, 0x1b, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x1, 0x1d, 0x1, HDA_OUTPUT),
+	STAC_CODEC_MUTE_IDX("Capture Switch", 0x1, 0x1d, 0x1, HDA_OUTPUT),
+	HDA_CODEC_VOLUME_IDX("Capture Mux Volume", 0x1, 0x1b, 0x1, HDA_OUTPUT),
 
 	HDA_CODEC_MUTE("Analog Loopback 1", 0x17, 0x3, HDA_INPUT),
 	HDA_CODEC_MUTE("Analog Loopback 2", 0x17, 0x4, HDA_INPUT),
@@ -751,12 +812,12 @@ static struct snd_kcontrol_new stac92hd7
 	HDA_CODEC_VOLUME_IDX("Digital Mic Volume", 0x1, 0x19, 0x0, HDA_OUTPUT),
 
 	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x0, 0x1c, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE_IDX("Capture Switch", 0x0, 0x1c, 0x0, HDA_OUTPUT),
+	STAC_CODEC_MUTE_IDX("Capture Switch", 0x0, 0x1c, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME_IDX("Capture Mux Volume", 0x0, 0x1a, 0x0, HDA_OUTPUT),
 
-	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x1, 0x1d, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE_IDX("Capture Switch", 0x1, 0x1d, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME_IDX("Capture Mux Volume", 0x1, 0x1b, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x1, 0x1d, 0x1, HDA_OUTPUT),
+	STAC_CODEC_MUTE_IDX("Capture Switch", 0x1, 0x1d, 0x1, HDA_OUTPUT),
+	HDA_CODEC_VOLUME_IDX("Capture Mux Volume", 0x1, 0x1b, 0x1, HDA_OUTPUT),
 	{ } /* end */
 };
 
@@ -857,7 +918,7 @@ static int stac92xx_build_controls(struc
 		if (err < 0)
 			return err;
 	}
-	return 0;	
+	return 0;
 }
 
 static unsigned int ref9200_pin_configs[8] = {
@@ -1962,7 +2023,7 @@ enum {
 
 static struct snd_kcontrol_new stac92xx_control_templates[] = {
 	HDA_CODEC_VOLUME(NULL, 0, 0, 0),
-	HDA_CODEC_MUTE(NULL, 0, 0, 0),
+	STAC_CODEC_MUTE(NULL, 0, 0, 0),
 	STAC_CODEC_IO_SWITCH(NULL, 0),
 	STAC_CODEC_CLFE_SWITCH(NULL, 0),
 };
@@ -2059,19 +2120,6 @@ static int stac92xx_add_dyn_out_pins(str
 	return 0;
 }
 
-
-static int is_in_dac_nids(struct sigmatel_spec *spec, hda_nid_t nid)
-{
-	int i;
-	
-	for (i = 0; i < spec->multiout.num_dacs; i++) {
-		if (spec->multiout.dac_nids[i] == nid)
-			return 1;
-	}
-
-	return 0;
-}
-
 /*
  * Fill in the dac_nids table from the parsed pin configuration
  * This function only works when every pin in line_out_pins[]
@@ -2806,6 +2854,7 @@ static void stac92xx_hp_detect(struct hd
 	struct sigmatel_spec *spec = codec->spec;
 	struct auto_pin_cfg *cfg = &spec->autocfg;
 	int i, presence;
+	unsigned char pwr_state = 0;
 
 	presence = 0;
 	for (i = 0; i < cfg->hp_outs; i++) {
@@ -2816,12 +2865,16 @@ static void stac92xx_hp_detect(struct hd
 
 	if (presence) {
 		/* disable lineouts, enable hp */
-		for (i = 0; i < cfg->line_outs; i++)
+		for (i = 0; i < cfg->line_outs; i++) {
 			stac92xx_reset_pinctl(codec, cfg->line_out_pins[i],
 						AC_PINCTL_OUT_EN);
-		for (i = 0; i < cfg->speaker_outs; i++)
+			pwr_state |= 1 << (cfg->line_out_pins[i] - 0xa);
+		}
+		for (i = 0; i < cfg->speaker_outs; i++) {
 			stac92xx_reset_pinctl(codec, cfg->speaker_pins[i],
 						AC_PINCTL_OUT_EN);
+			pwr_state |= 1 << (cfg->speaker_pins[i] - 0xa);
+		}
 	} else {
 		/* enable lineouts, disable hp */
 		for (i = 0; i < cfg->line_outs; i++)
@@ -2830,7 +2883,12 @@ static void stac92xx_hp_detect(struct hd
 		for (i = 0; i < cfg->speaker_outs; i++)
 			stac92xx_set_pinctl(codec, cfg->speaker_pins[i],
 						AC_PINCTL_OUT_EN);
-	}
+		for (i = 0; i < cfg->hp_outs; i++)
+			pwr_state |= 1 << (cfg->hp_pins[i] - 0xa);
+	}
+
+	/* power down unused ports */
+	snd_hda_codec_write(codec, codec->afg, 0, 0x7ec, pwr_state);
 } 
 
 static void stac92xx_unsol_event(struct hda_codec *codec, unsigned int res)

--------------070706050107060601070403
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------070706050107060601070403--
