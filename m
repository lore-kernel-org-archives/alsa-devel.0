From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm9081: Remove #if
	IS_ENABLED(CONFIG_I2C)" to the asoc tree
Date: Mon, 21 Nov 2016 19:20:29 +0000
Message-ID: <E1c8u8j-0007tP-9K@debutante>
References: <87y40l8h47.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F1FFF26658E
 for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2016 20:20:36 +0100 (CET)
In-Reply-To: <87y40l8h47.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: wm9081: Remove #if IS_ENABLED(CONFIG_I2C)

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

>From e2d575918bf38d16cacaac789ba05d5e5a649b6f Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 17 Nov 2016 01:13:00 +0000
Subject: [PATCH] ASoC: wm9081: Remove #if IS_ENABLED(CONFIG_I2C)

wm9081 driver doesn't work without CONFIG_I2C anyway.
Let's remove #if IS_ENABLED(CONFIG_I2C)

And, this patch adds "depends on I2C" to Kconfig

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/Kconfig  | 1 +
 sound/soc/codecs/wm9081.c | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index c67667bb970f..5efcd9b2152f 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1048,6 +1048,7 @@ config SND_SOC_WM8998
 
 config SND_SOC_WM9081
 	tristate
+	depends on I2C
 
 config SND_SOC_WM9090
 	tristate
diff --git a/sound/soc/codecs/wm9081.c b/sound/soc/codecs/wm9081.c
index 856867ec2813..6febef337dd2 100644
--- a/sound/soc/codecs/wm9081.c
+++ b/sound/soc/codecs/wm9081.c
@@ -1304,7 +1304,6 @@ static const struct regmap_config wm9081_regmap = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
-#if IS_ENABLED(CONFIG_I2C)
 static int wm9081_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
 {
@@ -1384,7 +1383,6 @@ static struct i2c_driver wm9081_i2c_driver = {
 	.remove =   wm9081_i2c_remove,
 	.id_table = wm9081_i2c_id,
 };
-#endif
 
 module_i2c_driver(wm9081_i2c_driver);
 
-- 
2.10.2
