From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: [PATCH V1 01/11] ASoC: DaVinci: i2s,
	remove MOD_REG_BIT macro
Date: Sat,  4 Jul 2009 19:29:51 -0700
Message-ID: <1246761001-21982-2-git-send-email-troy.kisky@boundarydevices.com>
References: <1246761001-21982-1-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mpls-qmqp-04.inet.qwest.net (mpls-qmqp-04.inet.qwest.net
	[63.231.195.115])
	by alsa0.perex.cz (Postfix) with ESMTP id 3A5A110380C
	for <alsa-devel@alsa-project.org>;
	Sun,  5 Jul 2009 04:30:04 +0200 (CEST)
In-Reply-To: <1246761001-21982-1-git-send-email-troy.kisky@boundarydevices.com>
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

No functional changes. Rename variable w to something
more meaningful. Remove code obfuscating macro MOD_REG_BIT.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
 sound/soc/davinci/davinci-i2s.c |   96 ++++++++++++++++++---------------------
 1 files changed, 44 insertions(+), 52 deletions(-)

diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/davinci/davinci-i2s.c
index b1ea52f..bf5ec4b 100644
--- a/sound/soc/davinci/davinci-i2s.c
+++ b/sound/soc/davinci/davinci-i2s.c
@@ -85,14 +85,6 @@
 #define DAVINCI_MCBSP_PCR_FSRM		(1 << 10)
 #define DAVINCI_MCBSP_PCR_FSXM		(1 << 11)
 
-#define MOD_REG_BIT(val, mask, set) do { \
-	if (set) { \
-		val |= mask; \
-	} else { \
-		val &= ~mask; \
-	} \
-} while (0)
-
 enum {
 	DAVINCI_MCBSP_WORD_8 = 0,
 	DAVINCI_MCBSP_WORD_12,
@@ -133,13 +125,13 @@ static void davinci_mcbsp_start(struct snd_pcm_substream *substream)
 	struct davinci_mcbsp_dev *dev = rtd->dai->cpu_dai->private_data;
 	struct snd_soc_device *socdev = rtd->socdev;
 	struct snd_soc_platform *platform = socdev->card->platform;
-	u32 w;
+	u32 spcr;
 	int ret;
 
 	/* Start the sample generator and enable transmitter/receiver */
-	w = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
-	MOD_REG_BIT(w, DAVINCI_MCBSP_SPCR_GRST, 1);
-	davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, w);
+	spcr = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
+	spcr |= DAVINCI_MCBSP_SPCR_GRST;
+	davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, spcr);
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		/* Stop the DMA to avoid data loss */
@@ -152,17 +144,17 @@ static void davinci_mcbsp_start(struct snd_pcm_substream *substream)
 		}
 
 		/* Enable the transmitter */
-		w = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
-		MOD_REG_BIT(w, DAVINCI_MCBSP_SPCR_XRST, 1);
-		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, w);
+		spcr = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
+		spcr |= DAVINCI_MCBSP_SPCR_XRST;
+		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, spcr);
 
 		/* wait for any unexpected frame sync error to occur */
 		udelay(100);
 
 		/* Disable the transmitter to clear any outstanding XSYNCERR */
-		w = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
-		MOD_REG_BIT(w, DAVINCI_MCBSP_SPCR_XRST, 0);
-		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, w);
+		spcr = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
+		spcr &= ~DAVINCI_MCBSP_SPCR_XRST;
+		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, spcr);
 
 		/* Restart the DMA */
 		if (platform->pcm_ops->trigger) {
@@ -172,40 +164,39 @@ static void davinci_mcbsp_start(struct snd_pcm_substream *substream)
 				printk(KERN_DEBUG "Playback DMA start failed\n");
 		}
 		/* Enable the transmitter */
-		w = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
-		MOD_REG_BIT(w, DAVINCI_MCBSP_SPCR_XRST, 1);
-		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, w);
+		spcr = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
+		spcr |= DAVINCI_MCBSP_SPCR_XRST;
+		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, spcr);
 
 	} else {
 
 		/* Enable the reciever */
-		w = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
-		MOD_REG_BIT(w, DAVINCI_MCBSP_SPCR_RRST, 1);
-		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, w);
+		spcr = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
+		spcr |= DAVINCI_MCBSP_SPCR_RRST;
+		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, spcr);
 	}
 
 
 	/* Start frame sync */
