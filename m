From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dpcm: add rate merge to the BE stream merge" to the asoc tree
Date: Wed, 11 Jul 2018 11:59:02 +0100
Message-ID: <E1fdCpq-0007wc-I6@debutante>
References: <20180705101349.7520-3-jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180705101349.7520-3-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dpcm: add rate merge to the BE stream merge

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From baacd8d100d571aa713c3c60b1471b9962e6ec8a Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Thu, 5 Jul 2018 12:13:49 +0200
Subject: [PATCH] ASoC: dpcm: add rate merge to the BE stream merge

As done for format and channels, add the possibility to merge
the backend rates on the frontend rates.

This useful if the backend does not support all rates supported by the
frontend, or if several backends (cpu and codecs) with different
capabilities are connected to the same frontend.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h |  2 ++
 sound/soc/soc-pcm.c | 60 +++++++++++++++++++++++++++++++++++++++++++++
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
index 114e6c060cae..4019bc10897c 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1769,6 +1769,64 @@ static void dpcm_runtime_merge_chan(struct snd_pcm_substream *substream,
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
@@ -1784,6 +1842,8 @@ static void dpcm_set_fe_runtime(struct snd_pcm_substream *substream)
 	dpcm_runtime_merge_format(substream, &runtime->hw.formats);
 	dpcm_runtime_merge_chan(substream, &runtime->hw.channels_min,
 				&runtime->hw.channels_max);
+	dpcm_runtime_merge_rate(substream, &runtime->hw.rates,
+				&runtime->hw.rate_min, &runtime->hw.rate_max);
 }
 
 static int dpcm_fe_dai_do_trigger(struct snd_pcm_substream *substream, int cmd);
-- 
2.18.0.rc2
