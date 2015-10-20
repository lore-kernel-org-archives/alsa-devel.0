From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] ASoC: ssm2518: Drop .volatile_reg
	implementation
Date: Tue, 20 Oct 2015 16:54:46 +0800
Message-ID: <1445331286.25880.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f41.google.com (mail-pa0-f41.google.com
 [209.85.220.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B11E2661B5
 for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2015 10:54:52 +0200 (CEST)
Received: by pabrc13 with SMTP id rc13so15405879pab.0
 for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2015 01:54:51 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The implementation of ssm2518_register_volatile always returns false,
this behavior is the same as no .volatile_reg callback implementation
when cache_type != REGCACHE_NONE.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/ssm2518.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/soc/codecs/ssm2518.c b/sound/soc/codecs/ssm2518.c
index ddb0203..86b81a60 100644
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
2.1.4
