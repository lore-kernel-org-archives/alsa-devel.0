From: Matt Porter <mporter@embeddedalley.com>
Subject: [PATCH] hda: change sigmatel references to idt
Date: Tue, 9 Jan 2007 14:05:12 -0500
Message-ID: <20070109190512.GA530@mbp.cse.wadsnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from oh.embeddedalley.com (cpe-088197.static.wadsnet.net
	[65.114.88.197])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id AF56E247
	for <alsa-devel@alsa-project.org>; Tue,  9 Jan 2007 20:05:10 +0100 (MET)
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

IDT bought out SigmaTel some time back.  This changes all
references in the code from SigmaTel to IDT to reflect this.
The filename remains the same so people can follow the history
easily.

Signed-off-by: Matt Porter <mporter@embeddedalley.com>

diff -r 4eae1a19406e -r ee44ce334f5c pci/hda/hda_codec.c
--- a/pci/hda/hda_codec.c	Thu Dec 28 13:56:48 2006 +0100
+++ b/pci/hda/hda_codec.c	Tue Jan 09 11:50:24 2007 -0700
@@ -57,7 +57,7 @@ static struct hda_vendor_id hda_vendor_i
 	{ 0x13f6, "C-Media" },
 	{ 0x14f1, "Conexant" },
 	{ 0x434d, "C-Media" },
-	{ 0x8384, "SigmaTel" },
+	{ 0x8384, "IDT" },
 	{} /* terminator */
 };
 
diff -r 4eae1a19406e -r ee44ce334f5c pci/hda/hda_patch.h
--- a/pci/hda/hda_patch.h	Thu Dec 28 13:56:48 2006 +0100
+++ b/pci/hda/hda_patch.h	Tue Jan 09 11:50:24 2007 -0700
@@ -8,8 +8,8 @@ extern struct hda_codec_preset snd_hda_p
 extern struct hda_codec_preset snd_hda_preset_cmedia[];
 /* Analog Devices codecs */
 extern struct hda_codec_preset snd_hda_preset_analog[];
-/* SigmaTel codecs */
-extern struct hda_codec_preset snd_hda_preset_sigmatel[];
+/* IDT codecs */
+extern struct hda_codec_preset snd_hda_preset_idt[];
 /* SiLabs 3054/3055 modem codecs */
 extern struct hda_codec_preset snd_hda_preset_si3054[];
 /* ATI HDMI codecs */
@@ -23,7 +23,7 @@ static const struct hda_codec_preset *hd
 	snd_hda_preset_realtek,
 	snd_hda_preset_cmedia,
 	snd_hda_preset_analog,
-	snd_hda_preset_sigmatel,
+	snd_hda_preset_idt,
 	snd_hda_preset_si3054,
 	snd_hda_preset_atihdmi,
 	snd_hda_preset_conexant,
