From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: uda1380: Remove #if
	IS_ENABLED(CONFIG_I2C)" to the asoc tree
Date: Mon, 21 Nov 2016 19:20:32 +0000
Message-ID: <E1c8u8m-0007uS-84@debutante>
References: <87zil18h4p.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B652266656
 for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2016 20:20:38 +0100 (CET)
In-Reply-To: <87zil18h4p.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: uda1380: Remove #if IS_ENABLED(CONFIG_I2C)

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

>From 4a5cf1320a9501261919cf96af300b1df3ad0210 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 17 Nov 2016 01:12:30 +0000
Subject: [PATCH] ASoC: uda1380: Remove #if IS_ENABLED(CONFIG_I2C)

uda1380 driver doesn't work without CONFIG_I2C anyway.
Let's remove #if IS_ENABLED(CONFIG_I2C), and use module_i2c_driver().

And, this patch adds "depends on I2C" to Kconfig

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/Kconfig   |  1 +
 sound/soc/codecs/uda1380.c | 22 +---------------------
 2 files changed, 2 insertions(+), 21 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index c67667bb970f..98b9a0c35d6b 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -874,6 +874,7 @@ config SND_SOC_UDA134X
 
 config SND_SOC_UDA1380
         tristate
+	depends on I2C
 
 config SND_SOC_WL1273
 	tristate
diff --git a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
index 533e3bb444e4..8e52439a58fd 100644
--- a/sound/soc/codecs/uda1380.c
+++ b/sound/soc/codecs/uda1380.c
@@ -775,7 +775,6 @@ static struct snd_soc_codec_driver soc_codec_dev_uda1380 = {
 	},
 };
 
-#if IS_ENABLED(CONFIG_I2C)
 static int uda1380_i2c_probe(struct i2c_client *i2c,
 			     const struct i2c_device_id *id)
 {
@@ -815,27 +814,8 @@ static struct i2c_driver uda1380_i2c_driver = {
 	.remove =   uda1380_i2c_remove,
 	.id_table = uda1380_i2c_id,
 };
-#endif
 
-static int __init uda1380_modinit(void)
-{
-	int ret = 0;
-#if IS_ENABLED(CONFIG_I2C)
-	ret = i2c_add_driver(&uda1380_i2c_driver);
-	if (ret != 0)
-		pr_err("Failed to register UDA1380 I2C driver: %d\n", ret);
-#endif
-	return ret;
-}
-module_init(uda1380_modinit);
-
-static void __exit uda1380_exit(void)
-{
-#if IS_ENABLED(CONFIG_I2C)
-	i2c_del_driver(&uda1380_i2c_driver);
-#endif
-}
-module_exit(uda1380_exit);
+module_i2c_driver(uda1380_i2c_driver);
 
 MODULE_AUTHOR("Giorgio Padrin");
 MODULE_DESCRIPTION("Audio support for codec Philips UDA1380");
-- 
2.10.2
