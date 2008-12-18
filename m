From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: [PATCH 5/8] ALSA: ASoC: DaVinci: davinci-i2s clean up
Date: Thu, 18 Dec 2008 12:36:43 -0700
Message-ID: <1229629006-4261-6-git-send-email-troy.kisky@boundarydevices.com>
References: <>
	<1229629006-4261-1-git-send-email-troy.kisky@boundarydevices.com>
	<1229629006-4261-2-git-send-email-troy.kisky@boundarydevices.com>
	<1229629006-4261-3-git-send-email-troy.kisky@boundarydevices.com>
	<1229629006-4261-4-git-send-email-troy.kisky@boundarydevices.com>
	<1229629006-4261-5-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mpls-qmqp-04.inet.qwest.net (mpls-qmqp-04.inet.qwest.net
	[63.231.195.115])
	by alsa0.perex.cz (Postfix) with ESMTP id E49D6244C0
	for <alsa-devel@alsa-project.org>; Thu, 18 Dec 2008 20:36:58 +0100 (CET)
In-Reply-To: <1229629006-4261-5-git-send-email-troy.kisky@boundarydevices.com>
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

Just at little cleanup of davinci_i2s_set_dai_fmt

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>

diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/davinci/davinci-i2s.c
index 8e2cdf2..c064348 100644
--- a/sound/soc/davinci/davinci-i2s.c
+++ b/sound/soc/davinci/davinci-i2s.c
@@ -200,36 +200,41 @@ static int davinci_i2s_startup(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+#define DEFAULT_BITPERSAMPLE	16
+
 static int davinci_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 				   unsigned int fmt)
 {
 	struct davinci_mcbsp_dev *dev = cpu_dai->private_data;
-	u32 w;
+	unsigned int pcr;
+	unsigned int srgr;
+	unsigned int rcr;
+	unsigned int xcr;
+	srgr = DAVINCI_MCBSP_SRGR_FSGM |
+		DAVINCI_MCBSP_SRGR_FPER(DEFAULT_BITPERSAMPLE * 2 - 1) |
+		DAVINCI_MCBSP_SRGR_FWID(DEFAULT_BITPERSAMPLE - 1);
 
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBS_CFS:
-		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_PCR_REG,
-					DAVINCI_MCBSP_PCR_FSXM |
-					DAVINCI_MCBSP_PCR_FSRM |
-					DAVINCI_MCBSP_PCR_CLKXM |
-					DAVINCI_MCBSP_PCR_CLKRM);
-		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SRGR_REG,
-					DAVINCI_MCBSP_SRGR_FSGM);
+		/* cpu is master */
+		pcr = DAVINCI_MCBSP_PCR_FSXM |
+			DAVINCI_MCBSP_PCR_FSRM |
+			DAVINCI_MCBSP_PCR_CLKXM |
+			DAVINCI_MCBSP_PCR_CLKRM;
 		break;
 	case SND_SOC_DAIFMT_CBM_CFS:
 		/* McBSP CLKR pin is the input for the Sample Rate Generator.
 		 * McBSP FSR and FSX are driven by the Sample Rate Generator. */
-		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_PCR_REG,
-					DAVINCI_MCBSP_PCR_SCLKME |
-					DAVINCI_MCBSP_PCR_FSXM |
-					DAVINCI_MCBSP_PCR_FSRM);
-		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SRGR_REG,
-					DAVINCI_MCBSP_SRGR_FSGM);
+		pcr = DAVINCI_MCBSP_PCR_SCLKME |
+			DAVINCI_MCBSP_PCR_FSXM |
+			DAVINCI_MCBSP_PCR_FSRM;
 		break;
 	case SND_SOC_DAIFMT_CBM_CFM:
-		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_PCR_REG, 0);
+		/* codec is master */
+		pcr = 0;
 		break;
 	default:
+		printk(KERN_ERR "%s:bad master\n", __func__);
 		return -EINVAL;
 	}
 
@@ -244,10 +249,7 @@ static int davinci_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		 * FSRP  Receive frame sync pol, 0 - active high
 		 * FSXP  Transmit frame sync pol, 0 - active high
 		 */
-		w = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_PCR_REG);
-		MOD_REG_BIT(w, DAVINCI_MCBSP_PCR_CLKXP |
-			       DAVINCI_MCBSP_PCR_CLKRP, 1);
-		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_PCR_REG, w);
+		pcr |= (DAVINCI_MCBSP_PCR_CLKXP | DAVINCI_MCBSP_PCR_CLKRP);
 		break;
 	case SND_SOC_DAIFMT_IB_IF:
 		/* CLKRP Receive clock polarity,
@@ -259,10 +261,7 @@ static int davinci_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		 * FSRP  Receive frame sync pol, 1 - active low
 		 * FSXP  Transmit frame sync pol, 1 - active low
 		 */
