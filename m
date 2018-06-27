From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH] ASoC: dpcm: don't merge format from invalid codec dai
Date: Wed, 27 Jun 2018 17:36:38 +0200
Message-ID: <20180627153638.11832-1-jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

When merging codec formats, dpcm_runtime_base_format() should skip
the codecs which are not supporting the current stream direction.

At the moment, if a BE link has more than one codec, and only one
of these codecs has no capture DAI, it becomes impossible to start
a capture stream because the merged format would be 0.

Skipping invalid codec DAI solves the problem.

Fixes: b073ed4e2126 ("ASoC: soc-pcm: DPCM cares BE format")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/soc-pcm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 5141409ccaed..a58d8e7bf52b 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1694,6 +1694,14 @@ static u64 dpcm_runtime_base_format(struct snd_pcm_substream *substream)
 		int i;
 
 		for (i = 0; i < be->num_codecs; i++) {
+			/*
+			 * Skip CODECs which don't support the current stream
+			 * type. See soc_pcm_init_runtime_hw() for more details
+			 */
+			if (!snd_soc_dai_stream_valid(be->codec_dais[i],
+						      stream))
+				continue;
+
 			codec_dai_drv = be->codec_dais[i]->driver;
 			if (stream == SNDRV_PCM_STREAM_PLAYBACK)
 				codec_stream = &codec_dai_drv->playback;
-- 
2.14.4
