From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: [PATCH V1 07/11] ASoC: DaVinci: i2s,
	fix mcbsp_word_length update
Date: Sat,  4 Jul 2009 19:29:57 -0700
Message-ID: <1246761001-21982-8-git-send-email-troy.kisky@boundarydevices.com>
References: <1246761001-21982-1-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-2-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-3-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-4-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-5-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-6-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-7-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mpls-qmqp-03.inet.qwest.net (mpls-qmqp-03.inet.qwest.net
	[63.231.195.114])
	by alsa0.perex.cz (Postfix) with ESMTP id 4B909103820
	for <alsa-devel@alsa-project.org>;
	Sun,  5 Jul 2009 04:30:12 +0200 (CEST)
In-Reply-To: <1246761001-21982-7-git-send-email-troy.kisky@boundarydevices.com>
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

Code previously just "ors" in this field without clearing
first. Fix, by never reading this register.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
 sound/soc/davinci/davinci-i2s.c |   50 ++++++++++++++++++++++----------------
 1 files changed, 29 insertions(+), 21 deletions(-)

diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/davinci/davinci-i2s.c
index 5b31b56..6fa1b6a 100644
--- a/sound/soc/davinci/davinci-i2s.c
+++ b/sound/soc/davinci/davinci-i2s.c
@@ -63,6 +63,7 @@
 #define DAVINCI_MCBSP_RCR_RWDLEN1(v)	((v) << 5)
 #define DAVINCI_MCBSP_RCR_RFRLEN1(v)	((v) << 8)
 #define DAVINCI_MCBSP_RCR_RDATDLY(v)	((v) << 16)
+#define DAVINCI_MCBSP_RCR_RFIG		(1 << 18)
 #define DAVINCI_MCBSP_RCR_RWDLEN2(v)	((v) << 21)
 
 #define DAVINCI_MCBSP_XCR_XWDLEN1(v)	((v) << 5)
@@ -104,6 +105,9 @@ static struct davinci_pcm_dma_params davinci_i2s_pcm_in = {
 
 struct davinci_mcbsp_dev {
 	void __iomem			*base;
+#define MOD_DSP_A	0
+#define MOD_DSP_B	1
+	int				mode;
 	u32				pcr;
 	struct clk			*clk;
 	struct davinci_pcm_dma_params	*dma_params[2];
@@ -225,12 +229,11 @@ static int davinci_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 	struct davinci_mcbsp_dev *dev = cpu_dai->private_data;
 	unsigned int pcr;
 	unsigned int srgr;
-	unsigned int rcr;
-	unsigned int xcr;
 	srgr = DAVINCI_MCBSP_SRGR_FSGM |
 		DAVINCI_MCBSP_SRGR_FPER(DEFAULT_BITPERSAMPLE * 2 - 1) |
 		DAVINCI_MCBSP_SRGR_FWID(DEFAULT_BITPERSAMPLE - 1);
 
+	/* set master/slave audio interface */
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBS_CFS:
 		/* cpu is master */
@@ -255,11 +258,8 @@ static int davinci_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		return -EINVAL;
 	}
 
-	rcr = DAVINCI_MCBSP_RCR_RFRLEN1(1);
-	xcr = DAVINCI_MCBSP_XCR_XFIG | DAVINCI_MCBSP_XCR_XFRLEN1(1);
+	/* interface format */
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
-	case SND_SOC_DAIFMT_DSP_B:
-		break;
 	case SND_SOC_DAIFMT_I2S:
 		/* Davinci doesn't support TRUE I2S, but some codecs will have
 		 * the left and right channels contiguous. This allows
@@ -279,8 +279,10 @@ static int davinci_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		 */
 		fmt ^= SND_SOC_DAIFMT_NB_IF;
 	case SND_SOC_DAIFMT_DSP_A:
-		rcr |= DAVINCI_MCBSP_RCR_RDATDLY(1);
-		xcr |= DAVINCI_MCBSP_XCR_XDATDLY(1);
+		dev->mode = MOD_DSP_A;
+		break;
+	case SND_SOC_DAIFMT_DSP_B:
+		dev->mode = MOD_DSP_B;
 		break;
 	default:
 		printk(KERN_ERR "%s:bad format\n", __func__);
@@ -342,8 +344,6 @@ static int davinci_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 	davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SRGR_REG, srgr);
 	dev->pcr = pcr;
 	davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_PCR_REG, pcr);
-	davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_RCR_REG, rcr);
-	davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_XCR_REG, xcr);
 	return 0;
 }
 
@@ -377,6 +377,15 @@ static int davinci_i2s_hw_params(struct snd_pcm_substream *substream,
 	srgr |= DAVINCI_MCBSP_SRGR_FPER(snd_interval_value(i) - 1);
 	davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SRGR_REG, srgr);
 
+	rcr = DAVINCI_MCBSP_RCR_RFIG;
+	xcr = DAVINCI_MCBSP_XCR_XFIG;
+	if (dev->mode == MOD_DSP_B) {
+		rcr |= DAVINCI_MCBSP_RCR_RDATDLY(0);
+		xcr |= DAVINCI_MCBSP_XCR_XDATDLY(0);
+	} else {
+		rcr |= DAVINCI_MCBSP_RCR_RDATDLY(1);
+		xcr |= DAVINCI_MCBSP_XCR_XDATDLY(1);
+	}
 	/* Determine xfer data type */
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S8:
@@ -396,19 +405,18 @@ static int davinci_i2s_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
-		rcr = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_RCR_REG);
-		rcr |= DAVINCI_MCBSP_RCR_RWDLEN1(mcbsp_word_length) |
-			       DAVINCI_MCBSP_RCR_RWDLEN2(mcbsp_word_length);
-		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_RCR_REG, rcr);
+	rcr |= DAVINCI_MCBSP_RCR_RFRLEN1(1);
+	xcr |= DAVINCI_MCBSP_XCR_XFRLEN1(1);
 
-	} else {
-		xcr = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_XCR_REG);
-		xcr |= DAVINCI_MCBSP_XCR_XWDLEN1(mcbsp_word_length) |
-				DAVINCI_MCBSP_XCR_XWDLEN2(mcbsp_word_length);
-		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_XCR_REG, xcr);
+	rcr |= DAVINCI_MCBSP_RCR_RWDLEN1(mcbsp_word_length) |
+		DAVINCI_MCBSP_RCR_RWDLEN2(mcbsp_word_length);
+	xcr |= DAVINCI_MCBSP_XCR_XWDLEN1(mcbsp_word_length) |
+		DAVINCI_MCBSP_XCR_XWDLEN2(mcbsp_word_length);
 
-	}
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_XCR_REG, xcr);
+	else
+		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_RCR_REG, rcr);
 	return 0;
 }
 
-- 
1.5.6.3
