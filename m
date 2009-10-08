From: Li Bo <liboat@gmail.com>
Subject: Re: [PATCH 14/31] HDA patch_via.c: Add Jack detect
	feature for VT1708.
Date: Thu, 8 Oct 2009 13:28:25 +0800
Message-ID: <16685ee0910072228k63b1e20cgfe098130a0924ade@mail.gmail.com>
References: <16685ee0910050727q4288fc76hdde23b431232d073@mail.gmail.com>
	<16685ee0910052206ge80ec18yb0546282c4a9945f@mail.gmail.com>
	<s5hhbudrrgb.wl%tiwai@suse.de>
	<20091006121740.GI17195@prithivi.gnumonks.org>
	<s5hws383dfv.wl%tiwai@suse.de>
	<16685ee0910060827t1ab399dek67447a1f635a72c9@mail.gmail.com>
	<s5hzl841qoy.wl%tiwai@suse.de>
	<16685ee0910062256l6747526erfd71ed2c6927974d@mail.gmail.com>
	<s5hzl83y9cl.wl%tiwai@suse.de>
	<16685ee0910072226u6c0e6c72g98cfc95f31fdf926@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f225.google.com (mail-bw0-f225.google.com
	[209.85.218.225])
	by alsa0.perex.cz (Postfix) with ESMTP id 8D28210391D
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Oct 2009 07:28:26 +0200 (CEST)
Received: by bwz25 with SMTP id 25so1455634bwz.32
	for <alsa-devel@alsa-project.org>; Wed, 07 Oct 2009 22:28:25 -0700 (PDT)
In-Reply-To: <16685ee0910072226u6c0e6c72g98cfc95f31fdf926@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, LoganLi@viatech.com.cn, Harald Welte <laforge@gnumonks.org>, lydiawang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

[ALSA] HDA VIA: Add Jack detect feature for VT1708.

VT1708 does not support unsolicited response, but we need hp detect to
automute speaker. Implemented in workqueue.

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>

---
 sound/pci/hda/patch_via.c |  224 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 168 insertions(+), 56 deletions(-)

--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -89,6 +89,64 @@
 	CODEC_TYPES,
 };

+struct via_spec {
+	/* codec parameterization */
+	struct snd_kcontrol_new *mixers[4];
+	unsigned int num_mixers;
+
+	struct hda_verb *init_verbs[5];
+	unsigned int num_iverbs;
+
+	char *stream_name_analog;
+	struct hda_pcm_stream *stream_analog_playback;
+	struct hda_pcm_stream *stream_analog_capture;
+
+	char *stream_name_digital;
+	struct hda_pcm_stream *stream_digital_playback;
+	struct hda_pcm_stream *stream_digital_capture;
+
+	/* playback */
+	struct hda_multi_out multiout;
+	hda_nid_t slave_dig_outs[2];
+
+	/* capture */
+	unsigned int num_adc_nids;
+	hda_nid_t *adc_nids;
+	hda_nid_t mux_nids[3];
+	hda_nid_t dig_in_nid;
+	hda_nid_t dig_in_pin;
+
+	/* capture source */
+	const struct hda_input_mux *input_mux;
+	unsigned int cur_mux[3];
+
+	/* PCM information */
+	struct hda_pcm pcm_rec[3];
+
+	/* dynamic controls, init_verbs and input_mux */
+	struct auto_pin_cfg autocfg;
+	struct snd_array kctls;
+	struct hda_input_mux private_imux[2];
+	hda_nid_t private_dac_nids[AUTO_CFG_MAX_OUTS];
+
+	/* HP mode source */
+	const struct hda_input_mux *hp_mux;
+	unsigned int hp_independent_mode;
+	unsigned int hp_independent_mode_index;
+	unsigned int smart51_enabled;
+
+	enum VIA_HDA_CODEC codec_type;
+
+	/* work to check hp jack state */
+	struct hda_codec *codec;
+	struct delayed_work vt1708_hp_work;
+	int vt1708_jack_detectect;
+	int vt1708_hp_present;
+#ifdef CONFIG_SND_HDA_POWER_SAVE
+	struct hda_loopback_check loopback;
+#endif
+};
+
 static enum VIA_HDA_CODEC get_codec_type(struct hda_codec *codec)
 {
 	u32 vendor_id = codec->vendor_id;
@@ -181,6 +239,28 @@

 static void analog_low_current_mode(struct hda_codec *codec, int stream_idle);
 static void set_jack_power_state(struct hda_codec *codec);
+static int is_aa_path_mute(struct hda_codec *codec);
+
+static void vt1708_start_hp_work(struct via_spec *spec)
+{
+	if (spec->codec_type != VT1708)
+		return;
+	snd_hda_codec_write(spec->codec, 0x1, 0, 0xf81,
+			    !spec->vt1708_jack_detectect);
+	if (!delayed_work_pending(&spec->vt1708_hp_work))
+		schedule_delayed_work(&spec->vt1708_hp_work,
+				      msecs_to_jiffies(100));
+}
+
+static void vt1708_stop_hp_work(struct via_spec *spec)
+{
+	if (spec->codec_type != VT1708)
+		return;
+	snd_hda_codec_write(spec->codec, 0x1, 0, 0xf81,
+			    !spec->vt1708_jack_detectect);
+	cancel_delayed_work(&spec->vt1708_hp_work);
+	flush_scheduled_work();
+}

 static int analog_input_switch_put(struct snd_kcontrol *kcontrol,
 				   struct snd_ctl_elem_value *ucontrol)
@@ -190,6 +270,12 @@

 	set_jack_power_state(codec);
 	analog_low_current_mode(snd_kcontrol_chip(kcontrol), -1);
+	if (snd_hda_get_bool_hint(codec, "analog_loopback_hp_detect") == 1) {
+		if (is_aa_path_mute(codec))
+			vt1708_start_hp_work(codec->spec);
+		else
+			vt1708_stop_hp_work(codec->spec);
+	}
 	return change;
 }

