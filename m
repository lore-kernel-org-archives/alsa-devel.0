From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/3] ASoC: Remove ASoC-specific WM8994 I/O code
Date: Mon, 28 Nov 2011 23:15:49 +0000
Message-ID: <1322522150-4350-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20111128231513.GA1608@opensource.wolfsonmicro.com>
	<1322522150-4350-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5EB0010396B
	for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2011 00:16:01 +0100 (CET)
In-Reply-To: <1322522150-4350-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Samuel Ortiz <sameo@linux.intel.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Just go directly to the regmap API, saving code and making integration
that bit more direct.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |   63 ++++++++------------------------------------
 1 files changed, 12 insertions(+), 51 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index eb0020f..813ec28 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -114,44 +114,6 @@ static int wm8994_volatile(struct snd_soc_codec *codec, unsigned int reg)
 	}
 }
 
-static int wm8994_write(struct snd_soc_codec *codec, unsigned int reg,
-	unsigned int value)
-{
-	int ret;
-
-	BUG_ON(reg > WM8994_MAX_REGISTER);
-
-	if (!wm8994_volatile(codec, reg)) {
-		ret = snd_soc_cache_write(codec, reg, value);
-		if (ret != 0)
-			dev_err(codec->dev, "Cache write to %x failed: %d\n",
-				reg, ret);
-	}
-
-	return wm8994_reg_write(codec->control_data, reg, value);
-}
-
-static unsigned int wm8994_read(struct snd_soc_codec *codec,
-				unsigned int reg)
-{
-	unsigned int val;
-	int ret;
-
-	BUG_ON(reg > WM8994_MAX_REGISTER);
-
-	if (!wm8994_volatile(codec, reg) && wm8994_readable(codec, reg) &&
-	    reg < codec->driver->reg_cache_size) {
-		ret = snd_soc_cache_read(codec, reg, &val);
-		if (ret >= 0)
-			return val;
-		else
-			dev_err(codec->dev, "Cache read from %x failed: %d\n",
-				reg, ret);
-	}
-
-	return wm8994_reg_read(codec->control_data, reg);
-}
-
 static int configure_aif_clock(struct snd_soc_codec *codec, int aif)
 {
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
@@ -2660,8 +2622,8 @@ static int wm8994_resume(struct snd_soc_codec *codec)
 
 	if (wm8994->revision < 4) {
 		/* force a HW read */
-		val = wm8994_reg_read(codec->control_data,
-				      WM8994_POWER_MANAGEMENT_5);
+		ret = regmap_read(control->regmap,
+				  WM8994_POWER_MANAGEMENT_5, &val);
 
 		/* modify the cache only */
 		codec->cache_only = 1;
@@ -3103,19 +3065,20 @@ static irqreturn_t wm8994_temp_shut(int irq, void *data)
 
 static int wm8994_codec_probe(struct snd_soc_codec *codec)
 {
-	struct wm8994 *control;
+	struct wm8994 *control = dev_get_drvdata(codec->dev->parent);
 	struct wm8994_priv *wm8994;
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
+	unsigned int reg;
 	int ret, i;
 
-	codec->control_data = dev_get_drvdata(codec->dev->parent);
-	control = codec->control_data;
+	codec->control_data = control->regmap;
 
 	wm8994 = kzalloc(sizeof(struct wm8994_priv), GFP_KERNEL);
 	if (wm8994 == NULL)
 		return -ENOMEM;
 	snd_soc_codec_set_drvdata(codec, wm8994);
 
+	snd_soc_codec_set_cache_io(codec, 16, 16, SND_SOC_REGMAP);
 
 	wm8994->wm8994 = dev_get_drvdata(codec->dev->parent);
 	wm8994->pdata = dev_get_platdata(codec->dev->parent);
@@ -3139,11 +3102,11 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 		if (!wm8994_readable(codec, i) || wm8994_volatile(codec, i))
 			continue;
 
-		ret = wm8994_reg_read(codec->control_data, i);
+		ret = regmap_read(control->regmap, i, &reg);
 		if (ret <= 0)
 			continue;
 
-		ret = snd_soc_cache_write(codec, i, ret);
+		ret = snd_soc_cache_write(codec, i, reg);
 		if (ret != 0) {
 			dev_err(codec->dev,
 				"Failed to initialise cache for 0x%x: %d\n",
@@ -3281,24 +3244,24 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 	 * configured on init - if a system wants to do this dynamically
 	 * at runtime we can deal with that then.
 	 */
-	ret = wm8994_reg_read(codec->control_data, WM8994_GPIO_1);
+	ret = regmap_read(control->regmap, WM8994_GPIO_1, &reg);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to read GPIO1 state: %d\n", ret);
 		goto err_irq;
 	}
-	if ((ret & WM8994_GPN_FN_MASK) != WM8994_GP_FN_PIN_SPECIFIC) {
+	if ((reg & WM8994_GPN_FN_MASK) != WM8994_GP_FN_PIN_SPECIFIC) {
 		wm8994->lrclk_shared[0] = 1;
 		wm8994_dai[0].symmetric_rates = 1;
 	} else {
 		wm8994->lrclk_shared[0] = 0;
 	}
 
-	ret = wm8994_reg_read(codec->control_data, WM8994_GPIO_6);
+	ret = regmap_read(control->regmap, WM8994_GPIO_6, &reg);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to read GPIO6 state: %d\n", ret);
 		goto err_irq;
 	}
-	if ((ret & WM8994_GPN_FN_MASK) != WM8994_GP_FN_PIN_SPECIFIC) {
+	if ((reg & WM8994_GPN_FN_MASK) != WM8994_GP_FN_PIN_SPECIFIC) {
 		wm8994->lrclk_shared[1] = 1;
 		wm8994_dai[1].symmetric_rates = 1;
 	} else {
@@ -3550,8 +3513,6 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8994 = {
 	.remove =	wm8994_codec_remove,
 	.suspend =	wm8994_suspend,
 	.resume =	wm8994_resume,
-	.read =		wm8994_read,
-	.write =	wm8994_write,
 	.readable_register = wm8994_readable,
 	.volatile_register = wm8994_volatile,
 	.set_bias_level = wm8994_set_bias_level,
-- 
1.7.7.3
