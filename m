From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: Allow bespoke configuration
	post widget creation" to the asoc tree
Date: Wed, 07 Jun 2017 20:31:55 +0100
Message-ID: <E1dIggN-0003h7-VK@debutante>
References: <1496760309-6195-2-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D5E9326724B
 for <alsa-devel@alsa-project.org>; Wed,  7 Jun 2017 21:32:02 +0200 (CEST)
In-Reply-To: <1496760309-6195-2-git-send-email-liam.r.girdwood@linux.intel.com>
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

>From c8597af855f3e34aaebaff0e5c3dbd07611c87f1 Mon Sep 17 00:00:00 2001
From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Date: Tue, 6 Jun 2017 15:45:07 +0100
Subject: [PATCH] ASoC: topology: Allow bespoke configuration post widget
 creation

Current topology only allows for widget configuration before the widget
is registered. This patch also allows further configuration and usage
after registration is complete.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
