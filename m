From: Zidan Wang <b50113@freescale.com>
Subject: [PATCH] ASoC: wm8960: Let wm8960 codec driver manage
	its own MCLK
Date: Wed, 3 Dec 2014 19:00:38 +0800
Message-ID: <1417604438-28362-1-git-send-email-b50113@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0144.outbound.protection.outlook.com [65.55.169.144])
 by alsa0.perex.cz (Postfix) with ESMTP id ECEDF261A96
 for <alsa-devel@alsa-project.org>; Wed,  3 Dec 2014 11:59:55 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, tiwai@suse.de, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, Li.Xiubo@freescale.com, Zidan Wang <b50113@freescale.com>, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

When we want to use wm8960 codec, we should enable its MCLK in machine
driver. It's reasonable for wm8960 codec driver to manage its own MCLK to
save power.

Enable runtime power management, and auto enable/disable MCLK in pm_runtime
resume and suspend. When wm8960 codec is being used, it will triger resume()
to enable MCLK. When codec is not being used, it will triger suspend() to
disable MCLK and power down PLL.

Signed-off-by: Zidan Wang <b50113@freescale.com>
---
 include/sound/wm8960.h    |  1 +
 sound/soc/codecs/wm8960.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

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
index 031a1ae..6a529b1 100644
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
@@ -988,6 +990,8 @@ static void wm8960_set_pdata_from_of(struct i2c_client *i2c,
 
 	if (of_property_read_bool(np, "wlf,shared-lrclk"))
 		pdata->shared_lrclk = true;
+
+	pdata->mclk = devm_clk_get(&i2c->dev, NULL);
 }
 
 static int wm8960_i2c_probe(struct i2c_client *i2c,
@@ -1011,6 +1015,14 @@ static int wm8960_i2c_probe(struct i2c_client *i2c,
 	else if (i2c->dev.of_node)
 		wm8960_set_pdata_from_of(i2c, &wm8960->pdata);
 
+    /* Mark the mclk pointer to NULL if no mclk assigned */
+	if (IS_ERR(wm8960->pdata.mclk)) {
+		/* But do not ignore the request for probe defer */
+		if (PTR_ERR(wm8960->pdata.mclk) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+		wm8960->pdata.mclk = NULL;
+	}
+
 	ret = wm8960_reset(wm8960->regmap);
 	if (ret != 0) {
 		dev_err(&i2c->dev, "Failed to issue reset\n");
@@ -1041,6 +1053,9 @@ static int wm8960_i2c_probe(struct i2c_client *i2c,
 
 	i2c_set_clientdata(i2c, wm8960);
 
+	pm_runtime_enable(&i2c->dev);
+	pm_request_idle(&i2c->dev);
+
 	ret = snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_wm8960, &wm8960_dai, 1);
 
@@ -1053,6 +1068,41 @@ static int wm8960_i2c_remove(struct i2c_client *client)
 	return 0;
 }
 
+#ifdef CONFIG_PM_RUNTIME
+static int wm8960_runtime_resume(struct device *dev)
+{
+	struct wm8960_priv *wm8960 = dev_get_drvdata(dev);
+	int ret;
+
+	if (wm8960->pdata.mclk) {
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
+	/* Power down PLL to save power */
+	regmap_update_bits(wm8960->regmap, WM8960_POWER2, 0x1, 0);
+
+	if (wm8960->pdata.mclk)
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
@@ -1070,6 +1120,7 @@ static struct i2c_driver wm8960_i2c_driver = {
 		.name = "wm8960",
 		.owner = THIS_MODULE,
 		.of_match_table = wm8960_of_match,
+		.pm = &wm8960_pm,
 	},
 	.probe =    wm8960_i2c_probe,
 	.remove =   wm8960_i2c_remove,
-- 
1.9.1
