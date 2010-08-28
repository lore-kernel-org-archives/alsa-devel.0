From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH v2 1/2] ASoC: uda1380: make driver more
	powersave-friendly
Date: Sat, 28 Aug 2010 14:34:56 +0300
Message-ID: <1282995296-24553-1-git-send-email-anarsoul@gmail.com>
References: <20100828091435.GC9324@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 8B2A7243E3
	for <alsa-devel@alsa-project.org>;
	Sat, 28 Aug 2010 13:35:47 +0200 (CEST)
Received: by eyd9 with SMTP id 9so2526448eyd.38
	for <alsa-devel@alsa-project.org>; Sat, 28 Aug 2010 04:35:47 -0700 (PDT)
In-Reply-To: <20100828091435.GC9324@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel <alsa-devel@alsa-project.org>, Philipp Zabel <philipp.zabel@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>
List-Id: alsa-devel@alsa-project.org

Disable some codec modules in standby mode, completely disable
codec in off mode to save some power.
Fix suspend/resume: mark mixer regs as dirty on resume to
restore mixer values, otherwise driver produces no sound
(master is muted by default).

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 sound/soc/codecs/uda1380.c |  139 +++++++++++++++++++++++++++++++------------
 1 files changed, 100 insertions(+), 39 deletions(-)

diff --git a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
index 2f925a2..c8902cc 100644
--- a/sound/soc/codecs/uda1380.c
+++ b/sound/soc/codecs/uda1380.c
@@ -131,7 +131,46 @@ static int uda1380_write(struct snd_soc_codec *codec, unsigned int reg,
 		return -EIO;
 }
 
-#define uda1380_reset(c)	uda1380_write(c, UDA1380_RESET, 0)
+static void uda1380_sync_cache(struct snd_soc_codec *codec)
+{
+	int reg;
+	u8 data[3];
+	u16 *cache = codec->reg_cache;
+
+	/* Sync reg_cache with the hardware */
+	for (reg = 0; reg < UDA1380_MVOL; reg++) {
+		data[0] = reg;
+		data[1] = (cache[reg] & 0xff00) >> 8;
+		data[2] = cache[reg] & 0x00ff;
+		if (codec->hw_write(codec->control_data, data, 3) != 3)
+			dev_err(codec->dev, "%s: write to reg 0x%x failed\n",
+				__func__, reg);
+	}
+}
+
+static int uda1380_reset(struct snd_soc_codec *codec)
+{
+	struct uda1380_platform_data *pdata = codec->dev->platform_data;
+
+	if (pdata->gpio_reset != -EINVAL) {
+		gpio_set_value(pdata->gpio_reset, 1);
+		mdelay(1);
+		gpio_set_value(pdata->gpio_reset, 0);
+	} else {
+		u8 data[3];
+
+		data[0] = UDA1380_RESET;
+		data[1] = 0;
+		data[2] = 0;
+
+		if (codec->hw_write(codec->control_data, data, 3) != 3) {
+			dev_err(codec->dev, "%s: failed\n", __func__);
+			return -EIO;
+		}
+	}
+
+	return 0;
+}
 
 static void uda1380_flush_work(struct work_struct *work)
 {
@@ -562,18 +601,40 @@ static int uda1380_set_bias_level(struct snd_soc_codec *codec,
 	enum snd_soc_bias_level level)
 {
 	int pm = uda1380_read_reg_cache(codec, UDA1380_PM);
+	struct uda1380_platform_data *pdata = codec->dev->platform_data;
+
+	if (codec->bias_level == level)
+		return 0;
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
 	case SND_SOC_BIAS_PREPARE:
+		/* ADC, DAC on */
 		uda1380_write(codec, UDA1380_PM, R02_PON_BIAS | pm);
 		break;
 	case SND_SOC_BIAS_STANDBY:
-		uda1380_write(codec, UDA1380_PM, R02_PON_BIAS);
-		break;
-	case SND_SOC_BIAS_OFF:
+		if (codec->bias_level == SND_SOC_BIAS_OFF) {
+			if (pdata->gpio_power != -EINVAL) {
+				gpio_set_value(pdata->gpio_power, 1);
+				uda1380_reset(codec);
+			}
+
+			uda1380_sync_cache(codec);
+		}
 		uda1380_write(codec, UDA1380_PM, 0x0);
 		break;
+	case SND_SOC_BIAS_OFF:
+		if (pdata->gpio_power != -EINVAL) {
+			int reg;
+			gpio_set_value(pdata->gpio_power, 0);
+
+			/* Mark mixer regs cache dirty to sync them with
+			 * codec regs on power on.
+			 */
+			for (reg = UDA1380_MVOL; reg < UDA1380_CACHEREGNUM;
+				reg++)
+				set_bit(reg - 0x10, &uda1380_cache_dirty);
+		}
 	}
 	codec->bias_level = level;
 	return 0;
@@ -659,16 +720,7 @@ static int uda1380_resume(struct platform_device *pdev)
 {
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
 	struct snd_soc_codec *codec = socdev->card->codec;
-	int i;
-	u8 data[2];
-	u16 *cache = codec->reg_cache;
 
-	/* Sync reg_cache with the hardware */
-	for (i = 0; i < ARRAY_SIZE(uda1380_reg); i++) {
-		data[0] = (i << 1) | ((cache[i] >> 8) & 0x0001);
-		data[1] = cache[i] & 0x00ff;
-		codec->hw_write(codec->control_data, data, 2);
-	}
 	uda1380_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 	return 0;
 }
@@ -698,16 +750,18 @@ static int uda1380_probe(struct platform_device *pdev)
 
 	/* power on device */
 	uda1380_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-	/* set clock input */
+
 	switch (pdata->dac_clk) {
 	case UDA1380_DAC_CLK_SYSCLK:
-		uda1380_write(codec, UDA1380_CLK, 0);
+		uda1380_write_reg_cache(codec, UDA1380_CLK, 0);
 		break;
 	case UDA1380_DAC_CLK_WSPLL:
-		uda1380_write(codec, UDA1380_CLK, R00_DAC_CLK);
+		uda1380_write_reg_cache(codec, UDA1380_CLK,
+			R00_DAC_CLK);
 		break;
 	}
 
+
 	snd_soc_add_controls(codec, uda1380_snd_controls,
 				ARRAY_SIZE(uda1380_snd_controls));
 	uda1380_add_widgets(codec);
@@ -752,22 +806,22 @@ static int uda1380_register(struct uda1380_priv *uda1380)
 		return -EINVAL;
 	}
 
