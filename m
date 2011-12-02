From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/6] ASoC: WM8903 only supports I2C so don't
	ifdef it
Date: Fri,  2 Dec 2011 19:28:11 +0000
Message-ID: <1322854095-14437-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20111202192330.GA4333@opensource.wolfsonmicro.com>
	<1322854095-14437-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C10DA24617
	for <alsa-devel@alsa-project.org>; Fri,  2 Dec 2011 20:28:19 +0100 (CET)
In-Reply-To: <1322854095-14437-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Stephen Warren <swarren@nvidia.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8903.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index e2eee02..2cfa2fc 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -2071,7 +2071,6 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8903 = {
 	.num_dapm_routes = ARRAY_SIZE(wm8903_intercon),
 };
 
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 static __devinit int wm8903_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
@@ -2113,27 +2112,22 @@ static struct i2c_driver wm8903_i2c_driver = {
 	.remove =   __devexit_p(wm8903_i2c_remove),
 	.id_table = wm8903_i2c_id,
 };
-#endif
 
 static int __init wm8903_modinit(void)
 {
 	int ret = 0;
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 	ret = i2c_add_driver(&wm8903_i2c_driver);
 	if (ret != 0) {
 		printk(KERN_ERR "Failed to register wm8903 I2C driver: %d\n",
 		       ret);
 	}
-#endif
 	return ret;
 }
 module_init(wm8903_modinit);
 
 static void __exit wm8903_exit(void)
 {
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 	i2c_del_driver(&wm8903_i2c_driver);
-#endif
 }
 module_exit(wm8903_exit);
 
-- 
1.7.7.3
