From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH] ASoC: Use card as parameter to exported PM
	functions
Date: Thu, 27 Jan 2011 11:56:56 -0700
Message-ID: <1296154616-1209-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id F17FC103806
	for <alsa-devel@alsa-project.org>; Thu, 27 Jan 2011 19:57:08 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

If a machine driver is going to use the exported snd_soc_suspend/resume,
at present, the platform device's drvdata must be the snd_soc_card. This
prevents the machine driver from placing its own custom drvdata into the
platform device.

This patch reworks the exported PM functions to take the card instead of the
dev, thus allowing machine drivers to use a custom drvdata type. The
disadvantage is that every machine driver that does this must then implement
something similar to the soc_suspend/resume_dev functions in this patch.

An alternative might be to add a drvdata field to struct snd_soc_card,
accompanied by snd_soc_set/get_drvdata functions.

Another alternative would be to wrap the snd_soc_card stored in the drvdata
within another type, and use container_of whenever the machine driver needed
the data in the wrapper type.

This patch is hence more of a question of "do we want to do it this way",
rather than a concrete proposed patch.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 include/sound/soc.h  |    6 +++---
 sound/soc/soc-core.c |   46 ++++++++++++++++++++++++++++++++--------------
 2 files changed, 35 insertions(+), 17 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 7ecdaef..96ae31d 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -260,9 +260,9 @@ enum snd_soc_compress_type {
 
 int snd_soc_register_card(struct snd_soc_card *card);
 int snd_soc_unregister_card(struct snd_soc_card *card);
-int snd_soc_suspend(struct device *dev);
-int snd_soc_resume(struct device *dev);
-int snd_soc_poweroff(struct device *dev);
+int snd_soc_suspend(struct snd_soc_card *card);
+int snd_soc_resume(struct snd_soc_card *card);
+int snd_soc_poweroff(struct snd_soc_card *card);
 int snd_soc_register_platform(struct device *dev,
 		struct snd_soc_platform_driver *platform_drv);
 void snd_soc_unregister_platform(struct device *dev);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index e9f81c5..b72110c 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -972,9 +972,8 @@ static struct snd_pcm_ops soc_pcm_ops = {
 
 #ifdef CONFIG_PM_SLEEP
 /* powers down audio subsystem for suspend */
-int snd_soc_suspend(struct device *dev)
+int snd_soc_suspend(struct snd_soc_card *card)
 {
-	struct snd_soc_card *card = dev_get_drvdata(dev);
 	struct snd_soc_codec *codec;
 	int i;
 
@@ -1088,6 +1087,13 @@ int snd_soc_suspend(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(snd_soc_suspend);
 
+static int soc_suspend_dev(struct device *dev)
+{
+	struct snd_soc_card *card = dev_get_drvdata(dev);
+
+	return snd_soc_suspend(card);
+}
+
 /* deferred resume work, so resume can complete before we finished
  * setting our codec back up, which can be very slow on I2C
  */
@@ -1192,9 +1198,8 @@ static void soc_resume_deferred(struct work_struct *work)
 }
 
 /* powers up audio subsystem after a suspend */
-int snd_soc_resume(struct device *dev)
+int snd_soc_resume(struct snd_soc_card *card)
 {
-	struct snd_soc_card *card = dev_get_drvdata(dev);
 	int i;
 
 	/* AC97 devices might have other drivers hanging off them so
@@ -1205,21 +1210,28 @@ int snd_soc_resume(struct device *dev)
 	for (i = 0; i < card->num_rtd; i++) {
 		struct snd_soc_dai *cpu_dai = card->rtd[i].cpu_dai;
 		if (cpu_dai->driver->ac97_control) {
-			dev_dbg(dev, "Resuming AC97 immediately\n");
+			dev_dbg(card->dev, "Resuming AC97 immediately\n");
 			soc_resume_deferred(&card->deferred_resume_work);
 		} else {
-			dev_dbg(dev, "Scheduling resume work\n");
+			dev_dbg(card->dev, "Scheduling resume work\n");
 			if (!schedule_work(&card->deferred_resume_work))
-				dev_err(dev, "resume work item may be lost\n");
+				dev_err(card->dev, "resume work item may be lost\n");
 		}
 	}
 
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_soc_resume);
+
+static int soc_resume_dev(struct device *dev)
+{
+	struct snd_soc_card *card = dev_get_drvdata(dev);
+
+	return snd_soc_resume(card);
+}
 #else
-#define snd_soc_suspend NULL
-#define snd_soc_resume NULL
+#define soc_suspend_dev NULL
+#define soc_resume_dev NULL
 #endif
 
 static struct snd_soc_dai_ops null_dai_ops = {
@@ -1926,9 +1938,8 @@ static int soc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-int snd_soc_poweroff(struct device *dev)
+int snd_soc_poweroff(struct snd_soc_card *card)
 {
-	struct snd_soc_card *card = dev_get_drvdata(dev);
 	int i;
 
 	if (!card->instantiated)
@@ -1947,10 +1958,17 @@ int snd_soc_poweroff(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(snd_soc_poweroff);
 
+static int soc_poweroff_dev(struct device *dev)
+{
+	struct snd_soc_card *card = dev_get_drvdata(dev);
+
+	return snd_soc_poweroff(card);
+}
+
 const struct dev_pm_ops snd_soc_pm_ops = {
-	.suspend = snd_soc_suspend,
-	.resume = snd_soc_resume,
-	.poweroff = snd_soc_poweroff,
+	.suspend = soc_suspend_dev,
+	.resume = soc_resume_dev,
+	.poweroff = soc_poweroff_dev,
 };
 
 /* ASoC platform driver */
-- 
1.7.1
