From: Sugar Zhang <sugar.zhang@rock-chips.com>
Subject: [PATCH v1 10/12] ASoC: rockchip: pdm: adjust waterlevel in frame unit
Date: Thu,  4 Apr 2019 11:56:29 +0800
Message-ID: <1554350189-24318-1-git-send-email-sugar.zhang@rock-chips.com>
References: <1554298856-59028-1-git-send-email-sugar.zhang@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554298856-59028-1-git-send-email-sugar.zhang@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de, broonie@kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Sugar Zhang <sugar.zhang@rock-chips.com>
List-Id: alsa-devel@alsa-project.org

This patch make the waterlevel more reasonable, because the pdm
controller share the single FIFO(128 entries) with each channel.
adjust waterlevel in frame to meet the vad or dma frames request.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
---

 sound/soc/rockchip/rockchip_pdm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/rockchip/rockchip_pdm.c b/sound/soc/rockchip/rockchip_pdm.c
index 3e1c5fd..955cdc2 100644
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
2.7.4
