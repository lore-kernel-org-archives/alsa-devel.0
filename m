From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/8] ASoC: Convert uda1380 to a new-style i2c
	driver
Date: Mon,  1 Sep 2008 18:46:58 +0100
Message-ID: <1220291224-11269-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1220291224-11269-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D6A881037F9
	for <alsa-devel@alsa-project.org>;
	Mon,  1 Sep 2008 19:47:06 +0200 (CEST)
In-Reply-To: <1220291224-11269-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: Jean Delvare <khali@linux-fr.org>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

From: Jean Delvare <khali@linux-fr.org>

Convert the uda1380 codec driver to the new (standard) device driver
binding model.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/uda1380.c |  109 +++++++++++++++++++++----------------------
 sound/soc/codecs/uda1380.h |    1 +
 2 files changed, 54 insertions(+), 56 deletions(-)

diff --git a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
index 807318f..f0c8043 100644
--- a/sound/soc/codecs/uda1380.c
+++ b/sound/soc/codecs/uda1380.c
@@ -701,87 +701,86 @@ static struct snd_soc_device *uda1380_socdev;
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 
-#define I2C_DRIVERID_UDA1380 0xfefe /* liam -  need a proper id */
-
-static unsigned short normal_i2c[] = { 0, I2C_CLIENT_END };
-
-/* Magic definition of all other variables and things */
-I2C_CLIENT_INSMOD;
-
-static struct i2c_driver uda1380_i2c_driver;
-static struct i2c_client client_template;
-
-/* If the i2c layer weren't so broken, we could pass this kind of data
-   around */
-
-static int uda1380_codec_probe(struct i2c_adapter *adap, int addr, int kind)
+static int uda1380_i2c_probe(struct i2c_client *i2c,
+			     const struct i2c_device_id *id)
 {
 	struct snd_soc_device *socdev = uda1380_socdev;
 	struct uda1380_setup_data *setup = socdev->codec_data;
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
-		pr_err("uda1380: failed to attach codec at addr %x\n", addr);
-		goto err;
-	}
-
 	ret = uda1380_init(socdev, setup->dac_clk);
-	if (ret < 0) {
+	if (ret < 0)
 		pr_err("uda1380: failed to initialise UDA1380\n");
-		goto err;
-	}
-	return ret;
 
-err:
-	kfree(i2c);
 	return ret;
 }
 
-static int uda1380_i2c_detach(struct i2c_client *client)
+static int uda1380_i2c_remove(struct i2c_client *client)
 {
 	struct snd_soc_codec *codec = i2c_get_clientdata(client);
-	i2c_detach_client(client);
 	kfree(codec->reg_cache);
-	kfree(client);
 	return 0;
 }
 
-static int uda1380_i2c_attach(struct i2c_adapter *adap)
-{
-	return i2c_probe(adap, &addr_data, uda1380_codec_probe);
-}
+static const struct i2c_device_id uda1380_i2c_id[] = {
+	{ "uda1380", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, uda1380_i2c_id);
 
 static struct i2c_driver uda1380_i2c_driver = {
 	.driver = {
 		.name =  "UDA1380 I2C Codec",
 		.owner = THIS_MODULE,
 	},
-	.id =             I2C_DRIVERID_UDA1380,
-	.attach_adapter = uda1380_i2c_attach,
-	.detach_client =  uda1380_i2c_detach,
-	.command =        NULL,
+	.probe =    uda1380_i2c_probe,
+	.remove =   uda1380_i2c_remove,
+	.id_table = uda1380_i2c_id,
 };
 
-static struct i2c_client client_template = {
-	.name =   "UDA1380",
-	.driver = &uda1380_i2c_driver,
-};
+static int uda1380_add_i2c_device(struct platform_device *pdev,
+				  const struct uda1380_setup_data *setup)
+{
+	struct i2c_board_info info;
+	struct i2c_adapter *adapter;
+	struct i2c_client *client;
+	int ret;
+
+	ret = i2c_add_driver(&uda1380_i2c_driver);
+	if (ret != 0) {
+		dev_err(&pdev->dev, "can't add i2c driver\n");
+		return ret;
+	}
+
+	memset(&info, 0, sizeof(struct i2c_board_info));
+	info.addr = setup->i2c_address;
+	strlcpy(info.type, "uda1380", I2C_NAME_SIZE);
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
+	i2c_del_driver(&uda1380_i2c_driver);
+	return -ENODEV;
+}
 #endif
 
 static int uda1380_probe(struct platform_device *pdev)
@@ -806,11 +805,8 @@ static int uda1380_probe(struct platform_device *pdev)
 	uda1380_socdev = socdev;
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 	if (setup->i2c_address) {
-		normal_i2c[0] = setup->i2c_address;
 		codec->hw_write = (hw_write_t)i2c_master_send;
-		ret = i2c_add_driver(&uda1380_i2c_driver);
-		if (ret != 0)
-			printk(KERN_ERR "can't add i2c driver");
+		ret = uda1380_add_i2c_device(pdev, setup);
 	}
 #else
 	/* Add other interfaces here */
@@ -833,6 +829,7 @@ static int uda1380_remove(struct platform_device *pdev)
 	snd_soc_free_pcms(socdev);
 	snd_soc_dapm_free(socdev);
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+	i2c_unregister_device(codec->control_data);
 	i2c_del_driver(&uda1380_i2c_driver);
 #endif
 	kfree(codec);
diff --git a/sound/soc/codecs/uda1380.h b/sound/soc/codecs/uda1380.h
index 50c603e..c55c17a 100644
--- a/sound/soc/codecs/uda1380.h
+++ b/sound/soc/codecs/uda1380.h
@@ -73,6 +73,7 @@
 #define R23_AGC_EN	0x0001
 
 struct uda1380_setup_data {
+	int            i2c_bus;
 	unsigned short i2c_address;
 	int            dac_clk;
 #define UDA1380_DAC_CLK_SYSCLK 0
-- 
1.5.6.5
