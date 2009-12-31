From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 3/5] ASoC: tlv320dac33: Clean up the hardware
	configuration code
Date: Thu, 31 Dec 2009 10:30:21 +0200
Message-ID: <1262248223-9335-4-git-send-email-peter.ujfalusi@nokia.com>
References: <1262248223-9335-1-git-send-email-peter.ujfalusi@nokia.com>
	<1262248223-9335-2-git-send-email-peter.ujfalusi@nokia.com>
	<1262248223-9335-3-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 7AD821038A3
	for <alsa-devel@alsa-project.org>; Thu, 31 Dec 2009 09:31:40 +0100 (CET)
In-Reply-To: <1262248223-9335-3-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Use switch instead of if statements to configure FIFO bypass
and mode1.
With this change adding new FIFO mode is going to be easier,
and cleaner.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/tlv320dac33.c |   61 +++++++++++++++++++++++++++++----------
 1 files changed, 45 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index f7c7bbc..c684aa2 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -707,7 +707,7 @@ static int dac33_prepare_chip(struct snd_pcm_substream *substream)
 	struct snd_soc_codec *codec = socdev->card->codec;
 	struct tlv320dac33_priv *dac33 = codec->private_data;
 	unsigned int oscset, ratioset, pwr_ctrl, reg_tmp;
-	u8 aictrl_a, fifoctrl_a;
+	u8 aictrl_a, aictrl_b, fifoctrl_a;
 
 	switch (substream->runtime->rate) {
 	case 44100:
@@ -764,6 +764,7 @@ static int dac33_prepare_chip(struct snd_pcm_substream *substream)
 	dac33_oscwait(codec);
 
 	if (dac33->fifo_mode) {
+		/* Generic for all FIFO modes */
 		/* 50-51 : ASRC Control registers */
 		dac33_write(codec, DAC33_ASRC_CTRL_A, (1 << 4)); /* div=2 */
 		dac33_write(codec, DAC33_ASRC_CTRL_B, 1); /* ??? */
@@ -773,38 +774,66 @@ static int dac33_prepare_chip(struct snd_pcm_substream *substream)
 
 		/* Set interrupts to high active */
 		dac33_write(codec, DAC33_INTP_CTRL_A, DAC33_INTPM_AHIGH);
-
-		dac33_write(codec, DAC33_FIFO_IRQ_MODE_B,
-			    DAC33_ATM(DAC33_FIFO_IRQ_MODE_LEVEL));
-		dac33_write(codec, DAC33_FIFO_IRQ_MASK, DAC33_MAT);
 	} else {
+		/* FIFO bypass mode */
 		/* 50-51 : ASRC Control registers */
 		dac33_write(codec, DAC33_ASRC_CTRL_A, DAC33_SRCBYP);
 		dac33_write(codec, DAC33_ASRC_CTRL_B, 0); /* ??? */
 	}
 
-	if (dac33->fifo_mode)
+	/* Interrupt behaviour configuration */
+	switch (dac33->fifo_mode) {
+	case DAC33_FIFO_MODE1:
+		dac33_write(codec, DAC33_FIFO_IRQ_MODE_B,
+			    DAC33_ATM(DAC33_FIFO_IRQ_MODE_LEVEL));
+		dac33_write(codec, DAC33_FIFO_IRQ_MASK, DAC33_MAT);
+		break;
+	default:
+		/* in FIFO bypass mode, the interrupts are not used */
+		break;
+	}
+
+	aictrl_b = dac33_read_reg_cache(codec, DAC33_SER_AUDIOIF_CTRL_B);
+
+	switch (dac33->fifo_mode) {
+	case DAC33_FIFO_MODE1:
+		/*
+		 * For mode1:
+		 * Disable the FIFO bypass (Enable the use of FIFO)
+		 * Select nSample mode
+		 * BCLK is only running when data is needed by DAC33
+		 */
 		fifoctrl_a &= ~DAC33_FBYPAS;
-	else
+		fifoctrl_a &= ~DAC33_FAUTO;
+		aictrl_b &= ~DAC33_BCLKON;
+		break;
+	default:
+		/*
+		 * For FIFO bypass mode:
+		 * Enable the FIFO bypass (Disable the FIFO use)
+		 * Set the BCLK as continous
+		 */
 		fifoctrl_a |= DAC33_FBYPAS;
-	dac33_write(codec, DAC33_FIFO_CTRL_A, fifoctrl_a);
+		aictrl_b |= DAC33_BCLKON;
+		break;
+	}
 
+	dac33_write(codec, DAC33_FIFO_CTRL_A, fifoctrl_a);
 	dac33_write(codec, DAC33_SER_AUDIOIF_CTRL_A, aictrl_a);
-	reg_tmp = dac33_read_reg_cache(codec, DAC33_SER_AUDIOIF_CTRL_B);
-	if (dac33->fifo_mode)
-		reg_tmp &= ~DAC33_BCLKON;
-	else
-		reg_tmp |= DAC33_BCLKON;
-	dac33_write(codec, DAC33_SER_AUDIOIF_CTRL_B, reg_tmp);
+	dac33_write(codec, DAC33_SER_AUDIOIF_CTRL_B, aictrl_b);
 
-	if (dac33->fifo_mode) {
+	switch (dac33->fifo_mode) {
+	case DAC33_FIFO_MODE1:
 		/* 20: BCLK divide ratio */
 		dac33_write(codec, DAC33_SER_AUDIOIF_CTRL_C, 3);
 
 		dac33_write16(codec, DAC33_ATHR_MSB,
 			      DAC33_THRREG(dac33->alarm_threshold));
-	} else {
+		break;
+	default:
+		/* BYPASS mode */
 		dac33_write(codec, DAC33_SER_AUDIOIF_CTRL_C, 32);
+		break;
 	}
 
 	mutex_unlock(&dac33->mutex);
-- 
1.6.6
