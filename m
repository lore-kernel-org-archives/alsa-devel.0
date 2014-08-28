From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: cs35l32: Simplify implementation of
 cs35l32_codec_set_sysclk
Date: Thu, 28 Aug 2014 16:27:56 +0800
Message-ID: <1409214476.21395.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
 [209.85.220.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 6888B268DF1
 for <alsa-devel@alsa-project.org>; Thu, 28 Aug 2014 10:28:08 +0200 (CEST)
Received: by mail-pa0-f54.google.com with SMTP id fb1so1631744pad.13
 for <alsa-devel@alsa-project.org>; Thu, 28 Aug 2014 01:28:03 -0700 (PDT)
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
Cc: Brian Austin <brian.austin@cirrus.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org

Use single snd_soc_update_bits() call to update the register bits.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/cs35l32.c | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/sound/soc/codecs/cs35l32.c b/sound/soc/codecs/cs35l32.c
index 9c6b272..380c212 100644
--- a/sound/soc/codecs/cs35l32.c
+++ b/sound/soc/codecs/cs35l32.c
@@ -242,41 +242,27 @@ static struct snd_soc_dai_driver cs35l32_dai[] = {
 static int cs35l32_codec_set_sysclk(struct snd_soc_codec *codec,
 			      int clk_id, int source, unsigned int freq, int dir)
 {
+	unsigned int val;
 
 	switch (freq) {
 	case 6000000:
-		snd_soc_update_bits(codec, CS35L32_CLK_CTL,
-				    CS35L32_MCLK_DIV2_MASK, 0);
-		snd_soc_update_bits(codec, CS35L32_CLK_CTL,
-				    CS35L32_MCLK_RATIO_MASK,
-					CS35L32_MCLK_RATIO);
+		val = CS35L32_MCLK_RATIO;
 		break;
 	case 12000000:
-		snd_soc_update_bits(codec, CS35L32_CLK_CTL,
-				    CS35L32_MCLK_DIV2_MASK,
-					CS35L32_MCLK_DIV2_MASK);
-		snd_soc_update_bits(codec, CS35L32_CLK_CTL,
-				    CS35L32_MCLK_RATIO_MASK,
-					CS35L32_MCLK_RATIO);
+		val = CS35L32_MCLK_DIV2_MASK | CS35L32_MCLK_RATIO;
 		break;
 	case 6144000:
-		snd_soc_update_bits(codec, CS35L32_CLK_CTL,
-				    CS35L32_MCLK_DIV2_MASK, 0);
-		snd_soc_update_bits(codec, CS35L32_CLK_CTL,
-				    CS35L32_MCLK_RATIO_MASK, 0);
+		val = 0;
 		break;
 	case 12288000:
-		snd_soc_update_bits(codec, CS35L32_CLK_CTL,
-				    CS35L32_MCLK_DIV2_MASK,
-					CS35L32_MCLK_DIV2_MASK);
-		snd_soc_update_bits(codec, CS35L32_CLK_CTL,
-				    CS35L32_MCLK_RATIO_MASK, 0);
+		val = CS35L32_MCLK_DIV2_MASK;
 		break;
 	default:
 		return -EINVAL;
 	}
 
-	return 0;
+	return snd_soc_update_bits(codec, CS35L32_CLK_CTL,
+			CS35L32_MCLK_DIV2_MASK | CS35L32_MCLK_RATIO_MASK, val);
 }
 
 static struct snd_soc_codec_driver soc_codec_dev_cs35l32 = {
-- 
1.9.1
