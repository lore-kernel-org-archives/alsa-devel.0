From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v5 3/4] ASoC: tlv320aic32x4: Rearrange clock
	tree shutdown
Date: Mon, 17 Feb 2014 11:04:19 +0100
Message-ID: <1392631460-32002-4-git-send-email-mpa@pengutronix.de>
References: <1392575252-9222-1-git-send-email-mpa@pengutronix.de>
 <1392631460-32002-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 688F3261B28
 for <alsa-devel@alsa-project.org>; Mon, 17 Feb 2014 11:04:47 +0100 (CET)
In-Reply-To: <1392631460-32002-1-git-send-email-mpa@pengutronix.de>
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
Cc: Markus Pargmann <mpa@pengutronix.de>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

Rearrange clock tree shutdown to disable them in the reversed order of
startup. First disable all dividers, then PLL followed by master clock.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/codecs/tlv320aic32x4.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index e4a7231..f76a693 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -537,29 +537,29 @@ static int aic32x4_set_bias_level(struct snd_soc_codec *codec,
 	case SND_SOC_BIAS_PREPARE:
 		break;
 	case SND_SOC_BIAS_STANDBY:
-		/* Switch off PLL */
-		snd_soc_update_bits(codec, AIC32X4_PLLPR,
-				    AIC32X4_PLLEN, 0);
-
-		/* Switch off NDAC Divider */
-		snd_soc_update_bits(codec, AIC32X4_NDAC,
-				    AIC32X4_NDACEN, 0);
+		/* Switch off BCLK_N Divider */
+		snd_soc_update_bits(codec, AIC32X4_BCLKN,
+				    AIC32X4_BCLKEN, 0);
 
-		/* Switch off MDAC Divider */
-		snd_soc_update_bits(codec, AIC32X4_MDAC,
-				    AIC32X4_MDACEN, 0);
+		/* Switch off MADC Divider */
+		snd_soc_update_bits(codec, AIC32X4_MADC,
+				    AIC32X4_MADCEN, 0);
 
 		/* Switch off NADC Divider */
 		snd_soc_update_bits(codec, AIC32X4_NADC,
 				    AIC32X4_NADCEN, 0);
 
-		/* Switch off MADC Divider */
-		snd_soc_update_bits(codec, AIC32X4_MADC,
-				    AIC32X4_MADCEN, 0);
+		/* Switch off MDAC Divider */
+		snd_soc_update_bits(codec, AIC32X4_MDAC,
+				    AIC32X4_MDACEN, 0);
 
-		/* Switch off BCLK_N Divider */
-		snd_soc_update_bits(codec, AIC32X4_BCLKN,
-				    AIC32X4_BCLKEN, 0);
+		/* Switch off NDAC Divider */
+		snd_soc_update_bits(codec, AIC32X4_NDAC,
+				    AIC32X4_NDACEN, 0);
+
+		/* Switch off PLL */
+		snd_soc_update_bits(codec, AIC32X4_PLLPR,
+				    AIC32X4_PLLEN, 0);
 
 		/* Switch off master clock */
 		if (!IS_ERR(aic32x4->mclk))
-- 
1.8.5.3
