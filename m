From: mengdong.lin@intel.com
Subject: [RFC PATCH 04/10] ASoC: implement DAI links in a list.
Date: Mon, 10 Aug 2015 14:13:09 +0800
Message-ID: <1439187189-1101-1-git-send-email-mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A81B265327
 for <alsa-devel@alsa-project.org>; Mon, 10 Aug 2015 08:00:02 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Mengdong Lin <mengdong.lin@intel.com>, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@intel.com>

Implement a dai link list for the soc card.
And API snd_soc_add_dai_link() is defined for machine drivers to add DAI
links dynamically based on topology.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/include/sound/soc.h b/include/sound/soc.h
index e2b7b0f..79891e2 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1011,6 +1011,8 @@ struct snd_soc_dai_link {
 
 	/* pmdown_time is ignored at stop */
 	unsigned int ignore_pmdown_time:1;
+
+	struct list_head list; /* dai link list of the soc card */
 };
 
 struct snd_soc_codec_conf {
@@ -1078,8 +1080,11 @@ struct snd_soc_card {
 	long pmdown_time;
 
 	/* CPU <--> Codec DAI links  */
-	struct snd_soc_dai_link *dai_link;
-	int num_links;
+	struct snd_soc_dai_link *dai_link;  /* predefined links only */
+	int num_links;  /* predefined links only */
+	struct list_head dai_link_list; /* all links except the dummy ones */
+	int num_dai_links;
+
 	struct list_head rtd_list;
 	int num_rtd;
 
@@ -1619,6 +1624,9 @@ int snd_soc_of_get_dai_link_codecs(struct device *dev,
 				   struct device_node *of_node,
 				   struct snd_soc_dai_link *dai_link);
 
+void snd_soc_add_dai_link(struct snd_soc_card *card,
+				struct snd_soc_dai_link *dai_link);
+
 #include <sound/soc-dai.h>
 
 #ifdef CONFIG_DEBUG_FS
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index ddfdd1d..58eac57 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1235,6 +1235,27 @@ static int soc_init_dai_link(struct snd_soc_card *card,
 	return 0;
 }
 
+/**
+ * snd_soc_add_dai_link - Add a DAI link dynamically
+ * @card: The ASoC card to which the DAI link is added
+ * @dai_link: The new DAI link to add
+ *
+ * This function adds a DAI link to the ASoC card, and creates a ASoC
+ * runtime for the link.
+ *
+ * Note: For adding DAI links dynamically by machine drivers based on
+ * the topology info when probing the platform component. And machine
+ * drivers can still define static DAI links in dai_link array.
+ */
+void snd_soc_add_dai_link(struct snd_soc_card *card,
+		struct snd_soc_dai_link *dai_link)
+{
+	lockdep_assert_held(&client_mutex);
+	list_add_tail(&dai_link->list, &card->dai_link_list);
+	card->num_dai_links++;
+}
+EXPORT_SYMBOL_GPL(snd_soc_add_dai_link);
+
 static void soc_set_name_prefix(struct snd_soc_card *card,
 				struct snd_soc_component *component)
 {
@@ -1729,6 +1750,10 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 			goto base_error;
 	}
 
+	/* all predefined resources are ready, store non-dummy links */
+	for (i = 0; i < card->num_links; i++)
+		snd_soc_add_dai_link(card, card->dai_link+i);
+
 	/* initialize the register cache for each available codec */
 	list_for_each_entry(codec, &codec_list, list) {
 		if (codec->cache_init)
@@ -2486,6 +2511,9 @@ int snd_soc_register_card(struct snd_soc_card *card)
 
 	snd_soc_initialize_card_lists(card);
 
+	INIT_LIST_HEAD(&card->dai_link_list);
+	card->num_dai_links = 0;
+
 	INIT_LIST_HEAD(&card->rtd_list);
 	card->num_rtd = 0;
 
-- 
1.9.1
