From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 02/14] ASoC: Convert wm8753 to a new-style i2c
	driver
Date: Fri,  5 Sep 2008 15:35:10 +0100
Message-ID: <1220625322-27982-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20080905143504.GA27793@rakim.wolfsonmicro.main>
	<1220625322-27982-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1A7B9103841
	for <alsa-devel@alsa-project.org>;
	Fri,  5 Sep 2008 16:35:27 +0200 (CEST)
In-Reply-To: <1220625322-27982-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: Jean Delvare <khali@linux-fr.org>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Frank Mandarino <fmandarino@endrelia.com>
List-Id: alsa-devel@alsa-project.org

From: Jean Delvare <khali@linux-fr.org>

Convert the wm8753 codec driver to the new (standard) i2c device
driver binding model.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Ville Syrjala <syrjala@sci.fi>
Cc: Frank Mandarino <fmandarino@endrelia.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8753.c          |  106 ++++++++++++++++++------------------
 sound/soc/codecs/wm8753.h          |    1 +
 sound/soc/s3c24xx/neo1973_wm8753.c |    1 +
 3 files changed, 55 insertions(+), 53 deletions(-)

diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index 5761164..b3e1b37 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -1637,84 +1637,86 @@ static struct snd_soc_device *wm8753_socdev;
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
@@ -1748,11 +1750,8 @@ static int wm8753_probe(struct platform_device *pdev)
 
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
@@ -1796,6 +1795,7 @@ static int wm8753_remove(struct platform_device *pdev)
 	snd_soc_free_pcms(socdev);
 	snd_soc_dapm_free(socdev);
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+	i2c_unregister_device(codec->control_data);
 	i2c_del_driver(&wm8753_i2c_driver);
 #endif
 	kfree(codec->private_data);
diff --git a/sound/soc/codecs/wm8753.h b/sound/soc/codecs/wm8753.h
index 44f5f1f..7defde0 100644
--- a/sound/soc/codecs/wm8753.h
+++ b/sound/soc/codecs/wm8753.h
@@ -79,6 +79,7 @@
 #define WM8753_ADCTL2		0x3f
 
 struct wm8753_setup_data {
+	int i2c_bus;
 	unsigned short i2c_address;
 };
 
diff --git a/sound/soc/s3c24xx/neo1973_wm8753.c b/sound/soc/s3c24xx/neo1973_wm8753.c
index 3aa441f..181d299 100644
--- a/sound/soc/s3c24xx/neo1973_wm8753.c
+++ b/sound/soc/s3c24xx/neo1973_wm8753.c
@@ -586,6 +586,7 @@ static struct snd_soc_machine neo1973 = {
 };
 
 static struct wm8753_setup_data neo1973_wm8753_setup = {
+	.i2c_bus = 0,
 	.i2c_address = 0x1a,
 };
 
-- 
1.5.6.5
