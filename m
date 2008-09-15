From: Harald Welte <HaraldWelte@viatech.com>
Subject: [PATCH 2/3] HDA VIA: Fix 2nd S/PDIF out function
Date: Mon, 15 Sep 2008 22:42:26 +0800
Message-ID: <20080915144226.GC8061@prithivi.gnumonks.org>
References: <20080915144005.GA8061@prithivi.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 26CBA24131
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Sep 2008 16:43:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080915144005.GA8061@prithivi.gnumonks.org>
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
Cc: Takashi Iwai <tiwai@suse.de>, Logan Li <loganli@viatech.com.cn>
List-Id: alsa-devel@alsa-project.org

[ALSA] HDA VIA: Fix 2nd S/PDIF out function

As it seems, the recently-sent patch for the 2nd S/PDIF (HDMI) output
is not working with alsa-kernel 1.0.18rc3.

This patch makes it work by
* activating the second S/PDIF output pin in the pin config
* consolidating the dig_playback_pcm_prepare() with extra_dig_pcm_prepare()
  functions
* remove the need for an extra hda_pcm_stream structure and rather represents
  the second digital output as substream within the primary S/PDIF digital out
  stream.

Signed-off-by: Logan Li <LoganLi@viatech.com.cn>
Signed-off-by: Harald Welte <HaraldWelte@viatech.com>

--- a/sound/pci/hda/patch_via.c	2008-09-10 00:55:25.000000000 +0800
+++ b/sound/pci/hda/patch_via.c	2008-09-12 14:58:32.000000000 +0800
@@ -123,7 +123,6 @@
 	char *stream_name_digital;
 	struct hda_pcm_stream *stream_digital_playback;
 	struct hda_pcm_stream *stream_digital_capture;
-	struct hda_pcm_stream *stream_extra_digital_playback;
 
 	/* playback */
 	struct hda_multi_out multiout;
@@ -656,17 +655,6 @@
 	return snd_hda_multi_out_dig_close(codec, &spec->multiout);
 }
 
-static int via_dig_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
-					struct hda_codec *codec,
-					unsigned int stream_tag,
-					unsigned int format,
-					struct snd_pcm_substream *substream)
-{
-	struct via_spec *spec = codec->spec;
-	return snd_hda_multi_out_dig_prepare(codec, &spec->multiout,
-					     stream_tag, format, substream);
-}
-
 /* setup SPDIF output stream */
 static void setup_dig_playback_stream(struct hda_codec *codec, hda_nid_t nid,
 				 unsigned int stream_tag, unsigned int format)
@@ -682,17 +670,25 @@
 				    codec->spdif_ctls & 0xff);
 }
 
-static int via_extra_dig_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
+static int via_dig_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
 					struct hda_codec *codec,
 					unsigned int stream_tag,
 					unsigned int format,
 					struct snd_pcm_substream *substream)
 {
 	struct via_spec *spec = codec->spec;
+	hda_nid_t nid;
+
+	/* 1st or 2nd S/PDIF */
+	if (substream->number == 0)
+		nid = spec->multiout.dig_out_nid;
+	else if (substream->number == 1)
+		nid = spec->extra_dig_out_nid;
+	else
+		return -1;
 
 	mutex_lock(&codec->spdif_mutex);
-	setup_dig_playback_stream(codec, spec->extra_dig_out_nid, stream_tag,
-				  format);
+	setup_dig_playback_stream(codec, nid, stream_tag, format);
 	mutex_unlock(&codec->spdif_mutex);
 	return 0;
 }
@@ -854,17 +850,6 @@
 		}
 	}
 
-	if (spec->extra_dig_out_nid) {
-		codec->num_pcms++;
-		info++;
-		info->name = spec->stream_name_digital;
-		info->pcm_type = HDA_PCM_TYPE_HDMI;
-		info->stream[SNDRV_PCM_STREAM_PLAYBACK] =
-				*(spec->stream_extra_digital_playback);
-		info->stream[SNDRV_PCM_STREAM_PLAYBACK].nid =
-				spec->extra_dig_out_nid;
-	}
-
 	return 0;
 }
 
