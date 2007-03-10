From: Tobin Davis <tdavis@dsl-only.net>
Subject: Conexant improvements
Date: Sat, 10 Mar 2007 09:01:43 -0800
Message-ID: <1173546103.4531.283.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-aBi+00p/MbqugiLk3Ifh"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-aBi+00p/MbqugiLk3Ifh
Content-Type: multipart/alternative; boundary="=-VpirqrITdiKIn7Jtgc0x"


--=-VpirqrITdiKIn7Jtgc0x
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch further improves on the Conexant Audio driver.
Adds support for Fujistu Siemens Si1520 series laptops.
Adds support for mic/line in on CX20549 based systems (aka 5045).
removes duplicated or unused controls (gpio, spdif) from test model.



Signed off by Tobin Davis <tdavis@dsl-only.net>

--=-VpirqrITdiKIn7Jtgc0x
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.12.0">
</HEAD>
<BODY>
This patch further improves on the Conexant Audio driver.<BR>
Adds support for Fujistu Siemens Si1520 series laptops.<BR>
Adds support for mic/line in on CX20549 based systems (aka 5045).<BR>
removes duplicated or unused controls (gpio, spdif) from test model.<BR>
<BR>
<BR>
<TABLE CELLSPACING="0" CELLPADDING="0" WIDTH="100%">
<TR>
<TD>
<BR>
Signed off by Tobin Davis &lt;tdavis@dsl-only.net&gt;
</TD>
</TR>
</TABLE>
</BODY>
</HTML>

--=-VpirqrITdiKIn7Jtgc0x--

--=-aBi+00p/MbqugiLk3Ifh
Content-Disposition: attachment; filename=conexant-test19a.patch
Content-Type: text/x-patch; name=conexant-test19a.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r bf193701a812 pci/hda/patch_conexant.c
--- a/pci/hda/patch_conexant.c	Mon Feb 26 16:07:42 2007 +0100
+++ b/pci/hda/patch_conexant.c	Wed Mar 07 08:30:30 2007 -0800
@@ -452,115 +452,6 @@ static int conexant_ch_mode_put(struct s
 	  .put = conexant_ch_mode_put, \
 	  .private_value = nid | (dir<<16) }
 
-static int cxt_gpio_data_info(struct snd_kcontrol *kcontrol,
-			      struct snd_ctl_elem_info *uinfo)
-{
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
-	uinfo->count = 1;
-	uinfo->value.integer.min = 0;
-	uinfo->value.integer.max = 1;
-	return 0;
-}                                
-
-static int cxt_gpio_data_get(struct snd_kcontrol *kcontrol,
-			     struct snd_ctl_elem_value *ucontrol)
-{
-	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	hda_nid_t nid = kcontrol->private_value & 0xffff;
-	unsigned char mask = (kcontrol->private_value >> 16) & 0xff;
-	long *valp = ucontrol->value.integer.value;
-	unsigned int val = snd_hda_codec_read(codec, nid, 0,
-					      AC_VERB_GET_GPIO_DATA, 0x00);
-
-	*valp = (val & mask) != 0;
-	return 0;
-}
-
-static int cxt_gpio_data_put(struct snd_kcontrol *kcontrol,
-			     struct snd_ctl_elem_value *ucontrol)
-{
-	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	hda_nid_t nid = kcontrol->private_value & 0xffff;
-	unsigned char mask = (kcontrol->private_value >> 16) & 0xff;
-	long val = *ucontrol->value.integer.value;
-	unsigned int gpio_data = snd_hda_codec_read(codec, nid, 0,
-						    AC_VERB_GET_GPIO_DATA,
-						    0x00);
-	unsigned int old_data = gpio_data;
-
-	/* Set/unset the masked GPIO bit(s) as needed */
-	if (val == 0)
-		gpio_data &= ~mask;
-	else
-		gpio_data |= mask;
-	if (gpio_data == old_data && !codec->in_resume)
-		return 0;
-	snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_GPIO_DATA, gpio_data);
-	return 1;
-}
-
-#define CXT_GPIO_DATA_SWITCH(xname, nid, mask) \
-	{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, .index = 0,  \
-	  .info = cxt_gpio_data_info, \
-	  .get = cxt_gpio_data_get, \
-	  .put = cxt_gpio_data_put, \
-	  .private_value = nid | (mask<<16) }
-#if 0
-static int cxt_spdif_ctrl_info(struct snd_kcontrol *kcontrol,
-			       struct snd_ctl_elem_info *uinfo)
-{
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
-	uinfo->count = 1;
-	uinfo->value.integer.min = 0;
-	uinfo->value.integer.max = 1;
-	return 0;
-}                                
-
-static int cxt_spdif_ctrl_get(struct snd_kcontrol *kcontrol,
-			      struct snd_ctl_elem_value *ucontrol)
-{
-	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	hda_nid_t nid = kcontrol->private_value & 0xffff;
-	unsigned char mask = (kcontrol->private_value >> 16) & 0xff;
-	long *valp = ucontrol->value.integer.value;
-	unsigned int val = snd_hda_codec_read(codec, nid, 0,
-					      AC_VERB_GET_DIGI_CONVERT, 0x00);
-
-	*valp = (val & mask) != 0;
-	return 0;
-}
-
-static int cxt_spdif_ctrl_put(struct snd_kcontrol *kcontrol,
-			      struct snd_ctl_elem_value *ucontrol)
-{
-	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	hda_nid_t nid = kcontrol->private_value & 0xffff;
-	unsigned char mask = (kcontrol->private_value >> 16) & 0xff;
-	long val = *ucontrol->value.integer.value;
-	unsigned int ctrl_data = snd_hda_codec_read(codec, nid, 0,
-						    AC_VERB_GET_DIGI_CONVERT,
-						    0x00);
-	unsigned int old_data = ctrl_data;
-
-	/* Set/unset the masked control bit(s) as needed */
-	if (val == 0)
-		ctrl_data &= ~mask;
-	else
-		ctrl_data |= mask;
-	if (ctrl_data == old_data && !codec->in_resume)
-		return 0;
-	snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_DIGI_CONVERT_1,
-			    ctrl_data);
-	return 1;
-}
-
-#define CXT_SPDIF_CTRL_SWITCH(xname, nid, mask) \
-	{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, .index = 0,  \
-	  .info = cxt_spdif_ctrl_info, \
-	  .get = cxt_spdif_ctrl_get, \
-	  .put = cxt_spdif_ctrl_put, \
-	  .private_value = nid | (mask<<16) }
-#endif
 #endif /* CONFIG_SND_DEBUG */
 
 /* Conexant 5045 specific */
