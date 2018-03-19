From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: Check widget kcontrols before
	deref." to the asoc tree
Date: Mon, 19 Mar 2018 08:08:58 +0000 (GMT)
Message-ID: <20180319080858.AA52144007A@finisterre.ee.mobilebroadband>
References: <20180314204240.13848-1-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 51B552672C0
 for <alsa-devel@alsa-project.org>; Mon, 19 Mar 2018 09:09:03 +0100 (CET)
In-Reply-To: <20180314204240.13848-1-liam.r.girdwood@linux.intel.com>
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

   ASoC: topology: Check widget kcontrols before deref.

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 05bdcf12905533b8628627b6634608cd3b57c607 Mon Sep 17 00:00:00 2001
From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Date: Wed, 14 Mar 2018 20:42:40 +0000
Subject: [PATCH] ASoC: topology: Check widget kcontrols before deref.

Validate the topology input before we dereference the pointer.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-topology.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index e81b52600d58..b363f2409f72 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -504,6 +504,9 @@ static void remove_widget(struct snd_soc_component *comp,
 	if (dobj->ops && dobj->ops->widget_unload)
 		dobj->ops->widget_unload(comp, dobj);
 
+	if (!w->kcontrols)
+		goto free_news;
+
 	/*
 	 * Dynamic Widgets either have 1..N enum kcontrols or mixers.
 	 * The enum may either have an array of values or strings.
@@ -524,7 +527,6 @@ static void remove_widget(struct snd_soc_component *comp,
 
 			kfree(se);
 		}
-		kfree(w->kcontrol_news);
 	} else {
 		/* volume mixer or bytes controls */
 		for (i = 0; i < w->num_kcontrols; i++) {
@@ -541,8 +543,11 @@ static void remove_widget(struct snd_soc_component *comp,
 			kfree((void *)kcontrol->private_value);
 			snd_ctl_remove(card, kcontrol);
 		}
-		kfree(w->kcontrol_news);
 	}
+
+free_news:
+	kfree(w->kcontrol_news);
+
 	/* widget w is freed by soc-dapm.c */
 }
 
-- 
2.16.2
