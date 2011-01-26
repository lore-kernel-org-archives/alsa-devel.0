From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/3] ASoC: Export card PM callbacks for use in
	direct registered cards
Date: Wed, 26 Jan 2011 17:08:29 +0000
Message-ID: <1296061709-12494-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1296061709-12494-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0D2EC2459B
	for <alsa-devel@alsa-project.org>; Wed, 26 Jan 2011 18:08:37 +0100 (CET)
In-Reply-To: <1296061709-12494-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

Allow hookup of cards registered directly with the core to the PM
operations by exporting the device power management operations to
modules, also exporting the default PM operations since it is
expected that most cards will end up using exactly the same setup.

Note that the callbacks require that the driver data for the card be
the snd_soc_card.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc.h  |    5 +++++
 sound/soc/soc-core.c |   34 +++++++++++++++++-----------------
 2 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index a6a9013..4fd79e0 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -261,6 +261,9 @@ enum snd_soc_compress_type {
 
 int snd_soc_register_card(struct snd_soc_card *card);
 int snd_soc_unregister_card(struct snd_soc_card *card);
+int snd_soc_suspend(struct device *dev);
+int snd_soc_resume(struct device *dev);
+int snd_soc_poweroff(struct device *dev);
 int snd_soc_register_platform(struct device *dev,
 		struct snd_soc_platform_driver *platform_drv);
 void snd_soc_unregister_platform(struct device *dev);
@@ -803,4 +806,6 @@ static inline void snd_soc_initialize_card_lists(struct snd_soc_card *card)
 extern struct dentry *snd_soc_debugfs_root;
 #endif
 
+extern const struct dev_pm_ops snd_soc_pm_ops;
+
 #endif
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 4bc2365..5dffc7a4 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -965,12 +965,11 @@ static struct snd_pcm_ops soc_pcm_ops = {
 	.pointer	= soc_pcm_pointer,
 };
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 /* powers down audio subsystem for suspend */
-static int soc_suspend(struct device *dev)
+int snd_soc_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct snd_soc_card *card = platform_get_drvdata(pdev);
+	struct snd_soc_card *card = dev_get_drvdata(dev);
 	struct snd_soc_codec *codec;
 	int i;
 
@@ -1082,6 +1081,7 @@ static int soc_suspend(struct device *dev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(snd_soc_suspend);
 
 /* deferred resume work, so resume can complete before we finished
  * setting our codec back up, which can be very slow on I2C
@@ -1187,10 +1187,9 @@ static void soc_resume_deferred(struct work_struct *work)
 }
 
 /* powers up audio subsystem after a suspend */
-static int soc_resume(struct device *dev)
+int snd_soc_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct snd_soc_card *card = platform_get_drvdata(pdev);
+	struct snd_soc_card *card = dev_get_drvdata(dev);
 	int i;
 
 	/* AC97 devices might have other drivers hanging off them so
@@ -1212,9 +1211,10 @@ static int soc_resume(struct device *dev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(snd_soc_resume);
 #else
-#define soc_suspend	NULL
-#define soc_resume	NULL
+#define snd_soc_suspend NULL
+#define snd_soc_resume NULL
 #endif
 
 static struct snd_soc_dai_ops null_dai_ops = {
@@ -1924,10 +1924,9 @@ static int soc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int soc_poweroff(struct device *dev)
+int snd_soc_poweroff(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct snd_soc_card *card = platform_get_drvdata(pdev);
+	struct snd_soc_card *card = dev_get_drvdata(dev);
 	int i;
 
 	if (!card->instantiated)
@@ -1944,11 +1943,12 @@ static int soc_poweroff(struct device *dev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(snd_soc_poweroff);
 
-static const struct dev_pm_ops soc_pm_ops = {
-	.suspend = soc_suspend,
-	.resume = soc_resume,
-	.poweroff = soc_poweroff,
+const struct dev_pm_ops snd_soc_pm_ops = {
+	.suspend = snd_soc_suspend,
+	.resume = snd_soc_resume,
+	.poweroff = snd_soc_poweroff,
 };
 
 /* ASoC platform driver */
@@ -1956,7 +1956,7 @@ static struct platform_driver soc_driver = {
 	.driver		= {
 		.name		= "soc-audio",
 		.owner		= THIS_MODULE,
-		.pm		= &soc_pm_ops,
+		.pm		= &snd_soc_pm_ops,
 	},
 	.probe		= soc_probe,
 	.remove		= soc_remove,
-- 
1.7.2.3
