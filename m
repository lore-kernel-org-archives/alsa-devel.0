From: Inha Song <ideal.song@samsung.com>
Subject: [alsa-devel] [PATCH] ASoC: wm8994: Manage wm8994's MCLK in codec driver
Date: Thu, 12 Mar 2015 11:49:39 +0900
Message-ID: <1426128580-18320-1-git-send-email-ideal.song@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, alsa-devel@alsa-project.org
Cc: patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, ckeepax@opensource.wolfsonmicro.com, nikesh@opensource.wolfsonmicro.com, lars@metafoo.de, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, Li.Xiubo@freescale.com, sachin.kamat@samsung.com, cw00.choi@samsung.com, Inha Song <ideal.song@samsung.com>
List-Id: alsa-devel@alsa-project.org

Previously, When we use wm8994 codec, we should control its MCLK in machine driver.
But, It should be managed by wm8994 codec driver, not machine driver.

This patch add MCLK clock DT parsing logic and control own MCLK.

Signed-off-by: Inha Song <ideal.song@samsung.com>
---
 sound/soc/codecs/wm8994.c | 27 ++++++++++++++++++++++++++-
 sound/soc/codecs/wm8994.h |  1 +
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 247b390..d80dcc6 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/pm.h>
+#include <linux/clk.h>
 #include <linux/gcd.h>
 #include <linux/i2c.h>
 #include <linux/platform_device.h>
@@ -2470,6 +2471,7 @@ static int wm8994_set_bias_level(struct snd_soc_codec *codec,
 {
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 	struct wm8994 *control = wm8994->wm8994;
+	int i;
 
 	wm_hubs_set_bias_level(codec, level);
 
@@ -2491,8 +2493,19 @@ static int wm8994_set_bias_level(struct snd_soc_codec *codec,
 			break;
 		}
 
-		if (codec->dapm.bias_level == SND_SOC_BIAS_STANDBY)
+		if (codec->dapm.bias_level == SND_SOC_BIAS_STANDBY) {
+			for (i = 0; i < ARRAY_SIZE(wm8994->clk_mclk); i++) {
+				if (!IS_ERR(wm8994->clk_mclk[i]))
+					clk_prepare_enable(wm8994->clk_mclk[i]);
+			}
 			active_reference(codec);
+		} else if (codec->dapm.bias_level == SND_SOC_BIAS_ON) {
+			for (i = 0; i < ARRAY_SIZE(wm8994->clk_mclk); i++) {
+				if (!IS_ERR(wm8994->clk_mclk[i]))
+					clk_disable_unprepare(
+							wm8994->clk_mclk[i]);
+			}
+		}
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
@@ -4451,6 +4464,7 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8994 = {
 static int wm8994_probe(struct platform_device *pdev)
 {
 	struct wm8994_priv *wm8994;
+	int i;
 
 	wm8994 = devm_kzalloc(&pdev->dev, sizeof(struct wm8994_priv),
 			      GFP_KERNEL);
@@ -4460,6 +4474,17 @@ static int wm8994_probe(struct platform_device *pdev)
 
 	wm8994->wm8994 = dev_get_drvdata(pdev->dev.parent);
 
+	for (i = 0; i < ARRAY_SIZE(wm8994->clk_mclk); i++) {
+		char mclk_name[] = "MCLKx";
+
+		snprintf(mclk_name, sizeof(mclk_name), "MCLK%d", i + 1);
+
+		wm8994->clk_mclk[i] = devm_clk_get(pdev->dev.parent, mclk_name);
+		if (IS_ERR(wm8994->clk_mclk[i]))
+			if (PTR_ERR(wm8994->clk_mclk) == -EPROBE_DEFER)
+				return -EPROBE_DEFER;
+	}
+
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_idle(&pdev->dev);
 
diff --git a/sound/soc/codecs/wm8994.h b/sound/soc/codecs/wm8994.h
index 6536f8d..8cf06a4 100644
--- a/sound/soc/codecs/wm8994.h
+++ b/sound/soc/codecs/wm8994.h
@@ -78,6 +78,7 @@ struct wm8994_priv {
 	int sysclk[2];
 	int sysclk_rate[2];
 	int mclk[2];
+	struct clk *clk_mclk[2];
 	int aifclk[2];
 	int aifdiv[2];
 	int channels[2];
-- 
2.0.0.390.gcb682f8
