From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 2/5] ASoC: tlv320dac33: Introduce prefill and
	playback state handlers
Date: Thu, 31 Dec 2009 10:30:20 +0200
Message-ID: <1262248223-9335-3-git-send-email-peter.ujfalusi@nokia.com>
References: <1262248223-9335-1-git-send-email-peter.ujfalusi@nokia.com>
	<1262248223-9335-2-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id A3144103891
	for <alsa-devel@alsa-project.org>; Thu, 31 Dec 2009 09:31:28 +0100 (CET)
In-Reply-To: <1262248223-9335-2-git-send-email-peter.ujfalusi@nokia.com>
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

Ensure that the code is going to be readable, when new FIFO modes
are introduced later.
Move the prefill and playback state handling to inlined
functions.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/tlv320dac33.c |   46 ++++++++++++++++++++++++++++++++++-----
 1 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index b67961d..f7c7bbc 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -543,6 +543,44 @@ static int dac33_set_bias_level(struct snd_soc_codec *codec,
 	return 0;
 }
 
+static inline void dac33_prefill_handler(struct tlv320dac33_priv *dac33)
+{
+	struct snd_soc_codec *codec;
+
+	codec = &dac33->codec;
+
+	switch (dac33->fifo_mode) {
+	case DAC33_FIFO_MODE1:
+		dac33_write16(codec, DAC33_NSAMPLE_MSB,
+				DAC33_THRREG(dac33->nsample));
+		dac33_write16(codec, DAC33_PREFILL_MSB,
+				DAC33_THRREG(dac33->alarm_threshold));
+		break;
+	default:
+		dev_warn(codec->dev, "Unhandled FIFO mode: %d\n",
+							dac33->fifo_mode);
+		break;
+	}
+}
+
+static inline void dac33_playback_handler(struct tlv320dac33_priv *dac33)
+{
+	struct snd_soc_codec *codec;
+
+	codec = &dac33->codec;
+
+	switch (dac33->fifo_mode) {
+	case DAC33_FIFO_MODE1:
+		dac33_write16(codec, DAC33_NSAMPLE_MSB,
+				DAC33_THRREG(dac33->nsample));
+		break;
+	default:
+		dev_warn(codec->dev, "Unhandled FIFO mode: %d\n",
+							dac33->fifo_mode);
+		break;
+	}
+}
+
 static void dac33_work(struct work_struct *work)
 {
 	struct snd_soc_codec *codec;
@@ -556,14 +594,10 @@ static void dac33_work(struct work_struct *work)
 	switch (dac33->state) {
 	case DAC33_PREFILL:
 		dac33->state = DAC33_PLAYBACK;
-		dac33_write16(codec, DAC33_NSAMPLE_MSB,
-				DAC33_THRREG(dac33->nsample));
-		dac33_write16(codec, DAC33_PREFILL_MSB,
-				DAC33_THRREG(dac33->alarm_threshold));
+		dac33_prefill_handler(dac33);
 		break;
 	case DAC33_PLAYBACK:
-		dac33_write16(codec, DAC33_NSAMPLE_MSB,
-				DAC33_THRREG(dac33->nsample));
+		dac33_playback_handler(dac33);
 		break;
 	case DAC33_IDLE:
 		break;
-- 
1.6.6
