From: Rander Wang <rander.wang@linux.intel.com>
Subject: [PATCH] ASoC:hdac_hda: use correct format to setup hda
	codec
Date: Mon, 25 Feb 2019 15:48:45 +0800
Message-ID: <20190225074845.73950-1-rander.wang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 55348F8961F
 for <alsa-devel@alsa-project.org>; Mon, 25 Feb 2019 08:46:53 +0100 (CET)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com, Rander Wang <rander.wang@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The current implementation of the hdac_hda codec results in zero-valued
samples on capture and noise with headset playback when SOF is used on
platforms with an on-board HDaudio codec. This is root-caused to SOF
using be_hw_params_fixup, and the prepare() call using invalid runtime
fields to determine the format.

This patch moves the format handling to the hw_params() callback, as
done already for hdac_hdmi, to make sure the fixed-up information is
taken into account but keeps the codec initialization in prepare() as
the stream_tag is only available at that time. Moving everything in the
prepare() callback is possible but the code is less elegant so this
two-step solution was chosen.

The solution was tested with the SST driver with no regressions, and all
the issues with SOF playback and capture are solved.

Signed-off-by: Rander Wang <rander.wang@linux.intel.com>
---
 sound/soc/codecs/hdac_hda.c | 53 +++++++++++++++++++++++++++++++++------------
 sound/soc/codecs/hdac_hda.h |  1 +
 2 files changed, 40 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/hdac_hda.c b/sound/soc/codecs/hdac_hda.c
index ffecdaaa8cf2..f889d94c8e3c 100644
--- a/sound/soc/codecs/hdac_hda.c
+++ b/sound/soc/codecs/hdac_hda.c
@@ -38,6 +38,9 @@ static void hdac_hda_dai_close(struct snd_pcm_substream *substream,
 			       struct snd_soc_dai *dai);
 static int hdac_hda_dai_prepare(struct snd_pcm_substream *substream,
 				struct snd_soc_dai *dai);
+static int hdac_hda_dai_hw_params(struct snd_pcm_substream *substream,
+				  struct snd_pcm_hw_params *params,
+				  struct snd_soc_dai *dai);
 static int hdac_hda_dai_hw_free(struct snd_pcm_substream *substream,
 				struct snd_soc_dai *dai);
 static int hdac_hda_dai_set_tdm_slot(struct snd_soc_dai *dai,
@@ -50,6 +53,7 @@ static const struct snd_soc_dai_ops hdac_hda_dai_ops = {
 	.startup = hdac_hda_dai_open,
 	.shutdown = hdac_hda_dai_close,
 	.prepare = hdac_hda_dai_prepare,
+	.hw_params = hdac_hda_dai_hw_params,
 	.hw_free = hdac_hda_dai_hw_free,
 	.set_tdm_slot = hdac_hda_dai_set_tdm_slot,
 };
@@ -139,6 +143,39 @@ static int hdac_hda_dai_set_tdm_slot(struct snd_soc_dai *dai,
 	return 0;
 }
 
+static int hdac_hda_dai_hw_params(struct snd_pcm_substream *substream,
+				  struct snd_pcm_hw_params *params,
+				  struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *component = dai->component;
+	struct hdac_hda_priv *hda_pvt;
+	unsigned int format_val;
+	unsigned int maxbps;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		maxbps = dai->driver->playback.sig_bits;
+	else
+		maxbps = dai->driver->capture.sig_bits;
+
+	hda_pvt = snd_soc_component_get_drvdata(component);
+	format_val = snd_hdac_calc_stream_format(params_rate(params),
+						 params_channels(params),
+						 params_format(params),
+						 maxbps,
+						 0);
+	if (!format_val) {
+		dev_err(dai->dev,
+			"invalid format_val, rate=%d, ch=%d, format=%d, maxbps=%d\n",
+			params_rate(params), params_channels(params),
+			params_format(params), maxbps);
+
+		return -EINVAL;
+	}
+
+	hda_pvt->pcm[dai->id].format_val[substream->stream] = format_val;
+	return 0;
+}
+
 static int hdac_hda_dai_hw_free(struct snd_pcm_substream *substream,
 				struct snd_soc_dai *dai)
 {
@@ -162,10 +199,9 @@ static int hdac_hda_dai_prepare(struct snd_pcm_substream *substream,
 				struct snd_soc_dai *dai)
 {
 	struct snd_soc_component *component = dai->component;
+	struct hda_pcm_stream *hda_stream;
 	struct hdac_hda_priv *hda_pvt;
-	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct hdac_device *hdev;
-	struct hda_pcm_stream *hda_stream;
 	unsigned int format_val;
 	struct hda_pcm *pcm;
 	unsigned int stream;
@@ -179,19 +215,8 @@ static int hdac_hda_dai_prepare(struct snd_pcm_substream *substream,
 
 	hda_stream = &pcm->stream[substream->stream];
 
-	format_val = snd_hdac_calc_stream_format(runtime->rate,
-						 runtime->channels,
-						 runtime->format,
-						 hda_stream->maxbps,
-						 0);
-	if (!format_val) {
-		dev_err(&hdev->dev,
-			"invalid format_val, rate=%d, ch=%d, format=%d\n",
-			runtime->rate, runtime->channels, runtime->format);
-		return -EINVAL;
-	}
-
 	stream = hda_pvt->pcm[dai->id].stream_tag[substream->stream];
+	format_val = hda_pvt->pcm[dai->id].format_val[substream->stream];
 
 	ret = snd_hda_codec_prepare(&hda_pvt->codec, hda_stream,
 				    stream, format_val, substream);
diff --git a/sound/soc/codecs/hdac_hda.h b/sound/soc/codecs/hdac_hda.h
index e444ef593360..6b1bd4f428e7 100644
--- a/sound/soc/codecs/hdac_hda.h
+++ b/sound/soc/codecs/hdac_hda.h
@@ -8,6 +8,7 @@
 
 struct hdac_hda_pcm {
 	int stream_tag[2];
+	unsigned int format_val[2];
 };
 
 struct hdac_hda_priv {
-- 
2.14.1