diff -r 4eae1a19406e -r ee44ce334f5c pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Thu Dec 28 13:56:48 2006 +0100
+++ b/pci/hda/patch_sigmatel.c	Tue Jan 09 11:50:24 2007 -0700
@@ -1,9 +1,9 @@
 /*
  * Universal Interface for Intel High Definition Audio Codec
  *
- * HD audio interface patch for SigmaTel STAC92xx
+ * HD audio interface patch for IDT STAC92xx
  *
- * Copyright (c) 2005 Embedded Alley Solutions, Inc.
+ * Copyright (c) 2005-2007 Embedded Alley Solutions, Inc.
  * Matt Porter <mporter@embeddedalley.com>
  *
  * Based on patch_cmedia.c and patch_realtek.c
@@ -62,7 +62,7 @@ enum {
 	STAC_927X_MODELS
 };
 
-struct sigmatel_spec {
+struct idt_spec {
 	struct snd_kcontrol_new *mixers[4];
 	unsigned int num_mixers;
 
@@ -184,7 +184,7 @@ static int stac92xx_dmux_enum_info(struc
 				   struct snd_ctl_elem_info *uinfo)
 {
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct sigmatel_spec *spec = codec->spec;
+	struct idt_spec *spec = codec->spec;
 	return snd_hda_input_mux_info(spec->dinput_mux, uinfo);
 }
 
@@ -192,7 +192,7 @@ static int stac92xx_dmux_enum_get(struct
 				  struct snd_ctl_elem_value *ucontrol)
 {
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct sigmatel_spec *spec = codec->spec;
+	struct idt_spec *spec = codec->spec;
 
 	ucontrol->value.enumerated.item[0] = spec->cur_dmux;
 	return 0;
@@ -202,7 +202,7 @@ static int stac92xx_dmux_enum_put(struct
 				  struct snd_ctl_elem_value *ucontrol)
 {
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct sigmatel_spec *spec = codec->spec;
+	struct idt_spec *spec = codec->spec;
 
 	return snd_hda_input_mux_put(codec, spec->dinput_mux, ucontrol,
 				     spec->dmux_nid, &spec->cur_dmux);
@@ -211,14 +211,14 @@ static int stac92xx_mux_enum_info(struct
 static int stac92xx_mux_enum_info(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct sigmatel_spec *spec = codec->spec;
+	struct idt_spec *spec = codec->spec;
 	return snd_hda_input_mux_info(spec->input_mux, uinfo);
 }
 
 static int stac92xx_mux_enum_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct sigmatel_spec *spec = codec->spec;
+	struct idt_spec *spec = codec->spec;
 	unsigned int adc_idx = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
 
 	ucontrol->value.enumerated.item[0] = spec->cur_mux[adc_idx];
@@ -228,7 +228,7 @@ static int stac92xx_mux_enum_put(struct 
 static int stac92xx_mux_enum_put(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct sigmatel_spec *spec = codec->spec;
+	struct idt_spec *spec = codec->spec;
 	unsigned int adc_idx = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
 
 	return snd_hda_input_mux_put(codec, spec->input_mux, ucontrol,
@@ -357,7 +357,7 @@ static struct snd_kcontrol_new stac9205_
 
 static int stac92xx_build_controls(struct hda_codec *codec)
 {
-	struct sigmatel_spec *spec = codec->spec;
+	struct idt_spec *spec = codec->spec;
 	int err;
 	int i;
 
@@ -398,7 +398,7 @@ static const char *stac9200_models[STAC_
 };
 
 static struct snd_pci_quirk stac9200_cfg_tbl[] = {
-	/* SigmaTel reference board */
+	/* IDT reference board */
 	SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0x2668,
 		      "DFI LanParty", STAC_REF),
 	/* Dell laptops have BIOS problem */
@@ -444,7 +444,7 @@ static const char *stac922x_models[STAC_
 };
 
 static struct snd_pci_quirk stac922x_cfg_tbl[] = {
-	/* SigmaTel reference board */
+	/* IDT reference board */
 	SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0x2668,
 		      "DFI LanParty", STAC_D945_REF),
 	/* Intel 945G based systems */
@@ -541,7 +541,7 @@ static const char *stac927x_models[STAC_
 };
 
 static struct snd_pci_quirk stac927x_cfg_tbl[] = {
-	/* SigmaTel reference board */
+	/* IDT reference board */
 	SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0x2668,
 		      "DFI LanParty", STAC_D965_REF),
 	 /* Intel 946 based systems */
@@ -592,7 +592,7 @@ static const char *stac9205_models[STAC_
 };
 
 static struct snd_pci_quirk stac9205_cfg_tbl[] = {
-	/* SigmaTel reference board */
+	/* IDT reference board */
 	SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0x2668,
 		      "DFI LanParty", STAC_9205_REF),
 	{} /* terminator */
