From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH 6/7] ASoC: max9867: Fix BSEL value in master
	mode.
Date: Tue, 30 Jan 2018 12:10:33 +0100
Message-ID: <20180130111033.GG18123@lenoch>
References: <20180130110604.GA18123@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cvs.linux-mips.org (eddie.linux-mips.org [148.251.95.138])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E21F2675B6
 for <alsa-devel@alsa-project.org>; Tue, 30 Jan 2018 12:10:40 +0100 (CET)
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
 (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
 id S23994711AbeA3LKknen80 (ORCPT
 <rfc822;alsa-devel@alsa-project.org>);
 Tue, 30 Jan 2018 12:10:40 +0100
Content-Disposition: inline
In-Reply-To: <20180130110604.GA18123@lenoch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, anish kumar <yesanishhere@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 Note: It should be reconsidered where BSEL should be set.

 sound/soc/codecs/max9867.c | 43 +++----------------------------------------
 1 file changed, 3 insertions(+), 40 deletions(-)

diff --git a/sound/soc/codecs/max9867.c b/sound/soc/codecs/max9867.c
index 026b7cf94910..6272cf5df4a9 100644
--- a/sound/soc/codecs/max9867.c
+++ b/sound/soc/codecs/max9867.c
@@ -148,46 +148,6 @@ static int max9867_dai_hw_params(struct snd_pcm_substream *substream,
 			MAX9867_RAPID_LOCK, MAX9867_RAPID_LOCK);
 		regmap_update_bits(max9867->regmap, MAX9867_AUDIOCLKHIGH,
 			MAX9867_PLL, MAX9867_PLL);
-	} else {
-		unsigned long int bclk_rate, pclk_bclk_ratio;
-		int bclk_value;
-
-		bclk_rate = params_rate(params) * 2 * params_width(params);
-		pclk_bclk_ratio = max9867->pclk/bclk_rate;
-		switch (params_width(params)) {
-		case 8:
-		case 16:
-			switch (pclk_bclk_ratio) {
-			case 2:
-				bclk_value = MAX9867_IFC1B_PCLK_2;
-				break;
-			case 4:
-				bclk_value = MAX9867_IFC1B_PCLK_4;
-				break;
-			case 8:
-				bclk_value = MAX9867_IFC1B_PCLK_8;
-				break;
-			case 16:
-				bclk_value = MAX9867_IFC1B_PCLK_16;
-				break;
-			default:
-				dev_err(codec->dev,
-					"unsupported sampling rate\n");
-				return -EINVAL;
-			}
-			break;
-		case 24:
-			bclk_value = MAX9867_IFC1B_24BIT;
-			break;
-		case 32:
-			bclk_value = MAX9867_IFC1B_32BIT;
-			break;
-		default:
-			dev_err(codec->dev, "unsupported sampling rate\n");
-			return -EINVAL;
-		}
-		regmap_update_bits(max9867->regmap, MAX9867_IFC1B,
-			MAX9867_IFC1B_BCLK_MASK, bclk_value);
 	}
 	return 0;
 }
@@ -244,6 +204,9 @@ static int max9867_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 	value &= ~MAX9867_FREQ_MASK;
 	regmap_update_bits(max9867->regmap, MAX9867_SYSCLK,
 			MAX9867_PSCLK_MASK, value);
+	regmap_update_bits(max9867->regmap, MAX9867_IFC1B,
+			MAX9867_IFC1B_BCLK_MASK, 0x010);
+
 	return 0;
 }
 
-- 
2.15.1
