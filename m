From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: es8328: Use single R/W for regmap" to the asoc tree
Date: Tue, 10 May 2016 19:49:32 +0100
Message-ID: <E1b0Ciq-0007hd-2n@debutante>
References: <20160509112437.8924-5-john@metanate.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160509112437.8924-5-john@metanate.com>
Sender: linux-kernel-owner@vger.kernel.org
To: John Keeping <john@metanate.com>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: es8328: Use single R/W for regmap

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

>From f2ed04a4317e5c8074d98a5c1da175596811a2d8 Mon Sep 17 00:00:00 2001
From: John Keeping <john@metanate.com>
Date: Mon, 9 May 2016 12:24:32 +0100
Subject: [PATCH] ASoC: es8328: Use single R/W for regmap

The chip only supports single reads and writes.

Signed-off-by: John Keeping <john@metanate.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/es8328.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/es8328.c b/sound/soc/codecs/es8328.c
index 63e82628222c..d580300d9220 100644
--- a/sound/soc/codecs/es8328.c
+++ b/sound/soc/codecs/es8328.c
@@ -713,6 +713,7 @@ const struct regmap_config es8328_regmap_config = {
 	.val_bits	= 8,
 	.max_register	= ES8328_REG_MAX,
 	.cache_type	= REGCACHE_RBTREE,
+	.use_single_rw	= true,
 };
 EXPORT_SYMBOL_GPL(es8328_regmap_config);
 
-- 
2.8.1
