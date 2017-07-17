From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs42l42: Remove unneeded gpiod NULL
	check" to the asoc tree
Date: Mon, 17 Jul 2017 17:05:52 +0100
Message-ID: <E1dX8Wu-0004vi-PO@debutante>
References: <1500239473-14886-6-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 553AE267400
 for <alsa-devel@alsa-project.org>; Mon, 17 Jul 2017 18:06:00 +0200 (CEST)
In-Reply-To: <1500239473-14886-6-git-send-email-festevam@gmail.com>
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

   ASoC: cs42l42: Remove unneeded gpiod NULL check

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

>From 205cbac065f9589c77a79f26339cf63023f08f6e Mon Sep 17 00:00:00 2001
From: Fabio Estevam <fabio.estevam@nxp.com>
Date: Sun, 16 Jul 2017 18:11:11 -0300
Subject: [PATCH] ASoC: cs42l42: Remove unneeded gpiod NULL check

The gpiod API checks for NULL descriptors, so there is no need to
duplicate the check in the driver.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs42l42.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 55e4520cdcaf..55caf5ff3e64 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -1898,8 +1898,7 @@ static int cs42l42_i2c_remove(struct i2c_client *i2c_client)
 	snd_soc_unregister_codec(&i2c_client->dev);
 
 	/* Hold down reset */
-	if (cs42l42->reset_gpio)
-		gpiod_set_value_cansleep(cs42l42->reset_gpio, 0);
+	gpiod_set_value_cansleep(cs42l42->reset_gpio, 0);
 
 	return 0;
 }
@@ -1913,8 +1912,7 @@ static int cs42l42_runtime_suspend(struct device *dev)
 	regcache_mark_dirty(cs42l42->regmap);
 
 	/* Hold down reset */
-	if (cs42l42->reset_gpio)
-		gpiod_set_value_cansleep(cs42l42->reset_gpio, 0);
+	gpiod_set_value_cansleep(cs42l42->reset_gpio, 0);
 
 	/* remove power */
 	regulator_bulk_disable(ARRAY_SIZE(cs42l42->supplies),
@@ -1937,8 +1935,7 @@ static int cs42l42_runtime_resume(struct device *dev)
 		return ret;
 	}
 
-	if (cs42l42->reset_gpio)
-		gpiod_set_value_cansleep(cs42l42->reset_gpio, 1);
+	gpiod_set_value_cansleep(cs42l42->reset_gpio, 1);
 
 	regcache_cache_only(cs42l42->regmap, false);
 	regcache_sync(cs42l42->regmap);
-- 
2.13.2
