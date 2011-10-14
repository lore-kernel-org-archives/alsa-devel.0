From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: max98095: Convert codec->hw_write to
	snd_soc_write
Date: Fri, 14 Oct 2011 11:43:18 +0800
Message-ID: <1318563798.9296.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id B5DCC243C7
	for <alsa-devel@alsa-project.org>;
	Fri, 14 Oct 2011 05:43:28 +0200 (CEST)
Received: by gyg8 with SMTP id 8so758862gyg.38
	for <alsa-devel@alsa-project.org>; Thu, 13 Oct 2011 20:43:28 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: Peter Hsiang <peter.hsiang@maxim-ic.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

codec->hw_write is broken now, convert codec->hw_write to snd_soc_write.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
Hi,
  I don't have this hardware, I'd appreciate if someone can test this patch.

Thanks,
Axel

 sound/soc/codecs/max98095.c |   26 ++++----------------------
 1 files changed, 4 insertions(+), 22 deletions(-)

diff --git a/sound/soc/codecs/max98095.c b/sound/soc/codecs/max98095.c
index 6982f74..85f9379 100644
--- a/sound/soc/codecs/max98095.c
+++ b/sound/soc/codecs/max98095.c
@@ -610,24 +610,6 @@ static int max98095_volatile(struct snd_soc_codec *codec, unsigned int reg)
 }
 
 /*
- * Filter coefficients are in a separate register segment
- * and they share the address space of the normal registers.
- * The coefficient registers do not need or share the cache.
- */
-static int max98095_hw_write(struct snd_soc_codec *codec, unsigned int reg,
-			     unsigned int value)
-{
-	u8 data[2];
-
-	data[0] = reg;
-	data[1] = value;
-	if (codec->hw_write(codec->control_data, data, 2) == 2)
-		return 0;
-	else
-		return -EIO;
-}
-
-/*
  * Load equalizer DSP coefficient configurations registers
  */
 static void m98095_eq_band(struct snd_soc_codec *codec, unsigned int dai,
@@ -647,8 +629,8 @@ static void m98095_eq_band(struct snd_soc_codec *codec, unsigned int dai,
 
 	/* Step through the registers and coefs */
 	for (i = 0; i < M98095_COEFS_PER_BAND; i++) {
-		max98095_hw_write(codec, eq_reg++, M98095_BYTE1(coefs[i]));
-		max98095_hw_write(codec, eq_reg++, M98095_BYTE0(coefs[i]));
+		snd_soc_write(codec, eq_reg++, M98095_BYTE1(coefs[i]));
+		snd_soc_write(codec, eq_reg++, M98095_BYTE0(coefs[i]));
 	}
 }
 
@@ -672,8 +654,8 @@ static void m98095_biquad_band(struct snd_soc_codec *codec, unsigned int dai,
 
 	/* Step through the registers and coefs */
 	for (i = 0; i < M98095_COEFS_PER_BAND; i++) {
-		max98095_hw_write(codec, bq_reg++, M98095_BYTE1(coefs[i]));
-		max98095_hw_write(codec, bq_reg++, M98095_BYTE0(coefs[i]));
+		snd_soc_write(codec, bq_reg++, M98095_BYTE1(coefs[i]));
+		snd_soc_write(codec, bq_reg++, M98095_BYTE0(coefs[i]));
 	}
 }
 
-- 
1.7.4.1
