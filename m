From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/4] ASoC: Remove I2C ifdefs from wm8961 driver
Date: Sat, 17 Dec 2011 09:39:14 +0000
Message-ID: <1324114756-24254-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1324114756-24254-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 97089244B8
	for <alsa-devel@alsa-project.org>; Sat, 17 Dec 2011 10:39:19 +0100 (CET)
In-Reply-To: <1324114756-24254-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The driver only supports I2C so no need to conditionalise its use.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8961.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm8961.c b/sound/soc/codecs/wm8961.c
index 58fbf0a..13a0850 100644
--- a/sound/soc/codecs/wm8961.c
+++ b/sound/soc/codecs/wm8961.c
@@ -1081,7 +1081,6 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8961 = {
 	.volatile_register = wm8961_volatile_register,
 };
 
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 static __devinit int wm8961_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
@@ -1123,27 +1122,22 @@ static struct i2c_driver wm8961_i2c_driver = {
 	.remove =   __devexit_p(wm8961_i2c_remove),
 	.id_table = wm8961_i2c_id,
 };
-#endif
 
 static int __init wm8961_modinit(void)
 {
 	int ret = 0;
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 	ret = i2c_add_driver(&wm8961_i2c_driver);
 	if (ret != 0) {
 		printk(KERN_ERR "Failed to register wm8961 I2C driver: %d\n",
 		       ret);
 	}
-#endif
 	return ret;
 }
 module_init(wm8961_modinit);
 
 static void __exit wm8961_exit(void)
 {
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 	i2c_del_driver(&wm8961_i2c_driver);
-#endif
 }
 module_exit(wm8961_exit);
 
-- 
1.7.7.3
