From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCHv2 3/5] ASoC: tlv320dac33: Change magic numbers
	used in Mode7
Date: Fri, 23 Apr 2010 10:09:59 +0300
Message-ID: <1272006601-24946-4-git-send-email-peter.ujfalusi@nokia.com>
References: <1272006601-24946-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id F0C3B243C0
	for <alsa-devel@alsa-project.org>;
	Fri, 23 Apr 2010 09:11:39 +0200 (CEST)
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

Upper and Lower threshold values are used as magic
numbers. Replace them with defines for later use.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/tlv320dac33.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index b101cbd..fa19942 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -50,6 +50,9 @@
 
 #define LATENCY_TIME_MS		20
 
+#define MODE7_LTHR		10
+#define MODE7_UTHR		(DAC33_BUFFER_SIZE_SAMPLES - 10)
+
 static struct snd_soc_codec *tlv320dac33_codec;
 
 enum dac33_state {
@@ -567,7 +570,7 @@ static inline void dac33_prefill_handler(struct tlv320dac33_priv *dac33)
 		break;
 	case DAC33_FIFO_MODE7:
 		dac33_write16(codec, DAC33_PREFILL_MSB,
-				DAC33_THRREG(10));
+				DAC33_THRREG(MODE7_LTHR));
 		break;
 	default:
 		dev_warn(codec->dev, "Unhandled FIFO mode: %d\n",
@@ -867,10 +870,8 @@ static int dac33_prepare_chip(struct snd_pcm_substream *substream)
 		 * Configure the threshold levels, and leave 10 sample space
 		 * at the bottom, and also at the top of the FIFO
 		 */
-		dac33_write16(codec, DAC33_UTHR_MSB,
-			DAC33_THRREG(DAC33_BUFFER_SIZE_SAMPLES - 10));
-		dac33_write16(codec, DAC33_LTHR_MSB,
-			DAC33_THRREG(10));
+		dac33_write16(codec, DAC33_UTHR_MSB, DAC33_THRREG(MODE7_UTHR));
+		dac33_write16(codec, DAC33_LTHR_MSB, DAC33_THRREG(MODE7_LTHR));
 		break;
 	default:
 		break;
-- 
1.7.0.4
