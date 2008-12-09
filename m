From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 18/18] ASoC: Convert WM8900 to allow
	registration by machine code
Date: Tue,  9 Dec 2008 14:01:42 +0000
Message-ID: <1228831302-17605-18-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081209140101.GA17558@rakim.wolfsonmicro.main>
	<1228831302-17605-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-7-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-8-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-9-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-10-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-11-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-12-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-13-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-14-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-15-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-16-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-17-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 159CC103850
	for <alsa-devel@alsa-project.org>; Tue,  9 Dec 2008 15:01:47 +0100 (CET)
In-Reply-To: <1228831302-17605-17-git-send-email-broonie@opensource.wolfsonmicro.com>
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

This makes use of the support for delayed DAI registration to allow the
WM8900 I2C device to be registered by general platform/architecture code
rather than as part of the ASoC device probe.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8900.c |   97 +++++++++-----------------------------------
 1 files changed, 20 insertions(+), 77 deletions(-)

diff --git a/sound/soc/codecs/wm8900.c b/sound/soc/codecs/wm8900.c
index 02bb1c9..34e58af 100644
--- a/sound/soc/codecs/wm8900.c
+++ b/sound/soc/codecs/wm8900.c
@@ -1382,32 +1382,21 @@ priv_err:
 	return ret;
 }
 
-static struct snd_soc_device *wm8900_socdev;
+static struct i2c_client *wm8900_client;
 
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-
-/* If the i2c layer weren't so broken, we could pass this kind of data
-   around */
 static int wm8900_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
 {
-	struct snd_soc_device *socdev = wm8900_socdev;
-	struct snd_soc_codec *codec = socdev->codec;
-	int ret;
-
-	i2c_set_clientdata(i2c, codec);
-	codec->control_data = i2c;
-
-	ret = wm8900_init(socdev);
-	if (ret < 0)
-		dev_err(&i2c->dev, "failed to initialise WM8900\n");
-	return ret;
+	wm8900_client = i2c;
+	wm8900_dai.dev = &i2c->dev;
+	return snd_soc_register_dai(&wm8900_dai);
 }
 
 static int wm8900_i2c_remove(struct i2c_client *client)
 {
-	struct snd_soc_codec *codec = i2c_get_clientdata(client);
-	kfree(codec->reg_cache);
+	snd_soc_unregister_dai(&wm8900_dai);
+	wm8900_dai.dev = NULL;
+	wm8900_client = NULL;
 	return 0;
 }
 
@@ -1427,57 +1416,17 @@ static struct i2c_driver wm8900_i2c_driver = {
 	.id_table = wm8900_i2c_id,
 };
 
-static int wm8900_add_i2c_device(struct platform_device *pdev,
-				 const struct wm8900_setup_data *setup)
-{
-	struct i2c_board_info info;
-	struct i2c_adapter *adapter;
-	struct i2c_client *client;
-	int ret;
-
-	ret = i2c_add_driver(&wm8900_i2c_driver);
-	if (ret != 0) {
-		dev_err(&pdev->dev, "can't add i2c driver\n");
-		return ret;
-	}
-
-	memset(&info, 0, sizeof(struct i2c_board_info));
-	info.addr = setup->i2c_address;
-	strlcpy(info.type, "wm8900", I2C_NAME_SIZE);
-
-	adapter = i2c_get_adapter(setup->i2c_bus);
-	if (!adapter) {
-		dev_err(&pdev->dev, "can't get i2c adapter %d\n",
-			setup->i2c_bus);
-		goto err_driver;
-	}
-
-	client = i2c_new_device(adapter, &info);
-	i2c_put_adapter(adapter);
-	if (!client) {
-		dev_err(&pdev->dev, "can't add i2c device at 0x%x\n",
-			(unsigned int)info.addr);
-		goto err_driver;
-	}
-
-	return 0;
-
-err_driver:
-	i2c_del_driver(&wm8900_i2c_driver);
-	return -ENODEV;
-}
-#endif
-
 static int wm8900_probe(struct platform_device *pdev)
 {
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct wm8900_setup_data *setup;
 	struct snd_soc_codec *codec;
 	int ret = 0;
 
-	dev_info(&pdev->dev, "WM8900 Audio Codec\n");
+	if (!wm8900_client) {
+		dev_err(&pdev->dev, "I2C client not yet instantiated\n");
+		return -ENODEV;
+	}
 
-	setup = socdev->codec_data;
 	codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
 	if (codec == NULL)
 		return -ENOMEM;
@@ -1490,15 +1439,13 @@ static int wm8900_probe(struct platform_device *pdev)
 
 	codec->set_bias_level = wm8900_set_bias_level;
 
-	wm8900_socdev = socdev;
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-	if (setup->i2c_address) {
-		codec->hw_write = (hw_write_t)i2c_master_send;
-		ret = wm8900_add_i2c_device(pdev, setup);
-	}
-#else
-#error Non-I2C interfaces not yet supported
-#endif
+	codec->hw_write = (hw_write_t)i2c_master_send;
+	codec->control_data = wm8900_client;
+
+	ret = wm8900_init(socdev);
+	if (ret != 0)
+		kfree(codec);
+
 	return ret;
 }
 
@@ -1513,10 +1460,6 @@ static int wm8900_remove(struct platform_device *pdev)
 
 	snd_soc_free_pcms(socdev);
 	snd_soc_dapm_free(socdev);
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-	i2c_unregister_device(codec->control_data);
-	i2c_del_driver(&wm8900_i2c_driver);
-#endif
 	kfree(codec);
 
 	return 0;
@@ -1532,13 +1475,13 @@ EXPORT_SYMBOL_GPL(soc_codec_dev_wm8900);
 
 static int __devinit wm8900_modinit(void)
 {
-	return snd_soc_register_dai(&wm8900_dai);
+	return i2c_add_driver(&wm8900_i2c_driver);
 }
 module_init(wm8900_modinit);
 
 static void __exit wm8900_exit(void)
 {
-	snd_soc_unregister_dai(&wm8900_dai);
+	i2c_del_driver(&wm8900_i2c_driver);
 }
 module_exit(wm8900_exit);
 
-- 
1.5.6.5
