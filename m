From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH v2 1/2] ASoC: tlv320dac33: Revisit the FIFO
	Mode1 handling
Date: Wed, 28 Jul 2010 15:26:54 +0300
Message-ID: <1280320015-16099-2-git-send-email-peter.ujfalusi@nokia.com>
References: <1280320015-16099-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id A324024418
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Jul 2010 14:27:10 +0200 (CEST)
In-Reply-To: <1280320015-16099-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Replace the hardwired latency definition with platform data
parameter, and simplify the nSample parameter calculation.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 include/sound/tlv320dac33-plat.h |    1 +
 sound/soc/codecs/tlv320dac33.c   |   71 ++++++++++++++++++--------------------
 2 files changed, 35 insertions(+), 37 deletions(-)

diff --git a/include/sound/tlv320dac33-plat.h b/include/sound/tlv320dac33-plat.h
index 3f428d5..1aa7bdb 100644
--- a/include/sound/tlv320dac33-plat.h
+++ b/include/sound/tlv320dac33-plat.h
@@ -15,6 +15,7 @@
 
 struct tlv320dac33_platform_data {
 	int power_gpio;
+	int mode1_latency; /* latency caused by the i2c writes in us */
 	int keep_bclk;	/* Keep the BCLK running in FIFO modes */
 	u8 burst_bclkdiv;
 };
diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index 2fa946c..ced6fbb 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -49,8 +49,6 @@
 
 #define NSAMPLE_MAX		5700
 
-#define LATENCY_TIME_MS		20
-
 #define MODE7_LTHR		10
 #define MODE7_UTHR		(DAC33_BUFFER_SIZE_SAMPLES - 10)
 
@@ -107,6 +105,8 @@ struct tlv320dac33_priv {
 					 * this */
 	enum dac33_fifo_modes fifo_mode;/* FIFO mode selection */
 	unsigned int nsample;		/* burst read amount from host */
+	int mode1_latency;		/* latency caused by the i2c writes in
+					 * us */
 	u8 burst_bclkdiv;		/* BCLK divider value in burst mode */
 	unsigned int burst_rate;	/* Interface speed in Burst modes */
 
@@ -649,7 +649,7 @@ static inline void dac33_prefill_handler(struct tlv320dac33_priv *dac33)
 	switch (dac33->fifo_mode) {
 	case DAC33_FIFO_MODE1:
 		dac33_write16(codec, DAC33_NSAMPLE_MSB,
-			DAC33_THRREG(dac33->nsample + dac33->alarm_threshold));
+			DAC33_THRREG(dac33->nsample));
 
 		/* Take the timestamps */
 		spin_lock_irq(&dac33->lock);
@@ -798,6 +798,10 @@ static void dac33_shutdown(struct snd_pcm_substream *substream,
 	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
 
 	dac33->substream = NULL;
+
+	/* Reset the nSample restrictions */
+	dac33->nsample_min = 0;
+	dac33->nsample_max = NSAMPLE_MAX;
 }
 
 static int dac33_hw_params(struct snd_pcm_substream *substream,
@@ -1040,48 +1044,38 @@ static void dac33_calculate_times(struct snd_pcm_substream *substream)
 	struct snd_soc_device *socdev = rtd->socdev;
 	struct snd_soc_codec *codec = socdev->card->codec;
 	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
+	unsigned int period_size = substream->runtime->period_size;
+	unsigned int rate = substream->runtime->rate;
 	unsigned int nsample_limit;
 
 	/* In bypass mode we don't need to calculate */
 	if (!dac33->fifo_mode)
 		return;
 
-	/* Number of samples (16bit, stereo) in one period */
-	dac33->nsample_min = snd_pcm_lib_period_bytes(substream) / 4;
-
-	/* Number of samples (16bit, stereo) in ALSA buffer */
-	dac33->nsample_max = snd_pcm_lib_buffer_bytes(substream) / 4;
-	/* Subtract one period from the total */
-	dac33->nsample_max -= dac33->nsample_min;
-
-	/* Number of samples for LATENCY_TIME_MS / 2 */
-	dac33->alarm_threshold = substream->runtime->rate /
-				 (1000 / (LATENCY_TIME_MS / 2));
-
-	/* Find and fix up the lowest nsmaple limit */
-	nsample_limit = substream->runtime->rate / (1000 / LATENCY_TIME_MS);
-
-	if (dac33->nsample_min < nsample_limit)
-		dac33->nsample_min = nsample_limit;
-
-	if (dac33->nsample < dac33->nsample_min)
-		dac33->nsample = dac33->nsample_min;
-
-	/*
-	 * Find and fix up the highest nsmaple limit
-	 * In order to not overflow the DAC33 buffer substract the
-	 * alarm_threshold value from the size of the DAC33 buffer
-	 */
-	nsample_limit = DAC33_BUFFER_SIZE_SAMPLES - dac33->alarm_threshold;
-
-	if (dac33->nsample_max > nsample_limit)
-		dac33->nsample_max = nsample_limit;
-
-	if (dac33->nsample > dac33->nsample_max)
-		dac33->nsample = dac33->nsample_max;
-
 	switch (dac33->fifo_mode) {
 	case DAC33_FIFO_MODE1:
+		/* Number of samples under i2c latency */
+		dac33->alarm_threshold = US_TO_SAMPLES(rate,
+						dac33->mode1_latency);
+		/* nSample time shall not be shorter than i2c latency */
+		dac33->nsample_min = dac33->alarm_threshold;
+		/*
+		 * nSample should not be bigger than alsa buffer minus
+		 * size of one period to avoid overruns
+		 */
+		dac33->nsample_max = substream->runtime->buffer_size -
+					period_size;
+		nsample_limit = DAC33_BUFFER_SIZE_SAMPLES -
+				dac33->alarm_threshold;
+		if (dac33->nsample_max > nsample_limit)
+			dac33->nsample_max = nsample_limit;
+
+		/* Correct the nSample if it is outside of the ranges */
+		if (dac33->nsample < dac33->nsample_min)
+			dac33->nsample = dac33->nsample_min;
+		if (dac33->nsample > dac33->nsample_max)
+			dac33->nsample = dac33->nsample_max;
+
 		dac33->mode1_us_burst = SAMPLES_TO_US(dac33->burst_rate,
 						      dac33->nsample);
 		dac33->t_stamp1 = 0;
@@ -1519,6 +1513,9 @@ static int __devinit dac33_i2c_probe(struct i2c_client *client,
 	/* Pre calculate the burst rate */
 	dac33->burst_rate = BURST_BASEFREQ_HZ / dac33->burst_bclkdiv / 32;
 	dac33->keep_bclk = pdata->keep_bclk;
+	dac33->mode1_latency = pdata->mode1_latency;
+	if (!dac33->mode1_latency)
+		dac33->mode1_latency = 10000; /* 10ms */
 	dac33->irq = client->irq;
 	dac33->nsample = NSAMPLE_MAX;
 	dac33->nsample_max = NSAMPLE_MAX;
-- 
1.7.2
