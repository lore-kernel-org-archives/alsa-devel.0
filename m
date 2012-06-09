From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: wm8904: Convert to
	module_i2c_driver()
Date: Sat,  9 Jun 2012 12:20:08 +0800
Message-ID: <1339215609-14435-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id D5B0B103EDF
	for <alsa-devel@alsa-project.org>;
	Sat,  9 Jun 2012 06:20:21 +0200 (CEST)
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
 sound/soc/codecs/wm8904.c |   18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index db94d10..02bc2ca 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -2313,23 +2313,7 @@ static struct i2c_driver wm8904_i2c_driver = {
 	.id_table = wm8904_i2c_id,
 };
 
-static int __init wm8904_modinit(void)
-{
-	int ret = 0;
-	ret = i2c_add_driver(&wm8904_i2c_driver);
-	if (ret != 0) {
-		printk(KERN_ERR "Failed to register wm8904 I2C driver: %d\n",
-		       ret);
-	}
-	return ret;
-}
-module_init(wm8904_modinit);
-
-static void __exit wm8904_exit(void)
-{
-	i2c_del_driver(&wm8904_i2c_driver);
-}
-module_exit(wm8904_exit);
+module_i2c_driver(wm8904_i2c_driver);
 
 MODULE_DESCRIPTION("ASoC WM8904 driver");
 MODULE_AUTHOR("Mark Brown <broonie@opensource.wolfsonmicro.com>");
-- 
1.7.10
