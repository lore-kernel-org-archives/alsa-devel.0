From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/3] ASoC: max98095: Remove custom hw_write()
	implementation
Date: Mon, 23 Sep 2013 19:10:11 +0100
Message-ID: <1379959813-22993-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 873152610B3
 for <alsa-devel@alsa-project.org>; Mon, 23 Sep 2013 20:10:34 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Hsiang <peter.hsiang@maxim-ic.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

The registers that are being kept uncached are marked as volatile anyway
so the call has no practical impact.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/max98095.c | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/sound/soc/codecs/max98095.c b/sound/soc/codecs/max98095.c
index 8dbcacd..29c266b 100644
--- a/sound/soc/codecs/max98095.c
+++ b/sound/soc/codecs/max98095.c
@@ -612,23 +612,6 @@ static int max98095_volatile(struct snd_soc_codec *codec, unsigned int reg)
 }
 
 /*
- * Filter coefficients are in a separate register segment
- * and they share the address space of the normal registers.
- * The coefficient registers do not need or share the cache.
- */
-static int max98095_hw_write(struct snd_soc_codec *codec, unsigned int reg,
-			     unsigned int value)
-{
-	int ret;
-
-	codec->cache_bypass = 1;
-	ret = snd_soc_write(codec, reg, value);
-	codec->cache_bypass = 0;
-
-	return ret ? -EIO : 0;
-}
-
-/*
  * Load equalizer DSP coefficient configurations registers
  */
 static void m98095_eq_band(struct snd_soc_codec *codec, unsigned int dai,
@@ -648,8 +631,8 @@ static void m98095_eq_band(struct snd_soc_codec *codec, unsigned int dai,
 
 	/* Step through the registers and coefs */
 	for (i = 0; i < M98095_COEFS_PER_BAND; i++) {
-		max98095_hw_write(codec, eq_reg++, M98095_BYTE1(coefs[i]));
-		max98095_hw_write(codec, eq_reg++, M98095_BYTE0(coefs[i]));
+		snd_soc_write(codec, eq_reg++, M98095_BYTE1(coefs[i]));
+		snd_soc_write(codec, eq_reg++, M98095_BYTE0(coefs[i]));
 	}
 }
 
@@ -673,8 +656,8 @@ static void m98095_biquad_band(struct snd_soc_codec *codec, unsigned int dai,
 
 	/* Step through the registers and coefs */
 	for (i = 0; i < M98095_COEFS_PER_BAND; i++) {
-		max98095_hw_write(codec, bq_reg++, M98095_BYTE1(coefs[i]));
-		max98095_hw_write(codec, bq_reg++, M98095_BYTE0(coefs[i]));
+		snd_soc_write(codec, bq_reg++, M98095_BYTE1(coefs[i]));
+		snd_soc_write(codec, bq_reg++, M98095_BYTE0(coefs[i]));
 	}
 }
 
-- 
1.8.4.rc3
