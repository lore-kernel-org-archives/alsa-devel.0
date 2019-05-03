From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: skip hw_free on codec dai for which the stream is invalid" to the asoc tree
Date: Fri,  3 May 2019 07:18:44 +0100 (BST)
Message-ID: <20190503061844.5E073441D3C@finisterre.ee.mobilebroadband>
References: <20190429094750.1857-3-jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190429094750.1857-3-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, patchwork-bot+notify@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: skip hw_free on codec dai for which the stream is invalid

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.1

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

>From f47b9ad927c6370b80922af434dda98764a43804 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Mon, 29 Apr 2019 11:47:50 +0200
Subject: [PATCH] ASoC: skip hw_free on codec dai for which the stream is
 invalid

Like for hw_params, hw_free should not be called on codec dai for
which the current stream is invalid.

Fixes: cde79035c6cf ("ASoC: Handle multiple codecs with split playback / capture")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-pcm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 57088bd69e5d..a810f6eeffee 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1031,6 +1031,9 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 
 codec_err:
 	for_each_rtd_codec_dai_rollback(rtd, i, codec_dai) {
+		if (!snd_soc_dai_stream_valid(codec_dai, substream->stream))
+			continue;
+
 		if (codec_dai->driver->ops->hw_free)
 			codec_dai->driver->ops->hw_free(substream, codec_dai);
 		codec_dai->rate = 0;
@@ -1088,6 +1091,9 @@ static int soc_pcm_hw_free(struct snd_pcm_substream *substream)
 
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
