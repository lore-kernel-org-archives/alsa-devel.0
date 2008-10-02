From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 5/5] ASoC: Drop device registration from GTA01
	lm4857 driver
Date: Thu,  2 Oct 2008 11:02:31 +0100
Message-ID: <1222941751-3238-5-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081002100200.GA3025@rakim.wolfsonmicro.main>
	<1222941751-3238-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1222941751-3238-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1222941751-3238-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1222941751-3238-4-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8BC2A24517
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Oct 2008 12:02:33 +0200 (CEST)
In-Reply-To: <1222941751-3238-4-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jonas Bonn <jonas.bonn@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Jonas Bonn <jonas.bonn@gmail.com>

Device registration should be handled at the machine level and not
in the driver code itself.  This patch removes the device registration
from the driver code in preparation for moving it to the machine
definition.

[Squashed down two parts to this patch for bisectability - there's also
a third part adding registration of the device to the out of tree GTA01
machine driver -- broonie]

Signed-off-by: Jonas Bonn <jonas.bonn@gmail.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/s3c24xx/neo1973_wm8753.c |   51 ++++-------------------------------
 1 files changed, 6 insertions(+), 45 deletions(-)

diff --git a/sound/soc/s3c24xx/neo1973_wm8753.c b/sound/soc/s3c24xx/neo1973_wm8753.c
index f3ac449..c602674 100644
--- a/sound/soc/s3c24xx/neo1973_wm8753.c
+++ b/sound/soc/s3c24xx/neo1973_wm8753.c
@@ -601,6 +601,8 @@ static int lm4857_i2c_probe(struct i2c_client *client,
 {
 	DBG("Entered %s\n", __func__);
 
+	i2c = client;
+
 	lm4857_write_regs();
 	return 0;
 }
@@ -609,6 +611,8 @@ static int lm4857_i2c_remove(struct i2c_client *client)
 {
 	DBG("Entered %s\n", __func__);
 
+	i2c = NULL;
+
 	return 0;
 }
 
@@ -666,48 +670,6 @@ static struct i2c_driver lm4857_i2c_driver = {
 };
 
 static struct platform_device *neo1973_snd_device;
-static struct i2c_client *lm4857_client;
-
-static int __init neo1973_add_lm4857_device(struct platform_device *pdev,
-					    int i2c_bus,
-					    unsigned short i2c_address)
-{
-	struct i2c_board_info info;
-	struct i2c_adapter *adapter;
-	struct i2c_client *client;
-	int ret;
-
-	ret = i2c_add_driver(&lm4857_i2c_driver);
-	if (ret != 0) {
-		dev_err(&pdev->dev, "can't add lm4857 driver\n");
-		return ret;
-	}
-
-	memset(&info, 0, sizeof(struct i2c_board_info));
-	info.addr = i2c_address;
-	strlcpy(info.type, "neo1973_lm4857", I2C_NAME_SIZE);
-
-	adapter = i2c_get_adapter(i2c_bus);
-	if (!adapter) {
-		dev_err(&pdev->dev, "can't get i2c adapter %d\n", i2c_bus);
-		goto err_driver;
-	}
-
-	client = i2c_new_device(adapter, &info);
-	i2c_put_adapter(adapter);
-	if (!client) {
-		dev_err(&pdev->dev, "can't add lm4857 device at 0x%x\n",
-			(unsigned int)info.addr);
-		goto err_driver;
-	}
-
-	lm4857_client = client;
-	return 0;
-
-err_driver:
-	i2c_del_driver(&lm4857_i2c_driver);
-	return -ENODEV;
-}
 
 static int __init neo1973_init(void)
 {
@@ -728,8 +690,8 @@ static int __init neo1973_init(void)
 		return ret;
 	}
 
-	ret = neo1973_add_lm4857_device(neo1973_snd_device,
-					0, 0x7C);
+	ret = i2c_add_driver(&lm4857_i2c_driver);
+
 	if (ret != 0)
 		platform_device_unregister(neo1973_snd_device);
 
@@ -740,7 +702,6 @@ static void __exit neo1973_exit(void)
 {
 	DBG("Entered %s\n", __func__);
 
-	i2c_unregister_device(lm4857_client);
 	i2c_del_driver(&lm4857_i2c_driver);
 	platform_device_unregister(neo1973_snd_device);
 }
-- 
1.5.6.5
