From: <shumingf@realtek.com>
Subject: [PATCH 5/5] ASoC: rt5682: Minor code modification
Date: Tue, 18 Sep 2018 19:51:53 +0800
Message-ID: <1537271513-5737-1-git-send-email-shumingf@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D4CD267887
 for <alsa-devel@alsa-project.org>; Tue, 18 Sep 2018 13:51:59 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, albertchen@realtek.com, Shuming Fan <shumingf@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

From: Shuming Fan <shumingf@realtek.com>

Minor code changes are:
 - improve the readability in patch list
 - add i2c remove function
 - regmap_register_patch changes to regmap_multi_reg_write

Signed-off-by: Shuming Fan <shumingf@realtek.com>
---
 sound/soc/codecs/rt5682.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index 1809966..340f904 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -67,7 +67,7 @@ struct rt5682_priv {
 };
 
 static const struct reg_sequence patch_list[] = {
-	{0x01c1, 0x1000},
+	{RT5682_HP_IMP_SENS_CTRL_19, 0x1000},
 	{RT5682_DAC_ADC_DIG_VOL1, 0xa020},
 };
 
@@ -2584,7 +2584,7 @@ static int rt5682_i2c_probe(struct i2c_client *i2c,
 
 	rt5682_calibrate(rt5682);
 
-	ret = regmap_register_patch(rt5682->regmap, patch_list,
+	ret = regmap_multi_reg_write(rt5682->regmap, patch_list,
 				    ARRAY_SIZE(patch_list));
 	if (ret != 0)
 		dev_warn(&i2c->dev, "Failed to apply regmap patch: %d\n", ret);
@@ -2659,11 +2659,17 @@ static int rt5682_i2c_probe(struct i2c_client *i2c,
 
 	}
 
-	return devm_snd_soc_register_component(&i2c->dev,
-			&soc_component_dev_rt5682,
+	return snd_soc_register_component(&i2c->dev, &soc_component_dev_rt5682,
 			rt5682_dai, ARRAY_SIZE(rt5682_dai));
 }
 
+static int rt5682_i2c_remove(struct i2c_client *i2c)
+{
+	snd_soc_unregister_component(&i2c->dev);
+
+	return 0;
+}
+
 static void rt5682_i2c_shutdown(struct i2c_client *client)
 {
 	struct rt5682_priv *rt5682 = i2c_get_clientdata(client);
@@ -2694,6 +2700,7 @@ static struct i2c_driver rt5682_i2c_driver = {
 		.acpi_match_table = ACPI_PTR(rt5682_acpi_match),
 	},
 	.probe = rt5682_i2c_probe,
+	.remove = rt5682_i2c_remove,
 	.shutdown = rt5682_i2c_shutdown,
 	.id_table = rt5682_i2c_id,
 };
-- 
2.7.4
