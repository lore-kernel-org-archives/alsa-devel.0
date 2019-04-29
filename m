From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 2/2] ASoC: skip hw_free on codec dai for which the stream is invalid
Date: Mon, 29 Apr 2019 11:47:50 +0200
Message-ID: <20190429094750.1857-3-jbrunet@baylibre.com>
References: <20190429094750.1857-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190429094750.1857-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patchwork-bot+notify@kernel.org
List-Id: alsa-devel@alsa-project.org

Like for hw_params, hw_free should not be called on codec dai for
which the current stream is invalid.

Fixes: cde79035c6cf ("ASoC: Handle multiple codecs with split playback / capture")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/soc-pcm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 263086af707d..04ccdc59295d 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1020,6 +1020,9 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 
 codec_err:
 	for_each_rtd_codec_dai_rollback(rtd, i, codec_dai) {
+		if (!snd_soc_dai_stream_valid(codec_dai, substream->stream))
+			continue;
+
 		if (codec_dai->driver->ops->hw_free)
 			codec_dai->driver->ops->hw_free(substream, codec_dai);
 		codec_dai->rate = 0;
@@ -1077,6 +1080,9 @@ static int soc_pcm_hw_free(struct snd_pcm_substream *substream)
 
 	/* now free hw params for the DAIs  */
 	for_each_rtd_codec_dai(rtd, i, codec_dai) {
+		if (!snd_soc_dai_stream_valid(codec_dai, substream->stream))
+			continue;
+
 		if (codec_dai->driver->ops->hw_free)
 			codec_dai->driver->ops->hw_free(substream, codec_dai);
 	}
-- 
2.20.1
