From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs42xx8: Setup of_match_table" to the
	asoc tree
Date: Tue, 07 Jul 2015 14:57:53 +0100
Message-ID: <E1ZCTNh-0005X5-4D@finisterre>
References: <1435239853.22170.4.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2B81B265727
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2015 15:58:08 +0200 (CEST)
In-Reply-To: <1435239853.22170.4.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Brian Austin <brian.austin@cirrus.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs42xx8: Setup of_match_table

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

>From 5e4cb7b60833b0124a9f71dbc5118144ca79c3c4 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 25 Jun 2015 21:44:13 +0800
Subject: [PATCH] ASoC: cs42xx8: Setup of_match_table

Setup of_match_table and since cs42xx8_of_match is exported and used in
cs42xx8-i2c.c, it cannot be static.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Brian Austin <brian.austin@cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs42xx8-i2c.c | 3 ++-
 sound/soc/codecs/cs42xx8.c     | 2 +-
 sound/soc/codecs/cs42xx8.h     | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs42xx8-i2c.c b/sound/soc/codecs/cs42xx8-i2c.c
index 657dce2..5a71c9e 100644
--- a/sound/soc/codecs/cs42xx8-i2c.c
+++ b/sound/soc/codecs/cs42xx8-i2c.c
@@ -20,7 +20,7 @@
 static int cs42xx8_i2c_probe(struct i2c_client *i2c,
 			     const struct i2c_device_id *id)
 {
-	u32 ret = cs42xx8_probe(&i2c->dev,
+	int ret = cs42xx8_probe(&i2c->dev,
 			devm_regmap_init_i2c(i2c, &cs42xx8_regmap_config));
 	if (ret)
 		return ret;
@@ -51,6 +51,7 @@ static struct i2c_driver cs42xx8_i2c_driver = {
 		.name = "cs42xx8",
 		.owner = THIS_MODULE,
 		.pm = &cs42xx8_pm,
+		.of_match_table = cs42xx8_of_match,
 	},
 	.probe = cs42xx8_i2c_probe,
 	.remove = cs42xx8_i2c_remove,
diff --git a/sound/soc/codecs/cs42xx8.c b/sound/soc/codecs/cs42xx8.c
index ab39514..d562e1b 100644
--- a/sound/soc/codecs/cs42xx8.c
+++ b/sound/soc/codecs/cs42xx8.c
@@ -425,7 +425,7 @@ const struct cs42xx8_driver_data cs42888_data = {
 };
 EXPORT_SYMBOL_GPL(cs42888_data);
 
-static const struct of_device_id cs42xx8_of_match[] = {
+const struct of_device_id cs42xx8_of_match[] = {
 	{ .compatible = "cirrus,cs42448", .data = &cs42448_data, },
 	{ .compatible = "cirrus,cs42888", .data = &cs42888_data, },
 	{ /* sentinel */ }
diff --git a/sound/soc/codecs/cs42xx8.h b/sound/soc/codecs/cs42xx8.h
index b2c10e5..d36c61b 100644
--- a/sound/soc/codecs/cs42xx8.h
+++ b/sound/soc/codecs/cs42xx8.h
@@ -22,6 +22,7 @@ extern const struct dev_pm_ops cs42xx8_pm;
 extern const struct cs42xx8_driver_data cs42448_data;
 extern const struct cs42xx8_driver_data cs42888_data;
 extern const struct regmap_config cs42xx8_regmap_config;
+extern const struct of_device_id cs42xx8_of_match[];
 int cs42xx8_probe(struct device *dev, struct regmap *regmap);
 
 /* CS42888 register map */
-- 
2.1.4
