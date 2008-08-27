From: Jean Delvare <khali@linux-fr.org>
Subject: [PATCH] ASoC: Convert wm8731 to a new-style i2c driver
 (v2, testers wanted)
Date: Wed, 27 Aug 2008 22:52:25 +0200
Message-ID: <20080827225225.58dcf057@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 13D03247E5
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Aug 2008 22:52:32 +0200 (CEST)
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
Cc: Dmitry Baryshkov <dbaryshkov@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Eric Miao <eric.miao@marvell.com>, Richard Purdie <rpurdie@rpsys.net>, Andrew Victor <linux@maxim.org.za>, Liam Girdwood <lrg@kernel.org>
List-Id: alsa-devel@alsa-project.org

Convert the wm8731 codec driver to the new (standard) device driver
binding model.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Tested-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
This second version fixes a bug reported by Manuel Lauss where
codec->control_data was used before being initialized.

Warning: this assumes that the corgi, poodle and eti_b1 have their
codec chips on I2C bus 0, which may or may not be the case. Someone
with these machines please test and report.

 include/linux/i2c-id.h         |    1 
 sound/soc/at91/eti_b1_wm8731.c |    1 
 sound/soc/codecs/wm8731.c      |  108 +++++++++++++++++++---------------------
 sound/soc/codecs/wm8731.h      |    1 
 sound/soc/pxa/corgi.c          |    1 
 sound/soc/pxa/poodle.c         |    1 
 6 files changed, 57 insertions(+), 56 deletions(-)

--- linux-2.6.27-rc4.orig/include/linux/i2c-id.h	2008-08-27 22:27:01.000000000 +0200
+++ linux-2.6.27-rc4/include/linux/i2c-id.h	2008-08-27 22:38:47.000000000 +0200
@@ -64,7 +64,6 @@
 #define I2C_DRIVERID_SAA717X	80	/* saa717x video encoder	*/
 #define I2C_DRIVERID_DS1672	81	/* Dallas/Maxim DS1672 RTC	*/
 #define I2C_DRIVERID_TLV320AIC23B 87	/* TI TLV320AIC23B audio codec  */
-#define I2C_DRIVERID_WM8731	89	/* Wolfson WM8731 audio codec */
 #define I2C_DRIVERID_WM8753	91	/* Wolfson WM8753 audio codec */
 #define I2C_DRIVERID_LM4857 	92 	/* LM4857 Audio Amplifier */
 #define I2C_DRIVERID_VP27SMPX	93	/* Panasonic VP27s tuner internal MPX */
--- linux-2.6.27-rc4.orig/sound/soc/at91/eti_b1_wm8731.c	2008-08-27 22:27:01.000000000 +0200
+++ linux-2.6.27-rc4/sound/soc/at91/eti_b1_wm8731.c	2008-08-27 22:38:47.000000000 +0200
@@ -243,6 +243,7 @@ static struct snd_soc_machine snd_soc_ma
 };
 
 static struct wm8731_setup_data eti_b1_wm8731_setup = {
+	.i2c_bus = 0,
 	.i2c_address = 0x1a,
 };
 
--- linux-2.6.27-rc4.orig/sound/soc/codecs/wm8731.c	2008-08-27 22:27:01.000000000 +0200
+++ linux-2.6.27-rc4/sound/soc/codecs/wm8731.c	2008-08-27 22:45:15.000000000 +0200
@@ -570,86 +570,86 @@ static struct snd_soc_device *wm8731_soc
  *    low  = 0x1a
  *    high = 0x1b
  */
-static unsigned short normal_i2c[] = { 0, I2C_CLIENT_END };
 
-/* Magic definition of all other variables and things */
-I2C_CLIENT_INSMOD;
-
-static struct i2c_driver wm8731_i2c_driver;
-static struct i2c_client client_template;
-
-/* If the i2c layer weren't so broken, we could pass this kind of data
-   around */
-
-static int wm8731_codec_probe(struct i2c_adapter *adap, int addr, int kind)
+static int wm8731_i2c_probe(struct i2c_client *i2c,
+			    const struct i2c_device_id *id)
 {
 	struct snd_soc_device *socdev = wm8731_socdev;
-	struct wm8731_setup_data *setup = socdev->codec_data;
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
-		pr_err("failed to attach codec at addr %x\n", addr);
-		goto err;
-	}
-
 	ret = wm8731_init(socdev);
-	if (ret < 0) {
+	if (ret < 0)
 		pr_err("failed to initialise WM8731\n");
-		goto err;
-	}
-	return ret;
 
-err:
-	kfree(i2c);
 	return ret;
 }
 
