From: Ian Minett <ian_minett@creativelabs.com>
Subject: [PATCHv2 4/9] ALSA: CA0132: Add PCM enhancements
Date: Thu, 20 Dec 2012 18:53:36 -0800
Message-ID: <1356058421-2683-5-git-send-email-ian_minett@creativelabs.com>
References: <1356058421-2683-1-git-send-email-ian_minett@creativelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1356058421-2683-1-git-send-email-ian_minett@creativelabs.com>
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

Remove the playback PCM open callback.
PCM stream setup and cleanup functions are added for use by PCM callbacks.
Delay stream cleanup if effects are on, to allow time for any effects tail to
finish.
Add the analog capture PCM callbacks.
Change the max channels of analog playback to 6.
Add two new PCMs: AMic2 and What-U-Hear.

Signed-off-by: Ian Minett <ian_minett@creativelabs.com>

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 91c4a50..748fca7 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -2630,17 +2630,62 @@ static bool dspload_wait_loaded(struct hda_codec *codec)
 	CA0132_CODEC_MUTE_MONO(xname, nid, 3, dir)
 
 /*
+ * PCM stuffs
+ */
+static void ca0132_setup_stream(struct hda_codec *codec, hda_nid_t nid,
+				 u32 stream_tag,
+				 int channel_id, int format)
+{
+	unsigned int oldval, newval;
+
+	if (!nid)
+		return;
+
+	snd_printdd(
+		   "ca0132_setup_stream: NID=0x%x, stream=0x%x, "
+		   "channel=%d, format=0x%x\n",
+		   nid, stream_tag, channel_id, format);
+
+	/* update the format-id if changed */
+	oldval = snd_hda_codec_read(codec, nid, 0,
+				    AC_VERB_GET_STREAM_FORMAT,
+				    0);
+	if (oldval != format) {
+		msleep(20);
+		snd_hda_codec_write(codec, nid, 0,
+				    AC_VERB_SET_STREAM_FORMAT,
+				    format);
+	}
+
+	oldval = snd_hda_codec_read(codec, nid, 0, AC_VERB_GET_CONV, 0);
+	newval = (stream_tag << 4) | channel_id;
+	if (oldval != newval) {
+		snd_hda_codec_write(codec, nid, 0,
+				    AC_VERB_SET_CHANNEL_STREAMID,
+				    newval);
+	}
+}
+
+static void ca0132_cleanup_stream(struct hda_codec *codec, hda_nid_t nid)
+{
+	unsigned int val;
+
+	if (!nid)
+		return;
+
+	snd_printdd(KERN_INFO "ca0132_cleanup_stream: NID=0x%x\n", nid);
+
+	val = snd_hda_codec_read(codec, nid, 0, AC_VERB_GET_CONV, 0);
+	if (!val)
+		return;
+
+	snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_STREAM_FORMAT, 0);
+	snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_CHANNEL_STREAMID, 0);
+}
+
+/*
  * PCM callbacks
  */
-static int ca0132_playback_pcm_open(struct hda_pcm_stream *hinfo,
-				    struct hda_codec *codec,
-				    struct snd_pcm_substream *substream)
-{
-	struct ca0132_spec *spec = codec->spec;
-	return snd_hda_multi_out_analog_open(codec, &spec->multiout, substream,
-					     hinfo);
-}
-
 static int ca0132_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
 			struct hda_codec *codec,
 			unsigned int stream_tag,
