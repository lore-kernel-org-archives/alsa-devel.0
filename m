From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH v2] ASoC: topology: Allow bespoke configuration
	post widget creation
Date: Fri,  9 Jun 2017 15:43:23 +0100
Message-ID: <1497019403-5484-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id D72A626765C
 for <alsa-devel@alsa-project.org>; Fri,  9 Jun 2017 16:43:56 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Current topology only allows for widget configuration before the widget
is registered. This patch also allows further configuration and usage
after registration is complete.

Changes v1. Fix build by removing part of an unrelated patch.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 include/sound/soc-topology.h |  3 +++
 sound/soc/soc-topology.c     | 19 +++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/sound/soc-topology.h b/include/sound/soc-topology.h
index b8da221615e0..f552c3f56368 100644
--- a/include/sound/soc-topology.h
+++ b/include/sound/soc-topology.h
@@ -118,6 +118,9 @@ struct snd_soc_tplg_ops {
 	int (*widget_load)(struct snd_soc_component *,
 		struct snd_soc_dapm_widget *,
 		struct snd_soc_tplg_dapm_widget *);
+	int (*widget_ready)(struct snd_soc_component *,
+		struct snd_soc_dapm_widget *,
+		struct snd_soc_tplg_dapm_widget *);
 	int (*widget_unload)(struct snd_soc_component *,
 		struct snd_soc_dobj *);
 
diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index f4ec236a418e..12e189701924 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -344,6 +344,17 @@ static int soc_tplg_widget_load(struct soc_tplg *tplg,
 	return 0;
 }
 
+/* optionally pass new dynamic widget to component driver. This is mainly for
+ * external widgets where we can assign private data/ops */
+static int soc_tplg_widget_ready(struct soc_tplg *tplg,
+	struct snd_soc_dapm_widget *w, struct snd_soc_tplg_dapm_widget *tplg_w)
+{
+	if (tplg->comp && tplg->ops && tplg->ops->widget_ready)
+		return tplg->ops->widget_ready(tplg->comp, w, tplg_w);
+
+	return 0;
+}
+
 /* pass DAI configurations to component driver for extra initialization */
 static int soc_tplg_dai_load(struct soc_tplg *tplg,
 	struct snd_soc_dai_driver *dai_drv)
@@ -1579,8 +1590,16 @@ static int soc_tplg_dapm_widget_create(struct soc_tplg *tplg,
 	widget->dobj.ops = tplg->ops;
 	widget->dobj.index = tplg->index;
 	list_add(&widget->dobj.list, &tplg->comp->dobj_list);
+
+	ret = soc_tplg_widget_ready(tplg, widget, w);
+	if (ret < 0)
+		goto ready_err;
+
 	return 0;
 
+ready_err:
+	snd_soc_tplg_widget_remove(widget);
+	snd_soc_dapm_free_widget(widget);
 hdr_err:
 	kfree(template.sname);
 err:
-- 
2.11.0
