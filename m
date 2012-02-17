From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/3] ASoC: wm8993: Convert to
	module_i2c_driver()
Date: Thu, 16 Feb 2012 22:46:46 -0800
Message-ID: <1329461207-31969-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1329461207-31969-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 135B3103A62
	for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2012 07:47:26 +0100 (CET)
In-Reply-To: <1329461207-31969-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
 sound/soc/codecs/wm8993.c |   19 +------------------
 1 files changed, 1 insertions(+), 18 deletions(-)

diff --git a/sound/soc/codecs/wm8993.c b/sound/soc/codecs/wm8993.c
index 1e69f63..d256a93 100644
--- a/sound/soc/codecs/wm8993.c
+++ b/sound/soc/codecs/wm8993.c
@@ -1859,24 +1859,7 @@ static struct i2c_driver wm8993_i2c_driver = {
 	.id_table = wm8993_i2c_id,
 };
 
-static int __init wm8993_modinit(void)
-{
-	int ret = 0;
-	ret = i2c_add_driver(&wm8993_i2c_driver);
-	if (ret != 0) {
-		pr_err("WM8993: Unable to register I2C driver: %d\n",
-		       ret);
-	}
-	return ret;
-}
-module_init(wm8993_modinit);
-
-static void __exit wm8993_exit(void)
-{
-	i2c_del_driver(&wm8993_i2c_driver);
-}
-module_exit(wm8993_exit);
-
+module_i2c_driver(wm8993_i2c_driver);
 
 MODULE_DESCRIPTION("ASoC WM8993 driver");
 MODULE_AUTHOR("Mark Brown <broonie@opensource.wolfsonmicro.com>");
-- 
1.7.9.rc1
