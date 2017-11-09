From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 10/17] ASoC: tlv320aic31xx: Fix inverted BCLK
	handling
Date: Wed, 8 Nov 2017 18:27:34 -0600
Message-ID: <20171109002741.10897-11-afd@ti.com>
References: <20171109002741.10897-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelnx193.ext.ti.com (lelnx193.ext.ti.com [198.47.27.77])
 by alsa0.perex.cz (Postfix) with ESMTP id 13B11267671
 for <alsa-devel@alsa-project.org>; Thu,  9 Nov 2017 01:27:45 +0100 (CET)
In-Reply-To: <20171109002741.10897-1-afd@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>
List-Id: alsa-devel@alsa-project.org

Currently BCLK inverting is only handled when the DAI format is
DSP, but the BCLK may be inverted in any supported mode. Without
this using this CODEC in any other mode than DSP with the BCLK
inverted leads to bad sampling timing and very poor audio quality.

Fixes: e00447fafbf7 ("ASoC: tlv320aic31xx: Add basic codec driver implementation")

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 sound/soc/codecs/tlv320aic31xx.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index 19e74ab68692..e58b7a4e0402 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -946,6 +946,16 @@ static int aic31xx_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		return -EINVAL;
 	}
 
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		iface_reg2 |= AIC31XX_BCLKINV_MASK;
+		break;
+	default:
+		return -EINVAL;
+	}
+
 	/* interface format */
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
@@ -953,16 +963,12 @@ static int aic31xx_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	case SND_SOC_DAIFMT_DSP_A:
 		dsp_a_val = 0x1;
 	case SND_SOC_DAIFMT_DSP_B:
-		/* NOTE: BCLKINV bit value 1 equas NB and 0 equals IB */
-		switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
-		case SND_SOC_DAIFMT_NB_NF:
-			iface_reg2 |= AIC31XX_BCLKINV_MASK;
-			break;
-		case SND_SOC_DAIFMT_IB_NF:
-			break;
-		default:
-			return -EINVAL;
-		}
+		/*
+		 * NOTE: This CODEC samples on the falling edge of BCLK in
+		 * DSP mode, this is inverted compared to what most DAIs
+		 * expect, so we invert for this mode
+		 */
+		iface_reg2 ^= AIC31XX_BCLKINV_MASK;
 		iface_reg1 |= (AIC31XX_DSP_MODE <<
 			       AIC31XX_IFACE1_DATATYPE_SHIFT);
 		break;
-- 
2.15.0
