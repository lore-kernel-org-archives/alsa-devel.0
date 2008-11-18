From: Petry Vincent <PVince81@yahoo.fr>
Subject: [PATCH] Added Realtek ALC888 model entry for the Acer
 Aspire 4930G laptop
Date: Tue, 18 Nov 2008 19:21:45 +0800
Message-ID: <4922A549.3070808@yahoo.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040908070101030703030204"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from n19.bullet.mail.mud.yahoo.com (n19.bullet.mail.mud.yahoo.com
	[68.142.206.146]) by alsa0.perex.cz (Postfix) with SMTP id 3FEA72451D
	for <alsa-devel@alsa-project.org>; Tue, 18 Nov 2008 12:21:40 +0100 (CET)
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
--------------040908070101030703030204
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello,

I would like to contribute a patch that adds a model entry for the Acer
Aspire 4930G laptop. Its chipset is a Realtek ALC888S-VC.
The new model is based on the "acer" model and fixes the following bugs
missing features:
- https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4223 Reversed
stereo (invalid report, please close it)
- https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4224 Headphone
jack sense
- https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4225 Internal mic
- channel mode (it was missing from the base acer model)

The model name is "acer-aspire-4930g" but could be renamed to something
more general, if necessary.

See attached patch file. It has been made against alsa-driver-1.0.18a.

Thanks,

Vincent Petry




--------------040908070101030703030204
Content-Type: text/x-patch;
 name="alsa-driver-acer-aspire-4930g.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-driver-acer-aspire-4930g.patch"

diff -Naur alsa-driver-1.0.18a/alsa-kernel/pci/hda/patch_realtek.c alsa-driver-1.0.18a-mod3//alsa-kernel/pci/hda/patch_realtek.c
--- alsa-driver-1.0.18a/alsa-kernel/pci/hda/patch_realtek.c	2008-11-12 18:02:25.000000000 +0800
+++ alsa-driver-1.0.18a-mod3//alsa-kernel/pci/hda/patch_realtek.c	2008-11-16 15:05:40.000000000 +0800
@@ -216,6 +216,7 @@
 	ALC883_TARGA_2ch_DIG,
 	ALC883_ACER,
 	ALC883_ACER_ASPIRE,
+	ALC888_ACER_ASPIRE_4930G,
 	ALC883_MEDION,
 	ALC883_MEDION_MD2,
 	ALC883_LAPTOP_EAPD,
@@ -1152,6 +1153,137 @@
 	}
 }
 
