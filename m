From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH v2] ASoC: topology: Add callback for DAPM route
	load/unload
Date: Thu, 14 Jun 2018 20:53:59 +0100
Message-ID: <20180614195359.12027-1-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 95CC326760A
 for <alsa-devel@alsa-project.org>; Thu, 14 Jun 2018 21:54:05 +0200 (CEST)
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

Changes since V1:
 - Fixed merge conflict with recent component model update.

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
index a30bb94fc800..ed8c00b43ef9 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1105,6 +1105,17 @@ static int soc_tplg_kcontrol_elems_load(struct soc_tplg *tplg,
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
@@ -1153,6 +1164,8 @@ static int soc_tplg_dapm_graph_elems_load(struct soc_tplg *tplg,
 		else
 			route.control = elem->control;
 
+		soc_tplg_add_route(tplg, &route);
+
 		/* add route, but keep going if some fail */
 		snd_soc_dapm_add_routes(dapm, &route, 1);
 	}
-- 
2.17.1
