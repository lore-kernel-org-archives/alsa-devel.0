From: Jean Delvare <khali@linux-fr.org>
Subject: [PATCH] ASoC: Convert tlv320aic3x to a new-style i2c
	driver (v2)
Date: Mon, 22 Sep 2008 14:15:53 +0200
Message-ID: <20080922141553.2a8c087a@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 0A1BB243B4
	for <alsa-devel@alsa-project.org>;
	Mon, 22 Sep 2008 14:15:21 +0200 (CEST)
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
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Vladimir Barinov <vbarinov@ru.mvista.com>
List-Id: alsa-devel@alsa-project.org

Convert the tlv320aic3x codec driver to the new (standard) device
driver binding model.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Vladimir Barinov <vbarinov@ru.mvista.com>
Tested-by: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/tlv320aic3x.c  |  106 +++++++++++++++++++--------------------
 sound/soc/codecs/tlv320aic3x.h  |    1 
 sound/soc/davinci/davinci-evm.c |    1 
 sound/soc/omap/n810.c           |    1 
 4 files changed, 57 insertions(+), 52 deletions(-)

--- linux-2.6.27-rc5.orig/sound/soc/codecs/tlv320aic3x.c	2008-09-01 11:06:20.000000000 +0200
+++ linux-2.6.27-rc5/sound/soc/codecs/tlv320aic3x.c	2008-09-01 11:06:23.000000000 +0200
@@ -1172,71 +1172,39 @@ static struct snd_soc_device *aic3x_socd
  * AIC3X 2 wire address can be up to 4 devices with device addresses
  * 0x18, 0x19, 0x1A, 0x1B
  */
-static unsigned short normal_i2c[] = { 0, I2C_CLIENT_END };
-
-/* Magic definition of all other variables and things */
-I2C_CLIENT_INSMOD;
-
-static struct i2c_driver aic3x_i2c_driver;
-static struct i2c_client client_template;
 
 /*
  * If the i2c layer weren't so broken, we could pass this kind of data
  * around
  */
-static int aic3x_codec_probe(struct i2c_adapter *adap, int addr, int kind)
+static int aic3x_i2c_probe(struct i2c_client *i2c,
+			   const struct i2c_device_id *id)
 {
 	struct snd_soc_device *socdev = aic3x_socdev;
-	struct aic3x_setup_data *setup = socdev->codec_data;
 	struct snd_soc_codec *codec = socdev->codec;
-	struct i2c_client *i2c;
 	int ret;
 
-	if (addr != setup->i2c_address)
-		return -ENODEV;
-
-	client_template.adapter = adap;
-	client_template.addr = addr;
-
-	i2c = kmemdup(&client_template, sizeof(client_template), GFP_KERNEL);
-	if (i2c == NULL)
-		return -ENOMEM;
-
 	i2c_set_clientdata(i2c, codec);
 	codec->control_data = i2c;
 
-	ret = i2c_attach_client(i2c);
-	if (ret < 0) {
-		printk(KERN_ERR "aic3x: failed to attach codec at addr %x\n",
-		       addr);
-		goto err;
-	}
-
 	ret = aic3x_init(socdev);
-	if (ret < 0) {
+	if (ret < 0)
 		printk(KERN_ERR "aic3x: failed to initialise AIC3X\n");
-		goto err;
-	}
-	return ret;
-
-err:
-	kfree(i2c);
 	return ret;
 }
 
-static int aic3x_i2c_detach(struct i2c_client *client)
+static int aic3x_i2c_remove(struct i2c_client *client)
 {
 	struct snd_soc_codec *codec = i2c_get_clientdata(client);
-	i2c_detach_client(client);
 	kfree(codec->reg_cache);
-	kfree(client);
 	return 0;
 }
 
-static int aic3x_i2c_attach(struct i2c_adapter *adap)
-{
-	return i2c_probe(adap, &addr_data, aic3x_codec_probe);
-}
+static const struct i2c_device_id aic3x_i2c_id[] = {
+	{ "tlv320aic3x", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, aic3x_i2c_id);
 
 /* machine i2c codec control layer */
 static struct i2c_driver aic3x_i2c_driver = {
@@ -1244,13 +1212,9 @@ static struct i2c_driver aic3x_i2c_drive
 		.name = "aic3x I2C Codec",
 		.owner = THIS_MODULE,
 	},
-	.attach_adapter = aic3x_i2c_attach,
-	.detach_client = aic3x_i2c_detach,
-};
-
-static struct i2c_client client_template = {
-	.name = "AIC3X",
-	.driver = &aic3x_i2c_driver,
+	.probe = aic3x_i2c_probe,
+	.remove = aic3x_i2c_remove,
+	.id_table = aic3x_i2c_id,
 };
 
 static int aic3x_i2c_read(struct i2c_client *client, u8 *value, int len)
