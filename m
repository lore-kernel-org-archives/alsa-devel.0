From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 4/5] ASoC: tlv320dac33: Add new FIFO mode: mode
	7
Date: Thu, 31 Dec 2009 10:30:22 +0200
Message-ID: <1262248223-9335-5-git-send-email-peter.ujfalusi@nokia.com>
References: <1262248223-9335-1-git-send-email-peter.ujfalusi@nokia.com>
	<1262248223-9335-2-git-send-email-peter.ujfalusi@nokia.com>
	<1262248223-9335-3-git-send-email-peter.ujfalusi@nokia.com>
	<1262248223-9335-4-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 9944E1038A6
	for <alsa-devel@alsa-project.org>; Thu, 31 Dec 2009 09:34:24 +0100 (CET)
In-Reply-To: <1262248223-9335-4-git-send-email-peter.ujfalusi@nokia.com>
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

Mode 7 of tlv320dac33 operates in the following way:
The codec is in master mode.
Host configures upper and lower thresholds in tlv320dac33
During playback the codec will clock in the data until the
upper threshold is reached in FIFO. At this point the codec
stops the colocks on the serial bus.
When the FIFO fill is reaching the lower threshold limit the
codec will enable the clocks on the serial bus, and clocks
in data till the upper threshold is reached.

In this mode, we can also request interrupts for threshold
events (upper, lower and alarm), which could be used for
power management.

At this point the interrupts are not enabled for this mode,
but it can be taken into use in the future, when the surrounding
code makes it possible to use it.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/tlv320dac33.c |   35 ++++++++++++++++++++++++++++++++++-
 1 files changed, 34 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index c684aa2..bc35f3f 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -62,6 +62,7 @@ enum dac33_state {
 enum dac33_fifo_modes {
 	DAC33_FIFO_BYPASS = 0,
 	DAC33_FIFO_MODE1,
+	DAC33_FIFO_MODE7,
 	DAC33_FIFO_LAST_MODE,
 };
 
@@ -422,7 +423,7 @@ static int dac33_set_fifo_mode(struct snd_kcontrol *kcontrol,
 
 /* Codec operation modes */
 static const char *dac33_fifo_mode_texts[] = {
-	"Bypass", "Mode 1"
+	"Bypass", "Mode 1", "Mode 7"
 };
 
 static const struct soc_enum dac33_fifo_mode_enum =
@@ -556,6 +557,10 @@ static inline void dac33_prefill_handler(struct tlv320dac33_priv *dac33)
 		dac33_write16(codec, DAC33_PREFILL_MSB,
 				DAC33_THRREG(dac33->alarm_threshold));
 		break;
+	case DAC33_FIFO_MODE7:
+		dac33_write16(codec, DAC33_PREFILL_MSB,
+				DAC33_THRREG(20));
+		break;
 	default:
 		dev_warn(codec->dev, "Unhandled FIFO mode: %d\n",
 							dac33->fifo_mode);
@@ -574,6 +579,9 @@ static inline void dac33_playback_handler(struct tlv320dac33_priv *dac33)
 		dac33_write16(codec, DAC33_NSAMPLE_MSB,
 				DAC33_THRREG(dac33->nsample));
 		break;
+	case DAC33_FIFO_MODE7:
+		/* At the moment we are not using interrupts in mode7 */
+		break;
 	default:
 		dev_warn(codec->dev, "Unhandled FIFO mode: %d\n",
 							dac33->fifo_mode);
@@ -788,6 +796,10 @@ static int dac33_prepare_chip(struct snd_pcm_substream *substream)
 			    DAC33_ATM(DAC33_FIFO_IRQ_MODE_LEVEL));
 		dac33_write(codec, DAC33_FIFO_IRQ_MASK, DAC33_MAT);
 		break;
+	case DAC33_FIFO_MODE7:
+		/* Disable all interrupts */
+		dac33_write(codec, DAC33_FIFO_IRQ_MASK, 0);
+		break;
 	default:
 		/* in FIFO bypass mode, the interrupts are not used */
 		break;
@@ -807,6 +819,17 @@ static int dac33_prepare_chip(struct snd_pcm_substream *substream)
 		fifoctrl_a &= ~DAC33_FAUTO;
 		aictrl_b &= ~DAC33_BCLKON;
 		break;
+	case DAC33_FIFO_MODE7:
+		/*
+		 * For mode1:
+		 * Disable the FIFO bypass (Enable the use of FIFO)
+		 * Select Threshold mode
+		 * BCLK is only running when data is needed by DAC33
+		 */
+		fifoctrl_a &= ~DAC33_FBYPAS;
+		fifoctrl_a |= DAC33_FAUTO;
+		aictrl_b &= ~DAC33_BCLKON;
+		break;
 	default:
 		/*
 		 * For FIFO bypass mode:
@@ -830,6 +853,16 @@ static int dac33_prepare_chip(struct snd_pcm_substream *substream)
 		dac33_write16(codec, DAC33_ATHR_MSB,
 			      DAC33_THRREG(dac33->alarm_threshold));
 		break;
+	case DAC33_FIFO_MODE7:
+		/*
+		 * Configure the threshold levels, and leave 10 sample space
+		 * at the bottom, and also at the top of the FIFO
+		 */
+		dac33_write16(codec, DAC33_UTHR_MSB,
+			DAC33_THRREG(DAC33_BUFFER_SIZE_SAMPLES - 10));
+		dac33_write16(codec, DAC33_LTHR_MSB,
+			DAC33_THRREG(10));
+		break;
 	default:
 		/* BYPASS mode */
 		dac33_write(codec, DAC33_SER_AUDIOIF_CTRL_C, 32);
-- 
1.6.6
