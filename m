From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH RFC 3/3] uda1380: make driver more
	powersave-friendly
Date: Sat, 26 Jun 2010 18:14:45 +0300
Message-ID: <1277565285-11563-4-git-send-email-anarsoul@gmail.com>
References: <1277565285-11563-1-git-send-email-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 5D80910383E
	for <alsa-devel@alsa-project.org>;
	Sat, 26 Jun 2010 17:15:31 +0200 (CEST)
Received: by mail-bw0-f51.google.com with SMTP id 11so1046443bwz.38
	for <alsa-devel@alsa-project.org>; Sat, 26 Jun 2010 08:15:31 -0700 (PDT)
In-Reply-To: <1277565285-11563-1-git-send-email-anarsoul@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel <alsa-devel@alsa-project.org>, Philipp Zabel <philipp.zabel@gmail.com>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>
List-Id: alsa-devel@alsa-project.org

Disable some codec modules in standby mode, completely disable
codec in off mode to save some power.
Fix suspend/resume: mark mixer regs as dirty on resume to
restore mixer values, otherwise driver produces no sound
(master is muted by default).

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 sound/soc/codecs/uda1380.c |   92 ++++++++++++++++++++++++++++---------------
 1 files changed, 60 insertions(+), 32 deletions(-)

diff --git a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
index 2b7f200..a30f809 100644
--- a/sound/soc/codecs/uda1380.c
+++ b/sound/soc/codecs/uda1380.c
@@ -130,7 +130,41 @@ static int uda1380_write(struct snd_soc_codec *codec, unsigned int reg,
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
+
+	for (reg = UDA1380_MVOL; reg < UDA1380_CACHEREGNUM; reg++)
+		set_bit(reg - 0x10, &uda1380_cache_dirty);
+}
+
+static int uda1380_reset(struct snd_soc_codec *codec)
+{
+	u8 data[3];
+
+	data[0] = UDA1380_RESET;
+	data[1] = 0;
+	data[2] = 0;
+
+	if (codec->hw_write(codec->control_data, data, 3) != 3) {
+		dev_err(codec->dev, "%s: failed\n", __func__);
+		return -EIO;
+	}
+
+	return 0;
+}
 
 static void uda1380_flush_work(struct work_struct *work)
 {
@@ -481,13 +515,13 @@ static int uda1380_trigger(struct snd_pcm_substream *substream, int cmd,
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		uda1380_write_reg_cache(codec, UDA1380_MIXER,
+		uda1380_write(codec, UDA1380_MIXER,
 					mixer & ~R14_SILENCE);
 		schedule_work(&uda1380->work);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		uda1380_write_reg_cache(codec, UDA1380_MIXER,
+		uda1380_write(codec, UDA1380_MIXER,
 					mixer | R14_SILENCE);
 		schedule_work(&uda1380->work);
 		break;
@@ -561,17 +595,38 @@ static int uda1380_set_bias_level(struct snd_soc_codec *codec,
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
+		if (codec->bias_level == SND_SOC_BIAS_OFF) {
+			pdata->set_power(1);
+			uda1380_reset(codec);
+
+			switch (pdata->dac_clk) {
+			case UDA1380_DAC_CLK_SYSCLK:
+				uda1380_write_reg_cache(codec, UDA1380_CLK, 0);
+				break;
+			case UDA1380_DAC_CLK_WSPLL:
+				uda1380_write_reg_cache(codec, UDA1380_CLK,
+					R00_DAC_CLK);
+				break;
+			}
+
+			uda1380_sync_cache(codec);
+		}
+		uda1380_write(codec, UDA1380_PM, 0x0);
 		break;
 	case SND_SOC_BIAS_OFF:
-		uda1380_write(codec, UDA1380_PM, 0x0);
+		pdata->set_power(0);
 		break;
 	}
 	codec->bias_level = level;
@@ -658,16 +713,7 @@ static int uda1380_resume(struct platform_device *pdev)
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
@@ -697,15 +743,6 @@ static int uda1380_probe(struct platform_device *pdev)
 
 	/* power on device */
 	uda1380_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-	/* set clock input */
-	switch (pdata->dac_clk) {
-	case UDA1380_DAC_CLK_SYSCLK:
-		uda1380_write(codec, UDA1380_CLK, 0);
-		break;
-	case UDA1380_DAC_CLK_WSPLL:
-		uda1380_write(codec, UDA1380_CLK, R00_DAC_CLK);
-		break;
-	}
 
 	snd_soc_add_controls(codec, uda1380_snd_controls,
 				ARRAY_SIZE(uda1380_snd_controls));
@@ -754,9 +791,6 @@ static int uda1380_register(struct uda1380_priv *uda1380)
 	if (!pdata || !pdata->set_power)
 		return -EINVAL;
 
-	/* we may need to have the clock running here - pH5 */
-	pdata->set_power(1);
-
 	mutex_init(&codec->mutex);
 	INIT_LIST_HEAD(&codec->dapm_widgets);
 	INIT_LIST_HEAD(&codec->dapm_paths);
@@ -776,12 +810,6 @@ static int uda1380_register(struct uda1380_priv *uda1380)
 
 	memcpy(codec->reg_cache, uda1380_reg, sizeof(uda1380_reg));
 
-	ret = uda1380_reset(codec);
-	if (ret < 0) {
-		dev_err(codec->dev, "Failed to issue reset\n");
-		goto err_reset;
-	}
-
 	INIT_WORK(&uda1380->work, uda1380_flush_work);
 
 	for (i = 0; i < ARRAY_SIZE(uda1380_dai); i++)
-- 
1.7.1
