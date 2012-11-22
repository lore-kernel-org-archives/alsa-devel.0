From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] mfd: wm8994: Store platform data in device
Date: Thu, 22 Nov 2012 17:12:16 +0900
Message-ID: <1353571937-23506-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 576D62615F3
 for <alsa-devel@alsa-project.org>; Fri, 23 Nov 2012 01:49:39 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Samuel Ortiz <sameo@linux.intel.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

This is better style as platform data is supposed to be discardable after
init (though hotplug usually prevents this) and will ease implementation
of device tree property bindings.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---

Patch 2 which uses this is going to collide with some other ASoC changes
- is it OK to merge this one via the ASoC tree as well?

 drivers/mfd/wm8994-core.c       |   35 +++++++++++++++++++----------------
 include/linux/mfd/wm8994/core.h |    4 ++++
 2 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/mfd/wm8994-core.c b/drivers/mfd/wm8994-core.c
index 5964d6a..7f0c2ba 100644
--- a/drivers/mfd/wm8994-core.c
+++ b/drivers/mfd/wm8994-core.c
@@ -401,13 +401,19 @@ static const __devinitconst struct reg_default wm1811_reva_patch[] = {
  */
 static __devinit int wm8994_device_init(struct wm8994 *wm8994, int irq)
 {
-	struct wm8994_pdata *pdata = wm8994->dev->platform_data;
+	struct wm8994_pdata *pdata;
 	struct regmap_config *regmap_config;
 	const struct reg_default *regmap_patch = NULL;
 	const char *devname;
 	int ret, i, patch_regs;
 	int pulls = 0;
 
+	if (dev_get_platdata(wm8994->dev)) {
+		pdata = dev_get_platdata(wm8994->dev);
+		wm8994->pdata = *pdata;
+	}
+	pdata = &wm8994->pdata;
+
 	dev_set_drvdata(wm8994->dev, wm8994);
 
 	/* Add the on-chip regulators first for bootstrapping */
@@ -604,24 +610,21 @@ static __devinit int wm8994_device_init(struct wm8994 *wm8994, int irq)
 		}
 	}
 
-	if (pdata) {
-		wm8994->irq_base = pdata->irq_base;
-		wm8994->gpio_base = pdata->gpio_base;
-
-		/* GPIO configuration is only applied if it's non-zero */
-		for (i = 0; i < ARRAY_SIZE(pdata->gpio_defaults); i++) {
-			if (pdata->gpio_defaults[i]) {
-				wm8994_set_bits(wm8994, WM8994_GPIO_1 + i,
-						0xffff,
-						pdata->gpio_defaults[i]);
-			}
+	wm8994->irq_base = pdata->irq_base;
+	wm8994->gpio_base = pdata->gpio_base;
+
+	/* GPIO configuration is only applied if it's non-zero */
+	for (i = 0; i < ARRAY_SIZE(pdata->gpio_defaults); i++) {
+		if (pdata->gpio_defaults[i]) {
+			wm8994_set_bits(wm8994, WM8994_GPIO_1 + i,
+					0xffff, pdata->gpio_defaults[i]);
 		}
+	}
 
-		wm8994->ldo_ena_always_driven = pdata->ldo_ena_always_driven;
+	wm8994->ldo_ena_always_driven = pdata->ldo_ena_always_driven;
 
-		if (pdata->spkmode_pu)
-			pulls |= WM8994_SPKMODE_PU;
-	}
+	if (pdata->spkmode_pu)
+		pulls |= WM8994_SPKMODE_PU;
 
 	/* Disable unneeded pulls */
 	wm8994_set_bits(wm8994, WM8994_PULL_CONTROL_2,
diff --git a/include/linux/mfd/wm8994/core.h b/include/linux/mfd/wm8994/core.h
index 1f17330..ae5c249 100644
--- a/include/linux/mfd/wm8994/core.h
+++ b/include/linux/mfd/wm8994/core.h
@@ -19,6 +19,8 @@
 #include <linux/interrupt.h>
 #include <linux/regmap.h>
 
+#include <linux/mfd/wm8994/pdata.h>
+
 enum wm8994_type {
 	WM8994 = 0,
 	WM8958 = 1,
@@ -55,6 +57,8 @@ struct regulator_bulk_data;
 struct wm8994 {
 	struct mutex irq_lock;
 
+	struct wm8994_pdata pdata;
+
 	enum wm8994_type type;
 	int revision;
 	int cust_id;
-- 
1.7.10.4
