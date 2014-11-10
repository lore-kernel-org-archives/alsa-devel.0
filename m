From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/2] ASoC: tlv320aic3x: Add TDM support
Date: Mon, 10 Nov 2014 12:27:33 +0200
Message-ID: <1415615253-28919-2-git-send-email-peter.ujfalusi@ti.com>
References: <1415615253-28919-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F9412606FB
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 11:27:41 +0100 (CET)
In-Reply-To: <1415615253-28919-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

TDM support is achieved using DSP transfer mode and setting a
programmable offset which specifies where data begins with
respect to the frame sync.

It requires 256-clock mode if CODEC is master (not currently
supported in the driver). No additional dependency if CODEC
is slave.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/tlv320aic3x.c | 62 ++++++++++++++++++++++++++++++++++++++++--
 sound/soc/codecs/tlv320aic3x.h |  1 +
 2 files changed, 60 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 70f8b8be9173..510158a5d8ca 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -78,6 +78,8 @@ struct aic3x_priv {
 	struct aic3x_disable_nb disable_nb[AIC3X_NUM_SUPPLIES];
 	struct aic3x_setup_data *setup;
 	unsigned int sysclk;
+	unsigned int dai_fmt;
+	unsigned int tdm_delay;
 	struct list_head list;
 	int master;
 	int gpio_reset;
@@ -1022,6 +1024,25 @@ found:
 	return 0;
 }
 
+static int aic3x_prepare(struct snd_pcm_substream *substream,
+			 struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct aic3x_priv *aic3x = snd_soc_codec_get_drvdata(codec);
+	int delay = 0;
+
+	/* TDM slot selection only valid in DSP_A/_B mode */
+	if (aic3x->dai_fmt == SND_SOC_DAIFMT_DSP_A)
+		delay += (aic3x->tdm_delay + 1);
+	else if (aic3x->dai_fmt == SND_SOC_DAIFMT_DSP_B)
+		delay += aic3x->tdm_delay;
+
+	/* Configure data delay */
+	snd_soc_write(codec, AIC3X_ASD_INTF_CTRLC, aic3x->tdm_delay);
+
+	return 0;
+}
+
 static int aic3x_mute(struct snd_soc_dai *dai, int mute)
 {
 	struct snd_soc_codec *codec = dai->codec;
@@ -1061,7 +1082,6 @@ static int aic3x_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	struct snd_soc_codec *codec = codec_dai->codec;
 	struct aic3x_priv *aic3x = snd_soc_codec_get_drvdata(codec);
 	u8 iface_areg, iface_breg;
-	int delay = 0;
 
 	iface_areg = snd_soc_read(codec, AIC3X_ASD_INTF_CTRLA) & 0x3f;
 	iface_breg = snd_soc_read(codec, AIC3X_ASD_INTF_CTRLB) & 0x3f;
@@ -1089,7 +1109,6 @@ static int aic3x_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	case (SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF):
 		break;
 	case (SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_IB_NF):
-		delay = 1;
 	case (SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_IB_NF):
 		iface_breg |= (0x01 << 6);
 		break;
@@ -1103,10 +1122,45 @@ static int aic3x_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		return -EINVAL;
 	}
 
+	aic3x->dai_fmt = fmt & SND_SOC_DAIFMT_FORMAT_MASK;
+
 	/* set iface */
 	snd_soc_write(codec, AIC3X_ASD_INTF_CTRLA, iface_areg);
 	snd_soc_write(codec, AIC3X_ASD_INTF_CTRLB, iface_breg);
-	snd_soc_write(codec, AIC3X_ASD_INTF_CTRLC, delay);
+
+	return 0;
+}
+
+static int aic3x_set_dai_tdm_slot(struct snd_soc_dai *codec_dai,
+				  unsigned int tx_mask, unsigned int rx_mask,
+				  int slots, int slot_width)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct aic3x_priv *aic3x = snd_soc_codec_get_drvdata(codec);
+	unsigned int lsb;
+
+	if (tx_mask != rx_mask) {
+		dev_err(codec->dev, "tx and rx masks must be symmetric\n");
+		return -EINVAL;
+	}
+
+	if (unlikely(!tx_mask)) {
+		dev_err(codec->dev, "tx and rx masks need to be non 0\n");
+		return -EINVAL;
+	}
+
+	/* TDM based on DSP mode requires slots to be adjacent */
+	lsb = __ffs(tx_mask);
+	if ((lsb + 1) != __fls(tx_mask)) {
+		dev_err(codec->dev, "Invalid mask, slots must be adjacent\n");
+		return -EINVAL;
+	}
+
+	aic3x->tdm_delay = lsb * slot_width;
+
+	/* DOUT in high-impedance on inactive bit clocks */
+	snd_soc_update_bits(codec, AIC3X_ASD_INTF_CTRLA,
+			    DOUT_TRISTATE, DOUT_TRISTATE);
 
 	return 0;
 }
@@ -1225,9 +1279,11 @@ static int aic3x_set_bias_level(struct snd_soc_codec *codec,
 
 static const struct snd_soc_dai_ops aic3x_dai_ops = {
 	.hw_params	= aic3x_hw_params,
+	.prepare	= aic3x_prepare,
 	.digital_mute	= aic3x_mute,
 	.set_sysclk	= aic3x_set_dai_sysclk,
 	.set_fmt	= aic3x_set_dai_fmt,
+	.set_tdm_slot	= aic3x_set_dai_tdm_slot,
 };
 
 static struct snd_soc_dai_driver aic3x_dai = {
diff --git a/sound/soc/codecs/tlv320aic3x.h b/sound/soc/codecs/tlv320aic3x.h
index e521ac3ddde8..89fa692df206 100644
--- a/sound/soc/codecs/tlv320aic3x.h
+++ b/sound/soc/codecs/tlv320aic3x.h
@@ -169,6 +169,7 @@
 /* Audio serial data interface control register A bits */
 #define BIT_CLK_MASTER          0x80
 #define WORD_CLK_MASTER         0x40
+#define DOUT_TRISTATE		0x20
 
 /* Codec Datapath setup register 7 */
 #define FSREF_44100		(1 << 7)
-- 
2.1.3
