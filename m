From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH] ASoC: dpcm: extend channel merging to the backend cpu dai
Date: Wed, 27 Jun 2018 11:48:18 +0200
Message-ID: <20180627094818.5885-1-jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Jiada Wang <jiada_wang@mentor.com>
List-Id: alsa-devel@alsa-project.org

Extend dpcm_merge_chan to also check backend cpu dai channels
capabilities. Apply the same policy as soc_pcm_init_runtime_hw() for
multicodec links and only check cpu dai in this case.

Cc: Jiada Wang <jiada_wang@mentor.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---

 Hi Mark,

 As you've probably noticed, this patch applies on top Jiada's patch
 pf4c277b817cc ("ASoC: soc-pcm: DPCM cares BE channel constraint")

 Regards.
 Jerome

 sound/soc/soc-pcm.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index b82d9ff1f47e..5141409ccaed 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1728,12 +1728,26 @@ static void dpcm_runtime_base_chan(struct snd_pcm_substream *substream,
 
 	list_for_each_entry(dpcm, &fe->dpcm[stream].be_clients, list_be) {
 		struct snd_soc_pcm_runtime *be = dpcm->be;
+		struct snd_soc_dai_driver *cpu_dai_drv =  be->cpu_dai->driver;
 		struct snd_soc_dai_driver *codec_dai_drv;
 		struct snd_soc_pcm_stream *codec_stream;
-		int i;
+		struct snd_soc_pcm_stream *cpu_stream;
+
+		if (stream == SNDRV_PCM_STREAM_PLAYBACK)
+			cpu_stream = &cpu_dai_drv->playback;
+		else
+			cpu_stream = &cpu_dai_drv->capture;
+
+		*channels_min = max(*channels_min, cpu_stream->channels_min);
+		*channels_max = min(*channels_max, cpu_stream->channels_max);
+
+		/*
+		 * chan min/max cannot be enforced if there are multiple CODEC
+		 * DAIs connected to a single CPU DAI, use CPU DAI's directly
+		 */
+		if (be->num_codecs == 1) {
+			codec_dai_drv = be->codec_dais[0]->driver;
 
-		for (i = 0; i < be->num_codecs; i++) {
-			codec_dai_drv = be->codec_dais[i]->driver;
 			if (stream == SNDRV_PCM_STREAM_PLAYBACK)
 				codec_stream = &codec_dai_drv->playback;
 			else
-- 
2.14.4
