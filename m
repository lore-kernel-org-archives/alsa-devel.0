From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5677: Remove NULL test for desc
	before gpiod_set_value_cansleep call" to the asoc tree
Date: Thu, 23 Jul 2015 16:47:29 +0100
Message-ID: <E1ZIIiX-0008CN-DI@debutante>
References: <1437665524.20606.8.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F686260711
 for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2015 17:47:35 +0200 (CEST)
In-Reply-To: <1437665524.20606.8.camel@ingics.com>
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

   ASoC: rt5677: Remove NULL test for desc before gpiod_set_value_cansleep call

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

>From f285f1610341af4181791938777e0affb5531278 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 23 Jul 2015 23:32:04 +0800
Subject: [PATCH] ASoC: rt5677: Remove NULL test for desc before
 gpiod_set_value_cansleep call

It's safe to call gpiod_set_value_cansleep() with NULL desc.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5677.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 13b871f11023..62230e05eac1 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -4763,10 +4763,8 @@ static int rt5677_remove(struct snd_soc_codec *codec)
 	struct rt5677_priv *rt5677 = snd_soc_codec_get_drvdata(codec);
 
 	regmap_write(rt5677->regmap, RT5677_RESET, 0x10ec);
-	if (rt5677->pow_ldo2)
-		gpiod_set_value_cansleep(rt5677->pow_ldo2, 0);
-	if (rt5677->reset_pin)
-		gpiod_set_value_cansleep(rt5677->reset_pin, 0);
+	gpiod_set_value_cansleep(rt5677->pow_ldo2, 0);
+	gpiod_set_value_cansleep(rt5677->reset_pin, 0);
 
 	return 0;
 }
@@ -4780,10 +4778,8 @@ static int rt5677_suspend(struct snd_soc_codec *codec)
 		regcache_cache_only(rt5677->regmap, true);
 		regcache_mark_dirty(rt5677->regmap);
 
-		if (rt5677->pow_ldo2)
-			gpiod_set_value_cansleep(rt5677->pow_ldo2, 0);
-		if (rt5677->reset_pin)
-			gpiod_set_value_cansleep(rt5677->reset_pin, 0);
+		gpiod_set_value_cansleep(rt5677->pow_ldo2, 0);
+		gpiod_set_value_cansleep(rt5677->reset_pin, 0);
 	}
 
 	return 0;
@@ -4794,10 +4790,8 @@ static int rt5677_resume(struct snd_soc_codec *codec)
 	struct rt5677_priv *rt5677 = snd_soc_codec_get_drvdata(codec);
 
 	if (!rt5677->dsp_vad_en) {
-		if (rt5677->pow_ldo2)
-			gpiod_set_value_cansleep(rt5677->pow_ldo2, 1);
-		if (rt5677->reset_pin)
-			gpiod_set_value_cansleep(rt5677->reset_pin, 1);
+		gpiod_set_value_cansleep(rt5677->pow_ldo2, 1);
+		gpiod_set_value_cansleep(rt5677->reset_pin, 1);
 		if (rt5677->pow_ldo2 || rt5677->reset_pin)
 			msleep(10);
 
-- 
2.1.4
