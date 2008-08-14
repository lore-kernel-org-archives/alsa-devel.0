From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: 92HD75xx fixes
Date: Thu, 14 Aug 2008 14:58:16 -0400
Message-ID: <48A48048.70708@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id A5D0C24781
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Aug 2008 20:58:26 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>, "Wong, Henry" <Henry.Wong@idt.com>, "Tellman,
	Steven" <Steven.Tellman@idt.com>
List-Id: alsa-devel@alsa-project.org

Fixed several noise issues with DACs and ADCs on some 92HD75xxx based codecs
with certain revision id's.

---
Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>


diff --git a/pci/hda/patch_sigmatel.c b/pci/hda/patch_sigmatel.c
index ff56432..9ec0610 100644
--- a/pci/hda/patch_sigmatel.c
+++ b/pci/hda/patch_sigmatel.c
@@ -145,6 +145,9 @@ struct sigmatel_spec {
 	unsigned int gpio_data;
 	unsigned int gpio_mute;

+	/* stream */
+	unsigned int stream_delay;
+
 	/* analog loopback */
 	unsigned char aloopback_mask;
 	unsigned char aloopback_shift;
@@ -190,6 +193,7 @@ struct sigmatel_spec {
 	unsigned int cur_dmux[2];
 	struct hda_input_mux *input_mux;
 	unsigned int cur_mux[3];
+	unsigned int powerdown_adcs;

 	/* i/o switches */
 	unsigned int io_switch[2];
@@ -2010,6 +2014,8 @@ static int stac92xx_playback_pcm_open(struct hda_pcm_stream *hinfo,
 				      struct snd_pcm_substream *substream)
 {
 	struct sigmatel_spec *spec = codec->spec;
+	if (spec->stream_delay)
+		msleep(spec->stream_delay);
 	return snd_hda_multi_out_analog_open(codec, &spec->multiout, substream,
 					     hinfo);
 }
@@ -2073,9 +2079,14 @@ static int stac92xx_capture_pcm_prepare(struct hda_pcm_stream *hinfo,
 					struct snd_pcm_substream *substream)
 {
 	struct sigmatel_spec *spec = codec->spec;
+	hda_nid_t nid = spec->adc_nids[substream->number];

-	snd_hda_codec_setup_stream(codec, spec->adc_nids[substream->number],
-                                   stream_tag, 0, format);
+	if (spec->powerdown_adcs) {
+		msleep(40);
+		snd_hda_codec_write_cache(codec, nid, 0,
+			AC_VERB_SET_POWER_STATE, AC_PWRST_D0);
+	}
+	snd_hda_codec_setup_stream(codec, nid, stream_tag, 0, format);
 	return 0;
 }

@@ -2084,8 +2095,12 @@ static int stac92xx_capture_pcm_cleanup(struct hda_pcm_stream *hinfo,
 					struct snd_pcm_substream *substream)
 {
 	struct sigmatel_spec *spec = codec->spec;
+	hda_nid_t nid = spec->adc_nids[substream->number];

-	snd_hda_codec_cleanup_stream(codec, spec->adc_nids[substream->number]);
+	snd_hda_codec_cleanup_stream(codec, nid);
+	if (spec->powerdown_adcs)
+		snd_hda_codec_write_cache(codec, nid, 0,
+			AC_VERB_SET_POWER_STATE, AC_PWRST_D3);
 	return 0;
 }

@@ -3275,6 +3290,12 @@ static int stac92xx_init(struct hda_codec *codec)

 	snd_hda_sequence_write(codec, spec->init);

+	/* power down adcs initially */
+	if (spec->powerdown_adcs)
+		for (i = 0; i < spec->num_adcs; i++)
+			snd_hda_codec_write_cache(codec,
+				spec->adc_nids[i], 0,
+				AC_VERB_SET_POWER_STATE, AC_PWRST_D3);
 	/* set up pins */
 	if (spec->hp_detect) {
 		/* Enable unsolicited responses on the HP widget */
@@ -3909,6 +3930,47 @@ again:
 	return 0;
 }

+#ifdef SND_HDA_NEEDS_RESUME
+static void stac92hd71xx_set_power_state(struct hda_codec *codec, int pwr)
+{
+	struct sigmatel_spec *spec = codec->spec;
+	int i;
+	snd_hda_codec_write_cache(codec, codec->afg, 0,
+		AC_VERB_SET_POWER_STATE, pwr);
+
+	msleep(1);
+	for (i = 0; i < spec->num_adcs; i++) {
+		snd_hda_codec_write_cache(codec,
+			spec->adc_nids[i], 0,
+			AC_VERB_SET_POWER_STATE, pwr);
+	}
+};
+
+static int stac92hd71xx_resume(struct hda_codec *codec)
+{
+	stac92hd71xx_set_power_state(codec, AC_PWRST_D0);
+	return stac92xx_resume(codec);
+}
+
+static int stac92hd71xx_suspend(struct hda_codec *codec, pm_message_t state)
+{
+	stac92hd71xx_set_power_state(codec, AC_PWRST_D3);
+	return 0;
+};
+
+#endif
+
+static struct hda_codec_ops stac92hd71bxx_patch_ops = {
+	.build_controls = stac92xx_build_controls,
+	.build_pcms = stac92xx_build_pcms,
+	.init = stac92xx_init,
+	.free = stac92xx_free,
+	.unsol_event = stac92xx_unsol_event,
+#ifdef SND_HDA_NEEDS_RESUME
+	.resume = stac92hd71xx_resume,
+	.suspend = stac92hd71xx_suspend,
+#endif
+};

 static int patch_stac92hd71bxx(struct hda_codec *codec)
 {
@@ -3920,6 +3982,7 @@ static int patch_stac92hd71bxx(struct hda_codec *codec)
 		return -ENOMEM;

 	codec->spec = spec;
+	codec->patch_ops = stac92xx_patch_ops;
 	spec->num_pins = ARRAY_SIZE(stac92hd71bxx_pin_nids);
 	spec->num_pwrs = ARRAY_SIZE(stac92hd71bxx_pwr_nids);
 	spec->pin_nids = stac92hd71bxx_pin_nids;
@@ -3951,6 +4014,14 @@ again:
 		spec->init = stac92hd71bxx_core_init;
 		break;
 	case 0x111d7608: /* 5 Port with Analog Mixer */
+		if ((codec->revision_id & 0xf) == 0 ||
+				(codec->revision_id & 0xf) == 1) {
+#ifdef SND_HDA_NEEDS_RESUME
+			codec->patch_ops = stac92hd71bxx_patch_ops;
+#endif
+			spec->stream_delay = 40; /* 40 milliseconds */
+		}
+
 		/* no output amps */
 		spec->num_pwrs = 0;
 		spec->mixer = stac92hd71bxx_analog_mixer;
@@ -3960,6 +4031,13 @@ again:
 		stac92xx_set_config_reg(codec, 0xf, 0x40f000f0);
 		break;
 	case 0x111d7603: /* 6 Port with Analog Mixer */
+		if ((codec->revision_id & 0xf) == 1) {
+#ifdef SND_HDA_NEEDS_RESUME
+			codec->patch_ops = stac92hd71bxx_patch_ops;
+#endif
+			spec->stream_delay = 40; /* 40 milliseconds */
+		}
+
 		/* no output amps */
 		spec->num_pwrs = 0;
 		/* fallthru */
@@ -3976,6 +4054,7 @@ again:
 	spec->gpio_dir = 0x01;
 	spec->gpio_data = 0x01;

+	spec->powerdown_adcs = 1;
 	spec->digbeep_nid = 0x26;
 	spec->mux_nids = stac92hd71bxx_mux_nids;
 	spec->adc_nids = stac92hd71bxx_adc_nids;
@@ -4008,8 +4087,6 @@ again:
 		return err;
 	}

-	codec->patch_ops = stac92xx_patch_ops;
-
 	return 0;
 };
