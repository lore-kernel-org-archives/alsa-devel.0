From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: [PATCH 4/8] ALSA: ASoC: DaVinci: i2s, evm,
	pass same value to codec and cpu_dai
Date: Thu, 18 Dec 2008 12:36:42 -0700
Message-ID: <1229629006-4261-5-git-send-email-troy.kisky@boundarydevices.com>
References: <>
	<1229629006-4261-1-git-send-email-troy.kisky@boundarydevices.com>
	<1229629006-4261-2-git-send-email-troy.kisky@boundarydevices.com>
	<1229629006-4261-3-git-send-email-troy.kisky@boundarydevices.com>
	<1229629006-4261-4-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mpls-qmqp-05.inet.qwest.net (mpls-qmqp-05.inet.qwest.net
	[63.231.195.116])
	by alsa0.perex.cz (Postfix) with ESMTP id CDF10244BE
	for <alsa-devel@alsa-project.org>; Thu, 18 Dec 2008 20:36:53 +0100 (CET)
In-Reply-To: <1229629006-4261-4-git-send-email-troy.kisky@boundarydevices.com>
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

Fix the meaning of SND_SOC_DAIFMT_NB_NF to match that
used in the codec.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>

diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index 555ecb2..a78ff59 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -28,6 +28,8 @@
 
 #define EVM_CODEC_CLOCK 22579200
 
+#define AUDIO_FORMAT (SND_SOC_DAIFMT_I2S | \
+		SND_SOC_DAIFMT_CBM_CFM | SND_SOC_DAIFMT_NB_NF)
 static int evm_hw_params(struct snd_pcm_substream *substream,
 			 struct snd_pcm_hw_params *params)
 {
@@ -37,16 +39,12 @@ static int evm_hw_params(struct snd_pcm_substream *substream,
 	int ret = 0;
 
 	/* set codec DAI configuration */
-	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
-					SND_SOC_DAIFMT_CBM_CFM |
-					SND_SOC_DAIFMT_NB_NF);
+	ret = snd_soc_dai_set_fmt(codec_dai, AUDIO_FORMAT);
 	if (ret < 0)
 		return ret;
 
 	/* set cpu DAI configuration */
-	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
-					SND_SOC_DAIFMT_CBM_CFM |
-				       SND_SOC_DAIFMT_IB_NF);
+	ret = snd_soc_dai_set_fmt(cpu_dai, AUDIO_FORMAT);
 	if (ret < 0)
 		return ret;
 
diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/davinci/davinci-i2s.c
index ecb5e83..8e2cdf2 100644
--- a/sound/soc/davinci/davinci-i2s.c
+++ b/sound/soc/davinci/davinci-i2s.c
@@ -234,7 +234,7 @@ static int davinci_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 	}
 
 	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
-	case SND_SOC_DAIFMT_IB_NF:
+	case SND_SOC_DAIFMT_NB_NF:
 		/* CLKRP Receive clock polarity,
 		 *	1 - sampled on rising edge of CLKR
 		 *	valid on rising edge
@@ -249,7 +249,7 @@ static int davinci_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 			       DAVINCI_MCBSP_PCR_CLKRP, 1);
 		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_PCR_REG, w);
 		break;
-	case SND_SOC_DAIFMT_NB_IF:
+	case SND_SOC_DAIFMT_IB_IF:
 		/* CLKRP Receive clock polarity,
 		 *	0 - sampled on falling edge of CLKR
 		 *	valid on falling edge
@@ -264,7 +264,7 @@ static int davinci_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 			       DAVINCI_MCBSP_PCR_FSRP, 1);
 		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_PCR_REG, w);
 		break;
-	case SND_SOC_DAIFMT_IB_IF:
+	case SND_SOC_DAIFMT_NB_IF:
 		/* CLKRP Receive clock polarity,
 		 *	1 - sampled on rising edge of CLKR
 		 *	valid on rising edge
@@ -281,7 +281,7 @@ static int davinci_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 			       DAVINCI_MCBSP_PCR_FSRP, 1);
 		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_PCR_REG, w);
 		break;
-	case SND_SOC_DAIFMT_NB_NF:
+	case SND_SOC_DAIFMT_IB_NF:
 		/* CLKRP Receive clock polarity,
 		 *	0 - sampled on falling edge of CLKR
 		 *	valid on falling edge
-- 
1.5.4.3
