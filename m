From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH] ASoC: topology: Dont free template strings
	whilst they are in use.
Date: Tue,  6 Jun 2017 15:45:09 +0100
Message-ID: <1496760309-6195-4-git-send-email-liam.r.girdwood@linux.intel.com>
References: <1496760309-6195-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id E9236266F0A
 for <alsa-devel@alsa-project.org>; Tue,  6 Jun 2017 16:45:22 +0200 (CEST)
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

Template name pointers are copied when creating new widgets and are freed
in widget destroy.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 sound/soc/soc-topology.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index b0bbb0756f69..b4626298f7eb 100644
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
