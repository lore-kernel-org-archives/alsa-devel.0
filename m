From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: multiple SPDIF outputs support
Date: Fri, 05 Sep 2008 17:45:54 -0400
Message-ID: <48C1A892.9030504@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id 6A1EA246F4
	for <alsa-devel@alsa-project.org>;
	Fri,  5 Sep 2008 23:46:04 +0200 (CEST)
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

Added support for outputting a stream to multiple SPDIF outs on supporting codecs.

---
Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>

diff --git a/pci/hda/hda_codec.c b/pci/hda/hda_codec.c
index 4f32911..696d77e 100644
--- a/pci/hda/hda_codec.c
+++ b/pci/hda/hda_codec.c
@@ -1454,12 +1454,22 @@ static int snd_hda_spdif_default_put(struct snd_kcontrol *kcontrol,
 	codec->spdif_ctls = val;

 	if (change) {
+		hda_nid_t *d;
 		snd_hda_codec_write_cache(codec, nid, 0,
 					  AC_VERB_SET_DIGI_CONVERT_1,
 					  val & 0xff);
 		snd_hda_codec_write_cache(codec, nid, 0,
 					  AC_VERB_SET_DIGI_CONVERT_2,
 					  val >> 8);
+
+		for (d = codec->slave_dig_outs; *d; d++) {
+			snd_hda_codec_write_cache(codec, *d, 0,
+					  AC_VERB_SET_DIGI_CONVERT_1,
+					  val & 0xff);
+			snd_hda_codec_write_cache(codec, *d, 0,
+					  AC_VERB_SET_DIGI_CONVERT_2,
+					  val >> 8);
+		}
 	}

 	mutex_unlock(&codec->spdif_mutex);
@@ -1491,10 +1501,16 @@ static int snd_hda_spdif_out_switch_put(struct snd_kcontrol *kcontrol,
 		val |= AC_DIG1_ENABLE;
 	change = codec->spdif_ctls != val;
 	if (change) {
+		hda_nid_t *d;
 		codec->spdif_ctls = val;
 		snd_hda_codec_write_cache(codec, nid, 0,
 					  AC_VERB_SET_DIGI_CONVERT_1,
 					  val & 0xff);
+
+		for (d = codec->slave_dig_outs; *d; d++)
+			snd_hda_codec_write_cache(codec, *d, 0,
+					  AC_VERB_SET_DIGI_CONVERT_1,
+					  val & 0xff);
 		/* unmute amp switch (if any) */
 		if ((get_wcaps(codec, nid) & AC_WCAP_OUT_AMP) &&
 		    (val & AC_DIG1_ENABLE))
@@ -1643,9 +1659,14 @@ static int snd_hda_spdif_in_switch_put(struct snd_kcontrol *kcontrol,
 	mutex_lock(&codec->spdif_mutex);
 	change = codec->spdif_in_enable != val;
 	if (change) {
+		hda_nid_t *d;
 		codec->spdif_in_enable = val;
 		snd_hda_codec_write_cache(codec, nid, 0,
 					  AC_VERB_SET_DIGI_CONVERT_1, val);
+
+		for (d = codec->slave_dig_outs; *d; d++)
+			snd_hda_codec_write_cache(codec, *d, 0,
+					  AC_VERB_SET_DIGI_CONVERT_1, val);
 	}
 	mutex_unlock(&codec->spdif_mutex);
 	return change;
@@ -2589,15 +2610,30 @@ int snd_hda_input_mux_put(struct hda_codec *codec,
 static void setup_dig_out_stream(struct hda_codec *codec, hda_nid_t nid,
 				 unsigned int stream_tag, unsigned int format)
 {
+	hda_nid_t *d;
+
 	/* turn off SPDIF once; otherwise the IEC958 bits won't be updated */
-	if (codec->spdif_status_reset && (codec->spdif_ctls & AC_DIG1_ENABLE))
+	if (codec->spdif_status_reset && (codec->spdif_ctls & AC_DIG1_ENABLE)) {
 		snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_DIGI_CONVERT_1,
+			    codec->spdif_ctls & ~AC_DIG1_ENABLE & 0xff);
+
+		for (d = codec->slave_dig_outs; *d; d++)
+			snd_hda_codec_write(codec, *d, 0,
+					AC_VERB_SET_DIGI_CONVERT_1,
 				    codec->spdif_ctls & ~AC_DIG1_ENABLE & 0xff);
+	}
 	snd_hda_codec_setup_stream(codec, nid, stream_tag, 0, format);
 	/* turn on again (if needed) */
-	if (codec->spdif_status_reset && (codec->spdif_ctls & AC_DIG1_ENABLE))
+	if (codec->spdif_status_reset && (codec->spdif_ctls & AC_DIG1_ENABLE)) {
 		snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_DIGI_CONVERT_1,
 				    codec->spdif_ctls & 0xff);
+
+		for (d = codec->slave_dig_outs; *d; d++)
+			snd_hda_codec_write(codec, *d, 0,
+					AC_VERB_SET_DIGI_CONVERT_1,
+				    codec->spdif_ctls & 0xff);
+	}
+
 }

 /*
@@ -2621,8 +2657,12 @@ int snd_hda_multi_out_dig_prepare(struct hda_codec *codec,
 				  unsigned int format,
 				  struct snd_pcm_substream *substream)
 {
+	hda_nid_t *nid;
 	mutex_lock(&codec->spdif_mutex);
 	setup_dig_out_stream(codec, mout->dig_out_nid, stream_tag, format);
+	if (codec->slave_dig_outs)
+		for (nid = codec->slave_dig_outs; *nid; nid++)
+			setup_dig_out_stream(codec, *nid, stream_tag, format);
 	mutex_unlock(&codec->spdif_mutex);
 	return 0;
 }
@@ -2689,6 +2729,7 @@ int snd_hda_multi_out_analog_prepare(struct hda_codec *codec,
 				     struct snd_pcm_substream *substream)
 {
 	hda_nid_t *nids = mout->dac_nids;
+	hda_nid_t *d;
 	int chs = substream->runtime->channels;
 	int i;

@@ -2702,9 +2743,16 @@ int snd_hda_multi_out_analog_prepare(struct hda_codec *codec,
 			mout->dig_out_used = HDA_DIG_ANALOG_DUP;
 			setup_dig_out_stream(codec, mout->dig_out_nid,
 					     stream_tag, format);
+			if (codec->slave_dig_outs)
+				for (d = codec->slave_dig_outs; *d; d++)
+					setup_dig_out_stream(codec, *d,
+						stream_tag, format);
 		} else {
 			mout->dig_out_used = 0;
 			snd_hda_codec_cleanup_stream(codec, mout->dig_out_nid);
+			if (codec->slave_dig_outs)
+				for (d = codec->slave_dig_outs; *d; d++)
+					snd_hda_codec_cleanup_stream(codec, *d);
 		}
 	}
 	mutex_unlock(&codec->spdif_mutex);
diff --git a/pci/hda/hda_codec.h b/pci/hda/hda_codec.h
index 780e2ff..60468f5 100644
--- a/pci/hda/hda_codec.h
+++ b/pci/hda/hda_codec.h
@@ -725,6 +725,7 @@ struct hda_codec {
 	unsigned int spdif_status;	/* IEC958 status bits */
 	unsigned short spdif_ctls;	/* SPDIF control bits */
 	unsigned int spdif_in_enable;	/* SPDIF input enable? */
+	hda_nid_t *slave_dig_outs; /* optional digital out slave widgets */

 	struct snd_hwdep *hwdep;	/* assigned hwdep device */

diff --git a/pci/hda/patch_sigmatel.c b/pci/hda/patch_sigmatel.c
index 9968ee4..52b3579 100644
--- a/pci/hda/patch_sigmatel.c
+++ b/pci/hda/patch_sigmatel.c
@@ -229,6 +229,10 @@ static hda_nid_t stac92hd73xx_pwr_nids[8] = {
 	0x0f, 0x10, 0x11
 };

+static hda_nid_t stac92hd73xx_slave_dig_outs[2] = {
+	0x26, 0,
+};
+
 static hda_nid_t stac92hd73xx_adc_nids[2] = {
 	0x1a, 0x1b
 };
@@ -274,6 +278,10 @@ static hda_nid_t stac92hd83xxx_pwr_nids[4] = {
 	0xa, 0xb, 0xd, 0xe,
 };

+static hda_nid_t stac92hd83xxx_slave_dig_outs[2] = {
+	0x1e, 0,
+};
+
 static unsigned int stac92hd83xxx_pwr_mapping[4] = {
 	0x03, 0x0c, 0x10, 0x40,
 };
@@ -303,6 +311,10 @@ static hda_nid_t stac92hd71bxx_dmic_nids[STAC92HD71BXX_NUM_DMICS + 1] = {
 	0x18, 0x19, 0
 };

+static hda_nid_t stac92hd71bxx_slave_dig_outs[2] = {
+	0x22, 0
+};
+
 static hda_nid_t stac925x_adc_nids[1] = {
         0x03,
 };
@@ -396,9 +408,10 @@ static hda_nid_t stac92hd83xxx_pin_nids[14] = {
 	0x0f, 0x10, 0x11, 0x12, 0x13,
 	0x1d, 0x1e, 0x1f, 0x20
 };
-static hda_nid_t stac92hd71bxx_pin_nids[10] = {
+static hda_nid_t stac92hd71bxx_pin_nids[11] = {
 	0x0a, 0x0b, 0x0c, 0x0d, 0x0e,
 	0x0f, 0x14, 0x18, 0x19, 0x1e,
+	0x1f,
 };

 static hda_nid_t stac927x_pin_nids[14] = {
@@ -1424,22 +1437,22 @@ static struct snd_pci_quirk stac92hd83xxx_cfg_tbl[] = {
 		      "DFI LanParty", STAC_92HD71BXX_REF),
 };

-static unsigned int ref92hd71bxx_pin_configs[10] = {
+static unsigned int ref92hd71bxx_pin_configs[11] = {
 	0x02214030, 0x02a19040, 0x01a19020, 0x01014010,
 	0x0181302e, 0x01114010, 0x01019020, 0x90a000f0,
-	0x90a000f0, 0x01452050,
+	0x90a000f0, 0x01452050, 0x01452050,
 };

-static unsigned int dell_m4_1_pin_configs[10] = {
+static unsigned int dell_m4_1_pin_configs[11] = {
 	0x0421101f, 0x04a11221, 0x40f000f0, 0x90170110,
 	0x23a1902e, 0x23014250, 0x40f000f0, 0x90a000f0,
-	0x40f000f0, 0x4f0000f0,
+	0x40f000f0, 0x4f0000f0, 0x4f0000f0,
 };

-static unsigned int dell_m4_2_pin_configs[10] = {
+static unsigned int dell_m4_2_pin_configs[11] = {
 	0x0421101f, 0x04a11221, 0x90a70330, 0x90170110,
 	0x23a1902e, 0x23014250, 0x40f000f0, 0x40f000f0,
-	0x40f000f0, 0x044413b0,
+	0x40f000f0, 0x044413b0, 0x044413b0,
 };

 static unsigned int *stac92hd71bxx_brd_tbl[STAC_92HD71BXX_MODELS] = {
@@ -3841,8 +3854,9 @@ again:

 	spec->num_pwrs = ARRAY_SIZE(stac92hd73xx_pwr_nids);
 	spec->pwr_nids = stac92hd73xx_pwr_nids;
+	codec->slave_dig_outs = stac92hd73xx_slave_dig_outs;

-	err = stac92xx_parse_auto_config(codec, 0x22, 0x24);
+	err = stac92xx_parse_auto_config(codec, 0x22, 0x25);

 	if (!err) {
 		if (spec->board_config < 0) {
@@ -3883,6 +3897,7 @@ static int patch_stac92hd83xxx(struct hda_codec *codec)
 		return -ENOMEM;

 	codec->spec = spec;
+	codec->slave_dig_outs = stac92hd83xxx_slave_dig_outs;
 	spec->mono_nid = 0x19;
 	spec->digbeep_nid = 0x21;
 	spec->dmic_nids = stac92hd83xxx_dmic_nids;
@@ -4033,6 +4048,7 @@ again:
 	case 0x111d76b5:
 		spec->mixer = stac92hd71bxx_mixer;
 		spec->init = stac92hd71bxx_core_init;
+		codec->slave_dig_outs = stac92hd71bxx_slave_dig_outs;
 		break;
 	case 0x111d7608: /* 5 Port with Analog Mixer */
 		if ((codec->revision_id & 0xf) == 0 ||
@@ -4065,6 +4081,7 @@ again:
 	default:
 		spec->mixer = stac92hd71bxx_analog_mixer;
 		spec->init = stac92hd71bxx_analog_core_init;
+		codec->slave_dig_outs = stac92hd71bxx_slave_dig_outs;
 	}

 	spec->aloopback_mask = 0x20;
