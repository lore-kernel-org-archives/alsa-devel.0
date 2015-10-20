From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] ASoC: ad193x: Drop .volatile_reg
	implementation
Date: Tue, 20 Oct 2015 16:56:11 +0800
Message-ID: <1445331371.25880.3.camel@ingics.com>
References: <1445331286.25880.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f53.google.com (mail-pa0-f53.google.com
 [209.85.220.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C7CD2661B5
 for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2015 10:56:16 +0200 (CEST)
Received: by pabrc13 with SMTP id rc13so15442513pab.0
 for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2015 01:56:15 -0700 (PDT)
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
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

adau193x_reg_volatile() always return false.
This seems pointless because current code uses REGCACHE_NONE cache_type
which is supposed to be volatile.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/ad193x.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/soc/codecs/ad193x.c b/sound/soc/codecs/ad193x.c
index 76d7966..3a3f3f2 100644
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
2.1.4
