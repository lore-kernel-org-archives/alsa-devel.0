From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH] ASoC: tlv320dac33: Mode1 FIFO auto
	configuration fix
Date: Fri, 29 Oct 2010 09:49:37 +0300
Message-ID: <1288334977-11781-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 8E7E5245AA
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Oct 2010 08:49:57 +0200 (CEST)
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

Do not allow invalid (too big) nSample value, when FIFO Mode1
and automatic fifo configuration has been selected.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/tlv320dac33.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index fed1458..6778e2e 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -1082,6 +1082,9 @@ static void dac33_calculate_times(struct snd_pcm_substream *substream)
 		/* Number of samples under i2c latency */
 		dac33->alarm_threshold = US_TO_SAMPLES(rate,
 						dac33->mode1_latency);
+		nsample_limit = DAC33_BUFFER_SIZE_SAMPLES -
+				dac33->alarm_threshold;
+
 		if (dac33->auto_fifo_config) {
 			if (period_size <= dac33->alarm_threshold)
 				/*
@@ -1092,6 +1095,8 @@ static void dac33_calculate_times(struct snd_pcm_substream *substream)
 				       ((dac33->alarm_threshold / period_size) +
 				       (dac33->alarm_threshold % period_size ?
 				       1 : 0));
+			else if (period_size > nsample_limit)
+				dac33->nsample = nsample_limit;
 			else
 				dac33->nsample = period_size;
 		} else {
@@ -1103,8 +1108,7 @@ static void dac33_calculate_times(struct snd_pcm_substream *substream)
 			 */
 			dac33->nsample_max = substream->runtime->buffer_size -
 						period_size;
-			nsample_limit = DAC33_BUFFER_SIZE_SAMPLES -
-					dac33->alarm_threshold;
+
 			if (dac33->nsample_max > nsample_limit)
 				dac33->nsample_max = nsample_limit;
 
-- 
1.7.3.2