@@ -601,7 +601,7 @@ static int stac92xx_save_bios_config_reg
 static int stac92xx_save_bios_config_regs(struct hda_codec *codec)
 {
 	int i;
-	struct sigmatel_spec *spec = codec->spec;
+	struct idt_spec *spec = codec->spec;
 	
 	if (! spec->bios_pin_configs) {
 		spec->bios_pin_configs = kcalloc(spec->num_pins,
@@ -627,7 +627,7 @@ static void stac92xx_set_config_regs(str
 static void stac92xx_set_config_regs(struct hda_codec *codec)
 {
 	int i;
-	struct sigmatel_spec *spec = codec->spec;
+	struct idt_spec *spec = codec->spec;
 	unsigned int pin_cfg;
 
 	if (! spec->pin_nids || ! spec->pin_configs)
@@ -660,7 +660,7 @@ static int stac92xx_playback_pcm_open(st
 				      struct hda_codec *codec,
 				      struct snd_pcm_substream *substream)
 {
-	struct sigmatel_spec *spec = codec->spec;
+	struct idt_spec *spec = codec->spec;
 	return snd_hda_multi_out_analog_open(codec, &spec->multiout, substream);
 }
 
@@ -670,7 +670,7 @@ static int stac92xx_playback_pcm_prepare
 					 unsigned int format,
 					 struct snd_pcm_substream *substream)
 {
-	struct sigmatel_spec *spec = codec->spec;
+	struct idt_spec *spec = codec->spec;
 	return snd_hda_multi_out_analog_prepare(codec, &spec->multiout, stream_tag, format, substream);
 }
 
@@ -678,7 +678,7 @@ static int stac92xx_playback_pcm_cleanup
 					struct hda_codec *codec,
 					struct snd_pcm_substream *substream)
 {
-	struct sigmatel_spec *spec = codec->spec;
+	struct idt_spec *spec = codec->spec;
 	return snd_hda_multi_out_analog_cleanup(codec, &spec->multiout);
 }
 
@@ -689,7 +689,7 @@ static int stac92xx_dig_playback_pcm_ope
 					  struct hda_codec *codec,
 					  struct snd_pcm_substream *substream)
 {
-	struct sigmatel_spec *spec = codec->spec;
+	struct idt_spec *spec = codec->spec;
 	return snd_hda_multi_out_dig_open(codec, &spec->multiout);
 }
 
@@ -697,7 +697,7 @@ static int stac92xx_dig_playback_pcm_clo
 					   struct hda_codec *codec,
 					   struct snd_pcm_substream *substream)
 {
-	struct sigmatel_spec *spec = codec->spec;
+	struct idt_spec *spec = codec->spec;
 	return snd_hda_multi_out_dig_close(codec, &spec->multiout);
 }
 
@@ -711,7 +711,7 @@ static int stac92xx_capture_pcm_prepare(
 					unsigned int format,
 					struct snd_pcm_substream *substream)
 {
-	struct sigmatel_spec *spec = codec->spec;
+	struct idt_spec *spec = codec->spec;
 
 	snd_hda_codec_setup_stream(codec, spec->adc_nids[substream->number],
                                    stream_tag, 0, format);
@@ -722,7 +722,7 @@ static int stac92xx_capture_pcm_cleanup(
 					struct hda_codec *codec,
 					struct snd_pcm_substream *substream)
 {
-	struct sigmatel_spec *spec = codec->spec;
+	struct idt_spec *spec = codec->spec;
 
 	snd_hda_codec_setup_stream(codec, spec->adc_nids[substream->number], 0, 0, 0);
 	return 0;
@@ -783,7 +783,7 @@ static struct hda_pcm_stream stac92xx_pc
 
 static int stac92xx_build_pcms(struct hda_codec *codec)
 {
-	struct sigmatel_spec *spec = codec->spec;
+	struct idt_spec *spec = codec->spec;
 	struct hda_pcm *info = spec->pcm_rec;
 
 	codec->num_pcms = 1;
@@ -852,7 +852,7 @@ static int stac92xx_io_switch_get(struct
 static int stac92xx_io_switch_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct sigmatel_spec *spec = codec->spec;
+	struct idt_spec *spec = codec->spec;
 	int io_idx = kcontrol-> private_value & 0xff;
 
 	ucontrol->value.integer.value[0] = spec->io_switch[io_idx];
@@ -862,7 +862,7 @@ static int stac92xx_io_switch_put(struct
 static int stac92xx_io_switch_put(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
         struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct sigmatel_spec *spec = codec->spec;
+	struct idt_spec *spec = codec->spec;
         hda_nid_t nid = kcontrol->private_value >> 8;
 	int io_idx = kcontrol-> private_value & 0xff;
         unsigned short val = ucontrol->value.integer.value[0];
@@ -904,7 +904,7 @@ static struct snd_kcontrol_new stac92xx_
 };
 
 /* add dynamic controls */
-static int stac92xx_add_control(struct sigmatel_spec *spec, int type, const char *name, unsigned long val)
+static int stac92xx_add_control(struct idt_spec *spec, int type, const char *name, unsigned long val)
 {
 	struct snd_kcontrol_new *knew;
 
@@ -935,7 +935,7 @@ static int stac92xx_add_control(struct s
 /* flag inputs as additional dynamic lineouts */
 static int stac92xx_add_dyn_out_pins(struct hda_codec *codec, struct auto_pin_cfg *cfg)
 {
-	struct sigmatel_spec *spec = codec->spec;
+	struct idt_spec *spec = codec->spec;
 
 	switch (cfg->line_outs) {
 	case 3:
@@ -991,7 +991,7 @@ static int stac92xx_auto_fill_dac_nids(s
 static int stac92xx_auto_fill_dac_nids(struct hda_codec *codec,
 				       const struct auto_pin_cfg *cfg)
 {
-	struct sigmatel_spec *spec = codec->spec;
+	struct idt_spec *spec = codec->spec;
 	hda_nid_t nid;
 	int i;
 
@@ -1008,7 +1008,7 @@ static int stac92xx_auto_fill_dac_nids(s
 }
 
 /* create volume control/switch for the given prefx type */
-static int create_controls(struct sigmatel_spec *spec, const char *pfx, hda_nid_t nid, int chs)
+static int create_controls(struct idt_spec *spec, const char *pfx, hda_nid_t nid, int chs)
 {
 	char name[32];
 	int err;
@@ -1027,7 +1027,7 @@ static int create_controls(struct sigmat
 }
 
 /* add playback controls from the parsed DAC table */
-static int stac92xx_auto_create_multi_out_ctls(struct sigmatel_spec *spec,
+static int stac92xx_auto_create_multi_out_ctls(struct idt_spec *spec,
 					       const struct auto_pin_cfg *cfg)
 {
 	static const char *chname[4] = {
@@ -1068,7 +1068,7 @@ static int stac92xx_auto_create_multi_ou
 	return 0;
 }
 
-static int check_in_dac_nids(struct sigmatel_spec *spec, hda_nid_t nid)
+static int check_in_dac_nids(struct idt_spec *spec, hda_nid_t nid)
 {
 	int i;
 
@@ -1081,7 +1081,7 @@ static int check_in_dac_nids(struct sigm
 	return 0;
 }
 
-static int add_spec_dacs(struct sigmatel_spec *spec, hda_nid_t nid)
+static int add_spec_dacs(struct idt_spec *spec, hda_nid_t nid)
 {
 	if (!spec->multiout.hp_nid)
 		spec->multiout.hp_nid = nid;
@@ -1099,7 +1099,7 @@ static int stac92xx_auto_create_hp_ctls(
 static int stac92xx_auto_create_hp_ctls(struct hda_codec *codec,
 					struct auto_pin_cfg *cfg)
 {
-	struct sigmatel_spec *spec = codec->spec;
+	struct idt_spec *spec = codec->spec;
 	hda_nid_t nid;
 	int i, old_num_dacs, err;
 
@@ -1161,7 +1161,7 @@ static int stac92xx_auto_create_dmic_inp
 static int stac92xx_auto_create_dmic_input_ctls(struct hda_codec *codec,
 						const struct auto_pin_cfg *cfg)
 {
-	struct sigmatel_spec *spec = codec->spec;
+	struct idt_spec *spec = codec->spec;
 	struct hda_input_mux *dimux = &spec->private_dimux;
 	hda_nid_t con_lst[HDA_MAX_NUM_INPUTS];
 	int i, j;
@@ -1206,7 +1206,7 @@ found:
 /* create playback/capture controls for input pins */
 static int stac92xx_auto_create_analog_input_ctls(struct hda_codec *codec, const struct auto_pin_cfg *cfg)
 {
-	struct sigmatel_spec *spec = codec->spec;
+	struct idt_spec *spec = codec->spec;
 	struct hda_input_mux *imux = &spec->private_imux;
 	hda_nid_t con_lst[HDA_MAX_NUM_INPUTS];
 	int i, j, k;
@@ -1254,7 +1254,7 @@ static int stac92xx_auto_create_analog_i
 
 static void stac92xx_auto_init_multi_out(struct hda_codec *codec)
 {
-	struct sigmatel_spec *spec = codec->spec;
+	struct idt_spec *spec = codec->spec;
 	int i;
 
 	for (i = 0; i < spec->autocfg.line_outs; i++) {
@@ -1265,7 +1265,7 @@ static void stac92xx_auto_init_multi_out
 
 static void stac92xx_auto_init_hp_out(struct hda_codec *codec)
 {
-	struct sigmatel_spec *spec = codec->spec;
+	struct idt_spec *spec = codec->spec;
 	int i;
 
 	for (i = 0; i < spec->autocfg.hp_outs; i++) {
@@ -1284,7 +1284,7 @@ static void stac92xx_auto_init_hp_out(st
 
 static int stac92xx_parse_auto_config(struct hda_codec *codec, hda_nid_t dig_out, hda_nid_t dig_in)
 {
-	struct sigmatel_spec *spec = codec->spec;
+	struct idt_spec *spec = codec->spec;
 	int err;
 
 	if ((err = snd_hda_parse_pin_def_config(codec,
@@ -1332,7 +1332,7 @@ static int stac9200_auto_create_hp_ctls(
 static int stac9200_auto_create_hp_ctls(struct hda_codec *codec,
 					struct auto_pin_cfg *cfg)
 {
-	struct sigmatel_spec *spec = codec->spec;
+	struct idt_spec *spec = codec->spec;
 	hda_nid_t pin = cfg->hp_pins[0];
 	unsigned int wid_caps;
 
@@ -1350,7 +1350,7 @@ static int stac9200_auto_create_lfe_ctls
 static int stac9200_auto_create_lfe_ctls(struct hda_codec *codec,
 					struct auto_pin_cfg *cfg)
 {
-	struct sigmatel_spec *spec = codec->spec;
+	struct idt_spec *spec = codec->spec;
 	int err;
 	hda_nid_t lfe_pin = 0x0;
 	int i;
@@ -1399,7 +1399,7 @@ static int stac9200_auto_create_lfe_ctls
 
 static int stac9200_parse_auto_config(struct hda_codec *codec)
 {
-	struct sigmatel_spec *spec = codec->spec;
+	struct idt_spec *spec = codec->spec;
 	int err;
 
 	if ((err = snd_hda_parse_pin_def_config(codec, &spec->autocfg, NULL)) < 0)
@@ -1478,7 +1478,7 @@ static void enable_pin_detect(struct hda
 
 static int stac92xx_init(struct hda_codec *codec)
 {
-	struct sigmatel_spec *spec = codec->spec;
+	struct idt_spec *spec = codec->spec;
 	struct auto_pin_cfg *cfg = &spec->autocfg;
 	int i;
 
@@ -1528,7 +1528,7 @@ static int stac92xx_init(struct hda_code
 
 static void stac92xx_free(struct hda_codec *codec)
 {
-	struct sigmatel_spec *spec = codec->spec;
+	struct idt_spec *spec = codec->spec;
 	int i;
 
 	if (! spec)
@@ -1580,7 +1580,7 @@ static int get_pin_presence(struct hda_c
 
 static void stac92xx_hp_detect(struct hda_codec *codec, unsigned int res)
 {
-	struct sigmatel_spec *spec = codec->spec;
+	struct idt_spec *spec = codec->spec;
 	struct auto_pin_cfg *cfg = &spec->autocfg;
 	int i, presence;
 
@@ -1622,7 +1622,7 @@ static void stac92xx_unsol_event(struct 
 #ifdef CONFIG_PM
 static int stac92xx_resume(struct hda_codec *codec)
 {
-	struct sigmatel_spec *spec = codec->spec;
+	struct idt_spec *spec = codec->spec;
 	int i;
 
 	stac92xx_init(codec);
@@ -1651,7 +1651,7 @@ static struct hda_codec_ops stac92xx_pat
 
 static int patch_stac9200(struct hda_codec *codec)
 {
-	struct sigmatel_spec *spec;
+	struct idt_spec *spec;
 	int err;
 
 	spec  = kzalloc(sizeof(*spec), GFP_KERNEL);
@@ -1701,7 +1701,7 @@ static int patch_stac9200(struct hda_cod
 
 static int patch_stac922x(struct hda_codec *codec)
 {
-	struct sigmatel_spec *spec;
+	struct idt_spec *spec;
 	int err;
 
 	spec  = kzalloc(sizeof(*spec), GFP_KERNEL);
@@ -1754,7 +1754,7 @@ static int patch_stac922x(struct hda_cod
 
 static int patch_stac927x(struct hda_codec *codec)
 {
-	struct sigmatel_spec *spec;
+	struct idt_spec *spec;
 	int err;
 
 	spec  = kzalloc(sizeof(*spec), GFP_KERNEL);
@@ -1821,7 +1821,7 @@ static int patch_stac927x(struct hda_cod
 
 static int patch_stac9205(struct hda_codec *codec)
 {
-	struct sigmatel_spec *spec;
+	struct idt_spec *spec;
 	int err;
 
 	spec  = kzalloc(sizeof(*spec), GFP_KERNEL);
@@ -2072,7 +2072,7 @@ static struct snd_pci_quirk stac9872_cfg
 
 static int patch_stac9872(struct hda_codec *codec)
 {
-	struct sigmatel_spec *spec;
+	struct idt_spec *spec;
 	int board_config;
 
 	board_config = snd_hda_check_board_config(codec, STAC_9872_MODELS,
@@ -2125,7 +2125,7 @@ static int patch_stac9872(struct hda_cod
 /*
  * patch entries
  */
-struct hda_codec_preset snd_hda_preset_sigmatel[] = {
+struct hda_codec_preset snd_hda_preset_idt[] = {
  	{ .id = 0x83847690, .name = "STAC9200", .patch = patch_stac9200 },
  	{ .id = 0x83847882, .name = "STAC9220 A1", .patch = patch_stac922x },
  	{ .id = 0x83847680, .name = "STAC9221 A1", .patch = patch_stac922x },

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
