From: Leon Romanovsky <leon@leon.nu>
Subject: [PATCH 2/6] ASoC: alc5632: Fix compile without
	CONFIG_I2C
Date: Wed, 16 Nov 2011 12:06:59 +0200
Message-ID: <1321438023-29660-3-git-send-email-leon@leon.nu>
References: <1321438023-29660-1-git-send-email-leon@leon.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 7BB0D24436
	for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2011 11:07:19 +0100 (CET)
Received: by mail-ey0-f179.google.com with SMTP id 10so213890eyz.38
	for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2011 02:07:19 -0800 (PST)
In-Reply-To: <1321438023-29660-1-git-send-email-leon@leon.nu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@ti.com
Cc: alsa-devel@alsa-project.org, Leon Romanovsky <leon@leon.nu>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Leon Romanovsky <leon@leon.nu>
---
 sound/soc/codecs/alc5632.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/alc5632.c b/sound/soc/codecs/alc5632.c
index 42feae0..b72d467 100644
--- a/sound/soc/codecs/alc5632.c
+++ b/sound/soc/codecs/alc5632.c
@@ -1105,6 +1105,7 @@ static struct regmap_config alc5632_regmap = {
  *    low  = 0x1a
  *    high = 0x1b
  */
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 static __devinit int alc5632_i2c_probe(struct i2c_client *client,
 				const struct i2c_device_id *id)
 {
@@ -1203,24 +1204,27 @@ static struct i2c_driver alc5632_i2c_driver = {
 	.remove =  __devexit_p(alc5632_i2c_remove),
 	.id_table = alc5632_i2c_table,
 };
+#endif
 
 static int __init alc5632_modinit(void)
 {
-	int ret;
-
+	int ret = 0;
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 	ret = i2c_add_driver(&alc5632_i2c_driver);
 	if (ret != 0) {
 		printk(KERN_ERR "%s: can't add i2c driver", __func__);
 		return ret;
 	}
-
+#endif
 	return ret;
 }
 module_init(alc5632_modinit);
 
 static void __exit alc5632_modexit(void)
 {
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 	i2c_del_driver(&alc5632_i2c_driver);
+#endif
 }
 module_exit(alc5632_modexit);
 
-- 
1.7.3.4
