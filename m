From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: tlv320aic32x4: Use snd_soc_update_bits
 for read-modify-write
Date: Thu, 13 Oct 2011 22:56:34 +0800
Message-ID: <1318517794.4554.4.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
	[209.85.220.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 93137103834
	for <alsa-devel@alsa-project.org>;
	Thu, 13 Oct 2011 16:56:46 +0200 (CEST)
Received: by vcbfk26 with SMTP id fk26so104293vcb.38
	for <alsa-devel@alsa-project.org>; Thu, 13 Oct 2011 07:56:45 -0700 (PDT)
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Wolfram Sang <w.sang@pengutronix.de>, Javier Martin <javier.martin@vista-silicon.com>
List-Id: alsa-devel@alsa-project.org

Use snd_soc_update_bits for read-modify-write register access instead of
open-coding it using snd_soc_read and snd_soc_write.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
This patch also fixes the mix usage of 
AIC32X4_MDACEN/AIC32X4_NDACEN/AIC32X4_NADCEN/AIC32X4_MADCEN in current code.
(They are all defined as (0x01 << 7), so it is not a bug,
 but not good for readability.)
Axel

 sound/soc/codecs/tlv320aic32x4.c |   61 +++++++++++++++-----------------------
 1 files changed, 24 insertions(+), 37 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index a68982e..b21c610 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -528,40 +528,33 @@ static int aic32x4_set_bias_level(struct snd_soc_codec *codec,
 				  enum snd_soc_bias_level level)
 {
 	struct aic32x4_priv *aic32x4 = snd_soc_codec_get_drvdata(codec);
-	u8 value;
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
 		if (aic32x4->master) {
 			/* Switch on PLL */
-			value = snd_soc_read(codec, AIC32X4_PLLPR);
-			snd_soc_write(codec, AIC32X4_PLLPR,
-				      (value | AIC32X4_PLLEN));
+			snd_soc_update_bits(codec, AIC32X4_PLLPR,
+					    AIC32X4_PLLEN, AIC32X4_PLLEN);
 
 			/* Switch on NDAC Divider */
-			value = snd_soc_read(codec, AIC32X4_NDAC);
-			snd_soc_write(codec, AIC32X4_NDAC,
-				      value | AIC32X4_NDACEN);
+			snd_soc_update_bits(codec, AIC32X4_NDAC,
+					    AIC32X4_NDACEN, AIC32X4_NDACEN);
 
 			/* Switch on MDAC Divider */
-			value = snd_soc_read(codec, AIC32X4_MDAC);
-			snd_soc_write(codec, AIC32X4_MDAC,
-				      value | AIC32X4_MDACEN);
+			snd_soc_update_bits(codec, AIC32X4_MDAC,
+					    AIC32X4_MDACEN, AIC32X4_MDACEN);
 
 			/* Switch on NADC Divider */
-			value = snd_soc_read(codec, AIC32X4_NADC);
-			snd_soc_write(codec, AIC32X4_NADC,
-				      value | AIC32X4_MDACEN);
+			snd_soc_update_bits(codec, AIC32X4_NADC,
+					    AIC32X4_NADCEN, AIC32X4_NADCEN);
 
 			/* Switch on MADC Divider */
-			value = snd_soc_read(codec, AIC32X4_MADC);
-			snd_soc_write(codec, AIC32X4_MADC,
-				      value | AIC32X4_MDACEN);
+			snd_soc_update_bits(codec, AIC32X4_MADC,
+					    AIC32X4_MADCEN, AIC32X4_MADCEN);
 
 			/* Switch on BCLK_N Divider */
-			value = snd_soc_read(codec, AIC32X4_BCLKN);
-			snd_soc_write(codec, AIC32X4_BCLKN,
-				      value | AIC32X4_BCLKEN);
+			snd_soc_update_bits(codec, AIC32X4_BCLKN,
+					    AIC32X4_BCLKEN, AIC32X4_BCLKEN);
 		}
 		break;
 	case SND_SOC_BIAS_PREPARE:
@@ -569,34 +562,28 @@ static int aic32x4_set_bias_level(struct snd_soc_codec *codec,
 	case SND_SOC_BIAS_STANDBY:
 		if (aic32x4->master) {
 			/* Switch off PLL */
-			value = snd_soc_read(codec, AIC32X4_PLLPR);
-			snd_soc_write(codec, AIC32X4_PLLPR,
-				      (value & ~AIC32X4_PLLEN));
+			snd_soc_update_bits(codec, AIC32X4_PLLPR,
+					    AIC32X4_PLLEN, 0);
 
 			/* Switch off NDAC Divider */
-			value = snd_soc_read(codec, AIC32X4_NDAC);
-			snd_soc_write(codec, AIC32X4_NDAC,
-				      value & ~AIC32X4_NDACEN);
+			snd_soc_update_bits(codec, AIC32X4_NDAC,
+					    AIC32X4_NDACEN, 0);
 
 			/* Switch off MDAC Divider */
-			value = snd_soc_read(codec, AIC32X4_MDAC);
-			snd_soc_write(codec, AIC32X4_MDAC,
-				      value & ~AIC32X4_MDACEN);
+			snd_soc_update_bits(codec, AIC32X4_MDAC,
+					    AIC32X4_MDACEN, 0);
 
 			/* Switch off NADC Divider */
-			value = snd_soc_read(codec, AIC32X4_NADC);
-			snd_soc_write(codec, AIC32X4_NADC,
-				      value & ~AIC32X4_NDACEN);
+			snd_soc_update_bits(codec, AIC32X4_NADC,
+					    AIC32X4_NADCEN, 0);
 
 			/* Switch off MADC Divider */
-			value = snd_soc_read(codec, AIC32X4_MADC);
-			snd_soc_write(codec, AIC32X4_MADC,
-				      value & ~AIC32X4_MDACEN);
-			value = snd_soc_read(codec, AIC32X4_BCLKN);
+			snd_soc_update_bits(codec, AIC32X4_MADC,
+					    AIC32X4_MADCEN, 0);
 
 			/* Switch off BCLK_N Divider */
-			snd_soc_write(codec, AIC32X4_BCLKN,
-				      value & ~AIC32X4_BCLKEN);
+			snd_soc_update_bits(codec, AIC32X4_BCLKN,
+					    AIC32X4_BCLKEN, 0);
 		}
 		break;
 	case SND_SOC_BIAS_OFF:
-- 
1.7.4.1
