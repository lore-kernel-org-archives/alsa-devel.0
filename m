From: Matt Porter <mporter@embeddedalley.com>
Subject: [PATCH] hda: add sigmatel dig mic support and refactor
	9227
Date: Wed, 25 Oct 2006 16:21:10 -0400
Message-ID: <20061025202110.GA351@matthew-porters-computer.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from oh.embeddedalley.com (cpe-088197.static.wadsnet.net
	[65.114.88.197])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 88E7B219
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Oct 2006 22:28:24 +0200 (MEST)
Content-Disposition: inline
Resent-To: alsa-devel@alsa-project.org, tiwai@suse.de
Resent-Message-Id: <20061025202823.715DB2284E4@oh.embeddedalley.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Adds support for digital microphone pin widgets on SigmaTel codecs.
Also refactor 9227 support out of the 927x support since the 9227
codecs have some differing pin widgets.

Signed-off-by: Matt Porter <mporter@embeddedalley.com>

diff -r c4d2375b7e9e pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Tue Oct 24 19:49:39 2006 +0200
+++ b/pci/hda/patch_sigmatel.c	Wed Oct 25 13:04:04 2006 -0700
@@ -41,10 +41,8 @@
 #define STAC_D945GTP3		1
 #define STAC_D945GTP5		2
 #define STAC_MACMINI		3
-#define STAC_922X_MODELS	4	/* number of 922x models */
 #define STAC_D965_3ST		4
 #define STAC_D965_5ST		5
