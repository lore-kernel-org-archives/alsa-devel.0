From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: sgtl5000: Convert to module_i2c_driver()
Date: Tue,  3 Apr 2012 22:36:54 +0100
Message-ID: <1333489014-14246-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E627F104339
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Apr 2012 23:42:48 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Zeng Zhaoming <zengzm.kernel@gmail.com>, Wolfram Sang <w.sang@pengutronix.de>, Liam Girdwood <lrg@ti.com>, Fabio Estevam <festevam@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/sgtl5000.c |   12 +-----------
 1 files changed, 1 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 159e3a8..6a7347f 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1451,17 +1451,7 @@ static struct i2c_driver sgtl5000_i2c_driver = {
 	.id_table = sgtl5000_id,
 };
 
-static int __init sgtl5000_modinit(void)
-{
-	return i2c_add_driver(&sgtl5000_i2c_driver);
-}
-module_init(sgtl5000_modinit);
-
-static void __exit sgtl5000_exit(void)
-{
-	i2c_del_driver(&sgtl5000_i2c_driver);
-}
-module_exit(sgtl5000_exit);
+module_i2c_driver(sgtl5000_i2c_driver);
 
 MODULE_DESCRIPTION("Freescale SGTL5000 ALSA SoC Codec Driver");
 MODULE_AUTHOR("Zeng Zhaoming <zengzm.kernel@gmail.com>");
-- 
1.7.9.1
