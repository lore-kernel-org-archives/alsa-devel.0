From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 04/10] ASoC: tlv320aic32x4: Use correct shift definition for DATATYPE bits
Date: Tue, 12 Dec 2017 16:43:05 -0600
Message-ID: <20171212224311.24045-4-afd@ti.com>
References: <20171212224311.24045-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171212224311.24045-1-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>
List-Id: alsa-devel@alsa-project.org

Setting the DATATYPE bit field requires shifting our value by 6. Setting
the J value of the PLL also requires a shift by 6. Currently the code
abuses this fact and uses the shift for the PLL register to set the
data-type register. Fix this here by using the definition meant for
this register.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 sound/soc/codecs/tlv320aic32x4.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index e37ab968a938..01e65d768cab 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -625,21 +625,23 @@ static int aic32x4_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 	case SND_SOC_DAIFMT_I2S:
 		break;
 	case SND_SOC_DAIFMT_DSP_A:
-		iface_reg_1 |= (AIC32X4_DSP_MODE << AIC32X4_PLLJ_SHIFT);
+		iface_reg_1 |= (AIC32X4_DSP_MODE <<
+				AIC32X4_IFACE1_DATATYPE_SHIFT);
 		iface_reg_3 |= (1 << 3); /* invert bit clock */
 		iface_reg_2 = 0x01; /* add offset 1 */
 		break;
 	case SND_SOC_DAIFMT_DSP_B:
-		iface_reg_1 |= (AIC32X4_DSP_MODE << AIC32X4_PLLJ_SHIFT);
+		iface_reg_1 |= (AIC32X4_DSP_MODE <<
+				AIC32X4_IFACE1_DATATYPE_SHIFT);
 		iface_reg_3 |= (1 << 3); /* invert bit clock */
 		break;
 	case SND_SOC_DAIFMT_RIGHT_J:
-		iface_reg_1 |=
-			(AIC32X4_RIGHT_JUSTIFIED_MODE << AIC32X4_PLLJ_SHIFT);
+		iface_reg_1 |= (AIC32X4_RIGHT_JUSTIFIED_MODE <<
+				AIC32X4_IFACE1_DATATYPE_SHIFT);
 		break;
 	case SND_SOC_DAIFMT_LEFT_J:
-		iface_reg_1 |=
-			(AIC32X4_LEFT_JUSTIFIED_MODE << AIC32X4_PLLJ_SHIFT);
+		iface_reg_1 |= (AIC32X4_LEFT_JUSTIFIED_MODE <<
+				AIC32X4_IFACE1_DATATYPE_SHIFT);
 		break;
 	default:
 		printk(KERN_ERR "aic32x4: invalid DAI interface format\n");
-- 
2.15.0
