From: Li Bo <liboat@gmail.com>
Subject: [PATCH 26/31] HDA patch_via.c: Add VT2002P support.
Date: Mon, 5 Oct 2009 22:28:21 +0800
Message-ID: <16685ee0910050728k1317ca8br1954fb0e4ccb81ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f225.google.com (mail-bw0-f225.google.com
	[209.85.218.225])
	by alsa0.perex.cz (Postfix) with ESMTP id 00AD11038C7
	for <alsa-devel@alsa-project.org>;
	Mon,  5 Oct 2009 16:28:21 +0200 (CEST)
Received: by mail-bw0-f225.google.com with SMTP id 25so10052327bwz.32
	for <alsa-devel@alsa-project.org>; Mon, 05 Oct 2009 07:28:21 -0700 (PDT)
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
Cc: tiwai@suse.de, LoganLi@viatech.com.cn, HaraldWelte@viatech.com, lydiawang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

[ALSA] HDA VIA: Add VT2002P support.

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>

Index: sound-2.6/sound/pci/hda/patch_via.c
===================================================================
--- sound-2.6.orig/sound/pci/hda/patch_via.c	2009-10-05 15:12:39.000000000 +0800
+++ sound-2.6/sound/pci/hda/patch_via.c	2009-10-05 15:13:44.000000000 +0800
@@ -88,6 +88,7 @@
 	VT1702,
 	VT1718S,
 	VT1716S,
+	VT2002P,
 	CODEC_TYPES,
 };

@@ -126,6 +127,8 @@
 		codec_type = VT1716S;
 	else if (dev_id == 0x0441 || dev_id == 0x4441)
 		codec_type = VT1718S;
+	else if (dev_id == 0x0438 || dev_id == 0x4438)
+		codec_type = VT2002P;
 	else
 		codec_type = UNKNOWN;
 	return codec_type;
@@ -135,11 +138,14 @@
 #define VIA_GPIO_EVENT		0x02
 #define VIA_JACK_EVENT		0x04
 #define VIA_MONO_EVENT		0x08
+#define VIA_SPEAKER_EVENT	0x10
+#define VIA_BIND_HP_EVENT	0x20

 enum {
 	VIA_CTL_WIDGET_VOL,
 	VIA_CTL_WIDGET_MUTE,
 	VIA_CTL_WIDGET_ANALOG_MUTE,
+	VIA_CTL_WIDGET_BIND_PIN_MUTE,
 };

 enum {
@@ -149,36 +155,6 @@
 	AUTO_SEQ_SIDE
 };

-static void analog_low_current_mode(struct hda_codec *codec, int stream_idle);
-static void set_jack_power_state(struct hda_codec *codec);
-
-static int analog_input_switch_put(struct snd_kcontrol *kcontrol,
-				   struct snd_ctl_elem_value *ucontrol)
-{
-	int change = snd_hda_mixer_amp_switch_put(kcontrol, ucontrol);
-	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-
-	set_jack_power_state(codec);
-	analog_low_current_mode(snd_kcontrol_chip(kcontrol), -1);
-	return change;
-}
-
-/* modify .put = snd_hda_mixer_amp_switch_put */
-#define ANALOG_INPUT_MUTE						\
-	{		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,		\
-			.name = NULL,					\
-			.index = 0,					\
-			.info = snd_hda_mixer_amp_switch_info,		\
-			.get = snd_hda_mixer_amp_switch_get,		\
-			.put = analog_input_switch_put,			\
-			.private_value = HDA_COMPOSE_AMP_VAL(0, 3, 0, 0) }
-
-static struct snd_kcontrol_new vt1708_control_templates[] = {
-	HDA_CODEC_VOLUME(NULL, 0, 0, 0),
-	HDA_CODEC_MUTE(NULL, 0, 0, 0),
-	ANALOG_INPUT_MUTE,
-};
-

 struct via_spec {
 	/* codec parameterization */
@@ -238,6 +214,132 @@
 #endif
 };

