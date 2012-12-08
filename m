From: Ian Minett <ian_minett@creativelabs.com>
Subject: [PATCH 6/7] ALSA: CA0132: Code shuffle and tidy
Date: Fri, 7 Dec 2012 21:36:02 -0800
Message-ID: <1354944963-4654-7-git-send-email-ian_minett@creativelabs.com>
References: <1354944963-4654-1-git-send-email-ian_minett@creativelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1354944963-4654-1-git-send-email-ian_minett@creativelabs.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Ian Minett <ian_minett@creativelabs.com>
List-Id: alsa-devel@alsa-project.org

From: Ian Minett <ian_minett@creativelabs.com>


Signed-off-by: Ian Minett <ian_minett@creativelabs.com>

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 983142a..21380f1 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -669,42 +669,6 @@ enum ca0132_sample_rate {
 	SR_RATE_UNKNOWN = 0x1F
 };
 
-static void init_output(struct hda_codec *codec, hda_nid_t pin, hda_nid_t dac)
-{
-	if (pin) {
-		snd_hda_set_pin_ctl(codec, pin, PIN_HP);
-		if (get_wcaps(codec, pin) & AC_WCAP_OUT_AMP)
-			snd_hda_codec_write(codec, pin, 0,
-					    AC_VERB_SET_AMP_GAIN_MUTE,
-					    AMP_OUT_UNMUTE);
-	}
-	if (dac && (get_wcaps(codec, dac) & AC_WCAP_OUT_AMP))
-		snd_hda_codec_write(codec, dac, 0,
-				    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO);
-}
-
-static void init_input(struct hda_codec *codec, hda_nid_t pin, hda_nid_t adc)
-{
-	if (pin) {
-		snd_hda_set_pin_ctl(codec, pin, PIN_IN |
-				    snd_hda_get_default_vref(codec, pin));
-		if (get_wcaps(codec, pin) & AC_WCAP_IN_AMP)
-			snd_hda_codec_write(codec, pin, 0,
-					    AC_VERB_SET_AMP_GAIN_MUTE,
-					    AMP_IN_UNMUTE(0));
-	}
-	if (adc && (get_wcaps(codec, adc) & AC_WCAP_IN_AMP)) {
-		snd_hda_codec_write(codec, adc, 0, AC_VERB_SET_AMP_GAIN_MUTE,
-				    AMP_IN_UNMUTE(0));
-
-		/* init to 0 dB and unmute. */
-		snd_hda_codec_amp_stereo(codec, adc, HDA_INPUT, 0,
-					 HDA_AMP_VOLMASK, 0x5a);
-		snd_hda_codec_amp_stereo(codec, adc, HDA_INPUT, 0,
-					 HDA_AMP_MUTE, 0);
-	}
-}
-
 enum dsp_download_state {
 	DSP_DOWNLOAD_FAILED = -1,
 	DSP_DOWNLOAD_INIT   = 0,
@@ -919,7 +883,7 @@ static int chipio_read_data(struct hda_codec *codec, unsigned int *data)
 	}
 
 	spec->curr_chip_addx = (res != -EIO) ?
-					(spec->curr_chip_addx + 4) : ~0UL;\
+					(spec->curr_chip_addx + 4) : ~0UL;
 	return res;
 }
 
@@ -2719,7 +2683,6 @@ static void ca0132_cleanup_stream(struct hda_codec *codec, hda_nid_t nid)
 	snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_CHANNEL_STREAMID, 0);
 }
 
-
 /*
  * PCM callbacks
  */
@@ -4080,6 +4043,44 @@ static int ca0132_build_pcms(struct hda_codec *codec)
 	return 0;
 }
 
+static void init_output(struct hda_codec *codec, hda_nid_t pin, hda_nid_t dac)
+{
+	if (pin) {
+		snd_hda_codec_write(codec, pin, 0,
+				    AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_HP);
+		if (get_wcaps(codec, pin) & AC_WCAP_OUT_AMP)
+			snd_hda_codec_write(codec, pin, 0,
+					    AC_VERB_SET_AMP_GAIN_MUTE,
+					    AMP_OUT_UNMUTE);
+	}
+	if (dac && (get_wcaps(codec, dac) & AC_WCAP_OUT_AMP))
+		snd_hda_codec_write(codec, dac, 0,
+				    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO);
+}
+
+static void init_input(struct hda_codec *codec, hda_nid_t pin, hda_nid_t adc)
+{
+	if (pin) {
+		snd_hda_codec_write(codec, pin, 0,
+				    AC_VERB_SET_PIN_WIDGET_CONTROL,
+				    PIN_VREF80);
+		if (get_wcaps(codec, pin) & AC_WCAP_IN_AMP)
+			snd_hda_codec_write(codec, pin, 0,
+					    AC_VERB_SET_AMP_GAIN_MUTE,
+					    AMP_IN_UNMUTE(0));
+	}
+	if (adc && (get_wcaps(codec, adc) & AC_WCAP_IN_AMP)) {
+		snd_hda_codec_write(codec, adc, 0, AC_VERB_SET_AMP_GAIN_MUTE,
+				    AMP_IN_UNMUTE(0));
+
+		/* init to 0 dB and unmute. */
+		snd_hda_codec_amp_stereo(codec, adc, HDA_INPUT, 0,
+					 HDA_AMP_VOLMASK, 0x5a);
+		snd_hda_codec_amp_stereo(codec, adc, HDA_INPUT, 0,
+					 HDA_AMP_MUTE, 0);
+	}
+}
+
 static void ca0132_init_unsol(struct hda_codec *codec)
 {
 	snd_hda_jack_detect_enable(codec, UNSOL_TAG_HP, UNSOL_TAG_HP);
@@ -4328,45 +4329,6 @@ static void ca0132_download_dsp(struct hda_codec *codec)
 		ca0132_set_dsp_msr(codec, true);
 }
 
