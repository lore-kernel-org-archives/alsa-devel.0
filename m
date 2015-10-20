From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ad193x: Drop .volatile_reg
	implementation" to the asoc tree
Date: Tue, 20 Oct 2015 20:32:25 +0100
Message-ID: <E1Zoce1-0003bE-0Q@debutante>
References: <1445331371.25880.3.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A9C22604C6
 for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2015 21:32:44 +0200 (CEST)
In-Reply-To: <1445331371.25880.3.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ad193x: Drop .volatile_reg implementation

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

>From 92b822a499607c32ce12ffd798a095babedc3202 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Tue, 20 Oct 2015 16:56:11 +0800
Subject: [PATCH] ASoC: ad193x: Drop .volatile_reg implementation

adau193x_reg_volatile() always return false.
This seems pointless because current code uses REGCACHE_NONE cache_type
which is supposed to be volatile.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ad193x.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/soc/codecs/ad193x.c b/sound/soc/codecs/ad193x.c
index 76d7966bd72c..3a3f3f2343d7 100644
--- a/sound/soc/codecs/ad193x.c
+++ b/sound/soc/codecs/ad193x.c
@@ -418,14 +418,8 @@ static struct snd_soc_codec_driver soc_codec_dev_ad193x = {
 	.num_dapm_routes = ARRAY_SIZE(audio_paths),
 };
 
-static bool adau193x_reg_volatile(struct device *dev, unsigned int reg)
-{
-	return false;
-}
-
 const struct regmap_config ad193x_regmap_config = {
 	.max_register = AD193X_NUM_REGS - 1,
-	.volatile_reg = adau193x_reg_volatile,
 };
 EXPORT_SYMBOL_GPL(ad193x_regmap_config);
 
-- 
2.6.1
