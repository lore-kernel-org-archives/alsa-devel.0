From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: tlv320aic3x: Remove even more unused code
Date: Mon,  6 Feb 2012 19:23:13 +0000
Message-ID: <1328556193-24593-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CB508243DA
	for <alsa-devel@alsa-project.org>; Mon,  6 Feb 2012 20:23:16 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Felipe Contreras <felipe.contreras@gmail.com>, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Now that we're not implement GPIO or microphone support there's no users
for the read() function any more.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/tlv320aic3x.c |   24 ------------------------
 1 files changed, 0 insertions(+), 24 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 07efbed..8d20f6e 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -121,30 +121,6 @@ static const u8 aic3x_reg[AIC3X_CACHEREGNUM] = {
 	0x00, 0x00, 0x02,	/* 100 */
 };
 
-/*
- * read from the aic3x register space. Only use for this function is if
- * wanting to read volatile bits from those registers that has both read-only
- * and read/write bits. All other cases should use snd_soc_read.
- */
-static int aic3x_read(struct snd_soc_codec *codec, unsigned int reg,
-		      u8 *value)
-{
-	u8 *cache = codec->reg_cache;
-
-	if (codec->cache_only)
-		return -EINVAL;
-	if (reg >= AIC3X_CACHEREGNUM)
-		return -1;
-
-	codec->cache_bypass = 1;
-	*value = snd_soc_read(codec, reg);
-	codec->cache_bypass = 0;
-
-	cache[reg] = *value;
-
-	return 0;
-}
-
 #define SOC_DAPM_SINGLE_AIC3X(xname, reg, shift, mask, invert) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
 	.info = snd_soc_info_volsw, \
-- 
1.7.9.rc1
