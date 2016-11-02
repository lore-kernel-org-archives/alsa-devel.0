From: mengdong.lin@linux.intel.com
Subject: [PATCH v7 06/11] ASoC: Define API to find a dai link
Date: Thu,  3 Nov 2016 01:04:12 +0800
Message-ID: <3dc6e000bf95a0ec17c407b6d349b50f0d6568d0.1478071138.git.mengdong.lin@linux.intel.com>
References: <cover.1478071138.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A6562666FA
 for <alsa-devel@alsa-project.org>; Wed,  2 Nov 2016 18:02:48 +0100 (CET)
In-Reply-To: <cover.1478071138.git.mengdong.lin@linux.intel.com>
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, rakesh.a.ughreja@intel.com, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

Define the API to find an existing DAI link of the soc card by matching
the ID, name and stream name.

Some cards may use unique ID for each DAI link, so matching ID is enough,
and name or stream name are not necessary. But user need to specify name
or stream name as well if not sure whether link ID is unique since most
cards use 0 as the default link ID.

Topology can use this API to find an existing BE link and configure it.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 4f1c784..c3a38ee 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1671,6 +1671,9 @@ int snd_soc_add_dai_link(struct snd_soc_card *card,
 				struct snd_soc_dai_link *dai_link);
 void snd_soc_remove_dai_link(struct snd_soc_card *card,
 			     struct snd_soc_dai_link *dai_link);
+struct snd_soc_dai_link *snd_soc_find_dai_link(struct snd_soc_card *card,
+					       int id, const char *name,
+					       const char *stream_name);
 
 int snd_soc_register_dai(struct snd_soc_component *component,
 	struct snd_soc_dai_driver *dai_drv);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index c0bbcd9..a7a1ca4 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -972,6 +972,48 @@ struct snd_soc_dai *snd_soc_find_dai(
 }
 EXPORT_SYMBOL_GPL(snd_soc_find_dai);
 
+
+/**
+ * snd_soc_find_dai_link - Find a DAI link
+ *
+ * @card: soc card
+ * @id: DAI link ID to match
+ * @name: DAI link name to match, optional
+ * @stream name: DAI link stream name to match, optional
+ *
+ * This function will search all existing DAI links of the soc card to
+ * find the link of the same ID. Since DAI links may not have their
+ * unique ID, so name and stream name should also match if being
+ * specified.
+ *
+ * Return: pointer of DAI link, or NULL if not found.
+ */
+struct snd_soc_dai_link *snd_soc_find_dai_link(struct snd_soc_card *card,
+					       int id, const char *name,
+					       const char *stream_name)
+{
+	struct snd_soc_dai_link *link, *_link;
+
+	lockdep_assert_held(&client_mutex);
+
+	list_for_each_entry_safe(link, _link, &card->dai_link_list, list) {
+		if (link->id != id)
+			continue;
+
+		if (name && (!link->name || strcmp(name, link->name)))
+			continue;
+
+		if (stream_name && (!link->stream_name
+			|| strcmp(stream_name, link->stream_name)))
+			continue;
+
+		return link;
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(snd_soc_find_dai_link);
+
 static bool soc_is_dai_link_bound(struct snd_soc_card *card,
 		struct snd_soc_dai_link *dai_link)
 {
-- 
2.7.4
