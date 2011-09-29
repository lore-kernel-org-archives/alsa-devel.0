From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 4/4] ASoC: twl6040: Simplify code in
	out_drv_event for pending work check
Date: Thu, 29 Sep 2011 15:22:37 +0300
Message-ID: <1317298957-30366-5-git-send-email-peter.ujfalusi@ti.com>
References: <1317298957-30366-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog119.obsmtp.com (na3sys009aog119.obsmtp.com
	[74.125.149.246])
	by alsa0.perex.cz (Postfix) with ESMTP id 5FD2E1038D2
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Sep 2011 14:22:49 +0200 (CEST)
Received: by mail-bw0-f53.google.com with SMTP id zt12so720817bkb.26
	for <alsa-devel@alsa-project.org>; Thu, 29 Sep 2011 05:22:48 -0700 (PDT)
In-Reply-To: <1317298957-30366-1-git-send-email-peter.ujfalusi@ti.com>
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

Instead of checking, if the work is pending, it is safer to cancel
the pending work, or wait till the scheduled work finishes.
This way we can avoid modifying the variables used by the work
function.
Since we know that no work is pending, we can remove the two additional
checks in POST_PMU, and PRE_PMD for non pending works.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/twl6040.c |   38 ++++++++++++++++++++++----------------
 1 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index c2b5829..efcb28b 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -565,12 +565,26 @@ static int out_drv_event(struct snd_soc_dapm_widget *w,
 	switch (w->shift) {
 	case 2: /* Headset output driver */
 		out = &priv->headset;
+		work = &out->work;
+		/*
+		 * Make sure, that we do not mess up variables for already
+		 * executing work.
+		 */
+		cancel_delayed_work_sync(work);
+
 		out->left_step = priv->hs_left_step;
 		out->right_step = priv->hs_right_step;
 		out->step_delay = 5;	/* 5 ms between volume ramp steps */
 		break;
 	case 4: /* Handsfree output driver */
 		out = &priv->handsfree;
+		work = &out->work;
+		/*
+		 * Make sure, that we do not mess up variables for already
+		 * executing work.
+		 */
+		cancel_delayed_work_sync(work);
+
 		out->left_step = priv->hf_left_step;
 		out->right_step = priv->hf_right_step;
 		out->step_delay = 5;	/* 5 ms between volume ramp steps */
@@ -583,39 +597,31 @@ static int out_drv_event(struct snd_soc_dapm_widget *w,
 		return -1;
 	}
 
-	work = &out->work;
-
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
 		if (out->active)
 			break;
 
 		/* don't use volume ramp for power-up */
+		out->ramp = TWL6040_RAMP_UP;
 		out->left_step = out->left_vol;
 		out->right_step = out->right_vol;
 
-		if (!delayed_work_pending(work)) {
-			out->ramp = TWL6040_RAMP_UP;
-			queue_delayed_work(priv->workqueue, work,
-					msecs_to_jiffies(1));
-		}
+		queue_delayed_work(priv->workqueue, work, msecs_to_jiffies(1));
 		break;
 
 	case SND_SOC_DAPM_PRE_PMD:
 		if (!out->active)
 			break;
 
-		if (!delayed_work_pending(work)) {
-			/* use volume ramp for power-down */
-			out->ramp = TWL6040_RAMP_DOWN;
-			INIT_COMPLETION(out->ramp_done);
+		/* use volume ramp for power-down */
+		out->ramp = TWL6040_RAMP_DOWN;
+		INIT_COMPLETION(out->ramp_done);
 
-			queue_delayed_work(priv->workqueue, work,
-					msecs_to_jiffies(1));
+		queue_delayed_work(priv->workqueue, work, msecs_to_jiffies(1));
 
-			wait_for_completion_timeout(&out->ramp_done,
-					msecs_to_jiffies(2000));
-		}
+		wait_for_completion_timeout(&out->ramp_done,
+					    msecs_to_jiffies(2000));
 		break;
 	}
 
-- 
1.7.6.1
