From: Lydia Wang <lydiawang@viatech.com.cn>
Subject: [PATCH 2/16] ALSA: VIA HDA: Add support for VT1802
Date: Mon, 21 Mar 2011 15:22:39 +0800
Message-ID: <4D86FCBF.60803@viatech.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from exchtp08.via.com.tw (exchtp08.via.com.tw [61.66.243.7])
	by alsa0.perex.cz (Postfix) with ESMTP id 0DFEC243DE
	for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2011 08:22:46 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de, HaraldWelte@viatech.com, lydiawang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

From: Lydia Wang <lydiawang@viatech.com.cn>
Subject: ALSA: VIA HDA: Add support for VT1802.

Add support for VT1802 codec, which is similiar with VT2002P.

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>
 sound/pci/hda/patch_via.c |  208 +++++++++++++++++++++++++------
 1 file changed, 174 insertions(+), 34 deletions(-)

--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -98,6 +98,7 @@
 	VT1716S,
 	VT2002P,
 	VT1812,
+	VT1802,
 	CODEC_TYPES,
 };
 
@@ -216,6 +217,8 @@
 		codec_type = VT1812;
 	else if (dev_id == 0x0440)
 		codec_type = VT1708S;
+	else if ((dev_id & 0xfff) == 0x446)
+		codec_type = VT1802;
 	else
 		codec_type = UNKNOWN;
 	return codec_type;
@@ -734,7 +737,8 @@
 	    || spec->codec_type == VT1718S
 	    || spec->codec_type == VT1716S
 	    || spec->codec_type == VT2002P