+static void analog_low_current_mode(struct hda_codec *codec, int stream_idle);
+static void set_jack_power_state(struct hda_codec *codec);
+
+static int analog_input_switch_put(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	int change = snd_hda_mixer_amp_switch_put(kcontrol, ucontrol);
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+
+	set_jack_power_state(codec);
+	analog_low_current_mode(snd_kcontrol_chip(kcontrol), -1);
+	return change;
+}
+
+/* modify .put = snd_hda_mixer_amp_switch_put */
+#define ANALOG_INPUT_MUTE						\
+	{		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,		\
+			.name = NULL,					\
+			.index = 0,					\
+			.info = snd_hda_mixer_amp_switch_info,		\
+			.get = snd_hda_mixer_amp_switch_get,		\
+			.put = analog_input_switch_put,			\
+			.private_value = HDA_COMPOSE_AMP_VAL(0, 3, 0, 0) }
+
+static void via_hp_bind_automute(struct hda_codec *codec);
+
+static int bind_pin_switch_put(struct snd_kcontrol *kcontrol,
+			       struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct via_spec *spec = codec->spec;
+	int i;
+	int change = 0;
+
+	long *valp = ucontrol->value.integer.value;
+	int lmute, rmute;
+	if (strstr(kcontrol->id.name, "Switch") == NULL) {
+		snd_printd("Invalid control!\n");
+		return change;
+	}
+	change = snd_hda_mixer_amp_switch_put(kcontrol,
+					      ucontrol);
+	/* Get mute value */
+	lmute = *valp ? 0 : HDA_AMP_MUTE;
+	valp++;
+	rmute = *valp ? 0 : HDA_AMP_MUTE;
+
+	/* Set hp pins */
+	if (!spec->hp_independent_mode) {
+		for (i = 0; i < spec->autocfg.hp_outs; i++) {
+			snd_hda_codec_amp_update(
+				codec, spec->autocfg.hp_pins[i],
+				0, HDA_OUTPUT, 0, HDA_AMP_MUTE,
+				lmute);
+			snd_hda_codec_amp_update(
+				codec, spec->autocfg.hp_pins[i],
+				1, HDA_OUTPUT, 0, HDA_AMP_MUTE,
+				rmute);
+		}
+	}
+
+	if (!lmute && !rmute) {
+		/* Line Outs */
+		for (i = 0; i < spec->autocfg.line_outs; i++)
+			snd_hda_codec_amp_stereo(
+				codec, spec->autocfg.line_out_pins[i],
+				HDA_OUTPUT, 0, HDA_AMP_MUTE, 0);
+		/* Speakers */
+		for (i = 0; i < spec->autocfg.speaker_outs; i++)
+			snd_hda_codec_amp_stereo(
+				codec, spec->autocfg.speaker_pins[i],
+				HDA_OUTPUT, 0, HDA_AMP_MUTE, 0);
+		/* unmute */
+		via_hp_bind_automute(codec);
+
+	} else {
+		if (lmute) {
+			/* Mute all left channels */
+			for (i = 1; i < spec->autocfg.line_outs; i++)
+				snd_hda_codec_amp_update(
+					codec,
+					spec->autocfg.line_out_pins[i],
+					0, HDA_OUTPUT, 0, HDA_AMP_MUTE,
+					lmute);
+			for (i = 0; i < spec->autocfg.speaker_outs; i++)
+				snd_hda_codec_amp_update(
+					codec,
+					spec->autocfg.speaker_pins[i],
+					0, HDA_OUTPUT, 0, HDA_AMP_MUTE,
+					lmute);
+		}
+		if (rmute) {
+			/* mute all right channels */
+			for (i = 1; i < spec->autocfg.line_outs; i++)
+				snd_hda_codec_amp_update(
+					codec,
+					spec->autocfg.line_out_pins[i],
+					1, HDA_OUTPUT, 0, HDA_AMP_MUTE,
+					rmute);
+			for (i = 0; i < spec->autocfg.speaker_outs; i++)
+				snd_hda_codec_amp_update(
+					codec,
+					spec->autocfg.speaker_pins[i],
+					1, HDA_OUTPUT, 0, HDA_AMP_MUTE,
+					rmute);
+		}
+	}
+	return change;
+}
+
+#define BIND_PIN_MUTE							\
+	{		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,		\
+			.name = NULL,					\
+			.index = 0,					\
+			.info = snd_hda_mixer_amp_switch_info,		\
+			.get = snd_hda_mixer_amp_switch_get,		\
+			.put = bind_pin_switch_put,			\
+			.private_value = HDA_COMPOSE_AMP_VAL(0, 3, 0, 0) }
+
+static struct snd_kcontrol_new vt1708_control_templates[] = {
+	HDA_CODEC_VOLUME(NULL, 0, 0, 0),
+	HDA_CODEC_MUTE(NULL, 0, 0, 0),
+	ANALOG_INPUT_MUTE,
+	BIND_PIN_MUTE,
+};
+
 static hda_nid_t vt1708_adc_nids[2] = {
 	/* ADC1-2 */
 	0x15, 0x27
@@ -273,6 +375,11 @@
 	0x13, 0x14
 };

+static hda_nid_t vt2002P_adc_nids[2] = {
+	/* ADC1-2 */
+	0x10, 0x11
+};
+
 /* add dynamic controls */
 static int via_add_control(struct via_spec *spec, int type, const char *name,
 			   unsigned long val)
@@ -355,10 +462,13 @@
 {
 	struct via_spec *spec = codec->spec;
 	hda_nid_t pin;
+	int i;

-	pin = spec->autocfg.hp_pins[0];
-	if (pin) /* connect to front */
-		via_auto_set_output_and_unmute(codec, pin, PIN_HP, 0);
+	for (i = 0; i < spec->autocfg.hp_outs; i++) {
+		pin = spec->autocfg.hp_pins[i];
+		if (pin) /* connect to front */
+			via_auto_set_output_and_unmute(codec, pin, PIN_HP, 0);
+	}
 }

 static void via_auto_init_analog_input(struct hda_codec *codec)
@@ -401,6 +511,65 @@
 	snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_POWER_STATE, parm);
 }

