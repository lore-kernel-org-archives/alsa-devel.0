From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: rt5631: Convert to
	module_i2c_driver()
Date: Tue,  8 May 2012 15:53:32 +0100
Message-ID: <1336488813-19613-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0CF1910440B
	for <alsa-devel@alsa-project.org>;
	Tue,  8 May 2012 16:53:37 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Daniel Drake <dsd@laptop.org>, Johnny Hsu <johnnyhsu@realtek.com>, flove@realtek.com
Cc: devel@lists.laptop.org, alsa-devel@alsa-project.org, Chris Ball <cjb@laptop.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/rt5631.c |   12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/sound/soc/codecs/rt5631.c b/sound/soc/codecs/rt5631.c
index 95147e4..a64f2a7 100644
--- a/sound/soc/codecs/rt5631.c
+++ b/sound/soc/codecs/rt5631.c
@@ -1751,17 +1751,7 @@ static struct i2c_driver rt5631_i2c_driver = {
 	.id_table = rt5631_i2c_id,
 };
 
-static int __init rt5631_modinit(void)
-{
-	return i2c_add_driver(&rt5631_i2c_driver);
-}
-module_init(rt5631_modinit);
-
-static void __exit rt5631_modexit(void)
-{
-	i2c_del_driver(&rt5631_i2c_driver);
-}
-module_exit(rt5631_modexit);
+module_i2c_driver(rt5631_i2c_driver);
 
 MODULE_DESCRIPTION("ASoC RT5631 driver");
 MODULE_AUTHOR("flove <flove@realtek.com>");
-- 
1.7.10
