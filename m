From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/3] ASoC: ak4642: Convert to
	module_i2c_driver()
Date: Thu, 28 Nov 2013 18:04:46 +0000
Message-ID: <1385661888-11924-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 15E6D265263
 for <alsa-devel@alsa-project.org>; Thu, 28 Nov 2013 19:04:55 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <morimoto.kuninori@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

The device does not support anything other than I2C (at least with the
current driver) so save code.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/ak4642.c | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/sound/soc/codecs/ak4642.c b/sound/soc/codecs/ak4642.c
index 2f861c9b1d69..5bb18e913fa5 100644
--- a/sound/soc/codecs/ak4642.c
+++ b/sound/soc/codecs/ak4642.c
@@ -511,7 +511,6 @@ static struct snd_soc_codec_driver soc_codec_dev_ak4648 = {
 	.num_dapm_routes	= ARRAY_SIZE(ak4642_intercon),
 };
 
-#if IS_ENABLED(CONFIG_I2C)
 static struct of_device_id ak4642_of_match[];
 static int ak4642_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
@@ -571,27 +570,8 @@ static struct i2c_driver ak4642_i2c_driver = {
 	.remove		= ak4642_i2c_remove,
 	.id_table	= ak4642_i2c_id,
 };
-#endif
 
-static int __init ak4642_modinit(void)
-{
-	int ret = 0;
-#if IS_ENABLED(CONFIG_I2C)
-	ret = i2c_add_driver(&ak4642_i2c_driver);
-#endif
-	return ret;
-
-}
-module_init(ak4642_modinit);
-
-static void __exit ak4642_exit(void)
-{
-#if IS_ENABLED(CONFIG_I2C)
-	i2c_del_driver(&ak4642_i2c_driver);
-#endif
-
-}
-module_exit(ak4642_exit);
+module_i2c_driver(ak4642_i2c_driver);
 
 MODULE_DESCRIPTION("Soc AK4642 driver");
 MODULE_AUTHOR("Kuninori Morimoto <morimoto.kuninori@renesas.com>");
-- 
1.8.4.4