@@ -210,59 +296,6 @@
 };


-struct via_spec {
-	/* codec parameterization */
-	struct snd_kcontrol_new *mixers[4];
-	unsigned int num_mixers;
-
-	struct hda_verb *init_verbs[5];
-	unsigned int num_iverbs;
-
-	char *stream_name_analog;
-	struct hda_pcm_stream *stream_analog_playback;
-	struct hda_pcm_stream *stream_analog_capture;
-
-	char *stream_name_digital;
-	struct hda_pcm_stream *stream_digital_playback;
-	struct hda_pcm_stream *stream_digital_capture;
-
-	/* playback */
-	struct hda_multi_out multiout;
-	hda_nid_t slave_dig_outs[2];
-
-	/* capture */
-	unsigned int num_adc_nids;
-	hda_nid_t *adc_nids;
-	hda_nid_t mux_nids[3];
-	hda_nid_t dig_in_nid;
-	hda_nid_t dig_in_pin;
-
-	/* capture source */
-	const struct hda_input_mux *input_mux;
-	unsigned int cur_mux[3];
-
-	/* PCM information */
-	struct hda_pcm pcm_rec[3];
-
-	/* dynamic controls, init_verbs and input_mux */
-	struct auto_pin_cfg autocfg;
-	struct snd_array kctls;
-	struct hda_input_mux private_imux[2];
-	hda_nid_t private_dac_nids[AUTO_CFG_MAX_OUTS];
-
-	/* HP mode source */
-	const struct hda_input_mux *hp_mux;
-	unsigned int hp_independent_mode;
-	unsigned int hp_independent_mode_index;
-	unsigned int smart51_enabled;
-
-	enum VIA_HDA_CODEC codec_type;
-
-#ifdef CONFIG_SND_HDA_POWER_SAVE
-	struct hda_loopback_check loopback;
-#endif
-};
-
 static hda_nid_t vt1708_adc_nids[2] = {
 	/* ADC1-2 */
 	0x15, 0x27
@@ -1094,7 +1127,7 @@
 			snd_hda_codec_setup_stream(codec, mout->hp_nid,
 						   stream_tag, 0, format);
 	}
-
+	vt1708_start_hp_work(spec);
 	return 0;
 }

@@ -1134,7 +1167,7 @@
 			snd_hda_codec_setup_stream(codec, mout->hp_nid,
 						   0, 0, 0);
 	}
-
+	vt1708_stop_hp_work(spec);
 	return 0;
 }

