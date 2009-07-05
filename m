From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: [PATCH V1 02/11] ASoC: DaVinci: i2s toggle clock to
	complete reset
Date: Sat,  4 Jul 2009 19:29:52 -0700
Message-ID: <1246761001-21982-3-git-send-email-troy.kisky@boundarydevices.com>
References: <1246761001-21982-1-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-2-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mpls-qmqp-01.inet.qwest.net (mpls-qmqp-01.inet.qwest.net
	[63.231.195.112])
	by alsa0.perex.cz (Postfix) with ESMTP id 3ED06103820
	for <alsa-devel@alsa-project.org>;
	Sun,  5 Jul 2009 04:30:04 +0200 (CEST)
In-Reply-To: <1246761001-21982-2-git-send-email-troy.kisky@boundarydevices.com>
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

Add toggle_clock function to complete i2s reset earlier.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
 sound/soc/davinci/davinci-i2s.c |   31 +++++++++++++++++++++++++------
 1 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/davinci/davinci-i2s.c
index bf5ec4b..dd44167 100644
--- a/sound/soc/davinci/davinci-i2s.c
+++ b/sound/soc/davinci/davinci-i2s.c
@@ -104,6 +104,7 @@ static struct davinci_pcm_dma_params davinci_i2s_pcm_in = {
 
 struct davinci_mcbsp_dev {
 	void __iomem			*base;
+	u32				pcr;
 	struct clk			*clk;
 	struct davinci_pcm_dma_params	*dma_params[2];
 };
@@ -119,17 +120,34 @@ static inline u32 davinci_mcbsp_read_reg(struct davinci_mcbsp_dev *dev, int reg)
 	return __raw_readl(dev->base + reg);
 }
 
+static void toggle_clock(struct davinci_mcbsp_dev *dev, int playback)
+{
+	u32 m = playback ? DAVINCI_MCBSP_PCR_CLKXP : DAVINCI_MCBSP_PCR_CLKRP;
+	/* The clock needs to toggle to complete reset.
+	 * So, fake it by toggling the clk polarity.
+	 */
+	davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_PCR_REG, dev->pcr ^ m);
+	davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_PCR_REG, dev->pcr);
+}
+
 static void davinci_mcbsp_start(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct davinci_mcbsp_dev *dev = rtd->dai->cpu_dai->private_data;
 	struct snd_soc_device *socdev = rtd->socdev;
 	struct snd_soc_platform *platform = socdev->card->platform;
+	int playback = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
 	u32 spcr;
 	int ret;
-
-	/* Start the sample generator and enable transmitter/receiver */
+	u32 mask = playback ? DAVINCI_MCBSP_SPCR_XRST : DAVINCI_MCBSP_SPCR_RRST;
 	spcr = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
+	if (spcr & mask) {
+		/* start off disabled */
+		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG,
+				spcr & ~mask);
+		toggle_clock(dev, playback);
+	}
+	/* Start the sample generator and enable transmitter/receiver */
 	spcr |= DAVINCI_MCBSP_SPCR_GRST;
 	davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, spcr);
 
@@ -155,6 +173,7 @@ static void davinci_mcbsp_start(struct snd_pcm_substream *substream)
 		spcr = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
 		spcr &= ~DAVINCI_MCBSP_SPCR_XRST;
 		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, spcr);
+		toggle_clock(dev, playback);
 
 		/* Restart the DMA */
 		if (platform->pcm_ops->trigger) {
@@ -188,15 +207,14 @@ static void davinci_mcbsp_stop(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct davinci_mcbsp_dev *dev = rtd->dai->cpu_dai->private_data;
 	u32 spcr;
+	int playback = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
 
 	/* Reset transmitter/receiver and sample rate/frame sync generators */
 	spcr = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
 	spcr &= ~(DAVINCI_MCBSP_SPCR_GRST | DAVINCI_MCBSP_SPCR_FRST);
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		spcr &= ~DAVINCI_MCBSP_SPCR_XRST;
-	else
-		spcr &= ~DAVINCI_MCBSP_SPCR_RRST;
+	spcr &= playback ? ~DAVINCI_MCBSP_SPCR_XRST : ~DAVINCI_MCBSP_SPCR_RRST;
 	davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, spcr);
+	toggle_clock(dev, playback);
 }
 
 static int davinci_i2s_startup(struct snd_pcm_substream *substream,
@@ -334,6 +352,7 @@ static int davinci_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		return -EINVAL;
 	}
 	davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SRGR_REG, srgr);
+	dev->pcr = pcr;
 	davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_PCR_REG, pcr);
 	davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_RCR_REG, rcr);
 	davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_XCR_REG, xcr);
-- 
1.5.6.3
