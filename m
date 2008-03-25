From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: Add 5.1 support for second headphone jack
Date: Tue, 25 Mar 2008 13:57:29 -0400
Message-ID: <47E93D09.6000904@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp105.biz.mail.mud.yahoo.com (smtp105.biz.mail.mud.yahoo.com
	[68.142.200.253]) by alsa0.perex.cz (Postfix) with SMTP id 2174E2445C
	for <alsa-devel@alsa-project.org>; Tue, 25 Mar 2008 18:57:27 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>, Jose_De_La_Rosa@Dell.com, Mario_Limonciello@Dell.com
List-Id: alsa-devel@alsa-project.org

Several 92hd7xxx and STAC9228 laptops have multiple headphone jacks, the second headphone jack should
be used for the 5.1 surround sound. Add support for 'Headphone as Line Out' switch, which allows it be used
in 5.1 surround sound.

Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
---
diff -r 547e051a88b5 pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Wed Mar 12 13:12:15 2008 +0100
+++ b/pci/hda/patch_sigmatel.c	Tue Mar 18 10:45:08 2008 -0400
@@ -179,6 +179,7 @@ struct sigmatel_spec {
 	/* i/o switches */
 	unsigned int io_switch[2];
 	unsigned int clfe_swap;
+	unsigned int hp_switch;
 	unsigned int aloopback;
 
 	struct hda_pcm pcm_rec[2];	/* PCM information */
@@ -1251,7 +1252,7 @@ static unsigned int ref92hd73xx_pin_conf
 
 static unsigned int dell_m6_pin_configs[13] = {
 	0x0321101f, 0x4f00000f, 0x4f0000f0, 0x90170110,
-	0x03a11020, 0x03011050, 0x4f0000f0, 0x4f0000f0,
+	0x03a11020, 0x0321101f, 0x4f0000f0, 0x4f0000f0,
 	0x4f0000f0, 0x90a60160, 0x4f0000f0, 0x4f0000f0,
 	0x4f0000f0,
 };
@@ -2029,6 +2030,33 @@ static void stac92xx_auto_set_pinctl(str
 				  AC_VERB_SET_PIN_WIDGET_CONTROL, pin_type);
 }
 
+#define stac92xx_hp_switch_info		snd_ctl_boolean_mono_info
+
+static int stac92xx_hp_switch_get(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct sigmatel_spec *spec = codec->spec;
+
+	ucontrol->value.integer.value[0] = spec->hp_switch;
+	return 0;
+}
+
+static int stac92xx_hp_switch_put(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct sigmatel_spec *spec = codec->spec;
+
+	spec->hp_switch = ucontrol->value.integer.value[0];
+
+	/* check to be sure that the ports are upto date with
+ 	 * switch changes */
+	codec->patch_ops.unsol_event(codec, STAC_HP_EVENT << 26);
+
+	return 1;
+}
+
 #define stac92xx_io_switch_info		snd_ctl_boolean_mono_info
 
 static int stac92xx_io_switch_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
@@ -2099,6 +2127,15 @@ static int stac92xx_clfe_switch_put(stru
 
 	return 1;
 }
+
+#define STAC_CODEC_HP_SWITCH(xname) \
+	{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+	  .name = xname, \
+	  .index = 0, \
+          .info = stac92xx_hp_switch_info, \
+          .get = stac92xx_hp_switch_get, \
+          .put = stac92xx_hp_switch_put, \
+	}
 
 #define STAC_CODEC_IO_SWITCH(xname, xpval) \
 	{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
@@ -2124,6 +2161,7 @@ enum {
 	STAC_CTL_WIDGET_VOL,
 	STAC_CTL_WIDGET_MUTE,
 	STAC_CTL_WIDGET_MONO_MUX,
+	STAC_CTL_WIDGET_HP_SWITCH,
 	STAC_CTL_WIDGET_IO_SWITCH,
 	STAC_CTL_WIDGET_CLFE_SWITCH
 };
@@ -2132,6 +2170,7 @@ static struct snd_kcontrol_new stac92xx_
 	HDA_CODEC_VOLUME(NULL, 0, 0, 0),
 	HDA_CODEC_MUTE(NULL, 0, 0, 0),
 	STAC_MONO_MUX,
+	STAC_CODEC_HP_SWITCH(NULL),
 	STAC_CODEC_IO_SWITCH(NULL, 0),
 	STAC_CODEC_CLFE_SWITCH(NULL, 0),
 };
@@ -2396,6 +2435,14 @@ static int stac92xx_auto_create_multi_ou
 		}
 	}
 
+	if (cfg->hp_outs > 1) {
+		err = stac92xx_add_control(spec,
+			STAC_CTL_WIDGET_HP_SWITCH,
+			"Headphone as Line Out Switch", 0);
+		if (err < 0)
+			return err;
+	}
+
 	if (spec->line_switch) {
 		nid = cfg->input_pins[AUTO_PIN_LINE];
 		pincap = snd_hda_param_read(codec, nid,
@@ -3144,6 +3191,7 @@ static void stac92xx_hp_detect(struct hd
 {
 	struct sigmatel_spec *spec = codec->spec;
 	struct auto_pin_cfg *cfg = &spec->autocfg;
+	int nid = cfg->hp_pins[cfg->hp_outs - 1];
 	int i, presence;
 
 	presence = 0;
@@ -3154,11 +3202,15 @@ static void stac92xx_hp_detect(struct hd
 	for (i = 0; i < cfg->hp_outs; i++) {
 		if (presence)
 			break;
+		if (spec->hp_switch && cfg->hp_pins[i] == nid)
+			break;
 		presence = get_hp_pin_presence(codec, cfg->hp_pins[i]);
 	}
 
 	if (presence) {
 		/* disable lineouts, enable hp */
+		if (spec->hp_switch)
+			stac92xx_reset_pinctl(codec, nid, AC_PINCTL_OUT_EN);
 		for (i = 0; i < cfg->line_outs; i++)
 			stac92xx_reset_pinctl(codec, cfg->line_out_pins[i],
 						AC_PINCTL_OUT_EN);
@@ -3167,6 +3219,8 @@ static void stac92xx_hp_detect(struct hd
 						AC_PINCTL_OUT_EN);
 	} else {
 		/* enable lineouts, disable hp */
+		if (spec->hp_switch)
+			stac92xx_set_pinctl(codec, nid, AC_PINCTL_OUT_EN);
 		for (i = 0; i < cfg->line_outs; i++)
 			stac92xx_set_pinctl(codec, cfg->line_out_pins[i],
 						AC_PINCTL_OUT_EN);
@@ -3174,6 +3228,8 @@ static void stac92xx_hp_detect(struct hd
 			stac92xx_set_pinctl(codec, cfg->speaker_pins[i],
 						AC_PINCTL_OUT_EN);
 	}
+	if (!spec->hp_switch && cfg->hp_outs > 1 && presence)
+		stac92xx_set_pinctl(codec, nid, AC_PINCTL_OUT_EN);
 } 
 
 static void stac92xx_pin_sense(struct hda_codec *codec, int idx)
@@ -3427,6 +3483,7 @@ again:
 
 	switch (spec->multiout.num_dacs) {
 	case 0x3: /* 6 Channel */
+		spec->multiout.hp_nid = 0x17;
 		spec->mixer = stac92hd73xx_6ch_mixer;
 		spec->init = stac92hd73xx_6ch_core_init;
 		break;
