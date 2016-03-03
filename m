From: Zidan Wang <zidan.wang@freescale.com>
Subject: [PATCH] ASoC: wm8994: codec driver should manage its
	own MCLK
Date: Thu, 3 Mar 2016 14:45:35 +0800
Message-ID: <bc33ec0dcfc610657d60d4e1f381545a81147e3e.1456986779.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0131.outbound.protection.outlook.com [157.56.111.131])
 by alsa0.perex.cz (Postfix) with ESMTP id 40AAC26068F
 for <alsa-devel@alsa-project.org>; Thu,  3 Mar 2016 07:42:02 +0100 (CET)
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
Cc: nicoleotsuka@gmail.com, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Zidan Wang <zidan.wang@freescale.com>
List-Id: alsa-devel@alsa-project.org

codec driver should manage its own master clock, MCLK1 and MCLK2.
When bias_level change from standby to prepare, enable codec MCLK.
When bias_level change from prepare to standby, disable codec MCLK.

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
---
 drivers/mfd/wm8994-core.c        |  7 +++++++
 include/linux/mfd/wm8994/pdata.h |  3 +++
 sound/soc/codecs/wm8994.c        | 17 +++++++++++++++--
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/wm8994-core.c b/drivers/mfd/wm8994-core.c
index 7eec619..ace2cea 100644
--- a/drivers/mfd/wm8994-core.c
+++ b/drivers/mfd/wm8994-core.c
@@ -14,6 +14,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/clk.h>
 #include <linux/slab.h>
 #include <linux/i2c.h>
 #include <linux/err.h>
@@ -270,6 +271,7 @@ static int wm8994_set_pdata_from_of(struct wm8994 *wm8994)
 {
 	struct device_node *np = wm8994->dev->of_node;
 	struct wm8994_pdata *pdata = &wm8994->pdata;
+	char tmp[8];
 	int i;
 
 	if (!np)
@@ -310,6 +312,11 @@ static int wm8994_set_pdata_from_of(struct wm8994 *wm8994)
 	if (pdata->ldo[1].enable < 0)
 		pdata->ldo[1].enable = 0;
 
+	for (i = 0; i < WM8994_NUM_MCLK; i++) {
+		sprintf(tmp, "MCLK%d", i + 1);
+		pdata->mclk[i] = devm_clk_get(wm8994->dev, tmp);
+	}
+
 	return 0;
 }
 #else
diff --git a/include/linux/mfd/wm8994/pdata.h b/include/linux/mfd/wm8994/pdata.h
index 90c6052..657a828 100644
--- a/include/linux/mfd/wm8994/pdata.h
+++ b/include/linux/mfd/wm8994/pdata.h
@@ -18,6 +18,7 @@
 #define WM8994_NUM_LDO   2
 #define WM8994_NUM_GPIO 11
 #define WM8994_NUM_AIF   3
+#define WM8994_NUM_MCLK  2
 
 struct wm8994_ldo_pdata {
 	/** GPIOs to enable regulator, 0 or less if not available */
@@ -233,6 +234,8 @@ struct wm8994_pdata {
 	 * GPIO for the IRQ pin if host only supports edge triggering
 	 */
 	int irq_gpio;
+
+	struct clk *mclk[WM8994_NUM_MCLK];
 };
 
 #endif
diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 2ccbb32..7379eae 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -17,6 +17,7 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/gcd.h>
+#include <linux/clk.h>
 #include <linux/i2c.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
@@ -2474,6 +2475,8 @@ static int wm8994_set_bias_level(struct snd_soc_codec *codec,
 {
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 	struct wm8994 *control = wm8994->wm8994;
+	struct wm8994_pdata *pdata = &control->pdata;
+	int i;
 
 	wm_hubs_set_bias_level(codec, level);
 
@@ -2495,8 +2498,13 @@ static int wm8994_set_bias_level(struct snd_soc_codec *codec,
 			break;
 		}
 
-		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_STANDBY)
+		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_STANDBY) {
 			active_reference(codec);
+
+			for (i = 0; i < WM8994_NUM_MCLK; i++)
+				if (!IS_ERR(pdata->mclk[i]))
+					clk_prepare_enable(pdata->mclk[i]);
+		}
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
@@ -2524,8 +2532,13 @@ static int wm8994_set_bias_level(struct snd_soc_codec *codec,
 					    WM8994_LINEOUT2_DISCH);
 		}
 
-		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_PREPARE)
+		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_PREPARE) {
+			for (i = 0; i < WM8994_NUM_MCLK; i++)
+				if (!IS_ERR(pdata->mclk[i]))
+					clk_disable_unprepare(pdata->mclk[i]);
+
 			active_dereference(codec);
+		}
 
 		/* MICBIAS into bypass mode on newer devices */
 		switch (control->type) {
-- 
1.9.1