+/* check AA path's mute statue */
+static int is_aa_path_mute(struct hda_codec *codec)
+{
+	int mute = 1;
+	hda_nid_t  nid_mixer;
+	int start_idx;
+	int end_idx;
+	int i;
+	struct via_spec *spec = codec->spec;
+	/* get nid of MW0 and start & end index */
+	switch (spec->codec_type) {
+	case VT1708B_8CH:
+	case VT1708B_4CH:
+	case VT1708S:
+	case VT1716S:
+		nid_mixer = 0x16;
+		start_idx = 2;
+		end_idx = 4;
+		break;
+	case VT1702:
+		nid_mixer = 0x1a;
+		start_idx = 1;
+		end_idx = 3;
+		break;
+	case VT1718S:
+		nid_mixer = 0x21;
+		start_idx = 1;
+		end_idx = 3;
+		break;
+	case VT2002P:
+		nid_mixer = 0x21;
+		start_idx = 0;
+		end_idx = 2;
+		break;
+	default:
+		return 0;
+	}
+	/* check AA path's mute status */
+	for (i = start_idx; i <= end_idx; i++) {
+		unsigned int con_list = snd_hda_codec_read(
+			codec, nid_mixer, 0, AC_VERB_GET_CONNECT_LIST, i/4*4);
+		int shift = 8 * (i % 4);
+		hda_nid_t nid_pin = (con_list & (0xff << shift)) >> shift;
+		unsigned int defconf = snd_hda_codec_get_pincfg(codec, nid_pin);
+		if (get_defcfg_connect(defconf) == AC_JACK_PORT_COMPLEX) {
+			/* check mute status while the pin is connected */
+			int mute_l = snd_hda_codec_amp_read(codec, nid_mixer, 0,
+							    HDA_INPUT, i) >> 7;
+			int mute_r = snd_hda_codec_amp_read(codec, nid_mixer, 1,
+							    HDA_INPUT, i) >> 7;
+			if (!mute_l || !mute_r) {
+				mute = 0;
+				break;
+			}
+		}
+	}
+	return mute;
+}
+
 static void set_jack_power_state(struct hda_codec *codec)
 {
 	struct via_spec *spec = codec->spec;
@@ -662,6 +831,107 @@
 				    imux_is_smixer ? AC_PWRST_D0 : parm);
 		snd_hda_codec_write(codec, 0x10, 0, AC_VERB_SET_POWER_STATE,
 				    mono_out ? AC_PWRST_D0 : parm);
+	} else if (spec->codec_type == VT2002P) {
+		unsigned int present;
+		/* MUX9 (1eh) = stereo mixer */
+		imux_is_smixer = snd_hda_codec_read(
+			codec, 0x1e, 0, AC_VERB_GET_CONNECT_SEL, 0x00) == 3;
+		/* inputs */
+		/* PW 5/6/7 (29h/2ah/2bh) */
+		parm = AC_PWRST_D3;
+		set_pin_power_state(codec, 0x29, &parm);
+		set_pin_power_state(codec, 0x2a, &parm);
+		set_pin_power_state(codec, 0x2b, &parm);
+		if (imux_is_smixer)
+			parm = AC_PWRST_D0;
+		/* MUX9/10 (1eh/1fh), AIW 0/1 (10h/11h) */
+		snd_hda_codec_write(codec, 0x1e, 0,
+				    AC_VERB_SET_POWER_STATE, parm);
+		snd_hda_codec_write(codec, 0x1f, 0,
+				    AC_VERB_SET_POWER_STATE, parm);
+		snd_hda_codec_write(codec, 0x10, 0,
+				    AC_VERB_SET_POWER_STATE, parm);
+		snd_hda_codec_write(codec, 0x11, 0,
+				    AC_VERB_SET_POWER_STATE, parm);
+
+		/* outputs */
+		/* AOW0 (8h)*/
+		snd_hda_codec_write(codec, 0x8, 0,
+				    AC_VERB_SET_POWER_STATE, AC_PWRST_D0);
+
+		/* PW4 (26h), MW4 (1ch), MUX4(37h) */
+		parm = AC_PWRST_D3;
+		set_pin_power_state(codec, 0x26, &parm);
+		snd_hda_codec_write(codec, 0x1c, 0,
+				    AC_VERB_SET_POWER_STATE, parm);
+		snd_hda_codec_write(codec, 0x37,
+				    0, AC_VERB_SET_POWER_STATE, parm);
+
+		/* PW1 (25h), MW1 (19h), MUX1(35h), AOW1 (9h) */
+		parm = AC_PWRST_D3;
+		set_pin_power_state(codec, 0x25, &parm);
+		snd_hda_codec_write(codec, 0x19, 0,
+				    AC_VERB_SET_POWER_STATE, parm);
+		snd_hda_codec_write(codec, 0x35, 0,
+				    AC_VERB_SET_POWER_STATE, parm);
+		if (spec->hp_independent_mode)	{
+			snd_hda_codec_write(codec, 0x9, 0,
+					    AC_VERB_SET_POWER_STATE, parm);
+		}
+
+		/* Class-D */
+		/* PW0 (24h), MW0(18h), MUX0(34h) */
+		present = snd_hda_codec_read(
+			codec, 0x25, 0, AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
+		parm = AC_PWRST_D3;
+		set_pin_power_state(codec, 0x24, &parm);
+		if (present) {
+			snd_hda_codec_write(
+				codec, 0x18, 0,
+				AC_VERB_SET_POWER_STATE, AC_PWRST_D3);
+			snd_hda_codec_write(
+				codec, 0x34, 0,
+				AC_VERB_SET_POWER_STATE, AC_PWRST_D3);
+		} else {
+			snd_hda_codec_write(
+				codec, 0x18, 0,
+				AC_VERB_SET_POWER_STATE, AC_PWRST_D0);
+			snd_hda_codec_write(
+				codec, 0x34, 0,
+				AC_VERB_SET_POWER_STATE, AC_PWRST_D0);
+		}
+
+		/* Mono Out */
+		/* PW15 (31h), MW8(17h), MUX8(3bh) */
+		present = snd_hda_codec_read(
+			codec, 0x26, 0, AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
+		parm = AC_PWRST_D3;
+		set_pin_power_state(codec, 0x31, &parm);
+		if (present) {
+			snd_hda_codec_write(
+				codec, 0x17, 0,
+				AC_VERB_SET_POWER_STATE, AC_PWRST_D3);
+			snd_hda_codec_write(
+				codec, 0x3b, 0,
+				AC_VERB_SET_POWER_STATE, AC_PWRST_D3);
+		} else {
+			snd_hda_codec_write(
+				codec, 0x17, 0,
+				AC_VERB_SET_POWER_STATE, AC_PWRST_D0);
+			snd_hda_codec_write(
+				codec, 0x3b, 0,
+				AC_VERB_SET_POWER_STATE, AC_PWRST_D0);
+		}
+
+		/* MW9 (21h) */
+		if (imux_is_smixer || !is_aa_path_mute(codec))
+			snd_hda_codec_write(
+				codec, 0x21, 0,
+				AC_VERB_SET_POWER_STATE, AC_PWRST_D0);
+		else
+			snd_hda_codec_write(
+				codec, 0x21, 0,
+				AC_VERB_SET_POWER_STATE, AC_PWRST_D3);
 	}
 }

@@ -734,13 +1004,18 @@
 			codec, mux1, 0, AC_VERB_GET_CONNECT_SEL, 0x00);
 		pinsel = conn_sel == 0 ? 0 : 1;
 	}
