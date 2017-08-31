From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max98927: Added PM suspend and resume function" to the asoc tree
Date: Thu, 31 Aug 2017 12:54:42 +0100
Message-ID: <E1dnO3W-0000jL-PV@debutante>
References: <1497910046-3369-7-git-send-email-ryans.lee@maximintegrated.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1497910046-3369-7-git-send-email-ryans.lee@maximintegrated.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, lgirdwood@gmail.combroonie@kernel.org, perex@perex.cz, tiwai@suse.com, ryans.lee@maximintegrated.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, ryan.lee.maxim@gmail.comalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max98927: Added PM suspend and resume function

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

>From f81991ddd001981bbe4ea0d25f88a4f95fb018be Mon Sep 17 00:00:00 2001
From: Ryan Lee <ryans.lee@maximintegrated.com>
Date: Mon, 28 Aug 2017 16:30:59 -0700
Subject: [PATCH] ASoC: max98927: Added PM suspend and resume function

Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98927.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max98927.c b/sound/soc/codecs/max98927.c
index 5b853604120a..caf5340ca6bb 100644
--- a/sound/soc/codecs/max98927.c
+++ b/sound/soc/codecs/max98927.c
@@ -701,6 +701,31 @@ static int max98927_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int max98927_suspend(struct device *dev)
+{
+	struct max98927_priv *max98927 = dev_get_drvdata(dev);
+
+	regcache_cache_only(max98927->regmap, true);
+	regcache_mark_dirty(max98927->regmap);
+	return 0;
+}
+static int max98927_resume(struct device *dev)
+{
+	struct max98927_priv *max98927 = dev_get_drvdata(dev);
+
+	regmap_write(max98927->regmap,
+		MAX98927_R0100_SOFT_RESET, MAX98927_SOFT_RESET);
+	regcache_cache_only(max98927->regmap, false);
+	regcache_sync(max98927->regmap);
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops max98927_pm = {
+	SET_SYSTEM_SLEEP_PM_OPS(max98927_suspend, max98927_resume)
+};
+
 static const struct snd_soc_codec_driver soc_codec_dev_max98927 = {
 	.probe = max98927_probe,
 	.component_driver = {
@@ -834,7 +859,7 @@ static struct i2c_driver max98927_i2c_driver = {
 		.name = "max98927",
 		.of_match_table = of_match_ptr(max98927_of_match),
 		.acpi_match_table = ACPI_PTR(max98927_acpi_match),
-		.pm = NULL,
+		.pm = &max98927_pm,
 	},
 	.probe  = max98927_i2c_probe,
 	.remove = max98927_i2c_remove,
-- 
2.14.1
