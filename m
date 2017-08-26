From: Ryan Lee <ryans.lee@maximintegrated.com>
Subject: [PATCH 7/9] ASoC: max98927: Added PM suspend and resume function
Date: Fri, 25 Aug 2017 17:41:08 -0700
Message-ID: <1503708070-7906-7-git-send-email-ryans.lee@maximintegrated.com>
References: <1503708070-7906-1-git-send-email-ryans.lee@maximintegrated.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1503708070-7906-1-git-send-email-ryans.lee@maximintegrated.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, ryans.lee@maximintegrated.com, kuninori.morimoto.gx@renesas.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: ryan.lee.maxim@gmail.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
---
Changes : added PM suspend and resume function to keep register values from power down

 sound/soc/codecs/max98927.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max98927.c b/sound/soc/codecs/max98927.c
index 3ab8220..5517251 100644
--- a/sound/soc/codecs/max98927.c
+++ b/sound/soc/codecs/max98927.c
@@ -803,6 +803,31 @@ static int max98927_probe(struct snd_soc_codec *codec)
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
@@ -936,7 +961,7 @@ static int max98927_i2c_remove(struct i2c_client *client)
 		.name = "max98927",
 		.of_match_table = of_match_ptr(max98927_of_match),
 		.acpi_match_table = ACPI_PTR(max98927_acpi_match),
-		.pm = NULL,
+		.pm = &max98927_pm,
 	},
 	.probe  = max98927_i2c_probe,
 	.remove = max98927_i2c_remove,
-- 
1.9.1
