From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8974: set cache type for regmap" to the asoc tree
Date: Sat, 12 Dec 2015 23:07:40 +0000
Message-ID: <E1a7tGO-0002hk-5l@finisterre>
References: <1449833229-3301-1-git-send-email-mans@mansr.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1449833229-3301-1-git-send-email-mans@mansr.com>
Sender: stable-owner@vger.kernel.org
To: Mans Rullgard <mans@mansr.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm8974: set cache type for regmap

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

>From 1ea5998afe903384ddc16391d4c023cd4c867bea Mon Sep 17 00:00:00 2001
From: Mans Rullgard <mans@mansr.com>
Date: Fri, 11 Dec 2015 11:27:08 +0000
Subject: [PATCH] ASoC: wm8974: set cache type for regmap

Attempting to use this codec driver triggers a BUG() in regcache_sync()
since no cache type is set.  The register map of this device is fairly
small and has few holes so a flat cache is suitable.

Signed-off-by: Mans Rullgard <mans@mansr.com>
Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/codecs/wm8974.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/wm8974.c b/sound/soc/codecs/wm8974.c
index 0a60677..4c29bd2 100644
--- a/sound/soc/codecs/wm8974.c
+++ b/sound/soc/codecs/wm8974.c
@@ -574,6 +574,7 @@ static const struct regmap_config wm8974_regmap = {
 	.max_register = WM8974_MONOMIX,
 	.reg_defaults = wm8974_reg_defaults,
 	.num_reg_defaults = ARRAY_SIZE(wm8974_reg_defaults),
+	.cache_type = REGCACHE_FLAT,
 };
 
 static int wm8974_probe(struct snd_soc_codec *codec)
-- 
2.6.4
