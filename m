From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 2/3] ASoC: tlv320dac33: Some cleanup for 32/24
	bit support
Date: Wed, 22 Dec 2010 10:45:17 +0200
Message-ID: <1293007518-3870-3-git-send-email-peter.ujfalusi@nokia.com>
References: <1293007518-3870-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da01.nokia.com (smtp.nokia.com [147.243.128.24])
	by alsa0.perex.cz (Postfix) with ESMTP id ACD66103880
	for <alsa-devel@alsa-project.org>; Wed, 22 Dec 2010 09:45:21 +0100 (CET)
In-Reply-To: <1293007518-3870-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Change the structure of FIFO handling in order to
pave the way for adding 32/24 bit audio support.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/tlv320dac33.c |   47 +++++++++++++++++++++++-----------------
 1 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index c574ae2..05a4e9f 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -42,12 +42,15 @@
 #include <sound/tlv320dac33-plat.h>
 #include "tlv320dac33.h"
 
-#define DAC33_BUFFER_SIZE_BYTES		24576	/* bytes, 12288 16 bit words,
-						 * 6144 stereo */
-#define DAC33_BUFFER_SIZE_SAMPLES	6144
-
-#define MODE7_LTHR		10
-#define MODE7_UTHR		(DAC33_BUFFER_SIZE_SAMPLES - 10)
+/*
+ * The internal FIFO is 24576 bytes long
+ * It can be configured to hold 16bit or 24bit samples
+ * In 16bit configuration the FIFO can hold 6144 stereo samples
+ * In 24bit configuration the FIFO can hold 4096 stereo samples
+ */
+#define DAC33_FIFO_SIZE_16BIT	6144
+#define DAC33_FIFO_SIZE_24BIT	4096
+#define DAC33_MODE7_MARGIN	10	/* Safety margin for FIFO in Mode7 */
 
 #define BURST_BASEFREQ_HZ	49152000
 
@@ -98,6 +101,7 @@ struct tlv320dac33_priv {
 
 	unsigned int alarm_threshold;	/* set to be half of LATENCY_TIME_MS */
 	enum dac33_fifo_modes fifo_mode;/* FIFO mode selection */
+	unsigned int fifo_size;		/* Size of the FIFO in samples */
 	unsigned int nsample;		/* burst read amount from host */
 	int mode1_latency;		/* latency caused by the i2c writes in
 					 * us */
@@ -650,7 +654,7 @@ static inline void dac33_prefill_handler(struct tlv320dac33_priv *dac33)
 		spin_unlock_irq(&dac33->lock);
 
 		dac33_write16(codec, DAC33_PREFILL_MSB,
-				DAC33_THRREG(MODE7_LTHR));
+				DAC33_THRREG(DAC33_MODE7_MARGIN));
 
 		/* Enable Upper Threshold IRQ */
 		dac33_write(codec, DAC33_FIFO_IRQ_MASK, DAC33_MUT);
@@ -773,12 +777,15 @@ static void dac33_shutdown(struct snd_pcm_substream *substream,
 	dac33->substream = NULL;
 }
 