@@ -1258,6 +1222,46 @@ static int aic3x_i2c_read(struct i2c_cli
 	value[0] = i2c_smbus_read_byte_data(client, value[0]);
 	return (len == 1);
 }
+
+static int aic3x_add_i2c_device(struct platform_device *pdev,
+				 const struct aic3x_setup_data *setup)
+{
+	struct i2c_board_info info;
+	struct i2c_adapter *adapter;
+	struct i2c_client *client;
+	int ret;
+
+	ret = i2c_add_driver(&aic3x_i2c_driver);
+	if (ret != 0) {
+		dev_err(&pdev->dev, "can't add i2c driver\n");
+		return ret;
+	}
+
+	memset(&info, 0, sizeof(struct i2c_board_info));
+	info.addr = setup->i2c_address;
+	strlcpy(info.type, "tlv320aic3x", I2C_NAME_SIZE);
+
+	adapter = i2c_get_adapter(setup->i2c_bus);
+	if (!adapter) {
+		dev_err(&pdev->dev, "can't get i2c adapter %d\n",
+			setup->i2c_bus);
+		goto err_driver;
+	}
+
+	client = i2c_new_device(adapter, &info);
+	i2c_put_adapter(adapter);
+	if (!client) {
+		dev_err(&pdev->dev, "can't add i2c device at 0x%x\n",
+			(unsigned int)info.addr);
+		goto err_driver;
+	}
+
+	return 0;
+
+err_driver:
+	i2c_del_driver(&aic3x_i2c_driver);
+	return -ENODEV;
+}
 #endif
 
 static int aic3x_probe(struct platform_device *pdev)
@@ -1290,12 +1294,9 @@ static int aic3x_probe(struct platform_d
 	aic3x_socdev = socdev;
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 	if (setup->i2c_address) {
-		normal_i2c[0] = setup->i2c_address;
 		codec->hw_write = (hw_write_t) i2c_master_send;
 		codec->hw_read = (hw_read_t) aic3x_i2c_read;
-		ret = i2c_add_driver(&aic3x_i2c_driver);
-		if (ret != 0)
-			printk(KERN_ERR "can't add i2c driver");
+		ret = aic3x_add_i2c_device(pdev, setup);
 	}
 #else
 	/* Add other interfaces here */
@@ -1320,6 +1321,7 @@ static int aic3x_remove(struct platform_
 	snd_soc_free_pcms(socdev);
 	snd_soc_dapm_free(socdev);
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+	i2c_unregister_device(codec->control_data);
 	i2c_del_driver(&aic3x_i2c_driver);
 #endif
 	kfree(codec->private_data);
--- linux-2.6.27-rc5.orig/sound/soc/codecs/tlv320aic3x.h	2008-09-01 11:06:20.000000000 +0200
+++ linux-2.6.27-rc5/sound/soc/codecs/tlv320aic3x.h	2008-09-01 11:06:23.000000000 +0200
@@ -224,6 +224,7 @@ int aic3x_get_gpio(struct snd_soc_codec 
 int aic3x_headset_detected(struct snd_soc_codec *codec);
 
 struct aic3x_setup_data {
+	int i2c_bus;
 	unsigned short i2c_address;
 	unsigned int gpio_func[2];
 };
--- linux-2.6.27-rc5.orig/sound/soc/davinci/davinci-evm.c	2008-09-01 11:06:20.000000000 +0200
+++ linux-2.6.27-rc5/sound/soc/davinci/davinci-evm.c	2008-09-01 11:06:23.000000000 +0200
@@ -136,6 +136,7 @@ static struct snd_soc_machine snd_soc_ma
 
 /* evm audio private data */
 static struct aic3x_setup_data evm_aic3x_setup = {
+	.i2c_bus = 0,
 	.i2c_address = 0x1b,
 };
 
--- linux-2.6.27-rc5.orig/sound/soc/omap/n810.c	2008-09-01 11:06:20.000000000 +0200
+++ linux-2.6.27-rc5/sound/soc/omap/n810.c	2008-09-01 14:29:09.000000000 +0200
@@ -290,6 +290,7 @@ static struct snd_soc_machine snd_soc_ma
 
 /* Audio private data */
 static struct aic3x_setup_data n810_aic33_setup = {
+	.i2c_bus = 2,
 	.i2c_address = 0x18,
 	.gpio_func[0] = AIC3X_GPIO1_FUNC_DISABLED,
 	.gpio_func[1] = AIC3X_GPIO2_FUNC_DIGITAL_MIC_INPUT,


-- 
Jean Delvare
