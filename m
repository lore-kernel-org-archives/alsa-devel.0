From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 1/2] ASoC: tlv320dac33: Use usleep_range for
	delays
Date: Fri, 22 Oct 2010 15:11:20 +0300
Message-ID: <1287749481-12203-2-git-send-email-peter.ujfalusi@nokia.com>
References: <1287749481-12203-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id BF0E8103820
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Oct 2010 14:11:31 +0200 (CEST)
In-Reply-To: <1287749481-12203-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: broonie@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Switch to use the more precise usleep_range instead of
msleep().
Replace the udelay with usleep_range to remove the busy loop
waiting.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/tlv320dac33.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index 58349dc..d251ff5 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -669,6 +669,7 @@ static int dac33_set_bias_level(struct snd_soc_codec *codec,
 static inline void dac33_prefill_handler(struct tlv320dac33_priv *dac33)
 {
 	struct snd_soc_codec *codec = dac33->codec;
+	unsigned int delay;
 
 	switch (dac33->fifo_mode) {
 	case DAC33_FIFO_MODE1:
@@ -684,8 +685,9 @@ static inline void dac33_prefill_handler(struct tlv320dac33_priv *dac33)
 		dac33_write16(codec, DAC33_PREFILL_MSB,
 				DAC33_THRREG(dac33->alarm_threshold));
 		/* Enable Alarm Threshold IRQ with a delay */
-		udelay(SAMPLES_TO_US(dac33->burst_rate,
-				     dac33->alarm_threshold));
+		delay = SAMPLES_TO_US(dac33->burst_rate,
+				     dac33->alarm_threshold) + 1000;
+		usleep_range(delay, delay + 500);
 		dac33_write(codec, DAC33_FIFO_IRQ_MASK, DAC33_MAT);
 		break;
 	case DAC33_FIFO_MODE7:
@@ -785,11 +787,11 @@ static irqreturn_t dac33_interrupt_handler(int irq, void *dev)
 
 static void dac33_oscwait(struct snd_soc_codec *codec)
 {
-	int timeout = 20;
+	int timeout = 60;
 	u8 reg;
 
 	do {
-		msleep(1);
+		usleep_range(1000, 2000);
 		dac33_read(codec, DAC33_INT_OSC_STATUS, &reg);
 	} while (((reg & 0x03) != DAC33_OSCSTATUS_NORMAL) && timeout--);
 	if ((reg & 0x03) != DAC33_OSCSTATUS_NORMAL)
-- 
1.7.3.1
