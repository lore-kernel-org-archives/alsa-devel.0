From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] ASoC: rt5677: Convert I2C driver to
	->probe_new()
Date: Thu, 24 Aug 2017 16:41:10 +0300
Message-ID: <20170824134110.63335-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id EDA0E266DE5
 for <alsa-devel@alsa-project.org>; Thu, 24 Aug 2017 15:41:17 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Oder Chiou <oder_chiou@realtek.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

There is no platform code that uses i2c module table.
Remove it altogether and adjust ->probe() to be ->probe_new().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/soc/codecs/rt5677.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index c735590c5a25..6448b7a00203 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -5009,11 +5009,6 @@ static const struct regmap_config rt5677_regmap = {
 	.num_ranges = ARRAY_SIZE(rt5677_ranges),
 };
 
-static const struct i2c_device_id rt5677_i2c_id[] = {
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, rt5677_i2c_id);
-
 static const struct of_device_id rt5677_of_match[] = {
 	{ .compatible = "realtek,rt5677", RT5677 },
 	{ }
@@ -5131,8 +5126,7 @@ static void rt5677_free_irq(struct i2c_client *i2c)
 		regmap_del_irq_chip(i2c->irq, rt5677->irq_data);
 }
 
-static int rt5677_i2c_probe(struct i2c_client *i2c,
-		    const struct i2c_device_id *id)
+static int rt5677_i2c_probe(struct i2c_client *i2c)
 {
 	struct rt5677_priv *rt5677;
 	int ret;
@@ -5279,9 +5273,8 @@ static struct i2c_driver rt5677_i2c_driver = {
 		.of_match_table = rt5677_of_match,
 		.acpi_match_table = ACPI_PTR(rt5677_acpi_match),
 	},
-	.probe = rt5677_i2c_probe,
+	.probe_new = rt5677_i2c_probe,
 	.remove   = rt5677_i2c_remove,
-	.id_table = rt5677_i2c_id,
 };
 module_i2c_driver(rt5677_i2c_driver);
 
-- 
2.14.1
