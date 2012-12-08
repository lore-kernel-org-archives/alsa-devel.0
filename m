From: Ian Minett <ian_minett@creativelabs.com>
Subject: [PATCH 5/7] ALSA: CA0132: Some code shuffling to group
	functions together.
Date: Fri, 7 Dec 2012 21:36:01 -0800
Message-ID: <1354944963-4654-6-git-send-email-ian_minett@creativelabs.com>
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
index b62d407..983142a 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -2665,42 +2665,6 @@ static bool dspload_wait_loaded(struct hda_codec *codec)
 	return false;
 }
 
-
-/*
- * Controls stuffs.
- */
-
-/*
- * Mixer controls helpers.
- */
-#define CA0132_CODEC_VOL_MONO(xname, nid, channel, dir) \
-	{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
-	  .name = xname, \
-	  .subdevice = HDA_SUBDEV_AMP_FLAG, \
-	  .access = SNDRV_CTL_ELEM_ACCESS_READWRITE | \
-			SNDRV_CTL_ELEM_ACCESS_TLV_READ | \
-			SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK, \
-	  .info = ca0132_volume_info, \
-	  .get = ca0132_volume_get, \
-	  .put = ca0132_volume_put, \
-	  .tlv = { .c = ca0132_volume_tlv }, \
-	  .private_value = HDA_COMPOSE_AMP_VAL(nid, channel, 0, dir) }
-
-#define CA0132_CODEC_MUTE_MONO(xname, nid, channel, dir) \
-	{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
-	  .name = xname, \
-	  .subdevice = HDA_SUBDEV_AMP_FLAG, \
-	  .info = snd_hda_mixer_amp_switch_info, \
-	  .get = ca0132_switch_get, \
-	  .put = ca0132_switch_put, \
-	  .private_value = HDA_COMPOSE_AMP_VAL(nid, channel, 0, dir) }
-
-/* stereo */
-#define CA0132_CODEC_VOL(xname, nid, dir) \
-	CA0132_CODEC_VOL_MONO(xname, nid, 3, dir)
-#define CA0132_CODEC_MUTE(xname, nid, dir) \
-	CA0132_CODEC_MUTE_MONO(xname, nid, 3, dir)
-
 /*
  * PCM stuffs
  */
@@ -2857,6 +2821,43 @@ static int ca0132_capture_pcm_cleanup(struct hda_pcm_stream *hinfo,
 	return 0;
 }
 
+
+/*
+ * Controls stuffs.
+ */
+
+/*
+ * Mixer controls helpers.
+ */
+#define CA0132_CODEC_VOL_MONO(xname, nid, channel, dir) \
+	{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+	  .name = xname, \
+	  .subdevice = HDA_SUBDEV_AMP_FLAG, \
+	  .access = SNDRV_CTL_ELEM_ACCESS_READWRITE | \
+			SNDRV_CTL_ELEM_ACCESS_TLV_READ | \
+			SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK, \
+	  .info = ca0132_volume_info, \
+	  .get = ca0132_volume_get, \
+	  .put = ca0132_volume_put, \
+	  .tlv = { .c = ca0132_volume_tlv }, \
+	  .private_value = HDA_COMPOSE_AMP_VAL(nid, channel, 0, dir) }
+
+#define CA0132_CODEC_MUTE_MONO(xname, nid, channel, dir) \
+	{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+	  .name = xname, \
+	  .subdevice = HDA_SUBDEV_AMP_FLAG, \
+	  .info = snd_hda_mixer_amp_switch_info, \
+	  .get = ca0132_switch_get, \
+	  .put = ca0132_switch_put, \
+	  .private_value = HDA_COMPOSE_AMP_VAL(nid, channel, 0, dir) }
+
+/* stereo */
+#define CA0132_CODEC_VOL(xname, nid, dir) \
+	CA0132_CODEC_VOL_MONO(xname, nid, 3, dir)
+#define CA0132_CODEC_MUTE(xname, nid, dir) \
+	CA0132_CODEC_MUTE_MONO(xname, nid, 3, dir)
+
+
 /* The followings are for tuning of products */
 #ifdef ENABLE_TUNING_CONTROLS
 
@@ -3923,6 +3924,68 @@ static struct snd_kcontrol_new ca0132_mixer[] = {
 	{ } /* end */
 };
 
