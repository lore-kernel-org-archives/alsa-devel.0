From: Ben Dooks <ben@simtec.co.uk>
Subject: [patch 2/4] tlv320aic3x: Change to use device model
Date: Thu, 20 Aug 2009 22:50:41 +0100
Message-ID: <20090820215121.748784224@fluff.org>
References: <20090820215039.380849394@fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ben-laptop (unknown [78.146.176.60])
	by alsa0.perex.cz (Postfix) with ESMTP id 0ECAF103886
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Aug 2009 23:53:02 +0200 (CEST)
Content-Disposition: inline; filename=asoc-simtec-tlv320aic33-dev-update.patch
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

The tlv320aic3x driver managed its own i2c device, instead of an extant
one created by the board support code. Change the code to make it so that
the driver binds to an extant (in this case i2c) device.

Add explict tlv320aic33 as well as tlv320aic3x to the supported device
table and remove the old driver bindings from the users of this code.

Signed-off-by: Ben Dooks <ben@simtec.co.uk>

---
 sound/soc/codecs/tlv320aic3x.c  |  221 ++++++++++++++++++++--------------------
 sound/soc/codecs/tlv320aic3x.h  |    2 
 sound/soc/davinci/davinci-evm.c |    2 
 sound/soc/omap/n810.c           |    2 
 sound/soc/s6000/s6105-ipcam.c   |    2 
 5 files changed, 116 insertions(+), 113 deletions(-)

Index: b/sound/soc/codecs/tlv320aic3x.c
===================================================================
--- a/sound/soc/codecs/tlv320aic3x.c	2009-08-20 08:37:52.000000000 +0100
+++ b/sound/soc/codecs/tlv320aic3x.c	2009-08-20 08:38:01.000000000 +0100
@@ -53,6 +53,7 @@
 
 /* codec private data */
 struct aic3x_priv {
+	struct snd_soc_codec codec;
 	unsigned int sysclk;
 	int master;
 };
