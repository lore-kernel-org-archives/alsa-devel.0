From: Zidan Wang <b50113@freescale.com>
Subject: [PATCH 1/4] ASoC: wm8960: Let wm8960 codec driver
	manage its own MCLK
Date: Wed, 31 Dec 2014 11:39:11 +0800
Message-ID: <1419997154-860-1-git-send-email-b50113@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0108.outbound.protection.outlook.com [65.55.169.108])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B4A926087F
 for <alsa-devel@alsa-project.org>; Wed, 31 Dec 2014 04:38:22 +0100 (CET)
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

When we want to use wm8960 codec, we should enable its MCLK in machine driver.
It's reasonable for wm8960 codec driver to manage its own MCLK.

When current bias_level is SND_SOC_BIAS_ON, it is preparing for a transition
away from ON. In this case, disable the codec mclk. When current bias_level
is not SND_SOC_BIAS_ON, it preparing for a transition to ON. In this case,
enable the codec mclk.

Signed-off-by: Zidan Wang <b50113@freescale.com>
---
 sound/soc/codecs/wm8960.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index 031a1ae..1a5f47b 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/pm.h>
+#include <linux/clk.h>
 #include <linux/i2c.h>
 #include <linux/slab.h>
 #include <sound/core.h>
@@ -117,6 +118,7 @@ static bool wm8960_volatile(struct device *dev, unsigned int reg)
 }
 
 struct wm8960_priv {
+	struct clk *mclk;
 	struct regmap *regmap;
 	int (*set_bias_level)(struct snd_soc_codec *,
 			      enum snd_soc_bias_level level);
@@ -618,6 +620,7 @@ static int wm8960_set_bias_level_out3(struct snd_soc_codec *codec,
 				      enum snd_soc_bias_level level)
 {
 	struct wm8960_priv *wm8960 = snd_soc_codec_get_drvdata(codec);
+	int ret;
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
@@ -626,6 +629,20 @@ static int wm8960_set_bias_level_out3(struct snd_soc_codec *codec,
 	case SND_SOC_BIAS_PREPARE:
 		/* Set VMID to 2x50k */
 		snd_soc_update_bits(codec, WM8960_POWER1, 0x180, 0x80);
+
+		if (!IS_ERR(wm8960->mclk)) {
+			if (codec->dapm.bias_level == SND_SOC_BIAS_ON)
+				clk_disable_unprepare(wm8960->mclk);
+			else {
+				ret = clk_prepare_enable(wm8960->mclk);
+				if (ret) {
+					dev_err(codec->dev,
+						"Failed to enable MCLK: %d\n",
+						ret);
+					return ret;
+				}
+			}
+		}
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
@@ -661,6 +678,7 @@ static int wm8960_set_bias_level_out3(struct snd_soc_codec *codec,
 
 		/* Disable VMID and VREF, let them discharge */
 		snd_soc_write(codec, WM8960_POWER1, 0);
+
 		msleep(600);
 		break;
 	}
@@ -674,7 +692,7 @@ static int wm8960_set_bias_level_capless(struct snd_soc_codec *codec,
 					 enum snd_soc_bias_level level)
 {
 	struct wm8960_priv *wm8960 = snd_soc_codec_get_drvdata(codec);
-	int reg;
+	int reg, ret;
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
@@ -715,9 +733,22 @@ static int wm8960_set_bias_level_capless(struct snd_soc_codec *codec,
 					    WM8960_VREF, WM8960_VREF);
 
 			msleep(100);
+
+			if (!IS_ERR(wm8960->mclk)) {
+				ret = clk_prepare_enable(wm8960->mclk);
+				if (ret) {
+					dev_err(codec->dev,
+						"Failed to enable MCLK: %d\n",
+						ret);
+					return ret;
+				}
+			}
 			break;
 
 		case SND_SOC_BIAS_ON:
+			if (!IS_ERR(wm8960->mclk))
+				clk_disable_unprepare(wm8960->mclk);
+
 			/* Enable anti-pop mode */
 			snd_soc_update_bits(codec, WM8960_APOP1,
 					    WM8960_POBCTRL | WM8960_SOFT_ST |
@@ -728,6 +759,7 @@ static int wm8960_set_bias_level_capless(struct snd_soc_codec *codec,
 			/* Disable VMID and VREF */
 			snd_soc_update_bits(codec, WM8960_POWER1,
 					    WM8960_VREF | WM8960_VMID_MASK, 0);
+
 			break;
 
 		case SND_SOC_BIAS_OFF:
@@ -1002,6 +1034,12 @@ static int wm8960_i2c_probe(struct i2c_client *i2c,
 	if (wm8960 == NULL)
 		return -ENOMEM;
 
+	wm8960->mclk = devm_clk_get(&i2c->dev, "codec_mclk");
+	if (IS_ERR(wm8960->mclk)) {
+		if (PTR_ERR(wm8960->mclk) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+	}
+
 	wm8960->regmap = devm_regmap_init_i2c(i2c, &wm8960_regmap);
 	if (IS_ERR(wm8960->regmap))
 		return PTR_ERR(wm8960->regmap);
-- 
1.9.1