@@ -1345,6 +1378,7 @@
 		return;

 	via_free_kctls(codec);
+	vt1708_stop_hp_work(spec);
 	kfree(codec->spec);
 }

@@ -1464,6 +1498,15 @@
  	return 0;
 }

+#ifdef SND_HDA_NEEDS_RESUME
+static int via_suspend(struct hda_codec *codec, pm_message_t state)
+{
+	struct via_spec *spec = codec->spec;
+	vt1708_stop_hp_work(spec);
+	return 0;
+}
+#endif
+
 #ifdef CONFIG_SND_HDA_POWER_SAVE
 static int via_check_power_status(struct hda_codec *codec, hda_nid_t nid)
 {
@@ -1479,6 +1522,9 @@
 	.build_pcms = via_build_pcms,
 	.init = via_init,
 	.free = via_free,
+#ifdef SND_HDA_NEEDS_RESUME
+	.suspend = via_suspend,
+#endif
 #ifdef CONFIG_SND_HDA_POWER_SAVE
 	.check_power_status = via_check_power_status,
 #endif
@@ -1728,6 +1774,51 @@
 	return;
 }

+static int vt1708_jack_detectect_get(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct via_spec *spec = codec->spec;
+
+	if (spec->codec_type != VT1708)
+		return 0;
+	spec->vt1708_jack_detectect =
+		!((snd_hda_codec_read(codec, 0x1, 0, 0xf84, 0) >> 8) & 0x1);
+	ucontrol->value.integer.value[0] = spec->vt1708_jack_detectect;
+	return 0;
+}
+
+static int vt1708_jack_detectect_put(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct via_spec *spec = codec->spec;
+	int change;
+
+	if (spec->codec_type != VT1708)
+		return 0;
+	spec->vt1708_jack_detectect = ucontrol->value.integer.value[0];
+	change = (0x1 & (snd_hda_codec_read(codec, 0x1, 0, 0xf84, 0) >> 8))
+		== !spec->vt1708_jack_detectect;
+	if (spec->vt1708_jack_detectect) {
+		mute_aa_path(codec, 1);
+		notify_aa_path_ctls(codec);
+	}
+	return change;
+}
+
+static struct snd_kcontrol_new vt1708_jack_detectect[] = {
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Jack Detect",
+		.count = 1,
+		.info = snd_ctl_boolean_mono_info,
+		.get = vt1708_jack_detectect_get,
+		.put = vt1708_jack_detectect_put,
+	},
+	{} /* end */
+};
+
 static int vt1708_parse_auto_config(struct hda_codec *codec)
 {
 	struct via_spec *spec = codec->spec;
@@ -1755,6 +1846,10 @@
 	err = vt1708_auto_create_analog_input_ctls(spec, &spec->autocfg);
 	if (err < 0)
 		return err;
+	/* add jack detect on/off control */
+	err = snd_hda_add_new_ctls(codec, vt1708_jack_detectect);
+	if (err < 0)
+		return err;

 	spec->multiout.max_channels = spec->multiout.num_dacs * 2;

@@ -1788,6 +1883,22 @@
 	return 0;
 }

+static void vt1708_update_hp_jack_state(struct work_struct *work)
+{
+	struct via_spec *spec = container_of(work, struct via_spec,
+					     vt1708_hp_work.work);
+	if (spec->codec_type != VT1708)
+		return;
+	/* if jack state toggled */
+	if (spec->vt1708_hp_present
+	    != (snd_hda_codec_read(spec->codec, spec->autocfg.hp_pins[0], 0,
+				   AC_VERB_GET_PIN_SENSE, 0) >> 31)) {
+		spec->vt1708_hp_present ^= 1;
+		via_hp_automute(spec->codec);
+	}
+	vt1708_start_hp_work(spec);
+}
+
 static int get_mux_nids(struct hda_codec *codec)
 {
 	struct via_spec *spec = codec->spec;
@@ -1864,7 +1975,8 @@
 #ifdef CONFIG_SND_HDA_POWER_SAVE
 	spec->loopback.amplist = vt1708_loopbacks;
 #endif
-
+	spec->codec = codec;
+	INIT_DELAYED_WORK(&spec->vt1708_hp_work, vt1708_update_hp_jack_state);
 	return 0;
 }
