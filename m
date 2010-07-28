From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH v2 2/2] ASoC: tlv320dac33: Add support for
	automatic FIFO configuration
Date: Wed, 28 Jul 2010 15:26:55 +0300
Message-ID: <1280320015-16099-3-git-send-email-peter.ujfalusi@nokia.com>
References: <1280320015-16099-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 83A8024438
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Jul 2010 14:27:17 +0200 (CEST)
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

Platform parameter to enable automatic FIFO configuration when
the codec is in Mode1 or Mode7 FIFO mode.
When this mode is selected, the controls for changing
nSample (in Mode1), and UTHR (in Mode7) are not added.
The driver configures the FIFO configuration based on
the stream's period size in a way, that every burst will
read period size of data from the host.
In Mode7 we need to use a formula, which gives close enough
aproximation for the burst length from the host point
of view.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 include/sound/tlv320dac33-plat.h |    1 +
 sound/soc/codecs/tlv320dac33.c   |   90 +++++++++++++++++++++++++++-----------
 2 files changed, 65 insertions(+), 26 deletions(-)

diff --git a/include/sound/tlv320dac33-plat.h b/include/sound/tlv320dac33-plat.h
index 1aa7bdb..6c66496 100644
--- a/include/sound/tlv320dac33-plat.h
+++ b/include/sound/tlv320dac33-plat.h
@@ -16,6 +16,7 @@
 struct tlv320dac33_platform_data {
 	int power_gpio;
 	int mode1_latency; /* latency caused by the i2c writes in us */
+	int auto_fifo_config; /* FIFO config based on the period size */
 	int keep_bclk;	/* Keep the BCLK running in FIFO modes */
 	u8 burst_bclkdiv;
 };
diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index ced6fbb..8651b01 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -60,6 +60,9 @@
 #define US_TO_SAMPLES(rate, us) \
 	(rate / (1000000 / us))
 
+#define UTHR_FROM_PERIOD_SIZE(samples, playrate, burstrate) \
+	((samples * 5000) / ((burstrate * 5000) / (burstrate - playrate)))
+
 static void dac33_calculate_times(struct snd_pcm_substream *substream);
 static int dac33_prepare_chip(struct snd_pcm_substream *substream);
 
@@ -107,6 +110,8 @@ struct tlv320dac33_priv {
 	unsigned int nsample;		/* burst read amount from host */
 	int mode1_latency;		/* latency caused by the i2c writes in
 					 * us */
+	int auto_fifo_config; 		/* Configure the FIFO based on the
+					 * period size */
 	u8 burst_bclkdiv;		/* BCLK divider value in burst mode */
 	unsigned int burst_rate;	/* Interface speed in Burst modes */
 
@@ -538,13 +543,16 @@ static const struct snd_kcontrol_new dac33_snd_controls[] = {
 		 DAC33_LINEL_TO_LLO_VOL, DAC33_LINER_TO_RLO_VOL, 0, 127, 1),
 };
 
-static const struct snd_kcontrol_new dac33_nsample_snd_controls[] = {
+static const struct snd_kcontrol_new dac33_mode_snd_controls[] = {
+	SOC_ENUM_EXT("FIFO Mode", dac33_fifo_mode_enum,
+		 dac33_get_fifo_mode, dac33_set_fifo_mode),
+};
+
+static const struct snd_kcontrol_new dac33_fifo_snd_controls[] = {
 	SOC_SINGLE_EXT("nSample", 0, 0, 5900, 0,
-		 dac33_get_nsample, dac33_set_nsample),
+		dac33_get_nsample, dac33_set_nsample),
 	SOC_SINGLE_EXT("UTHR", 0, 0, MODE7_UTHR, 0,
 		 dac33_get_uthr, dac33_set_uthr),
-	SOC_ENUM_EXT("FIFO Mode", dac33_fifo_mode_enum,
-		 dac33_get_fifo_mode, dac33_set_fifo_mode),
 };
 
 /* Analog bypass */
@@ -1057,24 +1065,38 @@ static void dac33_calculate_times(struct snd_pcm_substream *substream)
 		/* Number of samples under i2c latency */
 		dac33->alarm_threshold = US_TO_SAMPLES(rate,
 						dac33->mode1_latency);
