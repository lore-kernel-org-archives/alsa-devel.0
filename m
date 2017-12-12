From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 09/10] ASoC: tlv320aic32x4: Use snd_soc_update_bits() in aic32x4_set_dai_fmt()
Date: Tue, 12 Dec 2017 16:43:10 -0600
Message-ID: <20171212224311.24045-9-afd@ti.com>
References: <20171212224311.24045-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171212224311.24045-1-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>
List-Id: alsa-devel@alsa-project.org

Make the code easier to read by using snd_soc_update_bits() over
read/modify/write sequences.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 sound/soc/codecs/tlv320aic32x4.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index 7a570afac8df..cccb3c2edb64 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -598,16 +598,9 @@ static int aic32x4_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 static int aic32x4_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
-	u8 iface_reg_1;
-	u8 iface_reg_2;
-	u8 iface_reg_3;
-
-	iface_reg_1 = snd_soc_read(codec, AIC32X4_IFACE1);
-	iface_reg_1 = iface_reg_1 & ~(3 << 6 | 3 << 2);
-	iface_reg_2 = snd_soc_read(codec, AIC32X4_IFACE2);
-	iface_reg_2 = 0;
-	iface_reg_3 = snd_soc_read(codec, AIC32X4_IFACE3);
-	iface_reg_3 = iface_reg_3 & ~(1 << 3);
+	u8 iface_reg_1 = 0;
+	u8 iface_reg_2 = 0;
+	u8 iface_reg_3 = 0;
 
 	/* set master/slave audio interface */
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
@@ -627,13 +620,13 @@ static int aic32x4_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 	case SND_SOC_DAIFMT_DSP_A:
 		iface_reg_1 |= (AIC32X4_DSP_MODE <<
 				AIC32X4_IFACE1_DATATYPE_SHIFT);
-		iface_reg_3 |= (1 << 3); /* invert bit clock */
+		iface_reg_3 |= AIC32X4_BCLKINV_MASK; /* invert bit clock */
 		iface_reg_2 = 0x01; /* add offset 1 */
 		break;
 	case SND_SOC_DAIFMT_DSP_B:
 		iface_reg_1 |= (AIC32X4_DSP_MODE <<
 				AIC32X4_IFACE1_DATATYPE_SHIFT);
-		iface_reg_3 |= (1 << 3); /* invert bit clock */
+		iface_reg_3 |= AIC32X4_BCLKINV_MASK; /* invert bit clock */
 		break;
 	case SND_SOC_DAIFMT_RIGHT_J:
 		iface_reg_1 |= (AIC32X4_RIGHT_JUSTIFIED_MODE <<
@@ -648,9 +641,14 @@ static int aic32x4_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 		return -EINVAL;
 	}
 
-	snd_soc_write(codec, AIC32X4_IFACE1, iface_reg_1);
-	snd_soc_write(codec, AIC32X4_IFACE2, iface_reg_2);
-	snd_soc_write(codec, AIC32X4_IFACE3, iface_reg_3);
+	snd_soc_update_bits(codec, AIC32X4_IFACE1,
+			    AIC32X4_IFACE1_DATATYPE_MASK |
+			    AIC32X4_IFACE1_MASTER_MASK, iface_reg_1);
+	snd_soc_update_bits(codec, AIC32X4_IFACE2,
+			    AIC32X4_DATA_OFFSET_MASK, iface_reg_2);
+	snd_soc_update_bits(codec, AIC32X4_IFACE3,
+			    AIC32X4_BCLKINV_MASK, iface_reg_3);
+
 	return 0;
 }
 
-- 
2.15.0
