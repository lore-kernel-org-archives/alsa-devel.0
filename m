From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Remove conditional I2C usage from
	tlv320aic3x driver
Date: Mon, 21 Nov 2011 18:15:00 +0000
Message-ID: <1321899300-6624-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 86798244B4
	for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2011 19:15:04 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The driver only supports I2C so doesn't need to do things conditionally.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/tlv320aic3x.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 14cb553..2e2bf18 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -1481,7 +1481,6 @@ static struct snd_soc_codec_driver soc_codec_dev_aic3x = {
 	.resume = aic3x_resume,
 };
 
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 /*
  * AIC3X 2 wire address can be up to 4 devices with device addresses
  * 0x18, 0x19, 0x1A, 0x1B
@@ -1548,27 +1547,22 @@ static struct i2c_driver aic3x_i2c_driver = {
 	.remove = aic3x_i2c_remove,
 	.id_table = aic3x_i2c_id,
 };
-#endif
 
 static int __init aic3x_modinit(void)
 {
 	int ret = 0;
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 	ret = i2c_add_driver(&aic3x_i2c_driver);
 	if (ret != 0) {
 		printk(KERN_ERR "Failed to register TLV320AIC3x I2C driver: %d\n",
 		       ret);
 	}
-#endif
 	return ret;
 }
 module_init(aic3x_modinit);
 
 static void __exit aic3x_exit(void)
 {
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 	i2c_del_driver(&aic3x_i2c_driver);
-#endif
 }
 module_exit(aic3x_exit);
 
-- 
1.7.7.3
