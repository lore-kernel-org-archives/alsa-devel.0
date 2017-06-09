From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: Allow bespoke configuration
	post widget creation" to the asoc tree
Date: Fri, 09 Jun 2017 18:40:12 +0100
Message-ID: <E1dJNtM-0006zW-M9@debutante>
References: <1497019403-5484-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 30F212676A0
 for <alsa-devel@alsa-project.org>; Fri,  9 Jun 2017 19:40:20 +0200 (CEST)
In-Reply-To: <1497019403-5484-1-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: topology: Allow bespoke configuration post widget creation

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

>From 0c2b5c7983ec376e20e5a063556ee39a455c9d66 Mon Sep 17 00:00:00 2001
From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Date: Fri, 9 Jun 2017 15:43:23 +0100
Subject: [PATCH] ASoC: topology: Allow bespoke configuration post widget
 creation

Current topology only allows for widget configuration before the widget
is registered. This patch also allows further configuration and usage
after registration is complete.

Changes v1. Fix build by removing part of an unrelated patch.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
