From: mengdong.lin@linux.intel.com
Subject: [PATCH 11/13] ASoC: Define API to find a dai link by id
Date: Fri, 19 Aug 2016 18:14:24 +0800
Message-ID: <a65ddd06141249a1d6c7569d93a0639f96095b43.1471599648.git.mengdong.lin@linux.intel.com>
References: <cover.1471599648.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 583F3266D7B
 for <alsa-devel@alsa-project.org>; Fri, 19 Aug 2016 12:08:32 +0200 (CEST)
In-Reply-To: <cover.1471599648.git.mengdong.lin@linux.intel.com>
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, mengdong.lin@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, hardik.t.shah@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

Topology can use this to check if a BE link already exists, and create
a new link if not found.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 4f1c784..d52601a 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1671,6 +1671,8 @@ int snd_soc_add_dai_link(struct snd_soc_card *card,
 				struct snd_soc_dai_link *dai_link);
 void snd_soc_remove_dai_link(struct snd_soc_card *card,
 			     struct snd_soc_dai_link *dai_link);
+struct snd_soc_dai_link *snd_soc_find_dai_link(struct snd_soc_card *card,
+					       int id);
 
 int snd_soc_register_dai(struct snd_soc_component *component,
 	struct snd_soc_dai_driver *dai_drv);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index f6f5027..6b1d198 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -972,6 +972,22 @@ struct snd_soc_dai *snd_soc_find_dai(
 }
 EXPORT_SYMBOL_GPL(snd_soc_find_dai);
 
+struct snd_soc_dai_link *snd_soc_find_dai_link(
+	struct snd_soc_card *card, int id)
+{
+	struct snd_soc_dai_link *link, *_link;
+
+	lockdep_assert_held(&client_mutex);
+
+	list_for_each_entry_safe(link, _link, &card->dai_link_list, list) {
+		if (link->id == id)
+			return link;
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
2.5.0