-#define STAC_927X_MODELS	6	/* number of 922x models */
 
 struct sigmatel_spec {
 	struct snd_kcontrol_new *mixers[4];
@@ -67,6 +65,9 @@ struct sigmatel_spec {
 	unsigned int num_adcs;
 	hda_nid_t *mux_nids;
 	unsigned int num_muxes;
+	hda_nid_t *dmic_nids;
+	unsigned int num_dmics;
+	hda_nid_t dmux_nid;
 	hda_nid_t dig_in_nid;
 
 	/* pin widgets */
@@ -80,6 +81,8 @@ struct sigmatel_spec {
 	struct snd_kcontrol_new *mixer;
 
 	/* capture source */
+	struct hda_input_mux *dinput_mux;
+	unsigned int cur_dmux;
 	struct hda_input_mux *input_mux;
 	unsigned int cur_mux[3];
 
@@ -92,6 +95,7 @@ struct sigmatel_spec {
 	struct auto_pin_cfg autocfg;
 	unsigned int num_kctl_alloc, num_kctl_used;
 	struct snd_kcontrol_new *kctl_alloc;
+	struct hda_input_mux private_dimux;
 	struct hda_input_mux private_imux;
 };
 
@@ -123,12 +127,32 @@ static hda_nid_t stac927x_mux_nids[3] = 
         0x15, 0x16, 0x17
 };
 
+static hda_nid_t stac927x_dmic_nids[3] = {
+        0x13, 0x14, 0
+};
+
+static hda_nid_t stac9227_adc_nids[3] = {
+        0x07, 0x08, 0x09
+};
+
+static hda_nid_t stac9227_mux_nids[3] = {
+        0x15, 0x16, 0x17
+};
+
+static hda_nid_t stac9227_dmic_nids[3] = {
+        0x13, 0x14, 0
+};
+
 static hda_nid_t stac9205_adc_nids[2] = {
         0x12, 0x13
 };
 
 static hda_nid_t stac9205_mux_nids[2] = {
         0x19, 0x1a
+};
+
+static hda_nid_t stac9205_dmic_nids[3] = {
+        0x17, 0x18, 0
 };
 
 static hda_nid_t stac9200_pin_nids[8] = {
@@ -145,6 +169,13 @@ static hda_nid_t stac927x_pin_nids[14] =
 	0x0a, 0x0b, 0x0c, 0x0d, 0x0e,
 	0x0f, 0x10, 0x11, 0x12, 0x13,
 	0x14, 0x21, 0x22, 0x23,
+};
+
+static hda_nid_t stac9227_pin_nids[16] = {
+	0x0a, 0x0b, 0x0c, 0x0d, 0x0e,
+	0x0f, 0x10, 0x11, 0x12, 0x13,
+	0x14, 0x1e, 0x20, 0x21, 0x22,
+	0x23,
 };
 
 static hda_nid_t stac9205_pin_nids[12] = {
@@ -153,6 +184,31 @@ static hda_nid_t stac9205_pin_nids[12] =
 	0x21, 0x22,
 	
 };
+
+static int stac92xx_dmux_enum_info(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct sigmatel_spec *spec = codec->spec;
+	return snd_hda_input_mux_info(spec->dinput_mux, uinfo);
+}
+
+static int stac92xx_dmux_enum_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct sigmatel_spec *spec = codec->spec;
+
+	ucontrol->value.enumerated.item[0] = spec->cur_dmux;
+	return 0;
+}
+
+static int stac92xx_dmux_enum_put(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct sigmatel_spec *spec = codec->spec;
+
+	return snd_hda_input_mux_put(codec, spec->dinput_mux, ucontrol,
+				     spec->dmux_nid, &spec->cur_dmux);
+}
 
 static int stac92xx_mux_enum_info(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
@@ -204,6 +260,12 @@ static struct hda_verb d965_core_init[] 
 };
 
 static struct hda_verb stac927x_core_init[] = {
+	/* set master volume and direct control */	
+	{ 0x24, AC_VERB_SET_VOLUME_KNOB_CONTROL, 0xff},
+	{}
+};
+
+static struct hda_verb stac9227_core_init[] = {
 	/* set master volume and direct control */	
 	{ 0x24, AC_VERB_SET_VOLUME_KNOB_CONTROL, 0xff},
 	{}
@@ -252,6 +314,14 @@ static struct snd_kcontrol_new stac9227_
 static struct snd_kcontrol_new stac9227_mixer[] = {
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Digital Input Source",
+		.count = 1,
+		.info = stac92xx_dmux_enum_info,
+		.get = stac92xx_dmux_enum_get,
+		.put = stac92xx_dmux_enum_put,
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.name = "Input Source",
 		.count = 1,
 		.info = stac92xx_mux_enum_info,
@@ -259,11 +329,20 @@ static struct snd_kcontrol_new stac9227_
 		.put = stac92xx_mux_enum_put,
 	},
 	HDA_CODEC_VOLUME("Capture Volume", 0x15, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("InVol Capture Volume", 0x18, 0x0, HDA_INPUT),
 	HDA_CODEC_MUTE("Capture Switch", 0x1b, 0x0, HDA_OUTPUT),
 	{ } /* end */
 };
 
 static snd_kcontrol_new_t stac927x_mixer[] = {
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Digital Input Source",
+		.count = 1,
+		.info = stac92xx_dmux_enum_info,
+		.get = stac92xx_dmux_enum_get,
+		.put = stac92xx_dmux_enum_put,
+	},
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.name = "Input Source",
@@ -281,6 +360,14 @@ static snd_kcontrol_new_t stac9205_mixer
 static snd_kcontrol_new_t stac9205_mixer[] = {
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Digital Input Source",
+		.count = 1,
+		.info = stac92xx_dmux_enum_info,
+		.get = stac92xx_dmux_enum_get,
+		.put = stac92xx_dmux_enum_put,
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.name = "Input Source",
 		.count = 1,
 		.info = stac92xx_mux_enum_info,
@@ -357,7 +444,7 @@ static unsigned int d945gtp5_pin_configs
 	0x02a19320, 0x40000100,
 };
 
-static unsigned int *stac922x_brd_tbl[STAC_922X_MODELS] = {
+static unsigned int *stac922x_brd_tbl[] = {
 	[STAC_REF] =	ref922x_pin_configs,
 	[STAC_D945GTP3] = d945gtp3_pin_configs,
 	[STAC_D945GTP5] = d945gtp5_pin_configs,
@@ -458,31 +545,38 @@ static unsigned int ref927x_pin_configs[
 static unsigned int ref927x_pin_configs[14] = {
 	0x02214020, 0x02a19080, 0x0181304e, 0x01014010,
 	0x01a19040, 0x01011012, 0x01016011, 0x0101201f, 
-	0x183301f0, 0x18a001f0, 0x18a001f0, 0x01442070,
+	0x183301f0, 0x90a000f0, 0x90a000f0, 0x01442070,
 	0x01c42190, 0x40000100,
 };
 
-static unsigned int d965_3st_pin_configs[14] = {
+static unsigned int ref9227_pin_configs[16] = {
+	0x02214020, 0x02a19080, 0x0181304e, 0x01014010,
+	0x01a19040, 0x01011012, 0x01016011, 0x0101201f, 
+	0x183301f0, 0x90a000f0, 0x90a000f0, 0x01442070,
+	0x01c42190, 0x40000100, 0x40000100, 0x40000100,
+};
+
+static unsigned int d965_3st_pin_configs[16] = {
 	0x0221401f, 0x02a19120, 0x40000100, 0x01014011,
 	0x01a19021, 0x01813024, 0x40000100, 0x40000100,
 	0x40000100, 0x40000100, 0x40000100, 0x40000100,
-	0x40000100, 0x40000100
-};
-
-static unsigned int d965_5st_pin_configs[14] = {
+	0x40000100, 0x40000100, 0x40000100, 0x40000100,
+};
+
+static unsigned int d965_5st_pin_configs[16] = {
 	0x02214020, 0x02a19080, 0x0181304e, 0x01014010,
 	0x01a19040, 0x01011012, 0x01016011, 0x40000100,
 	0x40000100, 0x40000100, 0x40000100, 0x01442070,
-	0x40000100, 0x40000100
-};
-
-static unsigned int *stac927x_brd_tbl[STAC_927X_MODELS] = {
-	[STAC_REF] =	ref927x_pin_configs,
+	0x40000100, 0x40000100, 0x40000100, 0x40000100,
+};
+
+static unsigned int *stac9227_brd_tbl[] = {
+	[STAC_REF] =	ref9227_pin_configs,
 	[STAC_D965_3ST] = d965_3st_pin_configs,
 	[STAC_D965_5ST] = d965_5st_pin_configs,
 };
 
-static struct hda_board_config stac927x_cfg_tbl[] = {
+static struct hda_board_config stac9227_cfg_tbl[] = {
 	{ .modelname = "5stack", .config = STAC_D965_5ST },
 	{ .modelname = "3stack", .config = STAC_D965_3ST },
 	{ .modelname = "ref",
@@ -576,10 +670,22 @@ static struct hda_board_config stac927x_
 	{} /* terminator */
 };
 
+static unsigned int *stac927x_brd_tbl[] = {
+	[STAC_REF] =	ref927x_pin_configs,
+};
+
+static struct hda_board_config stac927x_cfg_tbl[] = {
+	{ .modelname = "ref",
+	  .pci_subvendor = PCI_VENDOR_ID_INTEL,
+	  .pci_subdevice = 0x2668,	/* DFI LanParty */
+	  .config = STAC_REF },		/* SigmaTel reference board */
+	{} /* terminator */
+};
+
 static unsigned int ref9205_pin_configs[12] = {
 	0x40000100, 0x40000100, 0x01016011, 0x01014010,
-	0x01813122, 0x01a19021, 0x40000100, 0x40000100, 
-	0x40000100, 0x40000100, 0x01441030, 0x01c41030
+	0x01813122, 0x01a19021, 0x40000100, 0x40000100,
+	0x90a000f0, 0x90a000f0, 0x01441030, 0x01c41030
 };
 
 static unsigned int *stac9205_brd_tbl[] = {
@@ -1154,6 +1260,49 @@ static int stac92xx_auto_create_hp_ctls(
 	return 0;
 }
 
+/* labels for dmic mux inputs */
+const char *stac92xx_dmic_labels[5] = {
+	        "Analog Inputs", "Digital Mic 1", "Digital Mic 2", "Digital Mic 3", "Digital Mic 4"
+};
+
+/* create playback/capture controls for input pins on dmic capable codecs */
+static int stac92xx_auto_create_dmic_input_ctls(struct hda_codec *codec, const struct auto_pin_cfg *cfg)
+{
+	struct sigmatel_spec *spec = codec->spec;
+	struct hda_input_mux *dimux = &spec->private_dimux;
+	hda_nid_t con_lst[HDA_MAX_NUM_INPUTS];
+	int i, j;
+
+	dimux->items[dimux->num_items].label = stac92xx_dmic_labels[0];
+	dimux->items[dimux->num_items].index = 0;
+	dimux->num_items++;
+
+	for (i = 0; i < spec->num_dmics; i++) {
+		int index;
+		int num_cons;
+		unsigned int def_conf = snd_hda_codec_read(codec, spec->dmic_nids[i], 0, AC_VERB_GET_CONFIG_DEFAULT, 0);
+		if (get_defcfg_connect(def_conf) == AC_JACK_PORT_NONE)
+			continue;
+
+		num_cons = snd_hda_get_connections(codec,
+				spec->dmux_nid,
+				con_lst,
+				HDA_MAX_NUM_INPUTS);
+		for (j = 0; j < num_cons; j++)
+			if (con_lst[j] == spec->dmic_nids[i]) {
+				index = j;
+				goto found;
+			}
+		continue;
+found:
+		dimux->items[dimux->num_items].label = stac92xx_dmic_labels[dimux->num_items];
+		dimux->items[dimux->num_items].index = index;
+		dimux->num_items++;
+	}
+
+	return 0;
+}
+
 /* create playback/capture controls for input pins */
 static int stac92xx_auto_create_analog_input_ctls(struct hda_codec *codec, const struct auto_pin_cfg *cfg)
 {
@@ -1238,7 +1387,7 @@ static int stac92xx_parse_auto_config(st
 	struct sigmatel_spec *spec = codec->spec;
 	int err;
 
-	if ((err = snd_hda_parse_pin_def_config(codec, &spec->autocfg, NULL)) < 0)
+	if ((err = snd_hda_parse_pin_def_config(codec, &spec->autocfg, spec->dmic_nids)) < 0)
 		return err;
 	if (! spec->autocfg.line_outs)
 		return 0; /* can't find valid pin config */
@@ -1254,6 +1403,10 @@ static int stac92xx_parse_auto_config(st
 	    (err = stac92xx_auto_create_analog_input_ctls(codec, &spec->autocfg)) < 0)
 		return err;
 
+	if (spec->num_dmics > 0)
+		if ((err = stac92xx_auto_create_dmic_input_ctls(codec, &spec->autocfg)) < 0)
+			return err;
+
 	spec->multiout.max_channels = spec->multiout.num_dacs * 2;
 	if (spec->multiout.max_channels > 2)
 		spec->surr_switch = 1;
@@ -1267,6 +1420,7 @@ static int stac92xx_parse_auto_config(st
 		spec->mixers[spec->num_mixers++] = spec->kctl_alloc;
 
 	spec->input_mux = &spec->private_imux;
+	spec->dinput_mux = &spec->private_dimux;
 
 	return 1;
 }
@@ -1366,6 +1520,7 @@ static int stac9200_parse_auto_config(st
 		spec->mixers[spec->num_mixers++] = spec->kctl_alloc;
 
 	spec->input_mux = &spec->private_imux;
+	spec->dinput_mux = &spec->private_dimux;
 
 	return 1;
 }
@@ -1448,6 +1603,11 @@ static int stac92xx_init(struct hda_code
 			stac92xx_auto_set_pinctl(codec, nid, pinctl);
 		}
 	}
+	if (spec->num_dmics > 0)
+		for (i = 0; i < spec->num_dmics; i++)
+			stac92xx_auto_set_pinctl(codec, spec->dmic_nids[i],
+					 AC_PINCTL_IN_EN);
+
 	if (cfg->dig_out_pin)
 		stac92xx_auto_set_pinctl(codec, cfg->dig_out_pin,
 					 AC_PINCTL_OUT_EN);
@@ -1618,6 +1778,7 @@ static int patch_stac9200(struct hda_cod
 	spec->adc_nids = stac9200_adc_nids;
 	spec->mux_nids = stac9200_mux_nids;
 	spec->num_muxes = 1;
+	spec->num_dmics = 0;
 
 	spec->init = stac9200_core_init;
 	spec->mixer = stac9200_mixer;
@@ -1663,6 +1824,7 @@ static int patch_stac922x(struct hda_cod
 	spec->adc_nids = stac922x_adc_nids;
 	spec->mux_nids = stac922x_mux_nids;
 	spec->num_muxes = 2;
+	spec->num_dmics = 0;
 
 	spec->init = stac922x_core_init;
 	spec->mixer = stac922x_mixer;
@@ -1677,6 +1839,73 @@ static int patch_stac922x(struct hda_cod
 
 	if (spec->board_config == STAC_MACMINI)
 		spec->gpio_mute = 1;
+
+	codec->patch_ops = stac92xx_patch_ops;
+
+	return 0;
+}
+
+static int patch_stac9227(struct hda_codec *codec)
+{
+	struct sigmatel_spec *spec;
+	int err;
+
+	spec  = kzalloc(sizeof(*spec), GFP_KERNEL);
+	if (spec == NULL)
+		return -ENOMEM;
+
+	codec->spec = spec;
+	spec->num_pins = 14;
+	spec->pin_nids = stac9227_pin_nids;
+	spec->board_config = snd_hda_check_board_config(codec, stac9227_cfg_tbl);
+	if (spec->board_config < 0) {
+                snd_printdd(KERN_INFO "hda_codec: Unknown model for STAC9227, using BIOS defaults\n");
+		err = stac92xx_save_bios_config_regs(codec);
+		if (err < 0) {
+			stac92xx_free(codec);
+			return err;
+		}
+		spec->pin_configs = spec->bios_pin_configs;
+	} else if (stac9227_brd_tbl[spec->board_config] != NULL) {
+		spec->pin_configs = stac9227_brd_tbl[spec->board_config];
+		stac92xx_set_config_regs(codec);
+	}
+
+	switch (spec->board_config) {
+	case STAC_D965_3ST:
+		spec->adc_nids = stac9227_adc_nids;
+		spec->mux_nids = stac9227_mux_nids;
+		spec->num_muxes = 3;
+		spec->num_dmics = 0;
+		spec->init = d965_core_init;
+		spec->mixer = stac9227_mixer;
+		break;
+	case STAC_D965_5ST:
+		spec->adc_nids = stac9227_adc_nids;
+		spec->mux_nids = stac9227_mux_nids;
+		spec->num_muxes = 3;
+		spec->num_dmics = 0;
+		spec->init = d965_core_init;
+		spec->mixer = stac9227_mixer;
+		break;
+	default:
+		spec->adc_nids = stac9227_adc_nids;
+		spec->mux_nids = stac9227_mux_nids;
+		spec->num_muxes = 3;
+		spec->dmic_nids = stac9227_dmic_nids;
+		spec->num_dmics = 2;
+		spec->dmux_nid = 0x1b;
+		spec->init = stac9227_core_init;
+		spec->mixer = stac9227_mixer;
+	}
+
+	spec->multiout.dac_nids = spec->dac_nids;
+
+	err = stac92xx_parse_auto_config(codec, 0x1e, 0x20);
+	if (err < 0) {
+		stac92xx_free(codec);
+		return err;
+	}
 
 	codec->patch_ops = stac92xx_patch_ops;
 
@@ -1709,28 +1938,14 @@ static int patch_stac927x(struct hda_cod
 		stac92xx_set_config_regs(codec);
 	}
 
-	switch (spec->board_config) {
-	case STAC_D965_3ST:
-		spec->adc_nids = stac927x_adc_nids;
-		spec->mux_nids = stac927x_mux_nids;
-		spec->num_muxes = 3;
-		spec->init = d965_core_init;
-		spec->mixer = stac9227_mixer;
-		break;
-	case STAC_D965_5ST:
-		spec->adc_nids = stac927x_adc_nids;
-		spec->mux_nids = stac927x_mux_nids;
-		spec->num_muxes = 3;
-		spec->init = d965_core_init;
-		spec->mixer = stac9227_mixer;
-		break;
-	default:
-		spec->adc_nids = stac927x_adc_nids;
-		spec->mux_nids = stac927x_mux_nids;
-		spec->num_muxes = 3;
-		spec->init = stac927x_core_init;
-		spec->mixer = stac927x_mixer;
-	}
+	spec->adc_nids = stac927x_adc_nids;
+	spec->mux_nids = stac927x_mux_nids;
+	spec->num_muxes = 3;
+	spec->dmic_nids = stac927x_dmic_nids;
+	spec->num_dmics = 2;
+	spec->dmux_nid = 0x1b;
+	spec->init = stac927x_core_init;
+	spec->mixer = stac927x_mixer;
 
 	spec->multiout.dac_nids = spec->dac_nids;
 
@@ -1773,7 +1988,10 @@ static int patch_stac9205(struct hda_cod
 
 	spec->adc_nids = stac9205_adc_nids;
 	spec->mux_nids = stac9205_mux_nids;
-	spec->num_muxes = 3;
+	spec->num_muxes = 2;
+	spec->dmic_nids = stac9205_dmic_nids;
+	spec->num_dmics = 2;
+	spec->dmux_nid = 0x1d;
 
 	spec->init = stac9205_core_init;
 	spec->mixer = stac9205_mixer;
@@ -2039,12 +2257,12 @@ struct hda_codec_preset snd_hda_preset_s
  	{ .id = 0x83847681, .name = "STAC9220D/9223D A2", .patch = patch_stac922x },
  	{ .id = 0x83847682, .name = "STAC9221 A2", .patch = patch_stac922x },
  	{ .id = 0x83847683, .name = "STAC9221D A2", .patch = patch_stac922x },
- 	{ .id = 0x83847618, .name = "STAC9227", .patch = patch_stac927x },
- 	{ .id = 0x83847619, .name = "STAC9227", .patch = patch_stac927x },
- 	{ .id = 0x83847616, .name = "STAC9228", .patch = patch_stac927x },
- 	{ .id = 0x83847617, .name = "STAC9228", .patch = patch_stac927x },
- 	{ .id = 0x83847614, .name = "STAC9229", .patch = patch_stac927x },
- 	{ .id = 0x83847615, .name = "STAC9229", .patch = patch_stac927x },
+ 	{ .id = 0x83847618, .name = "STAC9227", .patch = patch_stac9227 },
+ 	{ .id = 0x83847619, .name = "STAC9227", .patch = patch_stac9227 },
+ 	{ .id = 0x83847616, .name = "STAC9228", .patch = patch_stac9227 },
+ 	{ .id = 0x83847617, .name = "STAC9228", .patch = patch_stac9227 },
+ 	{ .id = 0x83847614, .name = "STAC9229", .patch = patch_stac9227 },
+ 	{ .id = 0x83847615, .name = "STAC9229", .patch = patch_stac9227 },
  	{ .id = 0x83847620, .name = "STAC9274", .patch = patch_stac927x },
  	{ .id = 0x83847621, .name = "STAC9274D", .patch = patch_stac927x },
  	{ .id = 0x83847622, .name = "STAC9273X", .patch = patch_stac927x },

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
