From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 11/11] soc - wm8750 - Clean up checkpatch
	warnings
Date: Wed, 23 Apr 2008 13:08:05 +0100
Message-ID: <1208952485-20385-11-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1208952485-20385-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1208952485-20385-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1208952485-20385-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1208952485-20385-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1208952485-20385-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1208952485-20385-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1208952485-20385-7-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1208952485-20385-8-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1208952485-20385-9-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1208952485-20385-10-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B5095244D9
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Apr 2008 14:08:08 +0200 (CEST)
In-Reply-To: <1208952485-20385-10-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8750.c |   27 +++++++++++++--------------
 1 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/wm8750.c b/sound/soc/codecs/wm8750.c
index 77a857b..16cd5d4 100644
--- a/sound/soc/codecs/wm8750.c
+++ b/sound/soc/codecs/wm8750.c
@@ -110,7 +110,7 @@ static int wm8750_write(struct snd_soc_codec *codec, unsigned int reg,
 	data[0] = (reg << 1) | ((value >> 8) & 0x0001);
 	data[1] = value & 0x00ff;
 
-	wm8750_write_reg_cache (codec, reg, value);
+	wm8750_write_reg_cache(codec, reg, value);
 	if (codec->hw_write(codec->control_data, data, 2) == 2)
 		return 0;
 	else
@@ -257,7 +257,8 @@ static int wm8750_add_controls(struct snd_soc_codec *codec)
 
 	for (i = 0; i < ARRAY_SIZE(wm8750_snd_controls); i++) {
 		err = snd_ctl_add(codec->card,
-				snd_soc_cnew(&wm8750_snd_controls[i],codec, NULL));
+				snd_soc_cnew(&wm8750_snd_controls[i],
+						codec, NULL));
 		if (err < 0)
 			return err;
 	}
@@ -478,15 +479,13 @@ static int wm8750_add_widgets(struct snd_soc_codec *codec)
 {
 	int i;
 
-	for(i = 0; i < ARRAY_SIZE(wm8750_dapm_widgets); i++) {
+	for (i = 0; i < ARRAY_SIZE(wm8750_dapm_widgets); i++)
 		snd_soc_dapm_new_control(codec, &wm8750_dapm_widgets[i]);
-	}
 
 	/* set up audio path audio_mapnects */
-	for(i = 0; audio_map[i][0] != NULL; i++) {
+	for (i = 0; audio_map[i][0] != NULL; i++)
 		snd_soc_dapm_connect_input(codec, audio_map[i][0],
 			audio_map[i][1], audio_map[i][2]);
-	}
 
 	snd_soc_dapm_new_widgets(codec);
 	return 0;
@@ -714,8 +713,8 @@ static int wm8750_dapm_event(struct snd_soc_codec *codec, int event)
 }
 
 #define WM8750_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |\
-		SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_44100 | \
-		SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000)
+	SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_44100 | \
+	SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000)
 
 #define WM8750_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
 	SNDRV_PCM_FMTBIT_S24_LE)
@@ -784,7 +783,8 @@ static int wm8750_resume(struct platform_device *pdev)
 	if (codec->suspend_dapm_state == SNDRV_CTL_POWER_D0) {
 		wm8750_dapm_event(codec, SNDRV_CTL_POWER_D2);
 		codec->dapm_state = SNDRV_CTL_POWER_D0;
-		schedule_delayed_work(&codec->delayed_work, msecs_to_jiffies(1000));
+		schedule_delayed_work(&codec->delayed_work,
+					msecs_to_jiffies(1000));
 	}
 
 	return 0;
@@ -864,7 +864,7 @@ pcm_err:
    around */
 static struct snd_soc_device *wm8750_socdev;
 
-#if defined (CONFIG_I2C) || defined (CONFIG_I2C_MODULE)
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 
 /*
  * WM8731 2 wire address is determined by GPIO5
@@ -979,8 +979,8 @@ static int wm8750_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&codec->dapm_paths);
 	wm8750_socdev = socdev;
 	INIT_DELAYED_WORK(&codec->delayed_work, wm8750_work);
-	
-#if defined (CONFIG_I2C) || defined (CONFIG_I2C_MODULE)
+
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 	if (setup->i2c_address) {
 		normal_i2c[0] = setup->i2c_address;
 		codec->hw_write = (hw_write_t)i2c_master_send;
@@ -1025,7 +1025,7 @@ static int wm8750_remove(struct platform_device *pdev)
 	run_delayed_work(&codec->delayed_work);
 	snd_soc_free_pcms(socdev);
 	snd_soc_dapm_free(socdev);
-#if defined (CONFIG_I2C) || defined (CONFIG_I2C_MODULE)
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 	i2c_del_driver(&wm8750_i2c_driver);
 #endif
 	kfree(codec->private_data);
@@ -1040,7 +1040,6 @@ struct snd_soc_codec_device soc_codec_dev_wm8750 = {
 	.suspend = 	wm8750_suspend,
 	.resume =	wm8750_resume,
 };
-
 EXPORT_SYMBOL_GPL(soc_codec_dev_wm8750);
 
 MODULE_DESCRIPTION("ASoC WM8750 driver");
-- 
1.5.5.1
