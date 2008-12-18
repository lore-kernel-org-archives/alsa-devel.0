From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: [PATCH 3/8] ALSA: ASoC: DaVinci: davinci-i2s add
	comments to explain polarity
Date: Thu, 18 Dec 2008 12:36:41 -0700
Message-ID: <1229629006-4261-4-git-send-email-troy.kisky@boundarydevices.com>
References: <>
	<1229629006-4261-1-git-send-email-troy.kisky@boundarydevices.com>
	<1229629006-4261-2-git-send-email-troy.kisky@boundarydevices.com>
	<1229629006-4261-3-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mpls-qmqp-04.inet.qwest.net (mpls-qmqp-04.inet.qwest.net
	[63.231.195.115])
	by alsa0.perex.cz (Postfix) with ESMTP id 05754244C1
	for <alsa-devel@alsa-project.org>; Thu, 18 Dec 2008 20:36:53 +0100 (CET)
In-Reply-To: <1229629006-4261-3-git-send-email-troy.kisky@boundarydevices.com>
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

Document the current polarity choices.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>

diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/davinci/davinci-i2s.c
index cf31b3b..ecb5e83 100644
--- a/sound/soc/davinci/davinci-i2s.c
+++ b/sound/soc/davinci/davinci-i2s.c
@@ -235,18 +235,45 @@ static int davinci_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 
 	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
 	case SND_SOC_DAIFMT_IB_NF:
+		/* CLKRP Receive clock polarity,
+		 *	1 - sampled on rising edge of CLKR
+		 *	valid on rising edge
+		 * CLKXP Transmit clock polarity,
+		 *	1 - clocked on falling edge of CLKX
+		 *	valid on rising edge
+		 * FSRP  Receive frame sync pol, 0 - active high
+		 * FSXP  Transmit frame sync pol, 0 - active high
+		 */
 		w = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_PCR_REG);
 		MOD_REG_BIT(w, DAVINCI_MCBSP_PCR_CLKXP |
 			       DAVINCI_MCBSP_PCR_CLKRP, 1);
 		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_PCR_REG, w);
 		break;
 	case SND_SOC_DAIFMT_NB_IF:
+		/* CLKRP Receive clock polarity,
+		 *	0 - sampled on falling edge of CLKR
+		 *	valid on falling edge
+		 * CLKXP Transmit clock polarity,
+		 *	0 - clocked on rising edge of CLKX
+		 *	valid on falling edge
+		 * FSRP  Receive frame sync pol, 1 - active low
+		 * FSXP  Transmit frame sync pol, 1 - active low
+		 */
 		w = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_PCR_REG);
 		MOD_REG_BIT(w, DAVINCI_MCBSP_PCR_FSXP |
 			       DAVINCI_MCBSP_PCR_FSRP, 1);
 		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_PCR_REG, w);
 		break;
 	case SND_SOC_DAIFMT_IB_IF:
+		/* CLKRP Receive clock polarity,
+		 *	1 - sampled on rising edge of CLKR
+		 *	valid on rising edge
+		 * CLKXP Transmit clock polarity,
+		 *	1 - clocked on falling edge of CLKX
+		 *	valid on rising edge
+		 * FSRP  Receive frame sync pol, 1 - active low
+		 * FSXP  Transmit frame sync pol, 1 - active low
+		 */
 		w = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_PCR_REG);
 		MOD_REG_BIT(w, DAVINCI_MCBSP_PCR_CLKXP |
 			       DAVINCI_MCBSP_PCR_CLKRP |
@@ -255,6 +282,15 @@ static int davinci_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_PCR_REG, w);
 		break;
 	case SND_SOC_DAIFMT_NB_NF:
+		/* CLKRP Receive clock polarity,
+		 *	0 - sampled on falling edge of CLKR
+		 *	valid on falling edge
+		 * CLKXP Transmit clock polarity,
+		 *	0 - clocked on rising edge of CLKX
+		 *	valid on falling edge
+		 * FSRP  Receive frame sync pol, 0 - active high
+		 * FSXP  Transmit frame sync pol, 0 - active high
+		 */
 		break;
 	default:
 		return -EINVAL;
-- 
1.5.4.3
