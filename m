From: Jean Delvare <khali@linux-fr.org>
Subject: [PATCH] ASoC: Convert wm8990 to a new-style i2c driver
Date: Mon, 1 Sep 2008 15:14:14 +0200
Message-ID: <20080901151414.7316f4cc@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 4D7B9243CD
	for <alsa-devel@alsa-project.org>;
	Mon,  1 Sep 2008 15:14:21 +0200 (CEST)
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

Convert the wm8990 codec driver to the new (standard) device driver
binding model. After this change, WM8990 devices are no longer
discovered automatically and must instead be instantiated explicitly.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8990.c |  103 +++++++++++++++++++++++----------------------
 sound/soc/codecs/wm8990.h |    1 
 2 files changed, 54 insertions(+), 50 deletions(-)

--- linux-2.6.27-rc5.orig/sound/soc/codecs/wm8990.c	2008-08-29 09:32:25.000000000 +0200
+++ linux-2.6.27-rc5/sound/soc/codecs/wm8990.c	2008-09-01 12:21:20.000000000 +0200
@@ -1477,81 +1477,86 @@ static struct snd_soc_device *wm8990_soc
  *    low  = 0x34
  *    high = 0x36
  */
-static unsigned short normal_i2c[] = { 0, I2C_CLIENT_END };
 
-/* Magic definition of all other variables and things */
-I2C_CLIENT_INSMOD;
-
-static struct i2c_driver wm8990_i2c_driver;
-static struct i2c_client client_template;
-
-static int wm8990_codec_probe(struct i2c_adapter *adap, int addr, int kind)
+static int wm8990_i2c_probe(struct i2c_client *i2c,
+			    const struct i2c_device_id *id)
 {
 	struct snd_soc_device *socdev = wm8990_socdev;
-	struct wm8990_setup_data *setup = socdev->codec_data;
 	struct snd_soc_codec *codec = socdev->codec;
-	struct i2c_client *i2c;
 	int ret;
 
-	if (addr != setup->i2c_address)
-		return -ENODEV;
-
-	client_template.adapter = adap;
-	client_template.addr = addr;
-
-	i2c =  kmemdup(&client_template, sizeof(client_template), GFP_KERNEL);
-	if (i2c == NULL)
-		return -ENOMEM;
-
 	i2c_set_clientdata(i2c, codec);
 	codec->control_data = i2c;
 
-	ret = i2c_attach_client(i2c);
-	if (ret < 0) {
-		pr_err("failed to attach codec at addr %x\n", addr);
-		goto err;
-	}
-
 	ret = wm8990_init(socdev);
-	if (ret < 0) {
+	if (ret < 0)
 		pr_err("failed to initialise WM8990\n");
-		goto err;
-	}
-	return ret;
 
-err:
-	kfree(i2c);
 	return ret;
 }
 
-static int wm8990_i2c_detach(struct i2c_client *client)
+static int wm8990_i2c_remove(struct i2c_client *client)
 {
 	struct snd_soc_codec *codec = i2c_get_clientdata(client);
-	i2c_detach_client(client);
 	kfree(codec->reg_cache);
-	kfree(client);
 	return 0;
 }
 
-static int wm8990_i2c_attach(struct i2c_adapter *adap)
-{
-	return i2c_probe(adap, &addr_data, wm8990_codec_probe);
-}
+static const struct i2c_device_id wm8990_i2c_id[] = {
+	{ "wm8990", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, wm8990_i2c_id);
 
 static struct i2c_driver wm8990_i2c_driver = {
 	.driver = {
 		.name = "WM8990 I2C Codec",
 		.owner = THIS_MODULE,
 	},
-	.attach_adapter = wm8990_i2c_attach,
-	.detach_client =  wm8990_i2c_detach,
-	.command =        NULL,
+	.probe =    wm8990_i2c_probe,
+	.remove =   wm8990_i2c_remove,
+	.id_table = wm8990_i2c_id,
 };
 
-static struct i2c_client client_template = {
-	.name =   "WM8990",
-	.driver = &wm8990_i2c_driver,
-};
+static int wm8990_add_i2c_device(struct platform_device *pdev,
+				 const struct wm8990_setup_data *setup)
+{
+	struct i2c_board_info info;
+	struct i2c_adapter *adapter;
+	struct i2c_client *client;
+	int ret;
+
+	ret = i2c_add_driver(&wm8990_i2c_driver);
+	if (ret != 0) {
+		dev_err(&pdev->dev, "can't add i2c driver\n");
+		return ret;
+	}
+
+	memset(&info, 0, sizeof(struct i2c_board_info));
+	info.addr = setup->i2c_address;
+	strlcpy(info.type, "wm8990", I2C_NAME_SIZE);
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
+	i2c_del_driver(&wm8990_i2c_driver);
+	return -ENODEV;
+}
 #endif
 
 static int wm8990_probe(struct platform_device *pdev)
@@ -1584,11 +1589,8 @@ static int wm8990_probe(struct platform_
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 	if (setup->i2c_address) {
-		normal_i2c[0] = setup->i2c_address;
 		codec->hw_write = (hw_write_t)i2c_master_send;
-		ret = i2c_add_driver(&wm8990_i2c_driver);
-		if (ret != 0)
-			printk(KERN_ERR "can't add i2c driver");
+		ret = wm8990_add_i2c_device(pdev, setup);
 	}
 #else
 		/* Add other interfaces here */
@@ -1612,6 +1614,7 @@ static int wm8990_remove(struct platform
 	snd_soc_free_pcms(socdev);
 	snd_soc_dapm_free(socdev);
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+	i2c_unregister_device(codec->control_data);
 	i2c_del_driver(&wm8990_i2c_driver);
 #endif
 	kfree(codec->private_data);
--- linux-2.6.27-rc5.orig/sound/soc/codecs/wm8990.h	2008-08-21 09:10:47.000000000 +0200
+++ linux-2.6.27-rc5/sound/soc/codecs/wm8990.h	2008-09-01 12:05:05.000000000 +0200
@@ -827,6 +827,7 @@
 #define WM8990_AINRMUX_PWR_BIT			3
 
 struct wm8990_setup_data {
+	unsigned i2c_bus;
 	unsigned short i2c_address;
 };
 


-- 
Jean Delvare
