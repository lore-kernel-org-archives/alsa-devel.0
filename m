From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: Don't block system resume
Date: Fri, 13 Jun 2008 15:39:13 +0100
Message-ID: <1213367953-32239-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1213367953-32239-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A5CF5103822
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Jun 2008 16:39:14 +0200 (CEST)
In-Reply-To: <1213367953-32239-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Andy Green <andy@openmoko.com>
List-Id: alsa-devel@alsa-project.org

From: Andy Green <andy@openmoko.com>

On OpenMoko soc-audio resume is taking 700ms of the whole resume time of
1.3s, dominated by writes to the codec over I2C.  This patch shunts the
resume guts into a workqueue which then is done asynchronously.

The "card" is locked using the ALSA power state APIs as suggested by
Mark Brown.

[Added fix for race with resume to suspend and fixed a couple of nits
from checkpatch -- broonie.]

Signed-off-by: Andy Green <andy@openmoko.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc.h  |    1 +
 sound/soc/soc-core.c |   46 +++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 1f5c621..340223a 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -510,6 +510,7 @@ struct snd_soc_device {
 	struct snd_soc_codec *codec;
 	struct snd_soc_codec_device *codec_dev;
 	struct delayed_work delayed_work;
+	struct work_struct deferred_resume_work;
 	void *codec_data;
 };
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index c96a618..b931039 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -639,6 +639,16 @@ static int soc_suspend(struct platform_device *pdev, pm_message_t state)
 	struct snd_soc_codec *codec = socdev->codec;
 	int i;
 
+	/* Due to the resume being scheduled into a workqueue we could
+	* suspend before that's finished - wait for it to complete.
+	 */
+	snd_power_lock(codec->card);
+	snd_power_wait(codec->card, SNDRV_CTL_POWER_D0);
+	snd_power_unlock(codec->card);
+
+	/* we're going to block userspace touching us until resume completes */
+	snd_power_change_state(codec->card, SNDRV_CTL_POWER_D3hot);
+
 	/* mute any active DAC's */
 	for (i = 0; i < machine->num_links; i++) {
 		struct snd_soc_codec_dai *dai = machine->dai_link[i].codec_dai;
@@ -691,16 +701,27 @@ static int soc_suspend(struct platform_device *pdev, pm_message_t state)
 	return 0;
 }
 
-/* powers up audio subsystem after a suspend */
-static int soc_resume(struct platform_device *pdev)
+/* deferred resume work, so resume can complete before we finished
+ * setting our codec back up, which can be very slow on I2C
+ */
+static void soc_resume_deferred(struct work_struct *work)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_device *socdev = container_of(work,
+						     struct snd_soc_device,
+						     deferred_resume_work);
 	struct snd_soc_machine *machine = socdev->machine;
 	struct snd_soc_platform *platform = socdev->platform;
 	struct snd_soc_codec_device *codec_dev = socdev->codec_dev;
 	struct snd_soc_codec *codec = socdev->codec;
+	struct platform_device *pdev = to_platform_device(socdev->dev);
 	int i;
 
+	/* our power state is still SNDRV_CTL_POWER_D3hot from suspend time,
+	 * so userspace apps are blocked from touching us
+	 */
+
+	dev_info(socdev->dev, "starting resume work\n");
+
 	if (machine->resume_pre)
 		machine->resume_pre(pdev);
 
@@ -742,6 +763,22 @@ static int soc_resume(struct platform_device *pdev)
 	if (machine->resume_post)
 		machine->resume_post(pdev);
 
+	dev_info(socdev->dev, "resume work completed\n");
+
+	/* userspace can access us now we are back as we were before */
+	snd_power_change_state(codec->card, SNDRV_CTL_POWER_D0);
+}
+
+/* powers up audio subsystem after a suspend */
+static int soc_resume(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+
+	dev_info(socdev->dev, "scheduling resume work\n");
+
+	if (!schedule_work(&socdev->deferred_resume_work))
+		dev_err(socdev->dev, "work item may be lost\n");
+
 	return 0;
 }
 
@@ -788,6 +825,9 @@ static int soc_probe(struct platform_device *pdev)
 
 	/* DAPM stream work */
 	INIT_DELAYED_WORK(&socdev->delayed_work, close_delayed_work);
+	/* deferred resume work */
+	INIT_WORK(&socdev->deferred_resume_work, soc_resume_deferred);
+
 	return 0;
 
 platform_err:
-- 
1.5.5.4
