From: mengdong.lin@linux.intel.com
Subject: [PATCH v2 05/13] ASoC: Implement DAI links in a list &
	define API to add a link
Date: Thu,  5 Nov 2015 17:59:02 +0800
Message-ID: <86b51c69423940d3c05c1f5fb9a58c1a65afa341.1446717205.git.mengdong.lin@linux.intel.com>
References: <cover.1446717205.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 20AF9265CAC
 for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2015 10:43:36 +0100 (CET)
In-Reply-To: <cover.1446717205.git.mengdong.lin@linux.intel.com>
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, mengdong.lin@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, jeeja.kp@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

Implement a dai link list for the soc card.

Add API snd_soc_add_dai_link() to add an DAI links dynamically, e.g.
based on topology.

The predefined DAI links are reserved to keep backward compatibility, and
they will also be added to the list.

Open:
No API to remove a DAI link from the list, because there is no request
from topology atm. When machine driver is removed, the dynamically added
links need to be removed and freed. Need a clear working flow.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 232b30d..60e5fda 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1037,6 +1037,8 @@ struct snd_soc_dai_link {
 
 	/* pmdown_time is ignored at stop */
 	unsigned int ignore_pmdown_time:1;
+
+	struct list_head list; /* dai link list of the soc card */
 };
 
 struct snd_soc_codec_conf {
@@ -1104,8 +1106,11 @@ struct snd_soc_card {
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
 
@@ -1647,6 +1652,9 @@ int snd_soc_of_get_dai_link_codecs(struct device *dev,
 				   struct device_node *of_node,
 				   struct snd_soc_dai_link *dai_link);
 
+void snd_soc_add_dai_link(struct snd_soc_card *card,
+				struct snd_soc_dai_link *dai_link);
+
 #include <sound/soc-dai.h>
 
 #ifdef CONFIG_DEBUG_FS
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 878a9fe..c855e30 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1228,6 +1228,27 @@ static int soc_init_dai_link(struct snd_soc_card *card,
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
@@ -1722,6 +1743,10 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 			goto base_error;
 	}
 
+	/* add predefined DAI links to the list */
+	for (i = 0; i < card->num_links; i++)
+		snd_soc_add_dai_link(card, card->dai_link+i);
+
 	/* initialize the register cache for each available codec */
 	list_for_each_entry(codec, &codec_list, list) {
 		if (codec->cache_init)
@@ -2479,6 +2504,9 @@ int snd_soc_register_card(struct snd_soc_card *card)
 
 	snd_soc_initialize_card_lists(card);
 
+	INIT_LIST_HEAD(&card->dai_link_list);
+	card->num_dai_links = 0;
+
 	INIT_LIST_HEAD(&card->rtd_list);
 	card->num_rtd = 0;
 
-- 
1.9.1
