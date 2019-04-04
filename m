From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max98357a: add missing supported rates" to the asoc tree
Date: Thu,  4 Apr 2019 20:58:37 +0700 (+07)
Message-ID: <20190404135837.5B0C0441D3C@finisterre.ee.mobilebroadband>
References: <20190404115015.32208-1-jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190404115015.32208-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Maxime Jourdan <mjourdan@baylibre.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max98357a: add missing supported rates

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

>From fdf34366d3242d5eeffa1b4d9a3497ebf30a4ecb Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Thu, 4 Apr 2019 13:50:15 +0200
Subject: [PATCH] ASoC: max98357a: add missing supported rates

According the publicly available datasheet (and some test) the max98357a
also supports 32, 44.1 and 88.2 kHz sample rate.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98357a.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/max98357a.c b/sound/soc/codecs/max98357a.c
index d469576b5a7b..d037a3e4d323 100644
--- a/sound/soc/codecs/max98357a.c
+++ b/sound/soc/codecs/max98357a.c
@@ -97,7 +97,10 @@ static struct snd_soc_dai_driver max98357a_dai_driver = {
 					SNDRV_PCM_FMTBIT_S32,
 		.rates		= SNDRV_PCM_RATE_8000 |
 					SNDRV_PCM_RATE_16000 |
+					SNDRV_PCM_RATE_32000 |
+					SNDRV_PCM_RATE_44100 |
 					SNDRV_PCM_RATE_48000 |
+					SNDRV_PCM_RATE_88200 |
 					SNDRV_PCM_RATE_96000,
 		.rate_min	= 8000,
 		.rate_max	= 96000,
-- 
2.20.1
