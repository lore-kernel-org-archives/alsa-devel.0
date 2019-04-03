From: Sugar Zhang <sugar.zhang@rock-chips.com>
Subject: [PATCH v1 03/12] ASoC: rockchip: pdm: add default regs
Date: Wed,  3 Apr 2019 21:40:47 +0800
Message-ID: <1554298856-59028-4-git-send-email-sugar.zhang@rock-chips.com>
References: <1554298856-59028-1-git-send-email-sugar.zhang@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554298856-59028-1-git-send-email-sugar.zhang@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de, broonie@kernel.org
Cc: linux-rockchip@lists.infradead.org, Sugar Zhang <sugar.zhang@rock-chips.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch add default regs value for controller.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
---

 sound/soc/rockchip/rockchip_pdm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/rockchip/rockchip_pdm.c b/sound/soc/rockchip/rockchip_pdm.c
index 360ebf2..8c1be59 100644
--- a/sound/soc/rockchip/rockchip_pdm.c
+++ b/sound/soc/rockchip/rockchip_pdm.c
@@ -363,11 +363,19 @@ static bool rockchip_pdm_volatile_reg(struct device *dev, unsigned int reg)
 	}
 }
 
+static const struct reg_default rockchip_pdm_reg_defaults[] = {
+	{0x04, 0x78000017},
+	{0x08, 0x0bb8ea60},
+	{0x18, 0x0000001f},
+};
+
 static const struct regmap_config rockchip_pdm_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
 	.max_register = PDM_VERSION,
+	.reg_defaults = rockchip_pdm_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(rockchip_pdm_reg_defaults),
 	.writeable_reg = rockchip_pdm_wr_reg,
 	.readable_reg = rockchip_pdm_rd_reg,
 	.volatile_reg = rockchip_pdm_volatile_reg,
-- 
2.7.4
