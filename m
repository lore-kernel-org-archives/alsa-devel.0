From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 03/14] ASoC: Convert neo1973/lm4857 to a
	new-style i2c driver
Date: Fri,  5 Sep 2008 15:35:11 +0100
Message-ID: <1220625322-27982-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20080905143504.GA27793@rakim.wolfsonmicro.main>
	<1220625322-27982-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1220625322-27982-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B7847103841
	for <alsa-devel@alsa-project.org>;
	Fri,  5 Sep 2008 16:35:24 +0200 (CEST)
In-Reply-To: <1220625322-27982-2-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: Jean Delvare <khali@linux-fr.org>, Graeme Gregory <graeme@openmoko.org>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tim Niemeyer <reddog@mastersword.de>
List-Id: alsa-devel@alsa-project.org

From: Jean Delvare <khali@linux-fr.org>

Convert the lm4857 driver in neo1973_wm8753 to the new (standard)
i2c device driver binding model. I assumed that the LM4857 was always
on the same I2C bus as the WM8753 codec.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Tim Niemeyer <reddog@mastersword.de>
Cc: Graeme Gregory <graeme@openmoko.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/s3c24xx/neo1973_wm8753.c |  110 +++++++++++++++++++-----------------
 1 files changed, 58 insertions(+), 52 deletions(-)

diff --git a/sound/soc/s3c24xx/neo1973_wm8753.c b/sound/soc/s3c24xx/neo1973_wm8753.c
index 181d299..47ddcde 100644
--- a/sound/soc/s3c24xx/neo1973_wm8753.c
+++ b/sound/soc/s3c24xx/neo1973_wm8753.c
@@ -597,54 +597,20 @@ static struct snd_soc_device neo1973_snd_devdata = {
 	.codec_data = &neo1973_wm8753_setup,
 };
 
-static struct i2c_client client_template;
-
-static const unsigned short normal_i2c[] = { 0x7C, I2C_CLIENT_END };
-
-/* Magic definition of all other variables and things */
-I2C_CLIENT_INSMOD;
-
-static int lm4857_amp_probe(struct i2c_adapter *adap, int addr, int kind)
+static int lm4857_i2c_probe(struct i2c_client *client,
+			    const struct i2c_device_id *id)
 {
-	int ret;
-
 	DBG("Entered %s\n", __func__);
 
-	client_template.adapter = adap;
-	client_template.addr = addr;
-
-	i2c = kmemdup(&client_template, sizeof(client_template), GFP_KERNEL);
-	if (i2c == NULL)
-		return -ENOMEM;
-
-	ret = i2c_attach_client(i2c);
-	if (ret < 0) {
-		printk(KERN_ERR "LM4857 failed to attach at addr %x\n", addr);
-		goto exit_err;
-	}
-
 	lm4857_write_regs();
-	return ret;
-
-exit_err:
-	kfree(i2c);
-	return ret;
-}
-
-static int lm4857_i2c_detach(struct i2c_client *client)
-{
-	DBG("Entered %s\n", __func__);
-
-	i2c_detach_client(client);
-	kfree(client);
 	return 0;
 }
 
-static int lm4857_i2c_attach(struct i2c_adapter *adap)
+static int lm4857_i2c_remove(struct i2c_client *client)
 {
 	DBG("Entered %s\n", __func__);
 
-	return i2c_probe(adap, &addr_data, lm4857_amp_probe);
+	return 0;
 }
 
 static u8 lm4857_state;
@@ -682,27 +648,67 @@ static void lm4857_shutdown(struct i2c_client *dev)
 	lm4857_write_regs();
 }
 
-/* corgi i2c codec control layer */
+static const struct i2c_device_id lm4857_i2c_id[] = {
+	{ "neo1973_lm4857", 0 }
+	{ }
+};
+
 static struct i2c_driver lm4857_i2c_driver = {
 	.driver = {
 		.name = "LM4857 I2C Amp",
 		.owner = THIS_MODULE,
 	},
-	.id =             I2C_DRIVERID_LM4857,
 	.suspend =        lm4857_suspend,
 	.resume	=         lm4857_resume,
 	.shutdown =       lm4857_shutdown,
-	.attach_adapter = lm4857_i2c_attach,
-	.detach_client =  lm4857_i2c_detach,
-	.command =        NULL,
-};
-
-static struct i2c_client client_template = {
-	.name =   "LM4857",
-	.driver = &lm4857_i2c_driver,
+	.probe =          lm4857_i2c_probe,
+	.remove =         lm4857_i2c_remove,
+	.id_table =       lm4857_i2c_id,
 };
 
 static struct platform_device *neo1973_snd_device;
+static struct i2c_client *lm4857_client;
+
+static int __init neo1973_add_lm4857_device(struct platform_device *pdev,
+					    int i2c_bus,
+					    unsigned short i2c_address)
+{
+	struct i2c_board_info info;
+	struct i2c_adapter *adapter;
+	struct i2c_client *client;
+	int ret;
+
+	ret = i2c_add_driver(&lm4857_i2c_driver);
+	if (ret != 0) {
+		dev_err(&pdev->dev, "can't add lm4857 driver\n");
+		return ret;
+	}
+
+	memset(&info, 0, sizeof(struct i2c_board_info));
+	info.addr = i2c_address;
+	strlcpy(info.type, "neo1973_lm4857", I2C_NAME_SIZE);
+
+	adapter = i2c_get_adapter(i2c_bus);
+	if (!adapter) {
+		dev_err(&pdev->dev, "can't get i2c adapter %d\n", i2c_bus);
+		goto err_driver;
+	}
+
+	client = i2c_new_device(adapter, &info);
+	i2c_put_adapter(adapter);
+	if (!client) {
+		dev_err(&pdev->dev, "can't add lm4857 device at 0x%x\n",
+			(unsigned int)info.addr);
+		goto err_driver;
+	}
+
+	lm4857_client = client;
+	return 0;
+
+err_driver:
+	i2c_del_driver(&lm4857_i2c_driver);
+	return -ENODEV;
+}
 
 static int __init neo1973_init(void)
 {
@@ -723,11 +729,10 @@ static int __init neo1973_init(void)
 		return ret;
 	}
 
-	ret = i2c_add_driver(&lm4857_i2c_driver);
-	if (ret != 0) {
-		printk(KERN_ERR "can't add i2c driver");
+	ret = neo1973_add_lm4857_device(neo1973_snd_device,
+					neo1973_wm8753_setup, 0x7C);
+	if (ret != 0)
 		platform_device_unregister(neo1973_snd_device);
-	}
 
 	return ret;
 }
@@ -736,6 +741,7 @@ static void __exit neo1973_exit(void)
 {
 	DBG("Entered %s\n", __func__);
 
+	i2c_unregister_device(lm4857_client);
 	i2c_del_driver(&lm4857_i2c_driver);
 	platform_device_unregister(neo1973_snd_device);
 }
-- 
1.5.6.5
