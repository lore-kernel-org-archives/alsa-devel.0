From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Back out post commit widget creation
	changes" to the asoc tree
Date: Thu, 08 Jun 2017 17:45:06 +0100
Message-ID: <E1dJ0YU-0001xt-57@debutante>
References: <20170608161054.31842-1-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 54BC326725C
 for <alsa-devel@alsa-project.org>; Thu,  8 Jun 2017 18:45:15 +0200 (CEST)
In-Reply-To: <20170608161054.31842-1-broonie@kernel.org>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Back out post commit widget creation changes

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 102ebe266c317da59471e2cde0dce603de031482 Mon Sep 17 00:00:00 2001
From: Mark Brown <broonie@kernel.org>
Date: Thu, 8 Jun 2017 17:02:02 +0100
Subject: [PATCH] ASoC: Back out post commit widget creation changes

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
