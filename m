From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rockchip: pdm: optimize clear logic" to the asoc tree
Date: Thu,  4 Apr 2019 15:16:50 +0700 (+07)
Message-ID: <20190404081650.7748C441D3D@finisterre.ee.mobilebroadband>
References: <1554298856-59028-5-git-send-email-sugar.zhang@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554298856-59028-5-git-send-email-sugar.zhang@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sugar Zhang <sugar.zhang@rock-chips.com>
Cc: Mark Brown <broonie@kernel.org>, heiko@sntech.debroonie@kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rockchip: pdm: optimize clear logic

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

>From 252163a66a06859f468ef1e00fa5a1f377b16eed Mon Sep 17 00:00:00 2001
From: Sugar Zhang <sugar.zhang@rock-chips.com>
Date: Wed, 3 Apr 2019 21:40:48 +0800
Subject: [PATCH] ASoC: rockchip: pdm: optimize clear logic

There is no need to reset controller every time, do this
once in pdm_probe.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rockchip_pdm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_pdm.c b/sound/soc/rockchip/rockchip_pdm.c
index 984d99889a65..eb5216dd7dbc 100644
--- a/sound/soc/rockchip/rockchip_pdm.c
+++ b/sound/soc/rockchip/rockchip_pdm.c
@@ -183,9 +183,6 @@ static int rockchip_pdm_hw_params(struct snd_pcm_substream *substream,
 				   val);
 		regmap_update_bits(pdm->regmap, PDM_DMA_CTRL, PDM_DMA_RDL_MSK,
 				   PDM_DMA_RDL(16));
-		regmap_update_bits(pdm->regmap, PDM_SYSCONFIG,
-				   PDM_RX_MASK | PDM_RX_CLR_MASK,
-				   PDM_RX_STOP | PDM_RX_CLR_WR);
 	}
 
 	return 0;
@@ -353,6 +350,7 @@ static bool rockchip_pdm_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case PDM_SYSCONFIG:
+	case PDM_FIFO_CTRL:
 	case PDM_INT_CLR:
 	case PDM_INT_ST:
 		return true;
@@ -436,6 +434,7 @@ static int rockchip_pdm_probe(struct platform_device *pdev)
 		goto err_suspend;
 	}
 
+	rockchip_pdm_rxctrl(pdm, 0);
 	ret = devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
 	if (ret) {
 		dev_err(&pdev->dev, "could not register pcm: %d\n", ret);
-- 
2.20.1