-	w = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
-	MOD_REG_BIT(w, DAVINCI_MCBSP_SPCR_FRST, 1);
-	davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, w);
+	spcr = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
+	spcr |= DAVINCI_MCBSP_SPCR_FRST;
+	davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, spcr);
 }
 
 static void davinci_mcbsp_stop(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct davinci_mcbsp_dev *dev = rtd->dai->cpu_dai->private_data;
-	u32 w;
+	u32 spcr;
 
 	/* Reset transmitter/receiver and sample rate/frame sync generators */
-	w = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
-	MOD_REG_BIT(w, DAVINCI_MCBSP_SPCR_GRST |
-		       DAVINCI_MCBSP_SPCR_FRST, 0);
+	spcr = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
+	spcr &= ~(DAVINCI_MCBSP_SPCR_GRST | DAVINCI_MCBSP_SPCR_FRST);
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		MOD_REG_BIT(w, DAVINCI_MCBSP_SPCR_XRST, 0);
+		spcr &= ~DAVINCI_MCBSP_SPCR_XRST;
 	else
-		MOD_REG_BIT(w, DAVINCI_MCBSP_SPCR_RRST, 0);
-	davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, w);
+		spcr &= ~DAVINCI_MCBSP_SPCR_RRST;
+	davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, spcr);
 }
 
 static int davinci_i2s_startup(struct snd_pcm_substream *substream,
@@ -358,25 +349,26 @@ static int davinci_i2s_hw_params(struct snd_pcm_substream *substream,
 	struct davinci_mcbsp_dev *dev = rtd->dai->cpu_dai->private_data;
 	struct snd_interval *i = NULL;
 	int mcbsp_word_length;
-	u32 w;
+	unsigned int rcr, xcr, srgr;
+	u32 spcr;
 
 	/* general line settings */
-	w = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
+	spcr = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
 	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
-		w |= DAVINCI_MCBSP_SPCR_RINTM(3) | DAVINCI_MCBSP_SPCR_FREE;
-		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, w);
+		spcr |= DAVINCI_MCBSP_SPCR_RINTM(3) | DAVINCI_MCBSP_SPCR_FREE;
+		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, spcr);
 	} else {
-		w |= DAVINCI_MCBSP_SPCR_XINTM(3) | DAVINCI_MCBSP_SPCR_FREE;
-		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, w);
+		spcr |= DAVINCI_MCBSP_SPCR_XINTM(3) | DAVINCI_MCBSP_SPCR_FREE;
+		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, spcr);
 	}
 
 	i = hw_param_interval(params, SNDRV_PCM_HW_PARAM_SAMPLE_BITS);
-	w = DAVINCI_MCBSP_SRGR_FSGM;
-	MOD_REG_BIT(w, DAVINCI_MCBSP_SRGR_FWID(snd_interval_value(i) - 1), 1);
+	srgr = DAVINCI_MCBSP_SRGR_FSGM;
+	srgr |= DAVINCI_MCBSP_SRGR_FWID(snd_interval_value(i) - 1);
 
 	i = hw_param_interval(params, SNDRV_PCM_HW_PARAM_FRAME_BITS);
-	MOD_REG_BIT(w, DAVINCI_MCBSP_SRGR_FPER(snd_interval_value(i) - 1), 1);
-	davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SRGR_REG, w);
+	srgr |= DAVINCI_MCBSP_SRGR_FPER(snd_interval_value(i) - 1);
+	davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SRGR_REG, srgr);
 
 	/* Determine xfer data type */
 	switch (params_format(params)) {
@@ -398,16 +390,16 @@ static int davinci_i2s_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
-		w = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_RCR_REG);
-		MOD_REG_BIT(w, DAVINCI_MCBSP_RCR_RWDLEN1(mcbsp_word_length) |
-			       DAVINCI_MCBSP_RCR_RWDLEN2(mcbsp_word_length), 1);
-		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_RCR_REG, w);
+		rcr = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_RCR_REG);
+		rcr |= DAVINCI_MCBSP_RCR_RWDLEN1(mcbsp_word_length) |
+			       DAVINCI_MCBSP_RCR_RWDLEN2(mcbsp_word_length);
+		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_RCR_REG, rcr);
 
 	} else {
-		w = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_XCR_REG);
-		MOD_REG_BIT(w, DAVINCI_MCBSP_XCR_XWDLEN1(mcbsp_word_length) |
-			       DAVINCI_MCBSP_XCR_XWDLEN2(mcbsp_word_length), 1);
-		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_XCR_REG, w);
+		xcr = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_XCR_REG);
+		xcr |= DAVINCI_MCBSP_XCR_XWDLEN1(mcbsp_word_length) |
+				DAVINCI_MCBSP_XCR_XWDLEN2(mcbsp_word_length);
+		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_XCR_REG, xcr);
 
 	}
 	return 0;
-- 
1.5.6.3
