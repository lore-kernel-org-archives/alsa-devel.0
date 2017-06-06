From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH] ASoC: topology: Allow bespoke configuration
	post widget creation
Date: Tue,  6 Jun 2017 15:45:07 +0100
Message-ID: <1496760309-6195-2-git-send-email-liam.r.girdwood@linux.intel.com>
References: <1496760309-6195-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id AAD31266F07
 for <alsa-devel@alsa-project.org>; Tue,  6 Jun 2017 16:45:20 +0200 (CEST)
In-Reply-To: <1496760309-6195-1-git-send-email-liam.r.girdwood@linux.intel.com>
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

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 sound/soc/soc-topology.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 002772e3ba2c..273a374e741c 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -344,12 +344,24 @@ static int soc_tplg_widget_load(struct soc_tplg *tplg,
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
-	struct snd_soc_dai_driver *dai_drv)
+	struct snd_soc_dai_driver *dai_drv,
+	struct snd_soc_tplg_pcm *pcm, struct snd_soc_dai *dai)
 {
 	if (tplg->comp && tplg->ops && tplg->ops->dai_load)
-		return tplg->ops->dai_load(tplg->comp, dai_drv);
+		return tplg->ops->dai_load(tplg->comp, dai_drv, pcm, dai);
 
 	return 0;
 }
@@ -1580,8 +1592,16 @@ static int soc_tplg_dapm_widget_create(struct soc_tplg *tplg,
 	kfree(template.sname);
 	kfree(template.name);
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
