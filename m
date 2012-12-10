From: lydiawang <lydiawang@viatech.com.cn>
Subject: [PATCH 1/2]: ALSA: VIA HDA: Add support for codec
	VT1705CF
Date: Mon, 10 Dec 2012 16:22:32 +0800
Message-ID: <50C59BC8.5000103@viatech.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from exchtp08.via.com.tw (exchtp08.via.com.tw [61.66.243.7])
 by alsa0.perex.cz (Postfix) with ESMTP id BC74B2615D7
 for <alsa-devel@alsa-project.org>; Mon, 10 Dec 2012 09:22:35 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, lydiawang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

From: Lydia Wang <lydiawang@viatech.com.cn>
Subject: ALSA: VIA HDA: Add support for codec VT1705CF.

Add support for new codec VT1705CF.

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>
Index: sound/sound/pci/hda/patch_via.c
===================================================================
--- sound.orig/sound/pci/hda/patch_via.c	2012-12-10 14:22:56.000000000 +0800
+++ sound/sound/pci/hda/patch_via.c	2012-12-10 15:02:02.000000000 +0800
@@ -76,6 +76,7 @@
  	VT2002P,
  	VT1812,
  	VT1802,
+	VT1705CF,
  	CODEC_TYPES,
  };
  
@@ -220,6 +221,7 @@
  	int vt1708_hp_present;
  
  	void (*set_widgets_power_state)(struct hda_codec *codec);
+	unsigned int dac_stream_tag[4];
  
  	struct hda_loopback_check loopback;
  	int num_loopbacks;
@@ -296,6 +298,8 @@
  		codec_type = VT1708S;
  	else if ((dev_id & 0xfff) == 0x446)
  		codec_type = VT1802;
+	else if (dev_id == 0x4760)
+		codec_type = VT1705CF;
  	else
  		codec_type = UNKNOWN;
  	return codec_type;
@@ -711,6 +715,28 @@
  	snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_POWER_STATE, parm);
  }
  
+static void update_conv_power_state(struct hda_codec *codec, hda_nid_t nid,
+			       unsigned int parm, unsigned int index)
+{
+	struct via_spec *spec = codec->spec;
+	unsigned int format;
+	if (snd_hda_codec_read(codec, nid, 0,
+			       AC_VERB_GET_POWER_STATE, 0) == parm)
+		return;
+	format = snd_hda_codec_read(codec, nid, 0, AC_VERB_GET_CONV, 0);
+	if (format && (spec->dac_stream_tag[index] != format))
+		spec->dac_stream_tag[index] = format;
+
+	snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_POWER_STATE, parm);
+	if (parm == AC_PWRST_D0) {
+		format = snd_hda_codec_read(codec, nid, 0, AC_VERB_GET_CONV, 0);
+		if (!format && (spec->dac_stream_tag[index] != format))
+			snd_hda_codec_write(codec, nid, 0,
+						  AC_VERB_SET_CHANNEL_STREAMID,
+						  spec->dac_stream_tag[index]);
+	}
+}
+
  static void set_pin_power_state(struct hda_codec *codec, hda_nid_t nid,
  				unsigned int *affected_parm)
  {
@@ -1085,6 +1111,10 @@
  		verb = 0xf93;
  		parm = enable ? 0x00 : 0xe0; /* 0x00: 4/40x, 0xe0: 1x */
  		break;
+	case VT1705CF:
+		verb = 0xf82;
+		parm = enable ? 0x00 : 0xe0;  /* 0x00: 4/40x, 0xe0: 1x */
+		break;
  	default:
  		return;		/* other codecs are not supported */
  	}
@@ -3817,6 +3847,125 @@
  	return 0;
  }
  
