From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: Input port AMP controls
Date: Thu, 11 Sep 2008 09:49:39 -0400
Message-ID: <48C921F3.8030606@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id 71264243CD
	for <alsa-devel@alsa-project.org>;
	Thu, 11 Sep 2008 15:49:49 +0200 (CEST)
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

Added support for controlling hardware gain amps on input ports
using a volume control mixer with a mux selecting the port being controlled.

Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
---

diff --git a/pci/hda/hda_codec.c b/pci/hda/hda_codec.c
index 696d77e..e12626b 100644
--- a/pci/hda/hda_codec.c
+++ b/pci/hda/hda_codec.c
@@ -961,15 +961,6 @@ void snd_hda_codec_resume_amp(struct hda_codec *codec)
 }
 #endif /* SND_HDA_NEEDS_RESUME */

-/*
- * AMP control callbacks
- */
-/* retrieve parameters from private_value */
-#define get_amp_nid(kc)		((kc)->private_value & 0xffff)
-#define get_amp_channels(kc)	(((kc)->private_value >> 16) & 0x3)
-#define get_amp_direction(kc)	(((kc)->private_value >> 18) & 0x1)
-#define get_amp_index(kc)	(((kc)->private_value >> 19) & 0xf)
-
 /* volume */
 int snd_hda_mixer_amp_volume_info(struct snd_kcontrol *kcontrol,
 				  struct snd_ctl_elem_info *uinfo)
diff --git a/pci/hda/hda_local.h b/pci/hda/hda_local.h
index 5c9e578..d688f50 100644
--- a/pci/hda/hda_local.h
+++ b/pci/hda/hda_local.h
@@ -418,4 +418,13 @@ int snd_hda_check_amp_list_power(struct hda_codec *codec,
 				 hda_nid_t nid);
 #endif /* CONFIG_SND_HDA_POWER_SAVE */

+/*
+ * AMP control callbacks
+ */
+/* retrieve parameters from private_value */
+#define get_amp_nid(kc)		((kc)->private_value & 0xffff)
+#define get_amp_channels(kc)	(((kc)->private_value >> 16) & 0x3)
+#define get_amp_direction(kc)	(((kc)->private_value >> 18) & 0x1)
+#define get_amp_index(kc)	(((kc)->private_value >> 19) & 0xf)
+
 #endif /* __SOUND_HDA_LOCAL_H */
