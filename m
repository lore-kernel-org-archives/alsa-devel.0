From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ak4642: Enable cache usage to fix crashes on resume" to the asoc tree
Date: Wed, 18 May 2016 19:13:42 +0100
Message-ID: <E1b35yY-0000uL-7z@debutante>
References: <1463593762-31871-1-git-send-email-broonie@kernel.org>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1463593762-31871-1-git-send-email-broonie@kernel.org>
Sender: stable-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Geert Uytterhoeven <geert+renesas@glider.be>, stable@vger.kernel.orgPeter Ujfalusi <peter.ujfalusi@ti.com>Geert Uytterhoeven <geert@linux-m68k.org>, alsa-devel@alsa-project.orgstable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ak4642: Enable cache usage to fix crashes on resume

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

>From d3030d11961a8c103cf07aed59905276ddfc06c2 Mon Sep 17 00:00:00 2001
From: Mark Brown <broonie@kernel.org>
Date: Wed, 18 May 2016 18:30:39 +0100
Subject: [PATCH] ASoC: ak4642: Enable cache usage to fix crashes on resume

The ak4642 driver is using a regmap cache sync to restore the
configuration of the chip on resume but (as Peter observed) does not
actually define a register cache which means that the resume is never
going to work and we trigger asserts in regmap.  Fix this by enabling
caching.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reported-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/codecs/ak4642.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/ak4642.c b/sound/soc/codecs/ak4642.c
index 1ee8506c06c7..4d8b9e49e8d6 100644
--- a/sound/soc/codecs/ak4642.c
+++ b/sound/soc/codecs/ak4642.c
@@ -560,6 +560,7 @@ static const struct regmap_config ak4642_regmap = {
 	.max_register		= FIL1_3,
 	.reg_defaults		= ak4642_reg,
 	.num_reg_defaults	= NUM_AK4642_REG_DEFAULTS,
+	.cache_type		= REGCACHE_RBTREE,
 };
 
 static const struct regmap_config ak4643_regmap = {
@@ -568,6 +569,7 @@ static const struct regmap_config ak4643_regmap = {
 	.max_register		= SPK_MS,
 	.reg_defaults		= ak4643_reg,
 	.num_reg_defaults	= ARRAY_SIZE(ak4643_reg),
+	.cache_type		= REGCACHE_RBTREE,
 };
 
 static const struct regmap_config ak4648_regmap = {
@@ -576,6 +578,7 @@ static const struct regmap_config ak4648_regmap = {
 	.max_register		= EQ_FBEQE,
 	.reg_defaults		= ak4648_reg,
 	.num_reg_defaults	= ARRAY_SIZE(ak4648_reg),
+	.cache_type		= REGCACHE_RBTREE,
 };
 
 static const struct ak4642_drvdata ak4642_drvdata = {
-- 
2.8.1
