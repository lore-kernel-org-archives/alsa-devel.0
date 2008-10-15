From: Jean Delvare <khali@linux-fr.org>
Subject: [PATCH] ASoC: Convert wm8900 to a new-style i2c driver
Date: Wed, 15 Oct 2008 19:58:12 +0200
Message-ID: <20081015195812.41384ca7@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	by alsa0.perex.cz (Postfix) with ESMTP id A6875243AB
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Oct 2008 19:58:36 +0200 (CEST)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Convert the wm8900 codec driver to the new (standard) device driver
binding model.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
Untested, no hardware.

 sound/soc/codecs/wm8900.c |  113 +++++++++++++++++++++------------------------
 sound/soc/codecs/wm8900.h |    1 
 2 files changed, 55 insertions(+), 59 deletions(-)

--- linux-2.6.28-rc0.orig/sound/soc/codecs/wm8900.c	2008-10-15 15:14:34.000000000 +0200
+++ linux-2.6.28-rc0/sound/soc/codecs/wm8900.c	2008-10-15 19:03:42.000000000 +0200
@@ -1387,89 +1387,86 @@ static struct snd_soc_device *wm8900_soc
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 
-static unsigned short normal_i2c[] = { 0, I2C_CLIENT_END };
-
-/* Magic definition of all other variables and things */
-I2C_CLIENT_INSMOD;
-
-static struct i2c_driver wm8900_i2c_driver;
-static struct i2c_client client_template;
-
 /* If the i2c layer weren't so broken, we could pass this kind of data
    around */
-static int wm8900_codec_probe(struct i2c_adapter *adap, int addr, int kind)
+static int wm8900_i2c_probe(struct i2c_client *i2c,
+			    const struct i2c_device_id *id)
 {
 	struct snd_soc_device *socdev = wm8900_socdev;
-	struct wm8900_setup_data *setup = socdev->codec_data;
 	struct snd_soc_codec *codec = socdev->codec;
-	struct i2c_client *i2c;
 	int ret;
 
-	if (addr != setup->i2c_address)
-		return -ENODEV;
-
-	dev_err(&adap->dev, "Probe on %x\n", addr);
-
-	client_template.adapter = adap;
-	client_template.addr = addr;
-
-	i2c = kmemdup(&client_template, sizeof(client_template), GFP_KERNEL);
-	if (i2c == NULL) {
-		kfree(codec);
-		return -ENOMEM;
-	}
 	i2c_set_clientdata(i2c, codec);
 	codec->control_data = i2c;
 
-	ret = i2c_attach_client(i2c);
-	if (ret < 0) {
-		dev_err(&adap->dev,
-			"failed to attach codec at addr %x\n", addr);
-		goto err;
-	}
-
 	ret = wm8900_init(socdev);
-	if (ret < 0) {
-		dev_err(&adap->dev, "failed to initialise WM8900\n");
-		goto err;
-	}
-	return ret;
-
-err:
-	kfree(codec);
-	kfree(i2c);
+	if (ret < 0)
+		dev_err(&i2c->dev, "failed to initialise WM8900\n");
 	return ret;
 }
 
-static int wm8900_i2c_detach(struct i2c_client *client)
+static int wm8900_i2c_remove(struct i2c_client *client)
 {
 	struct snd_soc_codec *codec = i2c_get_clientdata(client);
-	i2c_detach_client(client);
 	kfree(codec->reg_cache);
-	kfree(client);
 	return 0;
 }
 
-static int wm8900_i2c_attach(struct i2c_adapter *adap)
-{
-	return i2c_probe(adap, &addr_data, wm8900_codec_probe);
-}
+static const struct i2c_device_id wm8900_i2c_id[] = {
+	{ "wm8900", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, wm8900_i2c_id);
 
-/* corgi i2c codec control layer */
 static struct i2c_driver wm8900_i2c_driver = {
 	.driver = {
 		.name = "WM8900 I2C codec",
 		.owner = THIS_MODULE,
 	},
-	.attach_adapter = wm8900_i2c_attach,
-	.detach_client =  wm8900_i2c_detach,
-	.command =        NULL,
+	.probe = wm8900_i2c_probe,
+	.remove = wm8900_i2c_remove,
+	.id_table = wm8900_i2c_id,
 };
 
-static struct i2c_client client_template = {
-	.name =   "WM8900",
-	.driver = &wm8900_i2c_driver,
-};
+static int wm8900_add_i2c_device(struct platform_device *pdev,
+				 const struct wm8900_setup_data *setup)
+{
+	struct i2c_board_info info;
+	struct i2c_adapter *adapter;
+	struct i2c_client *client;
+	int ret;
+
+	ret = i2c_add_driver(&wm8900_i2c_driver);
+	if (ret != 0) {
+		dev_err(&pdev->dev, "can't add i2c driver\n");
+		return ret;
+	}
+
+	memset(&info, 0, sizeof(struct i2c_board_info));
+	info.addr = setup->i2c_address;
+	strlcpy(info.type, "wm8900", I2C_NAME_SIZE);
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
+	i2c_del_driver(&wm8900_i2c_driver);
+	return -ENODEV;
+}
 #endif
 
 static int wm8900_probe(struct platform_device *pdev)
@@ -1497,11 +1494,8 @@ static int wm8900_probe(struct platform_
 	wm8900_socdev = socdev;
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 	if (setup->i2c_address) {
-		normal_i2c[0] = setup->i2c_address;
 		codec->hw_write = (hw_write_t)i2c_master_send;
-		ret = i2c_add_driver(&wm8900_i2c_driver);
-		if (ret != 0)
-			printk(KERN_ERR "can't add i2c driver");
+		ret = wm8900_add_i2c_device(pdev, setup);
 	}
 #else
 #error Non-I2C interfaces not yet supported
@@ -1521,6 +1515,7 @@ static int wm8900_remove(struct platform
 	snd_soc_free_pcms(socdev);
 	snd_soc_dapm_free(socdev);
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+	i2c_unregister_device(codec->control_data);
 	i2c_del_driver(&wm8900_i2c_driver);
 #endif
 	kfree(codec);
--- linux-2.6.28-rc0.orig/sound/soc/codecs/wm8900.h	2008-10-15 15:14:34.000000000 +0200
+++ linux-2.6.28-rc0/sound/soc/codecs/wm8900.h	2008-10-15 18:33:26.000000000 +0200
@@ -55,6 +55,7 @@
 #define WM8900_
 
 struct wm8900_setup_data {
+	int i2c_bus;
 	unsigned short i2c_address;
 };
 


-- 
Jean Delvare
