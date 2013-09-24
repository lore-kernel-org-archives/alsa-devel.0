From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/3] ASoC: tlv320aic23: Remove #defines for I2C
Date: Tue, 24 Sep 2013 19:27:16 +0100
Message-ID: <1380047238-16909-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B1F0261A2C
 for <alsa-devel@alsa-project.org>; Tue, 24 Sep 2013 20:27:22 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

The only control interface supported by this driver is I2C so there is no
need for conditional compilation around the control interface.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/tlv320aic23.c | 25 +------------------------
 1 file changed, 1 insertion(+), 24 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic23.c b/sound/soc/codecs/tlv320aic23.c
index 31762eb..3299459 100644
--- a/sound/soc/codecs/tlv320aic23.c
+++ b/sound/soc/codecs/tlv320aic23.c
@@ -613,7 +613,6 @@ static struct snd_soc_codec_driver soc_codec_dev_tlv320aic23 = {
 	.num_dapm_routes = ARRAY_SIZE(tlv320aic23_intercon),
 };
 
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 /*
  * If the i2c layer weren't so broken, we could pass this kind of data
  * around
@@ -660,29 +659,7 @@ static struct i2c_driver tlv320aic23_i2c_driver = {
 	.id_table = tlv320aic23_id,
 };
 
-#endif
-
-static int __init tlv320aic23_modinit(void)
-{
-	int ret;
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-	ret = i2c_add_driver(&tlv320aic23_i2c_driver);
-	if (ret != 0) {
-		printk(KERN_ERR "Failed to register TLV320AIC23 I2C driver: %d\n",
-		       ret);
-	}
-#endif
-	return ret;
-}
-module_init(tlv320aic23_modinit);
-
-static void __exit tlv320aic23_exit(void)
-{
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-	i2c_del_driver(&tlv320aic23_i2c_driver);
-#endif
-}
-module_exit(tlv320aic23_exit);
+module_i2c_driver(tlv320aic23_i2c_driver);
 
 MODULE_DESCRIPTION("ASoC TLV320AIC23 codec driver");
 MODULE_AUTHOR("Arun KS <arunks@mistralsolutions.com>");
-- 
1.8.4.rc3