-
+	if (spec->codec_type == VT2002P) {
+		hda_nid_t mux1 = 0x35;
+		pinsel = snd_hda_codec_read(
+			codec, mux1, 0, AC_VERB_GET_CONNECT_SEL, 0);
+	}
 	ucontrol->value.enumerated.item[0] = pinsel;
 	/* update HP controls on first time */
 	if ((spec->codec_type == VT1708S
 	     || spec->codec_type == VT1702
 	     || spec->codec_type == VT1718S
-	     || spec->codec_type == VT1716S)
+	     || spec->codec_type == VT1716S
+	     || spec->codec_type == VT2002P)
 	    && hp_ctl_initialized == -1) {
 		struct snd_card *card = codec->bus->card;
 		struct snd_kcontrol *kctl;
@@ -774,6 +1049,7 @@
 		[VT1702] = 0,
 		[VT1718S] = 0,
 		[VT1716S] = 0,
+		[VT2002P] = 0,
 	};

 	if (!nids_sw3[spec->codec_type])
@@ -802,10 +1078,14 @@
 		snd_hda_codec_write(codec, mux1, 0,
 				    AC_VERB_SET_CONNECT_SEL, pinsel ? 2 : 0);
 		spec->multiout.num_dacs = 4;
-	} else
+	} else if (spec->codec_type == VT2002P) {
+		/* mux1: index 0: AOW0, index 1: AOW1 */
+		hda_nid_t mux1 = 0x35;
+		snd_hda_codec_write(codec, mux1, 0,
+				    AC_VERB_SET_CONNECT_SEL, pinsel);
+	}
 		snd_hda_codec_write(codec, nid, 0,
 				    AC_VERB_SET_CONNECT_SEL, pinsel);
-
 	if (spec->multiout.hp_nid && spec->multiout.hp_nid
 	    != spec->multiout.dac_nids[HDA_FRONT])
 		snd_hda_codec_setup_stream(codec, spec->multiout.hp_nid,
@@ -1021,95 +1301,45 @@
 	{ } /* end */
 };

