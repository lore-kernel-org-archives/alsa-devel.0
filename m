From: Jean Delvare <khali@linux-fr.org>
Subject: [PATCH 2/3] ASoC: Convert wm8753 to a new-style i2c
	driver
Date: Mon, 1 Sep 2008 17:45:34 +0200
Message-ID: <20080901174534.663528a3@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	by alsa0.perex.cz (Postfix) with ESMTP id A5E9924479
	for <alsa-devel@alsa-project.org>;
	Mon,  1 Sep 2008 17:45:40 +0200 (CEST)
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
Cc: Ville@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Graeme Gregory <graeme@openmoko.org>, Tim Niemeyer <reddog@mastersword.de>, Frank Mandarino <fmandarino@endrelia.com>
List-Id: alsa-devel@alsa-project.org

Convert the wm8753 codec driver to the new (standard) i2c device
driver binding model.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Ville Syrjala <syrjala@sci.fi>
Cc: Frank Mandarino <fmandarino@endrelia.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
Warning: this assumes that the neo1973 has its codec chip on I2C bus
0, which may or may not be the case. Someone with this machine please
test and report.

 include/linux/i2c-id.h             |    1 
 sound/soc/codecs/wm8753.c          |  106 ++++++++++++++++++------------------
 sound/soc/codecs/wm8753.h          |    1 
 sound/soc/s3c24xx/neo1973_wm8753.c |    1 
 4 files changed, 55 insertions(+), 54 deletions(-)

--- linux-2.6.27-rc5.orig/include/linux/i2c-id.h	2008-09-01 11:06:04.000000000 +0200
+++ linux-2.6.27-rc5/include/linux/i2c-id.h	2008-09-01 12:46:57.000000000 +0200
@@ -64,7 +64,6 @@
 #define I2C_DRIVERID_SAA717X	80	/* saa717x video encoder	*/
 #define I2C_DRIVERID_DS1672	81	/* Dallas/Maxim DS1672 RTC	*/
 #define I2C_DRIVERID_TLV320AIC23B 87	/* TI TLV320AIC23B audio codec  */
-#define I2C_DRIVERID_WM8753	91	/* Wolfson WM8753 audio codec */
 #define I2C_DRIVERID_LM4857 	92 	/* LM4857 Audio Amplifier */
 #define I2C_DRIVERID_VP27SMPX	93	/* Panasonic VP27s tuner internal MPX */
 #define I2C_DRIVERID_CS4270	94	/* Cirrus Logic 4270 audio codec */
--- linux-2.6.27-rc5.orig/sound/soc/codecs/wm8753.c	2008-08-29 09:32:25.000000000 +0200
+++ linux-2.6.27-rc5/sound/soc/codecs/wm8753.c	2008-09-01 12:49:46.000000000 +0200
@@ -1637,84 +1637,86 @@ static struct snd_soc_device *wm8753_soc
  *    low  = 0x1a
  *    high = 0x1b
  */
-static unsigned short normal_i2c[] = { 0, I2C_CLIENT_END };
 
-/* Magic definition of all other variables and things */
-I2C_CLIENT_INSMOD;
-
-static struct i2c_driver wm8753_i2c_driver;
-static struct i2c_client client_template;
-
-static int wm8753_codec_probe(struct i2c_adapter *adap, int addr, int kind)
+static int wm8753_i2c_probe(struct i2c_client *i2c,
+			    const struct i2c_device_id *id)
 {
 	struct snd_soc_device *socdev = wm8753_socdev;
-	struct wm8753_setup_data *setup = socdev->codec_data;
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
-	if (!i2c)
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
 	ret = wm8753_init(socdev);
-	if (ret < 0) {
+	if (ret < 0)
 		pr_err("failed to initialise WM8753\n");
-		goto err;
-	}
-
-	return ret;
 
-err:
-	kfree(i2c);
 	return ret;
 }
 
