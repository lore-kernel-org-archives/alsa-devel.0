From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH v2] ASoC: wm8962: Let CODEC driver enable and
	disable its own MCLK
Date: Mon, 28 Jul 2014 19:41:58 +0800
Message-ID: <1406547718-21498-1-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0204.outbound.protection.outlook.com [207.46.163.204])
 by alsa0.perex.cz (Postfix) with ESMTP id C1922261740
 for <alsa-devel@alsa-project.org>; Mon, 28 Jul 2014 13:39:36 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, b02247@freescale.com, linux-kernel@vger.kernel.org, b42378@freescale.com
List-Id: alsa-devel@alsa-project.org

snd_soc_open() will trigger pm_runtime resume() which will then enable
the regulator and initialization. So we should make sure the MCLK is
enabled before this resume().

Previously we let the machine driver get the clock and enable it in
its probe(). However, considering about power saving, it'll be better
to enable it when it's going to be used and disable it after using.

So this patch just simply adds clk_get() and clk_enable() to WM8962
driver. Meanwhile, it marks clock pointer to NULL if no clock assigned
to it so it will not break any current function.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---

Changelog:
v2
 * Use wm8962->pdata.mclk instead.

 include/sound/wm8962.h    |  1 +
 sound/soc/codecs/wm8962.c | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/sound/wm8962.h b/include/sound/wm8962.h
index 79e6d42..0af7c16 100644
--- a/include/sound/wm8962.h
+++ b/include/sound/wm8962.h
@@ -37,6 +37,7 @@
 #define WM8962_GPIO_FN_MICSCD          22
 
 struct wm8962_pdata {
+	struct clk *mclk;
 	int gpio_base;
 	u32 gpio_init[WM8962_MAX_GPIO];
 
diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index ca2fda9..28a2c21 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/init.h>
+#include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/gcd.h>
@@ -3541,6 +3542,8 @@ static int wm8962_set_pdata_from_of(struct i2c_client *i2c,
 				pdata->gpio_init[i] = 0x0;
 		}
 
+	pdata->mclk = devm_clk_get(&i2c->dev, NULL);
+
 	return 0;
 }
 
@@ -3572,6 +3575,10 @@ static int wm8962_i2c_probe(struct i2c_client *i2c,
 			return ret;
 	}
 
+	/* Mark the mclk pointer to NULL if no mclk assigned */
+	if (IS_ERR(wm8962->pdata.mclk))
+		wm8962->pdata.mclk = NULL;
+
 	for (i = 0; i < ARRAY_SIZE(wm8962->supplies); i++)
 		wm8962->supplies[i].supply = wm8962_supply_names[i];
 
@@ -3780,6 +3787,8 @@ static int wm8962_runtime_resume(struct device *dev)
 	struct wm8962_priv *wm8962 = dev_get_drvdata(dev);
 	int ret;
 
+	clk_prepare_enable(wm8962->pdata.mclk);
+
 	ret = regulator_bulk_enable(ARRAY_SIZE(wm8962->supplies),
 				    wm8962->supplies);
 	if (ret != 0) {
@@ -3839,6 +3848,8 @@ static int wm8962_runtime_suspend(struct device *dev)
 	regulator_bulk_disable(ARRAY_SIZE(wm8962->supplies),
 			       wm8962->supplies);
 
+	clk_disable_unprepare(wm8962->pdata.mclk);
+
 	return 0;
 }
 #endif
-- 
1.8.4