-/* check AA path's mute statue */
-static int is_aa_path_mute(struct hda_codec *codec)
+/* enter/exit analog low-current mode */
+static void analog_low_current_mode(struct hda_codec *codec, int stream_idle)
 {
-	int mute = 1;
-	hda_nid_t  nid_mixer;
-	int start_idx;
-	int end_idx;
-	int i;
 	struct via_spec *spec = codec->spec;
-	/* get nid of MW0 and start & end index */
+	static int saved_stream_idle = 1; /* saved stream idle status */
+	int enable = is_aa_path_mute(codec);
+	unsigned int verb = 0;
+	unsigned int parm = 0;
+
+	if (stream_idle == -1)	/* stream status did not change */
+		enable = enable && saved_stream_idle;
+	else {
+		enable = enable && stream_idle;
+		saved_stream_idle = stream_idle;
+	}
+
+	/* decide low current mode's verb & parameter */
 	switch (spec->codec_type) {
 	case VT1708B_8CH:
 	case VT1708B_4CH:
+		verb = 0xf70;
+		parm = enable ? 0x02 : 0x00; /* 0x02: 2/3x, 0x00: 1x */
+		break;
 	case VT1708S:
+	case VT1718S:
 	case VT1716S:
-		nid_mixer = 0x16;
-		start_idx = 2;
-		end_idx = 4;
+		verb = 0xf73;
+		parm = enable ? 0x51 : 0xe1; /* 0x51: 4/28x, 0xe1: 1x */
 		break;
 	case VT1702:
-		nid_mixer = 0x1a;
-		start_idx = 1;
-		end_idx = 3;
+		verb = 0xf73;
+		parm = enable ? 0x01 : 0x1d; /* 0x01: 4/40x, 0x1d: 1x */
 		break;
-	case VT1718S:
-		nid_mixer = 0x21;
-		start_idx = 1;
-		end_idx = 3;
+	case VT2002P:
+		verb = 0xf93;
+		parm = enable ? 0x00 : 0xe0; /* 0x00: 4/40x, 0xe0: 1x */
 		break;
 	default:
-		return 0;
-	}
-	/* check AA path's mute status */
-	for (i = start_idx; i <= end_idx; i++) {
-		unsigned int con_list = snd_hda_codec_read(
-			codec, nid_mixer, 0, AC_VERB_GET_CONNECT_LIST, i/4*4);
-		int shift = 8 * (i % 4);
-		hda_nid_t nid_pin = (con_list & (0xff << shift)) >> shift;
-		unsigned int defconf = snd_hda_codec_get_pincfg(codec, nid_pin);
-		if (get_defcfg_connect(defconf) == AC_JACK_PORT_COMPLEX) {
-			/* check mute status while the pin is connected */
-			int mute_l = snd_hda_codec_amp_read(codec, nid_mixer, 0,
-							    HDA_INPUT, i) >> 7;
-			int mute_r = snd_hda_codec_amp_read(codec, nid_mixer, 1,
-							    HDA_INPUT, i) >> 7;
-			if (!mute_l || !mute_r) {
-				mute = 0;
-				break;
-			}
-		}
-	}
-	return mute;
-}
-
-/* enter/exit analog low-current mode */
-static void analog_low_current_mode(struct hda_codec *codec, int stream_idle)
-{
-	struct via_spec *spec = codec->spec;
-	static int saved_stream_idle = 1; /* saved stream idle status */
-	int enable = is_aa_path_mute(codec);
-	unsigned int verb = 0;
-	unsigned int parm = 0;
-
-	if (stream_idle == -1)	/* stream status did not change */
-		enable = enable && saved_stream_idle;
-	else {
-		enable = enable && stream_idle;
-		saved_stream_idle = stream_idle;
-	}
-
-	/* decide low current mode's verb & parameter */
-	switch (spec->codec_type) {
-	case VT1708B_8CH:
-	case VT1708B_4CH:
-		verb = 0xf70;
-		parm = enable ? 0x02 : 0x00; /* 0x02: 2/3x, 0x00: 1x */
-		break;
-	case VT1708S:
-	case VT1718S:
-	case VT1716S:
-		verb = 0xf73;
-		parm = enable ? 0x51 : 0xe1; /* 0x51: 4/28x, 0xe1: 1x */
-		break;
-	case VT1702:
-		verb = 0xf73;
-		parm = enable ? 0x01 : 0x1d; /* 0x01: 4/40x, 0x1d: 1x */
-		break;
-	default:
-		return;		/* other codecs are not supported */
+		return;		/* other codecs are not supported */
 	}
 	/* send verb */
 	snd_hda_codec_write(codec, codec->afg, 0, verb, parm);
@@ -1623,6 +1853,67 @@
 	}
 }

