From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH] ASoC: tlv320dac33: Fix inconsistent spinlock
	usage
Date: Fri, 18 Mar 2011 15:15:11 +0200
Message-ID: <1300454111-27452-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da01.nokia.com (smtp.nokia.com [147.243.128.24])
	by alsa0.perex.cz (Postfix) with ESMTP id DA9261039DA
	for <alsa-devel@alsa-project.org>; Fri, 18 Mar 2011 14:15:21 +0100 (CET)
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

The lock is used within the interrupt handler.
Correct the spinlock usage, and use irqsave/irqrestore
flavour of spin_lock/unlock.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/tlv320dac33.c |   28 ++++++++++++++++------------
 1 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index 71d7be8..93f38b1 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -670,6 +670,7 @@ static inline void dac33_prefill_handler(struct tlv320dac33_priv *dac33)
 {
 	struct snd_soc_codec *codec = dac33->codec;
 	unsigned int delay;
+	unsigned long flags;
 
 	switch (dac33->fifo_mode) {
 	case DAC33_FIFO_MODE1:
@@ -677,10 +678,10 @@ static inline void dac33_prefill_handler(struct tlv320dac33_priv *dac33)
 			DAC33_THRREG(dac33->nsample));
 
 		/* Take the timestamps */
-		spin_lock_irq(&dac33->lock);
+		spin_lock_irqsave(&dac33->lock, flags);
 		dac33->t_stamp2 = ktime_to_us(ktime_get());
 		dac33->t_stamp1 = dac33->t_stamp2;
-		spin_unlock_irq(&dac33->lock);
+		spin_unlock_irqrestore(&dac33->lock, flags);
 
 		dac33_write16(codec, DAC33_PREFILL_MSB,
 				DAC33_THRREG(dac33->alarm_threshold));
@@ -692,11 +693,11 @@ static inline void dac33_prefill_handler(struct tlv320dac33_priv *dac33)
 		break;
 	case DAC33_FIFO_MODE7:
 		/* Take the timestamp */
-		spin_lock_irq(&dac33->lock);
+		spin_lock_irqsave(&dac33->lock, flags);
 		dac33->t_stamp1 = ktime_to_us(ktime_get());
 		/* Move back the timestamp with drain time */
 		dac33->t_stamp1 -= dac33->mode7_us_to_lthr;
-		spin_unlock_irq(&dac33->lock);
+		spin_unlock_irqrestore(&dac33->lock, flags);
 
 		dac33_write16(codec, DAC33_PREFILL_MSB,
 				DAC33_THRREG(DAC33_MODE7_MARGIN));
@@ -714,13 +715,14 @@ static inline void dac33_prefill_handler(struct tlv320dac33_priv *dac33)
 static inline void dac33_playback_handler(struct tlv320dac33_priv *dac33)
 {
 	struct snd_soc_codec *codec = dac33->codec;
+	unsigned long flags;
 
 	switch (dac33->fifo_mode) {
 	case DAC33_FIFO_MODE1:
 		/* Take the timestamp */
-		spin_lock_irq(&dac33->lock);
+		spin_lock_irqsave(&dac33->lock, flags);
 		dac33->t_stamp2 = ktime_to_us(ktime_get());
-		spin_unlock_irq(&dac33->lock);
+		spin_unlock_irqrestore(&dac33->lock, flags);
 
 		dac33_write16(codec, DAC33_NSAMPLE_MSB,
 				DAC33_THRREG(dac33->nsample));
@@ -773,10 +775,11 @@ static irqreturn_t dac33_interrupt_handler(int irq, void *dev)
 {
 	struct snd_soc_codec *codec = dev;
 	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
+	unsigned long flags;
 
-	spin_lock(&dac33->lock);
+	spin_lock_irqsave(&dac33->lock, flags);
 	dac33->t_stamp1 = ktime_to_us(ktime_get());
-	spin_unlock(&dac33->lock);
+	spin_unlock_irqrestore(&dac33->lock, flags);
 
 	/* Do not schedule the workqueue in Mode7 */
 	if (dac33->fifo_mode != DAC33_FIFO_MODE7)
@@ -1173,15 +1176,16 @@ static snd_pcm_sframes_t dac33_dai_delay(
 	unsigned int time_delta, uthr;
 	int samples_out, samples_in, samples;
 	snd_pcm_sframes_t delay = 0;
+	unsigned long flags;
 
 	switch (dac33->fifo_mode) {
 	case DAC33_FIFO_BYPASS:
 		break;
 	case DAC33_FIFO_MODE1:
-		spin_lock(&dac33->lock);
+		spin_lock_irqsave(&dac33->lock, flags);
 		t0 = dac33->t_stamp1;
 		t1 = dac33->t_stamp2;
-		spin_unlock(&dac33->lock);
+		spin_unlock_irqrestore(&dac33->lock, flags);
 		t_now = ktime_to_us(ktime_get());
 
 		/* We have not started to fill the FIFO yet, delay is 0 */
@@ -1246,10 +1250,10 @@ static snd_pcm_sframes_t dac33_dai_delay(
 		}
 		break;
 	case DAC33_FIFO_MODE7:
-		spin_lock(&dac33->lock);
+		spin_lock_irqsave(&dac33->lock, flags);
 		t0 = dac33->t_stamp1;
 		uthr = dac33->uthr;
-		spin_unlock(&dac33->lock);
+		spin_unlock_irqrestore(&dac33->lock, flags);
 		t_now = ktime_to_us(ktime_get());
 
 		/* We have not started to fill the FIFO yet, delay is 0 */
-- 
1.7.4.1
