From: Tobin Davis <tdavis@dsl-only.net>
Subject: Latest patch for Conexant HD Audio
Date: Mon, 12 Feb 2007 15:38:43 -0800
Message-ID: <1171323523.715.115.camel@localhost.gruemaster.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-SoLWrVO1TFwUDBffaTh4"
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


--=-SoLWrVO1TFwUDBffaTh4
Content-Type: multipart/alternative; boundary="=-YtyxtcdtHNVMu9nUBGIN"


--=-YtyxtcdtHNVMu9nUBGIN
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Summary:  More fixes for Conexant HD Audio support.

Renamed Conexant 5045 to CX20549 (Venice) per Conexant Documentation
Renamed Conexant 5047 to CX20551 (Waikiki) per Conexant Documentation
Fixed automute on HP Laptops with CX20551 codec.
Fixed recording issues on Toshiba Satelite P100/P105 series laptops
Added HP DV8000, DV2000Z, Fujitsu Si1520 support

More work to be done on CX20549 based systems, but CX20551 Systems are
much better now.


Signed off by Tobin Davis <tdavis@dsl-only.net>

--=-YtyxtcdtHNVMu9nUBGIN
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.12.0">
</HEAD>
<BODY>
Summary:&nbsp; More fixes for Conexant HD Audio support.<BR>
<BR>
Renamed Conexant 5045 to CX20549 (Venice) per Conexant Documentation<BR>
Renamed Conexant 5047 to CX20551 (Waikiki) per Conexant Documentation<BR>
Fixed automute on HP Laptops with CX20551 codec.<BR>
Fixed recording issues on Toshiba Satelite P100/P105 series laptops<BR>
Added HP DV8000, DV2000Z, Fujitsu Si1520 support<BR>
<BR>
More work to be done on CX20549 based systems, but CX20551 Systems are much better now.<BR>
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

--=-YtyxtcdtHNVMu9nUBGIN--

