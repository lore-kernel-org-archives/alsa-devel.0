From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 3/3] ASoC: tlv320dac33: Add 32/24 bit audio
	support
Date: Wed, 22 Dec 2010 10:45:18 +0200
Message-ID: <1293007518-3870-4-git-send-email-peter.ujfalusi@nokia.com>
References: <1293007518-3870-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da01.nokia.com (smtp.nokia.com [147.243.128.24])
	by alsa0.perex.cz (Postfix) with ESMTP id B817E103877
	for <alsa-devel@alsa-project.org>; Wed, 22 Dec 2010 09:45:22 +0100 (CET)
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

Add support for 24 bit audio (with S32_LE msbits 24).
The reason to limit the msbits to 24, is that the FIFO
can be configured for 16 or 24 bit layout.
It is unknown how the codec would downsample from 32 to
24 bit, if the interface is configured to receive 32
bit data.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/tlv320dac33.c |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index 05a4e9f..13d521c 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -764,6 +764,8 @@ static int dac33_startup(struct snd_pcm_substream *substream,
 	/* Stream started, save the substream pointer */
 	dac33->substream = substream;
 
+	snd_pcm_hw_constraint_msbits(substream->runtime, 0, 32, 24);
+
 	return 0;
 }
 
@@ -803,6 +805,10 @@ static int dac33_hw_params(struct snd_pcm_substream *substream,
 		dac33->fifo_size = DAC33_FIFO_SIZE_16BIT;
 		dac33->burst_rate = CALC_BURST_RATE(dac33->burst_bclkdiv, 32);
 		break;
+	case SNDRV_PCM_FORMAT_S32_LE:
+		dac33->fifo_size = DAC33_FIFO_SIZE_24BIT;
+		dac33->burst_rate = CALC_BURST_RATE(dac33->burst_bclkdiv, 64);
+		break;
 	default:
 		dev_err(codec->dev, "unsupported format %d\n",
 			params_format(params));
@@ -856,6 +862,9 @@ static int dac33_prepare_chip(struct snd_pcm_substream *substream)
 		aictrl_a |= (DAC33_NCYCL_16 | DAC33_WLEN_16);
 		fifoctrl_a |= DAC33_WIDTH;
 		break;
+	case SNDRV_PCM_FORMAT_S32_LE:
+		aictrl_a |= (DAC33_NCYCL_32 | DAC33_WLEN_24);
+		break;
 	default:
 		dev_err(codec->dev, "unsupported format %d\n",
 			substream->runtime->format);
@@ -990,7 +999,10 @@ static int dac33_prepare_chip(struct snd_pcm_substream *substream)
 		dac33_write(codec, DAC33_SER_AUDIOIF_CTRL_C,
 							dac33->burst_bclkdiv);
 	else
-		dac33_write(codec, DAC33_SER_AUDIOIF_CTRL_C, 32);
+		if (substream->runtime->format == SNDRV_PCM_FORMAT_S16_LE)
+			dac33_write(codec, DAC33_SER_AUDIOIF_CTRL_C, 32);
+		else
+			dac33_write(codec, DAC33_SER_AUDIOIF_CTRL_C, 16);
 
 	switch (dac33->fifo_mode) {
 	case DAC33_FIFO_MODE1:
@@ -1438,7 +1450,7 @@ static struct snd_soc_codec_driver soc_codec_dev_tlv320dac33 = {
 
 #define DAC33_RATES	(SNDRV_PCM_RATE_44100 | \
 			 SNDRV_PCM_RATE_48000)
-#define DAC33_FORMATS	SNDRV_PCM_FMTBIT_S16_LE
+#define DAC33_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S32_LE)
 
 static struct snd_soc_dai_ops dac33_dai_ops = {
 	.startup	= dac33_startup,
-- 
1.7.3.4
