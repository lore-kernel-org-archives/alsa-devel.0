From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 2/2] ASoC: tlv320dac33: Burst mode BCLK divider
	configuration
Date: Wed, 20 Jan 2010 09:39:36 +0200
Message-ID: <1263973176-15925-3-git-send-email-peter.ujfalusi@nokia.com>
References: <1263973176-15925-1-git-send-email-peter.ujfalusi@nokia.com>
	<1263973176-15925-2-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id B63631038B4
	for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2010 08:40:08 +0100 (CET)
In-Reply-To: <1263973176-15925-2-git-send-email-peter.ujfalusi@nokia.com>
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

Add possibility to configure the burst mode BCLK divider through platform
data structure.
The BCLK divider changes the actual speed of the serial bus in burst mode,
which is faster than the sampling frequency of the running stream.
In this way platforms can experiment with the optimal burst speed without
the need to modify the codec driver itself.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 include/sound/tlv320dac33-plat.h |    1 +
 sound/soc/codecs/tlv320dac33.c   |   15 +++++++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/sound/tlv320dac33-plat.h b/include/sound/tlv320dac33-plat.h
index 5858d06..ac06652 100644
--- a/include/sound/tlv320dac33-plat.h
+++ b/include/sound/tlv320dac33-plat.h
@@ -15,6 +15,7 @@
 
 struct tlv320dac33_platform_data {
 	int power_gpio;
+	u8 burst_bclkdiv;
 };
 
 #endif /* __TLV320DAC33_PLAT_H */
diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index e1aa66f..1b35d0c 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -91,6 +91,7 @@ struct tlv320dac33_priv {
 					 * this */
 	enum dac33_fifo_modes fifo_mode;/* FIFO mode selection */
 	unsigned int nsample;		/* burst read amount from host */
+	u8 burst_bclkdiv;		/* BCLK divider value in burst mode */
 
 	enum dac33_state state;
 };
@@ -845,9 +846,18 @@ static int dac33_prepare_chip(struct snd_pcm_substream *substream)
 	dac33_write(codec, DAC33_SER_AUDIOIF_CTRL_A, aictrl_a);
 	dac33_write(codec, DAC33_SER_AUDIOIF_CTRL_B, aictrl_b);
 
-	/* BCLK divide ratio */
+	/*
+	 * BCLK divide ratio
+	 * 0: 1.5
+	 * 1: 1
+	 * 2: 2
+	 * ...
+	 * 254: 254
+	 * 255: 255
+	 */
 	if (dac33->fifo_mode)
-		dac33_write(codec, DAC33_SER_AUDIOIF_CTRL_C, 3);
+		dac33_write(codec, DAC33_SER_AUDIOIF_CTRL_C,
+							dac33->burst_bclkdiv);
 	else
 		dac33_write(codec, DAC33_SER_AUDIOIF_CTRL_C, 32);
 
@@ -1239,6 +1249,7 @@ static int __devinit dac33_i2c_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, dac33);
 
 	dac33->power_gpio = pdata->power_gpio;
+	dac33->burst_bclkdiv = pdata->burst_bclkdiv;
 	dac33->irq = client->irq;
 	dac33->nsample = NSAMPLE_MAX;
 	/* Disable FIFO use by default */
-- 
1.6.6
