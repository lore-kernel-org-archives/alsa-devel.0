From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 16/18] ASoC: Initial framework for dynamic card
	instantiation
Date: Tue,  9 Dec 2008 14:01:40 +0000
Message-ID: <1228831302-17605-16-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081209140101.GA17558@rakim.wolfsonmicro.main>
	<1228831302-17605-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-7-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-8-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-9-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-10-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-11-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-12-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-13-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-14-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-15-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 157E0103846
	for <alsa-devel@alsa-project.org>; Tue,  9 Dec 2008 15:01:46 +0100 (CET)
In-Reply-To: <1228831302-17605-15-git-send-email-broonie@opensource.wolfsonmicro.com>
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

Use the lists of platforms, platform DAIs and cards to check to see that
everything has registered. Since relationships are still specified by
direct references to the structures in the drivers and the drivers all
register everything at modprobe there should be no practical effect yet.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c |   97 ++++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 78 insertions(+), 19 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index ffae370..717db0e 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -780,30 +780,54 @@ static int soc_resume(struct platform_device *pdev)
 #define soc_resume	NULL
 #endif
 
-/* probes a new socdev */
-static int soc_probe(struct platform_device *pdev)
-{
-	int ret = 0, i;
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_card *card = socdev->card;
-	struct snd_soc_platform *platform = card->platform;
-	struct snd_soc_codec_device *codec_dev = socdev->codec_dev;
-
-	/* Bodge while we push things out of socdev */
-	card->socdev = socdev;
+static void snd_soc_instantiate_card(struct snd_soc_card *card)
+{
+	struct platform_device *pdev = container_of(card->dev,
+						    struct platform_device,
+						    dev);
+	struct snd_soc_codec_device *codec_dev = card->socdev->codec_dev;
+	struct snd_soc_platform *platform;
+	struct snd_soc_dai *dai;
+	int i, found, ret;
+
+	if (card->instantiated)
+		return;
+
+	found = 0;
+	list_for_each_entry(platform, &platform_list, list)
+		if (card->platform == platform) {
+			found = 1;
+			break;
+		}
+	if (!found) {
+		dev_dbg(card->dev, "Platform %s not registered\n",
+			card->platform->name);
+		return;
+	}
 
-	/* Bodge while we unpick instantiation */
-	card->dev = &pdev->dev;
-	ret = snd_soc_register_card(card);
-	if (ret != 0) {
-		dev_err(&pdev->dev, "Failed to register card\n");
-		return ret;
+	for (i = 0; i < card->num_links; i++) {
+		found = 0;
+		list_for_each_entry(dai, &dai_list, list)
+			if (card->dai_link[i].cpu_dai == dai) {
+				found = 1;
+				break;
+			}
+		if (!found) {
+			dev_dbg(card->dev, "DAI %s not registered\n",
+				card->dai_link[i].cpu_dai->name);
+			return;
+		}
 	}
 
+	/* Note that we do not current check for codec components */
+
+	dev_dbg(card->dev, "All components present, instantiating\n");
+
+	/* Found everything, bring it up */
 	if (card->probe) {
 		ret = card->probe(pdev);
 		if (ret < 0)
-			return ret;
+			return;
 	}
 
 	for (i = 0; i < card->num_links; i++) {
@@ -834,7 +858,9 @@ static int soc_probe(struct platform_device *pdev)
 	INIT_WORK(&card->deferred_resume_work, soc_resume_deferred);
 #endif
 
-	return 0;
+	card->instantiated = 1;
+
+	return;
 
 platform_err:
 	if (codec_dev->remove)
@@ -849,8 +875,38 @@ cpu_dai_err:
 
 	if (card->remove)
 		card->remove(pdev);
+}
 
-	return ret;
+/*
+ * Attempt to initialise any uninitalised cards.  Must be called with
+ * client_mutex.
+ */
+static void snd_soc_instantiate_cards(void)
+{
+	struct snd_soc_card *card;
+	list_for_each_entry(card, &card_list, list)
+		snd_soc_instantiate_card(card);
+}
+
+/* probes a new socdev */
+static int soc_probe(struct platform_device *pdev)
+{
+	int ret = 0;
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_card *card = socdev->card;
+
+	/* Bodge while we push things out of socdev */
+	card->socdev = socdev;
+
+	/* Bodge while we unpick instantiation */
+	card->dev = &pdev->dev;
+	ret = snd_soc_register_card(card);
+	if (ret != 0) {
+		dev_err(&pdev->dev, "Failed to register card\n");
+		return ret;
+	}
+
+	return 0;
 }
 
 /* removes a socdev */
@@ -1994,6 +2050,7 @@ static int snd_soc_register_card(struct snd_soc_card *card)
 
 	mutex_lock(&client_mutex);
 	list_add(&card->list, &card_list);
+	snd_soc_instantiate_cards();
 	mutex_unlock(&client_mutex);
 
 	dev_dbg(card->dev, "Registered card '%s'\n", card->name);
@@ -2039,6 +2096,7 @@ int snd_soc_register_dai(struct snd_soc_dai *dai)
 
 	mutex_lock(&client_mutex);
 	list_add(&dai->list, &dai_list);
+	snd_soc_instantiate_cards();
 	mutex_unlock(&client_mutex);
 
 	pr_debug("Registered DAI '%s'\n", dai->name);
@@ -2117,6 +2175,7 @@ int snd_soc_register_platform(struct snd_soc_platform *platform)
 
 	mutex_lock(&client_mutex);
 	list_add(&platform->list, &platform_list);
+	snd_soc_instantiate_cards();
 	mutex_unlock(&client_mutex);
 
 	pr_debug("Registered platform '%s'\n", platform->name);
-- 
1.5.6.5
