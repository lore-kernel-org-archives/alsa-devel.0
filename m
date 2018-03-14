From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH] ASoC: topology: Check widget kcontrols before
	deref.
Date: Wed, 14 Mar 2018 20:42:40 +0000
Message-ID: <20180314204240.13848-1-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id BED31266EBE
 for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2018 21:42:47 +0100 (CET)
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

Validate the topology input before we dereference the pointer.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 sound/soc/soc-topology.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 4616286869a8..78197e82fc4f 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -508,6 +508,9 @@ static void remove_widget(struct snd_soc_component *comp,
 	if (dobj->ops && dobj->ops->widget_unload)
 		dobj->ops->widget_unload(comp, dobj);
 
+	if (!w->kcontrols)
+		goto free_news;
+
 	/*
 	 * Dynamic Widgets either have 1..N enum kcontrols or mixers.
 	 * The enum may either have an array of values or strings.
@@ -528,7 +531,6 @@ static void remove_widget(struct snd_soc_component *comp,
 
 			kfree(se);
 		}
-		kfree(w->kcontrol_news);
 	} else {
 		/* volume mixer or bytes controls */
 		for (i = 0; i < w->num_kcontrols; i++) {
@@ -545,8 +547,11 @@ static void remove_widget(struct snd_soc_component *comp,
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
2.14.1
