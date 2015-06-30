From: Kimmo Saarela <kimmo.saarela-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/5] ASoC: tlv320aic32x4: Move bit polarity config to specific switch statement
Date: Tue, 30 Jun 2015 13:25:11 +0300
Message-ID: <7007ae68aa1b5585ca791cedcf0527d1c918d2ce.1435569929.git.kimmo.saarela@gmail.com>
References: <cover.1435569929.git.kimmo.saarela@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1435569929.git.kimmo.saarela-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
In-Reply-To: <cover.1435569929.git.kimmo.saarela-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
References: <cover.1435569929.git.kimmo.saarela-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Kimmo Saarela <kimmo.saarela-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Move data format bit polarity control to its own switch statement,
instead of magically selecting invert for specific formats.
Fix supply format in binding documentation

Signed-off-by: Kimmo Saarela <kimmo.saarela-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 .../devicetree/bindings/sound/tlv320aic32x4.txt    |  2 +-
 sound/soc/codecs/tlv320aic32x4.c                   | 22 ++++++++++++++++++++--
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/tlv320aic32x4.txt b/Documentation/devicetree/bindings/sound/tlv320aic32x4.txt
index 5e2741a..143a192 100644
--- a/Documentation/devicetree/bindings/sound/tlv320aic32x4.txt
+++ b/Documentation/devicetree/bindings/sound/tlv320aic32x4.txt
@@ -5,7 +5,7 @@ The tlv320aic32x4 serial control bus communicates through I2C protocols
 Required properties:
  - compatible: Should be "ti,tlv320aic32x4"
  - reg: I2C slave address
- - supply-*: Required supply regulators are:
+ - *-supply: Required supply regulators are:
     "iov" - digital IO power supply
     "ldoin" - LDO power supply
     "dv" - Digital core power supply
diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index ce0972f..d3636c1 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -353,17 +353,35 @@ static int aic32x4_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 		return -EINVAL;
 	}
 
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_IB_NF:
+		iface_reg_3 |= (1 << 3); /* invert bit clock */
+		break;
+
+	case SND_SOC_DAIFMT_NB_IF:
+		break;
+
+	case SND_SOC_DAIFMT_IB_IF:
+		iface_reg_3 |= (1 << 3); /* invert bit clock */
+		break;
+
+	case SND_SOC_DAIFMT_NB_NF:
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
 		break;
 	case SND_SOC_DAIFMT_DSP_A:
 		iface_reg_1 |= (AIC32X4_DSP_MODE << AIC32X4_PLLJ_SHIFT);
-		iface_reg_3 |= (1 << 3); /* invert bit clock */
 		iface_reg_2 = 0x01; /* add offset 1 */
 		break;
 	case SND_SOC_DAIFMT_DSP_B:
 		iface_reg_1 |= (AIC32X4_DSP_MODE << AIC32X4_PLLJ_SHIFT);
-		iface_reg_3 |= (1 << 3); /* invert bit clock */
 		break;
 	case SND_SOC_DAIFMT_RIGHT_J:
 		iface_reg_1 |=
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
