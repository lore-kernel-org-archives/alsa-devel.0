From: Sugar Zhang <sugar.zhang@rock-chips.com>
Subject: [PATCH v1 12/12] ASoC: rockchip: pdm: Correct PDM_CTRL0 reg value
Date: Thu,  4 Apr 2019 11:57:57 +0800
Message-ID: <1554350277-24561-1-git-send-email-sugar.zhang@rock-chips.com>
References: <1554298856-59028-1-git-send-email-sugar.zhang@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554298856-59028-1-git-send-email-sugar.zhang@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de, broonie@kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Sugar Zhang <sugar.zhang@rock-chips.com>
List-Id: alsa-devel@alsa-project.org

This patch fix the wrong reg value for rk322x/rk322xh,
cuz there is no STORE JUSTIFIED MODE on it.

on rk322x/rk322xh, the same bit means PDM_MODE/RESERVED,
if the bit is set to RESERVED, the controller will not work.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
---

 sound/soc/rockchip/rockchip_pdm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_pdm.c b/sound/soc/rockchip/rockchip_pdm.c
index e89beeb..6c0f242 100644
--- a/sound/soc/rockchip/rockchip_pdm.c
+++ b/sound/soc/rockchip/rockchip_pdm.c
@@ -210,7 +210,9 @@ static int rockchip_pdm_hw_params(struct snd_pcm_substream *substream,
 	regmap_update_bits(pdm->regmap, PDM_HPF_CTRL,
 			   PDM_HPF_LE | PDM_HPF_RE, PDM_HPF_LE | PDM_HPF_RE);
 	regmap_update_bits(pdm->regmap, PDM_CLK_CTRL, PDM_CLK_EN, PDM_CLK_EN);
-	regmap_update_bits(pdm->regmap, PDM_CTRL0, PDM_MODE_MSK, PDM_MODE_LJ);
+	if (pdm->version != RK_PDM_RK3229)
+		regmap_update_bits(pdm->regmap, PDM_CTRL0,
+				   PDM_MODE_MSK, PDM_MODE_LJ);
 
 	val = 0;
 	switch (params_format(params)) {
@@ -468,7 +470,8 @@ static const struct regmap_config rockchip_pdm_regmap_config = {
 };
 
 static const struct of_device_id rockchip_pdm_match[] = {
-	{ .compatible = "rockchip,pdm", },
+	{ .compatible = "rockchip,pdm",
+	  .data = (void *)RK_PDM_RK3229 },
 	{ .compatible = "rockchip,px30-pdm",
 	  .data = (void *)RK_PDM_RK3308 },
 	{ .compatible = "rockchip,rk1808-pdm",
-- 
2.7.4
