From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5663: Add regulator support" to the
	asoc tree
Date: Thu, 15 Nov 2018 19:45:42 +0000 (GMT)
Message-ID: <20181115194542.1E030440078@finisterre.ee.mobilebroadband>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id ADA93267AFC
 for <alsa-devel@alsa-project.org>; Thu, 15 Nov 2018 20:45:48 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Cheng-Yi Chiang <cychiang@chromium.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5663: Add regulator support

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

>From e81a2a6d12e85fbd7b19e96ad72b82a3cc8a6b2d Mon Sep 17 00:00:00 2001
From: Cheng-Yi Chiang <cychiang@chromium.org>
Date: Thu, 15 Nov 2018 12:13:34 +0800
Subject: [PATCH] ASoC: rt5663: Add regulator support

Add regulator support to turn on cpvdd and avdd in probe.
If a regulator is not given from device tree, a dummy regulator will be
used.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5663.c | 68 +++++++++++++++++++++++++++++++++++----
 1 file changed, 61 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/rt5663.c b/sound/soc/codecs/rt5663.c
index 7eb2cbd39d6e..29c059ed0682 100644
--- a/sound/soc/codecs/rt5663.c
+++ b/sound/soc/codecs/rt5663.c
@@ -17,6 +17,7 @@
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
 #include <linux/acpi.h>
+#include <linux/regulator/consumer.h>
 #include <linux/workqueue.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -33,6 +34,9 @@
 #define RT5663_DEVICE_ID_2 0x6451
 #define RT5663_DEVICE_ID_1 0x6406
 
+#define RT5663_POWER_ON_DELAY_MS 300
+#define RT5663_SUPPLY_CURRENT_UA 500000
+
 enum {
 	CODEC_VER_1,
 	CODEC_VER_0,
@@ -48,6 +52,11 @@ struct impedance_mapping_table {
 	unsigned int dc_offset_r_manual_mic;
 };
 
+static const char *const rt5663_supply_names[] = {
+	"avdd",
+	"cpvdd",
+};
+
 struct rt5663_priv {
 	struct snd_soc_component *component;
 	struct rt5663_platform_data pdata;
@@ -56,6 +65,7 @@ struct rt5663_priv {
 	struct snd_soc_jack *hs_jack;
 	struct timer_list btn_check_timer;
 	struct impedance_mapping_table *imp_table;
+	struct regulator_bulk_data supplies[ARRAY_SIZE(rt5663_supply_names)];
 
 	int codec_ver;
 	int sysclk;
@@ -3483,7 +3493,7 @@ static int rt5663_i2c_probe(struct i2c_client *i2c,
 {
 	struct rt5663_platform_data *pdata = dev_get_platdata(&i2c->dev);
 	struct rt5663_priv *rt5663;
-	int ret;
+	int ret, i;
 	unsigned int val;
 	struct regmap *regmap;
 
@@ -3500,6 +3510,37 @@ static int rt5663_i2c_probe(struct i2c_client *i2c,
 	else
 		rt5663_parse_dp(rt5663, &i2c->dev);
 
+	for (i = 0; i < ARRAY_SIZE(rt5663->supplies); i++)
+		rt5663->supplies[i].supply = rt5663_supply_names[i];
+
+	ret = devm_regulator_bulk_get(&i2c->dev,
+				      ARRAY_SIZE(rt5663->supplies),
+				      rt5663->supplies);
+	if (ret) {
+		dev_err(&i2c->dev, "Failed to request supplies: %d\n", ret);
+		return ret;
+	}
+
+	/* Set load for regulator. */
+	for (i = 0; i < ARRAY_SIZE(rt5663->supplies); i++) {
+		ret = regulator_set_load(rt5663->supplies[i].consumer,
+					 RT5663_SUPPLY_CURRENT_UA);
+		if (ret) {
+			dev_err(&i2c->dev,
+				"Failed to set regulator %s, ret: %d\n",
+				rt5663->supplies[i].supply, ret);
+		}
+	}
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(rt5663->supplies),
+				    rt5663->supplies);
+
+	if (ret) {
+		dev_err(&i2c->dev, "Failed to enable supplies: %d\n", ret);
+		return ret;
+	}
+	msleep(RT5663_POWER_ON_DELAY_MS);
+
 	regmap = devm_regmap_init_i2c(i2c, &temp_regmap);
 	if (IS_ERR(regmap)) {
 		ret = PTR_ERR(regmap);
@@ -3530,7 +3571,8 @@ static int rt5663_i2c_probe(struct i2c_client *i2c,
 		dev_err(&i2c->dev,
 			"Device with ID register %#x is not rt5663\n",
 			val);
-		return -ENODEV;
+		ret = -ENODEV;
+		goto err_enable;
 	}
 
 	if (IS_ERR(rt5663->regmap)) {
@@ -3635,20 +3677,30 @@ static int rt5663_i2c_probe(struct i2c_client *i2c,
 		ret = request_irq(i2c->irq, rt5663_irq,
 			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING
 			| IRQF_ONESHOT, "rt5663", rt5663);
-		if (ret)
+		if (ret) {
 			dev_err(&i2c->dev, "%s Failed to reguest IRQ: %d\n",
 				__func__, ret);
+			goto err_enable;
+		}
 	}
 
 	ret = devm_snd_soc_register_component(&i2c->dev,
 			&soc_component_dev_rt5663,
 			rt5663_dai, ARRAY_SIZE(rt5663_dai));
 
-	if (ret) {
-		if (i2c->irq)
-			free_irq(i2c->irq, rt5663);
-	}
+	if (ret)
+		goto err_irq;
 
+	return 0;
+
+err_irq:
+	if (i2c->irq)
+		free_irq(i2c->irq, rt5663);
+
+err_enable:
+	dev_err(&i2c->dev,
+		"%s: Disable regulator after probe error\n", __func__);
+	regulator_bulk_disable(ARRAY_SIZE(rt5663->supplies), rt5663->supplies);
 	return ret;
 }
 
@@ -3659,6 +3711,8 @@ static int rt5663_i2c_remove(struct i2c_client *i2c)
 	if (i2c->irq)
 		free_irq(i2c->irq, rt5663);
 
+	regulator_bulk_disable(ARRAY_SIZE(rt5663->supplies), rt5663->supplies);
+
 	return 0;
 }
 
-- 
2.19.1
