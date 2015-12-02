From: mengdong.lin@linux.intel.com
Subject: [PATCH 4/5] ASoC: Bind new DAI links after probing
	components
Date: Wed,  2 Dec 2015 14:11:48 +0800
Message-ID: <79cf9079e131823657203e1bcce4964b1bbd3bd5.1449036307.git.mengdong.lin@linux.intel.com>
References: <cover.1449036307.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 70980265090
 for <alsa-devel@alsa-project.org>; Wed,  2 Dec 2015 06:55:54 +0100 (CET)
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

Probing components can bring new DAI or DAI links based on the topology
info. This patch finds the unbound DAI links and bind them.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 9dada21..19f7486 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1806,6 +1806,7 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 {
 	struct snd_soc_codec *codec;
 	struct snd_soc_pcm_runtime *rtd;
+	struct snd_soc_dai_link *dai_link;
 	int ret, i, order;
 
 	mutex_lock(&client_mutex);
@@ -1893,6 +1894,21 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 		}
 	}
 
+	/* Find new DAI links added during probing components and bind them.
+	 * Components with topology may bring new DAIs and DAI links.
+	 */
+	list_for_each_entry(dai_link, &card->dai_link_list, list) {
+		if (soc_is_dai_link_bound(card, dai_link))
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
2.5.0