-	if (!pdata || !pdata->gpio_power || !pdata->gpio_reset)
+	if (!pdata)
 		return -EINVAL;
 
-	ret = gpio_request(pdata->gpio_power, "uda1380 power");
-	if (ret)
-		goto err_out;
-	ret = gpio_request(pdata->gpio_reset, "uda1380 reset");
-	if (ret)
-		goto err_gpio;
-
-	gpio_direction_output(pdata->gpio_power, 1);
+	if (pdata->gpio_power != -EINVAL) {
+		ret = gpio_request(pdata->gpio_power, "uda1380 power");
+		if (ret)
+			goto err_out;
+		gpio_direction_output(pdata->gpio_power, 0);
+	}
 
-	/* we may need to have the clock running here - pH5 */
-	gpio_direction_output(pdata->gpio_reset, 1);
-	udelay(5);
-	gpio_set_value(pdata->gpio_reset, 0);
+	if (pdata->gpio_reset != -EINVAL) {
+		ret = gpio_request(pdata->gpio_reset, "uda1380 reset");
+		if (ret)
+			goto err_gpio;
+		gpio_direction_output(pdata->gpio_reset, 0);
+	}
 
 	mutex_init(&codec->mutex);
 	INIT_LIST_HEAD(&codec->dapm_widgets);
@@ -788,10 +842,12 @@ static int uda1380_register(struct uda1380_priv *uda1380)
 
 	memcpy(codec->reg_cache, uda1380_reg, sizeof(uda1380_reg));
 
-	ret = uda1380_reset(codec);
-	if (ret < 0) {
-		dev_err(codec->dev, "Failed to issue reset\n");
-		goto err_reset;
+	if (pdata->gpio_power == -EINVAL) {
+		ret = uda1380_reset(codec);
+		if (ret < 0) {
+			dev_err(codec->dev, "Failed to issue reset\n");
+			goto err_reset;
+		}
 	}
 
 	INIT_WORK(&uda1380->work, uda1380_flush_work);
@@ -818,10 +874,11 @@ static int uda1380_register(struct uda1380_priv *uda1380)
 err_dai:
 	snd_soc_unregister_codec(codec);
 err_reset:
-	gpio_set_value(pdata->gpio_power, 0);
-	gpio_free(pdata->gpio_reset);
+	if (pdata->gpio_reset != -EINVAL)
+		gpio_free(pdata->gpio_reset);
 err_gpio:
-	gpio_free(pdata->gpio_power);
+	if (pdata->gpio_power != -EINVAL)
+		gpio_free(pdata->gpio_power);
 err_out:
 	return ret;
 }
@@ -834,9 +891,13 @@ static void uda1380_unregister(struct uda1380_priv *uda1380)
 	snd_soc_unregister_dais(uda1380_dai, ARRAY_SIZE(uda1380_dai));
 	snd_soc_unregister_codec(&uda1380->codec);
 
-	gpio_set_value(pdata->gpio_power, 0);
-	gpio_free(pdata->gpio_reset);
-	gpio_free(pdata->gpio_power);
+	if (pdata->gpio_power != -EINVAL) {
+		gpio_set_value(pdata->gpio_power, 0);
+		gpio_free(pdata->gpio_power);
+	}
+
+	if (pdata->gpio_reset != -EINVAL)
+		gpio_free(pdata->gpio_reset);
 
 	kfree(uda1380);
 	uda1380_codec = NULL;
-- 
1.7.2
