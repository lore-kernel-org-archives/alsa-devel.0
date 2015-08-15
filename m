From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: adav80x: Remove .read_flag_mask setting from adav80x_regmap_config" to the asoc tree
Date: Fri, 14 Aug 2015 19:15:10 -0700
Message-ID: <E1ZQR02-0004Rm-CZ@finisterre>
References: <1439546047.5150.1.camel@ingics.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1439546047.5150.1.camel@ingics.com>
Sender: stable-owner@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>, Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: adav80x: Remove .read_flag_mask setting from adav80x_regmap_config

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

>From 9d8352864907f0ad76124c5b28f65b5a382d7d7c Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Fri, 14 Aug 2015 17:54:07 +0800
Subject: [PATCH] ASoC: adav80x: Remove .read_flag_mask setting from
 adav80x_regmap_config

Don't set .read_flag_mask for adav803, it's for adav801 only.

Fixes: 0c2d69645628 ("ASoC: adav80x: Split SPI and I2C code into different modules")
Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/codecs/adav80x.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/adav80x.c b/sound/soc/codecs/adav80x.c
index 36d8425..69c63b9 100644
--- a/sound/soc/codecs/adav80x.c
+++ b/sound/soc/codecs/adav80x.c
@@ -865,7 +865,6 @@ const struct regmap_config adav80x_regmap_config = {
 	.val_bits = 8,
 	.pad_bits = 1,
 	.reg_bits = 7,
-	.read_flag_mask = 0x01,
 
 	.max_register = ADAV80X_PLL_OUTE,
 
-- 
2.5.0
