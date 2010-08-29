From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH v6 1/3] ASoC: uda1380: make driver more
	powersave-friendly
Date: Sun, 29 Aug 2010 22:33:48 +0300
Message-ID: <1283110428-23007-1-git-send-email-anarsoul@gmail.com>
References: <1283107824-16791-1-git-send-email-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 5720F103801
	for <alsa-devel@alsa-project.org>;
	Sun, 29 Aug 2010 21:34:15 +0200 (CEST)
Received: by eyd9 with SMTP id 9so2765841eyd.38
	for <alsa-devel@alsa-project.org>; Sun, 29 Aug 2010 12:34:15 -0700 (PDT)
In-Reply-To: <1283107824-16791-1-git-send-email-anarsoul@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel <alsa-devel@alsa-project.org>, Philipp Zabel <philipp.zabel@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>, marek.vasut
List-Id: alsa-devel@alsa-project.org

Disable some codec modules in standby mode, completely disable
codec in off mode to save some power.
Fix suspend/resume: mark mixer regs as dirty on resume to
restore mixer values, otherwise driver produces no sound
(master is muted by default).

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 sound/soc/codecs/uda1380.c |  145 ++++++++++++++++++++++++++++++++------------
 1 files changed, 105 insertions(+), 40 deletions(-)

diff --git a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
index 1a51c81..488f801 100644
--- a/sound/soc/codecs/uda1380.c
+++ b/sound/soc/codecs/uda1380.c
@@ -39,6 +39,7 @@ struct uda1380_priv {
 	u16 reg_cache[UDA1380_CACHEREGNUM];
 	unsigned int dac_clk;
 	struct work_struct work;
+	void *control_data;
 };
 
 /*
@@ -129,7 +130,46 @@ static int uda1380_write(struct snd_soc_codec *codec, unsigned int reg,
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
+	if (gpio_is_valid(pdata->gpio_reset)) {
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
@@ -560,18 +600,40 @@ static int uda1380_set_bias_level(struct snd_soc_codec *codec,
 	enum snd_soc_bias_level level)
 {
 	int pm = uda1380_read_reg_cache(codec, UDA1380_PM);
+	int reg;
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
+			if (gpio_is_valid(pdata->gpio_power)) {
+				gpio_set_value(pdata->gpio_power, 1);
+				uda1380_reset(codec);
+			}
+
+			uda1380_sync_cache(codec);
+		}
 		uda1380_write(codec, UDA1380_PM, 0x0);
 		break;
+	case SND_SOC_BIAS_OFF:
+		if (!gpio_is_valid(pdata->gpio_power))
+			break;
+
+		gpio_set_value(pdata->gpio_power, 0);
+
+		/* Mark mixer regs cache dirty to sync them with
+		 * codec regs on power on.
+		 */
+		for (reg = UDA1380_MVOL; reg < UDA1380_CACHEREGNUM; reg++)
+			set_bit(reg - 0x10, &uda1380_cache_dirty);
 	}
 	codec->bias_level = level;
 	return 0;
@@ -651,16 +713,6 @@ static int uda1380_suspend(struct snd_soc_codec *codec, pm_message_t state)
 
 static int uda1380_resume(struct snd_soc_codec *codec)
 {
-	int i;
-	u8 data[2];
-	u16 *cache = codec->reg_cache;
-
-	/* Sync reg_cache with the hardware */
-	for (i = 0; i < ARRAY_SIZE(uda1380_reg); i++) {
-		data[0] = (i << 1) | ((cache[i] >> 8) & 0x0001);
-		data[1] = cache[i] & 0x00ff;
-		codec->hw_write(codec->control_data, data, 2);
-	}
 	uda1380_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 	return 0;
 }
@@ -671,29 +723,36 @@ static int uda1380_probe(struct snd_soc_codec *codec)
 	struct uda1380_priv *uda1380 = snd_soc_codec_get_drvdata(codec);
 	int ret;
 
