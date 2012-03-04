From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: ak4641: Convert to
	module_i2c_driver()
Date: Sun,  4 Mar 2012 21:31:05 +0000
Message-ID: <1330896666-21877-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D7A5A24376
	for <alsa-devel@alsa-project.org>; Sun,  4 Mar 2012 22:31:14 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Harald Welte <laforge@gnumonks.org>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/ak4641.c |   18 +-----------------
 1 files changed, 1 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/ak4641.c b/sound/soc/codecs/ak4641.c
index c4d165a..611e8f0 100644
--- a/sound/soc/codecs/ak4641.c
+++ b/sound/soc/codecs/ak4641.c
@@ -641,23 +641,7 @@ static struct i2c_driver ak4641_i2c_driver = {
 	.id_table = ak4641_i2c_id,
 };
 
-static int __init ak4641_modinit(void)
-{
-	int ret;
-
-	ret = i2c_add_driver(&ak4641_i2c_driver);
-	if (ret != 0)
-		pr_err("Failed to register AK4641 I2C driver: %d\n", ret);
-
-	return ret;
-}
-module_init(ak4641_modinit);
-
-static void __exit ak4641_exit(void)
-{
-	i2c_del_driver(&ak4641_i2c_driver);
-}
-module_exit(ak4641_exit);
+module_i2c_driver(ak4641_i2c_driver);
 
 MODULE_DESCRIPTION("SoC AK4641 driver");
 MODULE_AUTHOR("Harald Welte <laforge@gnufiish.org>");
-- 
1.7.9.1