@@ -957,6 +942,10 @@
 		via_gpio_control(codec);
 }
 
+static hda_nid_t slave_dig_outs[] = {
+	0,
+};
+
 static int via_init(struct hda_codec *codec)
 {
 	struct via_spec *spec = codec->spec;
@@ -991,6 +980,9 @@
 		snd_hda_codec_write(codec, spec->autocfg.dig_in_pin, 0,
 				    AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN);
 
+	/* no slave outs */
+	codec->slave_dig_outs = slave_dig_outs;
+
  	return 0;
 }
 
@@ -2477,8 +2469,9 @@
 
 	/* Setup default input of PW4 to MW0 */
 	{0x1d, AC_VERB_SET_CONNECT_SEL, 0x0},
-	/* PW9 Output enable */
+	/* PW9, PW10  Output enable */
 	{0x20, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x40},
+	{0x21, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x40},
 	{ }
 };
 
@@ -2511,7 +2504,7 @@
 };
 
 static struct hda_pcm_stream vt1708S_pcm_digital_playback = {
-	.substreams = 1,
+	.substreams = 2,
 	.channels_min = 2,
 	.channels_max = 2,
 	/* NID is set in via_build_pcms */
@@ -2522,16 +2515,6 @@
 	},
 };
 
-static struct hda_pcm_stream vt1708S_pcm_extra_digital_playback = {
-	.substreams = 1,
-	.channels_min = 2,
-	.channels_max = 2,
-	/* NID is set in via_build_pcms */
-	.ops = {
-		.prepare = via_extra_dig_playback_pcm_prepare
-	},
-};
-
 /* fill in the dac_nids table from the parsed pin configuration */
 static int vt1708S_auto_fill_dac_nids(struct via_spec *spec,
 				     const struct auto_pin_cfg *cfg)
@@ -2822,8 +2805,6 @@
 
 	spec->stream_name_digital = "VT1708S Digital";
 	spec->stream_digital_playback = &vt1708S_pcm_digital_playback;
-	spec->stream_extra_digital_playback =
-					&vt1708S_pcm_extra_digital_playback;
 
 	if (!spec->adc_nids && spec->input_mux) {
 		spec->adc_nids = vt1708S_adc_nids;
@@ -2927,7 +2908,7 @@
 };
 
 static struct hda_pcm_stream vt1702_pcm_digital_playback = {
-	.substreams = 1,
+	.substreams = 2,
 	.channels_min = 2,
 	.channels_max = 2,
 	/* NID is set in via_build_pcms */
@@ -2938,16 +2919,6 @@
 	},
 };
 
-static struct hda_pcm_stream vt1702_pcm_extra_digital_playback = {
-	.substreams = 1,
-	.channels_min = 2,
-	.channels_max = 2,
-	/* NID is set in via_build_pcms */
-	.ops = {
-		.prepare = via_extra_dig_playback_pcm_prepare
-	},
-};
-
 /* fill in the dac_nids table from the parsed pin configuration */
 static int vt1702_auto_fill_dac_nids(struct via_spec *spec,
 				     const struct auto_pin_cfg *cfg)
@@ -3155,8 +3126,6 @@
 
 	spec->stream_name_digital = "VT1702 Digital";
 	spec->stream_digital_playback = &vt1702_pcm_digital_playback;
-	spec->stream_extra_digital_playback =
-					&vt1702_pcm_extra_digital_playback;
 
 	if (!spec->adc_nids && spec->input_mux) {
 		spec->adc_nids = vt1702_adc_nids;

-- 
- Harald Welte <HaraldWelte@viatech.com>	    http://linux.via.com.tw/
============================================================================
VIA Open Source Liaison
