From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: es7134: remove 64kHz rate from the supported rates" to the asoc tree
Date: Mon, 02 Jul 2018 11:09:43 +0100
Message-ID: <E1fZvmB-0006N9-83@debutante>
References: <20180629150924.18197-2-jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180629150924.18197-2-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: es7134: remove 64kHz rate from the supported rates

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

>From 5650729f9a1bbf65b57139d855dabe0a7e6cb494 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Fri, 29 Jun 2018 17:09:20 +0200
Subject: [PATCH] ASoC: es7134: remove 64kHz rate from the supported rates

64Khz is actually not supported by the es7134 according to the datasheet

Fixes: 9000b59d7a12 ("ASoC: es7134: add es7134 DAC driver")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/es7134.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/es7134.c b/sound/soc/codecs/es7134.c
index 58515bb1a303..2fbb49f5b278 100644
--- a/sound/soc/codecs/es7134.c
+++ b/sound/soc/codecs/es7134.c
@@ -48,7 +48,11 @@ static struct snd_soc_dai_driver es7134_dai = {
 		.stream_name = "Playback",
 		.channels_min = 2,
 		.channels_max = 2,
-		.rates = SNDRV_PCM_RATE_8000_192000,
+		.rates = (SNDRV_PCM_RATE_8000_48000 |
+			  SNDRV_PCM_RATE_88200      |
+			  SNDRV_PCM_RATE_96000      |
+			  SNDRV_PCM_RATE_176400     |
+			  SNDRV_PCM_RATE_192000),
 		.formats = (SNDRV_PCM_FMTBIT_S16_LE  |
 			    SNDRV_PCM_FMTBIT_S18_3LE |
 			    SNDRV_PCM_FMTBIT_S20_3LE |
-- 
2.18.0.rc2
