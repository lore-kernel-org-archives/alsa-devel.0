From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: zte: Fix incorrect PCM format bit usages" to the asoc tree
Date: Thu, 26 Jul 2018 16:01:21 +0100 (BST)
Message-ID: <20180726150121.3B822440078@finisterre.ee.mobilebroadband>
References: <20180725204049.28859-1-tiwai@suse.de>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180725204049.28859-1-tiwai@suse.de>
Sender: stable-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: stable@vger.kernel.org, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Baoyou Xie <baoyou.xie@linaro.org>, Jun Nie <jun.nie@linaro.org>Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: zte: Fix incorrect PCM format bit usages

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

>From c889a45d229938a94b50aadb819def8bb11a6a54 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Wed, 25 Jul 2018 22:40:49 +0200
Subject: [PATCH] ASoC: zte: Fix incorrect PCM format bit usages

zx-tdm driver sets the DAI driver definitions with the format bits
wrongly set with SNDRV_PCM_FORMAT_*, instead of SNDRV_PCM_FMTBIT_*.

This patch corrects the definitions.

Spotted by a sparse warning:
  sound/soc/zte/zx-tdm.c:363:35: warning: restricted snd_pcm_format_t degrades to integer

Fixes: 870e0ddc4345 ("ASoC: zx-tdm: add zte's tdm controller driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/zte/zx-tdm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/zte/zx-tdm.c b/sound/soc/zte/zx-tdm.c
index dc955272f58b..389272eeba9a 100644
--- a/sound/soc/zte/zx-tdm.c
+++ b/sound/soc/zte/zx-tdm.c
@@ -144,8 +144,8 @@ static void zx_tdm_rx_dma_en(struct zx_tdm_info *tdm, bool on)
 #define ZX_TDM_RATES	(SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000)
 
 #define ZX_TDM_FMTBIT \
-	(SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FORMAT_MU_LAW | \
-	SNDRV_PCM_FORMAT_A_LAW)
+	(SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_MU_LAW | \
+	SNDRV_PCM_FMTBIT_A_LAW)
 
 static int zx_tdm_dai_probe(struct snd_soc_dai *dai)
 {
-- 
2.18.0
