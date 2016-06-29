From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs35l33: mark PM functions as __maybe_unused" to the asoc tree
Date: Wed, 29 Jun 2016 19:04:45 +0100
Message-ID: <E1bIJqv-0003Wr-IQ@finisterre>
References: <20160629143416.45214-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160629143416.45214-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Paul Handrigan <Paul.Handrigan@cirrus.com>, Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, Brian Austin <brian.austin@cirrus.com>, Axel Lin <axel.lin@ingics.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.orgPaul Handrigan <Paul.Handrigan@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs35l33: mark PM functions as __maybe_unused

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

>From 20f12f2c4819a36de92ec6be382d0636d3485c6b Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 29 Jun 2016 16:33:17 +0200
Subject: [PATCH] ASoC: cs35l33: mark PM functions as __maybe_unused

The newly added cs35l33 driver produces a harmless warning when
CONFIG_PM is disabled:

sound/soc/codecs/cs35l33.c:908:12: error: 'cs35l33_runtime_suspend' defined but not used [-Werror=unused-function]
sound/soc/codecs/cs35l33.c:868:12: error: 'cs35l33_runtime_resume' defined but not used [-Werror=unused-function]

This adds __maybe_unused annotations to shut up the warning
regardless of the configuration.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Paul Handrigan <Paul.Handrigan@cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs35l33.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs35l33.c b/sound/soc/codecs/cs35l33.c
index 622a1111b21c..d8b5fc3fc45d 100644
--- a/sound/soc/codecs/cs35l33.c
+++ b/sound/soc/codecs/cs35l33.c
@@ -862,7 +862,7 @@ static const struct regmap_config cs35l33_regmap = {
 	.use_single_rw = true,
 };
 
-static int cs35l33_runtime_resume(struct device *dev)
+static int __maybe_unused cs35l33_runtime_resume(struct device *dev)
 {
 	struct cs35l33_private *cs35l33 = dev_get_drvdata(dev);
 	int ret;
@@ -902,7 +902,7 @@ err:
 	return ret;
 }
 
-static int cs35l33_runtime_suspend(struct device *dev)
+static int __maybe_unused cs35l33_runtime_suspend(struct device *dev)
 {
 	struct cs35l33_private *cs35l33 = dev_get_drvdata(dev);
 
-- 
2.8.1
