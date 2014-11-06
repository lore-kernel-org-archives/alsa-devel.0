From: <bardliao@realtek.com>
Subject: [PATCH 1/4] ASoC:rt5670:Add runtime PM support
Date: Thu, 6 Nov 2014 12:23:51 +0800
Message-ID: <1415247834-14278-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 220042614D6
 for <alsa-devel@alsa-project.org>; Thu,  6 Nov 2014 05:24:36 +0100 (CET)
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, mengdong.lin@intel.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

From: Bard Liao <bardliao@realtek.com>

This patch adds runtime PM support on rt5670 codec. And will switch
sysclk to internal clock during runtime suspend.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5670.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index da4b689..97359b3 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -14,6 +14,7 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/pm.h>
+#include <linux/pm_runtime.h>
 #include <linux/i2c.h>
 #include <linux/platform_device.h>
 #include <linux/firmware.h>
@@ -2666,6 +2667,13 @@ static int rt5670_i2c_probe(struct i2c_client *i2c,
 	/*Give sysclk a default value*/
 	rt5670->sysclk = 24576000;
 
+	/* The set initial power status to active, to be consist with ACPI power
+	 * state D0. The codec will be suspended after probe and runtime status
+	 * change will trigger ACPI D3 method for power saving.
+	 */
+	pm_runtime_set_active(&i2c->dev);
+	pm_runtime_enable(&i2c->dev);
+
 	ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_rt5670,
 			rt5670_dai, ARRAY_SIZE(rt5670_dai));
 	if (ret < 0)
@@ -2673,20 +2681,61 @@ static int rt5670_i2c_probe(struct i2c_client *i2c,
 
 	return 0;
 err:
+	pm_runtime_disable(&i2c->dev);
+
 	return ret;
 }
 
 static int rt5670_i2c_remove(struct i2c_client *i2c)
 {
+	pm_runtime_disable(&i2c->dev);
 	snd_soc_unregister_codec(&i2c->dev);
 
 	return 0;
 }
 
+#ifdef CONFIG_PM_RUNTIME
+static void rt5670_use_internal_clk(struct rt5670_priv *rt5670)
+{
+	struct snd_soc_codec *codec = rt5670->codec;
+
+	if (!codec ||
+	   (0 == rt5670->sysclk && RT5670_SCLK_S_RCCLK == rt5670->sysclk_src))
+		return;
+
+	snd_soc_update_bits(codec, RT5670_GLB_CLK,
+			RT5670_SCLK_SRC_MASK, RT5670_SCLK_SRC_RCCLK);
+
+	rt5670->sysclk = 0;
+	rt5670->sysclk_src = RT5670_SCLK_S_RCCLK;
+}
+
+static int rt5670_runtime_suspend(struct device *dev)
+{
+	struct rt5670_priv *rt5670 = dev_get_drvdata(dev);
+
+	rt5670_use_internal_clk(rt5670);
+	return 0;
+}
+
+static int rt5670_runtime_resume(struct device *dev)
+{
+	return 0;
+}
+
+static const struct dev_pm_ops rt5670_pm = {
+	SET_RUNTIME_PM_OPS(rt5670_runtime_suspend, rt5670_runtime_resume, NULL)
+};
+#define RT5670_PM_OPS	rt5670_pm
+#else
+#define RT5670_PM_OPS	NULL
+#endif /* CONFIG_PM_RUNTIME */
+
 static struct i2c_driver rt5670_i2c_driver = {
 	.driver = {
 		.name = "rt5670",
 		.owner = THIS_MODULE,
+		.pm = &RT5670_PM_OPS,
 	},
 	.probe = rt5670_i2c_probe,
 	.remove   = rt5670_i2c_remove,
-- 
1.8.1.1.439.g50a6b54
