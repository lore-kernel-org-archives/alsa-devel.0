From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 2/2] ASoC: tlv320dac33: Add option for keeping
	the BCLK running
Date: Thu, 11 Mar 2010 16:26:22 +0200
Message-ID: <1268317582-10284-3-git-send-email-peter.ujfalusi@nokia.com>
References: <1268317582-10284-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id D6DAA10394E
	for <alsa-devel@alsa-project.org>; Thu, 11 Mar 2010 15:26:41 +0100 (CET)
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

Platform data option for the codec to keep the BCLK clock
continuously running in FIFO modes (codec master).

OMAP3 McBSP when in slave mode needs continuous BCLK running
on the serial bus in order to operate correctly.

Since in FIFO mode the DAC33 can also shut down the BCLK clock
and enable it only when it is needed, let the platforms decide
if the CPU side needs the BCLK running or not.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 include/sound/tlv320dac33-plat.h |    1 +
 sound/soc/codecs/tlv320dac33.c   |   13 +++++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/sound/tlv320dac33-plat.h b/include/sound/tlv320dac33-plat.h
index ac06652..3f428d5 100644
--- a/include/sound/tlv320dac33-plat.h
+++ b/include/sound/tlv320dac33-plat.h
@@ -15,6 +15,7 @@
 
 struct tlv320dac33_platform_data {
 	int power_gpio;
+	int keep_bclk;	/* Keep the BCLK running in FIFO modes */
 	u8 burst_bclkdiv;
 };
 
diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index e845c4b..a6f1927 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -93,6 +93,8 @@ struct tlv320dac33_priv {
 	unsigned int nsample;		/* burst read amount from host */
 	u8 burst_bclkdiv;		/* BCLK divider value in burst mode */
 
+	int keep_bclk;			/* Keep the BCLK continuously running
+					 * in FIFO modes */
 	enum dac33_state state;
 };
 
@@ -803,7 +805,10 @@ static int dac33_prepare_chip(struct snd_pcm_substream *substream)
 		 */
 		fifoctrl_a &= ~DAC33_FBYPAS;
 		fifoctrl_a &= ~DAC33_FAUTO;
-		aictrl_b &= ~DAC33_BCLKON;
+		if (dac33->keep_bclk)
+			aictrl_b |= DAC33_BCLKON;
+		else
+			aictrl_b &= ~DAC33_BCLKON;
 		break;
 	case DAC33_FIFO_MODE7:
 		/*
@@ -814,7 +819,10 @@ static int dac33_prepare_chip(struct snd_pcm_substream *substream)
 		 */
 		fifoctrl_a &= ~DAC33_FBYPAS;
 		fifoctrl_a |= DAC33_FAUTO;
-		aictrl_b &= ~DAC33_BCLKON;
+		if (dac33->keep_bclk)
+			aictrl_b |= DAC33_BCLKON;
+		else
+			aictrl_b &= ~DAC33_BCLKON;
 		break;
 	default:
 		/*
@@ -1234,6 +1242,7 @@ static int __devinit dac33_i2c_probe(struct i2c_client *client,
 
 	dac33->power_gpio = pdata->power_gpio;
 	dac33->burst_bclkdiv = pdata->burst_bclkdiv;
+	dac33->keep_bclk = pdata->keep_bclk;
 	dac33->irq = client->irq;
 	dac33->nsample = NSAMPLE_MAX;
 	/* Disable FIFO use by default */
-- 
1.7.0.2