-static int wm8753_i2c_detach(struct i2c_client *client)
+static int wm8753_i2c_remove(struct i2c_client *client)
 {
 	struct snd_soc_codec *codec = i2c_get_clientdata(client);
-	i2c_detach_client(client);
 	kfree(codec->reg_cache);
-	kfree(client);
 	return 0;
 }
 
-static int wm8753_i2c_attach(struct i2c_adapter *adap)
-{
-	return i2c_probe(adap, &addr_data, wm8753_codec_probe);
-}
+static const struct i2c_device_id wm8753_i2c_id[] = {
+	{ "wm8753", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, wm8753_i2c_id);
 
-/* corgi i2c codec control layer */
 static struct i2c_driver wm8753_i2c_driver = {
 	.driver = {
 		.name = "WM8753 I2C Codec",
 		.owner = THIS_MODULE,
 	},
-	.id =             I2C_DRIVERID_WM8753,
-	.attach_adapter = wm8753_i2c_attach,
-	.detach_client =  wm8753_i2c_detach,
-	.command =        NULL,
+	.probe =    wm8753_i2c_probe,
+	.remove =   wm8753_i2c_remove,
+	.id_table = wm8753_i2c_id,
 };
 
-static struct i2c_client client_template = {
-	.name =   "WM8753",
-	.driver = &wm8753_i2c_driver,
-};
+static int wm8753_add_i2c_device(struct platform_device *pdev,
+				 const struct wm8753_setup_data *setup)
+{
+	struct i2c_board_info info;
+	struct i2c_adapter *adapter;
+	struct i2c_client *client;
+	int ret;
+
+	ret = i2c_add_driver(&wm8753_i2c_driver);
+	if (ret != 0) {
+		dev_err(&pdev->dev, "can't add i2c driver\n");
+		return ret;
+	}
+
+	memset(&info, 0, sizeof(struct i2c_board_info));
+	info.addr = setup->i2c_address;
+	strlcpy(info.type, "wm8753", I2C_NAME_SIZE);
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
+	i2c_del_driver(&wm8753_i2c_driver);
+	return -ENODEV;
+}
 #endif
 
 static int wm8753_probe(struct platform_device *pdev)
@@ -1748,11 +1750,8 @@ static int wm8753_probe(struct platform_
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 	if (setup->i2c_address) {
-		normal_i2c[0] = setup->i2c_address;
 		codec->hw_write = (hw_write_t)i2c_master_send;
-		ret = i2c_add_driver(&wm8753_i2c_driver);
-		if (ret != 0)
-			printk(KERN_ERR "can't add i2c driver");
+		ret = wm8753_add_i2c_device(pdev, setup);
 	}
 #else
 		/* Add other interfaces here */
@@ -1796,6 +1795,7 @@ static int wm8753_remove(struct platform
 	snd_soc_free_pcms(socdev);
 	snd_soc_dapm_free(socdev);
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+	i2c_unregister_device(codec->control_data);
 	i2c_del_driver(&wm8753_i2c_driver);
 #endif
 	kfree(codec->private_data);
--- linux-2.6.27-rc5.orig/sound/soc/codecs/wm8753.h	2008-08-05 18:18:18.000000000 +0200
+++ linux-2.6.27-rc5/sound/soc/codecs/wm8753.h	2008-09-01 12:44:52.000000000 +0200
@@ -79,6 +79,7 @@
 #define WM8753_ADCTL2		0x3f
 
 struct wm8753_setup_data {
+	int i2c_bus;
 	unsigned short i2c_address;
 };
 
--- linux-2.6.27-rc5.orig/sound/soc/s3c24xx/neo1973_wm8753.c	2008-08-23 22:18:36.000000000 +0200
+++ linux-2.6.27-rc5/sound/soc/s3c24xx/neo1973_wm8753.c	2008-09-01 12:45:10.000000000 +0200
@@ -586,6 +586,7 @@ static struct snd_soc_machine neo1973 = 
 };
 
 static struct wm8753_setup_data neo1973_wm8753_setup = {
+	.i2c_bus = 0,
 	.i2c_address = 0x1a,
 };
 


-- 
Jean Delvare
