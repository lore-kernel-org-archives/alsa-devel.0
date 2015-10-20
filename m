From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ssm2518: Drop .volatile_reg
	implementation" to the asoc tree
Date: Tue, 20 Oct 2015 20:32:24 +0100
Message-ID: <E1Zoce0-0003al-39@debutante>
References: <1445331286.25880.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 834062604D5
 for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2015 21:32:44 +0200 (CEST)
In-Reply-To: <1445331286.25880.1.camel@ingics.com>
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

   ASoC: ssm2518: Drop .volatile_reg implementation

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

>From ce7b8dbdded8552d1fd25cc9289da361c5cc765e Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Tue, 20 Oct 2015 16:54:46 +0800
Subject: [PATCH] ASoC: ssm2518: Drop .volatile_reg implementation

The implementation of ssm2518_register_volatile always returns false,
this behavior is the same as no .volatile_reg callback implementation
when cache_type != REGCACHE_NONE.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ssm2518.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/soc/codecs/ssm2518.c b/sound/soc/codecs/ssm2518.c
index ddb0203fc649..86b81a60ac52 100644
--- a/sound/soc/codecs/ssm2518.c
+++ b/sound/soc/codecs/ssm2518.c
@@ -723,17 +723,11 @@ static struct snd_soc_codec_driver ssm2518_codec_driver = {
 	.num_dapm_routes = ARRAY_SIZE(ssm2518_routes),
 };
 
-static bool ssm2518_register_volatile(struct device *dev, unsigned int reg)
-{
-	return false;
-}
-
 static const struct regmap_config ssm2518_regmap_config = {
 	.val_bits = 8,
 	.reg_bits = 8,
 
 	.max_register = SSM2518_REG_DRC_9,
-	.volatile_reg = ssm2518_register_volatile,
 
 	.cache_type = REGCACHE_RBTREE,
 	.reg_defaults = ssm2518_reg_defaults,
-- 
2.6.1