+#define CALC_BURST_RATE(bclkdiv, bclk_per_sample) \
+	(BURST_BASEFREQ_HZ / bclkdiv / bclk_per_sample)
 static int dac33_hw_params(struct snd_pcm_substream *substream,
 			   struct snd_pcm_hw_params *params,
 			   struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_codec *codec = rtd->codec;
+	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
 
 	/* Check parameters for validity */
 	switch (params_rate(params)) {
@@ -793,6 +800,8 @@ static int dac33_hw_params(struct snd_pcm_substream *substream,
 
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S16_LE:
+		dac33->fifo_size = DAC33_FIFO_SIZE_16BIT;
+		dac33->burst_rate = CALC_BURST_RATE(dac33->burst_bclkdiv, 32);
 		break;
 	default:
 		dev_err(codec->dev, "unsupported format %d\n",
@@ -994,7 +1003,8 @@ static int dac33_prepare_chip(struct snd_pcm_substream *substream)
 		 * at the bottom, and also at the top of the FIFO
 		 */
 		dac33_write16(codec, DAC33_UTHR_MSB, DAC33_THRREG(dac33->uthr));
-		dac33_write16(codec, DAC33_LTHR_MSB, DAC33_THRREG(MODE7_LTHR));
+		dac33_write16(codec, DAC33_LTHR_MSB,
+			      DAC33_THRREG(DAC33_MODE7_MARGIN));
 		break;
 	default:
 		break;
@@ -1023,8 +1033,7 @@ static void dac33_calculate_times(struct snd_pcm_substream *substream)
 		/* Number of samples under i2c latency */
 		dac33->alarm_threshold = US_TO_SAMPLES(rate,
 						dac33->mode1_latency);
-		nsample_limit = DAC33_BUFFER_SIZE_SAMPLES -
-				dac33->alarm_threshold;
+		nsample_limit = dac33->fifo_size - dac33->alarm_threshold;
 
 		if (period_size <= dac33->alarm_threshold)
 			/*
@@ -1048,14 +1057,14 @@ static void dac33_calculate_times(struct snd_pcm_substream *substream)
 	case DAC33_FIFO_MODE7:
 		dac33->uthr = UTHR_FROM_PERIOD_SIZE(period_size, rate,
 						    dac33->burst_rate) + 9;
-		if (dac33->uthr > MODE7_UTHR)
-			dac33->uthr = MODE7_UTHR;
-		if (dac33->uthr < (MODE7_LTHR + 10))
-			dac33->uthr = (MODE7_LTHR + 10);
+		if (dac33->uthr > (dac33->fifo_size - DAC33_MODE7_MARGIN))
+			dac33->uthr = dac33->fifo_size - DAC33_MODE7_MARGIN;
+		if (dac33->uthr < (DAC33_MODE7_MARGIN + 10))
+			dac33->uthr = (DAC33_MODE7_MARGIN + 10);
 
 		dac33->mode7_us_to_lthr =
 				SAMPLES_TO_US(substream->runtime->rate,
-					dac33->uthr - MODE7_LTHR + 1);
+					dac33->uthr - DAC33_MODE7_MARGIN + 1);
 		dac33->t_stamp1 = 0;
 		break;
 	default:
@@ -1173,8 +1182,8 @@ static snd_pcm_sframes_t dac33_dai_delay(
 			samples += (samples_in - samples_out);
 
 			if (likely(samples > 0))
-				delay = samples > DAC33_BUFFER_SIZE_SAMPLES ?
-					DAC33_BUFFER_SIZE_SAMPLES : samples;
+				delay = samples > dac33->fifo_size ?
+					dac33->fifo_size : samples;
 			else
 				delay = 0;
 		}
@@ -1226,7 +1235,7 @@ static snd_pcm_sframes_t dac33_dai_delay(
 			samples_in = US_TO_SAMPLES(
 					dac33->burst_rate,
 					time_delta);
-			delay = MODE7_LTHR + samples_in - samples_out;
+			delay = DAC33_MODE7_MARGIN + samples_in - samples_out;
 
 			if (unlikely(delay > uthr))
 				delay = uthr;
@@ -1477,8 +1486,6 @@ static int __devinit dac33_i2c_probe(struct i2c_client *client,
 
 	dac33->power_gpio = pdata->power_gpio;
 	dac33->burst_bclkdiv = pdata->burst_bclkdiv;
-	/* Pre calculate the burst rate */
-	dac33->burst_rate = BURST_BASEFREQ_HZ / dac33->burst_bclkdiv / 32;
 	dac33->keep_bclk = pdata->keep_bclk;
 	dac33->mode1_latency = pdata->mode1_latency;
 	if (!dac33->mode1_latency)
-- 
1.7.3.4
