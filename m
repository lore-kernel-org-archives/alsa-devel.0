From: Sugar Zhang <sugar.zhang@rock-chips.com>
Subject: [PATCH v1 04/12] ASoC: rockchip: pdm: optimize clear logic
Date: Wed,  3 Apr 2019 21:40:48 +0800
Message-ID: <1554298856-59028-5-git-send-email-sugar.zhang@rock-chips.com>
References: <1554298856-59028-1-git-send-email-sugar.zhang@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554298856-59028-1-git-send-email-sugar.zhang@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de, broonie@kernel.org
Cc: linux-rockchip@lists.infradead.org, Sugar Zhang <sugar.zhang@rock-chips.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

There is no need to reset controller every time, do this
once in pdm_probe.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
---

 sound/soc/rockchip/rockchip_pdm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_pdm.c b/sound/soc/rockchip/rockchip_pdm.c
index 8c1be59..abbb6d7 100644
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
@@ -355,6 +352,7 @@ static bool rockchip_pdm_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case PDM_SYSCONFIG:
+	case PDM_FIFO_CTRL:
 	case PDM_INT_CLR:
 	case PDM_INT_ST:
 		return true;
@@ -438,6 +436,7 @@ static int rockchip_pdm_probe(struct platform_device *pdev)
 		goto err_suspend;
 	}
 
+	rockchip_pdm_rxctrl(pdm, 0);
 	ret = devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
 	if (ret) {
 		dev_err(&pdev->dev, "could not register pcm: %d\n", ret);
-- 
2.7.4
