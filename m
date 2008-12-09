From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 11/18] ASoC: Add DAI registration API
Date: Tue,  9 Dec 2008 14:01:35 +0000
Message-ID: <1228831302-17605-11-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6BC2B103857
	for <alsa-devel@alsa-project.org>; Tue,  9 Dec 2008 15:01:47 +0100 (CET)
In-Reply-To: <1228831302-17605-10-git-send-email-broonie@opensource.wolfsonmicro.com>
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

Add API calls to register and unregister DAIs with the core.  Currently
these APIs are ineffective.  Since multiple DAIs for a given device are
a common case bulk variants are provided.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc-dai.h |    8 ++++
 sound/soc/soc-core.c    |   83 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index e2d5f76..24247f7 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -100,6 +100,12 @@ struct snd_soc_dai_ops;
 struct snd_soc_dai;
 struct snd_ac97_bus_ops;
 
+/* Digital Audio Interface registration */
+int snd_soc_register_dai(struct snd_soc_dai *dai);
+void snd_soc_unregister_dai(struct snd_soc_dai *dai);
+int snd_soc_register_dais(struct snd_soc_dai *dai, size_t count);
+void snd_soc_unregister_dais(struct snd_soc_dai *dai, size_t count);
+
 /* Digital Audio Interface clocking API.*/
 int snd_soc_dai_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 	unsigned int freq, int dir);
@@ -186,6 +192,8 @@ struct snd_soc_dai {
 	unsigned int id;
 	int ac97_control;
 
+	struct device *dev;
+
 	/* DAI callbacks */
 	int (*probe)(struct platform_device *pdev,
 		     struct snd_soc_dai *dai);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 44fbd71..03460b0 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -45,6 +45,7 @@ static struct dentry *debugfs_root;
 
 static DEFINE_MUTEX(client_mutex);
 static LIST_HEAD(card_list);
+static LIST_HEAD(dai_list);
 
 static int snd_soc_register_card(struct snd_soc_card *card);
 static int snd_soc_unregister_card(struct snd_soc_card *card);
@@ -2019,6 +2020,88 @@ static int snd_soc_unregister_card(struct snd_soc_card *card)
 	return 0;
 }
 
+/**
+ * snd_soc_register_dai - Register a DAI with the ASoC core
+ *
+ * @param dai DAI to register
+ */
+int snd_soc_register_dai(struct snd_soc_dai *dai)
+{
+	if (!dai->name)
+		return -EINVAL;
+
+	/* The device should become mandatory over time */
+	if (!dai->dev)
+		printk(KERN_WARNING "No device for DAI %s\n", dai->name);
+
+	INIT_LIST_HEAD(&dai->list);
+
+	mutex_lock(&client_mutex);
+	list_add(&dai->list, &dai_list);
+	mutex_unlock(&client_mutex);
+
+	pr_debug("Registered DAI '%s'\n", dai->name);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_register_dai);
+
+/**
+ * snd_soc_unregister_dai - Unregister a DAI from the ASoC core
+ *
+ * @param dai DAI to unregister
+ */
+void snd_soc_unregister_dai(struct snd_soc_dai *dai)
+{
+	mutex_lock(&client_mutex);
+	list_del(&dai->list);
+	mutex_unlock(&client_mutex);
+
+	pr_debug("Unregistered DAI '%s'\n", dai->name);
+}
+EXPORT_SYMBOL_GPL(snd_soc_unregister_dai);
+
+/**
+ * snd_soc_register_dais - Register multiple DAIs with the ASoC core
+ *
+ * @param dai Array of DAIs to register
+ * @param count Number of DAIs
+ */
+int snd_soc_register_dais(struct snd_soc_dai *dai, size_t count)
+{
+	int i, ret;
+
+	for (i = 0; i < count; i++) {
+		ret = snd_soc_register_dai(&dai[i]);
+		if (ret != 0)
+			goto err;
+	}
+
+	return 0;
+
+err:
+	for (i--; i >= 0; i--)
+		snd_soc_unregister_dai(&dai[i]);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snd_soc_register_dais);
+
+/**
+ * snd_soc_unregister_dais - Unregister multiple DAIs from the ASoC core
+ *
+ * @param dai Array of DAIs to unregister
+ * @param count Number of DAIs
+ */
+void snd_soc_unregister_dais(struct snd_soc_dai *dai, size_t count)
+{
+	int i;
+
+	for (i = 0; i < count; i++)
+		snd_soc_unregister_dai(&dai[i]);
+}
+EXPORT_SYMBOL_GPL(snd_soc_unregister_dais);
+
 static int __devinit snd_soc_init(void)
 {
 #ifdef CONFIG_DEBUG_FS
-- 
1.5.6.5
