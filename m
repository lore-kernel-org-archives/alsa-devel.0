From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: Back out post commit widget creation
	changes
Date: Thu,  8 Jun 2017 17:10:54 +0100
Message-ID: <20170608161054.31842-1-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 11EB126725C
 for <alsa-devel@alsa-project.org>; Thu,  8 Jun 2017 18:11:12 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Due to build errors revert commit c8597af855f3 (ASoC: topology: Allow
bespoke configuration post widget creation) until they can be fixed.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-topology.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 7006cf3007b5..f4ec236a418e 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -344,24 +344,12 @@ static int soc_tplg_widget_load(struct soc_tplg *tplg,
 	return 0;
 }
 
-/* optionally pass new dynamic widget to component driver. This is mainly for
- * external widgets where we can assign private data/ops */
-static int soc_tplg_widget_ready(struct soc_tplg *tplg,
-	struct snd_soc_dapm_widget *w, struct snd_soc_tplg_dapm_widget *tplg_w)
-{
-	if (tplg->comp && tplg->ops && tplg->ops->widget_ready)
-		return tplg->ops->widget_ready(tplg->comp, w, tplg_w);
-
-	return 0;
-}
-
 /* pass DAI configurations to component driver for extra initialization */
 static int soc_tplg_dai_load(struct soc_tplg *tplg,
-	struct snd_soc_dai_driver *dai_drv,
-	struct snd_soc_tplg_pcm *pcm, struct snd_soc_dai *dai)
+	struct snd_soc_dai_driver *dai_drv)
 {
 	if (tplg->comp && tplg->ops && tplg->ops->dai_load)
-		return tplg->ops->dai_load(tplg->comp, dai_drv, pcm, dai);
+		return tplg->ops->dai_load(tplg->comp, dai_drv);
 
 	return 0;
 }
@@ -1591,16 +1579,8 @@ static int soc_tplg_dapm_widget_create(struct soc_tplg *tplg,
 	widget->dobj.ops = tplg->ops;
 	widget->dobj.index = tplg->index;
 	list_add(&widget->dobj.list, &tplg->comp->dobj_list);
-
-	ret = soc_tplg_widget_ready(tplg, widget, w);
-	if (ret < 0)
-		goto ready_err;
-
 	return 0;
 
-ready_err:
-	snd_soc_tplg_widget_remove(widget);
-	snd_soc_dapm_free_widget(widget);
 hdr_err:
 	kfree(template.sname);
 err:
-- 
2.11.0