@@ -599,6 +490,7 @@ static int cxt5045_hp_master_sw_put(stru
 	bits = (!spec->hp_present && spec->cur_eapd) ? 0 : 0x80;
 	snd_hda_codec_amp_update(codec, 0x10, 0, HDA_OUTPUT, 0, 0x80, bits);
 	snd_hda_codec_amp_update(codec, 0x10, 1, HDA_OUTPUT, 0, 0x80, bits);
+
 	bits = spec->cur_eapd ? 0 : 0x80;
 	snd_hda_codec_amp_update(codec, 0x11, 0, HDA_OUTPUT, 0, 0x80, bits);
 	snd_hda_codec_amp_update(codec, 0x11, 1, HDA_OUTPUT, 0, 0x80, bits);
@@ -624,6 +516,29 @@ static int cxt5045_hp_master_vol_put(str
 	return change;
 }
 
+/* toggle input of built-in and mic jack appropriately */
+static void cxt5045_hp_automic(struct hda_codec *codec)
+{
+	static struct hda_verb mic_jack_on[] = {
+		{0x14, AC_VERB_SET_AMP_GAIN_MUTE, 0xb080},
+		{0x12, AC_VERB_SET_AMP_GAIN_MUTE, 0xb000},
+		{}
+	};
+	static struct hda_verb mic_jack_off[] = {
+		{0x12, AC_VERB_SET_AMP_GAIN_MUTE, 0xb080},
+		{0x14, AC_VERB_SET_AMP_GAIN_MUTE, 0xb000},
+		{}
+	};
+	unsigned int present;
+
+	present = snd_hda_codec_read(codec, 0x12, 0,
+				     AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
+	if (present)
+		snd_hda_sequence_write(codec, mic_jack_on);
+	else
+		snd_hda_sequence_write(codec, mic_jack_off);
+}
+
 
 /* mute internal speaker if HP is plugged */
 static void cxt5045_hp_automute(struct hda_codec *codec)
@@ -634,7 +549,7 @@ static void cxt5045_hp_automute(struct h
 	spec->hp_present = snd_hda_codec_read(codec, 0x11, 0,
 				     AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
 
-	bits = (spec->hp_present || !spec->cur_eapd) ? 0x80 : 0;
+	bits = (spec->hp_present || !spec->cur_eapd) ? 0x80 : 0; 
 	snd_hda_codec_amp_update(codec, 0x10, 0, HDA_OUTPUT, 0, 0x80, bits);
 	snd_hda_codec_amp_update(codec, 0x10, 1, HDA_OUTPUT, 0, 0x80, bits);
 }
@@ -648,6 +563,10 @@ static void cxt5045_hp_unsol_event(struc
 	case CONEXANT_HP_EVENT:
 		cxt5045_hp_automute(codec);
 		break;
+	case CONEXANT_MIC_EVENT:
+		cxt5045_hp_automic(codec);
+		break;
+
 	}
 }
 
@@ -659,12 +578,10 @@ static struct snd_kcontrol_new cxt5045_m
 		.get = conexant_mux_enum_get,
 		.put = conexant_mux_enum_put
 	},
-	HDA_CODEC_VOLUME("Int Mic Volume", 0x17, 0x01, HDA_INPUT),
-	HDA_CODEC_MUTE("Int Mic Switch", 0x17, 0x01, HDA_INPUT),
-	HDA_CODEC_VOLUME("Ext Mic Volume", 0x17, 0x02, HDA_INPUT),
-	HDA_CODEC_MUTE("Ext Mic Switch", 0x17, 0x02, HDA_INPUT),
-	HDA_CODEC_VOLUME("Capture Volume", 0x1a, 0x0, HDA_INPUT),
-	HDA_CODEC_MUTE("Capture Switch", 0x1a, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Int Mic Volume", 0x1a, 0x01, HDA_INPUT),
+	HDA_CODEC_MUTE("Int Mic Switch", 0x1a, 0x01, HDA_INPUT),
+	HDA_CODEC_VOLUME("Ext Mic Volume", 0x1a, 0x02, HDA_INPUT),
+	HDA_CODEC_MUTE("Ext Mic Switch", 0x1a, 0x02, HDA_INPUT),
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.name = "Master Playback Volume",
@@ -688,7 +605,7 @@ static struct hda_verb cxt5045_init_verb
 static struct hda_verb cxt5045_init_verbs[] = {
 	/* Line in, Mic */
 	{0x12, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN },
-	{0x14, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN|AC_PINCTL_VREF_50 },
+	{0x14, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN|AC_PINCTL_VREF_80 },
 	/* HP, Amp  */
 	{0x11, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_HP },
 	{0x17, AC_VERB_SET_CONNECT_SEL,0x01},
@@ -701,16 +618,25 @@ static struct hda_verb cxt5045_init_verb
 	{0x17, AC_VERB_SET_AMP_GAIN_MUTE,
 	 AC_AMP_SET_OUTPUT|AC_AMP_SET_RIGHT|AC_AMP_SET_LEFT|0x04},
 	/* Record selector: Int mic */
-	{0x1a, AC_VERB_SET_CONNECT_SEL,0x0},
+	{0x1a, AC_VERB_SET_CONNECT_SEL,0x1},
 	{0x1a, AC_VERB_SET_AMP_GAIN_MUTE,
 	 AC_AMP_SET_INPUT|AC_AMP_SET_RIGHT|AC_AMP_SET_LEFT|0x17},
 	/* SPDIF route: PCM */
 	{ 0x13, AC_VERB_SET_CONNECT_SEL, 0x0 },
-	/* pin sensing on HP and Mic jacks */
-	{0x11, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | CONEXANT_HP_EVENT},
 	/* EAPD */
 	{0x10, AC_VERB_SET_EAPD_BTLENABLE, 0x2 }, /* default on */ 
 	{ } /* end */
+};
+
+
+static struct hda_verb cxt5045_hp_sense_init_verbs[] = {
+	/* pin sensing on HP jack */
+	{0x11, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | CONEXANT_HP_EVENT},
+};
+
+static struct hda_verb cxt5045_mic_sense_init_verbs[] = {
+	/* pin sensing on HP jack */
+	{0x12, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | CONEXANT_MIC_EVENT},
 };
 
 #ifdef CONFIG_SND_DEBUG
@@ -733,6 +659,10 @@ static struct snd_kcontrol_new cxt5045_t
 	/* Output controls */
 	HDA_CODEC_VOLUME("Speaker Playback Volume", 0x10, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE("Speaker Playback Switch", 0x10, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("Node 11 Playback Volume", 0x11, 0x0, HDA_OUTPUT),
+	HDA_CODEC_MUTE("Node 11 Playback Switch", 0x11, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("Node 12 Playback Volume", 0x12, 0x0, HDA_OUTPUT),
+	HDA_CODEC_MUTE("Node 12 Playback Switch", 0x12, 0x0, HDA_OUTPUT),
 	
 	/* Modes for retasking pin widgets */
 	CXT_PIN_MODE("HP-OUT pin mode", 0x11, CXT_PIN_DIR_INOUT),
@@ -742,25 +672,17 @@ static struct snd_kcontrol_new cxt5045_t
 	CXT_EAPD_SWITCH("External Amplifier", 0x10, 0x0),
 
 	/* Loopback mixer controls */
-	HDA_CODEC_VOLUME("MIC1 Playback Volume", 0x17, 0x01, HDA_INPUT),
-	HDA_CODEC_MUTE("MIC1 Playback Switch", 0x17, 0x01, HDA_INPUT),
-	HDA_CODEC_VOLUME("LINE loopback Playback Volume", 0x17, 0x02, HDA_INPUT),
-	HDA_CODEC_MUTE("LINE loopback Playback Switch", 0x17, 0x02, HDA_INPUT),
-	HDA_CODEC_VOLUME("HP-OUT loopback Playback Volume", 0x17, 0x03, HDA_INPUT),
-	HDA_CODEC_MUTE("HP-OUT loopback Playback Switch", 0x17, 0x03, HDA_INPUT),
-	HDA_CODEC_VOLUME("CD Playback Volume", 0x17, 0x04, HDA_INPUT),
-	HDA_CODEC_MUTE("CD Playback Switch", 0x17, 0x04, HDA_INPUT),
-
-	HDA_CODEC_VOLUME("Capture-1 Volume", 0x17, 0x0, HDA_INPUT),
-	HDA_CODEC_MUTE("Capture-1 Switch", 0x17, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Capture-2 Volume", 0x17, 0x1, HDA_INPUT),
-	HDA_CODEC_MUTE("Capture-2 Switch", 0x17, 0x1, HDA_INPUT),
-	HDA_CODEC_VOLUME("Capture-3 Volume", 0x17, 0x2, HDA_INPUT),
-	HDA_CODEC_MUTE("Capture-3 Switch", 0x17, 0x2, HDA_INPUT),
-	HDA_CODEC_VOLUME("Capture-4 Volume", 0x17, 0x3, HDA_INPUT),
-	HDA_CODEC_MUTE("Capture-4 Switch", 0x17, 0x3, HDA_INPUT),
-	HDA_CODEC_VOLUME("Capture-5 Volume", 0x17, 0x4, HDA_INPUT),
-	HDA_CODEC_MUTE("Capture-5 Switch", 0x17, 0x4, HDA_INPUT),
+
+	HDA_CODEC_VOLUME("Mixer-1 Volume", 0x17, 0x0, HDA_INPUT),
+	HDA_CODEC_MUTE("Mixer-1 Switch", 0x17, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mixer-2 Volume", 0x17, 0x1, HDA_INPUT),
+	HDA_CODEC_MUTE("Mixer-2 Switch", 0x17, 0x1, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mixer-3 Volume", 0x17, 0x2, HDA_INPUT),
+	HDA_CODEC_MUTE("Mixer-3 Switch", 0x17, 0x2, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mixer-4 Volume", 0x17, 0x3, HDA_INPUT),
+	HDA_CODEC_MUTE("Mixer-4 Switch", 0x17, 0x3, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mixer-5 Volume", 0x17, 0x4, HDA_INPUT),
+	HDA_CODEC_MUTE("Mixer-5 Switch", 0x17, 0x4, HDA_INPUT),
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.name = "Input Source",
@@ -768,14 +690,17 @@ static struct snd_kcontrol_new cxt5045_t
 		.get = conexant_mux_enum_get,
 		.put = conexant_mux_enum_put,
 	},
-
 	{ } /* end */
 };
 
 static struct hda_verb cxt5045_test_init_verbs[] = {
+	/* Set connections */
+	{ 0x10, AC_VERB_SET_CONNECT_SEL, 0x0 },
+	{ 0x11, AC_VERB_SET_CONNECT_SEL, 0x0 },
+	{ 0x12, AC_VERB_SET_CONNECT_SEL, 0x0 },
 	/* Enable retasking pins as output, initially without power amp */
 	{0x12, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
-	{0x11, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_HP},
+	{0x11, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
 
 	/* Disable digital (SPDIF) pins initially, but users can enable
 	 * them via a mixer switch.  In the case of SPDIF-out, this initverb
@@ -804,6 +729,7 @@ static struct hda_verb cxt5045_test_init
 	 * pin)
 	 */
 	{0x1a, AC_VERB_SET_CONNECT_SEL, 0x00},
+	{0x17, AC_VERB_SET_CONNECT_SEL, 0x00},
 
 	/* Mute all inputs to mixer widget (even unconnected ones) */
 	{0x17, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)}, /* Mixer pin */
@@ -827,7 +753,8 @@ static int cxt5045_init(struct hda_codec
 
 
 enum {
-	CXT5045_LAPTOP,	/* Laptops w/ EAPD support */
+	CXT5045_LAPTOP,	 /* Laptops w/ EAPD support */
+	CXT5045_FUJITSU, /* Laptops w/ EAPD support */ 
 #ifdef CONFIG_SND_DEBUG
 	CXT5045_TEST,
 #endif
@@ -836,6 +763,7 @@ enum {
 
 static const char *cxt5045_models[CXT5045_MODELS] = {
 	[CXT5045_LAPTOP]	= "laptop",
+	[CXT5045_FUJITSU]	= "fujitsu",
 #ifdef CONFIG_SND_DEBUG
 	[CXT5045_TEST]		= "test",
 #endif
@@ -844,7 +772,8 @@ static struct snd_pci_quirk cxt5045_cfg_
 static struct snd_pci_quirk cxt5045_cfg_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x30b7, "HP DV6000Z", CXT5045_LAPTOP),
 	SND_PCI_QUIRK(0x103c, 0x30bb, "HP DV8000", CXT5045_LAPTOP),
-	SND_PCI_QUIRK(0x1734, 0x10ad, "Fujitsu Si1520", CXT5045_LAPTOP),
+	SND_PCI_QUIRK(0x1734, 0x10ad, "Fujitsu Si1520", CXT5045_FUJITSU),
+	SND_PCI_QUIRK(0x8086, 0x2111, "Conexant Reference board", CXT5045_LAPTOP),
 	{}
 };
 
@@ -877,16 +806,23 @@ static int patch_cxt5045(struct hda_code
 
 
 	codec->patch_ops = conexant_patch_ops;
-	codec->patch_ops.unsol_event = cxt5045_hp_unsol_event;
 
 	board_config = snd_hda_check_board_config(codec, CXT5045_MODELS,
 						  cxt5045_models,
 						  cxt5045_cfg_tbl);
 	switch (board_config) {
 	case CXT5045_LAPTOP:
+		codec->patch_ops.unsol_event = cxt5045_hp_unsol_event;
 		spec->input_mux = &cxt5045_capture_source;
 		spec->num_init_verbs = 2;
-		spec->init_verbs[1] = cxt5045_init_verbs;
+		spec->init_verbs[1] = cxt5045_hp_sense_init_verbs;
+		spec->mixers[0] = cxt5045_mixers;
+		codec->patch_ops.init = cxt5045_init;
+		break;
+	case CXT5045_FUJITSU:
+		spec->input_mux = &cxt5045_capture_source;
+		spec->num_init_verbs = 2;
+		spec->init_verbs[1] = cxt5045_mic_sense_init_verbs;
 		spec->mixers[0] = cxt5045_mixers;
 		codec->patch_ops.init = cxt5045_init;
 		break;
@@ -913,10 +849,9 @@ static struct hda_channel_mode cxt5047_m
 };
 
 static struct hda_input_mux cxt5047_capture_source = {
-	.num_items = 2,
+	.num_items = 1,
 	.items = {
-		{ "ExtMic", 0x0 },
-		{ "IntMic", 0x1 },
+		{ "Mic", 0x2 },
 	}
 };
 
@@ -1009,7 +944,7 @@ static void cxt5047_hp_automic(struct hd
 	};
 	unsigned int present;
 
-	present = snd_hda_codec_read(codec, 0x08, 0,
+	present = snd_hda_codec_read(codec, 0x15, 0,
 				     AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
 	if (present)
 		snd_hda_sequence_write(codec, mic_jack_on);
@@ -1033,15 +968,10 @@ static void cxt5047_hp_unsol_event(struc
 }
 
 static struct snd_kcontrol_new cxt5047_mixers[] = {
-	{
-		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		.name = "Capture Source",
-		.info = conexant_mux_enum_info,
-		.get = conexant_mux_enum_get,
-		.put = conexant_mux_enum_put
-	},
 	HDA_CODEC_VOLUME("Mic Bypass Capture Volume", 0x19, 0x02, HDA_INPUT),
 	HDA_CODEC_MUTE("Mic Bypass Capture Switch", 0x19, 0x02, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Gain Volume", 0x1a, 0x0, HDA_OUTPUT),
+	HDA_CODEC_MUTE("Mic Gain Switch", 0x1a, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME("Capture Volume", 0x12, 0x03, HDA_INPUT),
 	HDA_CODEC_MUTE("Capture Switch", 0x12, 0x03, HDA_INPUT),
 	HDA_CODEC_VOLUME("PCM Volume", 0x10, 0x00, HDA_OUTPUT),
@@ -1133,18 +1063,18 @@ static struct hda_verb cxt5047_init_verb
 	{0x14, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN },
 	{0x15, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN|AC_PINCTL_VREF_50 },
 	{0x17, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN|AC_PINCTL_VREF_50 },
-	/* HP, Amp, Speaker  */
+	/* HP, Speaker  */
 	{0x13, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT },
-	{0x1A, AC_VERB_SET_CONNECT_SEL,0x00},
+	{0x1d, AC_VERB_SET_CONNECT_SEL,0x0},
+	/* Record selector: Mic */
+	{0x12, AC_VERB_SET_CONNECT_SEL,0x03},
+	{0x19, AC_VERB_SET_AMP_GAIN_MUTE,
+	 AC_AMP_SET_INPUT|AC_AMP_SET_RIGHT|AC_AMP_SET_LEFT|0x17},
+	{0x1A, AC_VERB_SET_CONNECT_SEL,0x02},
 	{0x1A, AC_VERB_SET_AMP_GAIN_MUTE,
 	 AC_AMP_SET_OUTPUT|AC_AMP_SET_RIGHT|AC_AMP_SET_LEFT|0x00},
 	{0x1A, AC_VERB_SET_AMP_GAIN_MUTE,
 	 AC_AMP_SET_OUTPUT|AC_AMP_SET_RIGHT|AC_AMP_SET_LEFT|0x03},
-	{0x1d, AC_VERB_SET_CONNECT_SEL,0x0},
-	/* Record selector: Front mic */
-	{0x12, AC_VERB_SET_CONNECT_SEL,0x03},
-	{0x19, AC_VERB_SET_AMP_GAIN_MUTE,
-	 AC_AMP_SET_INPUT|AC_AMP_SET_RIGHT|AC_AMP_SET_LEFT|0x17},
 	/* SPDIF route: PCM */
 	{ 0x18, AC_VERB_SET_CONNECT_SEL, 0x0 },
 	/* Enable unsolicited events */
@@ -1161,8 +1091,6 @@ static struct hda_verb cxt5047_toshiba_i
 	{0x15, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | CONEXANT_MIC_EVENT},
 	/* Speaker routing */
 	{0x1d, AC_VERB_SET_CONNECT_SEL,0x1},
-	/* Change default to ExtMic for recording */
-	{0x1a, AC_VERB_SET_CONNECT_SEL,0x2},
 	{}
 };
 
@@ -1172,7 +1100,6 @@ static struct hda_verb cxt5047_hp_init_v
 	{0x13, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | CONEXANT_HP_EVENT},
 	/* Record selector: Ext Mic */
 	{0x12, AC_VERB_SET_CONNECT_SEL,0x03},
-	{0x1a, AC_VERB_SET_CONNECT_SEL,0x02},
 	{0x19, AC_VERB_SET_AMP_GAIN_MUTE,
 	 AC_AMP_SET_INPUT|AC_AMP_SET_RIGHT|AC_AMP_SET_LEFT|0x17},
 	/* Speaker routing */
@@ -1242,14 +1169,6 @@ static struct snd_kcontrol_new cxt5047_t
 		.get = conexant_mux_enum_get,
 		.put = conexant_mux_enum_put,
 	},
-       /* Controls for GPIO pins, assuming they exist and are configured
-	* as outputs
-	*/
-	CXT_GPIO_DATA_SWITCH("GPIO pin 0", 0x01, 0x01),
-	CXT_GPIO_DATA_SWITCH("GPIO pin 1", 0x01, 0x02),
-	CXT_GPIO_DATA_SWITCH("GPIO pin 2", 0x01, 0x04),
-	CXT_GPIO_DATA_SWITCH("GPIO pin 3", 0x01, 0x08),
-
 	{ } /* end */
 };
 

--=-aBi+00p/MbqugiLk3Ifh
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-aBi+00p/MbqugiLk3Ifh
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-aBi+00p/MbqugiLk3Ifh--
