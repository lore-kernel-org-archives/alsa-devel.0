From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs35l32: Remove unneeded NULL test for
	cs35l32->reset_gpio" to the asoc tree
Date: Thu, 23 Jul 2015 16:04:29 +0100
Message-ID: <E1ZII2v-0006jb-25@debutante>
References: <1437611397.6620.5.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C02D12606F9
 for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2015 17:04:39 +0200 (CEST)
In-Reply-To: <1437611397.6620.5.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Brian Austin <brian.austin@cirrus.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs35l32: Remove unneeded NULL test for cs35l32->reset_gpio

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

>From d5a78c8ea050e9c81db1e25a4916d8d9168dfb2e Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 23 Jul 2015 08:29:57 +0800
Subject: [PATCH] ASoC: cs35l32: Remove unneeded NULL test for
 cs35l32->reset_gpio

It's safe to call gpiod_set_value_cansleep() with NULL desc.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Brian Austin <brian.austin@cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs35l32.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/cs35l32.c b/sound/soc/codecs/cs35l32.c
index 8f40025b7e7c..f5f86b204521 100644
--- a/sound/soc/codecs/cs35l32.c
+++ b/sound/soc/codecs/cs35l32.c
@@ -441,8 +441,7 @@ static int cs35l32_i2c_probe(struct i2c_client *i2c_client,
 	if (IS_ERR(cs35l32->reset_gpio))
 		return PTR_ERR(cs35l32->reset_gpio);
 
-	if (cs35l32->reset_gpio)
-		gpiod_set_value_cansleep(cs35l32->reset_gpio, 1);
+	gpiod_set_value_cansleep(cs35l32->reset_gpio, 1);
 
 	/* initialize codec */
 	ret = regmap_read(cs35l32->regmap, CS35L32_DEVID_AB, &reg);
@@ -536,8 +535,7 @@ static int cs35l32_i2c_remove(struct i2c_client *i2c_client)
 	snd_soc_unregister_codec(&i2c_client->dev);
 
 	/* Hold down reset */
-	if (cs35l32->reset_gpio)
-		gpiod_set_value_cansleep(cs35l32->reset_gpio, 0);
+	gpiod_set_value_cansleep(cs35l32->reset_gpio, 0);
 
 	return 0;
 }
@@ -551,8 +549,7 @@ static int cs35l32_runtime_suspend(struct device *dev)
 	regcache_mark_dirty(cs35l32->regmap);
 
 	/* Hold down reset */
-	if (cs35l32->reset_gpio)
-		gpiod_set_value_cansleep(cs35l32->reset_gpio, 0);
+	gpiod_set_value_cansleep(cs35l32->reset_gpio, 0);
 
 	/* remove power */
 	regulator_bulk_disable(ARRAY_SIZE(cs35l32->supplies),
@@ -575,8 +572,7 @@ static int cs35l32_runtime_resume(struct device *dev)
 		return ret;
 	}
 
-	if (cs35l32->reset_gpio)
-		gpiod_set_value_cansleep(cs35l32->reset_gpio, 1);
+	gpiod_set_value_cansleep(cs35l32->reset_gpio, 1);
 
 	regcache_cache_only(cs35l32->regmap, false);
 	regcache_sync(cs35l32->regmap);
-- 
2.1.4
