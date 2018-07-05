From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 2/2] ASoC: dpcm: add rate merge to the BE stream merge
Date: Thu,  5 Jul 2018 12:13:49 +0200
Message-ID: <20180705101349.7520-3-jbrunet@baylibre.com>
References: <20180705101349.7520-1-jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180705101349.7520-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

As done for format and channels, add the possibility to merge
the backend rates on the frontend rates.

This useful if the backend does not support all rates supported by the
frontend, or if several backends (cpu and codecs) with different
capabilities are connected to the same frontend.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 include/sound/soc.h |  2 ++
 sound/soc/soc-pcm.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 870ba6b64817..a4915148f739 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -964,6 +964,8 @@ struct snd_soc_dai_link {
 	unsigned int dpcm_merged_format:1;
 	/* DPCM used FE & BE merged channel */
 	unsigned int dpcm_merged_chan:1;
+	/* DPCM used FE & BE merged rate */
+	unsigned int dpcm_merged_rate:1;
 
 	/* pmdown_time is ignored at stop */
 	unsigned int ignore_pmdown_time:1;
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 54141a69b6b0..98be04b543ae 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1777,6 +1777,64 @@ static void dpcm_runtime_merge_chan(struct snd_pcm_substream *substream,
 	}
 }
 
+static void dpcm_runtime_merge_rate(struct snd_pcm_substream *substream,
+				    unsigned int *rates,
+				    unsigned int *rate_min,
+				    unsigned int *rate_max)
+{
+	struct snd_soc_pcm_runtime *fe = substream->private_data;
+	struct snd_soc_dpcm *dpcm;
+	int stream = substream->stream;
+
+	if (!fe->dai_link->dpcm_merged_rate)
+		return;
+
+	/*
+	 * It returns merged BE codec channel;
+	 * if FE want to use it (= dpcm_merged_chan)
+	 */
+
+	list_for_each_entry(dpcm, &fe->dpcm[stream].be_clients, list_be) {
+		struct snd_soc_pcm_runtime *be = dpcm->be;
+		struct snd_soc_dai_driver *cpu_dai_drv =  be->cpu_dai->driver;
+		struct snd_soc_dai_driver *codec_dai_drv;
+		struct snd_soc_pcm_stream *codec_stream;
+		struct snd_soc_pcm_stream *cpu_stream;
+		int i;
+
+		if (stream == SNDRV_PCM_STREAM_PLAYBACK)
+			cpu_stream = &cpu_dai_drv->playback;
+		else
+			cpu_stream = &cpu_dai_drv->capture;
+
+		*rate_min = max(*rate_min, cpu_stream->rate_min);
+		*rate_max = min_not_zero(*rate_max, cpu_stream->rate_max);
+		*rates = snd_pcm_rate_mask_intersect(*rates, cpu_stream->rates);
+
+		for (i = 0; i < be->num_codecs; i++) {
+			/*
+			 * Skip CODECs which don't support the current stream
+			 * type. See soc_pcm_init_runtime_hw() for more details
+			 */
+			if (!snd_soc_dai_stream_valid(be->codec_dais[i],
+						      stream))
+				continue;
+
+			codec_dai_drv = be->codec_dais[i]->driver;
+			if (stream == SNDRV_PCM_STREAM_PLAYBACK)
+				codec_stream = &codec_dai_drv->playback;
+			else
+				codec_stream = &codec_dai_drv->capture;
+
+			*rate_min = max(*rate_min, codec_stream->rate_min);
+			*rate_max = min_not_zero(*rate_max,
+						 codec_stream->rate_max);
+			*rates = snd_pcm_rate_mask_intersect(*rates,
+						codec_stream->rates);
+		}
+	}
+}
+
 static void dpcm_set_fe_runtime(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
@@ -1792,6 +1850,8 @@ static void dpcm_set_fe_runtime(struct snd_pcm_substream *substream)
 	dpcm_runtime_merge_format(substream, &runtime->hw.formats);
 	dpcm_runtime_merge_chan(substream, &runtime->hw.channels_min,
 				&runtime->hw.channels_max);
+	dpcm_runtime_merge_rate(substream, &runtime->hw.rates,
+				&runtime->hw.rate_min, &runtime->hw.rate_max);
 }
 
 static int dpcm_fe_dai_do_trigger(struct snd_pcm_substream *substream, int cmd);
-- 
2.14.4
