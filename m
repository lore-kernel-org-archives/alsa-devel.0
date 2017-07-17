From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs53l30: Remove unneeded gpiod NULL
	check" to the asoc tree
Date: Mon, 17 Jul 2017 17:05:49 +0100
Message-ID: <E1dX8Wr-0004un-OI@debutante>
References: <1500239473-14886-7-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4679C26740B
 for <alsa-devel@alsa-project.org>; Mon, 17 Jul 2017 18:05:57 +0200 (CEST)
In-Reply-To: <1500239473-14886-7-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@nxp.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs53l30: Remove unneeded gpiod NULL check

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

>From 55be663dc71ec50f0e383c50886cbd3be69fcd2e Mon Sep 17 00:00:00 2001
From: Fabio Estevam <fabio.estevam@nxp.com>
Date: Sun, 16 Jul 2017 18:11:12 -0300
Subject: [PATCH] ASoC: cs53l30: Remove unneeded gpiod NULL check

The gpiod API checks for NULL descriptors, so there is no need to
duplicate the check in the driver.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs53l30.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/cs53l30.c b/sound/soc/codecs/cs53l30.c
index 06933a5d0a75..92fbe6303dd4 100644
--- a/sound/soc/codecs/cs53l30.c
+++ b/sound/soc/codecs/cs53l30.c
@@ -842,8 +842,7 @@ static int cs53l30_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
 {
 	struct cs53l30_private *priv = snd_soc_codec_get_drvdata(dai->codec);
 
-	if (priv->mute_gpio)
-		gpiod_set_value_cansleep(priv->mute_gpio, mute);
+	gpiod_set_value_cansleep(priv->mute_gpio, mute);
 
 	return 0;
 }
@@ -960,8 +959,7 @@ static int cs53l30_i2c_probe(struct i2c_client *client,
 		goto error;
 	}
 
-	if (cs53l30->reset_gpio)
-		gpiod_set_value_cansleep(cs53l30->reset_gpio, 1);
+	gpiod_set_value_cansleep(cs53l30->reset_gpio, 1);
 
 	i2c_set_clientdata(client, cs53l30);
 
@@ -1056,8 +1054,7 @@ static int cs53l30_i2c_remove(struct i2c_client *client)
 	snd_soc_unregister_codec(&client->dev);
 
 	/* Hold down reset */
-	if (cs53l30->reset_gpio)
-		gpiod_set_value_cansleep(cs53l30->reset_gpio, 0);
+	gpiod_set_value_cansleep(cs53l30->reset_gpio, 0);
 
 	regulator_bulk_disable(ARRAY_SIZE(cs53l30->supplies),
 			       cs53l30->supplies);
@@ -1073,8 +1070,7 @@ static int cs53l30_runtime_suspend(struct device *dev)
 	regcache_cache_only(cs53l30->regmap, true);
 
 	/* Hold down reset */
-	if (cs53l30->reset_gpio)
-		gpiod_set_value_cansleep(cs53l30->reset_gpio, 0);
+	gpiod_set_value_cansleep(cs53l30->reset_gpio, 0);
 
 	regulator_bulk_disable(ARRAY_SIZE(cs53l30->supplies),
 			       cs53l30->supplies);
@@ -1094,8 +1090,7 @@ static int cs53l30_runtime_resume(struct device *dev)
 		return ret;
 	}
 
-	if (cs53l30->reset_gpio)
-		gpiod_set_value_cansleep(cs53l30->reset_gpio, 1);
+	gpiod_set_value_cansleep(cs53l30->reset_gpio, 1);
 
 	regcache_cache_only(cs53l30->regmap, false);
 	ret = regcache_sync(cs53l30->regmap);
-- 
2.13.2
