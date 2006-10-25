From: Tobin Davis <tdavis@dsl-only.net>
Subject: Test Patch5 for Conexant HD Audio.
Date: Tue, 24 Oct 2006 18:03:11 -0700
Message-ID: <1161738191.18211.17.camel@razman>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-N/wUnDv34yI+HyLuH56S"
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-N/wUnDv34yI+HyLuH56S
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Here's test patch 5 (alsa-kernel).  I've commented out the test mode for
the moment.  HP users should now see controls similar to the original
patch.

Let me know how it works.  Please include your system model (Ex: HP
DV8000) and your subvendor and subdevice ID from "lspci -s 0:1b -vn" so
that I can start tracking what worked and what didn't.  Codec output is
almost useless at this point, as it really hasn't changed (from what
I've seen earlier).

Thanks for testing this.

-- 
Tobin Davis <tdavis@dsl-only.net>

--=-N/wUnDv34yI+HyLuH56S
Content-Disposition: attachment; filename=conexant-kernel-core5.patch
Content-Type: text/x-patch; name=conexant-kernel-core5.patch;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- /dev/null	2006-10-23 04:17:47.000000000 -0700
+++ alsa-kernel/pci/hda/patch_conexant.c	2006-10-24 17:53:27.000000000 -0700
@@ -0,0 +1,890 @@
+/*
+ * HD audio interface patch for Conexant HDA audio codec
+ *
+ * Copyright (c) 2006 Pototskiy Akex <alex.pototskiy@gmail.com>
+ * 		      Takashi Iwai <tiwai@suse.de>
+ * 		      Tobin Davis  <tdavis@dsl-only.net>
+ *
+ *  This driver is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This driver is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+
+#include <sound/driver.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/pci.h>
+#include <sound/core.h>
+#include "hda_codec.h"
+#include "hda_local.h"
+
+#define MAIN_MUX	0x1A
+#define DAC		0x10
+#define ADC		0x12
+#define SPDIF_OUT	0x11
+
+struct conexant_spec {
+
+	struct snd_kcontrol_new *mixers[5];
+	int num_mixers;
+
+	const struct hda_verb *init_verbs[5];	/* initialization verbs
+						 * don't forget NULL termination!
+						 */
+	unsigned int num_init_verbs;
+
+	/* playback */
+	struct hda_multi_out multiout;	/* playback set-up
+					 * max_channels, dacs must be set
+					 * dig_out_nid and hp_nid are optional
+					 */
+	unsigned int cur_eapd;
+
+	/* capture */
+	unsigned int num_adc_nids;
+	hda_nid_t *adc_nids;
+	hda_nid_t dig_in_nid;		/* digital-in NID; optional */
+
+	/* capture source */
+	const struct hda_input_mux *input_mux;
+	hda_nid_t *capsrc_nids;
+	unsigned int cur_mux[3];
+
+	/* channel model */
+	const struct hda_channel_mode *channel_mode;
+	int num_channel_mode;
+
+	/* PCM information */
+	struct hda_pcm pcm_rec[2];	/* used in build_pcms() */
+
+	struct mutex amp_mutex;	/* PCM volume/mute control mutex */
+	unsigned int spdif_route;
+
+	/* dynamic controls, init_verbs and input_mux */
+	struct auto_pin_cfg autocfg;
+	unsigned int num_kctl_alloc, num_kctl_used;
+	struct snd_kcontrol_new *kctl_alloc;
+	struct hda_input_mux private_imux;
+	hda_nid_t private_dac_nids[4];
+
+};
+
+static int conexant_playback_pcm_open(struct hda_pcm_stream *hinfo,
+				    struct hda_codec *codec,
+				    struct snd_pcm_substream *substream)
+{
+	struct conexant_spec *spec = codec->spec;
+	return snd_hda_multi_out_analog_open(codec, &spec->multiout, substream);
+}
+
+static int conexant_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
+				       struct hda_codec *codec,
+				       unsigned int stream_tag,
+				       unsigned int format,
+				       struct snd_pcm_substream *substream)
+{
+	struct conexant_spec *spec = codec->spec;
+	return snd_hda_multi_out_analog_prepare(codec, &spec->multiout, stream_tag,
+						format, substream);
+}
+
+static int conexant_playback_pcm_cleanup(struct hda_pcm_stream *hinfo,
+				       struct hda_codec *codec,
+				       struct snd_pcm_substream *substream)
+{
+	struct conexant_spec *spec = codec->spec;
+	return snd_hda_multi_out_analog_cleanup(codec, &spec->multiout);
+}
+
+/*
+ * Digital out
+ */
+static int conexant_dig_playback_pcm_open(struct hda_pcm_stream *hinfo,
+					struct hda_codec *codec,
+					struct snd_pcm_substream *substream)
+{
+	struct conexant_spec *spec = codec->spec;
+	return snd_hda_multi_out_dig_open(codec, &spec->multiout);
+}
+
+static int conexant_dig_playback_pcm_close(struct hda_pcm_stream *hinfo,
+					 struct hda_codec *codec,
+					 struct snd_pcm_substream *substream)
+{
+	struct conexant_spec *spec = codec->spec;
+	return snd_hda_multi_out_dig_close(codec, &spec->multiout);
+}
+
+/*
+ * Analog capture
+ */
+static int conexant_capture_pcm_prepare(struct hda_pcm_stream *hinfo,
+				      struct hda_codec *codec,
+				      unsigned int stream_tag,
+				      unsigned int format,
+				      struct snd_pcm_substream *substream)
+{
+	struct conexant_spec *spec = codec->spec;
+	snd_hda_codec_setup_stream(codec, spec->adc_nids[substream->number],
+				   stream_tag, 0, format);
+	return 0;
+}
+
+static int conexant_capture_pcm_cleanup(struct hda_pcm_stream *hinfo,
+				      struct hda_codec *codec,
+				      struct snd_pcm_substream *substream)
+{
+	struct conexant_spec *spec = codec->spec;
+	snd_hda_codec_setup_stream(codec, spec->adc_nids[substream->number],
+				   0, 0, 0);
+	return 0;
+}
+
+
+
+static struct hda_pcm_stream conexant_pcm_analog_playback = {
+	.substreams = 1,
+	.channels_min = 2,
+	.channels_max = 2,
+	.nid = 0, /* fill later */
+	.ops = {
+		.open = conexant_playback_pcm_open,
+		.prepare = conexant_playback_pcm_prepare,
+		.cleanup = conexant_playback_pcm_cleanup
+	},
+
+};
+
+static struct hda_pcm_stream conexant_pcm_analog_capture = {
+	.substreams = 1,
+	.channels_min = 2,
+	.channels_max = 2,
+	.nid = 0, /* fill later */
+	.ops = {
+		.prepare = conexant_capture_pcm_prepare,
+		.cleanup = conexant_capture_pcm_cleanup
+	},
+
+};
+
+
+static struct hda_pcm_stream conexant_pcm_digital_playback = {
+	.substreams = 1,
+	.channels_min = 2,
+	.channels_max = 2,
+	.nid = 0, /* fill later */
+	.ops = {
+		.open = conexant_dig_playback_pcm_open,
+		.close = conexant_dig_playback_pcm_close
+	},
+};
+
+static struct hda_pcm_stream conexant_pcm_digital_capture = {
+	.substreams = 1,
+	.channels_min = 2,
+	.channels_max = 2,
+	/* NID is set in alc_build_pcms */
+};
+
+static int conexant_build_pcms(struct hda_codec *codec) {
+	struct conexant_spec *spec = codec->spec;
+	struct hda_pcm *info = spec->pcm_rec;
+
+	codec->num_pcms = 1;
+	codec->pcm_info = info;
+
+	info->name = "CONEXANT Analog";
+	info->stream[SNDRV_PCM_STREAM_PLAYBACK] = conexant_pcm_analog_playback;
+	info->stream[SNDRV_PCM_STREAM_PLAYBACK].channels_max = spec->multiout.max_channels;
+	info->stream[SNDRV_PCM_STREAM_PLAYBACK].nid = spec->multiout.dac_nids[0];
+	info->stream[SNDRV_PCM_STREAM_CAPTURE] = conexant_pcm_analog_capture;
+	info->stream[SNDRV_PCM_STREAM_CAPTURE].substreams = spec->num_adc_nids;
+	info->stream[SNDRV_PCM_STREAM_CAPTURE].nid = spec->adc_nids[0];
+
+	if (spec->multiout.dig_out_nid) {
+		info++;
+		codec->num_pcms++;
+		info->name = "Conexant Digital";
+		info->stream[SNDRV_PCM_STREAM_PLAYBACK] = conexant_pcm_digital_playback;
+		info->stream[SNDRV_PCM_STREAM_PLAYBACK].nid = spec->multiout.dig_out_nid;
+		if (spec->dig_in_nid) {
+			info->stream[SNDRV_PCM_STREAM_CAPTURE] = conexant_pcm_digital_capture;
+			info->stream[SNDRV_PCM_STREAM_CAPTURE].nid = spec->dig_in_nid;
+		}
+	}
+
+	return 0;
+}
+/*   */
+static struct hda_input_mux conexant_capture_source = {
+	.num_items = 4,
+	.items = {
+		{ "ExtMic", 0x1 },
+		{ "IntMic", 0x2 },
+		{ "Line", 0x3 },
+		{ "CD", 0x4 }
+	}
+};
+
+static int conexant_mux_enum_info(struct snd_kcontrol *kcontrol,
+	       			  struct snd_ctl_elem_info *uinfo)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct conexant_spec *spec = codec->spec;
+
+	return snd_hda_input_mux_info(spec->input_mux, uinfo);
+}
+
+static int conexant_mux_enum_get(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct conexant_spec *spec = codec->spec;
+	unsigned int adc_idx = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
+
+	ucontrol->value.enumerated.item[0] = spec->cur_mux[adc_idx];
+	return 0;
+}
+
+static int conexant_mux_enum_put(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct conexant_spec *spec = codec->spec;
+	unsigned int adc_idx = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
+
+	return snd_hda_input_mux_put(codec, spec->input_mux, ucontrol,
+				     spec->capsrc_nids[adc_idx],
+				     &spec->cur_mux[adc_idx]);
+}
+
+static int conexant_init(struct hda_codec *codec) {
+	struct conexant_spec *spec = codec->spec;
+	int i;
+
+	for (i = 0; i < spec->num_init_verbs; i++)
+		snd_hda_sequence_write(codec, spec->init_verbs[i]);
+	return 0;
+}
+
+static void conexant_free(struct hda_codec *codec) {
+        struct conexant_spec *spec = codec->spec;
+        unsigned int i;
+
+        if (spec->kctl_alloc) {
+                for (i = 0; i < spec->num_kctl_used; i++)
+                        kfree(spec->kctl_alloc[i].name);
+                kfree(spec->kctl_alloc);
+        }
+
+	kfree(codec->spec);
+}
+
+#ifdef CONFIG_PM
+static int conexant_resume(struct hda_codec *codec)
+{
+	struct conexant_spec *spec = codec->spec;
+	int i;
+
+	codec->patch_ops.init(codec);
+	for (i = 0; i < spec->num_mixers; i++)
+		snd_hda_resume_ctls(codec, spec->mixers[i]);
+	if (spec->multiout.dig_out_nid)
+		snd_hda_resume_spdif_out(codec);
+	if (spec->dig_in_nid)
+		snd_hda_resume_spdif_in(codec);
+	return 0;
+}
+#endif
+
+static int conexant_build_controls(struct hda_codec *codec) {
+	struct conexant_spec *spec = codec->spec;
+	unsigned int i;
+	int err;
+
+	for (i = 0; i < spec->num_mixers; i++) {
+		err = snd_hda_add_new_ctls(codec, spec->mixers[i]);
+		if (err < 0)
+			return err;
+	}
+	if (spec->multiout.dig_out_nid) {
+		err = snd_hda_create_spdif_out_ctls(codec, spec->multiout.dig_out_nid);
+		if (err < 0)
+			return err;
+	} 
+	if (spec->dig_in_nid) {
+		err = snd_hda_create_spdif_in_ctls(codec, spec->dig_in_nid);
+		if (err < 0)
+			return err;
+	}
+	return 0;
+}
+
+static struct hda_codec_ops conexant_patch_ops = {
+	.build_controls = conexant_build_controls,
+	.build_pcms = conexant_build_pcms,
+	.init = conexant_init,
+	.free = conexant_free,
+#ifdef CONFIG_PM
+	.resume = conexant_resume,
+#endif
+};
+
+/*
+ * EAPD control
+ * the private value = nid | (invert << 8)
+ */
+
+#define CXT5047_HP_EVENT	0x37
+#define CXT5047_MIC_EVENT	0x38
+
+
+static int conexant_eapd_info(struct snd_kcontrol *kcontrol,
+			    struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 1;
+	return 0;
+}
+
+static int conexant_eapd_get(struct snd_kcontrol *kcontrol,
+			   struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct conexant_spec *spec = codec->spec;
+	int invert = (kcontrol->private_value >> 8) & 1;
+	if (invert)
+		ucontrol->value.integer.value[0] = ! spec->cur_eapd;
+	else
+		ucontrol->value.integer.value[0] = spec->cur_eapd;
+	return 0;
+}
+
+static int conexant_eapd_put(struct snd_kcontrol *kcontrol,
+			   struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct conexant_spec *spec = codec->spec;
+	int invert = (kcontrol->private_value >> 8) & 1;
+	hda_nid_t nid = kcontrol->private_value & 0xff;
+	unsigned int eapd;
+	eapd = ucontrol->value.integer.value[0];
+	if (invert)
+		eapd = !eapd;
+	if (eapd == spec->cur_eapd && ! codec->in_resume)
+		return 0;
+	spec->cur_eapd = eapd;
+	snd_hda_codec_write(codec, nid,
+			    0, AC_VERB_SET_EAPD_BTLENABLE,
+			    eapd ? 0x02 : 0x00);
+	return 1;
+}
+#if 0
+static int cxt_pin_mode_info(struct snd_kcontrol *kcontrol,
+			     struct snd_ctl_elem_info *uinfo)
+{
+	unsigned int item_num = uinfo->value.enumerated.item;
+	unsigned char dir = (kcontrol->private_value >> 16) & 0xff;
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count = 1;
+	uinfo->value.enumerated.items = cxt_pin_mode_n_items(dir);
+
+	if (item_num < cxt_pin_mode_min(dir) || item_num > cxt_pin_mode_max(dir))
+		item_num = cxt_pin_mode_min(dir);
+	strcpy(uinfo->value.enumerated.name, cxt_pin_mode_names[item_num]);
+	return 0;
+}
+
+static int cxt_pin_mode_get(struct snd_kcontrol *kcontrol,
+			    struct snd_ctl_elem_value *ucontrol)
+{
+	unsigned int i;
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	hda_nid_t nid = kcontrol->private_value & 0xffff;
+	unsigned char dir = (kcontrol->private_value >> 16) & 0xff;
+	long *valp = ucontrol->value.integer.value;
+	unsigned int pinctl = snd_hda_codec_read(codec, nid, 0,
+						 AC_VERB_GET_PIN_WIDGET_CONTROL,
+						 0x00);
+
+	/* Find enumerated value for current pinctl setting */
+	i = alc_pin_mode_min(dir);
+	while (alc_pin_mode_values[i] != pinctl && i <= alc_pin_mode_max(dir))
+		i++;
+	*valp = i <= alc_pin_mode_max(dir) ? i: alc_pin_mode_min(dir);
+	return 0;
+}
+
+static int cxt_pin_mode_put(struct snd_kcontrol *kcontrol,
+			    struct snd_ctl_elem_value *ucontrol)
+{
+	signed int change;
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	hda_nid_t nid = kcontrol->private_value & 0xffff;
+	unsigned char dir = (kcontrol->private_value >> 16) & 0xff;
+	long val = *ucontrol->value.integer.value;
+	unsigned int pinctl = snd_hda_codec_read(codec, nid, 0,
+						 AC_VERB_GET_PIN_WIDGET_CONTROL,
+						 0x00);
+
+	if (val < cxt_pin_mode_min(dir) || val > cxt_pin_mode_max(dir)) 
+		val = cxt_pin_mode_min(dir);
+
+	change = pinctl != cxt_pin_mode_values[val];
+	if (change) {
+		/* Set pin mode to that requested */
+		snd_hda_codec_write(codec,nid,0,AC_VERB_SET_PIN_WIDGET_CONTROL,
+				    cxt_pin_mode_values[val]);
+
+		/* Also enable the retasking pin's input/output as required 
+		 * for the requested pin mode.  Enum values of 2 or less are
+		 * input modes.
+		 *
+		 * Dynamically switching the input/output buffers probably
+		 * reduces noise slightly (particularly on input) so we'll
+		 * do it.  However, having both input and output buffers
+		 * enabled simultaneously doesn't seem to be problematic if
+		 * this turns out to be necessary in the future.
+		 */
+		if (val <= 2) {
+			snd_hda_codec_write(codec, nid, 0,
+					    AC_VERB_SET_AMP_GAIN_MUTE,
+					    AMP_OUT_MUTE);
+			snd_hda_codec_write(codec, nid, 0,
+					    AC_VERB_SET_AMP_GAIN_MUTE,
+					    AMP_IN_UNMUTE(0));
+		} else {
+			snd_hda_codec_write(codec, nid, 0,
+					    AC_VERB_SET_AMP_GAIN_MUTE,
+					    AMP_IN_MUTE(0));
+			snd_hda_codec_write(codec, nid, 0,
+					    AC_VERB_SET_AMP_GAIN_MUTE,
+					    AMP_OUT_UNMUTE);
+		}
+	}
+	return change;
+}
+#endif
+
+
+/* Conexant 5047 specific */
+
+static hda_nid_t cxt5047_dac_nids[1] = { 0x10 };
+static hda_nid_t cxt5047_adc_nids[1] = { 0x12 };
+static hda_nid_t cxt5047_capsrc_nids[1] = { 0x19 };
+
+
+/* turn on/off EAPD (+ mute HP) as a master switch */
+static int cxt5047_hp_master_sw_put(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct conexant_spec *spec = codec->spec;
+
+	if (! conexant_eapd_put(kcontrol, ucontrol))
+		return 0;
+
+	/* toggle HP mute appropriately */
+	snd_hda_codec_amp_update(codec, 0x13, 0, HDA_OUTPUT, 0,
+				 0x80, spec->cur_eapd ? 0 : 0x80);
+	snd_hda_codec_amp_update(codec, 0x13, 1, HDA_OUTPUT, 0,
+				 0x80, spec->cur_eapd ? 0 : 0x80);
+	return 1;
+}
+
+/* bind volumes of both NID 0x13 and 0x14 */
+static int cxt5047_hp_master_vol_put(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	long *valp = ucontrol->value.integer.value;
+	int change;
+
+	change = snd_hda_codec_amp_update(codec, 0x14, 0, HDA_OUTPUT, 0,
+					  0x7f, valp[0] & 0x7f);
+	change |= snd_hda_codec_amp_update(codec, 0x14, 1, HDA_OUTPUT, 0,
+					   0x7f, valp[1] & 0x7f);
+	snd_hda_codec_amp_update(codec, 0x13, 0, HDA_OUTPUT, 0,
+				 0x7f, valp[0] & 0x7f);
+	snd_hda_codec_amp_update(codec, 0x13, 1, HDA_OUTPUT, 0,
+				 0x7f, valp[1] & 0x7f);
+	return change;
+}
+
+
+/* mute internal speaker if HP is plugged */
+static void cxt5047_hp_automute(struct hda_codec *codec)
+{
+	unsigned int present;
+
+	present = snd_hda_codec_read(codec, 0x13, 0,
+				     AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
+	snd_hda_codec_amp_update(codec, 0x14, 0, HDA_OUTPUT, 0,
+				 0x80, present ? 0x80 : 0);
+	snd_hda_codec_amp_update(codec, 0x14, 1, HDA_OUTPUT, 0,
+				 0x80, present ? 0x80 : 0);
+}
+
+/* toggle input of built-in and mic jack appropriately */
+static void cxt5047_hp_automic(struct hda_codec *codec)
+{
+	static struct hda_verb mic_jack_on[] = {
+		{0x15, AC_VERB_SET_AMP_GAIN_MUTE, 0xb080},
+		{0x17, AC_VERB_SET_AMP_GAIN_MUTE, 0xb000},
+		{}
+	};
+	static struct hda_verb mic_jack_off[] = {
+		{0x17, AC_VERB_SET_AMP_GAIN_MUTE, 0xb080},
+		{0x15, AC_VERB_SET_AMP_GAIN_MUTE, 0xb000},
+		{}
+	};
+	unsigned int present;
+
+	present = snd_hda_codec_read(codec, 0x08, 0,
+			    	 AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
+	if (present)
+		snd_hda_sequence_write(codec, mic_jack_on);
+	else
+		snd_hda_sequence_write(codec, mic_jack_off);
+}
+
+/* unsolicited event for HP jack sensing */
+static void cxt5047_hp_unsol_event(struct hda_codec *codec,
+				  unsigned int res)
+{
+	res >>= 26;
+	switch (res) {
+	case CXT5047_HP_EVENT:
+		cxt5047_hp_automute(codec);
+		break;
+	case CXT5047_MIC_EVENT:
+		cxt5047_hp_automic(codec);
+		break;
+	}
+}
+
+static struct snd_kcontrol_new cxt5047_mixers[] = {
+	{
+	  .iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	  .name = "Capture Source",
+	  .info = conexant_mux_enum_info,
+	  .get = conexant_mux_enum_get,
+	  .put = conexant_mux_enum_put
+	},
+	HDA_CODEC_VOLUME("Mic Bypass Capture Volume",0x19,0x02,HDA_INPUT),
+	HDA_CODEC_MUTE("Mic Bypass Capture Switch",0x19,0x02,HDA_INPUT),
+	HDA_CODEC_VOLUME("Capture Volume",0x12,0x03,HDA_INPUT),
+	HDA_CODEC_MUTE("Capture Switch",0x12,0x03,HDA_INPUT),
+	HDA_CODEC_VOLUME("PCM Volume",0x10,0x00,HDA_OUTPUT),
+	HDA_CODEC_MUTE("PCM Switch",0x10,0x00,HDA_OUTPUT),
+	HDA_CODEC_VOLUME("Headphone Playback Volume",0x13,0x00,HDA_OUTPUT),
+	HDA_CODEC_MUTE("Headphone Playback Switch",0x13,0x00,HDA_OUTPUT),
+	{}
+};
+
+static struct snd_kcontrol_new cxt5047_hp_mixers[] = {
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
+		.info = conexant_eapd_info,
+		.get = conexant_eapd_get,
+		.put = cxt5047_hp_master_sw_put,
+		.private_value = 0x13,
+	},
+	HDA_CODEC_VOLUME("PCM Playback Volume", 0x10, 0x0, HDA_OUTPUT),
+	HDA_CODEC_MUTE("PCM Playback Switch", 0x10, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("Mic Boost", 0x15, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Internal Mic Boost", 0x17, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Capture Volume", 0x19, 0x0, HDA_OUTPUT),
+	HDA_CODEC_MUTE("Capture Switch", 0x19, 0x0, HDA_OUTPUT),
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Capture Source",
+		.info = conexant_mux_enum_info,
+		.get = conexant_mux_enum_get,
+		.put = conexant_mux_enum_put,
+	},
+	{ } /* end */
+};
+
+static struct hda_verb cxt5047_init_verbs[] = {
+	/* Line in, Mic, Built-in Mic */
+	{0x14, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN },
+	{0x15, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN },
+	{0x17, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN|AC_PINCTL_VREF_50 },
+	/* HP, Amp  */
+	{0x13, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT },
+	{0x1A, AC_VERB_SET_CONNECT_SEL,0x01},
+	{0x1A, AC_VERB_SET_AMP_GAIN_MUTE, AC_AMP_SET_OUTPUT|AC_AMP_SET_RIGHT|AC_AMP_SET_LEFT|0x00},
+	{0x1A, AC_VERB_SET_AMP_GAIN_MUTE, AC_AMP_SET_OUTPUT|AC_AMP_SET_RIGHT|AC_AMP_SET_LEFT|0x03},
+	/* Record selector: Front mic */
+	{0x12, AC_VERB_SET_CONNECT_SEL,0x03},
+	{0x19, AC_VERB_SET_AMP_GAIN_MUTE, AC_AMP_SET_INPUT|AC_AMP_SET_RIGHT|AC_AMP_SET_LEFT|0x17},
+	/* SPDIF route: PCM */
+	{ 0x18, AC_VERB_SET_CONNECT_SEL, 0x0 },
+	{ } /* end */
+};
+
+/* configuration for Toshiba Laptops */
+static struct hda_verb cxt5047_toshiba_init_verbs[] = {
+	{0x13, AC_VERB_SET_EAPD_BTLENABLE, 0x01 }, /* default on */
+	/* pin sensing on HP and Mic jacks */
+	{0x13, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | CXT5047_HP_EVENT},
+	{0x15, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | CXT5047_MIC_EVENT},
+	{}
+};
+
+/* configuration for HP Laptops */
+static struct hda_verb cxt5047_hp_init_verbs[] = {
+	/* pin sensing on HP and Mic jacks */
+	{0x13, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | CXT5047_HP_EVENT},
+	{0x15, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | CXT5047_MIC_EVENT},
+	{}
+};
+/* Test configuration for debugging, modelled after the ALC260 test
+ * configuration.
+ */
+#if 0
+#ifdef CONFIG_SND_DEBUG
+static struct hda_input_mux cxt5047_test_capture_sources[1] = {
+	{
+		.num_items = 6,
+		.items = {
+			{ "MIXER", 0x0 },
+			{ "LINE1 pin", 0x1 },
+			{ "MIC1 pin", 0x2 },
+			{ "MIC2 pin", 0x3 },
+			{ "CD pin", 0x4 },
+			{ "HP-OUT pin", 0x5 },
+		},
+        },
+};
+
+#define CXT_PIN_MODE(xname, nid, dir) \
+	{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, .index = 0,  \
+	  .info = cxt_pin_mode_info, \
+	  .get = cxt_pin_mode_get, \
+	  .put = cxt_pin_mode_put, \
+	  .private_value = nid | (dir<<16) }
+
+static struct snd_kcontrol_new cxt5047_test_mixer[] = {
+
+	/* Modes for retasking pin widgets */
+	CXT_PIN_MODE("HP-OUT pin mode", 0x13, ALC_PIN_DIR_INOUT),
+	CXT_PIN_MODE("LINE1 pin mode", 0x14, ALC_PIN_DIR_INOUT),
+	CXT_PIN_MODE("MIC1 pin mode", 0x15, ALC_PIN_DIR_INOUT),
+
+	/* Loopback mixer controls */
+	HDA_CODEC_VOLUME("MIC1 Playback Volume", 0x19, 0x00, HDA_INPUT),
+	HDA_CODEC_MUTE("MIC1 Playback Switch", 0x19, 0x00, HDA_INPUT),
+	HDA_CODEC_VOLUME("MIC2 Playback Volume", 0x19, 0x01, HDA_INPUT),
+	HDA_CODEC_MUTE("MIC2 Playback Switch", 0x19, 0x01, HDA_INPUT),
+	HDA_CODEC_VOLUME("LINE2 Playback Volume", 0x19, 0x03, HDA_INPUT),
+	HDA_CODEC_MUTE("LINE2 Playback Switch", 0x19, 0x03, HDA_INPUT),
+	HDA_CODEC_VOLUME("CD Playback Volume", 0x19, 0x04, HDA_INPUT),
+	HDA_CODEC_MUTE("CD Playback Switch", 0x19, 0x04, HDA_INPUT),
+	HDA_CODEC_VOLUME("Beep Playback Volume", 0x19, 0x05, HDA_INPUT),
+	HDA_CODEC_MUTE("Beep Playback Switch", 0x19, 0x05, HDA_INPUT),
+	HDA_CODEC_VOLUME("LINE-OUT loopback Playback Volume", 0x19, 0x06, HDA_INPUT),
+	HDA_CODEC_MUTE("LINE-OUT loopback Playback Switch", 0x19, 0x06, HDA_INPUT),
+	HDA_CODEC_VOLUME("HP-OUT loopback Playback Volume", 0x19, 0x7, HDA_INPUT),
+	HDA_CODEC_MUTE("HP-OUT loopback Playback Switch", 0x19, 0x7, HDA_INPUT),
+
+	/* Controls for GPIO pins, assuming they exist and are configured as outputs */
+	ALC_GPIO_DATA_SWITCH("GPIO pin 0", 0x01, 0x01),
+	ALC_GPIO_DATA_SWITCH("GPIO pin 1", 0x01, 0x02),
+	ALC_GPIO_DATA_SWITCH("GPIO pin 2", 0x01, 0x04),
+	ALC_GPIO_DATA_SWITCH("GPIO pin 3", 0x01, 0x08),
+
+	ALC_SPDIF_CTRL_SWITCH("SPDIF Playback Switch", 0x18, 0x01),
+
+	HDA_CODEC_VOLUME("Capture Volume", 0x19, 0x0, HDA_OUTPUT),
+	HDA_CODEC_MUTE("Capture Switch", 0x19, 0x0, HDA_OUTPUT),
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Input Source",
+		.info = conexant_mux_enum_info,
+		.get = conexant_mux_enum_get,
+		.put = conexant_mux_enum_put,
+	},
+
+	{ } /* end */
+};
+
+static struct hda_verb cxt5047_test_init_verbs[] = {
+	/* Enable all GPIOs as outputs with an initial value of 0 */
+	{0x01, AC_VERB_SET_GPIO_DIRECTION, 0x0f},
+	{0x01, AC_VERB_SET_GPIO_DATA, 0x00},
+	{0x01, AC_VERB_SET_GPIO_MASK, 0x0f},
+
+	/* Enable retasking pins as output, initially without power amp */
+	{0x15, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
+	{0x14, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
+	{0x13, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
+
+	/* Disable digital (SPDIF) pins initially, but users can enable
+	 * them via a mixer switch.  In the case of SPDIF-out, this initverb
+	 * payload also sets the generation to 0, output to be in "consumer"
+	 * PCM format, copyright asserted, no pre-emphasis and no validity
+	 * control.
+	 */
+	{0x18, AC_VERB_SET_DIGI_CONVERT_1, 0},
+
+	/* Ensure mic1, mic2, line1 and line2 pin widgets take input from the 
+	 * OUT1 sum bus when acting as an output.
+	 */
+	{0x1a, AC_VERB_SET_CONNECT_SEL, 0},
+	{0x1b, AC_VERB_SET_CONNECT_SEL, 0},
+
+	/* Start with output sum widgets muted and their output gains at min */
+	{0x19, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+	{0x19, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
+
+	/* Unmute retasking pin widget output buffers since the default
+	 * state appears to be output.  As the pin mode is changed by the
+	 * user the pin mode control will take care of enabling the pin's
+	 * input/output buffers as needed.
+	 */
+	{0x15, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	{0x14, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	{0x13, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+
+	/* Mute capture amp left and right */
+	{0x12, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+
+	/* Set ADC connection select to match default mixer setting (mic1
+	 * pin)
+	 */
+	{0x12, AC_VERB_SET_CONNECT_SEL, 0x00},
+
+	/* Mute all inputs to mixer widget (even unconnected ones) */
+	{0x19, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)}, /* mic1 pin */
+	{0x19, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)}, /* mic2 pin */
+	{0x19, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(2)}, /* line1 pin */
+	{0x19, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(3)}, /* line2 pin */
+	{0x19, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(4)}, /* CD pin */
+	{0x19, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(5)}, /* Beep-gen pin */
+	{0x19, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(6)}, /* Line-out pin */
+	{0x19, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(7)}, /* HP-pin pin */
+
+	{ }
+};
+#endif
+#endif
+
+
+/* initialize jack-sensing, too */
+static int cxt5047_hp_init(struct hda_codec *codec)
+{
+	conexant_init(codec);
+	cxt5047_hp_automute(codec);
+	cxt5047_hp_automic(codec);
+	return 0;
+}
+
+
+enum {  CXT5047_LAPTOP,
+#ifdef CONFIG_SND_DEBUG
+	CXT5047_TEST,
+#endif
+	CXT5047_LAPTOP_EAPD };
+
+static struct hda_board_config cxt5047_cfg_tbl[] = {
+	/* Laptops w/o EAPD support */
+	{ .modelname = "laptop", .config = CXT5047_LAPTOP },
+	{ .pci_subvendor = 0x103c, .pci_subdevice = 0x30a0, 
+	  .config = CXT5047_LAPTOP }, /*HP DV1000 */
+	{ .pci_subvendor = 0x103c, .pci_subdevice = 0x30b2,
+	  .config = CXT5047_LAPTOP }, /*HP DV2000T */
+	{ .pci_subvendor = 0x103c, .pci_subdevice = 0x30a5,
+	  .config = CXT5047_LAPTOP }, /*HP DV8000 */
+	/* Laptops with EAPD support */
+	{ .modelname = "laptop-eapd", .config = CXT5047_LAPTOP_EAPD },
+	{ .pci_subvendor = 0x1179, .pci_subdevice = 0xff31,
+	  .config = CXT5047_LAPTOP_EAPD }, /* Toshiba P100 */
+#if 0	
+#ifdef CONFIG_SND_DEBUG
+	{ .modelname = "test", .config = CXT5047_TEST },
+#endif
+#endif
+	
+	{}
+};
+
+static int patch_cxt5047(struct hda_codec *codec) {
+	struct conexant_spec *spec;
+	int board_config;
+
+	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
+	if ( !spec )
+		return -ENOMEM;
+	mutex_init(&spec->amp_mutex);
+	codec->spec = spec;
+
+	spec->multiout.max_channels = 2;
+	spec->multiout.num_dacs = ARRAY_SIZE(cxt5047_dac_nids);
+	spec->multiout.dac_nids = cxt5047_dac_nids;
+	spec->multiout.dig_out_nid = SPDIF_OUT;
+	spec->num_adc_nids = 1;
+	spec->adc_nids = cxt5047_adc_nids;
+	spec->capsrc_nids = cxt5047_capsrc_nids;
+	spec->input_mux = &conexant_capture_source;
+	spec->num_mixers = 1;
+	spec->mixers[0] = cxt5047_mixers;
+	spec->num_init_verbs = 1;
+	spec->init_verbs[0] = cxt5047_init_verbs;
+	spec->spdif_route = 0;
+
+	codec->patch_ops = conexant_patch_ops;
+	codec->patch_ops.unsol_event = cxt5047_hp_unsol_event;
+	/* Place holder for different board configurations */
+	board_config = snd_hda_check_board_config(codec, cxt5047_cfg_tbl);
+	switch (board_config) {
+	case CXT5047_LAPTOP:
+		spec->num_init_verbs = 2;
+		spec->init_verbs[1] = cxt5047_hp_init_verbs;
+
+		codec->patch_ops.init = cxt5047_hp_init;
+		break;
+	case CXT5047_LAPTOP_EAPD:
+		spec->num_init_verbs = 2;
+		spec->init_verbs[1] = cxt5047_toshiba_init_verbs;
+		break;
+	}
+#if 0	
+#ifdef CONFIG_SND_DEBUG
+	case CXT5047_TEST:
+		spec->input_mux = cxt5047_test_capture_sources;
+		spec->mixers[0] = cxt5047_test_mixer;
+		spec->init_verbs[0] = cxt5047_test_init_verbs;
+#endif	
+#endif	
+	return 0;
+}
+
+struct hda_codec_preset snd_hda_preset_conexant[] = {
+	{ .id = 0x14f15047, .name = "CXT5047", .patch = patch_cxt5047 },
+	{} /* terminator */
+};

--=-N/wUnDv34yI+HyLuH56S
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--=-N/wUnDv34yI+HyLuH56S
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-N/wUnDv34yI+HyLuH56S--