-static int wm8731_i2c_detach(struct i2c_client *client)
+static int wm8731_i2c_remove(struct i2c_client *client)
 {
 	struct snd_soc_codec *codec = i2c_get_clientdata(client);
-	i2c_detach_client(client);
 	kfree(codec->reg_cache);
-	kfree(client);
 	return 0;
 }
 
-static int wm8731_i2c_attach(struct i2c_adapter *adap)
-{
-	return i2c_probe(adap, &addr_data, wm8731_codec_probe);
-}
+static const struct i2c_device_id wm8731_i2c_id[] = {
+	{ "wm8731", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, wm8731_i2c_id);
 
-/* corgi i2c codec control layer */
 static struct i2c_driver wm8731_i2c_driver = {
 	.driver = {
 		.name = "WM8731 I2C Codec",
 		.owner = THIS_MODULE,
 	},
-	.id =             I2C_DRIVERID_WM8731,
-	.attach_adapter = wm8731_i2c_attach,
-	.detach_client =  wm8731_i2c_detach,
-	.command =        NULL,
+	.probe =    wm8731_i2c_probe,
+	.remove =   wm8731_i2c_remove,
+	.id_table = wm8731_i2c_id,
 };
 
-static struct i2c_client client_template = {
-	.name =   "WM8731",
-	.driver = &wm8731_i2c_driver,
-};
+static int wm8731_add_i2c_device(struct platform_device *pdev,
+				 const struct wm8731_setup_data *setup)
+{
+	struct i2c_board_info info;
+	struct i2c_adapter *adapter;
+	struct i2c_client *client;
+	int ret;
+
+	ret = i2c_add_driver(&wm8731_i2c_driver);
+	if (ret != 0) {
+		dev_err(&pdev->dev, "can't add i2c driver\n");
+		return ret;
+	}
+
+	memset(&info, 0, sizeof(struct i2c_board_info));
+	info.addr = setup->i2c_address;
+	strlcpy(info.type, "wm8731", I2C_NAME_SIZE);
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
+	i2c_del_driver(&wm8731_i2c_driver);
+	return -ENODEV;
+}
 #endif
 
 static int wm8731_probe(struct platform_device *pdev)
@@ -682,11 +682,8 @@ static int wm8731_probe(struct platform_
 	wm8731_socdev = socdev;
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 	if (setup->i2c_address) {
-		normal_i2c[0] = setup->i2c_address;
 		codec->hw_write = (hw_write_t)i2c_master_send;
-		ret = i2c_add_driver(&wm8731_i2c_driver);
-		if (ret != 0)
-			printk(KERN_ERR "can't add i2c driver");
+		ret = wm8731_add_i2c_device(pdev, setup);
 	}
 #else
 	/* Add other interfaces here */
@@ -711,6 +708,7 @@ static int wm8731_remove(struct platform
 	snd_soc_free_pcms(socdev);
 	snd_soc_dapm_free(socdev);
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+	i2c_unregister_device(codec->control_data);
 	i2c_del_driver(&wm8731_i2c_driver);
 #endif
 	kfree(codec->private_data);
--- linux-2.6.27-rc4.orig/sound/soc/codecs/wm8731.h	2008-08-27 22:27:01.000000000 +0200
+++ linux-2.6.27-rc4/sound/soc/codecs/wm8731.h	2008-08-27 22:38:47.000000000 +0200
@@ -35,6 +35,7 @@
 #define WM8731_DAI		0
 
 struct wm8731_setup_data {
+	int            i2c_bus;
 	unsigned short i2c_address;
 };
 
--- linux-2.6.27-rc4.orig/sound/soc/pxa/corgi.c	2008-08-27 22:27:01.000000000 +0200
+++ linux-2.6.27-rc4/sound/soc/pxa/corgi.c	2008-08-27 22:38:47.000000000 +0200
@@ -330,6 +330,7 @@ static struct snd_soc_machine snd_soc_ma
 
 /* corgi audio private data */
 static struct wm8731_setup_data corgi_wm8731_setup = {
+	.i2c_bus = 0,
 	.i2c_address = 0x1b,
 };
 
--- linux-2.6.27-rc4.orig/sound/soc/pxa/poodle.c	2008-08-27 22:27:01.000000000 +0200
+++ linux-2.6.27-rc4/sound/soc/pxa/poodle.c	2008-08-27 22:38:47.000000000 +0200
@@ -284,6 +284,7 @@ static struct snd_soc_machine snd_soc_ma
 
 /* poodle audio private data */
 static struct wm8731_setup_data poodle_wm8731_setup = {
+	.i2c_bus = 0,
 	.i2c_address = 0x1b,
 };
 


-- 
Jean Delvare
