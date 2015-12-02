From: mengdong.lin@linux.intel.com
Subject: [PATCH 1/5] ASoC: Implement DAI links in a list &
	define API to add/remove a link
Date: Wed,  2 Dec 2015 14:11:22 +0800
Message-ID: <55f372688ae3e96e0403147f53f7891483318aa4.1449036307.git.mengdong.lin@linux.intel.com>
References: <cover.1449036307.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id C58A5264F03
 for <alsa-devel@alsa-project.org>; Wed,  2 Dec 2015 06:55:16 +0100 (CET)
In-Reply-To: <cover.1449036307.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, vinod.koul@intel.com, mengdong.lin@intel.com, liam.r.girdwood@linux.intel.com, jeeja.kp@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

Implement a dai link list for the soc card.

Add APIs to add/remove a DAI links dynamically, e.g. by topology.

And a dobj is embedded into the struct snd_soc_dai_link. Topology can
use the dobj to find the links created by it and remove them when the
topology component is unloaded.

The predefined DAI links are reserved to keep backward compatibility.
And they will also be added to the list.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 03431e7..d1583df 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1040,6 +1040,9 @@ struct snd_soc_dai_link {
 
 	/* pmdown_time is ignored at stop */
 	unsigned int ignore_pmdown_time:1;
+
+	struct list_head list; /* DAI link list of the soc card */
+	struct snd_soc_dobj dobj; /* For topology */
 };
 
 struct snd_soc_codec_conf {
@@ -1107,8 +1110,11 @@ struct snd_soc_card {
 	long pmdown_time;
 
 	/* CPU <--> Codec DAI links  */
-	struct snd_soc_dai_link *dai_link;
-	int num_links;
+	struct snd_soc_dai_link *dai_link;  /* predefined links only */
+	int num_links;  /* predefined links only */
+	struct list_head dai_link_list; /* all links */
+	int num_dai_links;
+
 	struct list_head rtd_list;
 	int num_rtd;
 
@@ -1652,6 +1658,11 @@ int snd_soc_of_get_dai_link_codecs(struct device *dev,
 				   struct device_node *of_node,
 				   struct snd_soc_dai_link *dai_link);
 
+int snd_soc_add_dai_link(struct snd_soc_card *card,
+				struct snd_soc_dai_link *dai_link);
+void snd_soc_remove_dai_link(struct snd_soc_card *card,
+			     struct snd_soc_dai_link *dai_link);
+
 #include <sound/soc-dai.h>
 
 #ifdef CONFIG_DEBUG_FS
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 40682b0..679379d 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1120,6 +1120,7 @@ static void soc_remove_dai_links(struct snd_soc_card *card)
 {
 	int order;
 	struct snd_soc_pcm_runtime *rtd;
+	struct snd_soc_dai_link *link, *_link;
 
 	for (order = SND_SOC_COMP_ORDER_FIRST; order <= SND_SOC_COMP_ORDER_LAST;
 			order++) {
@@ -1132,6 +1133,15 @@ static void soc_remove_dai_links(struct snd_soc_card *card)
 		list_for_each_entry(rtd, &card->rtd_list, list)
 			soc_remove_link_components(card, rtd, order);
 	}
+
+	list_for_each_entry_safe(link, _link, &card->dai_link_list, list) {
+		if (link->dobj.type == SND_SOC_DOBJ_DAI_LINK)
+			dev_warn(card->dev, "Topology forgot to remove link %s?\n",
+				link->name);
+
+		list_del(&link->list);
+		card->num_dai_links--;
+	}
 }
 
 static int snd_soc_init_multicodec(struct snd_soc_card *card,
@@ -1228,6 +1238,68 @@ static int soc_init_dai_link(struct snd_soc_card *card,
 	return 0;
 }
 
+/**
+ * snd_soc_add_dai_link - Add a DAI link dynamically
+ * @card: The ASoC card to which the DAI link is added
+ * @dai_link: The new DAI link to add
+ *
+ * This function adds a DAI link to the ASoC card's link list.
+ *
+ * Note: Topology can use this API to add DAI links when probing the
+ * topology component. And machine drivers can still define static
+ * DAI links in dai_link array.
+ */
+int snd_soc_add_dai_link(struct snd_soc_card *card,
+		struct snd_soc_dai_link *dai_link)
+{
+	if (dai_link->dobj.type
+	    && dai_link->dobj.type != SND_SOC_DOBJ_DAI_LINK) {
+		dev_err(card->dev, "Invalid dai link type %d\n",
+			dai_link->dobj.type);
+		return -EINVAL;
+	}
+
+	lockdep_assert_held(&client_mutex);
+	list_add_tail(&dai_link->list, &card->dai_link_list);
+	card->num_dai_links++;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_add_dai_link);
+
+/**
+ * snd_soc_remove_dai_link - Remove a DAI link from the list
+ * @card: The ASoC card that owns the link
+ * @dai_link: The DAI link to remove
+ *
+ * This function removes a DAI link from the ASoC card's link list.
+ *
+ * For DAI links previously added by topology, topology should
+ * remove them by using the dobj embedded in the link.
+ */
+void snd_soc_remove_dai_link(struct snd_soc_card *card,
+			     struct snd_soc_dai_link *dai_link)
+{
+	struct snd_soc_dai_link *link, *_link;
+
+	if (dai_link->dobj.type
+	    && dai_link->dobj.type != SND_SOC_DOBJ_DAI_LINK) {
+		dev_err(card->dev, "Invalid dai link type %d\n",
+			dai_link->dobj.type);
+		return;
+	}
+
+	lockdep_assert_held(&client_mutex);
+	list_for_each_entry_safe(link, _link, &card->dai_link_list, list) {
+		if (link == dai_link) {
+			list_del(&link->list);
+			card->num_dai_links--;
+			return;
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(snd_soc_remove_dai_link);
+
 static void soc_set_name_prefix(struct snd_soc_card *card,
 				struct snd_soc_component *component)
 {
@@ -1722,6 +1794,10 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 			goto base_error;
 	}
 
+	/* add predefined DAI links to the list */
+	for (i = 0; i < card->num_links; i++)
+		snd_soc_add_dai_link(card, card->dai_link+i);
+
 	/* initialize the register cache for each available codec */
 	list_for_each_entry(codec, &codec_list, list) {
 		if (codec->cache_init)
@@ -2479,6 +2555,9 @@ int snd_soc_register_card(struct snd_soc_card *card)
 
 	snd_soc_initialize_card_lists(card);
 
+	INIT_LIST_HEAD(&card->dai_link_list);
+	card->num_dai_links = 0;
+
 	INIT_LIST_HEAD(&card->rtd_list);
 	card->num_rtd = 0;
 
-- 
2.5.0
