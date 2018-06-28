From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dpcm: don't merge format from invalid codec dai" to the asoc tree
Date: Thu, 28 Jun 2018 11:20:31 +0100
Message-ID: <E1fYU2R-00046n-DA@debutante>
References: <20180627153638.11832-1-jbrunet@baylibre.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180627153638.11832-1-jbrunet@baylibre.com>
Sender: stable-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, stable@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dpcm: don't merge format from invalid codec dai

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

>From 4febced15ac8ddb9cf3e603edb111842e4863d9a Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Wed, 27 Jun 2018 17:36:38 +0200
Subject: [PATCH] ASoC: dpcm: don't merge format from invalid codec dai

When merging codec formats, dpcm_runtime_base_format() should skip
the codecs which are not supporting the current stream direction.

At the moment, if a BE link has more than one codec, and only one
of these codecs has no capture DAI, it becomes impossible to start
a capture stream because the merged format would be 0.

Skipping invalid codec DAI solves the problem.

Fixes: b073ed4e2126 ("ASoC: soc-pcm: DPCM cares BE format")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/soc-pcm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 5e7ae47a9658..5feae9666822 100644
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
2.18.0.rc2
