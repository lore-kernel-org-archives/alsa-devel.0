From: mengdong.lin@linux.intel.com
Subject: [PATCH 5/5] ASoC: The soc card can have auxiliary
	components
Date: Wed,  2 Dec 2015 14:11:56 +0800
Message-ID: <bb343fe20b14af90f695939d8faae50fae1ba97a.1449036307.git.mengdong.lin@linux.intel.com>
References: <cover.1449036307.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 020902664FB
 for <alsa-devel@alsa-project.org>; Wed,  2 Dec 2015 06:55:48 +0100 (CET)
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

Machine drivers can set the name of one or more auxiliary components.
And the ASoC core will find and probe the auxiliary components.

Machine drivers can use this to specify the components with topology.
Then when the components are probed, topology info will be loaded to
the core.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/sound/soc.h b/include/sound/soc.h
index f28b36e..46c6492 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1074,6 +1074,11 @@ struct snd_soc_aux_dev {
 	int (*init)(struct snd_soc_component *component);
 };
 
+struct snd_soc_aux_component {
+	const char *name;
+	struct snd_soc_component *comp;
+};
+
 /* SoC card */
 struct snd_soc_card {
 	const char *name;
@@ -1120,6 +1125,10 @@ struct snd_soc_card {
 	struct list_head dai_link_list; /* all links */
 	int num_dai_links;
 
+	/* auxiliary components, e.g. topology */
+	struct snd_soc_aux_component *aux_components;
+	int num_aux_components;
+
 	struct list_head rtd_list;
 	int num_rtd;
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 19f7486..4ddc5d5 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1826,6 +1826,18 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 			goto base_error;
 	}
 
+	/* find auxiliary components */
+	for (i = 0; i < card->num_aux_components; i++) {
+		card->aux_components[i].comp =
+			soc_find_component(NULL, card->aux_components[i].name);
+		if (!card->aux_components[i].comp) {
+			dev_err(card->dev, "ASoC: Aux component %s not registered\n",
+				card->aux_components[i].name);
+			ret = -EPROBE_DEFER;
+			goto base_error;
+		}
+	}
+
 	/* add predefined DAI links to the list */
 	for (i = 0; i < card->num_links; i++)
 		snd_soc_add_dai_link(card, card->dai_link+i);
@@ -1880,6 +1892,21 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 			goto card_probe_error;
 	}
 
+	/* probe auxiliary components */
+	for (order = SND_SOC_COMP_ORDER_FIRST; order <= SND_SOC_COMP_ORDER_LAST;
+			order++) {
+		for (i = 0; i < card->num_aux_components; i++) {
+			ret = soc_probe_component(card,
+					card->aux_components[i].comp);
+			if (ret < 0) {
+				dev_err(card->dev,
+					"ASoC: failed to probe aux component %s %d\n",
+					card->aux_components[i].name, ret);
+				goto probe_dai_err;
+			}
+		}
+	}
+
 	/* probe all components used by DAI links on this card */
 	for (order = SND_SOC_COMP_ORDER_FIRST; order <= SND_SOC_COMP_ORDER_LAST;
 			order++) {
-- 
2.5.0
