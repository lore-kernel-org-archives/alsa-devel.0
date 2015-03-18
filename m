From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/4] ALSA: hda - Simplify PCM setup overrides
Date: Wed, 18 Mar 2015 09:50:55 +0100
Message-ID: <1426668658-15911-2-git-send-email-tiwai@suse.de>
References: <1426668658-15911-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5BF382604F3
 for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2015 09:51:01 +0100 (CET)
In-Reply-To: <1426668658-15911-1-git-send-email-tiwai@suse.de>
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
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

This patch does two things:
- code refactoring with a local helper function,
- allow codec drivers to provide the specific PCM stream info pointers
  only for overriding the non-NULL entries, instead of copying the
  whole.

This simplifies the codec driver side (currently the only user is
alc269's 44kHz fixed rate).

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c   | 110 +++++++++++++++++++++++-------------------
 sound/pci/hda/patch_realtek.c |  41 ----------------
 2 files changed, 60 insertions(+), 91 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index ebdbc023583d..27ce54701f0f 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -5137,6 +5137,33 @@ static void fill_pcm_stream_name(char *str, size_t len, const char *sfx,
 	strlcat(str, sfx, len);
 }
 
+/* copy PCM stream info from @default_str, and override non-NULL entries
+ * from @spec_str and @nid
+ */
+static void setup_pcm_stream(struct hda_pcm_stream *str,
+			     const struct hda_pcm_stream *default_str,
+			     const struct hda_pcm_stream *spec_str,
+			     hda_nid_t nid)
+{
+	*str = *default_str;
+	if (nid)
+		str->nid = nid;
+	if (spec_str) {
+		if (spec_str->substreams)
+			str->substreams = spec_str->substreams;
+		if (spec_str->channels_min)
+			str->channels_min = spec_str->channels_min;
+		if (spec_str->channels_max)
+			str->channels_max = spec_str->channels_max;
+		if (spec_str->rates)
+			str->rates = spec_str->rates;
+		if (spec_str->formats)
+			str->formats = spec_str->formats;
+		if (spec_str->maxbps)
+			str->maxbps = spec_str->maxbps;
+	}
+}
+
 /**
  * snd_hda_gen_build_pcms - build PCM streams based on the parsed results
  * @codec: the HDA codec
@@ -5147,7 +5174,6 @@ int snd_hda_gen_build_pcms(struct hda_codec *codec)
 {
 	struct hda_gen_spec *spec = codec->spec;
 	struct hda_pcm *info;
-	const struct hda_pcm_stream *p;
 	bool have_multi_adcs;
 
 	if (spec->no_analog)
@@ -5162,11 +5188,10 @@ int snd_hda_gen_build_pcms(struct hda_codec *codec)
 	spec->pcm_rec[0] = info;
 
 	if (spec->multiout.num_dacs > 0) {
-		p = spec->stream_analog_playback;
-		if (!p)
-			p = &pcm_analog_playback;
-		info->stream[SNDRV_PCM_STREAM_PLAYBACK] = *p;
-		info->stream[SNDRV_PCM_STREAM_PLAYBACK].nid = spec->multiout.dac_nids[0];
+		setup_pcm_stream(&info->stream[SNDRV_PCM_STREAM_PLAYBACK],
+				 &pcm_analog_playback,
+				 spec->stream_analog_playback,
+				 spec->multiout.dac_nids[0]);
 		info->stream[SNDRV_PCM_STREAM_PLAYBACK].channels_max =
 			spec->multiout.max_channels;
 		if (spec->autocfg.line_out_type == AUTO_PIN_SPEAKER_OUT &&
@@ -5175,15 +5200,11 @@ int snd_hda_gen_build_pcms(struct hda_codec *codec)
 				snd_pcm_2_1_chmaps;
 	}
 	if (spec->num_adc_nids) {
-		p = spec->stream_analog_capture;
-		if (!p) {
-			if (spec->dyn_adc_switch)
-				p = &dyn_adc_pcm_analog_capture;
-			else
-				p = &pcm_analog_capture;
-		}
-		info->stream[SNDRV_PCM_STREAM_CAPTURE] = *p;
-		info->stream[SNDRV_PCM_STREAM_CAPTURE].nid = spec->adc_nids[0];
+		setup_pcm_stream(&info->stream[SNDRV_PCM_STREAM_CAPTURE],
+				 (spec->dyn_adc_switch ?
+				  &dyn_adc_pcm_analog_capture : &pcm_analog_capture),
+				 spec->stream_analog_capture,
+				 spec->adc_nids[0]);
 	}
 
  skip_analog:
@@ -5202,20 +5223,16 @@ int snd_hda_gen_build_pcms(struct hda_codec *codec)
 			info->pcm_type = spec->dig_out_type;
 		else
 			info->pcm_type = HDA_PCM_TYPE_SPDIF;
-		if (spec->multiout.dig_out_nid) {
-			p = spec->stream_digital_playback;
-			if (!p)
-				p = &pcm_digital_playback;
-			info->stream[SNDRV_PCM_STREAM_PLAYBACK] = *p;
-			info->stream[SNDRV_PCM_STREAM_PLAYBACK].nid = spec->multiout.dig_out_nid;
-		}
-		if (spec->dig_in_nid) {
-			p = spec->stream_digital_capture;
-			if (!p)
-				p = &pcm_digital_capture;
-			info->stream[SNDRV_PCM_STREAM_CAPTURE] = *p;
-			info->stream[SNDRV_PCM_STREAM_CAPTURE].nid = spec->dig_in_nid;
-		}
+		if (spec->multiout.dig_out_nid)
+			setup_pcm_stream(&info->stream[SNDRV_PCM_STREAM_PLAYBACK],
+					 &pcm_digital_playback,
+					 spec->stream_digital_playback,
+					 spec->multiout.dig_out_nid);
+		if (spec->dig_in_nid)
+			setup_pcm_stream(&info->stream[SNDRV_PCM_STREAM_CAPTURE],
+					 &pcm_digital_capture,
+					 spec->stream_digital_capture,
+					 spec->dig_in_nid);
 	}
 
 	if (spec->no_analog)
@@ -5236,31 +5253,24 @@ int snd_hda_gen_build_pcms(struct hda_codec *codec)
 		if (!info)
 			return -ENOMEM;
 		spec->pcm_rec[2] = info;
-		if (spec->alt_dac_nid) {
-			p = spec->stream_analog_alt_playback;
-			if (!p)
-				p = &pcm_analog_alt_playback;
-			info->stream[SNDRV_PCM_STREAM_PLAYBACK] = *p;
-			info->stream[SNDRV_PCM_STREAM_PLAYBACK].nid =
-				spec->alt_dac_nid;
-		} else {
-			info->stream[SNDRV_PCM_STREAM_PLAYBACK] =
-				pcm_null_stream;
-			info->stream[SNDRV_PCM_STREAM_PLAYBACK].nid = 0;
-		}
+		if (spec->alt_dac_nid)
+			setup_pcm_stream(&info->stream[SNDRV_PCM_STREAM_PLAYBACK],
+					 &pcm_analog_alt_playback,
+					 spec->stream_analog_alt_playback,
+					 spec->alt_dac_nid);
+		else
+			setup_pcm_stream(&info->stream[SNDRV_PCM_STREAM_PLAYBACK],
+					 &pcm_null_stream, NULL, 0);
 		if (have_multi_adcs) {
-			p = spec->stream_analog_alt_capture;
-			if (!p)
-				p = &pcm_analog_alt_capture;
-			info->stream[SNDRV_PCM_STREAM_CAPTURE] = *p;
-			info->stream[SNDRV_PCM_STREAM_CAPTURE].nid =
-				spec->adc_nids[1];
+			setup_pcm_stream(&info->stream[SNDRV_PCM_STREAM_CAPTURE],
+					 &pcm_analog_alt_capture,
+					 spec->stream_analog_alt_capture,
+					 spec->adc_nids[1]);
 			info->stream[SNDRV_PCM_STREAM_CAPTURE].substreams =
 				spec->num_adc_nids - 1;
 		} else {
-			info->stream[SNDRV_PCM_STREAM_CAPTURE] =
-				pcm_null_stream;
-			info->stream[SNDRV_PCM_STREAM_CAPTURE].nid = 0;
+			setup_pcm_stream(&info->stream[SNDRV_PCM_STREAM_CAPTURE],
+					 &pcm_null_stream, NULL, 0);
 		}
 	}
 
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 2a61bda8115d..124eacf67fc4 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2602,53 +2602,12 @@ static int patch_alc268(struct hda_codec *codec)
  * ALC269
  */
 
-static int playback_pcm_open(struct hda_pcm_stream *hinfo,
-			     struct hda_codec *codec,
-			     struct snd_pcm_substream *substream)
-{
-	struct hda_gen_spec *spec = codec->spec;
-	return snd_hda_multi_out_analog_open(codec, &spec->multiout, substream,
-					     hinfo);
-}
-
-static int playback_pcm_prepare(struct hda_pcm_stream *hinfo,
-				struct hda_codec *codec,
-				unsigned int stream_tag,
-				unsigned int format,
-				struct snd_pcm_substream *substream)
-{
-	struct hda_gen_spec *spec = codec->spec;
-	return snd_hda_multi_out_analog_prepare(codec, &spec->multiout,
-						stream_tag, format, substream);
-}
-
-static int playback_pcm_cleanup(struct hda_pcm_stream *hinfo,
-				struct hda_codec *codec,
-				struct snd_pcm_substream *substream)
-{
-	struct hda_gen_spec *spec = codec->spec;
-	return snd_hda_multi_out_analog_cleanup(codec, &spec->multiout);
-}
-
 static const struct hda_pcm_stream alc269_44k_pcm_analog_playback = {
-	.substreams = 1,
-	.channels_min = 2,
-	.channels_max = 8,
 	.rates = SNDRV_PCM_RATE_44100, /* fixed rate */
-	/* NID is set in alc_build_pcms */
-	.ops = {
-		.open = playback_pcm_open,
-		.prepare = playback_pcm_prepare,
-		.cleanup = playback_pcm_cleanup
-	},
 };
 
 static const struct hda_pcm_stream alc269_44k_pcm_analog_capture = {
-	.substreams = 1,
-	.channels_min = 2,
-	.channels_max = 2,
 	.rates = SNDRV_PCM_RATE_44100, /* fixed rate */
-	/* NID is set in alc_build_pcms */
 };
 
 /* different alc269-variants */
-- 
2.3.3
