From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max9850: remove unused variable 'max9850_reg'" to the asoc tree
Date: Mon, 12 Aug 2019 14:09:52 +0100 (BST)
Message-ID: <20190812130952.E77BF2740CBD@ypsilon.sirena.org.uk>
References: <20190808143507.66788-1-yuehaibing@huawei.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190808143507.66788-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>
Cc: allison@lohutok.net, alsa-devel@alsa-project.org, broonie@kernel.org, gregkh@linuxfoundation.org, Hulk Robot <hulkci@huawei.com>, lgirdwood@gmail.com, linux-kernel@vger.kernel.orgMark Brown <broonie@kernel.org>, perex@perex.cz, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max9850: remove unused variable 'max9850_reg'

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

>From c86102a333f77dcd0f7ef20ba836c6f13f1a077a Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Thu, 8 Aug 2019 22:35:07 +0800
Subject: [PATCH] ASoC: max9850: remove unused variable 'max9850_reg'

sound/soc/codecs/max9850.c:31:33: warning:
 max9850_reg defined but not used [-Wunused-const-variable=]

It is not used since commit 068416620c0d ("ASoC:
max9850: Convert to direct regmap API usage")

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20190808143507.66788-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max9850.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/sound/soc/codecs/max9850.c b/sound/soc/codecs/max9850.c
index f50ee8f5fe93..6f43748f9239 100644
--- a/sound/soc/codecs/max9850.c
+++ b/sound/soc/codecs/max9850.c
@@ -27,19 +27,6 @@ struct max9850_priv {
 	unsigned int sysclk;
 };
 
-/* max9850 register cache */
-static const struct reg_default max9850_reg[] = {
-	{  2, 0x0c },
-	{  3, 0x00 },
-	{  4, 0x00 },
-	{  5, 0x00 },
-	{  6, 0x00 },
-	{  7, 0x00 },
-	{  8, 0x00 },
-	{  9, 0x00 },
-	{ 10, 0x00 },
-};
-
 /* these registers are not used at the moment but provided for the sake of
  * completeness */
 static bool max9850_volatile_register(struct device *dev, unsigned int reg)
-- 
2.20.1