-static void ca0132_config(struct hda_codec *codec)
-{
-	struct ca0132_spec *spec = codec->spec;
-	struct auto_pin_cfg *cfg = &spec->autocfg;
-
-	spec->dacs[0] = 0x2;
-	spec->dacs[1] = 0x3;
-	spec->dacs[2] = 0x4;
-
-	spec->multiout.dac_nids = spec->dacs;
-	spec->multiout.num_dacs = 3;
-	spec->multiout.max_channels = 2;
-
-	spec->num_outputs = 2;
-	spec->out_pins[0] = 0x0b; /* speaker out */
-	spec->out_pins[1] = 0x10; /* headphone out */
-	spec->shared_out_nid = 0x2;
-
-	spec->num_inputs = 3;
-	spec->adcs[0] = 0x7; /* digital mic / analog mic1 */
-	spec->adcs[1] = 0x8; /* analog mic2 */
-	spec->adcs[2] = 0xa; /* what u hear */
-	spec->shared_mic_nid = 0x7;
-
-	spec->input_pins[0] = 0x12;
-	spec->input_pins[1] = 0x11;
-	spec->input_pins[2] = 0x13;
-
-	/* SPDIF I/O */
-	spec->dig_out = 0x05;
-	spec->multiout.dig_out_nid = spec->dig_out;
-	cfg->dig_out_pins[0] = 0x0c;
-	cfg->dig_outs = 1;
-	cfg->dig_out_type[0] = HDA_PCM_TYPE_SPDIF;
-	spec->dig_in = 0x09;
-	cfg->dig_in_pin = 0x0e;
-	cfg->dig_in_type = HDA_PCM_TYPE_SPDIF;
-}
-
 static void ca0132_process_dsp_response(struct hda_codec *codec)
 {
 	struct ca0132_spec *spec = codec->spec;
@@ -4589,6 +4551,45 @@ static struct hda_codec_ops ca0132_patch_ops = {
 	.unsol_event = ca0132_unsol_event,
 };
 
+static void ca0132_config(struct hda_codec *codec)
+{
+	struct ca0132_spec *spec = codec->spec;
+	struct auto_pin_cfg *cfg = &spec->autocfg;
+
+	spec->dacs[0] = 0x2;
+	spec->dacs[1] = 0x3;
+	spec->dacs[2] = 0x4;
+
+	spec->multiout.dac_nids = spec->dacs;
+	spec->multiout.num_dacs = 3;
+	spec->multiout.max_channels = 2;
+
+	spec->num_outputs = 2;
+	spec->out_pins[0] = 0x0b; /* speaker out */
+	spec->out_pins[1] = 0x10; /* headphone out */
+	spec->shared_out_nid = 0x2;
+
+	spec->num_inputs = 3;
+	spec->adcs[0] = 0x7; /* digital mic / analog mic1 */
+	spec->adcs[1] = 0x8; /* analog mic2 */
+	spec->adcs[2] = 0xa; /* what u hear */
+	spec->shared_mic_nid = 0x7;
+
+	spec->input_pins[0] = 0x12;
+	spec->input_pins[1] = 0x11;
+	spec->input_pins[2] = 0x13;
+
+	/* SPDIF I/O */
+	spec->dig_out = 0x05;
+	spec->multiout.dig_out_nid = spec->dig_out;
+	cfg->dig_out_pins[0] = 0x0c;
+	cfg->dig_outs = 1;
+	cfg->dig_out_type[0] = HDA_PCM_TYPE_SPDIF;
+	spec->dig_in = 0x09;
+	cfg->dig_in_pin = 0x0e;
+	cfg->dig_in_type = HDA_PCM_TYPE_SPDIF;
+}
+
 static int patch_ca0132(struct hda_codec *codec)
 {
 	struct ca0132_spec *spec;
-- 
1.7.4.1
