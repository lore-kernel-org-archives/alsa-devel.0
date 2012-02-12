From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm9081: Use module_i2c_driver
Date: Sun, 12 Feb 2012 18:46:20 +0000
Message-ID: <1329072380-23925-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CA18324344
	for <alsa-devel@alsa-project.org>; Mon, 13 Feb 2012 17:07:13 +0100 (CET)
Received: from finisterre.wolfsonmicro.main (unknown [108.60.121.130])
	by opensource.wolfsonmicro.com (Postfix) with ESMTPSA id 9D0B0110565
	for <alsa-devel@alsa-project.org>; Mon, 13 Feb 2012 16:07:11 +0000 (GMT)
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

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm9081.c |   23 +----------------------
 1 files changed, 1 insertions(+), 22 deletions(-)

diff --git a/sound/soc/codecs/wm9081.c b/sound/soc/codecs/wm9081.c
index 13bfcbd..076c126 100644
--- a/sound/soc/codecs/wm9081.c
+++ b/sound/soc/codecs/wm9081.c
@@ -1418,28 +1418,7 @@ static struct i2c_driver wm9081_i2c_driver = {
 };
 #endif
 
-static int __init wm9081_modinit(void)
-{
-	int ret = 0;
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-	ret = i2c_add_driver(&wm9081_i2c_driver);
-	if (ret != 0) {
-		printk(KERN_ERR "Failed to register WM9081 I2C driver: %d\n",
-		       ret);
-	}
-#endif
-	return ret;
-}
-module_init(wm9081_modinit);
-
-static void __exit wm9081_exit(void)
-{
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-	i2c_del_driver(&wm9081_i2c_driver);
-#endif
-}
-module_exit(wm9081_exit);
-
+module_i2c_driver(wm9081_i2c_driver);
 
 MODULE_DESCRIPTION("ASoC WM9081 driver");
 MODULE_AUTHOR("Mark Brown <broonie@opensource.wolfsonmicro.com>");
-- 
1.7.9.rc1