@@ -2648,8 +2693,10 @@ static int ca0132_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
 			struct snd_pcm_substream *substream)
 {
 	struct ca0132_spec *spec = codec->spec;
-	return snd_hda_multi_out_analog_prepare(codec, &spec->multiout,
-						stream_tag, format, substream);
+
+	ca0132_setup_stream(codec, spec->dacs[0], stream_tag, 0, format);
+
+	return 0;
 }
 
 static int ca0132_playback_pcm_cleanup(struct hda_pcm_stream *hinfo,
@@ -2657,7 +2704,18 @@ static int ca0132_playback_pcm_cleanup(struct hda_pcm_stream *hinfo,
 			struct snd_pcm_substream *substream)
 {
 	struct ca0132_spec *spec = codec->spec;
-	return snd_hda_multi_out_analog_cleanup(codec, &spec->multiout);
+
+	if (spec->dsp_state == DSP_DOWNLOADING)
+		return 0;
+
+	/*If Playback effects are on, allow stream some time to flush
+	 *effects tail*/
+	if (spec->effects_switch[PLAY_ENHANCEMENT - EFFECT_START_NID])
+		msleep(50);
+
+	ca0132_cleanup_stream(codec, spec->dacs[0]);
+
+	return 0;
 }
 
 /*
@@ -2699,6 +2757,36 @@ static int ca0132_dig_playback_pcm_close(struct hda_pcm_stream *hinfo,
 }
 
 /*
+ * Analog capture
+ */
+static int ca0132_capture_pcm_prepare(struct hda_pcm_stream *hinfo,
+					struct hda_codec *codec,
+					unsigned int stream_tag,
+					unsigned int format,
+					struct snd_pcm_substream *substream)
+{
+	struct ca0132_spec *spec = codec->spec;
+
+	ca0132_setup_stream(codec, spec->adcs[substream->number],
+			    stream_tag, 0, format);
+
+	return 0;
+}
+
+static int ca0132_capture_pcm_cleanup(struct hda_pcm_stream *hinfo,
+			struct hda_codec *codec,
+			struct snd_pcm_substream *substream)
+{
+	struct ca0132_spec *spec = codec->spec;
+
+	if (spec->dsp_state == DSP_DOWNLOADING)
+		return 0;
+
+	ca0132_cleanup_stream(codec, hinfo->nid);
+	return 0;
+}
+
+/*
  * Select the active output.
  * If autodetect is enabled, output will be selected based on jack detection.
  * If jack inserted, headphone will be selected, else built-in speakers
@@ -3509,9 +3597,8 @@ static struct snd_kcontrol_new ca0132_mixer[] = {
 static struct hda_pcm_stream ca0132_pcm_analog_playback = {
 	.substreams = 1,
 	.channels_min = 2,
-	.channels_max = 2,
+	.channels_max = 6,
 	.ops = {
-		.open = ca0132_playback_pcm_open,
 		.prepare = ca0132_playback_pcm_prepare,
 		.cleanup = ca0132_playback_pcm_cleanup
 	},
@@ -3521,6 +3608,10 @@ static struct hda_pcm_stream ca0132_pcm_analog_capture = {
 	.substreams = 1,
 	.channels_min = 2,
 	.channels_max = 2,
+	.ops = {
+		.prepare = ca0132_capture_pcm_prepare,
+		.cleanup = ca0132_capture_pcm_cleanup
+	},
 };
 
 static struct hda_pcm_stream ca0132_pcm_digital_playback = {
@@ -3555,10 +3646,24 @@ static int ca0132_build_pcms(struct hda_codec *codec)
 	info->stream[SNDRV_PCM_STREAM_PLAYBACK].channels_max =
 		spec->multiout.max_channels;
 	info->stream[SNDRV_PCM_STREAM_CAPTURE] = ca0132_pcm_analog_capture;
-	info->stream[SNDRV_PCM_STREAM_CAPTURE].substreams = spec->num_inputs;
+	info->stream[SNDRV_PCM_STREAM_CAPTURE].substreams = 1;
 	info->stream[SNDRV_PCM_STREAM_CAPTURE].nid = spec->adcs[0];
 	codec->num_pcms++;
 
+	info++;
+	info->name = "CA0132 Analog Mic-In2";
+	info->stream[SNDRV_PCM_STREAM_CAPTURE] = ca0132_pcm_analog_capture;
+	info->stream[SNDRV_PCM_STREAM_CAPTURE].substreams = 1;
+	info->stream[SNDRV_PCM_STREAM_CAPTURE].nid = spec->adcs[1];
+	codec->num_pcms++;
+
+	info++;
+	info->name = "CA0132 What U Hear";
+	info->stream[SNDRV_PCM_STREAM_CAPTURE] = ca0132_pcm_analog_capture;
+	info->stream[SNDRV_PCM_STREAM_CAPTURE].substreams = 1;
+	info->stream[SNDRV_PCM_STREAM_CAPTURE].nid = spec->adcs[2];
+	codec->num_pcms++;
+
 	if (!spec->dig_out && !spec->dig_in)
 		return 0;
 
-- 
1.7.4.1
