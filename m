From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Subject: Re: Support for Compaq Presario F700 - model 755US -
	NVidia MCP67 Audio - Codec Conexant 5051
Date: Sat, 19 Jan 2008 21:23:29 -0200
Message-ID: <200801192123.29589.herton@mandriva.com.br>
References: <200801181655.05217.philippe@paravicini.com>
	<1200743818.5011.247.camel@razman.gruemaster.com>
	<5f52f6d70801190645y5cf92b42ved1c7becc2376c70@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_xZokHWc4Wn/zjuQ"
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <5f52f6d70801190645y5cf92b42ved1c7becc2376c70@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Claudio Matsuoka <cmatsuoka@gmail.com>
Cc: alsa-devel@alsa-project.org, alsa-user@alsa-project.org, Philippe Paravicini <philippe@paravicini.com>
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_xZokHWc4Wn/zjuQ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Em Saturday 19 January 2008 12:45:52 Claudio Matsuoka escreveu:
> On Jan 19, 2008 9:56 AM, Tobin Davis <tdavis@dsl-only.net> wrote:
> > I have already requested documentation and a development board from
> > Conexant, so I should be able to get a fully functional driver going
> > soon.  In the meantime, I'll try to get a test patch out to you as soon
> > as possible.
>
> If this is the Hermosa codec (see
> http://helllabs.org/codecgraph/out/hp-spartan-ng.svg), Herton has just
> finished fully functional support to it, based on the HP "Spartan 1.1"

Yes, it was working, but there were some things to sort out, like the Spartan 
1.1 doesn't have to switch between capture source as each mic (int, ext) has 
its own adc, and I hacked it without removing the capture source from mixer.

Also I worked on the same code provided by hsfmodem, that already has support 
for 5051, but I don't know why it wasn't sent upstream yet by 
Conexant/hsfmodem people.

> laptop (subdevice ID is 14f1:5051).
>
> Herton, did you submit the patches for Hermosa support to the list?

No, as I didn't fixed the patches for proper submission, and the part of 
hsfmodem probably Conexant/Linuxant people should send with proper 
Signed-offs etc. But anyway I'll attach here the patches for reference, that 
are not ready for inclusion and will not apply to current alsa tree.

The patch that adds code with support for the Hermosa chip is entirely from 
hsfmodem-7.68.00.04full [1]. Note that hsfmodem has its proprietary part but 
this is only GPL code, and Linuxant also adds a Copyright for this code at 
the start of the patch_conexant.c that isn't in this patch ("Copyright (c) 
2005-2006 Linuxant Inc."), as this patch applies above others in local tree 
here that after integrates with hsfmodem licensed by HP (copyright line is 
added by another patch).

The other patch is my hacked modifications to support the Spartan 1.1 (yes, 
it's ugly, should be a separate model), that also needs to remove Capture 
Source mixer item that doesn't make sense for it.

[1]
http://www.linuxant.com/drivers/hsf/full/downloads.php -> 
http://www.linuxant.com/drivers/hsf/full/archive/hsfmodem-7.68.00.04full/hsfmodem-7.68.00.04full.tar.gz

--
[]'s
Herton

--Boundary-00=_xZokHWc4Wn/zjuQ
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="alsa-add-support-for-Conexant-CX20561-Hermosa-chip.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="alsa-add-support-for-Conexant-CX20561-Hermosa-chip.patch"

Conexant 5051 support from hsfmodem-7.68.00.04full
(http://www.linuxant.com/drivers/hsf/full/archive/hsfmodem-7.68.00.04full/hsfmodem-7.68.00.04full.tar.gz)

--- linux-2.6.23/sound/pci/hda/patch_conexant.c.orig	2007-12-12 17:22:57.000000000 -0200
+++ linux-2.6.23/sound/pci/hda/patch_conexant.c	2007-12-12 17:28:26.000000000 -0200
@@ -1641,11 +1641,357 @@ static int patch_cxt5047(struct hda_code
 	return 0;
 }
 
+
+/* Conexant 5051 specific */
+static hda_nid_t cxt5051_dac_nids[1] = { 0x10 };
+static hda_nid_t cxt5051_adc_nids[1] = { 0x14 };
+static hda_nid_t cxt5051_capsrc_nids[1] = { 0x14 };
+#define CXT5051_SPDIF_OUT	0x1C
+#define CXT5051_PORTB_EVENT	0x38
+#define CXT5051_PORTC_EVENT	0x39
+
+static struct hda_channel_mode cxt5051_modes[1] = {
+	{ 2, NULL },
+};
+
+static struct hda_input_mux cxt5051_capture_source = {
+	.num_items = 2,
+	.items = {
+		{ "IntMic", 0x1 },
+		{ "LineIn", 0x2 },
+	}
+};
+
+/* turn on/off EAPD (+ mute HP) as a master switch */
+static int cxt5051_hp_master_sw_put(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol)
+{
+	static struct hda_verb spk_on[] = {
+		{0x1A, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
+		{}
+	};
+	static struct hda_verb spk_off[] = {
+		{0x1A, AC_VERB_SET_PIN_WIDGET_CONTROL, 0},
+		{}
+	};
+	static struct hda_verb hp_on[] = {
+		{0x16, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
+		{}
+	};
+	static struct hda_verb hp_off[] = {
+		{0x16, AC_VERB_SET_PIN_WIDGET_CONTROL, 0},
+		{}
+	};
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct conexant_spec *spec = codec->spec;
+	unsigned int bits;
+
+	if (!cxt_eapd_put(kcontrol, ucontrol))
+		return 0;
+
+	/* toggle internal speakers mute depending of presence of
+	 * the headphone jack
+	 */
+	bits = (!spec->hp_present && spec->cur_eapd) ? 0 : 0x80;
+	if (bits)
+		snd_hda_sequence_write(codec, spk_off);
+	else
+		snd_hda_sequence_write(codec, spk_on);
+
+	bits = (spec->cur_eapd) ? 0 : 0x80;
+	if (bits)
+		snd_hda_sequence_write(codec, hp_off);
+	else
+		snd_hda_sequence_write(codec, hp_on);
+
+	return 1;
+}
+
+/* bind volumes of both NID 0x10 and 0x11 */
+static int cxt5051_hp_master_vol_put(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	long *valp = ucontrol->value.integer.value;
+	int change;
+
+	change = snd_hda_codec_amp_update(codec, 0x10, 0, HDA_OUTPUT, 0,
+					  0x7f, valp[0] & 0x7f);
+	change |= snd_hda_codec_amp_update(codec, 0x10, 1, HDA_OUTPUT, 0,
+					   0x7f, valp[1] & 0x7f);
+	return change;
+}
+
+/* toggle input of built-in and mic jack appropriately */
+static void cxt5051_portb_automic(struct hda_codec *codec)
+{
+	static struct hda_verb mic_jack_on[] = {
+		{0x14, AC_VERB_SET_CONNECT_SEL,0x1},
+		{}
+	};
+	static struct hda_verb mic_jack_off[] = {
+		{0x14, AC_VERB_SET_CONNECT_SEL,0x1},
+		{}
+	};
+	unsigned int present;
+
+	present = snd_hda_codec_read(codec, 0x17, 0,
+				     AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
+	printk(KERN_DEBUG"cxt5051_portb_automic present =%x\n",present);
+
+	if (present)
+		snd_hda_sequence_write(codec, mic_jack_on);
+	else
+		snd_hda_sequence_write(codec, mic_jack_off);
+
+}
+
+static void cxt5051_portc_automic(struct hda_codec *codec)
+{
+/*
+	static struct hda_verb mic_jack_on[] = {
+		{}
+	};
+	static struct hda_verb mic_jack_off[] = {
+		{}
+	};
+	unsigned int present;
+
+	present = snd_hda_codec_read(codec, 0x18, 0,
+				     AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
+	printk(KERN_DEBUG"cxt5051_portc_automic present =%x\n",present);
+
+	if (present)
+		snd_hda_sequence_write(codec, mic_jack_on);
+	else
+		snd_hda_sequence_write(codec, mic_jack_off);
+*/
+}
+
+/* mute internal speaker if HP is plugged */
+static void cxt5051_hp_automute(struct hda_codec *codec)
+{
+	static struct hda_verb spk_on[] = {
+		{0x1A, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
+		{}
+	};
+	static struct hda_verb spk_off[] = {
+		{0x1A, AC_VERB_SET_PIN_WIDGET_CONTROL, 0},
+		{}
+	};
+
+	struct conexant_spec *spec = codec->spec;
+	unsigned int bits;
+
+	spec->hp_present = snd_hda_codec_read(codec, 0x16, 0,
+				     AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
+
+
+	bits = (spec->hp_present || !spec->cur_eapd) ? 0x80 : 0; 
+	if (bits)
+		snd_hda_sequence_write(codec, spk_off);
+	else
+		snd_hda_sequence_write(codec, spk_on);
+
+	printk(KERN_DEBUG"cxt5051_hp_automute bits =%x\n",bits);
+}
+
+/* unsolicited event for HP jack sensing */
+static void cxt5051_hp_unsol_event(struct hda_codec *codec,
+				   unsigned int res)
+{
+	switch (res >> 26) {
+	case CONEXANT_HP_EVENT:
+		cxt5051_hp_automute(codec);
+		break;
+	case CXT5051_PORTB_EVENT:
+		cxt5051_portb_automic(codec);
+		break;
+	case CXT5051_PORTC_EVENT:
+		cxt5051_portc_automic(codec);
+		break;
+
+	default:
+		conexant_unsol_event(codec, res);
+		break;
+
+	}
+}
+
+static struct snd_kcontrol_new cxt5051_mixers[] = {
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Capture Source",
+		.info = conexant_mux_enum_info,
+		.get = conexant_mux_enum_get,
+		.put = conexant_mux_enum_put
+	},
+//	HDA_CODEC_VOLUME("Int Mic Volume", 0x14, 0x00, HDA_INPUT),
+//	HDA_CODEC_MUTE("Int Mic Switch", 0x14, 0x00, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Volume", 0x14, 0x01, HDA_INPUT),
+	HDA_CODEC_MUTE("Mic Switch", 0x14, 0x01, HDA_INPUT),
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Master Playback Volume",
+		.info = snd_hda_mixer_amp_volume_info,
+		.get = snd_hda_mixer_amp_volume_get,
+		.put = cxt5051_hp_master_vol_put,
+		.private_value = HDA_COMPOSE_AMP_VAL(0x10, 3, 0, HDA_OUTPUT),
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Master Playback Switch",
+		.info = cxt_eapd_info,
+		.get = cxt_eapd_get,
+		.put = cxt5051_hp_master_sw_put,
+		.private_value = 0x1A,
+	},
+
+	{}
+};
+
+static struct hda_verb cxt5051_init_verbs[] = {
+	/* Line in, Mic */
+	{0x17, AC_VERB_SET_AMP_GAIN_MUTE,AC_AMP_SET_INPUT|AC_AMP_SET_LEFT
+	|AC_AMP_SET_RIGHT|0x2},
+	{0x17, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN|AC_PINCTL_VREF_80 },
+	{0x18, AC_VERB_SET_AMP_GAIN_MUTE,AC_AMP_SET_INPUT|AC_AMP_SET_LEFT
+	|AC_AMP_SET_RIGHT|0x2},
+	{0x18, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN|AC_PINCTL_VREF_80 },
+	{0x1D, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN},
+	/* SPK  */
+	{0x1A, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT },
+	{0x1A, AC_VERB_SET_CONNECT_SEL,0x00},
+	/* HP, Amp  */
+	{0x16, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_HP|PIN_OUT },
+	{0x16, AC_VERB_SET_CONNECT_SEL,0x00},
+	/* DAC1 */	
+	{0x10, AC_VERB_SET_AMP_GAIN_MUTE,
+	 AC_AMP_SET_OUTPUT|AC_AMP_SET_RIGHT|AC_AMP_SET_LEFT|0x01},
+	{0x10, AC_VERB_SET_AMP_GAIN_MUTE,
+	 AC_AMP_SET_OUTPUT|AC_AMP_SET_RIGHT|AC_AMP_SET_LEFT|0x02},
+	{0x10, AC_VERB_SET_AMP_GAIN_MUTE,
+	 AC_AMP_SET_OUTPUT|AC_AMP_SET_RIGHT|AC_AMP_SET_LEFT|0x03},
+	{0x10, AC_VERB_SET_AMP_GAIN_MUTE,
+	 AC_AMP_SET_OUTPUT|AC_AMP_SET_RIGHT|AC_AMP_SET_LEFT|0x04},
+	/* Record selector: Int mic */
+	{0x14, AC_VERB_SET_AMP_GAIN_MUTE,
+	 AC_AMP_SET_INPUT|AC_AMP_SET_RIGHT|AC_AMP_SET_LEFT|0x44},
+	{0x14, AC_VERB_SET_AMP_GAIN_MUTE,AC_AMP_SET_INPUT|AC_AMP_SET_RIGHT|
+	AC_AMP_SET_LEFT|0x44|1<<AC_AMP_SET_INDEX_SHIFT},
+	/* SPDIF route: PCM */
+	{ 0x1C, AC_VERB_SET_CONNECT_SEL, 0x0 },
+	/* EAPD */
+	{0x1A, AC_VERB_SET_EAPD_BTLENABLE, 0x2 }, /* default on */ 
+	{0x16, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | CONEXANT_HP_EVENT},
+	{0x17, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | CXT5051_PORTB_EVENT},
+	{0x18, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | CXT5051_PORTC_EVENT},
+	{ } /* end */
+};
+
+
+#if 0
+static struct hda_verb cxt5051_mic_wid1d_init_verbs[] = {
+	/* pin sensing on HP jack */
+	{0x14, AC_VERB_SET_CONNECT_SEL,0x0},
+	{ } /* end */
+};
+#endif
+
+/* For HP's configuration always use portB as Internal and External Mic */
+static struct hda_verb cxt5051_mic_wid17_init_verbs[] = {
+	/* pin sensing on HP jack */
+	{0x14, AC_VERB_SET_CONNECT_SEL,0x1},
+	{ } /* end */
+};
+
+
+/* initialize jack-sensing, too */
+static int cxt5051_init(struct hda_codec *codec)
+{
+	conexant_init(codec);
+	return 0;
+}
+
+
+enum {
+	CXT5051_LAPTOP,	 /* Laptops w/ EAPD support */
+	CXT5051_MODELS
+};
+
+static const char *cxt5051_models[CXT5051_MODELS] = {
+	[CXT5051_LAPTOP]	= "laptop",
+};
+
+static struct snd_pci_quirk cxt5051_cfg_tbl[] = {
+	SND_PCI_QUIRK(0x14F1, 0x0101, "Conexant Reference board", CXT5051_LAPTOP),
+	{}
+};
+
+static int patch_cxt5051(struct hda_codec *codec)
+{
+	struct conexant_spec *spec;
+	int board_config;
+
+	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
+	if (!spec)
+		return -ENOMEM;
+	mutex_init(&spec->amp_mutex);
+	codec->spec = spec;
+
+	spec->multiout.max_channels = 2;
+	spec->multiout.num_dacs = ARRAY_SIZE(cxt5051_dac_nids);
+	spec->multiout.dac_nids = cxt5051_dac_nids;
+	spec->multiout.dig_out_nid = CXT5051_SPDIF_OUT;
+	spec->num_adc_nids = 1;
+	spec->adc_nids = cxt5051_adc_nids;
+	spec->capsrc_nids = cxt5051_capsrc_nids;
+	spec->input_mux = &cxt5051_capture_source;
+	spec->num_mixers = 1;
+	spec->mixers[0] = cxt5051_mixers;
+	spec->num_init_verbs = 1;
+	spec->init_verbs[0] = cxt5051_init_verbs;
+	spec->spdif_route = 0;
+	spec->num_channel_mode = ARRAY_SIZE(cxt5051_modes),
+	spec->channel_mode = cxt5051_modes,
+
+
+	codec->patch_ops = conexant_patch_ops;
+
+	board_config = snd_hda_check_board_config(codec, CXT5051_MODELS,
+						  cxt5051_models,
+						  cxt5051_cfg_tbl);
+	switch (board_config) {
+	default:
+	case CXT5051_LAPTOP:
+		codec->patch_ops.unsol_event = cxt5051_hp_unsol_event;
+		spec->input_mux = &cxt5051_capture_source;
+		spec->num_init_verbs = 2;
+		spec->init_verbs[1] = cxt5051_mic_wid17_init_verbs;
+		spec->mixers[0] = cxt5051_mixers;
+		codec->patch_ops.init = cxt5051_init;
+		break;
+	}
+
+	if(codec->mfg) {
+		int (*cnxthwhda_probe)(void *codec, struct device *hwDev, void **ppDevNode);
+		cnxthwhda_probe = (void*)symbol_request(cnxthwhda_probe);
+		if(cnxthwhda_probe)
+			symbol_put(cnxthwhda_probe);
+		else
+			printk(KERN_ERR"%s: symbol_request(cnxthwhda_probe) failed\n", __FUNCTION__);
+	}
+
+	return 0;
+}
+
 struct hda_codec_preset snd_hda_preset_conexant[] = {
 	{ .id = 0x14f15045, .name = "CX20549 (Venice)",
 	  .patch = patch_cxt5045 },
 	{ .id = 0x14f15047, .name = "CX20551 (Waikiki)",
 	  .patch = patch_cxt5047 },
+	{ .id = 0x14f15051, .name = "CX20561 (Hermosa)",
+	  .patch = patch_cxt5051 },
 	{ .id = 0x14f12bfa, .mfg = 2, .name = "HSF",
 	  .patch = patch_cxthsf },
 	{ .id = 0x14f12c06, .mfg = 2, .name = "HSF",

--Boundary-00=_xZokHWc4Wn/zjuQ
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="alsa-spartan-hermosa-support.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="alsa-spartan-hermosa-support.patch"

diff -p -up linux-2.6.23/sound/pci/hda/patch_conexant.c.orig linux-2.6.23/sound/pci/hda/patch_conexant.c
--- linux-2.6.23/sound/pci/hda/patch_conexant.c.orig	2007-12-28 11:21:31.000000000 -0200
+++ linux-2.6.23/sound/pci/hda/patch_conexant.c	2007-12-28 11:27:03.000000000 -0200
@@ -1643,9 +1643,9 @@ static int patch_cxt5047(struct hda_code
 
 
 /* Conexant 5051 specific */
-static hda_nid_t cxt5051_dac_nids[1] = { 0x10 };
-static hda_nid_t cxt5051_adc_nids[1] = { 0x14 };
-static hda_nid_t cxt5051_capsrc_nids[1] = { 0x14 };
+static hda_nid_t cxt5051_dac_nids[2] = { 0x10, 0x11 };
+static hda_nid_t cxt5051_adc_nids[2] = { 0x14, 0x15 };
+static hda_nid_t cxt5051_capsrc_nids[2] = { 0x14, 0x15 };
 #define CXT5051_SPDIF_OUT	0x1C
 #define CXT5051_PORTB_EVENT	0x38
 #define CXT5051_PORTC_EVENT	0x39
@@ -1658,7 +1658,7 @@ static struct hda_input_mux cxt5051_capt
 	.num_items = 2,
 	.items = {
 		{ "IntMic", 0x1 },
-		{ "LineIn", 0x2 },
+		{ "ExtMic", 0x2 },
 	}
 };
 
@@ -1730,14 +1730,14 @@ static void cxt5051_portb_automic(struct
 		{}
 	};
 	static struct hda_verb mic_jack_off[] = {
-		{0x14, AC_VERB_SET_CONNECT_SEL,0x1},
+		{0x14, AC_VERB_SET_CONNECT_SEL,0x0},
 		{}
 	};
 	unsigned int present;
 
 	present = snd_hda_codec_read(codec, 0x17, 0,
 				     AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
-	printk(KERN_DEBUG"cxt5051_portb_automic present =%x\n",present);
+	//printk(KERN_DEBUG"cxt5051_portb_automic present =%x\n",present);
 
 	if (present)
 		snd_hda_sequence_write(codec, mic_jack_on);
@@ -1748,24 +1748,28 @@ static void cxt5051_portb_automic(struct
 
 static void cxt5051_portc_automic(struct hda_codec *codec)
 {
-/*
 	static struct hda_verb mic_jack_on[] = {
+		{0x1d, AC_VERB_SET_PIN_WIDGET_CONTROL, 0},
 		{}
 	};
 	static struct hda_verb mic_jack_off[] = {
+		{0x1d, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN},
 		{}
 	};
 	unsigned int present;
+	struct conexant_spec *spec = codec->spec;
 
 	present = snd_hda_codec_read(codec, 0x18, 0,
 				     AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
-	printk(KERN_DEBUG"cxt5051_portc_automic present =%x\n",present);
+	//printk(KERN_DEBUG"cxt5051_portc_automic present =%x\n",present);
 
-	if (present)
+	if (present) {
 		snd_hda_sequence_write(codec, mic_jack_on);
-	else
+		spec->adc_nids[0] = 0x15;
+	} else {
 		snd_hda_sequence_write(codec, mic_jack_off);
-*/
+		spec->adc_nids[0] = 0x14;
+	}
 }
 
 /* mute internal speaker if HP is plugged */
@@ -1793,7 +1797,7 @@ static void cxt5051_hp_automute(struct h
 	else
 		snd_hda_sequence_write(codec, spk_on);
 
-	printk(KERN_DEBUG"cxt5051_hp_automute bits =%x\n",bits);
+	//printk(KERN_DEBUG"cxt5051_hp_automute bits =%x\n",bits);
 }
 
 /* unsolicited event for HP jack sensing */
@@ -1826,10 +1830,10 @@ static struct snd_kcontrol_new cxt5051_m
 		.get = conexant_mux_enum_get,
 		.put = conexant_mux_enum_put
 	},
-//	HDA_CODEC_VOLUME("Int Mic Volume", 0x14, 0x00, HDA_INPUT),
-//	HDA_CODEC_MUTE("Int Mic Switch", 0x14, 0x00, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Volume", 0x14, 0x01, HDA_INPUT),
-	HDA_CODEC_MUTE("Mic Switch", 0x14, 0x01, HDA_INPUT),
+	HDA_CODEC_VOLUME("Int Mic Volume", 0x14, 0x00, HDA_INPUT),
+	HDA_CODEC_MUTE("Int Mic Switch", 0x14, 0x00, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Volume", 0x15, 0x00, HDA_INPUT),
+	HDA_CODEC_MUTE("Mic Switch", 0x15, 0x00, HDA_INPUT),
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.name = "Master Playback Volume",
@@ -1852,13 +1856,13 @@ static struct snd_kcontrol_new cxt5051_m
 
 static struct hda_verb cxt5051_init_verbs[] = {
 	/* Line in, Mic */
-	{0x17, AC_VERB_SET_AMP_GAIN_MUTE,AC_AMP_SET_INPUT|AC_AMP_SET_LEFT
+	{0x1D, AC_VERB_SET_AMP_GAIN_MUTE,AC_AMP_SET_INPUT|AC_AMP_SET_LEFT
 	|AC_AMP_SET_RIGHT|0x2},
-	{0x17, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN|AC_PINCTL_VREF_80 },
+	{0x1D, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN|AC_PINCTL_VREF_80 },
 	{0x18, AC_VERB_SET_AMP_GAIN_MUTE,AC_AMP_SET_INPUT|AC_AMP_SET_LEFT
 	|AC_AMP_SET_RIGHT|0x2},
 	{0x18, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN|AC_PINCTL_VREF_80 },
-	{0x1D, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN},
+	{0x17, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN},
 	/* SPK  */
 	{0x1A, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT },
 	{0x1A, AC_VERB_SET_CONNECT_SEL,0x00},
@@ -1879,6 +1883,12 @@ static struct hda_verb cxt5051_init_verb
 	 AC_AMP_SET_INPUT|AC_AMP_SET_RIGHT|AC_AMP_SET_LEFT|0x44},
 	{0x14, AC_VERB_SET_AMP_GAIN_MUTE,AC_AMP_SET_INPUT|AC_AMP_SET_RIGHT|
 	AC_AMP_SET_LEFT|0x44|1<<AC_AMP_SET_INDEX_SHIFT},
+	/* Ext Mic? */
+	{0x15, AC_VERB_SET_CONNECT_SEL, 0x0},
+	{0x15, AC_VERB_SET_AMP_GAIN_MUTE,
+	 AC_AMP_SET_INPUT|AC_AMP_SET_RIGHT|AC_AMP_SET_LEFT|0x50},
+	{0x15, AC_VERB_SET_AMP_GAIN_MUTE,AC_AMP_SET_INPUT|AC_AMP_SET_RIGHT|
+	 AC_AMP_SET_LEFT|0x50|1<<AC_AMP_SET_INDEX_SHIFT},
 	/* SPDIF route: PCM */
 	{ 0x1C, AC_VERB_SET_CONNECT_SEL, 0x0 },
 	/* EAPD */
@@ -1889,22 +1899,20 @@ static struct hda_verb cxt5051_init_verb
 	{ } /* end */
 };
 
-
-#if 0
 static struct hda_verb cxt5051_mic_wid1d_init_verbs[] = {
 	/* pin sensing on HP jack */
 	{0x14, AC_VERB_SET_CONNECT_SEL,0x0},
 	{ } /* end */
 };
-#endif
 
+#if 0
 /* For HP's configuration always use portB as Internal and External Mic */
 static struct hda_verb cxt5051_mic_wid17_init_verbs[] = {
 	/* pin sensing on HP jack */
 	{0x14, AC_VERB_SET_CONNECT_SEL,0x1},
 	{ } /* end */
 };
-
+#endif
 
 /* initialize jack-sensing, too */
 static int cxt5051_init(struct hda_codec *codec)
@@ -1943,7 +1951,7 @@ static int patch_cxt5051(struct hda_code
 	spec->multiout.num_dacs = ARRAY_SIZE(cxt5051_dac_nids);
 	spec->multiout.dac_nids = cxt5051_dac_nids;
 	spec->multiout.dig_out_nid = CXT5051_SPDIF_OUT;
-	spec->num_adc_nids = 1;
+	spec->num_adc_nids = ARRAY_SIZE(cxt5051_adc_nids);
 	spec->adc_nids = cxt5051_adc_nids;
 	spec->capsrc_nids = cxt5051_capsrc_nids;
 	spec->input_mux = &cxt5051_capture_source;
@@ -1967,20 +1975,20 @@ static int patch_cxt5051(struct hda_code
 		codec->patch_ops.unsol_event = cxt5051_hp_unsol_event;
 		spec->input_mux = &cxt5051_capture_source;
 		spec->num_init_verbs = 2;
-		spec->init_verbs[1] = cxt5051_mic_wid17_init_verbs;
+		spec->init_verbs[1] = cxt5051_mic_wid1d_init_verbs;
 		spec->mixers[0] = cxt5051_mixers;
 		codec->patch_ops.init = cxt5051_init;
 		break;
 	}
 
-	if(codec->mfg) {
+	/*if(codec->mfg) {
 		int (*cnxthwhda_probe)(void *codec, struct device *hwDev, void **ppDevNode);
 		cnxthwhda_probe = (void*)symbol_request(cnxthwhda_probe);
 		if(cnxthwhda_probe)
 			symbol_put(cnxthwhda_probe);
 		else
 			printk(KERN_ERR"%s: symbol_request(cnxthwhda_probe) failed\n", __FUNCTION__);
-	}
+	}*/
 
 	return 0;
 }

--Boundary-00=_xZokHWc4Wn/zjuQ
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_xZokHWc4Wn/zjuQ--