+/* mute Internal-Speaker if HP is plugged */
+static void via_speaker_automute(struct hda_codec *codec)
+{
+	unsigned int hp_present;
+	struct via_spec *spec = codec->spec;
+	char name[32] = "Speaker Playback Switch";
+
+	if (spec->codec_type != VT2002P)
+		return;
+
+	hp_present = snd_hda_codec_read(codec, spec->autocfg.hp_pins[0], 0,
+				     AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
+
+	if (!spec->hp_independent_mode) {
+		struct snd_card *card = codec->bus->card;
+		struct snd_kcontrol *kctl;
+		snd_hda_codec_amp_stereo(
+			codec, spec->autocfg.speaker_pins[0], HDA_OUTPUT, 0,
+			HDA_AMP_MUTE, hp_present ? HDA_AMP_MUTE : 0);
+		/* notify change */
+		list_for_each_entry(kctl, &card->controls, list)
+			if (strcmp(kctl->id.name, name) == 0)
+				snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_VALUE,
+					       &kctl->id);
+	}
+}
+
+/* mute line-out and internal speaker if HP is plugged */
+static void via_hp_bind_automute(struct hda_codec *codec)
+{
+	unsigned int hp_present, present = 0;
+	struct via_spec *spec = codec->spec;
+	int i;
+
+	if (!spec->autocfg.hp_pins[0] || !spec->autocfg.line_out_pins[0])
+		return;
+
+	hp_present = snd_hda_codec_read(codec, spec->autocfg.hp_pins[0], 0,
+					AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
+
+	present = snd_hda_codec_read(codec, spec->autocfg.line_out_pins[0], 0,
+				     AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
+
+	if (!spec->hp_independent_mode) {
+		/* Mute Line-Outs */
+		for (i = 0; i < spec->autocfg.line_outs; i++)
+			snd_hda_codec_amp_stereo(
+				codec, spec->autocfg.line_out_pins[i],
+				HDA_OUTPUT, 0,
+				HDA_AMP_MUTE, hp_present ? HDA_AMP_MUTE : 0);
+		if (hp_present)
+			present = hp_present;
+	}
+	/* Speakers */
+	for (i = 0; i < spec->autocfg.speaker_outs; i++)
+		snd_hda_codec_amp_stereo(
+			codec, spec->autocfg.speaker_pins[i], HDA_OUTPUT, 0,
+			HDA_AMP_MUTE, present ? HDA_AMP_MUTE : 0);
+}
+
+
 /* unsolicited event for jack sensing */
 static void via_unsol_event(struct hda_codec *codec,
 				  unsigned int res)
@@ -1636,6 +1927,10 @@
 		set_jack_power_state(codec);
 	if (res & VIA_MONO_EVENT)
 		via_mono_automute(codec);
+	if (res & VIA_SPEAKER_EVENT)
+		via_speaker_automute(codec);
+	if (res & VIA_BIND_HP_EVENT)
+		via_hp_bind_automute(codec);
 }

 static int via_init(struct hda_codec *codec)
@@ -2034,10 +2329,19 @@
 /* init callback for auto-configuration model -- overriding the default init */
 static int via_auto_init(struct hda_codec *codec)
 {
+	struct via_spec *spec = codec->spec;
+
 	via_init(codec);
 	via_auto_init_multi_out(codec);
 	via_auto_init_hp_out(codec);
 	via_auto_init_analog_input(codec);
+	if (spec->codec_type == VT2002P) {
+		via_hp_bind_automute(codec);
+	} else {
+		via_hp_automute(codec);
+		via_speaker_automute(codec);
+	}
+
 	return 0;
 }

@@ -4978,6 +5282,359 @@

 	return 0;
 }
