From: Peter Rosin <peda@axentia.se>
Subject: [PATCH] ASoC: atmel_ssc_dai: Track playback and
 capture CMR dividers separately.
Date: Mon, 20 Oct 2014 13:45:23 +0000
Message-ID: <a541333cf46b4c61b790df927d4b315d@EMAIL.axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EMAIL.axentia.se (axentia.se [87.96.186.132])
 by alsa0.perex.cz (Postfix) with ESMTP id DDB5026149B
 for <alsa-devel@alsa-project.org>; Mon, 20 Oct 2014 15:47:16 +0200 (CEST)
Content-Language: sv-SE
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Rosin <peda@axentia.se>, Bo Shen <voice.shen@atmel.com>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav
 Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, "'alsa-devel@alsa-project.org'" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

>From 1e5621d7b9887c648d1a66238dc82d715c1e2cad Mon Sep 17 00:00:00 2001
From: Peter Rosin <peda@axentia.se>
Date: Mon, 20 Oct 2014 14:38:04 +0200
Subject: [PATCH] ASoC: atmel_ssc_dai: Track playback and capture CMR dividers
 separately.

The CMR divider register is shared by playback and capture. The SSC driver
therefore tries to enforce rules so that the needed register content do
not conflict during simultaneous playback/capture. However, the
implementation also prevents changing the register content in a
half-duplex scenario, which is needed when changing sample rates.

Thus, keep track of the desired playback and capture clock dividers
separately, and allow changing rates without closing the stream.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 sound/soc/atmel/atmel_ssc_dai.c |   31 ++++++++++++++++++++++---------
 sound/soc/atmel/atmel_ssc_dai.h |   10 ++++++----
 2 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index f403f39..fec14fb 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -277,7 +277,8 @@ static void atmel_ssc_shutdown(struct snd_pcm_substream *substream,
 		/* Reset the SSC */
 		ssc_writel(ssc_p->ssc->regs, CR, SSC_BIT(CR_SWRST));
 		/* Clear the SSC dividers */
-		ssc_p->cmr_div = ssc_p->tcmr_period = ssc_p->rcmr_period = 0;
+		ssc_p->tcmr_div = ssc_p->rcmr_div = 0;
+		ssc_p->tcmr_period = ssc_p->rcmr_period = 0;
 	}
 	spin_unlock_irq(&ssc_p->lock);
 }
@@ -304,17 +305,27 @@ static int atmel_ssc_set_dai_clkdiv(struct snd_soc_dai *cpu_dai,
 	struct atmel_ssc_info *ssc_p = &ssc_info[cpu_dai->id];
 
 	switch (div_id) {
-	case ATMEL_SSC_CMR_DIV:
+	case ATMEL_SSC_TCMR_DIV:
 		/*
 		 * The same master clock divider is used for both
 		 * transmit and receive, so if a value has already
-		 * been set, it must match this value.
+		 * been set for the other direction, it must match
+		 * this value.
 		 */
-		if (ssc_p->cmr_div == 0)
-			ssc_p->cmr_div = div;
-		else
-			if (div != ssc_p->cmr_div)
-				return -EBUSY;
+		if (ssc_p->rcmr_div == 0)
+			ssc_p->tcmr_div = div;
+		else if (div != ssc_p->rcmr_div)
+			return -EBUSY;
+		break;
+
+	case ATMEL_SSC_RCMR_DIV:
+		/*
+		 * See ATMEL_SSC_TCMR_DIV.
+		 */
+		if (ssc_p->tcmr_div == 0)
+			ssc_p->rcmr_div = div;
+		else if (div != ssc_p->tcmr_div)
+			return -EBUSY;
 		break;
 
 	case ATMEL_SSC_TCMR_PERIOD:
@@ -345,6 +356,7 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 	struct atmel_pcm_dma_params *dma_params;
 	int dir, channels, bits;
 	u32 tfmr, rfmr, tcmr, rcmr;
+	u16 cmr;
 	int start_event;
 	int ret;
 	int fslen, fslen_ext;
@@ -626,7 +638,8 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	/* set SSC clock mode register */
-	ssc_writel(ssc_p->ssc->regs, CMR, ssc_p->cmr_div);
+	cmr = ssc_p->tcmr_div ? ssc_p->tcmr_div : ssc_p->rcmr_div;
+	ssc_writel(ssc_p->ssc->regs, CMR, cmr);
 
 	/* set receive clock mode and format */
 	ssc_writel(ssc_p->ssc->regs, RCMR, rcmr);
diff --git a/sound/soc/atmel/atmel_ssc_dai.h b/sound/soc/atmel/atmel_ssc_dai.h
index b1f08d5..a25df7a 100644
--- a/sound/soc/atmel/atmel_ssc_dai.h
+++ b/sound/soc/atmel/atmel_ssc_dai.h
@@ -39,9 +39,10 @@
 #define ATMEL_SYSCLK_MCK	0 /* SSC uses AT91 MCK as system clock */
 
 /* SSC divider ids */
-#define ATMEL_SSC_CMR_DIV	0 /* MCK divider for BCLK */
-#define ATMEL_SSC_TCMR_PERIOD	1 /* BCLK divider for transmit FS */
-#define ATMEL_SSC_RCMR_PERIOD	2 /* BCLK divider for receive FS */
+#define ATMEL_SSC_TCMR_DIV	0 /* MCK divider for transmit BCLK */
+#define ATMEL_SSC_RCMR_DIV	1 /* MCK divider for receive BCLK */
+#define ATMEL_SSC_TCMR_PERIOD	2 /* BCLK divider for transmit FS */
+#define ATMEL_SSC_RCMR_PERIOD	3 /* BCLK divider for receive FS */
 /*
  * SSC direction masks
  */
@@ -110,7 +111,8 @@ struct atmel_ssc_info {
 	unsigned short dir_mask;	/* 0=unused, 1=playback, 2=capture */
 	unsigned short initialized;	/* true if SSC has been initialized */
 	unsigned short daifmt;
-	unsigned short cmr_div;
+	unsigned short tcmr_div;
+	unsigned short rcmr_div;
 	unsigned short tcmr_period;
 	unsigned short rcmr_period;
 	struct atmel_pcm_dma_params *dma_params[2];
-- 
1.7.10.4
