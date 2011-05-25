From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH] ASoC: core: Don't schedule
	deferred_resume_work twice
Date: Wed, 25 May 2011 14:06:41 -0600
Message-ID: <1306354001-5629-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 4C21E1037EA
	for <alsa-devel@alsa-project.org>;
	Wed, 25 May 2011 22:06:52 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@ti.com
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

For cards that have two or more DAIs, snd_soc_resume's loop over all
DAIs ends up calling schedule_work(deferred_resume_work) once per DAI.
Since this is the same work item each time, the 2nd and subsequent
calls return 0 (work item already queued), and trigger the dev_err
message below stating that a work item may have been lost.

Solve this by adjusting the loop to simply calculate whether to run the
resume work immediately or defer it, and then call schedule work (or not)
one time based on that.

Note: This has not been tested in mainline, but only in chromeos-2.6.38;
mainline doesn't support suspend/resume on Tegra, nor does the mainline
Tegra ASoC driver contain multiple DAIs. It has been compile-checked in
mainline.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/soc/soc-core.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index a477e21..c261eeb 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1256,7 +1256,7 @@ static void soc_resume_deferred(struct work_struct *work)
 int snd_soc_resume(struct device *dev)
 {
 	struct snd_soc_card *card = dev_get_drvdata(dev);
-	int i;
+	int i, ac97_control = 0;
 
 	/* AC97 devices might have other drivers hanging off them so
 	 * need to resume immediately.  Other drivers don't have that
@@ -1265,14 +1265,15 @@ int snd_soc_resume(struct device *dev)
 	 */
 	for (i = 0; i < card->num_rtd; i++) {
 		struct snd_soc_dai *cpu_dai = card->rtd[i].cpu_dai;
-		if (cpu_dai->driver->ac97_control) {
-			dev_dbg(dev, "Resuming AC97 immediately\n");
-			soc_resume_deferred(&card->deferred_resume_work);
-		} else {
-			dev_dbg(dev, "Scheduling resume work\n");
-			if (!schedule_work(&card->deferred_resume_work))
-				dev_err(dev, "resume work item may be lost\n");
-		}
+		ac97_control |= cpu_dai->driver->ac97_control;
+	}
+	if (ac97_control) {
+		dev_dbg(dev, "Resuming AC97 immediately\n");
+		soc_resume_deferred(&card->deferred_resume_work);
+	} else {
+		dev_dbg(dev, "Scheduling resume work\n");
+		if (!schedule_work(&card->deferred_resume_work))
+			dev_err(dev, "resume work item may be lost\n");
 	}
 
 	return 0;
-- 
1.7.0.4