--=-SoLWrVO1TFwUDBffaTh4
Content-Disposition: attachment; filename=conexant-test14a.patch
Content-Type: text/x-patch; name=conexant-test14a.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r 1ce859e9fd4a pci/hda/patch_conexant.c
--- a/pci/hda/patch_conexant.c	Fri Feb 09 20:52:55 2007 +0100
+++ b/pci/hda/patch_conexant.c	Mon Feb 12 15:27:39 2007 -0800
@@ -57,6 +57,7 @@ struct conexant_spec {
 					 * dig_out_nid and hp_nid are optional
 					 */
 	unsigned int cur_eapd;
+	unsigned int hp_present;
 	unsigned int need_dac_fix;
 
 	/* capture */
@@ -354,7 +355,7 @@ static struct hda_codec_ops conexant_pat
  * the private value = nid | (invert << 8)
  */
 
-static int conexant_eapd_info(struct snd_kcontrol *kcontrol,
+static int cxt_eapd_info(struct snd_kcontrol *kcontrol,
 			      struct snd_ctl_elem_info *uinfo)
 {
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
@@ -364,7 +365,7 @@ static int conexant_eapd_info(struct snd
 	return 0;
 }
 
-static int conexant_eapd_get(struct snd_kcontrol *kcontrol,
+static int cxt_eapd_get(struct snd_kcontrol *kcontrol,
 			     struct snd_ctl_elem_value *ucontrol)
 {
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
@@ -375,9 +376,10 @@ static int conexant_eapd_get(struct snd_
 	else
 		ucontrol->value.integer.value[0] = spec->cur_eapd;
 	return 0;
-}
-
-static int conexant_eapd_put(struct snd_kcontrol *kcontrol,
+
+}
+
+static int cxt_eapd_put(struct snd_kcontrol *kcontrol,
 			     struct snd_ctl_elem_value *ucontrol)
 {
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
@@ -385,11 +387,13 @@ static int conexant_eapd_put(struct snd_
 	int invert = (kcontrol->private_value >> 8) & 1;
 	hda_nid_t nid = kcontrol->private_value & 0xff;
 	unsigned int eapd;
+
 	eapd = ucontrol->value.integer.value[0];
 	if (invert)
 		eapd = !eapd;
 	if (eapd == spec->cur_eapd && !codec->in_resume)
 		return 0;
+	
 	spec->cur_eapd = eapd;
 	snd_hda_codec_write(codec, nid,
 			    0, AC_VERB_SET_EAPD_BTLENABLE,
@@ -399,6 +403,15 @@ static int conexant_eapd_put(struct snd_
 
 /* controls for test mode */
 #ifdef CONFIG_SND_DEBUG
+
+#define CXT_EAPD_SWITCH(xname, nid, mask) \
+	{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, .index = 0,  \
+	  .info = cxt_eapd_info, \
+	  .get = cxt_eapd_get, \
+	  .put = cxt_eapd_put, \
+	  .private_value = nid | (mask<<16) }
+
+
 
 static int conexant_ch_mode_info(struct snd_kcontrol *kcontrol,
 				 struct snd_ctl_elem_info *uinfo)
@@ -492,7 +505,7 @@ static int cxt_gpio_data_put(struct snd_
 	  .get = cxt_gpio_data_get, \
 	  .put = cxt_gpio_data_put, \
 	  .private_value = nid | (mask<<16) }
-
+#if 0
 static int cxt_spdif_ctrl_info(struct snd_kcontrol *kcontrol,
 			       struct snd_ctl_elem_info *uinfo)
 {
@@ -547,7 +560,7 @@ static int cxt_spdif_ctrl_put(struct snd
 	  .get = cxt_spdif_ctrl_get, \
 	  .put = cxt_spdif_ctrl_put, \
 	  .private_value = nid | (mask<<16) }
-
+#endif
 #endif /* CONFIG_SND_DEBUG */
 
 /* Conexant 5045 specific */
@@ -564,7 +577,7 @@ static struct hda_input_mux cxt5045_capt
 static struct hda_input_mux cxt5045_capture_source = {
 	.num_items = 2,
 	.items = {
-		{ "ExtMic", 0x1 },
+		{ "IntMic", 0x1 },
 		{ "LineIn", 0x2 },
 	}
 };
@@ -576,10 +589,14 @@ static int cxt5045_hp_master_sw_put(stru
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct conexant_spec *spec = codec->spec;
 
-	if (!conexant_eapd_put(kcontrol, ucontrol))
+	if (!cxt_eapd_put(kcontrol, ucontrol))
 		return 0;
 
-	/* toggle HP mute appropriately */
+	/* toggle internal speakers mute depending of presence of the headphone jack */
+	snd_hda_codec_amp_update(codec, 0x10, 0, HDA_OUTPUT, 0,
+				 0x80, (!spec->hp_present & spec->cur_eapd) ? 0 : 0x80);
+	snd_hda_codec_amp_update(codec, 0x10, 1, HDA_OUTPUT, 0,
+				 0x80, (!spec->hp_present & spec->cur_eapd) ? 0 : 0x80);
 	snd_hda_codec_amp_update(codec, 0x11, 0, HDA_OUTPUT, 0,
 				 0x80, spec->cur_eapd ? 0 : 0x80);
 	snd_hda_codec_amp_update(codec, 0x11, 1, HDA_OUTPUT, 0,
@@ -610,14 +627,14 @@ static int cxt5045_hp_master_vol_put(str
 /* mute internal speaker if HP is plugged */
 static void cxt5045_hp_automute(struct hda_codec *codec)
 {
-	unsigned int present;
-
-	present = snd_hda_codec_read(codec, 0x11, 0,
+	struct conexant_spec *spec = codec->spec;
+
+	spec->hp_present = snd_hda_codec_read(codec, 0x11, 0,
 				     AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
 	snd_hda_codec_amp_update(codec, 0x10, 0, HDA_OUTPUT, 0,
-				 0x80, present ? 0x80 : 0);
+				 0x80, (spec->hp_present|!spec->cur_eapd) ? 0x80 : 0);
 	snd_hda_codec_amp_update(codec, 0x10, 1, HDA_OUTPUT, 0,
-				 0x80, present ? 0x80 : 0);
+				 0x80, (spec->hp_present|!spec->cur_eapd) ? 0x80 : 0);
 }
 
 /* unsolicited event for HP jack sensing */
@@ -640,25 +657,27 @@ static struct snd_kcontrol_new cxt5045_m
 		.get = conexant_mux_enum_get,
 		.put = conexant_mux_enum_put
 	},
-	HDA_CODEC_VOLUME("Mic Bypass Capture Volume", 0x17, 0x02, HDA_INPUT),
-	HDA_CODEC_MUTE("Mic Bypass Capture Switch", 0x17, 0x02, HDA_INPUT),
-	HDA_CODEC_VOLUME("Capture Volume", 0x1a, 0x02, HDA_INPUT),
-	HDA_CODEC_MUTE("Capture Switch", 0x1a, 0x02, HDA_INPUT),
+	HDA_CODEC_VOLUME("Int Mic Volume", 0x17, 0x01, HDA_INPUT),
+	HDA_CODEC_MUTE("Int Mic Switch", 0x17, 0x01, HDA_INPUT),
+	HDA_CODEC_VOLUME("Ext Mic Volume", 0x17, 0x02, HDA_INPUT),
+	HDA_CODEC_MUTE("Ext Mic Switch", 0x17, 0x02, HDA_INPUT),
+	HDA_CODEC_VOLUME("Capture Volume", 0x1a, 0x0, HDA_INPUT),
+	HDA_CODEC_MUTE("Capture Switch", 0x1a, 0x0, HDA_INPUT),
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.name = "Master Playback Volume",
 		.info = snd_hda_mixer_amp_volume_info,
 		.get = snd_hda_mixer_amp_volume_get,
 		.put = cxt5045_hp_master_vol_put,
-		.private_value = HDA_COMPOSE_AMP_VAL(0x11, 3, 0, HDA_OUTPUT),
+		.private_value = HDA_COMPOSE_AMP_VAL(0x10, 3, 0, HDA_OUTPUT), 
 	},
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.name = "Master Playback Switch",
-		.info = conexant_eapd_info,
-		.get = conexant_eapd_get,
+		.info = cxt_eapd_info,
+		.get = cxt_eapd_get,
 		.put = cxt5045_hp_master_sw_put,
-		.private_value = 0x11,
+		.private_value = 0x10, 
 	},
 
 	{}
@@ -669,22 +688,26 @@ static struct hda_verb cxt5045_init_verb
 	{0x12, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN },
 	{0x14, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN|AC_PINCTL_VREF_50 },
 	/* HP, Amp  */
-	{0x11, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT },
-	{0x1A, AC_VERB_SET_CONNECT_SEL,0x01},
-	{0x1A, AC_VERB_SET_AMP_GAIN_MUTE,
-	 AC_AMP_SET_OUTPUT|AC_AMP_SET_RIGHT|AC_AMP_SET_LEFT|0x00},
-	{0x1A, AC_VERB_SET_AMP_GAIN_MUTE,
+	{0x11, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_HP },
+	{0x17, AC_VERB_SET_CONNECT_SEL,0x01},
+	{0x17, AC_VERB_SET_AMP_GAIN_MUTE,
+	 AC_AMP_SET_OUTPUT|AC_AMP_SET_RIGHT|AC_AMP_SET_LEFT|0x01},
+	{0x17, AC_VERB_SET_AMP_GAIN_MUTE,
+	 AC_AMP_SET_OUTPUT|AC_AMP_SET_RIGHT|AC_AMP_SET_LEFT|0x02},
+	{0x17, AC_VERB_SET_AMP_GAIN_MUTE,
 	 AC_AMP_SET_OUTPUT|AC_AMP_SET_RIGHT|AC_AMP_SET_LEFT|0x03},
-	/* Record selector: Front mic */
-	{0x14, AC_VERB_SET_CONNECT_SEL,0x03},
 	{0x17, AC_VERB_SET_AMP_GAIN_MUTE,
+	 AC_AMP_SET_OUTPUT|AC_AMP_SET_RIGHT|AC_AMP_SET_LEFT|0x04},
+	/* Record selector: Int mic */
+	{0x1a, AC_VERB_SET_CONNECT_SEL,0x0},
+	{0x1a, AC_VERB_SET_AMP_GAIN_MUTE,
 	 AC_AMP_SET_INPUT|AC_AMP_SET_RIGHT|AC_AMP_SET_LEFT|0x17},
 	/* SPDIF route: PCM */
 	{ 0x13, AC_VERB_SET_CONNECT_SEL, 0x0 },
 	/* pin sensing on HP and Mic jacks */
 	{0x11, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | CONEXANT_HP_EVENT},
 	/* EAPD */
-	{0x10, AC_VERB_SET_EAPD_BTLENABLE, 0x0 }, /* default on */
+	{0x10, AC_VERB_SET_EAPD_BTLENABLE, 0x2 }, /* default on */ 
 	{ } /* end */
 };
 
@@ -706,14 +729,15 @@ static struct snd_kcontrol_new cxt5045_t
 static struct snd_kcontrol_new cxt5045_test_mixer[] = {
 
 	/* Output controls */
-	HDA_CODEC_VOLUME("OutAmp-1 Volume", 0x19, 0x00, HDA_OUTPUT),
-	HDA_CODEC_MUTE("OutAmp-1 Switch", 0x19,0x00, HDA_OUTPUT),
 	HDA_CODEC_VOLUME("Speaker Playback Volume", 0x10, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE("Speaker Playback Switch", 0x10, 0x0, HDA_OUTPUT),
 	
 	/* Modes for retasking pin widgets */
 	CXT_PIN_MODE("HP-OUT pin mode", 0x11, CXT_PIN_DIR_INOUT),
 	CXT_PIN_MODE("LINE1 pin mode", 0x12, CXT_PIN_DIR_INOUT),
+
+	/* EAPD Switch Control */
+	CXT_EAPD_SWITCH("External Amplifier", 0x10, 0x0),
 
 	/* Loopback mixer controls */
 	HDA_CODEC_VOLUME("MIC1 Playback Volume", 0x17, 0x01, HDA_INPUT),
@@ -725,17 +749,16 @@ static struct snd_kcontrol_new cxt5045_t
 	HDA_CODEC_VOLUME("CD Playback Volume", 0x17, 0x04, HDA_INPUT),
 	HDA_CODEC_MUTE("CD Playback Switch", 0x17, 0x04, HDA_INPUT),
 
-	/* Controls for GPIO pins, assuming they exist and are configured as outputs */
-	CXT_GPIO_DATA_SWITCH("GPIO pin 0", 0x01, 0x01),
-#if 0   /* limit this to one GPIO pin for now */	
-	CXT_GPIO_DATA_SWITCH("GPIO pin 1", 0x01, 0x02),
-	CXT_GPIO_DATA_SWITCH("GPIO pin 2", 0x01, 0x04),
-	CXT_GPIO_DATA_SWITCH("GPIO pin 3", 0x01, 0x08),
-#endif
-	CXT_SPDIF_CTRL_SWITCH("SPDIF Playback Switch", 0x13, 0x01),
-
-	HDA_CODEC_VOLUME("Capture Volume", 0x17, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE("Capture Switch", 0x17, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("Capture-1 Volume", 0x17, 0x0, HDA_INPUT),
+	HDA_CODEC_MUTE("Capture-1 Switch", 0x17, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Capture-2 Volume", 0x17, 0x1, HDA_INPUT),
+	HDA_CODEC_MUTE("Capture-2 Switch", 0x17, 0x1, HDA_INPUT),
+	HDA_CODEC_VOLUME("Capture-3 Volume", 0x17, 0x2, HDA_INPUT),
+	HDA_CODEC_MUTE("Capture-3 Switch", 0x17, 0x2, HDA_INPUT),
+	HDA_CODEC_VOLUME("Capture-4 Volume", 0x17, 0x3, HDA_INPUT),
+	HDA_CODEC_MUTE("Capture-4 Switch", 0x17, 0x3, HDA_INPUT),
+	HDA_CODEC_VOLUME("Capture-5 Volume", 0x17, 0x4, HDA_INPUT),
+	HDA_CODEC_MUTE("Capture-5 Switch", 0x17, 0x4, HDA_INPUT),
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.name = "Input Source",
@@ -748,14 +771,9 @@ static struct snd_kcontrol_new cxt5045_t
 };
 
 static struct hda_verb cxt5045_test_init_verbs[] = {
-	/* Enable all GPIOs as outputs with an initial value of 0 */
-	{0x01, AC_VERB_SET_GPIO_DIRECTION, 0x0f},
-	{0x01, AC_VERB_SET_GPIO_DATA, 0x00},
-	{0x01, AC_VERB_SET_GPIO_MASK, 0x0f},
-
 	/* Enable retasking pins as output, initially without power amp */
 	{0x12, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
-	{0x11, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
+	{0x11, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_HP},
 
 	/* Disable digital (SPDIF) pins initially, but users can enable
 	 * them via a mixer switch.  In the case of SPDIF-out, this initverb
@@ -823,6 +841,8 @@ static const char *cxt5045_models[CXT504
 
 static struct snd_pci_quirk cxt5045_cfg_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x30b7, "HP DV6000Z", CXT5045_LAPTOP),
+	SND_PCI_QUIRK(0x103c, 0x30bb, "HP DV8000", CXT5045_LAPTOP),
+	SND_PCI_QUIRK(0x1734, 0x10ad, "Fujitsu Si1520", CXT5045_LAPTOP),
 	{}
 };
 
@@ -880,11 +900,11 @@ static int patch_cxt5045(struct hda_code
 
 
 /* Conexant 5047 specific */
-
-static hda_nid_t cxt5047_dac_nids[1] = { 0x10 };
+#define CXT5047_SPDIF_OUT	0x11
+
+static hda_nid_t cxt5047_dac_nids[2] = { 0x10, 0x1c };
 static hda_nid_t cxt5047_adc_nids[1] = { 0x12 };
 static hda_nid_t cxt5047_capsrc_nids[1] = { 0x1a };
-#define CXT5047_SPDIF_OUT	0x11
 
 static struct hda_channel_mode cxt5047_modes[1] = {
 	{ 2, NULL },
@@ -893,15 +913,23 @@ static struct hda_input_mux cxt5047_capt
 static struct hda_input_mux cxt5047_capture_source = {
 	.num_items = 2,
 	.items = {
-		{ "ExtMic", 0x1 },
-		{ "IntMic", 0x2 },
+		{ "ExtMic", 0x0 },
+		{ "IntMic", 0x1 },
 	}
 };
 
 static struct hda_input_mux cxt5047_hp_capture_source = {
 	.num_items = 1,
 	.items = {
-		{ "ExtMic", 0x1 },
+		{ "ExtMic", 0x2 },
+	}
+};
+
+static struct hda_input_mux cxt5047_toshiba_capture_source = {
+	.num_items = 2,
+	.items = {
+		{ "ExtMic", 0x2 },
+		{ "Line-In", 0x1 },
 	}
 };
 
@@ -912,10 +940,14 @@ static int cxt5047_hp_master_sw_put(stru
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct conexant_spec *spec = codec->spec;
 
-	if (!conexant_eapd_put(kcontrol, ucontrol))
+	if (!cxt_eapd_put(kcontrol, ucontrol))
 		return 0;
 
-	/* toggle HP mute appropriately */
+	/* toggle internal speakers mute depending of presence of the headphone jack */
+	snd_hda_codec_amp_update(codec, 0x1d, 0, HDA_OUTPUT, 0,
+				 0x80, (!spec->hp_present & spec->cur_eapd) ? 0 : 0x80);
+	snd_hda_codec_amp_update(codec, 0x1d, 1, HDA_OUTPUT, 0,
+				 0x80, (!spec->hp_present & spec->cur_eapd) ? 0 : 0x80);
 	snd_hda_codec_amp_update(codec, 0x13, 0, HDA_OUTPUT, 0,
 				 0x80, spec->cur_eapd ? 0 : 0x80);
 	snd_hda_codec_amp_update(codec, 0x13, 1, HDA_OUTPUT, 0,
@@ -923,8 +955,7 @@ static int cxt5047_hp_master_sw_put(stru
 	return 1;
 }
 
-#if 0
-/* bind volumes of both NID 0x13 and 0x1d */
+/* bind volumes of both NID 0x13 (Headphones) and 0x1d (Speakers) */
 static int cxt5047_hp_master_vol_put(struct snd_kcontrol *kcontrol,
 				     struct snd_ctl_elem_value *ucontrol)
 {
@@ -932,9 +963,9 @@ static int cxt5047_hp_master_vol_put(str
 	long *valp = ucontrol->value.integer.value;
 	int change;
 
-	change = snd_hda_codec_amp_update(codec, 0x1c, 0, HDA_OUTPUT, 0,
+	change = snd_hda_codec_amp_update(codec, 0x1d, 0, HDA_OUTPUT, 0,
 					  0x7f, valp[0] & 0x7f);
-	change |= snd_hda_codec_amp_update(codec, 0x1c, 1, HDA_OUTPUT, 0,
+	change |= snd_hda_codec_amp_update(codec, 0x1d, 1, HDA_OUTPUT, 0,
 					   0x7f, valp[1] & 0x7f);
 	snd_hda_codec_amp_update(codec, 0x13, 0, HDA_OUTPUT, 0,
 				 0x7f, valp[0] & 0x7f);
@@ -942,19 +973,24 @@ static int cxt5047_hp_master_vol_put(str
 				 0x7f, valp[1] & 0x7f);
 	return change;
 }
-#endif
 
 /* mute internal speaker if HP is plugged */
 static void cxt5047_hp_automute(struct hda_codec *codec)
 {
-	unsigned int present;
-
-	present = snd_hda_codec_read(codec, 0x13, 0,
+
+	struct conexant_spec *spec = codec->spec;
+
+	spec->hp_present = snd_hda_codec_read(codec, 0x13, 0,
 				     AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
+	snd_hda_codec_amp_update(codec, 0x1d, 0, HDA_OUTPUT, 0,
+				 0x80, spec->hp_present|!spec->cur_eapd ? 0x80 : 0);
+	snd_hda_codec_amp_update(codec, 0x1d, 1, HDA_OUTPUT, 0,
+				 0x80, spec->hp_present|!spec->cur_eapd ? 0x80 : 0);
+	/* Mute/Unmute PCM 2 for good measure - some systems need this */
 	snd_hda_codec_amp_update(codec, 0x1c, 0, HDA_OUTPUT, 0,
-				 0x80, present ? 0x80 : 0);
+				 0x80, spec->hp_present|!spec->cur_eapd ? 0x80 : 0);
 	snd_hda_codec_amp_update(codec, 0x1c, 1, HDA_OUTPUT, 0,
-				 0x80, present ? 0x80 : 0);
+				 0x80, spec->hp_present|!spec->cur_eapd ? 0x80 : 0);
 }
 
 /* toggle input of built-in and mic jack appropriately */
@@ -1009,12 +1045,55 @@ static struct snd_kcontrol_new cxt5047_m
 	HDA_CODEC_MUTE("Capture Switch", 0x12, 0x03, HDA_INPUT),
 	HDA_CODEC_VOLUME("PCM Volume", 0x10, 0x00, HDA_OUTPUT),
 	HDA_CODEC_MUTE("PCM Switch", 0x10, 0x00, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("Master Playback Volume", 0x13, 0x00, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("PCM-2 Volume", 0x1c, 0x00, HDA_OUTPUT),
+	HDA_CODEC_MUTE("PCM-2 Switch", 0x1c, 0x00, HDA_OUTPUT),
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Master Playback Volume",
+		.info = snd_hda_mixer_amp_volume_info,
+		.get = snd_hda_mixer_amp_volume_get,
+		.put = cxt5047_hp_master_vol_put,
+		.private_value = HDA_COMPOSE_AMP_VAL(0x13, 3, 0, HDA_OUTPUT), 
+	},
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.name = "Master Playback Switch",
-		.info = conexant_eapd_info,
-		.get = conexant_eapd_get,
+		.info = cxt_eapd_info,
+		.get = cxt_eapd_get,
+		.put = cxt5047_hp_master_sw_put,
+		.private_value = 0x13,
+	},
+
+	{}
+};
+
+static struct snd_kcontrol_new cxt5047_toshiba_mixers[] = {
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Capture Source",
+		.info = conexant_mux_enum_info,
+		.get = conexant_mux_enum_get,
+		.put = conexant_mux_enum_put
+	},
+	HDA_CODEC_VOLUME("Mic Bypass Capture Volume", 0x19, 0x02, HDA_INPUT),
+	HDA_CODEC_MUTE("Mic Bypass Capture Switch", 0x19, 0x02, HDA_INPUT),
+	HDA_CODEC_VOLUME("Capture Volume", 0x12, 0x03, HDA_INPUT),
+	HDA_CODEC_MUTE("Capture Switch", 0x12, 0x03, HDA_INPUT),
+	HDA_CODEC_VOLUME("PCM Volume", 0x10, 0x00, HDA_OUTPUT),
+	HDA_CODEC_MUTE("PCM Switch", 0x10, 0x00, HDA_OUTPUT),
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Master Playback Volume",
+		.info = snd_hda_mixer_amp_volume_info,
+		.get = snd_hda_mixer_amp_volume_get,
+		.put = cxt5047_hp_master_vol_put,
+		.private_value = HDA_COMPOSE_AMP_VAL(0x13, 3, 0, HDA_OUTPUT), 
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Master Playback Switch",
+		.info = cxt_eapd_info,
+		.get = cxt_eapd_get,
 		.put = cxt5047_hp_master_sw_put,
 		.private_value = 0x13,
 	},
@@ -1040,8 +1119,8 @@ static struct snd_kcontrol_new cxt5047_h
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.name = "Master Playback Switch",
-		.info = conexant_eapd_info,
-		.get = conexant_eapd_get,
+		.info = cxt_eapd_info,
+		.get = cxt_eapd_get,
 		.put = cxt5047_hp_master_sw_put,
 		.private_value = 0x13,
 	},
@@ -1053,19 +1132,23 @@ static struct hda_verb cxt5047_init_verb
 	{0x14, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN },
 	{0x15, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN|AC_PINCTL_VREF_50 },
 	{0x17, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN|AC_PINCTL_VREF_50 },
-	/* HP, Amp  */
+	/* HP, Amp, Speaker  */
 	{0x13, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT },
-	{0x1A, AC_VERB_SET_CONNECT_SEL,0x03},
+	{0x1A, AC_VERB_SET_CONNECT_SEL,0x00},
 	{0x1A, AC_VERB_SET_AMP_GAIN_MUTE,
 	 AC_AMP_SET_OUTPUT|AC_AMP_SET_RIGHT|AC_AMP_SET_LEFT|0x00},
 	{0x1A, AC_VERB_SET_AMP_GAIN_MUTE,
 	 AC_AMP_SET_OUTPUT|AC_AMP_SET_RIGHT|AC_AMP_SET_LEFT|0x03},
+	{0x1d, AC_VERB_SET_CONNECT_SEL,0x0},
 	/* Record selector: Front mic */
 	{0x12, AC_VERB_SET_CONNECT_SEL,0x03},
 	{0x19, AC_VERB_SET_AMP_GAIN_MUTE,
 	 AC_AMP_SET_INPUT|AC_AMP_SET_RIGHT|AC_AMP_SET_LEFT|0x17},
 	/* SPDIF route: PCM */
 	{ 0x18, AC_VERB_SET_CONNECT_SEL, 0x0 },
+	/* Enable unsolicited events */
+	{0x13, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | CONEXANT_HP_EVENT},
+	{0x15, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | CONEXANT_MIC_EVENT},
 	{ } /* end */
 };
 
@@ -1075,14 +1158,24 @@ static struct hda_verb cxt5047_toshiba_i
 	/* pin sensing on HP and Mic jacks */
 	{0x13, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | CONEXANT_HP_EVENT},
 	{0x15, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | CONEXANT_MIC_EVENT},
+	/* Speaker routing */
+	{0x1d, AC_VERB_SET_CONNECT_SEL,0x1},
+	/* Change default to ExtMic for recording */
+	{0x1a, AC_VERB_SET_CONNECT_SEL,0x2},
 	{}
 };
 
 /* configuration for HP Laptops */
 static struct hda_verb cxt5047_hp_init_verbs[] = {
-	/* pin sensing on HP and Mic jacks */
+	/* pin sensing on HP jack */
 	{0x13, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | CONEXANT_HP_EVENT},
-	{0x15, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | CONEXANT_MIC_EVENT},
+	/* Record selector: Ext Mic */
+	{0x12, AC_VERB_SET_CONNECT_SEL,0x03},
+	{0x1a, AC_VERB_SET_CONNECT_SEL,0x02},
+	{0x19, AC_VERB_SET_AMP_GAIN_MUTE,
+	 AC_AMP_SET_INPUT|AC_AMP_SET_RIGHT|AC_AMP_SET_LEFT|0x17},
+	/* Speaker routing */
+	{0x1d, AC_VERB_SET_CONNECT_SEL,0x1},
 	{}
 };
 
@@ -1091,53 +1184,56 @@ static struct hda_verb cxt5047_hp_init_v
  */
 #ifdef CONFIG_SND_DEBUG
 static struct hda_input_mux cxt5047_test_capture_source = {
-	.num_items = 5,
+	.num_items = 4,
 	.items = {
-		{ "MIXER", 0x0 },
-		{ "LINE1 pin", 0x1 },
-		{ "MIC1 pin", 0x2 },
-		{ "MIC2 pin", 0x3 },
-		{ "CD pin", 0x4 },
+		{ "LINE1 pin", 0x0 },
+		{ "MIC1 pin", 0x1 },
+		{ "MIC2 pin", 0x2 },
+		{ "CD pin", 0x3 },
         },
 };
 
 static struct snd_kcontrol_new cxt5047_test_mixer[] = {
 
 	/* Output only controls */
-	HDA_CODEC_VOLUME("OutAmp-1 Volume", 0x10, 0x00, HDA_OUTPUT),
-	HDA_CODEC_MUTE("OutAmp-1 Switch", 0x10,0x00, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("OutAmp-2 Volume", 0x1c, 0x00, HDA_OUTPUT),
-	HDA_CODEC_MUTE("OutAmp-2 Switch", 0x1c, 0x00, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("OutAmp-1 Volume", 0x10, 0x0, HDA_OUTPUT),
+	HDA_CODEC_MUTE("OutAmp-1 Switch", 0x10,0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("OutAmp-2 Volume", 0x1c, 0x0, HDA_OUTPUT),
+	HDA_CODEC_MUTE("OutAmp-2 Switch", 0x1c, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME("Speaker Playback Volume", 0x1d, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE("Speaker Playback Switch", 0x1d, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME("HeadPhone Playback Volume", 0x13, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE("HeadPhone Playback Switch", 0x13, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("Line1-Out Playback Volume", 0x14, 0x0, HDA_OUTPUT),
+	HDA_CODEC_MUTE("Line1-Out Playback Switch", 0x14, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("Line2-Out Playback Volume", 0x15, 0x0, HDA_OUTPUT),
+	HDA_CODEC_MUTE("Line2-Out Playback Switch", 0x15, 0x0, HDA_OUTPUT),
 
 	/* Modes for retasking pin widgets */
 	CXT_PIN_MODE("LINE1 pin mode", 0x14, CXT_PIN_DIR_INOUT),
 	CXT_PIN_MODE("MIC1 pin mode", 0x15, CXT_PIN_DIR_INOUT),
 
+	/* EAPD Switch Control */
+	CXT_EAPD_SWITCH("External Amplifier", 0x13, 0x0),
+
 	/* Loopback mixer controls */
-	HDA_CODEC_VOLUME("MIC1 Playback Volume", 0x19, 0x02, HDA_INPUT),
-	HDA_CODEC_MUTE("MIC1 Playback Switch", 0x19, 0x02, HDA_INPUT),
-	HDA_CODEC_VOLUME("MIC2 Playback Volume", 0x19, 0x03, HDA_INPUT),
-	HDA_CODEC_MUTE("MIC2 Playback Switch", 0x19, 0x03, HDA_INPUT),
-	HDA_CODEC_VOLUME("LINE Playback Volume", 0x19, 0x01, HDA_INPUT),
-	HDA_CODEC_MUTE("LINE Playback Switch", 0x19, 0x01, HDA_INPUT),
-	HDA_CODEC_VOLUME("CD Playback Volume", 0x19, 0x04, HDA_INPUT),
-	HDA_CODEC_MUTE("CD Playback Switch", 0x19, 0x04, HDA_INPUT),
-
-#if 0   
-	/* Controls for GPIO pins, assuming they exist and are configured as outputs */
-	CXT_GPIO_DATA_SWITCH("GPIO pin 0", 0x01, 0x01),
-	CXT_GPIO_DATA_SWITCH("GPIO pin 1", 0x01, 0x02),
-	CXT_GPIO_DATA_SWITCH("GPIO pin 2", 0x01, 0x04),
-	CXT_GPIO_DATA_SWITCH("GPIO pin 3", 0x01, 0x08),
-#endif
-	CXT_SPDIF_CTRL_SWITCH("SPDIF Playback Switch", 0x18, 0x01),
-
-	HDA_CODEC_VOLUME("Capture Volume", 0x19, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE("Capture Switch", 0x19, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("MIC1 Playback Volume", 0x12, 0x01, HDA_INPUT),
+	HDA_CODEC_MUTE("MIC1 Playback Switch", 0x12, 0x01, HDA_INPUT),
+	HDA_CODEC_VOLUME("MIC2 Playback Volume", 0x12, 0x02, HDA_INPUT),
+	HDA_CODEC_MUTE("MIC2 Playback Switch", 0x12, 0x02, HDA_INPUT),
+	HDA_CODEC_VOLUME("LINE Playback Volume", 0x12, 0x0, HDA_INPUT),
+	HDA_CODEC_MUTE("LINE Playback Switch", 0x12, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("CD Playback Volume", 0x12, 0x04, HDA_INPUT),
+	HDA_CODEC_MUTE("CD Playback Switch", 0x12, 0x04, HDA_INPUT),
+
+	HDA_CODEC_VOLUME("Capture-1 Volume", 0x19, 0x0, HDA_INPUT),
+	HDA_CODEC_MUTE("Capture-1 Switch", 0x19, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Capture-2 Volume", 0x19, 0x1, HDA_INPUT),
+	HDA_CODEC_MUTE("Capture-2 Switch", 0x19, 0x1, HDA_INPUT),
+	HDA_CODEC_VOLUME("Capture-3 Volume", 0x19, 0x2, HDA_INPUT),
+	HDA_CODEC_MUTE("Capture-3 Switch", 0x19, 0x2, HDA_INPUT),
+	HDA_CODEC_VOLUME("Capture-4 Volume", 0x19, 0x3, HDA_INPUT),
+	HDA_CODEC_MUTE("Capture-4 Switch", 0x19, 0x3, HDA_INPUT),
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.name = "Input Source",
@@ -1145,16 +1241,16 @@ static struct snd_kcontrol_new cxt5047_t
 		.get = conexant_mux_enum_get,
 		.put = conexant_mux_enum_put,
 	},
+       /* Controls for GPIO pins, assuming they exist and are configured as outputs */
+	CXT_GPIO_DATA_SWITCH("GPIO pin 0", 0x01, 0x01),
+	CXT_GPIO_DATA_SWITCH("GPIO pin 1", 0x01, 0x02),
+	CXT_GPIO_DATA_SWITCH("GPIO pin 2", 0x01, 0x04),
+	CXT_GPIO_DATA_SWITCH("GPIO pin 3", 0x01, 0x08),
 
 	{ } /* end */
 };
 
 static struct hda_verb cxt5047_test_init_verbs[] = {
-	/* Enable all GPIOs as outputs with an initial value of 0 */
-	{0x01, AC_VERB_SET_GPIO_DIRECTION, 0x0f},
-	{0x01, AC_VERB_SET_GPIO_DATA, 0x00},
-	{0x01, AC_VERB_SET_GPIO_MASK, 0x0f},
-
 	/* Enable retasking pins as output, initially without power amp */
 	{0x15, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
 	{0x14, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
@@ -1215,7 +1311,6 @@ static int cxt5047_hp_init(struct hda_co
 {
 	conexant_init(codec);
 	cxt5047_hp_automute(codec);
-	cxt5047_hp_automic(codec);
 	return 0;
 }
 
@@ -1242,6 +1337,7 @@ static struct snd_pci_quirk cxt5047_cfg_
 static struct snd_pci_quirk cxt5047_cfg_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x30a0, "HP DV1000", CXT5047_LAPTOP),
 	SND_PCI_QUIRK(0x103c, 0x30b2, "HP DV2000T/DV3000T", CXT5047_LAPTOP),
+	SND_PCI_QUIRK(0x103c, 0x30b5, "HP DV2000Z", CXT5047_LAPTOP),
 	SND_PCI_QUIRK(0x103c, 0x30a5, "HP DV5200T/DV8000T", CXT5047_LAPTOP_HP),
 	SND_PCI_QUIRK(0x1179, 0xff31, "Toshiba P100", CXT5047_LAPTOP_EAPD),
 	{}
@@ -1291,8 +1387,10 @@ static int patch_cxt5047(struct hda_code
 		codec->patch_ops.init = cxt5047_hp_init;
 		break;
 	case CXT5047_LAPTOP_EAPD:
+		spec->input_mux = &cxt5047_toshiba_capture_source;
 		spec->num_init_verbs = 2;
 		spec->init_verbs[1] = cxt5047_toshiba_init_verbs;
+		spec->mixers[0] = cxt5047_toshiba_mixers;
 		break;
 #ifdef CONFIG_SND_DEBUG
 	case CXT5047_TEST:
@@ -1305,7 +1403,7 @@ static int patch_cxt5047(struct hda_code
 }
 
 struct hda_codec_preset snd_hda_preset_conexant[] = {
-	{ .id = 0x14f15045, .name = "CXT5045", .patch = patch_cxt5045 },
-	{ .id = 0x14f15047, .name = "CXT5047", .patch = patch_cxt5047 },
+	{ .id = 0x14f15045, .name = "CX20549 (Venice)", .patch = patch_cxt5045 },
+	{ .id = 0x14f15047, .name = "CX20551 (Waikiki)", .patch = patch_cxt5047 },
 	{} /* terminator */
 };

--=-SoLWrVO1TFwUDBffaTh4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--=-SoLWrVO1TFwUDBffaTh4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-SoLWrVO1TFwUDBffaTh4--
