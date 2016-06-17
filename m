From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ak4613: Enable cache usage to fix crashes on resume" to the asoc tree
Date: Fri, 17 Jun 2016 12:43:18 +0100
Message-ID: <E1bDsBC-00024E-CC@debutante>
References: <1466080472-9817-2-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1466080472-9817-2-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, patches@opensource.wolfsonmicro.com, Peter Ujfalusi <peter.ujfalusi@ti.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ak4613: Enable cache usage to fix crashes on resume

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

>From dcd2d1f78664fdc75eadaaf65257834e24383d01 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 16 Jun 2016 14:34:30 +0200
Subject: [PATCH] ASoC: ak4613: Enable cache usage to fix crashes on resume

During system resume:

    kernel BUG at drivers/base/regmap/regcache.c:347!
    ...
    PC is at regcache_sync+0x1c/0x128
    LR is at ak4613_resume+0x28/0x34

The ak4613 driver is using a regmap cache sync to restore the
configuration of the chip on resume but does not actually define a
register cache which means that the resume is never going to work and we
trigger asserts in regmap.  Fix this by enabling caching.

Based on commit d3030d11961a8c10 ("ASoC: ak4642: Enable cache usage to
fix crashes on resume") by Mark Brown <broonie@kernel.org>.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ak4613.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/ak4613.c b/sound/soc/codecs/ak4613.c
index 33d2f2e10e24..5013d2ba0c10 100644
--- a/sound/soc/codecs/ak4613.c
+++ b/sound/soc/codecs/ak4613.c
@@ -146,6 +146,7 @@ static const struct regmap_config ak4613_regmap_cfg = {
 	.max_register		= 0x16,
 	.reg_defaults		= ak4613_reg,
 	.num_reg_defaults	= ARRAY_SIZE(ak4613_reg),
+	.cache_type		= REGCACHE_RBTREE,
 };
 
 static const struct of_device_id ak4613_of_match[] = {
-- 
2.8.1
