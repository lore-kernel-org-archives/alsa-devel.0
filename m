From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 1/2] ASoC: tlv320dac33: Start/stop sequence
	change
Date: Thu, 11 Mar 2010 16:26:21 +0200
Message-ID: <1268317582-10284-2-git-send-email-peter.ujfalusi@nokia.com>
References: <1268317582-10284-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 2536B103905
	for <alsa-devel@alsa-project.org>; Thu, 11 Mar 2010 15:26:37 +0100 (CET)
In-Reply-To: <1268317582-10284-1-git-send-email-peter.ujfalusi@nokia.com>
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

To avoid race condition especially in FIFO modes the
sequence for enabling and disabling the codec need to
be changed.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/tlv320dac33.c |   25 +++----------------------
 1 files changed, 3 insertions(+), 22 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index f9f367d..e845c4b 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -310,7 +310,8 @@ static inline void dac33_soft_power(struct snd_soc_codec *codec, int power)
 	if (power)
 		reg |= DAC33_PDNALLB;
 	else
-		reg &= ~DAC33_PDNALLB;
+		reg &= ~(DAC33_PDNALLB | DAC33_OSCPDNB |
+			 DAC33_DACRPDNB | DAC33_DACLPDNB);
 	dac33_write(codec, DAC33_PWR_CTRL, reg);
 }
 
@@ -634,26 +635,6 @@ static irqreturn_t dac33_interrupt_handler(int irq, void *dev)
 	return IRQ_HANDLED;
 }
 
-static void dac33_shutdown(struct snd_pcm_substream *substream,
-			     struct snd_soc_dai *dai)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
-	struct tlv320dac33_priv *dac33 = codec->private_data;
-	unsigned int pwr_ctrl;
-
-	/* Stop pending workqueue */
-	if (dac33->fifo_mode)
-		cancel_work_sync(&dac33->work);
-
-	mutex_lock(&dac33->mutex);
-	pwr_ctrl = dac33_read_reg_cache(codec, DAC33_PWR_CTRL);
-	pwr_ctrl &= ~(DAC33_OSCPDNB | DAC33_DACRPDNB | DAC33_DACLPDNB);
-	dac33_write(codec, DAC33_PWR_CTRL, pwr_ctrl);
-	mutex_unlock(&dac33->mutex);
-}
-
 static void dac33_oscwait(struct snd_soc_codec *codec)
 {
 	int timeout = 20;
@@ -751,6 +732,7 @@ static int dac33_prepare_chip(struct snd_pcm_substream *substream)
 	}
 
 	mutex_lock(&dac33->mutex);
+	dac33_soft_power(codec, 0);
 	dac33_soft_power(codec, 1);
 
 	reg_tmp = dac33_read_reg_cache(codec, DAC33_INT_OSC_CTRL);
@@ -1185,7 +1167,6 @@ EXPORT_SYMBOL_GPL(soc_codec_dev_tlv320dac33);
 #define DAC33_FORMATS	SNDRV_PCM_FMTBIT_S16_LE
 
 static struct snd_soc_dai_ops dac33_dai_ops = {
-	.shutdown	= dac33_shutdown,
 	.hw_params	= dac33_hw_params,
 	.prepare	= dac33_pcm_prepare,
 	.trigger	= dac33_pcm_trigger,
-- 
1.7.0.2
