From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 08/10] ASoC: twl6040: No need to change delay
	during HF ramp
Date: Mon, 26 Sep 2011 16:26:31 +0300
Message-ID: <1317043593-27202-9-git-send-email-peter.ujfalusi@ti.com>
References: <1317043593-27202-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog102.obsmtp.com (na3sys009aog102.obsmtp.com
	[74.125.149.69])
	by alsa0.perex.cz (Postfix) with ESMTP id BBB921038DF
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Sep 2011 15:26:59 +0200 (CEST)
Received: by mail-gw0-f44.google.com with SMTP id 15so7227074gwj.17
	for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2011 06:26:58 -0700 (PDT)
In-Reply-To: <1317043593-27202-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

The Handsfree gain have 2dB steps all the way, so there is no
reason to have different delays as we approaching to the
end of the scale.
The comment was also wrong, since we have 0dB at 0x3 raw, at 16 the gain
is -26dB.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/twl6040.c |   12 ++----------
 1 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 659a235..580cb1c 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -524,7 +524,6 @@ static void twl6040_pga_hf_work(struct work_struct *work)
 		container_of(work, struct twl6040_data, handsfree.work.work);
 	struct snd_soc_codec *codec = priv->codec;
 	struct twl6040_output *handsfree = &priv->handsfree;
-	unsigned int delay = handsfree->step_delay;
 	int i, handsfree_complete;
 
 	/* do we need to ramp at all ? */
@@ -544,15 +543,8 @@ static void twl6040_pga_hf_work(struct work_struct *work)
 		if (handsfree_complete)
 			break;
 
-		/*
-		 * TODO: tune: delay is longer over 0dB
-		 * as increases are larger.
-		 */
-		if (i >= 16)
-			schedule_timeout_interruptible(msecs_to_jiffies(delay +
-						       (delay >> 1)));
-		else
-			schedule_timeout_interruptible(msecs_to_jiffies(delay));
+		schedule_timeout_interruptible(
+				msecs_to_jiffies(handsfree->step_delay));
 	}
 
 
-- 
1.7.6.1
