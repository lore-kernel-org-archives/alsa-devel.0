From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH v2 4/6] ASoC: topology: Add callback for DAPM
	route load/unload
Date: Tue, 27 Mar 2018 14:30:43 +0100
Message-ID: <20180327133045.29351-5-liam.r.girdwood@linux.intel.com>
References: <20180327133045.29351-1-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 8BC2826718B
 for <alsa-devel@alsa-project.org>; Tue, 27 Mar 2018 15:31:05 +0200 (CEST)
In-Reply-To: <20180327133045.29351-1-liam.r.girdwood@linux.intel.com>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Add a callback fro clients for notification about DAPM route loading and
unloading.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 include/sound/soc-topology.h |  7 +++++++
 sound/soc/soc-topology.c     | 13 +++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/sound/soc-topology.h b/include/sound/soc-topology.h
index e1f265e21ee1..401ef2c45d6c 100644
--- a/include/sound/soc-topology.h
+++ b/include/sound/soc-topology.h
@@ -32,6 +32,7 @@ struct snd_kcontrol_new;
 struct snd_soc_dai_link;
 struct snd_soc_dai_driver;
 struct snd_soc_dai;
+struct snd_soc_dapm_route;
 
 /* object scan be loaded and unloaded in groups with identfying indexes */
 #define SND_SOC_TPLG_INDEX_ALL	0	/* ID that matches all FW objects */
@@ -116,6 +117,12 @@ struct snd_soc_tplg_ops {
 	int (*control_unload)(struct snd_soc_component *,
 		struct snd_soc_dobj *);
 
+	/* DAPM graph route element loading and unloading */
+	int (*dapm_route_load)(struct snd_soc_component *, int index,
+		struct snd_soc_dapm_route *route);
+	int (*dapm_route_unload)(struct snd_soc_component *,
+		struct snd_soc_dobj *);
+
 	/* external widget init - used for any driver specific init */
 	int (*widget_load)(struct snd_soc_component *, int index,
 		struct snd_soc_dapm_widget *,
diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index c43515d218ea..b1970a05ba44 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1161,6 +1161,17 @@ static int soc_tplg_kcontrol_elems_load(struct soc_tplg *tplg,
 	return 0;
 }
 
+/* optionally pass new dynamic kcontrol to component driver. */
+static int soc_tplg_add_route(struct soc_tplg *tplg,
+	struct snd_soc_dapm_route *route)
+{
+	if (tplg->comp && tplg->ops && tplg->ops->dapm_route_load)
+		return tplg->ops->dapm_route_load(tplg->comp, tplg->index,
+			route);
+
+	return 0;
+}
+
 static int soc_tplg_dapm_graph_elems_load(struct soc_tplg *tplg,
 	struct snd_soc_tplg_hdr *hdr)
 {
@@ -1209,6 +1220,8 @@ static int soc_tplg_dapm_graph_elems_load(struct soc_tplg *tplg,
 		else
 			route.control = elem->control;
 
+		soc_tplg_add_route(tplg, &route);
+
 		/* add route, but keep going if some fail */
 		snd_soc_dapm_add_routes(dapm, &route, 1);
 	}
-- 
2.14.1
