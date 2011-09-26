From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 10/10] ASoC: twl6040: Simplify code in
	out_drv_event for pending work check
Date: Mon, 26 Sep 2011 16:26:33 +0300
Message-ID: <1317043593-27202-11-git-send-email-peter.ujfalusi@ti.com>
References: <1317043593-27202-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog106.obsmtp.com (na3sys009aob106.obsmtp.com
	[74.125.149.76]) by alsa0.perex.cz (Postfix) with ESMTP id 2C496243AF
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Sep 2011 15:27:02 +0200 (CEST)
Received: by mail-yx0-f181.google.com with SMTP id 30so5915740yxk.26
	for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2011 06:27:02 -0700 (PDT)
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

Check for pending work before the DAPM event switch case, and return,
if the work is pending.
This way we can remove the two additional checks in POST_PMU, and
PRE_PMD for non pending works.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/twl6040.c |   25 +++++++++++--------------
 1 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 7ad209f..23506d5 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -587,37 +587,34 @@ static int out_drv_event(struct snd_soc_dapm_widget *w,
 
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
