From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rockchip: i2s: add default values for
	registers" to the asoc tree
Date: Mon, 22 Feb 2016 20:13:05 +0900
Message-ID: <E1aXoQL-0006Ow-Ob@finisterre>
References: <1456127815-68575-2-git-send-email-sugar.zhang@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9923B2659D3
 for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2016 12:13:13 +0100 (CET)
In-Reply-To: <1456127815-68575-2-git-send-email-sugar.zhang@rock-chips.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sugar Zhang <sugar.zhang@rock-chips.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rockchip: i2s: add default values for registers

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From ea2e5b96bd6e835052981b777253def60cfd905f Mon Sep 17 00:00:00 2001
From: Sugar Zhang <sugar.zhang@rock-chips.com>
Date: Mon, 22 Feb 2016 15:56:54 +0800
Subject: [PATCH] ASoC: rockchip: i2s: add default values for registers

this patch add default values for registers according description from TRM.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rockchip_i2s.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index 531a6d201d2e..2f8e20416bd3 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -440,11 +440,21 @@ static bool rockchip_i2s_precious_reg(struct device *dev, unsigned int reg)
 	}
 }
 
+static const struct reg_default rockchip_i2s_reg_defaults[] = {
+	{0x00, 0x0000000f},
+	{0x04, 0x0000000f},
+	{0x08, 0x00071f1f},
+	{0x10, 0x001f0000},
+	{0x14, 0x01f00000},
+};
+
 static const struct regmap_config rockchip_i2s_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
 	.max_register = I2S_RXDR,
+	.reg_defaults = rockchip_i2s_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(rockchip_i2s_reg_defaults),
 	.writeable_reg = rockchip_i2s_wr_reg,
 	.readable_reg = rockchip_i2s_rd_reg,
 	.volatile_reg = rockchip_i2s_volatile_reg,
-- 
2.7.0
