From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sun4i-i2s: Fix RX slot number of SUN8I" to the asoc tree
Date: Mon, 26 Feb 2018 11:17:25 +0000
Message-ID: <E1eqGmb-0005TR-IC@debutante>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: 
Sender: stable-owner@vger.kernel.org
To: Yong Deng <yong.deng@magewell.com>
Cc: Mark Brown <broonie@kernel.org>, stable@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sun4i-i2s: Fix RX slot number of SUN8I

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

>From 5a3386790a172cf738194e1574f631cd43c6140a Mon Sep 17 00:00:00 2001
From: Yong Deng <yong.deng@magewell.com>
Date: Mon, 26 Feb 2018 10:43:52 +0800
Subject: [PATCH] ASoC: sun4i-i2s: Fix RX slot number of SUN8I

I2S's RX slot number of SUN8I should be shifted 4 bit to left.

Fixes: 7d2993811a1e ("ASoC: sun4i-i2s: Add support for H3")
Signed-off-by: Yong Deng <yong.deng@magewell.com>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/sunxi/sun4i-i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index dca1143c1150..a4aa931ebfae 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -104,7 +104,7 @@
 
 #define SUN8I_I2S_CHAN_CFG_REG		0x30
 #define SUN8I_I2S_CHAN_CFG_RX_SLOT_NUM_MASK	GENMASK(6, 4)
-#define SUN8I_I2S_CHAN_CFG_RX_SLOT_NUM(chan)	(chan - 1)
+#define SUN8I_I2S_CHAN_CFG_RX_SLOT_NUM(chan)	((chan - 1) << 4)
 #define SUN8I_I2S_CHAN_CFG_TX_SLOT_NUM_MASK	GENMASK(2, 0)
 #define SUN8I_I2S_CHAN_CFG_TX_SLOT_NUM(chan)	(chan - 1)
 
-- 
2.16.1
