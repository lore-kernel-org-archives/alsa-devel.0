From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rockchip: pdm: adjust waterlevel in frame unit" to the asoc tree
Date: Thu,  4 Apr 2019 15:16:34 +0700 (+07)
Message-ID: <20190404081634.31E08441D3C@finisterre.ee.mobilebroadband>
References: <1554350189-24318-1-git-send-email-sugar.zhang@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554350189-24318-1-git-send-email-sugar.zhang@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sugar Zhang <sugar.zhang@rock-chips.com>
Cc: Mark Brown <broonie@kernel.org>, heiko@sntech.debroonie@kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rockchip: pdm: adjust waterlevel in frame unit

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

>From 430f5da69b9323d5e7faca95bc30e61be4fcbbbf Mon Sep 17 00:00:00 2001
From: Sugar Zhang <sugar.zhang@rock-chips.com>
Date: Thu, 4 Apr 2019 11:56:29 +0800
Subject: [PATCH] ASoC: rockchip: pdm: adjust waterlevel in frame unit

This patch make the waterlevel more reasonable, because the pdm
controller share the single FIFO(128 entries) with each channel.
adjust waterlevel in frame to meet the vad or dma frames request.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rockchip_pdm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/rockchip/rockchip_pdm.c b/sound/soc/rockchip/rockchip_pdm.c
index 3e1c5fd5b32b..955cdc2b8fc5 100644
--- a/sound/soc/rockchip/rockchip_pdm.c
+++ b/sound/soc/rockchip/rockchip_pdm.c
@@ -255,8 +255,9 @@ static int rockchip_pdm_hw_params(struct snd_pcm_substream *substream,
 	regmap_update_bits(pdm->regmap, PDM_CTRL0,
 			   PDM_PATH_MSK | PDM_VDW_MSK,
 			   val);
+	/* all channels share the single FIFO */
 	regmap_update_bits(pdm->regmap, PDM_DMA_CTRL, PDM_DMA_RDL_MSK,
-			   PDM_DMA_RDL(16));
+			   PDM_DMA_RDL(8 * params_channels(params)));
 
 	return 0;
 }
-- 
2.20.1
