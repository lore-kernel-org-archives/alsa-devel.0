From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 4/4] ASoC: twl6040: Simplify code in
	out_drv_event for pending work check
Date: Wed, 28 Sep 2011 14:16:33 +0300
Message-ID: <1317208593-21142-5-git-send-email-peter.ujfalusi@ti.com>
References: <1317208593-21142-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog109.obsmtp.com (na3sys009aog109.obsmtp.com
	[74.125.149.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 5D9EA103A59
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Sep 2011 13:17:13 +0200 (CEST)
Received: by bkbzu17 with SMTP id zu17so10386521bkb.24
	for <alsa-devel@alsa-project.org>; Wed, 28 Sep 2011 04:17:11 -0700 (PDT)
In-Reply-To: <1317208593-21142-1-git-send-email-peter.ujfalusi@ti.com>
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

Check for pending work before the DAPM event switch case, and return,
if the work is pending.
This way we can remove the two additional checks in POST_PMU, and
PRE_PMD for non pending works.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/twl6040.c |   25 +++++++++++--------------
 1 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index c2b5829..e2e6c66 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -585,37 +585,34 @@ static int out_drv_event(struct snd_soc_dapm_widget *w,
 
 	work = &out->work;
 
+	if (delayed_work_pending(work))
+		return 0;
+
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
