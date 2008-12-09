From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 10/18] ASoC: Add card registration API
Date: Tue,  9 Dec 2008 14:01:34 +0000
Message-ID: <1228831302-17605-10-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 029DA10384D
	for <alsa-devel@alsa-project.org>; Tue,  9 Dec 2008 15:01:46 +0100 (CET)
In-Reply-To: <1228831302-17605-9-git-send-email-broonie@opensource.wolfsonmicro.com>
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

ASoC v2 allows cards, codecs and platforms to instantiate separately,
with the overall ASoC device only being instantiated once all the
required components have registered. As part of backporting Liam's work
introduce an initial version of the card registration functions. At
present these do nothing active and are internal only, they will be
exposed to machine drivers after further backporting.  Adding this now
allows the datastructures used for dynamic card instantiation to be
built up gradually.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc.h  |    5 ++++
 sound/soc/soc-core.c |   62 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 79d855d..4a578b5 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -333,6 +333,11 @@ struct snd_soc_dai_link  {
 /* SoC card */
 struct snd_soc_card {
 	char *name;
+	struct device *dev;
+
+	struct list_head list;
+
+	int instantiated;
 
 	int (*probe)(struct platform_device *pdev);
 	int (*remove)(struct platform_device *pdev);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 2f2a8d9..44fbd71 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -43,6 +43,12 @@ static DECLARE_WAIT_QUEUE_HEAD(soc_pm_waitq);
 static struct dentry *debugfs_root;
 #endif
 
+static DEFINE_MUTEX(client_mutex);
+static LIST_HEAD(card_list);
+
+static int snd_soc_register_card(struct snd_soc_card *card);
+static int snd_soc_unregister_card(struct snd_soc_card *card);
+
 /*
  * This is a timeout to do a DAPM powerdown after a stream is closed().
  * It can be used to eliminate pops between different playback streams, e.g.
@@ -784,6 +790,14 @@ static int soc_probe(struct platform_device *pdev)
 	/* Bodge while we push things out of socdev */
 	card->socdev = socdev;
 
+	/* Bodge while we unpick instantiation */
+	card->dev = &pdev->dev;
+	ret = snd_soc_register_card(card);
+	if (ret != 0) {
+		dev_err(&pdev->dev, "Failed to register card\n");
+		return ret;
+	}
+
 	if (card->probe) {
 		ret = card->probe(pdev);
 		if (ret < 0)
@@ -863,6 +877,8 @@ static int soc_remove(struct platform_device *pdev)
 	if (card->remove)
 		card->remove(pdev);
 
+	snd_soc_unregister_card(card);
+
 	return 0;
 }
 
@@ -1957,6 +1973,52 @@ int snd_soc_dai_digital_mute(struct snd_soc_dai *dai, int mute)
 }
 EXPORT_SYMBOL_GPL(snd_soc_dai_digital_mute);
 
+/**
+ * snd_soc_register_card - Register a card with the ASoC core
+ *
+ * @param card Card to register
+ *
+ * Note that currently this is an internal only function: it will be
+ * exposed to machine drivers after further backporting of ASoC v2
+ * registration APIs.
+ */
+static int snd_soc_register_card(struct snd_soc_card *card)
+{
+	if (!card->name || !card->dev)
+		return -EINVAL;
+
+	INIT_LIST_HEAD(&card->list);
+	card->instantiated = 0;
+
+	mutex_lock(&client_mutex);
+	list_add(&card->list, &card_list);
+	mutex_unlock(&client_mutex);
+
+	dev_dbg(card->dev, "Registered card '%s'\n", card->name);
+
+	return 0;
+}
+
+/**
+ * snd_soc_unregister_card - Unregister a card with the ASoC core
+ *
+ * @param card Card to unregister
+ *
+ * Note that currently this is an internal only function: it will be
+ * exposed to machine drivers after further backporting of ASoC v2
+ * registration APIs.
+ */
+static int snd_soc_unregister_card(struct snd_soc_card *card)
+{
+	mutex_lock(&client_mutex);
+	list_del(&card->list);
+	mutex_unlock(&client_mutex);
+
+	dev_dbg(card->dev, "Unregistered card '%s'\n", card->name);
+
+	return 0;
+}
+
 static int __devinit snd_soc_init(void)
 {
 #ifdef CONFIG_DEBUG_FS
-- 
1.5.6.5