+	uda1380->codec = codec;
+
 	codec->hw_write = (hw_write_t)i2c_master_send;
+	codec->control_data = uda1380->control_data;
 
-	if (!pdata || !pdata->gpio_power || !pdata->gpio_reset)
+	if (!pdata)
 		return -EINVAL;
 
-	ret = gpio_request(pdata->gpio_power, "uda1380 power");
-	if (ret)
-		return ret;
-	ret = gpio_request(pdata->gpio_reset, "uda1380 reset");
-	if (ret)
-		goto err_gpio;
-
-	gpio_direction_output(pdata->gpio_power, 1);
-
-	/* we may need to have the clock running here - pH5 */
-	gpio_direction_output(pdata->gpio_reset, 1);
-	udelay(5);
-	gpio_set_value(pdata->gpio_reset, 0);
+	if (gpio_is_valid(pdata->gpio_reset)) {
+		ret = gpio_request(pdata->gpio_reset, "uda1380 reset");
+		if (ret)
+			goto err_out;
+		ret = gpio_direction_output(pdata->gpio_reset, 0);
+		if (ret)
+			goto err_gpio_reset_conf;
+	}
 
-	ret = uda1380_reset(codec);
-	if (ret < 0) {
-		dev_err(codec->dev, "Failed to issue reset\n");
-		goto err_reset;
+	if (gpio_is_valid(pdata->gpio_power)) {
+		ret = gpio_request(pdata->gpio_power, "uda1380 power");
+		if (ret)
+			goto err_gpio;
+		ret = gpio_direction_output(pdata->gpio_power, 0);
+		if (ret)
+			goto err_gpio_power_conf;
+	} else {
+		ret = uda1380_reset(codec);
+		if (ret) {
+			dev_err(codec->dev, "Failed to issue reset\n");
+			goto err_reset;
+		}
 	}
 
 	INIT_WORK(&uda1380->work, uda1380_flush_work);
@@ -703,10 +762,11 @@ static int uda1380_probe(struct snd_soc_codec *codec)
 	/* set clock input */
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
 
@@ -717,10 +777,15 @@ static int uda1380_probe(struct snd_soc_codec *codec)
 	return 0;
 
 err_reset:
-	gpio_set_value(pdata->gpio_power, 0);
-	gpio_free(pdata->gpio_reset);
+err_gpio_power_conf:
+	if (gpio_is_valid(pdata->gpio_power))
+		gpio_free(pdata->gpio_power);
+
+err_gpio_reset_conf:
 err_gpio:
-	gpio_free(pdata->gpio_power);
+	if (gpio_is_valid(pdata->gpio_reset))
+		gpio_free(pdata->gpio_reset);
+err_out:
 	return ret;
 }
 
@@ -731,7 +796,6 @@ static int uda1380_remove(struct snd_soc_codec *codec)
 
 	uda1380_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
-	gpio_set_value(pdata->gpio_power, 0);
 	gpio_free(pdata->gpio_reset);
 	gpio_free(pdata->gpio_power);
 
@@ -743,8 +807,8 @@ static struct snd_soc_codec_driver soc_codec_dev_uda1380 = {
 	.remove =	uda1380_remove,
 	.suspend =	uda1380_suspend,
 	.resume =	uda1380_resume,
-	.read = uda1380_read_reg_cache,
-	.write = uda1380_write,
+	.read =		uda1380_read_reg_cache,
+	.write =	uda1380_write,
 	.set_bias_level = uda1380_set_bias_level,
 	.reg_cache_size = ARRAY_SIZE(uda1380_reg),
 	.reg_word_size = sizeof(u16),
@@ -764,6 +828,7 @@ static __devinit int uda1380_i2c_probe(struct i2c_client *i2c,
 		return -ENOMEM;
 
 	i2c_set_clientdata(i2c, uda1380);
+	uda1380->control_data = i2c;
 
 	ret =  snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_uda1380, uda1380_dai, ARRAY_SIZE(uda1380_dai));
-- 
1.7.2
