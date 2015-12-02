From: mengdong.lin@linux.intel.com
Subject: [PATCH 2/5] ASoC: Define add/remove_dai_link ops for a
	soc card
Date: Wed,  2 Dec 2015 14:11:32 +0800
Message-ID: <a7aecce7622d5206339f18e43521da8e46d43445.1449036307.git.mengdong.lin@linux.intel.com>
References: <cover.1449036307.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id D0BD5264F03
 for <alsa-devel@alsa-project.org>; Wed,  2 Dec 2015 06:55:24 +0100 (CET)
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

A machine driver can register the two ops.

When a DAI link is added or removed by a component's topology, the
ASoC core can call the ops to notify the machine driver for extra
intialization or destruction.

E.g. topology can create FE DAI links from a cpu DAI component, and
the machine driver may define an add_dai_link ops to set machine-specific
.init ops for the DAI link.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/sound/soc.h b/include/sound/soc.h
index d1583df..f28b36e 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1107,6 +1107,11 @@ struct snd_soc_card {
 				   struct snd_soc_dapm_context *dapm,
 				   enum snd_soc_bias_level level);
 
+	int (*add_dai_link)(struct snd_soc_card *,
+			    struct snd_soc_dai_link *link);
+	void (*remove_dai_link)(struct snd_soc_card *,
+			    struct snd_soc_dai_link *link);
+
 	long pmdown_time;
 
 	/* CPU <--> Codec DAI links  */
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 679379d..c504d04 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1260,6 +1260,12 @@ int snd_soc_add_dai_link(struct snd_soc_card *card,
 	}
 
 	lockdep_assert_held(&client_mutex);
+	/* Notify the machine driver for extra initialization
+	 * on the link created by topology.
+	 */
+	if (dai_link->dobj.type && card->add_dai_link)
+		card->add_dai_link(card, dai_link);
+
 	list_add_tail(&dai_link->list, &card->dai_link_list);
 	card->num_dai_links++;
 
@@ -1290,6 +1296,12 @@ void snd_soc_remove_dai_link(struct snd_soc_card *card,
 	}
 
 	lockdep_assert_held(&client_mutex);
+	/* Notify the machine driver for extra destruction
+	 * on the link created by topology.
+	 */
+	if (dai_link->dobj.type && card->remove_dai_link)
+		card->remove_dai_link(card, dai_link);
+
 	list_for_each_entry_safe(link, _link, &card->dai_link_list, list) {
 		if (link == dai_link) {
 			list_del(&link->list);
-- 
2.5.0
