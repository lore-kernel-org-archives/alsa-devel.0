From: mengdong.lin@linux.intel.com
Subject: [PATCH 12/13] ASoC: Probe link components after
	finding new links
Date: Fri, 19 Aug 2016 18:14:32 +0800
Message-ID: <823f27d0ca644b75c29246715d0c9c06d3ceb49f.1471599648.git.mengdong.lin@linux.intel.com>
References: <cover.1471599648.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 46BB6266D87
 for <alsa-devel@alsa-project.org>; Fri, 19 Aug 2016 12:08:40 +0200 (CEST)
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

Probing link components may bring new links from topolgy and these new
links may need new components. So there will be multiple rounds of
components probing until there is no new links found during the process.

Probing of aux_dev is moved earlier to simply the code. There is no need
to probe aux_devices multiple times.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 6b1d198..dbd2169 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1862,6 +1862,7 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 	struct snd_soc_pcm_runtime *rtd;
 	struct snd_soc_dai_link *dai_link;
 	int ret, i, order;
+	bool find_new_link; /* topolgy may create new links */
 
 	mutex_lock(&client_mutex);
 	mutex_lock_nested(&card->mutex, SND_SOC_CARD_CLASS_INIT);
@@ -1934,7 +1935,13 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 			goto card_probe_error;
 	}
 
+	/* probe auxiliary components */
+	ret = soc_probe_aux_devices(card);
+	if (ret < 0)
+		goto probe_dai_err;
+
 	/* probe all components used by DAI links on this card */
+probe_link_cmpnt:
 	for (order = SND_SOC_COMP_ORDER_FIRST; order <= SND_SOC_COMP_ORDER_LAST;
 			order++) {
 		list_for_each_entry(rtd, &card->rtd_list, list) {
@@ -1948,18 +1955,15 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 		}
 	}
 
-	/* probe auxiliary components */
-	ret = soc_probe_aux_devices(card);
-	if (ret < 0)
-		goto probe_dai_err;
-
 	/* Find new DAI links added during probing components and bind them.
 	 * Components with topology may bring new DAIs and DAI links.
 	 */
+	find_new_link = false;
 	list_for_each_entry(dai_link, &card->dai_link_list, list) {
 		if (soc_is_dai_link_bound(card, dai_link))
 			continue;
 
+		find_new_link = true;
 		ret = soc_init_dai_link(card, dai_link);
 		if (ret)
 			goto probe_dai_err;
@@ -1968,6 +1972,9 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 			goto probe_dai_err;
 	}
 
+	if (find_new_link) /* new link may have unprobed components */
+		goto probe_link_cmpnt;
+
 	/* probe all DAI links on this card */
 	for (order = SND_SOC_COMP_ORDER_FIRST; order <= SND_SOC_COMP_ORDER_LAST;
 			order++) {
-- 
2.5.0
