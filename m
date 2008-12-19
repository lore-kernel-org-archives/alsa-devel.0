From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: [PATCH 1/4] ALSA: ASoC: tlv320aic3x add dsp_a
Date: Fri, 19 Dec 2008 13:05:22 -0700
Message-ID: <1229717125-9859-1-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mpls-qmqp-03.inet.qwest.net (mpls-qmqp-03.inet.qwest.net
	[63.231.195.114])
	by alsa0.perex.cz (Postfix) with ESMTP id A2E241037F7
	for <alsa-devel@alsa-project.org>; Fri, 19 Dec 2008 21:05:33 +0100 (CET)
In-Reply-To: <>
References: <>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: naresh@ti.com, broonie@sirena.org.uk, Troy Kisky <troy.kisky@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

Add SND_SOC_DAIFMT_DSP_A mode option.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index b76bcc3..b9b67ed 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -847,6 +847,7 @@ static int aic3x_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	struct snd_soc_codec *codec = codec_dai->codec;
 	struct aic3x_priv *aic3x = codec->private_data;
 	u8 iface_areg, iface_breg;
+	int delay = 0;
 
 	iface_areg = aic3x_read_reg_cache(codec, AIC3X_ASD_INTF_CTRLA) & 0x3f;
 	iface_breg = aic3x_read_reg_cache(codec, AIC3X_ASD_INTF_CTRLB) & 0x3f;
@@ -872,6 +873,8 @@ static int aic3x_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		       SND_SOC_DAIFMT_INV_MASK)) {
 	case (SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF):
 		break;
+	case (SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_IB_NF):
+		delay = 1;
 	case (SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_IB_NF):
 		iface_breg |= (0x01 << 6);
 		break;
@@ -888,6 +891,7 @@ static int aic3x_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	/* set iface */
 	aic3x_write(codec, AIC3X_ASD_INTF_CTRLA, iface_areg);
 	aic3x_write(codec, AIC3X_ASD_INTF_CTRLB, iface_breg);
+	aic3x_write(codec, AIC3X_ASD_INTF_CTRLC, delay);
 
 	return 0;
 }
diff --git a/sound/soc/codecs/tlv320aic3x.h b/sound/soc/codecs/tlv320aic3x.h
index 00a195a..40a6c2a 100644
--- a/sound/soc/codecs/tlv320aic3x.h
+++ b/sound/soc/codecs/tlv320aic3x.h
@@ -35,6 +35,8 @@
 #define AIC3X_ASD_INTF_CTRLA		8
 /* Audio serial data interface control register B */
 #define AIC3X_ASD_INTF_CTRLB		9
+/* Audio serial data interface control register C */
+#define AIC3X_ASD_INTF_CTRLC		10
 /* Audio overflow status and PLL R value programming register */
 #define AIC3X_OVRF_STATUS_AND_PLLR_REG	11
 /* Audio codec digital filter control register */
-- 
1.5.4.3
