From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 08/13] ASoC: Lower priority of resume work
	logging
Date: Tue, 25 Nov 2008 15:44:44 +0000
Message-ID: <1227627889-8373-8-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081125154302.GA8319@rakim.wolfsonmicro.main>
	<1227627889-8373-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227627889-8373-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227627889-8373-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227627889-8373-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227627889-8373-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227627889-8373-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227627889-8373-7-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1C1F2244A0
	for <alsa-devel@alsa-project.org>; Tue, 25 Nov 2008 16:44:53 +0100 (CET)
In-Reply-To: <1227627889-8373-7-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Now that the ASoC resume has been punted to a workqueue for a release
cycle without attracting bug reports it should be safe to make the
log messages associated with it debug level, reducing noise and kernel
size in production configurations.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 0d47696..dbd92e1 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -693,7 +693,7 @@ static void soc_resume_deferred(struct work_struct *work)
 	 * so userspace apps are blocked from touching us
 	 */
 
-	dev_info(socdev->dev, "starting resume work\n");
+	dev_dbg(socdev->dev, "starting resume work\n");
 
 	if (card->resume_pre)
 		card->resume_pre(pdev);
@@ -736,7 +736,7 @@ static void soc_resume_deferred(struct work_struct *work)
 	if (card->resume_post)
 		card->resume_post(pdev);
 
-	dev_info(socdev->dev, "resume work completed\n");
+	dev_dbg(socdev->dev, "resume work completed\n");
 
 	/* userspace can access us now we are back as we were before */
 	snd_power_change_state(codec->card, SNDRV_CTL_POWER_D0);
@@ -747,10 +747,10 @@ static int soc_resume(struct platform_device *pdev)
 {
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
 
-	dev_info(socdev->dev, "scheduling resume work\n");
+	dev_dbg(socdev->dev, "scheduling resume work\n");
 
 	if (!schedule_work(&socdev->deferred_resume_work))
-		dev_err(socdev->dev, "work item may be lost\n");
+		dev_err(socdev->dev, "resume work item may be lost\n");
 
 	return 0;
 }
-- 
1.5.6.5
