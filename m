From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 07/10] ASoC: twl6040: No need to change delay
	during HS ramp
Date: Mon, 26 Sep 2011 16:26:30 +0300
Message-ID: <1317043593-27202-8-git-send-email-peter.ujfalusi@ti.com>
References: <1317043593-27202-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog113.obsmtp.com (na3sys009aog113.obsmtp.com
	[74.125.149.209])
	by alsa0.perex.cz (Postfix) with ESMTP id 2E3B3103897
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Sep 2011 15:26:57 +0200 (CEST)
Received: by mail-yx0-f181.google.com with SMTP id 30so5912639yxk.26
	for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2011 06:26:56 -0700 (PDT)
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

The Headset gain have 2dB steps all the way, so there is no
reason to have different delays as we approaching to the
end of the scale.
The comment was also wrong, since we have 0dB at 0x0 raw at
one end of the range, and not in the middle.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/twl6040.c |   12 ++----------
 1 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 5a33fe1..659a235 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -489,7 +489,6 @@ static void twl6040_pga_hs_work(struct work_struct *work)
 		container_of(work, struct twl6040_data, headset.work.work);
 	struct snd_soc_codec *codec = priv->codec;
 	struct twl6040_output *headset = &priv->headset;
-	unsigned int delay = headset->step_delay;
 	int i, headset_complete;
 
 	/* do we need to ramp at all ? */
@@ -506,15 +505,8 @@ static void twl6040_pga_hs_work(struct work_struct *work)
 		if (headset_complete)
 			break;
 
-		/*
-		 * TODO: tune: delay is longer over 0dB
-		 * as increases are larger.
-		 */
-		if (i >= 8)
-			schedule_timeout_interruptible(msecs_to_jiffies(delay +
-							(delay >> 1)));
-		else
-			schedule_timeout_interruptible(msecs_to_jiffies(delay));
+		schedule_timeout_interruptible(
+				msecs_to_jiffies(headset->step_delay));
 	}
 
 	if (headset->ramp == TWL6040_RAMP_DOWN) {
-- 
1.7.6.1
