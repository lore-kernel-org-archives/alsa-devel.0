From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: [PATCH 2/4] ALSA: ASoC: DaVinci: i2s, evm,
	pass same value to codec and cpu_dai
Date: Fri, 19 Dec 2008 13:05:23 -0700
Message-ID: <1229717125-9859-2-git-send-email-troy.kisky@boundarydevices.com>
References: <>
	<1229717125-9859-1-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mpls-qmqp-04.inet.qwest.net (mpls-qmqp-04.inet.qwest.net
	[63.231.195.115])
	by alsa0.perex.cz (Postfix) with ESMTP id A06B71037F4
	for <alsa-devel@alsa-project.org>; Fri, 19 Dec 2008 21:05:33 +0100 (CET)
In-Reply-To: <1229717125-9859-1-git-send-email-troy.kisky@boundarydevices.com>
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
index fa8b57d..c425c86 100644
--- a/sound/soc/davinci/davinci-i2s.c
+++ b/sound/soc/davinci/davinci-i2s.c
@@ -254,7 +254,7 @@ static int davinci_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 	}
 
 	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
-	case SND_SOC_DAIFMT_IB_NF:
+	case SND_SOC_DAIFMT_NB_NF:
 		/* CLKRP Receive clock polarity,
 		 *	1 - sampled on rising edge of CLKR
 		 *	valid on rising edge
@@ -266,7 +266,7 @@ static int davinci_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		 */
 		pcr |= (DAVINCI_MCBSP_PCR_CLKXP | DAVINCI_MCBSP_PCR_CLKRP);
 		break;
-	case SND_SOC_DAIFMT_NB_IF:
+	case SND_SOC_DAIFMT_IB_IF:
 		/* CLKRP Receive clock polarity,
 		 *	0 - sampled on falling edge of CLKR
 		 *	valid on falling edge
@@ -278,7 +278,7 @@ static int davinci_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		 */
 		pcr |= (DAVINCI_MCBSP_PCR_FSXP | DAVINCI_MCBSP_PCR_FSRP);
 		break;
-	case SND_SOC_DAIFMT_IB_IF:
+	case SND_SOC_DAIFMT_NB_IF:
 		/* CLKRP Receive clock polarity,
 		 *	1 - sampled on rising edge of CLKR
 		 *	valid on rising edge
@@ -291,7 +291,7 @@ static int davinci_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		pcr |= (DAVINCI_MCBSP_PCR_CLKXP | DAVINCI_MCBSP_PCR_CLKRP |
 			DAVINCI_MCBSP_PCR_FSXP | DAVINCI_MCBSP_PCR_FSRP);
 		break;
-	case SND_SOC_DAIFMT_NB_NF:
+	case SND_SOC_DAIFMT_IB_NF:
 		/* CLKRP Receive clock polarity,
 		 *	0 - sampled on falling edge of CLKR
 		 *	valid on falling edge
-- 
1.5.4.3
