From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 10/11] soc - wm8731 - Clean up checkpatch
	warnings
Date: Wed, 23 Apr 2008 13:08:04 +0100
Message-ID: <1208952485-20385-10-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1208952485-20385-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1208952485-20385-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1208952485-20385-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1208952485-20385-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1208952485-20385-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1208952485-20385-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1208952485-20385-7-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1208952485-20385-8-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1208952485-20385-9-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B5F92244BC
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Apr 2008 14:08:07 +0200 (CEST)
In-Reply-To: <1208952485-20385-9-git-send-email-broonie@opensource.wolfsonmicro.com>
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
 sound/soc/codecs/wm8731.c |   23 +++++++++++------------
 1 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index 9c33fe8..0cf9265 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -110,7 +110,7 @@ static int wm8731_write(struct snd_soc_codec *codec, unsigned int reg,
 	data[0] = (reg << 1) | ((value >> 8) & 0x0001);
 	data[1] = value & 0x00ff;
 
-	wm8731_write_reg_cache (codec, reg, value);
+	wm8731_write_reg_cache(codec, reg, value);
 	if (codec->hw_write(codec->control_data, data, 2) == 2)
 		return 0;
 	else
@@ -154,8 +154,10 @@ static int wm8731_add_controls(struct snd_soc_codec *codec)
 	int err, i;
 
 	for (i = 0; i < ARRAY_SIZE(wm8731_snd_controls); i++) {
-		if ((err = snd_ctl_add(codec->card,
-				snd_soc_cnew(&wm8731_snd_controls[i],codec, NULL))) < 0)
+		err = snd_ctl_add(codec->card,
+				  snd_soc_cnew(&wm8731_snd_controls[i],
+						codec, NULL));
+		if (err < 0)
 			return err;
 	}
 
@@ -221,15 +223,13 @@ static int wm8731_add_widgets(struct snd_soc_codec *codec)
 {
 	int i;
 
-	for(i = 0; i < ARRAY_SIZE(wm8731_dapm_widgets); i++) {
+	for (i = 0; i < ARRAY_SIZE(wm8731_dapm_widgets); i++)
 		snd_soc_dapm_new_control(codec, &wm8731_dapm_widgets[i]);
-	}
 
 	/* set up audio path interconnects */
-	for(i = 0; intercon[i][0] != NULL; i++) {
+	for (i = 0; intercon[i][0] != NULL; i++)
 		snd_soc_dapm_connect_input(codec, intercon[i][0],
 			intercon[i][1], intercon[i][2]);
-	}
 
 	snd_soc_dapm_new_widgets(codec);
 	return 0;
@@ -589,7 +589,7 @@ pcm_err:
 
 static struct snd_soc_device *wm8731_socdev;
 
-#if defined (CONFIG_I2C) || defined (CONFIG_I2C_MODULE)
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 
 /*
  * WM8731 2 wire address is determined by GPIO5
@@ -651,7 +651,7 @@ err:
 
 static int wm8731_i2c_detach(struct i2c_client *client)
 {
-	struct snd_soc_codec* codec = i2c_get_clientdata(client);
+	struct snd_soc_codec *codec = i2c_get_clientdata(client);
 	i2c_detach_client(client);
 	kfree(codec->reg_cache);
 	kfree(client);
@@ -709,7 +709,7 @@ static int wm8731_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&codec->dapm_paths);
 
 	wm8731_socdev = socdev;
-#if defined (CONFIG_I2C) || defined (CONFIG_I2C_MODULE)
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 	if (setup->i2c_address) {
 		normal_i2c[0] = setup->i2c_address;
 		codec->hw_write = (hw_write_t)i2c_master_send;
@@ -734,7 +734,7 @@ static int wm8731_remove(struct platform_device *pdev)
 
 	snd_soc_free_pcms(socdev);
 	snd_soc_dapm_free(socdev);
-#if defined (CONFIG_I2C) || defined (CONFIG_I2C_MODULE)
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 	i2c_del_driver(&wm8731_i2c_driver);
 #endif
 	kfree(codec->private_data);
@@ -749,7 +749,6 @@ struct snd_soc_codec_device soc_codec_dev_wm8731 = {
 	.suspend = 	wm8731_suspend,
 	.resume =	wm8731_resume,
 };
-
 EXPORT_SYMBOL_GPL(soc_codec_dev_wm8731);
 
 MODULE_DESCRIPTION("ASoC WM8731 driver");
-- 
1.5.5.1