+/* patch for vt3476 */
+
+static const struct hda_verb vt3476_init_verbs[] = {
+	/* Enable DMic 8/16/32K */
+	{0x1, 0xF7B, 0x30},
+	/* Enable Boost Volume backdoor */
+	{0x1, 0xFB9, 0x20},
+	/* Enable AOW-MW9 path */
+	{0x1, 0xFB8, 0x10},
+	{ }
+};
+
+static void set_widgets_power_state_vt3476(struct hda_codec *codec)
+{
+	struct via_spec *spec = codec->spec;
+	int imux_is_smixer;
+	unsigned int parm, parm2;
+	/* MUX10 (1eh) = stereo mixer */
+	imux_is_smixer =
+	snd_hda_codec_read(codec, 0x1e, 0, AC_VERB_GET_CONNECT_SEL, 0x00) == 4;
+	/* inputs */
+	/* PW 5/6/7 (29h/2ah/2bh) */
+	parm = AC_PWRST_D3;
+	set_pin_power_state(codec, 0x29, &parm);
+	set_pin_power_state(codec, 0x2a, &parm);
+	set_pin_power_state(codec, 0x2b, &parm);
+	if (imux_is_smixer)
+		parm = AC_PWRST_D0;
+	/* MUX10/11 (1eh/1fh), AIW 0/1 (10h/11h) */
+	update_power_state(codec, 0x1e, parm);
+	update_power_state(codec, 0x1f, parm);
+	update_power_state(codec, 0x10, parm);
+	update_power_state(codec, 0x11, parm);
+
+	/* outputs */
+	/* PW3 (27h), MW3(37h), AOW3 (bh) */
+	if (spec->codec_type == VT1705CF) {
+		parm = AC_PWRST_D3;
+		update_power_state(codec, 0x27, parm);
+		update_power_state(codec, 0x37, parm);
+	}	else {
+		parm = AC_PWRST_D3;
+		set_pin_power_state(codec, 0x27, &parm);
+		update_power_state(codec, 0x37, parm);
+	}
+
+	/* PW2 (26h), MW2(36h), AOW2 (ah) */
+	parm = AC_PWRST_D3;
+	set_pin_power_state(codec, 0x26, &parm);
+	update_power_state(codec, 0x36, parm);
+	if (spec->smart51_enabled) {
+		/* PW7(2bh), MW7(3bh), MUX7(1Bh) */
+		set_pin_power_state(codec, 0x2b, &parm);
+		update_power_state(codec, 0x3b, parm);
+		update_power_state(codec, 0x1b, parm);
+	}
+	update_conv_power_state(codec, 0xa, parm, 2);
+
+	/* PW1 (25h), MW1(35h), AOW1 (9h) */
+	parm = AC_PWRST_D3;
+	set_pin_power_state(codec, 0x25, &parm);
+	update_power_state(codec, 0x35, parm);
+	if (spec->smart51_enabled) {
+		/* PW6(2ah), MW6(3ah), MUX6(1ah) */
+		set_pin_power_state(codec, 0x2a, &parm);
+		update_power_state(codec, 0x3a, parm);
+		update_power_state(codec, 0x1a, parm);
+	}
+	update_conv_power_state(codec, 0x9, parm, 1);
+
+	/* PW4 (28h), MW4 (38h), MUX4(18h), AOW3(bh)/AOW0(8h) */
+	parm = AC_PWRST_D3;
+	set_pin_power_state(codec, 0x28, &parm);
+	update_power_state(codec, 0x38, parm);
+	update_power_state(codec, 0x18, parm);
+	if (spec->hp_independent_mode)
+		update_conv_power_state(codec, 0xb, parm, 3);
+	parm2 = parm; /* for pin 0x0b */
+
+	/* PW0 (24h), MW0(34h), MW9(3fh), AOW0 (8h) */
+	parm = AC_PWRST_D3;
+	set_pin_power_state(codec, 0x24, &parm);
+	update_power_state(codec, 0x34, parm);
+	if (!spec->hp_independent_mode && parm2 != AC_PWRST_D3)
+		parm = parm2;
+	update_conv_power_state(codec, 0x8, parm, 0);
+	/* MW9 (21h), Mw2 (1ah), AOW0 (8h) */
+	update_power_state(codec, 0x3f, imux_is_smixer ? AC_PWRST_D0 : parm);
+}
+
+static int patch_vt3476(struct hda_codec *codec)
+{
+	struct via_spec *spec;
+	int err;
+
+	/* create a codec specific record */
+	spec = via_new_spec(codec);
+	if (spec == NULL)
+		return -ENOMEM;
+
+	spec->aa_mix_nid = 0x3f;
+	add_secret_dac_path(codec);
+
+	/* automatic parse from the BIOS config */
+	err = via_parse_auto_config(codec);
+	if (err < 0) {
+		via_free(codec);
+		return err;
+	}
+
+	spec->init_verbs[spec->num_iverbs++] = vt3476_init_verbs;
+
+	codec->patch_ops = via_patch_ops;
+
+	spec->set_widgets_power_state = set_widgets_power_state_vt3476;
+
+	return 0;
+}
+
  /*
   * patch entries
   */
@@ -3910,6 +4059,8 @@
  		.patch = patch_vt2002P},
  	{ .id = 0x11068446, .name = "VT1802",
  		.patch = patch_vt2002P},
+	{ .id = 0x11064760, .name = "VT1705CF",
+		.patch = patch_vt3476},
  	{} /* terminator */
  };
  