+static int ca0132_build_controls(struct hda_codec *codec)
+{
+	struct ca0132_spec *spec = codec->spec;
+	int i, num_fx;
+	int err = 0;
+
+	/* Add Mixer controls */
+	for (i = 0; i < spec->num_mixers; i++) {
+		err = snd_hda_add_new_ctls(codec, spec->mixers[i]);
+		if (err < 0)
+			return err;
+	}
+
+	/* Add in and out effects controls.
+	 * VoiceFX, PE and CrystalVoice are added separately.
+	 */
+	num_fx = OUT_EFFECTS_COUNT + IN_EFFECTS_COUNT;
+	for (i = 0; i < num_fx; i++) {
+		err = add_fx_switch(codec, ca0132_effects[i].nid,
+				    ca0132_effects[i].name,
+				    ca0132_effects[i].direct);
+		if (err < 0)
+			return err;
+	}
+
+	err = add_fx_switch(codec, PLAY_ENHANCEMENT, "PlayEnhancement", 0);
+	if (err < 0)
+		return err;
+
+	err = add_fx_switch(codec, CRYSTAL_VOICE, "CrystalVoice", 1);
+	if (err < 0)
+		return err;
+
+	add_voicefx(codec);
+
+	#ifdef ENABLE_TUNING_CONTROLS
+	add_tuning_ctls(codec);
+	#endif
+
+	err = snd_hda_jack_add_kctls(codec, &spec->autocfg);
+	if (err < 0)
+		return err;
+
+	if (spec->dig_out) {
+		err = snd_hda_create_spdif_out_ctls(codec, spec->dig_out,
+						    spec->dig_out);
+		if (err < 0)
+			return err;
+		err = snd_hda_create_spdif_share_sw(codec, &spec->multiout);
+		if (err < 0)
+			return err;
+		/* spec->multiout.share_spdif = 1; */
+	}
+
+	if (spec->dig_in) {
+		err = snd_hda_create_spdif_in_ctls(codec, spec->dig_in);
+		if (err < 0)
+			return err;
+	}
+	return 0;
+}
+
 /*
  * PCM
  */
@@ -4017,68 +4080,6 @@ static int ca0132_build_pcms(struct hda_codec *codec)
 	return 0;
 }
 
-static int ca0132_build_controls(struct hda_codec *codec)
-{
-	struct ca0132_spec *spec = codec->spec;
-	int i, num_fx;
-	int err = 0;
-
-	/* Add Mixer controls */
-	for (i = 0; i < spec->num_mixers; i++) {
-		err = snd_hda_add_new_ctls(codec, spec->mixers[i]);
-		if (err < 0)
-			return err;
-	}
-
-	/* Add in and out effects controls.
-	 * VoiceFX, PE and CrystalVoice are added separately.
-	 */
-	num_fx = OUT_EFFECTS_COUNT + IN_EFFECTS_COUNT;
-	for (i = 0; i < num_fx; i++) {
-		err = add_fx_switch(codec, ca0132_effects[i].nid,
-				    ca0132_effects[i].name,
-				    ca0132_effects[i].direct);
-		if (err < 0)
-			return err;
-	}
-
-	err = add_fx_switch(codec, PLAY_ENHANCEMENT, "PlayEnhancement", 0);
-	if (err < 0)
-		return err;
-
-	err = add_fx_switch(codec, CRYSTAL_VOICE, "CrystalVoice", 1);
-	if (err < 0)
-		return err;
-
-	add_voicefx(codec);
-
-	#ifdef ENABLE_TUNING_CONTROLS
-	add_tuning_ctls(codec);
-	#endif
-
-	err = snd_hda_jack_add_kctls(codec, &spec->autocfg);
-	if (err < 0)
-		return err;
-
-	if (spec->dig_out) {
-		err = snd_hda_create_spdif_out_ctls(codec, spec->dig_out,
-						    spec->dig_out);
-		if (err < 0)
-			return err;
-		err = snd_hda_create_spdif_share_sw(codec, &spec->multiout);
-		if (err < 0)
-			return err;
-		/* spec->multiout.share_spdif = 1; */
-	}
-
-	if (spec->dig_in) {
-		err = snd_hda_create_spdif_in_ctls(codec, spec->dig_in);
-		if (err < 0)
-			return err;
-	}
-	return 0;
-}
-
 static void ca0132_init_unsol(struct hda_codec *codec)
 {
 	snd_hda_jack_detect_enable(codec, UNSOL_TAG_HP, UNSOL_TAG_HP);
@@ -4278,16 +4279,54 @@ static void ca0132_init_params(struct hda_codec *codec)
 	chipio_set_control_param(codec, CONTROL_PARAM_PORTD_160OHM_GAIN, 6);
 }
 
