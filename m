From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 4/5] ASoC: tlv320dac33: Calculate the interface
	speed during bursts
Date: Thu, 22 Apr 2010 16:57:49 +0300
Message-ID: <1271944670-14588-5-git-send-email-peter.ujfalusi@nokia.com>
References: <1271944670-14588-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 4AB371038A1
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Apr 2010 16:00:36 +0200 (CEST)
In-Reply-To: <1271944670-14588-1-git-send-email-peter.ujfalusi@nokia.com>
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

When the DAC33 FIFO is in use the dai interface is running in
much higher speed than the sampling frequency.
Calculate the rate based on the internal base frequency and
the bclk divider.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/tlv320dac33.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index 725be4c..7a3dea6 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -53,6 +53,8 @@
 #define MODE7_LTHR		10
 #define MODE7_UTHR		(DAC33_BUFFER_SIZE_SAMPLES - 10)
 
+#define BURST_BASEFREQ_HZ	49152000
+
 static struct snd_soc_codec *tlv320dac33_codec;
 
 enum dac33_state {
@@ -95,6 +97,7 @@ struct tlv320dac33_priv {
 	enum dac33_fifo_modes fifo_mode;/* FIFO mode selection */
 	unsigned int nsample;		/* burst read amount from host */
 	u8 burst_bclkdiv;		/* BCLK divider value in burst mode */
+	unsigned int burst_rate;	/* Interface speed in Burst modes */
 
 	int keep_bclk;			/* Keep the BCLK continuously running
 					 * in FIFO modes */
@@ -1245,6 +1248,8 @@ static int __devinit dac33_i2c_probe(struct i2c_client *client,
 
 	dac33->power_gpio = pdata->power_gpio;
 	dac33->burst_bclkdiv = pdata->burst_bclkdiv;
+	/* Pre calculate the burst rate */
+	dac33->burst_rate = BURST_BASEFREQ_HZ / dac33->burst_bclkdiv / 32;
 	dac33->keep_bclk = pdata->keep_bclk;
 	dac33->irq = client->irq;
 	dac33->nsample = NSAMPLE_MAX;
-- 
1.7.0.4
