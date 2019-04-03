From: Sugar Zhang <sugar.zhang@rock-chips.com>
Subject: [PATCH v1 02/12] ASoC: rockchip: pdm: using left justified store mode
Date: Wed,  3 Apr 2019 21:40:46 +0800
Message-ID: <1554298856-59028-3-git-send-email-sugar.zhang@rock-chips.com>
References: <1554298856-59028-1-git-send-email-sugar.zhang@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554298856-59028-1-git-send-email-sugar.zhang@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de, broonie@kernel.org
Cc: linux-rockchip@lists.infradead.org, Sugar Zhang <sugar.zhang@rock-chips.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch set left justified store mode default.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
---

 sound/soc/rockchip/rockchip_pdm.c | 1 +
 sound/soc/rockchip/rockchip_pdm.h | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/sound/soc/rockchip/rockchip_pdm.c b/sound/soc/rockchip/rockchip_pdm.c
index 8a2e3bb..360ebf2 100644
--- a/sound/soc/rockchip/rockchip_pdm.c
+++ b/sound/soc/rockchip/rockchip_pdm.c
@@ -135,6 +135,7 @@ static int rockchip_pdm_hw_params(struct snd_pcm_substream *substream,
 	regmap_update_bits(pdm->regmap, PDM_HPF_CTRL,
 			   PDM_HPF_LE | PDM_HPF_RE, PDM_HPF_LE | PDM_HPF_RE);
 	regmap_update_bits(pdm->regmap, PDM_CLK_CTRL, PDM_CLK_EN, PDM_CLK_EN);
+	regmap_update_bits(pdm->regmap, PDM_CTRL0, PDM_MODE_MSK, PDM_MODE_LJ);
 
 	val = 0;
 	switch (params_format(params)) {
diff --git a/sound/soc/rockchip/rockchip_pdm.h b/sound/soc/rockchip/rockchip_pdm.h
index 886b48d1..00a8fa1 100644
--- a/sound/soc/rockchip/rockchip_pdm.h
+++ b/sound/soc/rockchip/rockchip_pdm.h
@@ -42,6 +42,9 @@
 
 /* PDM CTRL0 */
 #define PDM_PATH_MSK		(0xf << 27)
+#define PDM_MODE_MSK		BIT(31)
+#define PDM_MODE_RJ		0
+#define PDM_MODE_LJ		BIT(31)
 #define PDM_PATH3_EN		BIT(30)
 #define PDM_PATH2_EN		BIT(29)
 #define PDM_PATH1_EN		BIT(28)
-- 
2.7.4
