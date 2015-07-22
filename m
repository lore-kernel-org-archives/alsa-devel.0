From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs4349: Remove unneeded NULL test for
	cs4349->reset_gpio" to the asoc tree
Date: Wed, 22 Jul 2015 10:57:29 +0100
Message-ID: <E1ZHqmH-00077z-MQ@debutante>
References: <1437530387.24723.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 311F12606CA
 for <alsa-devel@alsa-project.org>; Wed, 22 Jul 2015 11:57:39 +0200 (CEST)
In-Reply-To: <1437530387.24723.1.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs4349: Remove unneeded NULL test for cs4349->reset_gpio

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

>From 6a75c0b62b0981c3a34d3336725b0840747e7680 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 22 Jul 2015 09:59:47 +0800
Subject: [PATCH] ASoC: cs4349: Remove unneeded NULL test for
 cs4349->reset_gpio

It's safe to call gpiod_set_value_cansleep() with NULL desc.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs4349.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/cs4349.c b/sound/soc/codecs/cs4349.c
index a7538aea7f99..852be858bb9f 100644
--- a/sound/soc/codecs/cs4349.c
+++ b/sound/soc/codecs/cs4349.c
@@ -300,8 +300,7 @@ static int cs4349_i2c_probe(struct i2c_client *client,
 	if (IS_ERR(cs4349->reset_gpio))
 		return PTR_ERR(cs4349->reset_gpio);
 
-	if (cs4349->reset_gpio)
-		gpiod_set_value_cansleep(cs4349->reset_gpio, 1);
+	gpiod_set_value_cansleep(cs4349->reset_gpio, 1);
 
 	i2c_set_clientdata(client, cs4349);
 
@@ -316,8 +315,7 @@ static int cs4349_i2c_remove(struct i2c_client *client)
 	snd_soc_unregister_codec(&client->dev);
 
 	/* Hold down reset */
-	if (cs4349->reset_gpio)
-		gpiod_set_value_cansleep(cs4349->reset_gpio, 0);
+	gpiod_set_value_cansleep(cs4349->reset_gpio, 0);
 
 	return 0;
 }
@@ -335,8 +333,7 @@ static int cs4349_runtime_suspend(struct device *dev)
 	regcache_cache_only(cs4349->regmap, true);
 
 	/* Hold down reset */
-	if (cs4349->reset_gpio)
-		gpiod_set_value_cansleep(cs4349->reset_gpio, 0);
+	gpiod_set_value_cansleep(cs4349->reset_gpio, 0);
 
 	return 0;
 }
@@ -350,8 +347,7 @@ static int cs4349_runtime_resume(struct device *dev)
 	if (ret < 0)
 		return ret;
 
-	if (cs4349->reset_gpio)
-		gpiod_set_value_cansleep(cs4349->reset_gpio, 1);
+	gpiod_set_value_cansleep(cs4349->reset_gpio, 1);
 
 	regcache_cache_only(cs4349->regmap, false);
 	regcache_sync(cs4349->regmap);
-- 
2.1.4
