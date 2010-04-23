From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCHv2 2/5] ASoC: tlv320dac33: Skip calculations in
	FIFO Bypass mode
Date: Fri, 23 Apr 2010 10:09:58 +0300
Message-ID: <1272006601-24946-3-git-send-email-peter.ujfalusi@nokia.com>
References: <1272006601-24946-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id A23F92439A
	for <alsa-devel@alsa-project.org>;
	Fri, 23 Apr 2010 09:10:41 +0200 (CEST)
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

There is no need for calculations for FIFO bypass mode.
Just in case set the nsample maximum limit, which
has been done in the calculation phase.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/tlv320dac33.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index 520377b..b101cbd 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -889,6 +889,10 @@ static void dac33_calculate_times(struct snd_pcm_substream *substream)
 	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
 	unsigned int nsample_limit;
 
+	/* In bypass mode we don't need to calculate */
+	if (!dac33->fifo_mode)
+		return;
+
 	/* Number of samples (16bit, stereo) in one period */
 	dac33->nsample_min = snd_pcm_lib_period_bytes(substream) / 4;
 
@@ -1244,6 +1248,7 @@ static int __devinit dac33_i2c_probe(struct i2c_client *client,
 	dac33->keep_bclk = pdata->keep_bclk;
 	dac33->irq = client->irq;
 	dac33->nsample = NSAMPLE_MAX;
+	dac33->nsample_max = NSAMPLE_MAX;
 	/* Disable FIFO use by default */
 	dac33->fifo_mode = DAC33_FIFO_BYPASS;
 
-- 
1.7.0.4
