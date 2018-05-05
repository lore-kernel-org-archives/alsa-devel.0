From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs35l35: Add use_single_rw to regmap config" to the asoc tree
Date: Sat,  5 May 2018 02:44:04 +0100 (BST)
Message-ID: <20180505014404.DC8D444007A@finisterre.ee.mobilebroadband>
References: <d4041f11-1d80-47cd-9b06-cc3966d7bacd@EX4.ad.cirrus.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <d4041f11-1d80-47cd-9b06-cc3966d7bacd@EX4.ad.cirrus.com>
Sender: stable-owner@vger.kernel.org
To: Paul Handrigan <Paul.Handrigan@cirrus.com>
Cc: Mark Brown <broonie@kernel.org>, stable@vger.kernel.org, alsa-devel@alsa-project.org, brian.austin@cirrus.combroonie@kernel.org, lgirdwood@gmail.com, charles.keepax@cirrus.comalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs35l35: Add use_single_rw to regmap config

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

>From 6a6ad7face95af0b9e6aaf1eb2261eb70240b89b Mon Sep 17 00:00:00 2001
From: Paul Handrigan <Paul.Handrigan@cirrus.com>
Date: Fri, 4 May 2018 16:37:41 -0500
Subject: [PATCH] ASoC: cs35l35: Add use_single_rw to regmap config

Add the use_single_rw flag to regmap config since the
device does not support bulk transactions over i2c.

Signed-off-by: Paul Handrigan <Paul.Handrigan@cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/codecs/cs35l35.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/cs35l35.c b/sound/soc/codecs/cs35l35.c
index a4a2cb171bdf..bd6226bde45f 100644
--- a/sound/soc/codecs/cs35l35.c
+++ b/sound/soc/codecs/cs35l35.c
@@ -1105,6 +1105,7 @@ static struct regmap_config cs35l35_regmap = {
 	.readable_reg = cs35l35_readable_register,
 	.precious_reg = cs35l35_precious_register,
 	.cache_type = REGCACHE_RBTREE,
+	.use_single_rw = true,
 };
 
 static irqreturn_t cs35l35_irq(int irq, void *data)
-- 
2.17.0
