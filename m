From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tas2552: Remove unneeded NULL test for
	tas2552->enable_gpio" to the asoc tree
Date: Wed, 29 Jul 2015 15:13:25 +0100
Message-ID: <E1ZKS6n-0004eQ-Tz@finisterre>
References: <1437809536.5851.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DAAA326592C
 for <alsa-devel@alsa-project.org>; Wed, 29 Jul 2015 16:13:40 +0200 (CEST)
In-Reply-To: <1437809536.5851.1.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Dan Murphy <dmurphy@ti.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tas2552: Remove unneeded NULL test for tas2552->enable_gpio

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

>From 82cf77a1bd61d981184a355742a9b5c78f286f97 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Sat, 25 Jul 2015 15:32:16 +0800
Subject: [PATCH] ASoC: tas2552: Remove unneeded NULL test for
 tas2552->enable_gpio

It's safe to call gpiod_set_value() with NULL desc.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Dan Murphy <dmurphy@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tas2552.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/tas2552.c b/sound/soc/codecs/tas2552.c
index 4f25a7d0..d6ec004 100644
--- a/sound/soc/codecs/tas2552.c
+++ b/sound/soc/codecs/tas2552.c
@@ -493,8 +493,7 @@ static int tas2552_runtime_suspend(struct device *dev)
 	regcache_cache_only(tas2552->regmap, true);
 	regcache_mark_dirty(tas2552->regmap);
 
-	if (tas2552->enable_gpio)
-		gpiod_set_value(tas2552->enable_gpio, 0);
+	gpiod_set_value(tas2552->enable_gpio, 0);
 
 	return 0;
 }
@@ -503,8 +502,7 @@ static int tas2552_runtime_resume(struct device *dev)
 {
 	struct tas2552_data *tas2552 = dev_get_drvdata(dev);
 
-	if (tas2552->enable_gpio)
-		gpiod_set_value(tas2552->enable_gpio, 1);
+	gpiod_set_value(tas2552->enable_gpio, 1);
 
 	tas2552_sw_shutdown(tas2552, 0);
 
@@ -585,8 +583,7 @@ static int tas2552_codec_probe(struct snd_soc_codec *codec)
 		return ret;
 	}
 
-	if (tas2552->enable_gpio)
-		gpiod_set_value(tas2552->enable_gpio, 1);
+	gpiod_set_value(tas2552->enable_gpio, 1);
 
 	ret = pm_runtime_get_sync(codec->dev);
 	if (ret < 0) {
@@ -610,8 +607,7 @@ static int tas2552_codec_probe(struct snd_soc_codec *codec)
 	return 0;
 
 probe_fail:
-	if (tas2552->enable_gpio)
-		gpiod_set_value(tas2552->enable_gpio, 0);
+	gpiod_set_value(tas2552->enable_gpio, 0);
 
 	regulator_bulk_disable(ARRAY_SIZE(tas2552->supplies),
 					tas2552->supplies);
@@ -624,8 +620,7 @@ static int tas2552_codec_remove(struct snd_soc_codec *codec)
 
 	pm_runtime_put(codec->dev);
 
-	if (tas2552->enable_gpio)
-		gpiod_set_value(tas2552->enable_gpio, 0);
+	gpiod_set_value(tas2552->enable_gpio, 0);
 
 	return 0;
 };
-- 
2.1.4