-		w = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_PCR_REG);
-		MOD_REG_BIT(w, DAVINCI_MCBSP_PCR_FSXP |
-			       DAVINCI_MCBSP_PCR_FSRP, 1);
-		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_PCR_REG, w);
+		pcr |= (DAVINCI_MCBSP_PCR_FSXP | DAVINCI_MCBSP_PCR_FSRP);
 		break;
 	case SND_SOC_DAIFMT_NB_IF:
 		/* CLKRP Receive clock polarity,
@@ -274,12 +273,8 @@ static int davinci_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		 * FSRP  Receive frame sync pol, 1 - active low
 		 * FSXP  Transmit frame sync pol, 1 - active low
 		 */
-		w = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_PCR_REG);
-		MOD_REG_BIT(w, DAVINCI_MCBSP_PCR_CLKXP |
-			       DAVINCI_MCBSP_PCR_CLKRP |
-			       DAVINCI_MCBSP_PCR_FSXP |
-			       DAVINCI_MCBSP_PCR_FSRP, 1);
-		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_PCR_REG, w);
+		pcr |= (DAVINCI_MCBSP_PCR_CLKXP | DAVINCI_MCBSP_PCR_CLKRP |
+			DAVINCI_MCBSP_PCR_FSXP | DAVINCI_MCBSP_PCR_FSRP);
 		break;
 	case SND_SOC_DAIFMT_IB_NF:
 		/* CLKRP Receive clock polarity,
@@ -296,28 +291,24 @@ static int davinci_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		return -EINVAL;
 	}
 
+	rcr = DAVINCI_MCBSP_RCR_RFRLEN1(1);
+	xcr = DAVINCI_MCBSP_XCR_XFIG | DAVINCI_MCBSP_XCR_XFRLEN1(1);
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_RIGHT_J:
-		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_RCR_REG,
-					DAVINCI_MCBSP_RCR_RFRLEN1(1) |
-					DAVINCI_MCBSP_RCR_RDATDLY(0));
-		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_XCR_REG,
-					DAVINCI_MCBSP_XCR_XFRLEN1(1) |
-					DAVINCI_MCBSP_XCR_XDATDLY(0) |
-					DAVINCI_MCBSP_XCR_XFIG);
 		break;
 	case SND_SOC_DAIFMT_I2S:
-	default:
-		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_RCR_REG,
-					DAVINCI_MCBSP_RCR_RFRLEN1(1) |
-					DAVINCI_MCBSP_RCR_RDATDLY(1));
-		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_XCR_REG,
-					DAVINCI_MCBSP_XCR_XFRLEN1(1) |
-					DAVINCI_MCBSP_XCR_XDATDLY(1) |
-					DAVINCI_MCBSP_XCR_XFIG);
+	case SND_SOC_DAIFMT_DSP_B:
+		rcr |= DAVINCI_MCBSP_RCR_RDATDLY(1);
+		xcr |= DAVINCI_MCBSP_XCR_XDATDLY(1);
 		break;
+	default:
+		printk(KERN_ERR "%s:bad format\n", __func__);
+		return -EINVAL;
 	}
-
+	davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SRGR_REG, srgr);
+	davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_PCR_REG, pcr);
+	davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_RCR_REG, rcr);
+	davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_XCR_REG, xcr);
 	return 0;
 }
 
@@ -343,12 +334,10 @@ static int davinci_i2s_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	i = hw_param_interval(params, SNDRV_PCM_HW_PARAM_SAMPLE_BITS);
-	w = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SRGR_REG);
+	w = DAVINCI_MCBSP_SRGR_FSGM;
 	MOD_REG_BIT(w, DAVINCI_MCBSP_SRGR_FWID(snd_interval_value(i) - 1), 1);
-	davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SRGR_REG, w);
 
 	i = hw_param_interval(params, SNDRV_PCM_HW_PARAM_FRAME_BITS);
-	w = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SRGR_REG);
 	MOD_REG_BIT(w, DAVINCI_MCBSP_SRGR_FPER(snd_interval_value(i) - 1), 1);
 	davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SRGR_REG, w);
 
-- 
1.5.4.3
