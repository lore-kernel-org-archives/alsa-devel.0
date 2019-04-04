From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rockchip: pdm: add default regs" to the asoc tree
Date: Thu,  4 Apr 2019 15:16:53 +0700 (+07)
Message-ID: <20190404081653.A4066441D3C@finisterre.ee.mobilebroadband>
References: <1554298856-59028-4-git-send-email-sugar.zhang@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554298856-59028-4-git-send-email-sugar.zhang@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sugar Zhang <sugar.zhang@rock-chips.com>
Cc: Mark Brown <broonie@kernel.org>, heiko@sntech.debroonie@kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rockchip: pdm: add default regs

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

>From a7980cd212cef9002fe9683f440d27609d1aae37 Mon Sep 17 00:00:00 2001
From: Sugar Zhang <sugar.zhang@rock-chips.com>
Date: Wed, 3 Apr 2019 21:40:47 +0800
Subject: [PATCH] ASoC: rockchip: pdm: add default regs

This patch add default regs value for controller.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rockchip_pdm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/rockchip/rockchip_pdm.c b/sound/soc/rockchip/rockchip_pdm.c
index ba61a4b27d39..984d99889a65 100644
--- a/sound/soc/rockchip/rockchip_pdm.c
+++ b/sound/soc/rockchip/rockchip_pdm.c
@@ -361,11 +361,19 @@ static bool rockchip_pdm_volatile_reg(struct device *dev, unsigned int reg)
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
2.20.1
