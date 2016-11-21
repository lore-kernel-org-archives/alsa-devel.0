From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8523: Remove #if
	IS_ENABLED(CONFIG_I2C)" to the asoc tree
Date: Mon, 21 Nov 2016 19:20:23 +0000
Message-ID: <E1c8u8d-0007rS-7y@debutante>
References: <87vavp8h36.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CADF8266552
 for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2016 20:20:35 +0100 (CET)
In-Reply-To: <87vavp8h36.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm8523: Remove #if IS_ENABLED(CONFIG_I2C)

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From f196e9ac07ed1212ce7d106c07a25019c9c1ee18 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 17 Nov 2016 01:13:35 +0000
Subject: [PATCH] ASoC: wm8523: Remove #if IS_ENABLED(CONFIG_I2C)

wm8523 driver doesn't work without CONFIG_I2C anyway.
Let's remove #if IS_ENABLED(CONFIG_I2C), and use module_i2c_driver().

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8523.c | 24 +-----------------------
 1 file changed, 1 insertion(+), 23 deletions(-)

diff --git a/sound/soc/codecs/wm8523.c b/sound/soc/codecs/wm8523.c
index deb2e075428e..6d0a2723bfde 100644
--- a/sound/soc/codecs/wm8523.c
+++ b/sound/soc/codecs/wm8523.c
@@ -446,7 +446,6 @@ static const struct regmap_config wm8523_regmap = {
 	.volatile_reg = wm8523_volatile_register,
 };
 
-#if IS_ENABLED(CONFIG_I2C)
 static int wm8523_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
 {
@@ -543,29 +542,8 @@ static struct i2c_driver wm8523_i2c_driver = {
 	.remove =   wm8523_i2c_remove,
 	.id_table = wm8523_i2c_id,
 };
-#endif
 
-static int __init wm8523_modinit(void)
-{
-	int ret;
-#if IS_ENABLED(CONFIG_I2C)
-	ret = i2c_add_driver(&wm8523_i2c_driver);
-	if (ret != 0) {
-		printk(KERN_ERR "Failed to register WM8523 I2C driver: %d\n",
-		       ret);
-	}
-#endif
-	return 0;
-}
-module_init(wm8523_modinit);
-
-static void __exit wm8523_exit(void)
-{
-#if IS_ENABLED(CONFIG_I2C)
-	i2c_del_driver(&wm8523_i2c_driver);
-#endif
-}
-module_exit(wm8523_exit);
+module_i2c_driver(wm8523_i2c_driver);
 
 MODULE_DESCRIPTION("ASoC WM8523 driver");
 MODULE_AUTHOR("Mark Brown <broonie@opensource.wolfsonmicro.com>");
-- 
2.10.2