-	    || spec->codec_type == VT1812) {
+	    || spec->codec_type == VT1812
+	    || spec->codec_type == VT1802) {
 		activate_ctl(codec, "Headphone Playback Volume",
 			     spec->hp_independent_mode);
 		activate_ctl(codec, "Headphone Playback Switch",
@@ -770,6 +774,7 @@
 		nid = 0x34;
 		break;
 	case VT2002P:
+	case VT1802:
 		nid = 0x35;
 		break;
 	case VT1812:
@@ -1045,6 +1050,7 @@
 		break;
 	case VT2002P:
 	case VT1812:
+	case VT1802:
 		nid_mixer = 0x21;
 		start_idx = 0;
 		end_idx = 2;
@@ -1109,6 +1115,7 @@
 		break;
 	case VT2002P:
 	case VT1812:
+	case VT1802:
 		verb = 0xf93;
 		parm = enable ? 0x00 : 0xe0; /* 0x00: 4/40x, 0xe0: 1x */
 		break;
@@ -1637,7 +1644,9 @@
 	unsigned int hp_present;
 	struct via_spec *spec = codec->spec;
 
-	if (spec->codec_type != VT2002P && spec->codec_type != VT1812)
+	if (spec->codec_type != VT2002P &&
+		spec->codec_type != VT1812 &&
+		spec->codec_type != VT1802)
 		return;
 
 	hp_present = snd_hda_jack_detect(codec, spec->autocfg.hp_pins[0]);
@@ -2122,7 +2131,10 @@
 	via_auto_init_multi_out(codec);
 	via_auto_init_hp_out(codec);
 	via_auto_init_analog_input(codec);
-	if (spec->codec_type == VT2002P || spec->codec_type == VT1812) {
+
+	if (spec->codec_type == VT2002P ||
+		spec->codec_type == VT1812 ||
+		spec->codec_type == VT1802) {
 		via_hp_bind_automute(codec);
 	} else {
 		via_hp_automute(codec);
@@ -5187,6 +5199,67 @@
 	{0x1, 0xfb8, 0x88},
 	{ }
 };
+static struct hda_verb vt1802_volume_init_verbs[] = {
+	/* Special verbs */
+	/*{0x1, 0xf93, 0xc3},
+	{0x1, 0xfa2, 0x70},
+	{0x1, 0xfe0, 0x04},
+	{0x1, 0xfe3, 0xfc},
+	{0x1, 0xff0, 0x39},
+	{0x1, 0xfa1, 0x58},
+	{0x1, 0xfd9, 0x0b},
+	{0x1, 0xfdb, 0x20},
+	{0x1, 0xfb0, 0x2b},*/
+	/*
+	 * Unmute ADC0-1 and set the default input to mic-in
+	 */
+	{0x8, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+	{0x9, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+
+
+	/* Mute input amps (CD, Line In, Mic 1 & Mic 2) of the analog-loopback
+	 * mixer widget
+	 */
+	/* Amp Indices: CD = 1, Mic1 = 2, Line = 3, Mic2 = 4 */
+	{0x21, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+	{0x21, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
+	{0x21, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(2)},
+	{0x21, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(3)},
+	{0x21, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(4)},
+
+	/* MUX Indices: Mic = 0 */
+	{0x1e, AC_VERB_SET_CONNECT_SEL, 0},
+	{0x1f, AC_VERB_SET_CONNECT_SEL, 0},
+
+	/* PW9 Output enable */
+	{0x2d, AC_VERB_SET_PIN_WIDGET_CONTROL, AC_PINCTL_OUT_EN},
+
+	/* Enable Boost Volume backdoor */
+	{0x1, 0xfb9, 0x24},
+
+	/* MW0/1/4/8: un-mute index 0 (MUXx), un-mute index 1 (MW9) */
+	{0x14, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+	{0x15, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+	{0x18, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+	{0x1c, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+	{0x14, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},
+	{0x15, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},
+	{0x18, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},
+	{0x1c, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},
+
+	/* set MUX0/1/4/8 = 0 (AOW0) */
+	{0x34, AC_VERB_SET_CONNECT_SEL, 0},
+	{0x35, AC_VERB_SET_CONNECT_SEL, 0},
+	{0x38, AC_VERB_SET_CONNECT_SEL, 0},
+	{0x3c, AC_VERB_SET_CONNECT_SEL, 0},
+
+	/* set PW0 index=0 (MW0) */
+	{0x24, AC_VERB_SET_CONNECT_SEL, 0},
+
+	/* Enable AOW0 to MW9 */
+	{0x1, 0xfb8, 0x88},
+	{ }
+};
 
 
 static struct hda_verb vt2002P_uniwill_init_verbs[] = {
@@ -5199,6 +5272,16 @@
 	{0x2b, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | VIA_JACK_EVENT},
 	{ }
 };
+static struct hda_verb vt1802_uniwill_init_verbs[] = {
+	{0x25, AC_VERB_SET_UNSOLICITED_ENABLE,
+	 AC_USRSP_EN | VIA_JACK_EVENT | VIA_BIND_HP_EVENT},
+	{0x28, AC_VERB_SET_UNSOLICITED_ENABLE,
+	 AC_USRSP_EN | VIA_JACK_EVENT | VIA_BIND_HP_EVENT},
+	{0x29, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | VIA_JACK_EVENT},
+	{0x2a, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | VIA_JACK_EVENT},
+	{0x2b, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | VIA_JACK_EVENT},
+	{ }
+};
 
 static struct hda_pcm_stream vt2002P_pcm_analog_playback = {
 	.substreams = 2,
@@ -5255,10 +5338,15 @@
 					     const struct auto_pin_cfg *cfg)
 {
 	int err;
+	hda_nid_t sw_nid;
 
 	if (!cfg->line_out_pins[0])
 		return -1;
 
+	if (spec->codec_type == VT1802)
+		sw_nid = 0x28;
+	else
+		sw_nid = 0x26;
 
 	/* Line-Out: PortE */
 	err = via_add_control(spec, VIA_CTL_WIDGET_VOL,
@@ -5268,7 +5356,7 @@
 		return err;
 	err = via_add_control(spec, VIA_CTL_WIDGET_BIND_PIN_MUTE,
 			      "Master Front Playback Switch",
-			      HDA_COMPOSE_AMP_VAL(0x26, 3, 0, HDA_OUTPUT));
+			      HDA_COMPOSE_AMP_VAL(sw_nid, 3, 0, HDA_OUTPUT));
 	if (err < 0)
 		return err;
 
@@ -5403,22 +5491,41 @@
 	/* AOW0 (8h)*/
 	snd_hda_codec_write(codec, 0x8, 0, AC_VERB_SET_POWER_STATE, parm);
 
-	/* PW4 (26h), MW4 (1ch), MUX4(37h) */
-	parm = AC_PWRST_D3;
-	set_pin_power_state(codec, 0x26, &parm);
-	snd_hda_codec_write(codec, 0x1c, 0,
-			    AC_VERB_SET_POWER_STATE, parm);
-	snd_hda_codec_write(codec, 0x37, 0,
-			    AC_VERB_SET_POWER_STATE, parm);
-
+	if (spec->codec_type == VT1802) {
+		/* PW4 (28h), MW4 (18h), MUX4(38h) */
+		parm = AC_PWRST_D3;
+		set_pin_power_state(codec, 0x28, &parm);
+		snd_hda_codec_write(codec, 0x18, 0,
+				    AC_VERB_SET_POWER_STATE, parm);
+		snd_hda_codec_write(codec, 0x38, 0,
+				    AC_VERB_SET_POWER_STATE, parm);
+	} else {
+		/* PW4 (26h), MW4 (1ch), MUX4(37h) */
+		parm = AC_PWRST_D3;
+		set_pin_power_state(codec, 0x26, &parm);
+		snd_hda_codec_write(codec, 0x1c, 0,
+				    AC_VERB_SET_POWER_STATE, parm);
+		snd_hda_codec_write(codec, 0x37, 0,
+				    AC_VERB_SET_POWER_STATE, parm);
+	}
 
-	/* PW1 (25h), MW1 (19h), MUX1(35h), AOW1 (9h) */
-	parm = AC_PWRST_D3;
-	set_pin_power_state(codec, 0x25, &parm);
-	snd_hda_codec_write(codec, 0x19, 0,
-			    AC_VERB_SET_POWER_STATE, parm);
-	snd_hda_codec_write(codec, 0x35, 0,
-			    AC_VERB_SET_POWER_STATE, parm);
+	if (spec->codec_type == VT1802) {
+		/* PW1 (25h), MW1 (15h), MUX1(35h), AOW1 (9h) */
+		parm = AC_PWRST_D3;
+		set_pin_power_state(codec, 0x25, &parm);
+		snd_hda_codec_write(codec, 0x15, 0,
+				    AC_VERB_SET_POWER_STATE, parm);
+		snd_hda_codec_write(codec, 0x35, 0,
+				    AC_VERB_SET_POWER_STATE, parm);
+	} else {
+		/* PW1 (25h), MW1 (19h), MUX1(35h), AOW1 (9h) */
+		parm = AC_PWRST_D3;
+		set_pin_power_state(codec, 0x25, &parm);
+		snd_hda_codec_write(codec, 0x19, 0,
+				    AC_VERB_SET_POWER_STATE, parm);
+		snd_hda_codec_write(codec, 0x35, 0,
+				    AC_VERB_SET_POWER_STATE, parm);
+	}
 
 	if (spec->hp_independent_mode)
 		snd_hda_codec_write(codec, 0x9, 0,
@@ -5432,8 +5539,12 @@
 	parm = AC_PWRST_D3;
 	set_pin_power_state(codec, 0x24, &parm);
 	parm = present ? AC_PWRST_D3 : AC_PWRST_D0;
-	snd_hda_codec_write(codec, 0x18, 0,
-			    AC_VERB_SET_POWER_STATE, parm);
+	if (spec->codec_type == VT1802)
+		snd_hda_codec_write(codec, 0x14, 0,
+				    AC_VERB_SET_POWER_STATE, parm);
+	else
+		snd_hda_codec_write(codec, 0x18, 0,
+				    AC_VERB_SET_POWER_STATE, parm);
 	snd_hda_codec_write(codec, 0x34, 0, AC_VERB_SET_POWER_STATE, parm);
 
 	/* Mono Out */
@@ -5441,15 +5552,23 @@
 	snd_hda_codec_read(codec, 0x26, 0,
 			   AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
 	parm = present ? AC_PWRST_D3 : AC_PWRST_D0;
-
-	/* PW15 (31h), MW8(17h), MUX8(3bh) */
-	snd_hda_codec_write(codec, 0x31, 0,
-			    AC_VERB_SET_POWER_STATE, parm);
-	snd_hda_codec_write(codec, 0x17, 0,
-			    AC_VERB_SET_POWER_STATE, parm);
-	snd_hda_codec_write(codec, 0x3b, 0,
-			    AC_VERB_SET_POWER_STATE, parm);
-
+	if (spec->codec_type == VT1802) {
+		/* PW15 (33h), MW8(1ch), MUX8(3ch) */
+		snd_hda_codec_write(codec, 0x33, 0,
+				    AC_VERB_SET_POWER_STATE, parm);
+		snd_hda_codec_write(codec, 0x1c, 0,
+				    AC_VERB_SET_POWER_STATE, parm);
+		snd_hda_codec_write(codec, 0x3c, 0,
+				    AC_VERB_SET_POWER_STATE, parm);
+	} else {
+		/* PW15 (31h), MW8(17h), MUX8(3bh) */
+		snd_hda_codec_write(codec, 0x31, 0,
+				    AC_VERB_SET_POWER_STATE, parm);
+		snd_hda_codec_write(codec, 0x17, 0,
+				    AC_VERB_SET_POWER_STATE, parm);
+		snd_hda_codec_write(codec, 0x3b, 0,
+				    AC_VERB_SET_POWER_STATE, parm);
+	}
 	/* MW9 (21h) */
 	if (imux_is_smixer || !is_aa_path_mute(codec))
 		snd_hda_codec_write(codec, 0x21, 0,
@@ -5480,14 +5599,31 @@
 		       "from BIOS.  Using genenic mode...\n");
 	}
 
-	spec->init_verbs[spec->num_iverbs++]  = vt2002P_volume_init_verbs;
-	spec->init_verbs[spec->num_iverbs++] = vt2002P_uniwill_init_verbs;
+	if (spec->codec_type == VT1802)
+		spec->init_verbs[spec->num_iverbs++]  =
+			vt1802_volume_init_verbs;
+	else
+		spec->init_verbs[spec->num_iverbs++]  =
+			vt2002P_volume_init_verbs;
+
+	if (spec->codec_type == VT1802)
+		spec->init_verbs[spec->num_iverbs++] =
+			vt1802_uniwill_init_verbs;
+	else
+		spec->init_verbs[spec->num_iverbs++] =
+			vt2002P_uniwill_init_verbs;
 
-	spec->stream_name_analog = "VT2002P Analog";
+	if (spec->codec_type == VT1802)
+		spec->stream_name_analog = "VT1802 Analog";
+	else
+		spec->stream_name_analog = "VT2002P Analog";
 	spec->stream_analog_playback = &vt2002P_pcm_analog_playback;
 	spec->stream_analog_capture = &vt2002P_pcm_analog_capture;
 
-	spec->stream_name_digital = "VT2002P Digital";
+	if (spec->codec_type == VT1802)
+		spec->stream_name_digital = "VT1802 Digital";
+	else
+		spec->stream_name_digital = "VT2002P Digital";
 	spec->stream_digital_playback = &vt2002P_pcm_digital_playback;
 
 	if (!spec->adc_nids && spec->input_mux) {
@@ -6020,6 +6156,10 @@
 	{ .id = 0x11060448, .name = "VT1812", .patch = patch_vt1812},
 	{ .id = 0x11060440, .name = "VT1818S",
 	  .patch = patch_vt1708S},
+	{ .id = 0x11060446, .name = "VT1802",
+		.patch = patch_vt2002P},
+	{ .id = 0x11068446, .name = "VT1802",
+		.patch = patch_vt2002P},
 	{} /* terminator */
 };
