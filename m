From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: ml26124: Remove duplicate code
Date: Sun, 14 Jun 2015 10:28:01 +0800
Message-ID: <1434248881.10956.2.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f44.google.com (mail-pa0-f44.google.com
 [209.85.220.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 0CE552604C6
 for <alsa-devel@alsa-project.org>; Sun, 14 Jun 2015 04:28:09 +0200 (CEST)
Received: by pacyx8 with SMTP id yx8so43849649pac.2
 for <alsa-devel@alsa-project.org>; Sat, 13 Jun 2015 19:28:08 -0700 (PDT)
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Tomoya MORINAGA <tomoya.rohm@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Current code has duplicate code for 16000, 32000 and 48000 sample rates.
get_srate() returns negative error code for unsupported rate, so we can
remove the duplicate code in the swith cases by calling get_srate() first.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/ml26124.c | 58 +++++++++-------------------------------------
 1 file changed, 11 insertions(+), 47 deletions(-)

diff --git a/sound/soc/codecs/ml26124.c b/sound/soc/codecs/ml26124.c
index 62dda24..b74118e 100644
--- a/sound/soc/codecs/ml26124.c
+++ b/sound/soc/codecs/ml26124.c
@@ -341,6 +341,7 @@ static int ml26124_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_codec *codec = dai->codec;
 	struct ml26124_priv *priv = snd_soc_codec_get_drvdata(codec);
 	int i = get_coeff(priv->mclk, params_rate(hw_params));
+	int srate;
 
 	if (i < 0)
 		return i;
@@ -370,53 +371,16 @@ static int ml26124_hw_params(struct snd_pcm_substream *substream,
 				    BIT(0) | BIT(1), 0);
 	}
 
-	switch (params_rate(hw_params)) {
-	case 16000:
-		snd_soc_update_bits(codec, ML26124_SMPLING_RATE, 0xf,
-				    get_srate(params_rate(hw_params)));
-		snd_soc_update_bits(codec, ML26124_PLLNL, 0xff,
-				    coeff_div[i].pllnl);
-		snd_soc_update_bits(codec, ML26124_PLLNH, 0x1,
-				    coeff_div[i].pllnh);
-		snd_soc_update_bits(codec, ML26124_PLLML, 0xff,
-				    coeff_div[i].pllml);
-		snd_soc_update_bits(codec, ML26124_PLLMH, 0x3f,
-				    coeff_div[i].pllmh);
-		snd_soc_update_bits(codec, ML26124_PLLDIV, 0x1f,
-				    coeff_div[i].plldiv);
-		break;
-	case 32000:
-		snd_soc_update_bits(codec, ML26124_SMPLING_RATE, 0xf,
-				    get_srate(params_rate(hw_params)));
-		snd_soc_update_bits(codec, ML26124_PLLNL, 0xff,
-				    coeff_div[i].pllnl);
-		snd_soc_update_bits(codec, ML26124_PLLNH, 0x1,
-				    coeff_div[i].pllnh);
-		snd_soc_update_bits(codec, ML26124_PLLML, 0xff,
-				    coeff_div[i].pllml);
-		snd_soc_update_bits(codec, ML26124_PLLMH, 0x3f,
-				    coeff_div[i].pllmh);
-		snd_soc_update_bits(codec, ML26124_PLLDIV, 0x1f,
-				    coeff_div[i].plldiv);
-		break;
-	case 48000:
-		snd_soc_update_bits(codec, ML26124_SMPLING_RATE, 0xf,
-				    get_srate(params_rate(hw_params)));
-		snd_soc_update_bits(codec, ML26124_PLLNL, 0xff,
-				    coeff_div[i].pllnl);
-		snd_soc_update_bits(codec, ML26124_PLLNH, 0x1,
-				    coeff_div[i].pllnh);
-		snd_soc_update_bits(codec, ML26124_PLLML, 0xff,
-				    coeff_div[i].pllml);
-		snd_soc_update_bits(codec, ML26124_PLLMH, 0x3f,
-				    coeff_div[i].pllmh);
-		snd_soc_update_bits(codec, ML26124_PLLDIV, 0x1f,
-				    coeff_div[i].plldiv);
-		break;
-	default:
-		pr_err("%s:this rate is no support for ml26124\n", __func__);
-		return -EINVAL;
-	}
+	srate = get_srate(params_rate(hw_params));
+	if (srate < 0)
+		return srate;
+
+	snd_soc_update_bits(codec, ML26124_SMPLING_RATE, 0xf, srate);
+	snd_soc_update_bits(codec, ML26124_PLLNL, 0xff, coeff_div[i].pllnl);
+	snd_soc_update_bits(codec, ML26124_PLLNH, 0x1, coeff_div[i].pllnh);
+	snd_soc_update_bits(codec, ML26124_PLLML, 0xff, coeff_div[i].pllml);
+	snd_soc_update_bits(codec, ML26124_PLLMH, 0x3f, coeff_div[i].pllmh);
+	snd_soc_update_bits(codec, ML26124_PLLDIV, 0x1f, coeff_div[i].plldiv);
 
 	return 0;
 }
-- 
2.1.0
