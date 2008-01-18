From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: Added mono mux mixer for some
	STAC92HD7XXX family codecs
Date: Fri, 18 Jan 2008 16:44:42 -0500
Message-ID: <47911DCA.9070104@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp107.biz.mail.mud.yahoo.com (smtp107.biz.mail.mud.yahoo.com
	[68.142.200.255]) by alsa0.perex.cz (Postfix) with SMTP id 3C2E4246BA
	for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2008 22:44:51 +0100 (CET)
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

Some 92HD7XXX family codecs have a mono mux, added support for selecting the input path to the mono out.

Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
---
diff -r a035d5e4801c pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Fri Jan 18 15:32:32 2008 +0100
+++ b/pci/hda/patch_sigmatel.c	Fri Jan 18 14:53:36 2008 -0500
@@ -131,6 +131,8 @@ struct sigmatel_spec {
 	hda_nid_t *pwr_nids;
 
 	/* playback */
+	struct hda_input_mux *mono_mux;
+	unsigned int cur_mmux;
 	struct hda_multi_out multiout;
 	hda_nid_t dac_nids[5];
 
@@ -144,6 +146,7 @@ struct sigmatel_spec {
 	hda_nid_t *dmux_nids;
 	unsigned int num_dmuxes;
 	hda_nid_t dig_in_nid;
+	hda_nid_t mono_nid;
 
 	/* pin widgets */
 	hda_nid_t *pin_nids;
@@ -399,6 +402,31 @@ static int stac92xx_mux_enum_put(struct 
 
 	return snd_hda_input_mux_put(codec, spec->input_mux, ucontrol,
 				     spec->mux_nids[adc_idx], &spec->cur_mux[adc_idx]);
+}
+
+static int stac92xx_mono_mux_enum_info(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct sigmatel_spec *spec = codec->spec;
+	return snd_hda_input_mux_info(spec->mono_mux, uinfo);
+}
+
+static int stac92xx_mono_mux_enum_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct sigmatel_spec *spec = codec->spec;
+
+	ucontrol->value.enumerated.item[0] = spec->cur_mmux;
+	return 0;
+}
+
+static int stac92xx_mono_mux_enum_put(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct sigmatel_spec *spec = codec->spec;
+
+	return snd_hda_input_mux_put(codec, spec->mono_mux, ucontrol,
+				     spec->mono_nid, &spec->cur_mmux);
 }
 
 #define stac92xx_aloopback_info snd_ctl_boolean_mono_info
@@ -603,6 +631,16 @@ static struct hda_verb stac9205_core_ini
 	{}
 };
 
+#define STAC_MONO_MUX \
+	{ \
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+		.name = "Mono Mux", \
+		.count = 1, \
+		.info = stac92xx_mono_mux_enum_info, \
+		.get = stac92xx_mono_mux_enum_get, \
+		.put = stac92xx_mono_mux_enum_put, \
+	}
+
 #define STAC_INPUT_SOURCE(cnt) \
 	{ \
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
@@ -714,6 +752,7 @@ static struct snd_kcontrol_new stac92hd7
 
 static struct snd_kcontrol_new stac92hd71bxx_analog_mixer[] = {
 	STAC_INPUT_SOURCE(2),
+	STAC_MONO_MUX,
 
 	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x0, 0x1c, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE_IDX("Capture Switch", 0x0, 0x1c, 0x0, HDA_OUTPUT),
@@ -733,6 +772,7 @@ static struct snd_kcontrol_new stac92hd7
 static struct snd_kcontrol_new stac92hd71bxx_mixer[] = {
 	STAC_INPUT_SOURCE(2),
 	STAC_ANALOG_LOOPBACK(0xFA0, 0x7A0, 2),
+	STAC_MONO_MUX,
 
 	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x0, 0x1c, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE_IDX("Capture Switch", 0x0, 0x1c, 0x0, HDA_OUTPUT),
@@ -1180,7 +1220,7 @@ static struct snd_pci_quirk stac92hd73xx
 
 static unsigned int ref92hd71bxx_pin_configs[10] = {
 	0x02214030, 0x02a19040, 0x01a19020, 0x01014010,
-	0x0181302e, 0x01114010, 0x01a19020, 0x90a000f0,
+	0x0181302e, 0x01114010, 0x01019020, 0x90a000f0,
 	0x90a000f0, 0x01452050,
 };
 
@@ -3188,6 +3228,16 @@ again:
 	return 0;
 }
 
+static struct hda_input_mux stac92hd71bxx_mono_mux = {
+	/* count set later */
+	.items = {
+		{ "DAC0",  0x0 },
+		{ "DAC1",  0x1 },
+		/* not an option on all cards */
+		{ "Mixer", 0x2 },
+	 },
+};
+
 static int patch_stac92hd71bxx(struct hda_codec *codec)
 {
 	struct sigmatel_spec *spec;
@@ -3224,10 +3274,12 @@ again:
 	case 0x111d76b7:
 	case 0x111d76b4: /* 6 Port without Analog Mixer */
 	case 0x111d76b5:
+		stac92hd71bxx_mono_mux.num_items = 2,
 		spec->mixer = stac92hd71bxx_mixer;
 		spec->init = stac92hd71bxx_core_init;
 		break;
 	default:
+		stac92hd71bxx_mono_mux.num_items = 3,
 		spec->mixer = stac92hd71bxx_analog_mixer;
 		spec->init = stac92hd71bxx_analog_core_init;
 	}
@@ -3237,6 +3289,8 @@ again:
 
 	spec->gpio_mask = spec->gpio_data = 0x00000001; /* GPIO0 High = EAPD */
 
+	spec->mono_mux = &stac92hd71bxx_mono_mux;
+	spec->mono_nid = 0x15;
 	spec->mux_nids = stac92hd71bxx_mux_nids;
 	spec->adc_nids = stac92hd71bxx_adc_nids;
 	spec->dmic_nids = stac92hd71bxx_dmic_nids;