-static void ca0132_set_ct_ext(struct hda_codec *codec, int enable)
+static void ca0132_set_dsp_msr(struct hda_codec *codec, bool is96k)
 {
-	/* Set Creative extension */
-	snd_printdd("SET CREATIVE EXTENSION\n");
-	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-			    VENDOR_CHIPIO_CT_EXTENSIONS_ENABLE,
-			    enable);
-	msleep(20);
+	chipio_set_control_flag(codec, CONTROL_FLAG_DSP_96KHZ, is96k);
+	chipio_set_control_flag(codec, CONTROL_FLAG_DAC_96KHZ, is96k);
+	chipio_set_control_flag(codec, CONTROL_FLAG_SRC_RATE_96KHZ, is96k);
+	chipio_set_control_flag(codec, CONTROL_FLAG_SRC_CLOCK_196MHZ, is96k);
+	chipio_set_control_flag(codec, CONTROL_FLAG_ADC_B_96KHZ, is96k);
+	chipio_set_control_flag(codec, CONTROL_FLAG_ADC_C_96KHZ, is96k);
+
+	chipio_set_conn_rate(codec, MEM_CONNID_MICIN1, SR_16_000);
+	chipio_set_conn_rate(codec, MEM_CONNID_MICOUT1, SR_16_000);
+	chipio_set_conn_rate(codec, MEM_CONNID_WUH, SR_48_000);
+}
+
+static bool ca0132_download_dsp_images(struct hda_codec *codec)
+{
+	bool dsp_loaded = false;
+	const struct dsp_image_seg *dsp_os_image;
+
+	if (request_firmware_cached(&fw_efx, EFX_FILE,
+				    codec->bus->card->dev) != 0)
+		return false;
+
+	dsp_os_image = (struct dsp_image_seg *)(fw_efx->data);
+	dspload_image(codec, dsp_os_image, 0, 0, true, 0);
+	dsp_loaded = dspload_wait_loaded(codec);
+
+	return dsp_loaded;
 }
 
+static void ca0132_download_dsp(struct hda_codec *codec)
+{
+	struct ca0132_spec *spec = codec->spec;
+
+	spec->dsp_state = DSP_DOWNLOAD_INIT;
+
+	if (spec->dsp_state == DSP_DOWNLOAD_INIT) {
+		chipio_enable_clocks(codec);
+		spec->dsp_state = DSP_DOWNLOADING;
+		if (!ca0132_download_dsp_images(codec))
+			spec->dsp_state = DSP_DOWNLOAD_FAILED;
+		else
+			spec->dsp_state = DSP_DOWNLOADED;
+	}
+
+	if (spec->dsp_state == DSP_DOWNLOADED)
+		ca0132_set_dsp_msr(codec, true);
+}
 
 static void ca0132_config(struct hda_codec *codec)
 {
@@ -4328,6 +4367,47 @@ static void ca0132_config(struct hda_codec *codec)
 	cfg->dig_in_type = HDA_PCM_TYPE_SPDIF;
 }
 
+static void ca0132_process_dsp_response(struct hda_codec *codec)
+{
+	struct ca0132_spec *spec = codec->spec;
+
+	snd_printdd(KERN_INFO "ca0132_process_dsp_response\n");
+	if (spec->wait_scp) {
+		if (dspio_get_response_data(codec) >= 0)
+			spec->wait_scp = 0;
+	}
+
+	dspio_clear_response_queue(codec);
+}
+
+static void ca0132_unsol_event(struct hda_codec *codec, unsigned int res)
+{
+	snd_printdd(KERN_INFO "ca0132_unsol_event: 0x%x\n", res);
+
+
+	if (((res >> AC_UNSOL_RES_TAG_SHIFT) & 0x3f) == UNSOL_TAG_DSP) {
+		ca0132_process_dsp_response(codec);
+	} else {
+		res = snd_hda_jack_get_action(codec,
+				(res >> AC_UNSOL_RES_TAG_SHIFT) & 0x3f);
+
+		snd_printdd(KERN_INFO "snd_hda_jack_get_action: 0x%x\n", res);
+
+		switch (res) {
+		case UNSOL_TAG_HP:
+			ca0132_select_out(codec);
+			snd_hda_jack_report_sync(codec);
+			break;
+		case UNSOL_TAG_AMIC1:
+			ca0132_select_mic(codec);
+			snd_hda_jack_report_sync(codec);
+			break;
+		default:
+			break;
+		}
+	}
+}
+
 /*
  * Verbs tables.
  */