+
+/* for vt2002P */
+
+/* capture mixer elements */
+static struct snd_kcontrol_new vt2002P_capture_mixer[] = {
+	HDA_CODEC_VOLUME("Capture Volume", 0x10, 0x0, HDA_INPUT),
+	HDA_CODEC_MUTE("Capture Switch", 0x10, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME_IDX("Capture Volume", 1, 0x11, 0x0, HDA_INPUT),
+	HDA_CODEC_MUTE_IDX("Capture Switch", 1, 0x11, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost Capture Volume", 0x2b, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Front Mic Boost Capture Volume", 0x29, 0x0,
+			 HDA_INPUT),
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		/* The multiple "Capture Source" controls confuse alsamixer
+		 * So call somewhat different..
+		 */
+		/* .name = "Capture Source", */
+		.name = "Input Source",
+		.count = 2,
+		.info = via_mux_enum_info,
+		.get = via_mux_enum_get,
+		.put = via_mux_enum_put,
+	},
+	{ } /* end */
+};
+
+static struct hda_verb vt2002P_volume_init_verbs[] = {
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
+	{0x18, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+	{0x19, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+	{0x1c, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+	{0x17, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+	{0x18, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},
+	{0x19, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},
+	{0x1c, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},
+	{0x17, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},
+
+	/* set MUX0/1/4/8 = 0 (AOW0) */
+	{0x34, AC_VERB_SET_CONNECT_SEL, 0},
+	{0x35, AC_VERB_SET_CONNECT_SEL, 0},
+	{0x37, AC_VERB_SET_CONNECT_SEL, 0},
+	{0x3b, AC_VERB_SET_CONNECT_SEL, 0},
+
+	/* set PW0 index=0 (MW0) */
+	{0x24, AC_VERB_SET_CONNECT_SEL, 0},
+
+	/* Enable AOW0 to MW9 */
+	{0x1, 0xfb8, 0x88},
+	{ }
+};
+
+
+static struct hda_verb vt2002P_uniwill_init_verbs[] = {
+	{0x25, AC_VERB_SET_UNSOLICITED_ENABLE,
+	 AC_USRSP_EN | VIA_JACK_EVENT | VIA_BIND_HP_EVENT},
+	{0x26, AC_VERB_SET_UNSOLICITED_ENABLE,
+	 AC_USRSP_EN | VIA_JACK_EVENT | VIA_BIND_HP_EVENT},
+	{0x29, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | VIA_JACK_EVENT},
+	{0x2a, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | VIA_JACK_EVENT},
+	{0x2b, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | VIA_JACK_EVENT},
+	{ }
+};
+
+static struct hda_pcm_stream vt2002P_pcm_analog_playback = {
+	.substreams = 2,
+	.channels_min = 2,
+	.channels_max = 2,
+	.nid = 0x8, /* NID to query formats and rates */
+	.ops = {
+		.open = via_playback_pcm_open,
+		.prepare = via_playback_multi_pcm_prepare,
+		.cleanup = via_playback_multi_pcm_cleanup,
+		.close = via_pcm_open_close,
+	},
+};
+
+static struct hda_pcm_stream vt2002P_pcm_analog_capture = {
+	.substreams = 2,
+	.channels_min = 2,
+	.channels_max = 2,
+	.nid = 0x10, /* NID to query formats and rates */
+	.ops = {
+		.open = via_pcm_open_close,
+		.prepare = via_capture_pcm_prepare,
+		.cleanup = via_capture_pcm_cleanup,
+		.close = via_pcm_open_close,
+	},
+};
+
+static struct hda_pcm_stream vt2002P_pcm_digital_playback = {
+	.substreams = 1,
+	.channels_min = 2,
+	.channels_max = 2,
+	.rates = SNDRV_PCM_RATE_48000,
+	/* NID is set in via_build_pcms */
+	.ops = {
+		.open = via_dig_playback_pcm_open,
+		.close = via_dig_playback_pcm_close,
+		.prepare = via_dig_playback_pcm_prepare,
+		.cleanup = via_dig_playback_pcm_cleanup
+	},
+};
+
+/* fill in the dac_nids table from the parsed pin configuration */
+static int vt2002P_auto_fill_dac_nids(struct via_spec *spec,
+				      const struct auto_pin_cfg *cfg)
+{
+	spec->multiout.num_dacs = 1;
+	spec->multiout.dac_nids = spec->private_dac_nids;
+	if (cfg->line_out_pins[0])
+		spec->multiout.dac_nids[0] = 0x8;
+	return 0;
+}
+
+/* add playback controls from the parsed DAC table */
+static int vt2002P_auto_create_multi_out_ctls(struct via_spec *spec,
+					     const struct auto_pin_cfg *cfg)
+{
+	int err;
+
+	if (!cfg->line_out_pins[0])
+		return -1;
+
+
+	/* Line-Out: PortE */
+	err = via_add_control(spec, VIA_CTL_WIDGET_VOL,
+			      "Master Front Playback Volume",
+			      HDA_COMPOSE_AMP_VAL(0x8, 3, 0, HDA_OUTPUT));
+	if (err < 0)
+		return err;
+	err = via_add_control(spec, VIA_CTL_WIDGET_BIND_PIN_MUTE,
+			      "Master Front Playback Switch",
+			      HDA_COMPOSE_AMP_VAL(0x26, 3, 0, HDA_OUTPUT));
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+static int vt2002P_auto_create_hp_ctls(struct via_spec *spec, hda_nid_t pin)
+{
+	int err;
+
+	if (!pin)
+		return 0;
+
+	spec->multiout.hp_nid = 0x9;
+	spec->hp_independent_mode_index = 1;
+
+	err = via_add_control(spec, VIA_CTL_WIDGET_VOL,
+			      "Headphone Playback Volume",
+			      HDA_COMPOSE_AMP_VAL(
+				      spec->multiout.hp_nid, 3, 0, HDA_OUTPUT));
+	if (err < 0)
+		return err;
+
+	err = via_add_control(spec, VIA_CTL_WIDGET_MUTE,
+			      "Headphone Playback Switch",
+			      HDA_COMPOSE_AMP_VAL(0x25, 3, 0, HDA_OUTPUT));
+	if (err < 0)
+		return err;
+
+	create_hp_imux(spec);
+	return 0;
+}
+
+/* create playback/capture controls for input pins */
+static int vt2002P_auto_create_analog_input_ctls(struct via_spec *spec,
+						const struct auto_pin_cfg *cfg)
+{
+	static char *labels[] = {
+		"Mic", "Front Mic", "Line", "Front Line", "CD", "Aux", NULL
+	};
+	struct hda_input_mux *imux = &spec->private_imux[0];
+	int i, err, idx = 0;
+
+	for (i = 0; i < AUTO_PIN_LAST; i++) {
+		if (!cfg->input_pins[i])
+			continue;
+
+		switch (cfg->input_pins[i]) {
+		case 0x2b: /* Mic */
+			idx = 0;
+			break;
+
+		case 0x2a: /* Line In */
+			idx = 1;
+			break;
+
+		case 0x29: /* Front Mic */
+			idx = 2;
+			break;
+		}
+		err = via_new_analog_input(spec, labels[i], idx, 0x21);
+		if (err < 0)
+			return err;
+		imux->items[imux->num_items].label = labels[i];
+		imux->items[imux->num_items].index = idx;
+		imux->num_items++;
+	}
+
+	/* build volume/mute control of loopback */
+	err = via_new_analog_input(spec, "Stereo Mixer", 3, 0x21);
+	if (err < 0)
+		return err;
+
+	/* for internal loopback recording select */
+	imux->items[imux->num_items].label = "Stereo Mixer";
+	imux->items[imux->num_items].index = 3;
+	imux->num_items++;
+
+	/* for digital mic select */
+	imux->items[imux->num_items].label = "Digital Mic";
+	imux->items[imux->num_items].index = 4;
+	imux->num_items++;
+
+	return 0;
+}
+
+static int vt2002P_parse_auto_config(struct hda_codec *codec)
+{
+	struct via_spec *spec = codec->spec;
+	int err;
+
+
+	err = snd_hda_parse_pin_def_config(codec, &spec->autocfg, NULL);
+	if (err < 0)
+		return err;
+
+	err = vt2002P_auto_fill_dac_nids(spec, &spec->autocfg);
+	if (err < 0)
+		return err;
+
+	if (!spec->autocfg.line_outs && !spec->autocfg.hp_pins[0])
+		return 0; /* can't find valid BIOS pin config */
+
+	err = vt2002P_auto_create_multi_out_ctls(spec, &spec->autocfg);
+	if (err < 0)
+		return err;
+	err = vt2002P_auto_create_hp_ctls(spec, spec->autocfg.hp_pins[0]);
+	if (err < 0)
+		return err;
+	err = vt2002P_auto_create_analog_input_ctls(spec, &spec->autocfg);
+	if (err < 0)
+		return err;
+
+	spec->multiout.max_channels = spec->multiout.num_dacs * 2;
+
+	fill_dig_outs(codec);
+
+	if (spec->kctls.list)
+		spec->mixers[spec->num_mixers++] = spec->kctls.list;
+
+	spec->input_mux = &spec->private_imux[0];
+
+	if (spec->hp_mux)
+		spec->mixers[spec->num_mixers++] = via_hp_mixer;
+
+	return 1;
+}
+
+#ifdef CONFIG_SND_HDA_POWER_SAVE
+static struct hda_amp_list vt2002P_loopbacks[] = {
+	{ 0x21, HDA_INPUT, 0 },
+	{ 0x21, HDA_INPUT, 1 },
+	{ 0x21, HDA_INPUT, 2 },
+	{ } /* end */
+};
+#endif
+
+
+/* patch for vt2002P */
+static int patch_vt2002P(struct hda_codec *codec)
+{
+	struct via_spec *spec;
+	int err;
+
+	/* create a codec specific record */
+	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
+	if (spec == NULL)
+		return -ENOMEM;
+
+	codec->spec = spec;
+
+	/* automatic parse from the BIOS config */
+	err = vt2002P_parse_auto_config(codec);
+	if (err < 0) {
+		via_free(codec);
+		return err;
+	} else if (!err) {
+		printk(KERN_INFO "hda_codec: Cannot set up configuration "
+		       "from BIOS.  Using genenic mode...\n");
+	}
+
+	spec->init_verbs[spec->num_iverbs++]  = vt2002P_volume_init_verbs;
+	spec->init_verbs[spec->num_iverbs++] = vt2002P_uniwill_init_verbs;
+
+	spec->stream_name_analog = "VT2002P Analog";
+	spec->stream_analog_playback = &vt2002P_pcm_analog_playback;
+	spec->stream_analog_capture = &vt2002P_pcm_analog_capture;
+
+	spec->stream_name_digital = "VT2002P Digital";
+	spec->stream_digital_playback = &vt2002P_pcm_digital_playback;
+
+	if (!spec->adc_nids && spec->input_mux) {
+		spec->adc_nids = vt2002P_adc_nids;
+		spec->num_adc_nids = ARRAY_SIZE(vt2002P_adc_nids);
+		get_mux_nids(codec);
+		override_mic_boost(codec, 0x2b, 0, 3, 40);
+		override_mic_boost(codec, 0x29, 0, 3, 40);
+		spec->mixers[spec->num_mixers] = vt2002P_capture_mixer;
+		spec->num_mixers++;
+	}
+
+	codec->patch_ops = via_patch_ops;
+
+	codec->patch_ops.init = via_auto_init;
+	codec->patch_ops.unsol_event = via_unsol_event,
+
+#ifdef CONFIG_SND_HDA_POWER_SAVE
+	spec->loopback.amplist = vt2002P_loopbacks;
+#endif
+
+	return 0;
+}
 /*
  * patch entries
  */
@@ -5062,6 +5719,8 @@
 	  .patch = patch_vt1716S},
 	{ .id = 0x1106a721, .name = "VT1716S",
 	  .patch = patch_vt1716S},
+	{ .id = 0x11060438, .name = "VT2002P", .patch = patch_vt2002P},
+	{ .id = 0x11064438, .name = "VT2002P", .patch = patch_vt2002P},
 	{} /* terminator */
 };
