From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: Dont free template strings
	whilst they are in use." to the asoc tree
Date: Wed, 07 Jun 2017 20:31:48 +0100
Message-ID: <E1dIggG-0003ea-3t@debutante>
References: <1496760309-6195-4-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 31FB22671A8
 for <alsa-devel@alsa-project.org>; Wed,  7 Jun 2017 21:31:55 +0200 (CEST)
In-Reply-To: <1496760309-6195-4-git-send-email-liam.r.girdwood@linux.intel.com>
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

   ASoC: topology: Dont free template strings whilst they are in use.

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

>From c3421a6a65abc636b067eb15a4c5e9cb59e91c95 Mon Sep 17 00:00:00 2001
From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Date: Tue, 6 Jun 2017 15:45:09 +0100
Subject: [PATCH] ASoC: topology: Dont free template strings whilst they are in
 use.

Template name pointers are copied when creating new widgets and are freed
in widget destroy.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-topology.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index f24d1f2e82a0..7006cf3007b5 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1477,6 +1477,7 @@ static int soc_tplg_dapm_widget_create(struct soc_tplg *tplg,
 	if (template.id < 0)
 		return template.id;
 
+	/* strings are allocated here, but used and freed by the widget */
 	template.name = kstrdup(w->name, GFP_KERNEL);
 	if (!template.name)
 		return -ENOMEM;
@@ -1589,8 +1590,6 @@ static int soc_tplg_dapm_widget_create(struct soc_tplg *tplg,
 	widget->dobj.widget.kcontrol_type = kcontrol_type;
 	widget->dobj.ops = tplg->ops;
 	widget->dobj.index = tplg->index;
-	kfree(template.sname);
-	kfree(template.name);
 	list_add(&widget->dobj.list, &tplg->comp->dobj_list);
 
 	ret = soc_tplg_widget_ready(tplg, widget, w);
-- 
2.11.0