-		/* nSample time shall not be shorter than i2c latency */
-		dac33->nsample_min = dac33->alarm_threshold;
-		/*
-		 * nSample should not be bigger than alsa buffer minus
-		 * size of one period to avoid overruns
-		 */
-		dac33->nsample_max = substream->runtime->buffer_size -
-					period_size;
-		nsample_limit = DAC33_BUFFER_SIZE_SAMPLES -
-				dac33->alarm_threshold;
-		if (dac33->nsample_max > nsample_limit)
-			dac33->nsample_max = nsample_limit;
-
-		/* Correct the nSample if it is outside of the ranges */
-		if (dac33->nsample < dac33->nsample_min)
-			dac33->nsample = dac33->nsample_min;
-		if (dac33->nsample > dac33->nsample_max)
-			dac33->nsample = dac33->nsample_max;
+		if (dac33->auto_fifo_config) {
+			if (period_size <= dac33->alarm_threshold)
+				/*
+				 * Configure nSamaple to number of periods,
+				 * which covers the latency requironment.
+				 */
+				dac33->nsample = period_size *
+				       ((dac33->alarm_threshold / period_size) +
+				       (dac33->alarm_threshold % period_size ?
+				       1 : 0));
+			else
+				dac33->nsample = period_size;
+		} else {
+			/* nSample time shall not be shorter than i2c latency */
+			dac33->nsample_min = dac33->alarm_threshold;
+			/*
+			 * nSample should not be bigger than alsa buffer minus
+			 * size of one period to avoid overruns
+			 */
+			dac33->nsample_max = substream->runtime->buffer_size -
+						period_size;
+			nsample_limit = DAC33_BUFFER_SIZE_SAMPLES -
+					dac33->alarm_threshold;
+			if (dac33->nsample_max > nsample_limit)
+				dac33->nsample_max = nsample_limit;
+
+			/* Correct the nSample if it is outside of the ranges */
+			if (dac33->nsample < dac33->nsample_min)
+				dac33->nsample = dac33->nsample_min;
+			if (dac33->nsample > dac33->nsample_max)
+				dac33->nsample = dac33->nsample_max;
+		}
 
 		dac33->mode1_us_burst = SAMPLES_TO_US(dac33->burst_rate,
 						      dac33->nsample);
@@ -1082,6 +1104,16 @@ static void dac33_calculate_times(struct snd_pcm_substream *substream)
 		dac33->t_stamp2 = 0;
 		break;
 	case DAC33_FIFO_MODE7:
+		if (dac33->auto_fifo_config) {
+			dac33->uthr = UTHR_FROM_PERIOD_SIZE(
+					period_size,
+					rate,
+					dac33->burst_rate) + 9;
+			if (dac33->uthr > MODE7_UTHR)
+				dac33->uthr = MODE7_UTHR;
+			if (dac33->uthr < (MODE7_LTHR + 10))
+				dac33->uthr = (MODE7_LTHR + 10);
+		}
 		dac33->mode7_us_to_lthr =
 				SAMPLES_TO_US(substream->runtime->rate,
 					dac33->uthr - MODE7_LTHR + 1);
@@ -1379,10 +1411,15 @@ static int dac33_soc_probe(struct platform_device *pdev)
 
 	snd_soc_add_controls(codec, dac33_snd_controls,
 			     ARRAY_SIZE(dac33_snd_controls));
-	/* Only add the nSample controls, if we have valid IRQ number */
-	if (dac33->irq >= 0)
-		snd_soc_add_controls(codec, dac33_nsample_snd_controls,
-				     ARRAY_SIZE(dac33_nsample_snd_controls));
+	/* Only add the FIFO controls, if we have valid IRQ number */
+	if (dac33->irq >= 0) {
+		snd_soc_add_controls(codec, dac33_mode_snd_controls,
+				     ARRAY_SIZE(dac33_mode_snd_controls));
+		/* FIFO usage controls only, if autoio config is not selected */
+		if (!dac33->auto_fifo_config)
+			snd_soc_add_controls(codec, dac33_fifo_snd_controls,
+					ARRAY_SIZE(dac33_fifo_snd_controls));
+	}
 
 	dac33_add_widgets(codec);
 
@@ -1513,6 +1550,7 @@ static int __devinit dac33_i2c_probe(struct i2c_client *client,
 	/* Pre calculate the burst rate */
 	dac33->burst_rate = BURST_BASEFREQ_HZ / dac33->burst_bclkdiv / 32;
 	dac33->keep_bclk = pdata->keep_bclk;
+	dac33->auto_fifo_config = pdata->auto_fifo_config;
 	dac33->mode1_latency = pdata->mode1_latency;
 	if (!dac33->mode1_latency)
 		dac33->mode1_latency = 10000; /* 10ms */
-- 
1.7.2
