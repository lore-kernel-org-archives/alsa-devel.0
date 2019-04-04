From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sprd: Fix spelling mistake "faied" -> "failed"" to the asoc tree
Date: Thu,  4 Apr 2019 15:16:27 +0700 (+07)
Message-ID: <20190404081627.D053A441D3C@finisterre.ee.mobilebroadband>
References: <20190404075603.11680-1-colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190404075603.11680-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin Ian King <colin.king@canonical.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linaro.org>, Chunyan Zhang <zhang.lyra@gmail.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sprd: Fix spelling mistake "faied" -> "failed"

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

>From 47fa5773f11c7cc9117d74ea5a18a22502d8f0f3 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Thu, 4 Apr 2019 08:56:03 +0100
Subject: [PATCH] ASoC: sprd: Fix spelling mistake "faied" -> "failed"

There are two identical spelling mistakes in dev_err messages. Fix them.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
Reviewed-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sprd/sprd-pcm-compress.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sprd/sprd-pcm-compress.c b/sound/soc/sprd/sprd-pcm-compress.c
index 424e9834d093..6cddf551bc11 100644
--- a/sound/soc/sprd/sprd-pcm-compress.c
+++ b/sound/soc/sprd/sprd-pcm-compress.c
@@ -281,13 +281,13 @@ static int sprd_platform_compr_set_params(struct snd_compr_stream *cstream,
 	 */
 	ret = sprd_platform_compr_dma_config(cstream, params, 1);
 	if (ret) {
-		dev_err(dev, "faied to config stage 1 DMA: %d\n", ret);
+		dev_err(dev, "failed to config stage 1 DMA: %d\n", ret);
 		return ret;
 	}
 
 	ret = sprd_platform_compr_dma_config(cstream, params, 0);
 	if (ret) {
-		dev_err(dev, "faied to config stage 0 DMA: %d\n", ret);
+		dev_err(dev, "failed to config stage 0 DMA: %d\n", ret);
 		goto config_err;
 	}
 
-- 
2.20.1