@@ -1156,11 +1157,13 @@ static int aic3x_resume(struct platform_
  * initialise the AIC3X driver
  * register the mixer and dsp interfaces with the kernel
  */
-static int aic3x_init(struct snd_soc_device *socdev)
+static int aic3x_init(struct snd_soc_codec *codec)
 {
-	struct snd_soc_codec *codec = socdev->card->codec;
-	struct aic3x_setup_data *setup = socdev->codec_data;
-	int reg, ret = 0;
+	int reg;
+
+	mutex_init(&codec->mutex);
+	INIT_LIST_HEAD(&codec->dapm_widgets);
+	INIT_LIST_HEAD(&codec->dapm_paths);
 
 	codec->name = "tlv320aic3x";
 	codec->owner = THIS_MODULE;
@@ -1177,13 +1180,6 @@ static int aic3x_init(struct snd_soc_dev
 	aic3x_write(codec, AIC3X_PAGE_SELECT, PAGE0_SELECT);
 	aic3x_write(codec, AIC3X_RESET, SOFT_RESET);
 
-	/* register pcms */
-	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
-	if (ret < 0) {
-		printk(KERN_ERR "aic3x: failed to create pcms\n");
-		goto pcm_err;
-	}
-
 	/* DAC default volume and mute */
 	aic3x_write(codec, LDAC_VOL, DEFAULT_VOL | MUTE_ON);
 	aic3x_write(codec, RDAC_VOL, DEFAULT_VOL | MUTE_ON);
@@ -1250,30 +1246,51 @@ static int aic3x_init(struct snd_soc_dev
 	/* off, with power on */
 	aic3x_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
-	/* setup GPIO functions */
-	aic3x_write(codec, AIC3X_GPIO1_REG, (setup->gpio_func[0] & 0xf) << 4);
-	aic3x_write(codec, AIC3X_GPIO2_REG, (setup->gpio_func[1] & 0xf) << 4);
+	return 0;
+}
 
-	snd_soc_add_controls(codec, aic3x_snd_controls,
-				ARRAY_SIZE(aic3x_snd_controls));
-	aic3x_add_widgets(codec);
-	ret = snd_soc_init_card(socdev);
+static struct snd_soc_codec *aic3x_codec;
+
+static int aic3x_register(struct snd_soc_codec *codec)
+{
+	int ret;
+
+	ret = aic3x_init(codec);
 	if (ret < 0) {
-		printk(KERN_ERR "aic3x: failed to register card\n");
-		goto card_err;
+		dev_err(codec->dev, "Failed to initialise device\n");
+		return ret;
 	}
 
-	return ret;
+	aic3x_codec = codec;
 
-card_err:
-	snd_soc_free_pcms(socdev);
-	snd_soc_dapm_free(socdev);
-pcm_err:
-	kfree(codec->reg_cache);
-	return ret;
+	ret = snd_soc_register_codec(codec);
+	if (ret) {
+		dev_err(codec->dev, "Failed to register codec\n");
+		return ret;
+	}
+
+	ret = snd_soc_register_dai(&aic3x_dai);
+	if (ret) {
+		dev_err(codec->dev, "Failed to register dai\n");
+		snd_soc_unregister_codec(codec);
+		return ret;
+	}
+
+	return 0;
 }
 
-static struct snd_soc_device *aic3x_socdev;
+static int aic3x_unregister(struct aic3x_priv *aic3x)
+{
+	aic3x_set_bias_level(&aic3x->codec, SND_SOC_BIAS_OFF);
+
+	snd_soc_unregister_dai(&aic3x_dai);
+	snd_soc_unregister_codec(&aic3x->codec);
+
+	kfree(aic3x);
+	aic3x_codec = NULL;
+
+	return 0;
+}
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 /*
@@ -1288,28 +1305,36 @@ static struct snd_soc_device *aic3x_socd
 static int aic3x_i2c_probe(struct i2c_client *i2c,
 			   const struct i2c_device_id *id)
 {
-	struct snd_soc_device *socdev = aic3x_socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
-	int ret;
+	struct snd_soc_codec *codec;
+	struct aic3x_priv *aic3x;
 
-	i2c_set_clientdata(i2c, codec);
+	aic3x = kzalloc(sizeof(struct aic3x_priv), GFP_KERNEL);
+	if (aic3x == NULL) {
+		dev_err(&i2c->dev, "failed to create private data\n");
+		return -ENOMEM;
+	}
+
+	codec = &aic3x->codec;
+	codec->dev = &i2c->dev;
+	codec->private_data = aic3x;
 	codec->control_data = i2c;
+	codec->hw_write = (hw_write_t) i2c_master_send;
 
-	ret = aic3x_init(socdev);
-	if (ret < 0)
-		printk(KERN_ERR "aic3x: failed to initialise AIC3X\n");
-	return ret;
+	i2c_set_clientdata(i2c, aic3x);
+
+	return aic3x_register(codec);
 }
 
 static int aic3x_i2c_remove(struct i2c_client *client)
 {
-	struct snd_soc_codec *codec = i2c_get_clientdata(client);
-	kfree(codec->reg_cache);
-	return 0;
+	struct aic3x_priv *aic3x = i2c_get_clientdata(client);
+
+	return aic3x_unregister(aic3x);
 }
 
 static const struct i2c_device_id aic3x_i2c_id[] = {
 	{ "tlv320aic3x", 0 },
+	{ "tlv320aic33", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, aic3x_i2c_id);
@@ -1320,50 +1345,28 @@ static struct i2c_driver aic3x_i2c_drive
 		.name = "aic3x I2C Codec",
 		.owner = THIS_MODULE,
 	},
-	.probe = aic3x_i2c_probe,
+	.probe	= aic3x_i2c_probe,
 	.remove = aic3x_i2c_remove,
 	.id_table = aic3x_i2c_id,
 };
 
-static int aic3x_add_i2c_device(struct platform_device *pdev,
-				 const struct aic3x_setup_data *setup)
+static inline void aic3x_i2c_init(void)
 {
-	struct i2c_board_info info;
-	struct i2c_adapter *adapter;
-	struct i2c_client *client;
 	int ret;
 
 	ret = i2c_add_driver(&aic3x_i2c_driver);
-	if (ret != 0) {
-		dev_err(&pdev->dev, "can't add i2c driver\n");
-		return ret;
-	}
-
-	memset(&info, 0, sizeof(struct i2c_board_info));
-	info.addr = setup->i2c_address;
-	strlcpy(info.type, "tlv320aic3x", I2C_NAME_SIZE);
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
+	if (ret)
+		printk(KERN_ERR "%s: error regsitering i2c driver, %d\n",
+		       __func__, ret);
+}
 
-err_driver:
+static inline void aic3x_i2c_exit(void)
+{
 	i2c_del_driver(&aic3x_i2c_driver);
-	return -ENODEV;
 }
+#else
+static inline void aic3x_i2c_init(void) { }
+static inline void aic3x_i2c_exit(void) { }
 #endif
 
 static int aic3x_probe(struct platform_device *pdev)
@@ -1371,42 +1374,52 @@ static int aic3x_probe(struct platform_d
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
 	struct aic3x_setup_data *setup;
 	struct snd_soc_codec *codec;
-	struct aic3x_priv *aic3x;
 	int ret = 0;
 
-	printk(KERN_INFO "AIC3X Audio Codec %s\n", AIC3X_VERSION);
+	codec = aic3x_codec;
+	if (!codec) {
+		dev_err(&pdev->dev, "Codec not registered\n");
+		return -ENODEV;
+	}
 
+	socdev->card->codec = codec;
 	setup = socdev->codec_data;
-	codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
-	if (codec == NULL)
-		return -ENOMEM;
 
-	aic3x = kzalloc(sizeof(struct aic3x_priv), GFP_KERNEL);
-	if (aic3x == NULL) {
-		kfree(codec);
-		return -ENOMEM;
+	if (!setup) {
+		dev_err(&pdev->dev, "No setup data supplied\n");
+		return -EINVAL;
 	}
 
-	codec->private_data = aic3x;
-	socdev->card->codec = codec;
-	mutex_init(&codec->mutex);
-	INIT_LIST_HEAD(&codec->dapm_widgets);
-	INIT_LIST_HEAD(&codec->dapm_paths);
+	/* setup GPIO functions */
+	aic3x_write(codec, AIC3X_GPIO1_REG, (setup->gpio_func[0] & 0xf) << 4);
+	aic3x_write(codec, AIC3X_GPIO2_REG, (setup->gpio_func[1] & 0xf) << 4);
 
-	aic3x_socdev = socdev;
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-	if (setup->i2c_address) {
-		codec->hw_write = (hw_write_t) i2c_master_send;
-		ret = aic3x_add_i2c_device(pdev, setup);
+	/* register pcms */
+	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
+	if (ret < 0) {
+		printk(KERN_ERR "aic3x: failed to create pcms\n");
+		goto pcm_err;
 	}
-#else
-	/* Add other interfaces here */
-#endif
 
-	if (ret != 0) {
-		kfree(codec->private_data);
-		kfree(codec);
+	snd_soc_add_controls(codec, aic3x_snd_controls,
+			     ARRAY_SIZE(aic3x_snd_controls));
+
+	aic3x_add_widgets(codec);
+
+	ret = snd_soc_init_card(socdev);
+	if (ret < 0) {
+		printk(KERN_ERR "aic3x: failed to register card\n");
+		goto card_err;
 	}
+
+	return ret;
+
+card_err:
+	snd_soc_free_pcms(socdev);
+	snd_soc_dapm_free(socdev);
+
+pcm_err:
+	kfree(codec->reg_cache);
 	return ret;
 }
 
@@ -1421,12 +1434,8 @@ static int aic3x_remove(struct platform_
 
 	snd_soc_free_pcms(socdev);
 	snd_soc_dapm_free(socdev);
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-	i2c_unregister_device(codec->control_data);
-	i2c_del_driver(&aic3x_i2c_driver);
-#endif
-	kfree(codec->private_data);
-	kfree(codec);
+
+	kfree(codec->reg_cache);
 
 	return 0;
 }
@@ -1441,13 +1450,15 @@ EXPORT_SYMBOL_GPL(soc_codec_dev_aic3x);
 
 static int __init aic3x_modinit(void)
 {
-	return snd_soc_register_dai(&aic3x_dai);
+	aic3x_i2c_init();
+
+	return 0;
 }
 module_init(aic3x_modinit);
 
 static void __exit aic3x_exit(void)
 {
-	snd_soc_unregister_dai(&aic3x_dai);
+	aic3x_i2c_exit();
 }
 module_exit(aic3x_exit);
 
Index: b/sound/soc/omap/n810.c
===================================================================
--- a/sound/soc/omap/n810.c	2009-08-20 08:37:32.000000000 +0100
+++ b/sound/soc/omap/n810.c	2009-08-20 08:38:01.000000000 +0100
@@ -322,8 +322,6 @@ static struct snd_soc_card snd_soc_n810 
 
 /* Audio private data */
 static struct aic3x_setup_data n810_aic33_setup = {
-	.i2c_bus = 2,
-	.i2c_address = 0x18,
 	.gpio_func[0] = AIC3X_GPIO1_FUNC_DISABLED,
 	.gpio_func[1] = AIC3X_GPIO2_FUNC_DIGITAL_MIC_INPUT,
 };
Index: b/sound/soc/s6000/s6105-ipcam.c
===================================================================
--- a/sound/soc/s6000/s6105-ipcam.c	2009-08-20 08:37:32.000000000 +0100
+++ b/sound/soc/s6000/s6105-ipcam.c	2009-08-20 08:38:01.000000000 +0100
@@ -189,8 +189,6 @@ static struct snd_soc_card snd_soc_card_
 
 /* s6105 audio private data */
 static struct aic3x_setup_data s6105_aic3x_setup = {
-	.i2c_bus = 0,
-	.i2c_address = 0x18,
 };
 
 /* s6105 audio subsystem */
Index: b/sound/soc/davinci/davinci-evm.c
===================================================================
--- a/sound/soc/davinci/davinci-evm.c	2009-08-20 08:37:52.000000000 +0100
+++ b/sound/soc/davinci/davinci-evm.c	2009-08-20 08:38:01.000000000 +0100
@@ -207,8 +207,6 @@ static struct snd_soc_card da850_snd_soc
 
 /* evm audio private data */
 static struct aic3x_setup_data evm_aic3x_setup = {
-	.i2c_bus = 1,
-	.i2c_address = 0x1b,
 };
 
 /* dm6467 evm audio private data */
Index: b/sound/soc/codecs/tlv320aic3x.h
===================================================================
--- a/sound/soc/codecs/tlv320aic3x.h	2009-08-20 08:37:32.000000000 +0100
+++ b/sound/soc/codecs/tlv320aic3x.h	2009-08-20 08:38:01.000000000 +0100
@@ -282,8 +282,6 @@ int aic3x_headset_detected(struct snd_so
 int aic3x_button_pressed(struct snd_soc_codec *codec);
 
 struct aic3x_setup_data {
-	int i2c_bus;
-	unsigned short i2c_address;
 	unsigned int gpio_func[2];
 };
 

-- 