@@ -4442,96 +4522,6 @@ static void ca0132_exit_chip(struct hda_codec *codec)
 		dsp_reset(codec);
 }
 
-static void ca0132_set_dsp_msr(struct hda_codec *codec, bool is96k)
-{
-	chipio_set_control_flag(codec, CONTROL_FLAG_DSP_96KHZ, is96k);
-	chipio_set_control_flag(codec, CONTROL_FLAG_DAC_96KHZ, is96k);
-	chipio_set_control_flag(codec, CONTROL_FLAG_SRC_RATE_96KHZ, is96k);
-	chipio_set_control_flag(codec, CONTROL_FLAG_SRC_CLOCK_196MHZ, is96k);
-	chipio_set_control_flag(codec, CONTROL_FLAG_ADC_B_96KHZ, is96k);
-	chipio_set_control_flag(codec, CONTROL_FLAG_ADC_C_96KHZ, is96k);
-
-	chipio_set_conn_rate(codec, MEM_CONNID_MICIN1, SR_16_000);
-	chipio_set_conn_rate(codec, MEM_CONNID_MICOUT1, SR_16_000);
-	chipio_set_conn_rate(codec, MEM_CONNID_WUH, SR_48_000);
-}
-
-static bool ca0132_download_dsp_images(struct hda_codec *codec)
-{
-	bool dsp_loaded = false;
-	const struct dsp_image_seg *dsp_os_image;
-
-	if (request_firmware_cached(&fw_efx, EFX_FILE,
-				    codec->bus->card->dev) != 0)
-		return false;
-
-	dsp_os_image = (struct dsp_image_seg *)(fw_efx->data);
-	dspload_image(codec, dsp_os_image, 0, 0, true, 0);
-	dsp_loaded = dspload_wait_loaded(codec);
-
-	return dsp_loaded;
-}
-
-static void ca0132_download_dsp(struct hda_codec *codec)
-{
-	struct ca0132_spec *spec = codec->spec;
-
-	spec->dsp_state = DSP_DOWNLOAD_INIT;
-
-	if (spec->dsp_state == DSP_DOWNLOAD_INIT) {
-		chipio_enable_clocks(codec);
-		spec->dsp_state = DSP_DOWNLOADING;
-		if (!ca0132_download_dsp_images(codec))
-			spec->dsp_state = DSP_DOWNLOAD_FAILED;
-		else
-			spec->dsp_state = DSP_DOWNLOADED;
-	}
-
-	if (spec->dsp_state == DSP_DOWNLOADED)
-		ca0132_set_dsp_msr(codec, true);
-}
-
-static void ca0132_process_dsp_response(struct hda_codec *codec)
-{
-	struct ca0132_spec *spec = codec->spec;
-
-	snd_printdd(KERN_INFO "ca0132_process_dsp_response\n");
-	if (spec->wait_scp) {
-		if (dspio_get_response_data(codec) >= 0)
-			spec->wait_scp = 0;
-	}
-
-	dspio_clear_response_queue(codec);
-}
-
-static void ca0132_unsol_event(struct hda_codec *codec, unsigned int res)
-{
-	snd_printdd(KERN_INFO "ca0132_unsol_event: 0x%x\n", res);
-
-
-	if (((res >> AC_UNSOL_RES_TAG_SHIFT) & 0x3f) == UNSOL_TAG_DSP) {
-		ca0132_process_dsp_response(codec);
-	} else {
-		res = snd_hda_jack_get_action(codec,
-				(res >> AC_UNSOL_RES_TAG_SHIFT) & 0x3f);
-
-		snd_printdd(KERN_INFO "snd_hda_jack_get_action: 0x%x\n", res);
-
-		switch (res) {
-		case UNSOL_TAG_HP:
-			ca0132_select_out(codec);
-			snd_hda_jack_report_sync(codec);
-			break;
-		case UNSOL_TAG_AMIC1:
-			ca0132_select_mic(codec);
-			snd_hda_jack_report_sync(codec);
-			break;
-		default:
-			break;
-		}
-	}
-}
-
 static int ca0132_init(struct hda_codec *codec)
 {
 	struct ca0132_spec *spec = codec->spec;
@@ -4599,8 +4589,6 @@ static struct hda_codec_ops ca0132_patch_ops = {
 	.unsol_event = ca0132_unsol_event,
 };
 
-
-
 static int patch_ca0132(struct hda_codec *codec)
 {
 	struct ca0132_spec *spec;
-- 
1.7.4.1
