From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/3] ASoC: wm8962: Convert to
	module_i2c_driver()
Date: Thu, 16 Feb 2012 22:46:45 -0800
Message-ID: <1329461207-31969-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0D479103A5A
	for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2012 07:47:26 +0100 (CET)
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
 sound/soc/codecs/wm8962.c |   12 +-----------
 1 files changed, 1 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 2f06886..bc04b49 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3793,17 +3793,7 @@ static struct i2c_driver wm8962_i2c_driver = {
 	.id_table = wm8962_i2c_id,
 };
 
-static int __init wm8962_modinit(void)
-{
-	return i2c_add_driver(&wm8962_i2c_driver);
-}
-module_init(wm8962_modinit);
-
-static void __exit wm8962_exit(void)
-{
-	i2c_del_driver(&wm8962_i2c_driver);
-}
-module_exit(wm8962_exit);
+module_i2c_driver(wm8962_i2c_driver);
 
 MODULE_DESCRIPTION("ASoC WM8962 driver");
 MODULE_AUTHOR("Mark Brown <broonie@opensource.wolfsonmicro.com>");
-- 
1.7.9.rc1
