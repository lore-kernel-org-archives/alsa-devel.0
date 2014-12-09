From: Zidan Wang <b50113@freescale.com>
Subject: [PATCH v4] ASoC: wm8960: Let wm8960 codec driver
	manage its own MCLK
Date: Tue, 9 Dec 2014 13:45:16 +0800
Message-ID: <1418103916-31295-1-git-send-email-b50113@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0138.outbound.protection.outlook.com [65.55.169.138])
 by alsa0.perex.cz (Postfix) with ESMTP id 009C1260639
 for <alsa-devel@alsa-project.org>; Tue,  9 Dec 2014 06:45:16 +0100 (CET)
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
disable MCLK.

Signed-off-by: Zidan Wang <b50113@freescale.com>
---
 sound/soc/codecs/wm8960.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index 031a1ae..aff24a7 100644
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
@@ -117,6 +119,7 @@ static bool wm8960_volatile(struct device *dev, unsigned int reg)
 }
 
 struct wm8960_priv {
+	struct clk *mclk;
 	struct regmap *regmap;
 	int (*set_bias_level)(struct snd_soc_codec *,
 			      enum snd_soc_bias_level level);
@@ -1002,6 +1005,13 @@ static int wm8960_i2c_probe(struct i2c_client *i2c,
 	if (wm8960 == NULL)
 		return -ENOMEM;
 
+	wm8960->mclk = devm_clk_get(&i2c->dev, "codec_mclk");
+
+	if (IS_ERR(wm8960->mclk)) {
+		if (PTR_ERR(wm8960->mclk) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+	}
+
 	wm8960->regmap = devm_regmap_init_i2c(i2c, &wm8960_regmap);
 	if (IS_ERR(wm8960->regmap))
 		return PTR_ERR(wm8960->regmap);
@@ -1041,6 +1051,9 @@ static int wm8960_i2c_probe(struct i2c_client *i2c,
 
 	i2c_set_clientdata(i2c, wm8960);
 
+	pm_runtime_enable(&i2c->dev);
+	pm_request_idle(&i2c->dev);
+
 	ret = snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_wm8960, &wm8960_dai, 1);
 
@@ -1053,6 +1066,38 @@ static int wm8960_i2c_remove(struct i2c_client *client)
 	return 0;
 }
 
+#ifdef CONFIG_PM_RUNTIME
+static int wm8960_runtime_resume(struct device *dev)
+{
+	struct wm8960_priv *wm8960 = dev_get_drvdata(dev);
+	int ret;
+
+	if (!IS_ERR(wm8960->mclk)) {
+		ret = clk_prepare_enable(wm8960->mclk);
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
+	if (!IS_ERR(wm8960->mclk))
+		clk_disable_unprepare(wm8960->mclk);
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
@@ -1070,6 +1115,7 @@ static struct i2c_driver wm8960_i2c_driver = {
 		.name = "wm8960",
 		.owner = THIS_MODULE,
 		.of_match_table = wm8960_of_match,
+		.pm = &wm8960_pm,
 	},
 	.probe =    wm8960_i2c_probe,
 	.remove =   wm8960_i2c_remove,
-- 
1.9.1
