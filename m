From: Zidan Wang <b50113@freescale.com>
Subject: [alsa-devel][PATCH v3] ASoC: wm8960: Let wm8960 codec driver manage its own MCLK
Date: Thu, 4 Dec 2014 20:41:19 +0800
Message-ID: <1417696879-15402-1-git-send-email-b50113@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, lars@metafoo.de, ckeepax@opensource.wolfsonmicro.com, Li.Xiubo@freescale.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Zidan Wang <b50113@freescale.com>
List-Id: alsa-devel@alsa-project.org

When we want to use wm8960 codec, we should enable its MCLK in machine
driver. It's reasonable for wm8960 codec driver to manage its own MCLK to
save power.

If platform data is not supplied, we will get MCLK from device tree and check
the return code to handle probe deferral.

Enable runtime power management, and auto enable/disable MCLK in pm_runtime
resume and suspend. When wm8960 codec is being used, it will triger resume()
to enable MCLK. When codec is not being used, it will triger suspend() to
disable MCLK.

Signed-off-by: Zidan Wang <b50113@freescale.com>
---
 include/sound/wm8960.h    |  1 +
 sound/soc/codecs/wm8960.c | 56 ++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 54 insertions(+), 3 deletions(-)

diff --git a/include/sound/wm8960.h b/include/sound/wm8960.h
index e8ce8ee..d7e84ed 100644
--- a/include/sound/wm8960.h
+++ b/include/sound/wm8960.h
@@ -16,6 +16,7 @@
 #define WM8960_DRES_MAX  3
 
 struct wm8960_data {
+	struct clk *mclk;
 	bool capless;  /* Headphone outputs configured in capless mode */
 
 	bool shared_lrclk;  /* DAC and ADC LRCLKs are wired together */
diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index 031a1ae..ea5f0b7 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -15,6 +15,8 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/pm.h>
+#include <linux/clk.h>
+#include <linux/pm_runtime.h>
 #include <linux/i2c.h>
 #include <linux/slab.h>
 #include <sound/core.h>
@@ -978,7 +980,7 @@ static const struct regmap_config wm8960_regmap = {
 	.volatile_reg = wm8960_volatile,
 };
 
-static void wm8960_set_pdata_from_of(struct i2c_client *i2c,
+static int wm8960_set_pdata_from_of(struct i2c_client *i2c,
 				struct wm8960_data *pdata)
 {
 	const struct device_node *np = i2c->dev.of_node;
@@ -988,6 +990,15 @@ static void wm8960_set_pdata_from_of(struct i2c_client *i2c,
 
 	if (of_property_read_bool(np, "wlf,shared-lrclk"))
 		pdata->shared_lrclk = true;
+
+	pdata->mclk = devm_clk_get(&i2c->dev, NULL);
+
+	if (IS_ERR(pdata->mclk)) {
+		if (PTR_ERR(pdata->mclk) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+	}
+
+	return 0;
 }
 
 static int wm8960_i2c_probe(struct i2c_client *i2c,
@@ -1008,8 +1019,11 @@ static int wm8960_i2c_probe(struct i2c_client *i2c,
 
 	if (pdata)
 		memcpy(&wm8960->pdata, pdata, sizeof(struct wm8960_data));
-	else if (i2c->dev.of_node)
-		wm8960_set_pdata_from_of(i2c, &wm8960->pdata);
+	else if (i2c->dev.of_node) {
+		ret = wm8960_set_pdata_from_of(i2c, &wm8960->pdata);
+		if (ret != 0)
+			return ret;
+	}
 
 	ret = wm8960_reset(wm8960->regmap);
 	if (ret != 0) {
@@ -1041,6 +1055,9 @@ static int wm8960_i2c_probe(struct i2c_client *i2c,
 
 	i2c_set_clientdata(i2c, wm8960);
 
+	pm_runtime_enable(&i2c->dev);
+	pm_request_idle(&i2c->dev);
+
 	ret = snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_wm8960, &wm8960_dai, 1);
 
@@ -1053,6 +1070,38 @@ static int wm8960_i2c_remove(struct i2c_client *client)
 	return 0;
 }
 
+#ifdef CONFIG_PM_RUNTIME
+static int wm8960_runtime_resume(struct device *dev)
+{
+	struct wm8960_priv *wm8960 = dev_get_drvdata(dev);
+	int ret;
+
+	if (!IS_ERR(wm8960->pdata.mclk)) {
+		ret = clk_prepare_enable(wm8960->pdata.mclk);
+		if (ret) {
+			dev_err(dev, "Failed to enable MCLK: %d\n", ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int wm8960_runtime_suspend(struct device *dev)
+{
+	struct wm8960_priv *wm8960 = dev_get_drvdata(dev);
+
+	if (!IS_ERR(wm8960->pdata.mclk))
+		clk_disable_unprepare(wm8960->pdata.mclk);
+
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops wm8960_pm = {
+	SET_RUNTIME_PM_OPS(wm8960_runtime_suspend, wm8960_runtime_resume, NULL)
+};
+
 static const struct i2c_device_id wm8960_i2c_id[] = {
 	{ "wm8960", 0 },
 	{ }
@@ -1070,6 +1119,7 @@ static struct i2c_driver wm8960_i2c_driver = {
 		.name = "wm8960",
 		.owner = THIS_MODULE,
 		.of_match_table = wm8960_of_match,
+		.pm = &wm8960_pm,
 	},
 	.probe =    wm8960_i2c_probe,
 	.remove =   wm8960_i2c_remove,
-- 
1.9.1
