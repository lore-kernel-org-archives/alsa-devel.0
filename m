From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] ASoC: tas5086: use module_i2c_driver to simplify the code
Date: Tue, 12 Mar 2013 21:36:24 +0800
Message-ID: <CAPgLHd_J+xdx6UdSFahEGmPJX-SXEkQBL7xHA7MEGKf21=32Uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@opensource.wolfsonmicro.com, perex@perex.cz, tiwai@suse.de, grant.likely@secretlab.ca, rob.herring@calxeda.com, zonque@gmail.com
Cc: yongjun_wei@trendmicro.com.cn, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Use the module_i2c_driver() macro to make the code smaller
and a bit simpler.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 sound/soc/codecs/tas5086.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/sound/soc/codecs/tas5086.c b/sound/soc/codecs/tas5086.c
index 008bea4..40cee84 100644
--- a/sound/soc/codecs/tas5086.c
+++ b/sound/soc/codecs/tas5086.c
@@ -584,17 +584,7 @@ static struct i2c_driver tas5086_i2c_driver = {
 	.remove		= tas5086_i2c_remove,
 };
 
-static int __init tas5086_modinit(void)
-{
-	return i2c_add_driver(&tas5086_i2c_driver);
-}
-module_init(tas5086_modinit);
-
-static void __exit tas5086_modexit(void)
-{
-	i2c_del_driver(&tas5086_i2c_driver);
-}
-module_exit(tas5086_modexit);
+module_i2c_driver(tas5086_i2c_driver);
 
 MODULE_AUTHOR("Daniel Mack <zonque@gmail.com>");
 MODULE_DESCRIPTION("Texas Instruments TAS5086 ALSA SoC Codec Driver");
