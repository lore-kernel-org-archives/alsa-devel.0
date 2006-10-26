From: Matt Porter <mporter@embeddedalley.com>
Subject: [PATCH] hda: add dig mic support for sigmatel codecs
Date: Thu, 26 Oct 2006 10:40:50 -0400
Message-ID: <20061026144050.GC1507@matthew-porters-computer.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from oh.embeddedalley.com (cpe-088197.static.wadsnet.net
	[65.114.88.197])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 408A7193
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Oct 2006 16:40:51 +0200 (MEST)
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
To: alsa-devel@alsa-project.org, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Adds support for digital microphone pin widgets on SigmaTel codecs.
Enables support only on the 9205 codecs for now. 

Signed-off-by: Matt Porter <mporter@embeddedalley.com>

diff -r c4d2375b7e9e pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Tue Oct 24 19:49:39 2006 +0200
+++ b/pci/hda/patch_sigmatel.c	Thu Oct 26 07:27:54 2006 -0700
@@ -44,7 +44,7 @@
 #define STAC_922X_MODELS	4	/* number of 922x models */
 #define STAC_D965_3ST		4
 #define STAC_D965_5ST		5
-#define STAC_927X_MODELS	6	/* number of 922x models */
+#define STAC_927X_MODELS	6	/* number of 927x models */
 
 struct sigmatel_spec {
 	struct snd_kcontrol_new *mixers[4];
@@ -67,6 +67,9 @@ struct sigmatel_spec {
 	unsigned int num_adcs;
 	hda_nid_t *mux_nids;
 	unsigned int num_muxes;
+	hda_nid_t *dmic_nids;
+	unsigned int num_dmics;
+	hda_nid_t dmux_nid;
 	hda_nid_t dig_in_nid;
 
 	/* pin widgets */
@@ -80,6 +83,8 @@ struct sigmatel_spec {
 	struct snd_kcontrol_new *mixer;
 
 	/* capture source */
+	struct hda_input_mux *dinput_mux;
+	unsigned int cur_dmux;
 	struct hda_input_mux *input_mux;
 	unsigned int cur_mux[3];
 
@@ -92,6 +97,7 @@ struct sigmatel_spec {
 	struct auto_pin_cfg autocfg;
 	unsigned int num_kctl_alloc, num_kctl_used;
 	struct snd_kcontrol_new *kctl_alloc;
+	struct hda_input_mux private_dimux;
 	struct hda_input_mux private_imux;
 };
 
@@ -129,6 +135,10 @@ static hda_nid_t stac9205_adc_nids[2] = 
 
 static hda_nid_t stac9205_mux_nids[2] = {
         0x19, 0x1a
+};
+
+static hda_nid_t stac9205_dmic_nids[3] = {
+        0x17, 0x18, 0
 };
 
 static hda_nid_t stac9200_pin_nids[8] = {
@@ -153,6 +163,34 @@ static hda_nid_t stac9205_pin_nids[12] =
 	0x21, 0x22,
 	
 };
+
+static int stac92xx_dmux_enum_info(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_info *uinfo)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct sigmatel_spec *spec = codec->spec;
+	return snd_hda_input_mux_info(spec->dinput_mux, uinfo);
+}
+
+static int stac92xx_dmux_enum_get(struct snd_kcontrol *kcontrol,
+				  struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct sigmatel_spec *spec = codec->spec;
+
+	ucontrol->value.enumerated.item[0] = spec->cur_dmux;
+	return 0;
+}
+
+static int stac92xx_dmux_enum_put(struct snd_kcontrol *kcontrol,
+				  struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct sigmatel_spec *spec = codec->spec;
+
+	return snd_hda_input_mux_put(codec, spec->dinput_mux, ucontrol,
+				     spec->dmux_nid, &spec->cur_dmux);
+}
 
 static int stac92xx_mux_enum_info(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
@@ -281,6 +319,14 @@ static snd_kcontrol_new_t stac9205_mixer
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
@@ -578,8 +624,8 @@ static struct hda_board_config stac927x_
 
 static unsigned int ref9205_pin_configs[12] = {
 	0x40000100, 0x40000100, 0x01016011, 0x01014010,
-	0x01813122, 0x01a19021, 0x40000100, 0x40000100, 
-	0x40000100, 0x40000100, 0x01441030, 0x01c41030
+	0x01813122, 0x01a19021, 0x40000100, 0x40000100,
+	0x90a000f0, 0x90a000f0, 0x01441030, 0x01c41030
 };
 
 static unsigned int *stac9205_brd_tbl[] = {
@@ -1154,6 +1200,58 @@ static int stac92xx_auto_create_hp_ctls(
 	return 0;
 }
 
+/* labels for dmic mux inputs */
+const char *stac92xx_dmic_labels[5] = {
+	"Analog Inputs", "Digital Mic 1", "Digital Mic 2",
+	"Digital Mic 3", "Digital Mic 4"
+};
+
+/* create playback/capture controls for input pins on dmic capable codecs */
+static int stac92xx_auto_create_dmic_input_ctls(struct hda_codec *codec,
+						const struct auto_pin_cfg *cfg)
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
+		unsigned int def_conf;
+
+		def_conf = snd_hda_codec_read(codec,
+					      spec->dmic_nids[i],
+					      0,
+					      AC_VERB_GET_CONFIG_DEFAULT,
+					      0);
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
+		dimux->items[dimux->num_items].label =
+			stac92xx_dmic_labels[dimux->num_items];
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
@@ -1238,7 +1336,9 @@ static int stac92xx_parse_auto_config(st
 	struct sigmatel_spec *spec = codec->spec;
 	int err;
 
-	if ((err = snd_hda_parse_pin_def_config(codec, &spec->autocfg, NULL)) < 0)
+	if ((err = snd_hda_parse_pin_def_config(codec,
+						&spec->autocfg,
+						spec->dmic_nids)) < 0)
 		return err;
 	if (! spec->autocfg.line_outs)
 		return 0; /* can't find valid pin config */
@@ -1254,6 +1354,11 @@ static int stac92xx_parse_auto_config(st
 	    (err = stac92xx_auto_create_analog_input_ctls(codec, &spec->autocfg)) < 0)
 		return err;
 
+	if (spec->num_dmics > 0)
+		if ((err = stac92xx_auto_create_dmic_input_ctls(codec,
+						&spec->autocfg)) < 0)
+			return err;
+
 	spec->multiout.max_channels = spec->multiout.num_dacs * 2;
 	if (spec->multiout.max_channels > 2)
 		spec->surr_switch = 1;
@@ -1267,6 +1372,7 @@ static int stac92xx_parse_auto_config(st
 		spec->mixers[spec->num_mixers++] = spec->kctl_alloc;
 
 	spec->input_mux = &spec->private_imux;
+	spec->dinput_mux = &spec->private_dimux;
 
 	return 1;
 }
@@ -1366,6 +1472,7 @@ static int stac9200_parse_auto_config(st
 		spec->mixers[spec->num_mixers++] = spec->kctl_alloc;
 
 	spec->input_mux = &spec->private_imux;
+	spec->dinput_mux = &spec->private_dimux;
 
 	return 1;
 }
@@ -1448,6 +1555,11 @@ static int stac92xx_init(struct hda_code
 			stac92xx_auto_set_pinctl(codec, nid, pinctl);
 		}
 	}
+	if (spec->num_dmics > 0)
+		for (i = 0; i < spec->num_dmics; i++)
+			stac92xx_auto_set_pinctl(codec, spec->dmic_nids[i],
+						 AC_PINCTL_IN_EN);
+
 	if (cfg->dig_out_pin)
 		stac92xx_auto_set_pinctl(codec, cfg->dig_out_pin,
 					 AC_PINCTL_OUT_EN);
@@ -1618,6 +1730,7 @@ static int patch_stac9200(struct hda_cod
 	spec->adc_nids = stac9200_adc_nids;
 	spec->mux_nids = stac9200_mux_nids;
 	spec->num_muxes = 1;
+	spec->num_dmics = 0;
 
 	spec->init = stac9200_core_init;
 	spec->mixer = stac9200_mixer;
@@ -1663,6 +1776,7 @@ static int patch_stac922x(struct hda_cod
 	spec->adc_nids = stac922x_adc_nids;
 	spec->mux_nids = stac922x_mux_nids;
 	spec->num_muxes = 2;
+	spec->num_dmics = 0;
 
 	spec->init = stac922x_core_init;
 	spec->mixer = stac922x_mixer;
@@ -1714,6 +1828,7 @@ static int patch_stac927x(struct hda_cod
 		spec->adc_nids = stac927x_adc_nids;
 		spec->mux_nids = stac927x_mux_nids;
 		spec->num_muxes = 3;
+		spec->num_dmics = 0;
 		spec->init = d965_core_init;
 		spec->mixer = stac9227_mixer;
 		break;
@@ -1721,6 +1836,7 @@ static int patch_stac927x(struct hda_cod
 		spec->adc_nids = stac927x_adc_nids;
 		spec->mux_nids = stac927x_mux_nids;
 		spec->num_muxes = 3;
+		spec->num_dmics = 0;
 		spec->init = d965_core_init;
 		spec->mixer = stac9227_mixer;
 		break;
@@ -1728,6 +1844,7 @@ static int patch_stac927x(struct hda_cod
 		spec->adc_nids = stac927x_adc_nids;
 		spec->mux_nids = stac927x_mux_nids;
 		spec->num_muxes = 3;
+		spec->num_dmics = 0;
 		spec->init = stac927x_core_init;
 		spec->mixer = stac927x_mixer;
 	}
@@ -1773,7 +1890,10 @@ static int patch_stac9205(struct hda_cod
 
 	spec->adc_nids = stac9205_adc_nids;
 	spec->mux_nids = stac9205_mux_nids;
-	spec->num_muxes = 3;
+	spec->num_muxes = 2;
+	spec->dmic_nids = stac9205_dmic_nids;
+	spec->num_dmics = 2;
+	spec->dmux_nid = 0x1d;
 
 	spec->init = stac9205_core_init;
 	spec->mixer = stac9205_mixer;

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