+static int alc888_mux_enum_put(struct snd_kcontrol *kcontrol,
+			       struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct alc_spec *spec = codec->spec;
+	unsigned int adc_idx = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
+	unsigned int mux_idx = adc_idx >= spec->num_mux_defs ? 0 : adc_idx;
+	struct hda_input_mux *imux = &spec->input_mux[mux_idx];
+	hda_nid_t nid = spec->capsrc_nids ?
+		spec->capsrc_nids[adc_idx] : spec->adc_nids[adc_idx];
+	unsigned int *cur_val = &spec->cur_mux[adc_idx];
+	unsigned int i, idx;
+
+	idx = ucontrol->value.enumerated.item[0];
+	if (idx >= imux->num_items)
+		idx = imux->num_items - 1;
+	if (*cur_val == idx)
+		return 0;
+
+	for (i = 0; i < imux->num_items; i++) {
+		unsigned int v = (i == idx) ? 0 : HDA_AMP_MUTE;
+		snd_hda_codec_amp_stereo(codec, nid, HDA_INPUT,
+					 imux->items[i].index,
+					 HDA_AMP_MUTE, v);
+	}
+	*cur_val = idx;
+	return 1;
+}
+
+/*
+ * ALC888 Acer Aspire 4930G model
+ */
+
+static struct hda_verb alc888_acer_aspire_4930g_verbs[] = {
+// Front Mic: set to PIN_IN (empty by default)
+	{ 0x12, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN },
+// Unselect Front Mic by default in input mixer 3
+	{ 0x22, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0xb) },
+	/* enable unsolicited event fpr HP jack */
+	{ 0x15, AC_VERB_SET_UNSOLICITED_ENABLE, ALC880_HP_EVENT | AC_USRSP_EN },
+// Connect Internal HP to front
+	{0x14, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
+	{0x14, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	{0x14, AC_VERB_SET_CONNECT_SEL, 0x00},
+// Connect HP out to front
+	{0x15, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
+	{0x15, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	{0x15, AC_VERB_SET_CONNECT_SEL, 0x00},
+	{ }
+};
+
+#define alc888_mux_enum_info alc_mux_enum_info
+#define alc888_mux_enum_get alc_mux_enum_get
+
+static struct hda_input_mux alc888_acer_aspire_4930g_capture_source[2] = {
+	{
+		.num_items = 3,
+		.items = {
+			{ "Mic", 0x0 },
+			{ "Line", 0x2 },
+			{ "CD", 0x4 },
+		},
+	},
+	{
+		.num_items = 4,
+		.items = {
+			{ "Mic", 0x0 },
+			{ "Line", 0x2 },
+			{ "CD", 0x4 },
+			{ "Front Mic", 0xb }, // front mic only available on second ADC
+		},
+	},
+};
+
+static struct snd_kcontrol_new alc888_acer_aspire_4930g_mixer[] = {
+	HDA_CODEC_VOLUME("Front Playback Volume", 		0x0c, 0x0, HDA_OUTPUT),
+	HDA_BIND_MUTE("Front Playback Switch", 			0x0c, 2, HDA_INPUT),
+	HDA_CODEC_VOLUME("Surround Playback Volume", 	0x0d, 0x0, HDA_OUTPUT),
+	HDA_BIND_MUTE("Surround Playback Switch", 		0x0d, 2, HDA_INPUT),
+	HDA_CODEC_VOLUME_MONO("Center Playback Volume", 0x0e, 1, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME_MONO("LFE Playback Volume", 0x0e, 2, 0x0, HDA_OUTPUT),
+	HDA_BIND_MUTE_MONO("Center Playback Switch", 	0x0e, 1, 2, HDA_INPUT),
+	HDA_BIND_MUTE_MONO("LFE Playback Switch", 		0x0e, 2, 2, HDA_INPUT),
+	HDA_CODEC_VOLUME("Side Playback Volume", 		0x0f, 0x0, HDA_OUTPUT),
+	HDA_BIND_MUTE("Side Playback Switch", 			0x0f, 2, HDA_INPUT),
+	HDA_CODEC_VOLUME("CD Playback Volume", 		0x0b, 0x04, HDA_INPUT),
+	HDA_CODEC_MUTE("CD Playback Switch", 			0x0b, 0x04, HDA_INPUT),
+	HDA_CODEC_VOLUME("Line Playback Volume", 		0x0b, 0x02, HDA_INPUT),
+	HDA_CODEC_MUTE("Line Playback Switch", 			0x0b, 0x02, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Playback Volume", 		0x0b, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost", 				0x18, 0, HDA_INPUT),
+	HDA_CODEC_MUTE("Mic Playback Switch", 			0x0b, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("PC Speaker Playback Volume", 0x0b, 0x05, HDA_INPUT),
+	HDA_CODEC_MUTE("PC Speaker Playback Switch", 0x0b, 0x05, HDA_INPUT),
+	{ } /* end */
+};
+
+static struct snd_kcontrol_new alc888_acer_aspire_4930g_capture_mixer[] = {
+	HDA_CODEC_VOLUME("Capture Volume", 0x08, 0x0, HDA_INPUT),
+	HDA_CODEC_MUTE("Capture Switch", 0x08, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME_IDX("Capture Volume", 1, 0x09, 0x0, HDA_INPUT),
+	HDA_CODEC_MUTE_IDX("Capture Switch", 1, 0x09, 0x0, HDA_INPUT),
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Input Source",
+		.count = 2,
+		.info = alc888_mux_enum_info,
+		.get = alc888_mux_enum_get,
+		.put = alc888_mux_enum_put,
+	},
+	{ } /* end */
+};
+
+static void alc888_acer_aspire_4930g_automute(struct hda_codec *codec)
+{	
+	unsigned int present;
+	present = snd_hda_codec_read(codec, 0x15, 0,
+				     AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
+	// enable or disable the internal HP PIN (regular muting doesn't work)
+	snd_hda_codec_write(codec, 0x14, 0, AC_VERB_SET_PIN_WIDGET_CONTROL,
+			    (present?0x0:PIN_OUT));
+}
+
+static void alc888_acer_aspire_4930g_unsol_event(struct hda_codec *codec, unsigned int res)
+{
+	if ( res >> 26 == ALC880_HP_EVENT )
+	{
+		alc888_acer_aspire_4930g_automute(codec);
+	}
+}
+
 /*
  * ALC880 3-stack model
  *
@@ -8176,6 +8308,7 @@
 	[ALC883_TARGA_2ch_DIG]	= "targa-2ch-dig",
 	[ALC883_ACER]		= "acer",
 	[ALC883_ACER_ASPIRE]	= "acer-aspire",
+	[ALC888_ACER_ASPIRE_4930G]		= "acer-aspire-4930g",
 	[ALC883_MEDION]		= "medion",
 	[ALC883_MEDION_MD2]	= "medion-md2",
 	[ALC883_LAPTOP_EAPD]	= "laptop-eapd",
@@ -8200,6 +8333,7 @@
 	SND_PCI_QUIRK(0x1025, 0x0110, "Acer Aspire", ALC883_ACER_ASPIRE),
 	SND_PCI_QUIRK(0x1025, 0x0112, "Acer Aspire 9303", ALC883_ACER_ASPIRE),
 	SND_PCI_QUIRK(0x1025, 0x0121, "Acer Aspire 5920G", ALC883_ACER_ASPIRE),
+	SND_PCI_QUIRK(0x1025, 0x013e, "Acer Aspire 4930G", ALC888_ACER_ASPIRE_4930G),
 	SND_PCI_QUIRK(0x1025, 0, "Acer laptop", ALC883_ACER), /* default Acer */
 	SND_PCI_QUIRK(0x1028, 0x020d, "Dell Inspiron 530", ALC888_6ST_DELL),
 	SND_PCI_QUIRK(0x103c, 0x2a3d, "HP Pavillion", ALC883_6ST_DIG),
@@ -8370,6 +8504,22 @@
 		.unsol_event = alc883_acer_aspire_unsol_event,
 		.init_hook = alc883_acer_aspire_automute,
 	},
+	[ALC888_ACER_ASPIRE_4930G] = {
+		.mixers = { alc888_acer_aspire_4930g_mixer, alc883_chmode_mixer },
+		.cap_mixer = alc888_acer_aspire_4930g_capture_mixer,
+		.init_verbs = { alc883_init_verbs, alc880_gpio1_init_verbs, 
+				alc888_acer_aspire_4930g_verbs },
+		.num_dacs = ARRAY_SIZE(alc883_dac_nids),
+		.dac_nids = alc883_dac_nids,
+		.dig_out_nid = ALC883_DIGOUT_NID,
+		.num_channel_mode = ARRAY_SIZE(alc883_3ST_6ch_modes),
+		.channel_mode = alc883_3ST_6ch_modes,
+		.need_dac_fix = 1,
+		.num_mux_defs = ARRAY_SIZE(alc888_acer_aspire_4930g_capture_source),
+		.input_mux = alc888_acer_aspire_4930g_capture_source,
+		.unsol_event = alc888_acer_aspire_4930g_unsol_event,
+		.init_hook = alc888_acer_aspire_4930g_automute,
+	},
 	[ALC883_MEDION] = {
 		.mixers = { alc883_fivestack_mixer,
 			    alc883_chmode_mixer },
diff -Naur alsa-driver-1.0.18a/sound/pci/hda/patch_realtek.c alsa-driver-1.0.18a-mod3//sound/pci/hda/patch_realtek.c
--- alsa-driver-1.0.18a/sound/pci/hda/patch_realtek.c	2008-11-12 18:02:25.000000000 +0800
+++ alsa-driver-1.0.18a-mod3//sound/pci/hda/patch_realtek.c	2008-11-16 15:05:40.000000000 +0800
@@ -216,6 +216,7 @@
 	ALC883_TARGA_2ch_DIG,
 	ALC883_ACER,
 	ALC883_ACER_ASPIRE,
+	ALC888_ACER_ASPIRE_4930G,
 	ALC883_MEDION,
 	ALC883_MEDION_MD2,
 	ALC883_LAPTOP_EAPD,
@@ -1152,6 +1153,137 @@
 	}
 }
 
+static int alc888_mux_enum_put(struct snd_kcontrol *kcontrol,
+			       struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct alc_spec *spec = codec->spec;
+	unsigned int adc_idx = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
+	unsigned int mux_idx = adc_idx >= spec->num_mux_defs ? 0 : adc_idx;
+	struct hda_input_mux *imux = &spec->input_mux[mux_idx];
+	hda_nid_t nid = spec->capsrc_nids ?
+		spec->capsrc_nids[adc_idx] : spec->adc_nids[adc_idx];
+	unsigned int *cur_val = &spec->cur_mux[adc_idx];
+	unsigned int i, idx;
+
+	idx = ucontrol->value.enumerated.item[0];
+	if (idx >= imux->num_items)
+		idx = imux->num_items - 1;
+	if (*cur_val == idx)
+		return 0;
+
+	for (i = 0; i < imux->num_items; i++) {
+		unsigned int v = (i == idx) ? 0 : HDA_AMP_MUTE;
+		snd_hda_codec_amp_stereo(codec, nid, HDA_INPUT,
+					 imux->items[i].index,
+					 HDA_AMP_MUTE, v);
+	}
+	*cur_val = idx;
+	return 1;
+}
+
+/*
+ * ALC888 Acer Aspire 4930G model
+ */
+
+static struct hda_verb alc888_acer_aspire_4930g_verbs[] = {
+// Front Mic: set to PIN_IN (empty by default)
+	{ 0x12, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN },
+// Unselect Front Mic by default in input mixer 3
+	{ 0x22, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0xb) },
+	/* enable unsolicited event fpr HP jack */
+	{ 0x15, AC_VERB_SET_UNSOLICITED_ENABLE, ALC880_HP_EVENT | AC_USRSP_EN },
+// Connect Internal HP to front
+	{0x14, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
+	{0x14, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	{0x14, AC_VERB_SET_CONNECT_SEL, 0x00},
+// Connect HP out to front
+	{0x15, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
+	{0x15, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	{0x15, AC_VERB_SET_CONNECT_SEL, 0x00},
+	{ }
+};
+
+#define alc888_mux_enum_info alc_mux_enum_info
+#define alc888_mux_enum_get alc_mux_enum_get
+
+static struct hda_input_mux alc888_acer_aspire_4930g_capture_source[2] = {
+	{
+		.num_items = 3,
+		.items = {
+			{ "Mic", 0x0 },
+			{ "Line", 0x2 },
+			{ "CD", 0x4 },
+		},
+	},
+	{
+		.num_items = 4,
+		.items = {
+			{ "Mic", 0x0 },
+			{ "Line", 0x2 },
+			{ "CD", 0x4 },
+			{ "Front Mic", 0xb }, // front mic only available on second ADC
+		},
+	},
+};
+
+static struct snd_kcontrol_new alc888_acer_aspire_4930g_mixer[] = {
+	HDA_CODEC_VOLUME("Front Playback Volume", 		0x0c, 0x0, HDA_OUTPUT),
+	HDA_BIND_MUTE("Front Playback Switch", 			0x0c, 2, HDA_INPUT),
+	HDA_CODEC_VOLUME("Surround Playback Volume", 	0x0d, 0x0, HDA_OUTPUT),
+	HDA_BIND_MUTE("Surround Playback Switch", 		0x0d, 2, HDA_INPUT),
+	HDA_CODEC_VOLUME_MONO("Center Playback Volume", 0x0e, 1, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME_MONO("LFE Playback Volume", 0x0e, 2, 0x0, HDA_OUTPUT),
+	HDA_BIND_MUTE_MONO("Center Playback Switch", 	0x0e, 1, 2, HDA_INPUT),
+	HDA_BIND_MUTE_MONO("LFE Playback Switch", 		0x0e, 2, 2, HDA_INPUT),
+	HDA_CODEC_VOLUME("Side Playback Volume", 		0x0f, 0x0, HDA_OUTPUT),
+	HDA_BIND_MUTE("Side Playback Switch", 			0x0f, 2, HDA_INPUT),
+	HDA_CODEC_VOLUME("CD Playback Volume", 		0x0b, 0x04, HDA_INPUT),
+	HDA_CODEC_MUTE("CD Playback Switch", 			0x0b, 0x04, HDA_INPUT),
+	HDA_CODEC_VOLUME("Line Playback Volume", 		0x0b, 0x02, HDA_INPUT),
+	HDA_CODEC_MUTE("Line Playback Switch", 			0x0b, 0x02, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Playback Volume", 		0x0b, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost", 				0x18, 0, HDA_INPUT),
+	HDA_CODEC_MUTE("Mic Playback Switch", 			0x0b, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("PC Speaker Playback Volume", 0x0b, 0x05, HDA_INPUT),
+	HDA_CODEC_MUTE("PC Speaker Playback Switch", 0x0b, 0x05, HDA_INPUT),
+	{ } /* end */
+};
+
+static struct snd_kcontrol_new alc888_acer_aspire_4930g_capture_mixer[] = {
+	HDA_CODEC_VOLUME("Capture Volume", 0x08, 0x0, HDA_INPUT),
+	HDA_CODEC_MUTE("Capture Switch", 0x08, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME_IDX("Capture Volume", 1, 0x09, 0x0, HDA_INPUT),
+	HDA_CODEC_MUTE_IDX("Capture Switch", 1, 0x09, 0x0, HDA_INPUT),
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Input Source",
+		.count = 2,
+		.info = alc888_mux_enum_info,
+		.get = alc888_mux_enum_get,
+		.put = alc888_mux_enum_put,
+	},
+	{ } /* end */
+};
+
+static void alc888_acer_aspire_4930g_automute(struct hda_codec *codec)
+{	
+	unsigned int present;
+	present = snd_hda_codec_read(codec, 0x15, 0,
+				     AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
+	// enable or disable the internal HP PIN (regular muting doesn't work)
+	snd_hda_codec_write(codec, 0x14, 0, AC_VERB_SET_PIN_WIDGET_CONTROL,
+			    (present?0x0:PIN_OUT));
+}
+
+static void alc888_acer_aspire_4930g_unsol_event(struct hda_codec *codec, unsigned int res)
+{
+	if ( res >> 26 == ALC880_HP_EVENT )
+	{
+		alc888_acer_aspire_4930g_automute(codec);
+	}
+}
+
 /*
  * ALC880 3-stack model
  *
@@ -8176,6 +8308,7 @@
 	[ALC883_TARGA_2ch_DIG]	= "targa-2ch-dig",
 	[ALC883_ACER]		= "acer",
 	[ALC883_ACER_ASPIRE]	= "acer-aspire",
+	[ALC888_ACER_ASPIRE_4930G]		= "acer-aspire-4930g",
 	[ALC883_MEDION]		= "medion",
 	[ALC883_MEDION_MD2]	= "medion-md2",
 	[ALC883_LAPTOP_EAPD]	= "laptop-eapd",
@@ -8200,6 +8333,7 @@
 	SND_PCI_QUIRK(0x1025, 0x0110, "Acer Aspire", ALC883_ACER_ASPIRE),
 	SND_PCI_QUIRK(0x1025, 0x0112, "Acer Aspire 9303", ALC883_ACER_ASPIRE),
 	SND_PCI_QUIRK(0x1025, 0x0121, "Acer Aspire 5920G", ALC883_ACER_ASPIRE),
+	SND_PCI_QUIRK(0x1025, 0x013e, "Acer Aspire 4930G", ALC888_ACER_ASPIRE_4930G),
 	SND_PCI_QUIRK(0x1025, 0, "Acer laptop", ALC883_ACER), /* default Acer */
 	SND_PCI_QUIRK(0x1028, 0x020d, "Dell Inspiron 530", ALC888_6ST_DELL),
 	SND_PCI_QUIRK(0x103c, 0x2a3d, "HP Pavillion", ALC883_6ST_DIG),
@@ -8370,6 +8504,22 @@
 		.unsol_event = alc883_acer_aspire_unsol_event,
 		.init_hook = alc883_acer_aspire_automute,
 	},
+	[ALC888_ACER_ASPIRE_4930G] = {
+		.mixers = { alc888_acer_aspire_4930g_mixer, alc883_chmode_mixer },
+		.cap_mixer = alc888_acer_aspire_4930g_capture_mixer,
+		.init_verbs = { alc883_init_verbs, alc880_gpio1_init_verbs, 
+				alc888_acer_aspire_4930g_verbs },
+		.num_dacs = ARRAY_SIZE(alc883_dac_nids),
+		.dac_nids = alc883_dac_nids,
+		.dig_out_nid = ALC883_DIGOUT_NID,
+		.num_channel_mode = ARRAY_SIZE(alc883_3ST_6ch_modes),
+		.channel_mode = alc883_3ST_6ch_modes,
+		.need_dac_fix = 1,
+		.num_mux_defs = ARRAY_SIZE(alc888_acer_aspire_4930g_capture_source),
+		.input_mux = alc888_acer_aspire_4930g_capture_source,
+		.unsol_event = alc888_acer_aspire_4930g_unsol_event,
+		.init_hook = alc888_acer_aspire_4930g_automute,
+	},
 	[ALC883_MEDION] = {
 		.mixers = { alc883_fivestack_mixer,
 			    alc883_chmode_mixer },


--------------040908070101030703030204
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------040908070101030703030204--