diff --git a/pci/hda/patch_sigmatel.c b/pci/hda/patch_sigmatel.c
index f00334f..ac56481 100644
--- a/pci/hda/patch_sigmatel.c
+++ b/pci/hda/patch_sigmatel.c
@@ -156,10 +156,13 @@ struct sigmatel_spec {
 	unsigned int num_pwrs;
 	unsigned int *pwr_mapping;
 	hda_nid_t *pwr_nids;
+	hda_nid_t *amp_nids;
 	hda_nid_t *dac_list;

 	/* playback */
 	struct hda_input_mux *mono_mux;
+	struct hda_input_mux *amp_mux;
+	unsigned int cur_amux;
 	unsigned int cur_mmux;
 	struct hda_multi_out multiout;
 	hda_nid_t dac_nids[5];
@@ -215,6 +218,7 @@ struct sigmatel_spec {
 	struct hda_input_mux private_dimux;
 	struct hda_input_mux private_imux;
 	struct hda_input_mux private_smux;
+	struct hda_input_mux private_amp_mux;
 	struct hda_input_mux private_mono_mux;
 };

@@ -243,6 +247,10 @@ static hda_nid_t stac92hd73xx_adc_nids[2] = {
 	0x1a, 0x1b
 };

+static hda_nid_t stac92hd73xx_amp_nids[4] = {
+	0x0b, 0x0c, 0x0e, 0
+};
+
 #define STAC92HD73XX_NUM_DMICS	2
 static hda_nid_t stac92hd73xx_dmic_nids[STAC92HD73XX_NUM_DMICS + 1] = {
 	0x13, 0x14, 0
@@ -448,6 +456,34 @@ static hda_nid_t stac9205_pin_nids[12] = {
 	0x21, 0x22,
 };

+#define stac92xx_amp_volume_info snd_hda_mixer_amp_volume_info
+
+static int stac92xx_amp_volume_get(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct sigmatel_spec *spec = codec->spec;
+	hda_nid_t nid = spec->amp_nids[spec->cur_amux];
+
+	kcontrol->private_value ^= get_amp_nid(kcontrol);
+	kcontrol->private_value |= nid;
+
+	return snd_hda_mixer_amp_volume_get(kcontrol, ucontrol);
+}
+
+static int stac92xx_amp_volume_put(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct sigmatel_spec *spec = codec->spec;
+	hda_nid_t nid = spec->amp_nids[spec->cur_amux];
+
+	kcontrol->private_value ^= get_amp_nid(kcontrol);
+	kcontrol->private_value |= nid;
+
+	return snd_hda_mixer_amp_volume_put(kcontrol, ucontrol);
+}
+
 static int stac92xx_dmux_enum_info(struct snd_kcontrol *kcontrol,
 				   struct snd_ctl_elem_info *uinfo)
 {
@@ -563,6 +599,41 @@ static int stac92xx_mono_mux_enum_put(struct snd_kcontrol *kcontrol,
 				     spec->mono_nid, &spec->cur_mmux);
 }

+static int stac92xx_amp_mux_enum_info(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_info *uinfo)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct sigmatel_spec *spec = codec->spec;
+	return snd_hda_input_mux_info(spec->amp_mux, uinfo);
+}
+
+static int stac92xx_amp_mux_enum_get(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct sigmatel_spec *spec = codec->spec;
+
+	ucontrol->value.enumerated.item[0] = spec->cur_amux;
+	return 0;
+}
+
+static int stac92xx_amp_mux_enum_put(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct sigmatel_spec *spec = codec->spec;
+	struct snd_kcontrol *ctl =
+		snd_hda_find_mixer_ctl(codec, "Amp Capture Volume");
+	if (!ctl)
+		return -EINVAL;
+
+	snd_ctl_notify(codec->bus->card, SNDRV_CTL_EVENT_MASK_VALUE |
+		SNDRV_CTL_EVENT_MASK_INFO, &ctl->id);
+
+	return snd_hda_input_mux_put(codec, spec->amp_mux, ucontrol,
+				     0, &spec->cur_amux);
+}
+
 #define stac92xx_aloopback_info snd_ctl_boolean_mono_info

 static int stac92xx_aloopback_get(struct snd_kcontrol *kcontrol,
@@ -837,6 +908,31 @@ static struct hda_verb stac9205_core_init[] = {
 		.put = stac92xx_mono_mux_enum_put, \
 	}

+#define STAC_AMP_MUX \
+	{ \
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+		.name = "Amp Selector Capture Switch", \
+		.count = 1, \
+		.info = stac92xx_amp_mux_enum_info, \
+		.get = stac92xx_amp_mux_enum_get, \
+		.put = stac92xx_amp_mux_enum_put, \
+	}
+
+#define STAC_AMP_VOL(xname, nid, chs, idx, dir) \
+	{ \
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+		.name = xname, \
+		.index = 0, \
+		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE | \
+			SNDRV_CTL_ELEM_ACCESS_TLV_READ | \
+			SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK, \
+		.info = stac92xx_amp_volume_info, \
+		.get = stac92xx_amp_volume_get, \
+		.put = stac92xx_amp_volume_put, \
+		.tlv = { .c = snd_hda_mixer_amp_tlv }, \
+		.private_value = HDA_COMPOSE_AMP_VAL(nid, chs, idx, dir) \
+	}
+
 #define STAC_INPUT_SOURCE(cnt) \
 	{ \
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
@@ -2418,6 +2514,8 @@ enum {
 	STAC_CTL_WIDGET_VOL,
 	STAC_CTL_WIDGET_MUTE,
 	STAC_CTL_WIDGET_MONO_MUX,
+	STAC_CTL_WIDGET_AMP_MUX,
+	STAC_CTL_WIDGET_AMP_VOL,
 	STAC_CTL_WIDGET_HP_SWITCH,
 	STAC_CTL_WIDGET_IO_SWITCH,
 	STAC_CTL_WIDGET_CLFE_SWITCH
@@ -2427,6 +2525,8 @@ static struct snd_kcontrol_new stac92xx_control_templates[] = {
 	HDA_CODEC_VOLUME(NULL, 0, 0, 0),
 	HDA_CODEC_MUTE(NULL, 0, 0, 0),
 	STAC_MONO_MUX,
+	STAC_AMP_MUX,
+	STAC_AMP_VOL(NULL, 0, 0, 0, 0),
 	STAC_CODEC_HP_SWITCH(NULL),
 	STAC_CODEC_IO_SWITCH(NULL, 0),
 	STAC_CODEC_CLFE_SWITCH(NULL, 0),
@@ -2844,6 +2944,35 @@ static int stac92xx_auto_create_mono_output_ctls(struct hda_codec *codec)
 				"Mono Mux", spec->mono_nid);
 }

+/* labels for amp mux outputs */
+static const char *stac92xx_amp_labels[3] = {
+	"Front Microphone", "Microphone", "Line In"
+};
+
+/* create amp out controls mux on capable codecs */
+static int stac92xx_auto_create_amp_output_ctls(struct hda_codec *codec)
+{
+	struct sigmatel_spec *spec = codec->spec;
+	struct hda_input_mux *amp_mux = &spec->private_amp_mux;
+	int i, err;
+
+	for (i = 0; i < ARRAY_SIZE(stac92xx_amp_labels); i++) {
+		amp_mux->items[amp_mux->num_items].label =
+					stac92xx_amp_labels[i];
+		amp_mux->items[amp_mux->num_items].index = i;
+		amp_mux->num_items++;
+	}
+
+	err = stac92xx_add_control(spec, STAC_CTL_WIDGET_AMP_MUX,
+		"Amp Selector Capture Switch", 0);
+	if (err < 0)
+		return err;
+	return stac92xx_add_control(spec, STAC_CTL_WIDGET_AMP_VOL,
+		"Amp Capture Volume",
+		HDA_COMPOSE_AMP_VAL(spec->amp_nids[0], 3, 0, HDA_INPUT));
+}
+
+
 /* create PC beep volume controls */
 static int stac92xx_auto_create_beep_ctls(struct hda_codec *codec,
 						hda_nid_t nid)
@@ -3213,7 +3342,11 @@ static int stac92xx_parse_auto_config(struct hda_codec *codec, hda_nid_t dig_out
 		if (err < 0)
 			return err;
 	}
-
+	if (spec->amp_nids) {
+		err = stac92xx_auto_create_amp_output_ctls(codec);
+		if (err < 0)
+			return err;
+	}
 	if (spec->num_dmics > 0)
 		if ((err = stac92xx_auto_create_dmic_input_ctls(codec,
 						&spec->autocfg)) < 0)
@@ -3246,7 +3379,7 @@ static int stac92xx_parse_auto_config(struct hda_codec *codec, hda_nid_t dig_out
 		spec->dinput_mux = &spec->private_dimux;
 	spec->sinput_mux = &spec->private_smux;
 	spec->mono_mux = &spec->private_mono_mux;
-
+	spec->amp_mux = &spec->private_amp_mux;
 	return 1;
 }

@@ -3914,6 +4047,7 @@ again:
 	spec->dmic_nids = stac92hd73xx_dmic_nids;
 	spec->dmux_nids = stac92hd73xx_dmux_nids;
 	spec->smux_nids = stac92hd73xx_smux_nids;
+	spec->amp_nids = stac92hd73xx_amp_nids;

 	spec->num_muxes = ARRAY_SIZE(stac92hd73xx_mux_nids);
 	spec->num_adcs = ARRAY_SIZE(stac92hd73xx_adc_nids);
