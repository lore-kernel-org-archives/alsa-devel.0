From: Sugar Zhang <sugar.zhang@rock-chips.com>
Subject: [PATCH v1 11/12] ASoC: rockchip: pdm: Mark RXFIFO_DATA as volatile and precious
Date: Thu,  4 Apr 2019 11:57:08 +0800
Message-ID: <1554350228-24440-1-git-send-email-sugar.zhang@rock-chips.com>
References: <1554298856-59028-1-git-send-email-sugar.zhang@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554298856-59028-1-git-send-email-sugar.zhang@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de, broonie@kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Sugar Zhang <sugar.zhang@rock-chips.com>
List-Id: alsa-devel@alsa-project.org

This patch marks RXFIFO_DATA as precious to avoid being read
outside a call from the driver, such as regmap debugfs

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
---

 sound/soc/rockchip/rockchip_pdm.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/soc/rockchip/rockchip_pdm.c b/sound/soc/rockchip/rockchip_pdm.c
index 955cdc2..e89beeb 100644
--- a/sound/soc/rockchip/rockchip_pdm.c
+++ b/sound/soc/rockchip/rockchip_pdm.c
@@ -415,6 +415,7 @@ static bool rockchip_pdm_rd_reg(struct device *dev, unsigned int reg)
 	case PDM_INT_CLR:
 	case PDM_INT_ST:
 	case PDM_DATA_VALID:
+	case PDM_RXFIFO_DATA:
 	case PDM_VERSION:
 		return true;
 	default:
@@ -429,6 +430,17 @@ static bool rockchip_pdm_volatile_reg(struct device *dev, unsigned int reg)
 	case PDM_FIFO_CTRL:
 	case PDM_INT_CLR:
 	case PDM_INT_ST:
+	case PDM_RXFIFO_DATA:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool rockchip_pdm_precious_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case PDM_RXFIFO_DATA:
 		return true;
 	default:
 		return false;
@@ -451,6 +463,7 @@ static const struct regmap_config rockchip_pdm_regmap_config = {
 	.writeable_reg = rockchip_pdm_wr_reg,
 	.readable_reg = rockchip_pdm_rd_reg,
 	.volatile_reg = rockchip_pdm_volatile_reg,
+	.precious_reg = rockchip_pdm_precious_reg,
 	.cache_type = REGCACHE_FLAT,
 };
 
-- 
2.7.4
