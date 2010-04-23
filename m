From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCHv2 1/5] ASoC: tlv320dac33: Fix for early
	interrupt in FIFO Mode1
Date: Fri, 23 Apr 2010 10:09:57 +0300
Message-ID: <1272006601-24946-2-git-send-email-peter.ujfalusi@nokia.com>
References: <1272006601-24946-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 657C12439C
	for <alsa-devel@alsa-project.org>;
	Fri, 23 Apr 2010 09:11:26 +0200 (CEST)
In-Reply-To: <1272006601-24946-1-git-send-email-peter.ujfalusi@nokia.com>
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

Alarm threshold interrupt is triggered right after the
playback start.
This interrupt is recieved during the first burst period,
and caused the state machine to write additional nSample
command, which has to be avoided.
To fix this issue move the DAC33 interrupt unmasking
after we configured the PREFILL register with a small
delay.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/tlv320dac33.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index 824bb35..520377b 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -557,9 +557,13 @@ static inline void dac33_prefill_handler(struct tlv320dac33_priv *dac33)
 	switch (dac33->fifo_mode) {
 	case DAC33_FIFO_MODE1:
 		dac33_write16(codec, DAC33_NSAMPLE_MSB,
-				DAC33_THRREG(dac33->nsample));
+			DAC33_THRREG(dac33->nsample + dac33->alarm_threshold));
 		dac33_write16(codec, DAC33_PREFILL_MSB,
 				DAC33_THRREG(dac33->alarm_threshold));
+		/* Enable Alarm Threshold IRQ with a delay */
+		udelay(SAMPLES_TO_US(dac33->burst_rate,
+				     dac33->alarm_threshold));
+		dac33_write(codec, DAC33_FIFO_IRQ_MASK, DAC33_MAT);
 		break;
 	case DAC33_FIFO_MODE7:
 		dac33_write16(codec, DAC33_PREFILL_MSB,
@@ -782,7 +786,6 @@ static int dac33_prepare_chip(struct snd_pcm_substream *substream)
 	case DAC33_FIFO_MODE1:
 		dac33_write(codec, DAC33_FIFO_IRQ_MODE_B,
 			    DAC33_ATM(DAC33_FIFO_IRQ_MODE_LEVEL));
-		dac33_write(codec, DAC33_FIFO_IRQ_MASK, DAC33_MAT);
 		break;
 	case DAC33_FIFO_MODE7:
 		/* Disable all interrupts */
-- 
1.7.0.4
