From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 1/2] ASoC: tlv320dac33: BCLK divider fix
Date: Wed, 20 Jan 2010 09:39:35 +0200
Message-ID: <1263973176-15925-2-git-send-email-peter.ujfalusi@nokia.com>
References: <1263973176-15925-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 501AF1038D5
	for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2010 08:42:16 +0100 (CET)
In-Reply-To: <1263973176-15925-1-git-send-email-peter.ujfalusi@nokia.com>
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

The BCLK divider was not configured in case of mode7.
This leads to unpredictable behavior when switching between FIFO modes.
Configure the BCLK divider depending on the fifo_mode (FIFO is in use,
or FIFO bypass).

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/tlv320dac33.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index 65683aa..e1aa66f 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -845,11 +845,14 @@ static int dac33_prepare_chip(struct snd_pcm_substream *substream)
 	dac33_write(codec, DAC33_SER_AUDIOIF_CTRL_A, aictrl_a);
 	dac33_write(codec, DAC33_SER_AUDIOIF_CTRL_B, aictrl_b);
 
-	switch (dac33->fifo_mode) {
-	case DAC33_FIFO_MODE1:
-		/* 20: BCLK divide ratio */
+	/* BCLK divide ratio */
+	if (dac33->fifo_mode)
 		dac33_write(codec, DAC33_SER_AUDIOIF_CTRL_C, 3);
+	else
+		dac33_write(codec, DAC33_SER_AUDIOIF_CTRL_C, 32);
 
+	switch (dac33->fifo_mode) {
+	case DAC33_FIFO_MODE1:
 		dac33_write16(codec, DAC33_ATHR_MSB,
 			      DAC33_THRREG(dac33->alarm_threshold));
 		break;
@@ -864,8 +867,6 @@ static int dac33_prepare_chip(struct snd_pcm_substream *substream)
 			DAC33_THRREG(10));
 		break;
 	default:
-		/* BYPASS mode */
-		dac33_write(codec, DAC33_SER_AUDIOIF_CTRL_C, 32);
 		break;
 	}
 
-- 
1.6.6
