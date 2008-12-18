From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: [PATCH 1/8] ALSA: ASoC: tlv320aic3x add dsp_a,
	fix dsp_b
Date: Thu, 18 Dec 2008 12:36:39 -0700
Message-ID: <1229629006-4261-2-git-send-email-troy.kisky@boundarydevices.com>
References: <>
	<1229629006-4261-1-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mpls-qmqp-02.inet.qwest.net (mpls-qmqp-02.inet.qwest.net
	[63.231.195.113])
	by alsa0.perex.cz (Postfix) with ESMTP id DB73E244BF
	for <alsa-devel@alsa-project.org>; Thu, 18 Dec 2008 20:36:53 +0100 (CET)
In-Reply-To: <1229629006-4261-1-git-send-email-troy.kisky@boundarydevices.com>
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
Cc: davinci-linux-open-source@linux.davincidsp.com, broonie@sirena.org.uk, Troy Kisky <troy.kisky@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

Add SND_SOC_DAIFMT_DSP_A and fix SND_SOC_DAIFMT_DSP_B
mode. Before dsp_b was really being initialized as dsp_a.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index b76bcc3..ad19661 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -847,6 +847,7 @@ static int aic3x_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	struct snd_soc_codec *codec = codec_dai->codec;
 	struct aic3x_priv *aic3x = codec->private_data;
 	u8 iface_areg, iface_breg;
+	int delay = 0;
 
 	iface_areg = aic3x_read_reg_cache(codec, AIC3X_ASD_INTF_CTRLA) & 0x3f;
 	iface_breg = aic3x_read_reg_cache(codec, AIC3X_ASD_INTF_CTRLB) & 0x3f;
@@ -873,6 +874,8 @@ static int aic3x_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	case (SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF):
 		break;
 	case (SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_IB_NF):
+		delay = 1;
+	case (SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_IB_NF):
 		iface_breg |= (0x01 << 6);
 		break;
 	case (SND_SOC_DAIFMT_RIGHT_J | SND_SOC_DAIFMT_NB_NF):
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
