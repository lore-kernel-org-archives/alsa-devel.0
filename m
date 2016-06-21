From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max9860: fix non static symbol warnings" to the asoc tree
Date: Tue, 21 Jun 2016 19:52:47 +0100
Message-ID: <E1bFQn1-0008Ou-Sw@debutante>
References: <1466184111-12667-1-git-send-email-weiyj_lk@163.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466184111-12667-1-git-send-email-weiyj_lk@163.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
Cc: Mark Brown <broonie@kernel.org>, Peter Rosin <peda@axentia.se>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max9860: fix non static symbol warnings

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

>From 716540fdd3d2461a00005cc1d9de067a27535ce2 Mon Sep 17 00:00:00 2001
From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
Date: Fri, 17 Jun 2016 17:21:51 +0000
Subject: [PATCH] ASoC: max9860: fix non static symbol warnings

Fixes the following sparse warnings:

sound/soc/codecs/max9860.c:120:28: warning:
 symbol 'max9860_regmap' was not declared. Should it be static?
sound/soc/codecs/max9860.c:596:25: warning:
 symbol 'max9860_pm_ops' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max9860.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/max9860.c b/sound/soc/codecs/max9860.c
index 2b0dd6a18dad..68074c92a7c0 100644
--- a/sound/soc/codecs/max9860.c
+++ b/sound/soc/codecs/max9860.c
@@ -117,7 +117,7 @@ static bool max9860_precious(struct device *dev, unsigned int reg)
 	return false;
 }
 
-const struct regmap_config max9860_regmap = {
+static const struct regmap_config max9860_regmap = {
 	.reg_bits = 8,
 	.val_bits = 8,
 
@@ -593,7 +593,7 @@ static int max9860_resume(struct device *dev)
 }
 #endif
 
-const struct dev_pm_ops max9860_pm_ops = {
+static const struct dev_pm_ops max9860_pm_ops = {
 	SET_RUNTIME_PM_OPS(max9860_suspend, max9860_resume, NULL)
 };
 
-- 
2.8.1
