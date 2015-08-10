From: mengdong.lin@intel.com
Subject: [RFC PATCH 06/10] ASoC: bind new DAI links after
	probing components.
Date: Mon, 10 Aug 2015 14:13:26 +0800
Message-ID: <1439187206-1199-1-git-send-email-mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id A49242651BE
 for <alsa-devel@alsa-project.org>; Mon, 10 Aug 2015 08:00:08 +0200 (CEST)
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

Probing components can bring new DAI or DAI links based on the topology
info. This patch finds the unbound DAI links and bind them.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index f552fa0..2818709 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1169,6 +1169,19 @@ static void soc_remove_dai_links(struct snd_soc_card *card)
 	}
 }
 
+static bool soc_is_dai_link_bound(struct snd_soc_card *card,
+		struct snd_soc_dai_link *dai_link)
+{
+	struct snd_soc_pcm_runtime *rtd;
+
+	list_for_each_entry(rtd, &card->rtd_list, list) {
+		if (rtd->dai_link == dai_link)
+			return true;
+	}
+
+	return false;
+}
+
 static int snd_soc_init_multicodec(struct snd_soc_card *card,
 				   struct snd_soc_dai_link *dai_link)
 {
@@ -1763,6 +1776,7 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 {
 	struct snd_soc_codec *codec;
 	struct snd_soc_pcm_runtime *rtd;
+	struct snd_soc_dai_link *dai_link;
 	int ret, i, order;
 
 	mutex_lock(&client_mutex);
@@ -1853,6 +1867,21 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 	/* no longer need dummy runtimes */
 	soc_remove_dummy_pcm_runtimes(card);
 
+	/* Find new DAI links added during probing components and bind them.
+	 * Components with topology may bring new DAIs and DAI links.
+	 */
+	list_for_each_entry(dai_link, &card->dai_link_list, list) {
+		if (dai_link->dummy || soc_is_dai_link_bound(card, dai_link))
+			continue;
+
+		ret = soc_init_dai_link(card, dai_link);
+		if (ret)
+			goto probe_dai_err;
+		ret = soc_bind_dai_link(card, dai_link);
+		if (ret)
+			goto probe_dai_err;
+	}
+
 	/* probe all DAI links on this card */
 	for (order = SND_SOC_COMP_ORDER_FIRST; order <= SND_SOC_COMP_ORDER_LAST;
 			order++) {
-- 
1.9.1
