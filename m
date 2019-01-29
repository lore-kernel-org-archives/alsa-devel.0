From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: modify dapm route loading
	routine and add dapm route unloading" to the asoc tree
Date: Tue, 29 Jan 2019 18:12:21 +0000 (GMT)
Message-ID: <20190129181221.0C5A91127D50@debutante.sirena.org.uk>
References: <20190125200648.12470-7-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id BFA95267588
 for <alsa-devel@alsa-project.org>; Tue, 29 Jan 2019 19:12:22 +0100 (CET)
In-Reply-To: <20190125200648.12470-7-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: topology: modify dapm route loading routine and add dapm route unloading

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

>From 7df04ea7a31eaa75bdad2905f07cc097b15558ee Mon Sep 17 00:00:00 2001
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Date: Fri, 25 Jan 2019 14:06:47 -0600
Subject: [PATCH] ASoC: topology: modify dapm route loading routine and add
 dapm route unloading

struct snd_soc_dapm_route has been modified to be a dynamic
object so that it can be used to save driver specific
data while parsing topology and clean up
driver-specific data during driver unloading.

This patch makes the following changes to accomplish the above:
1. Set the dobj member of snd_soc_dapm_route during the
SOC_TPLG_PASS_GRAPH pass of topology parsing.
2. Add the remove_route() routine that will be called while
removing all dynamic objects from the component driver.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-topology.c | 102 +++++++++++++++++++++++++++++++++------
 1 file changed, 86 insertions(+), 16 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 2cb0a05e2368..23d421370e6c 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -433,6 +433,23 @@ static void remove_bytes(struct snd_soc_component *comp,
 	kfree(sb);
 }
 
+/* remove a route */
+static void remove_route(struct snd_soc_component *comp,
+			 struct snd_soc_dobj *dobj, int pass)
+{
+	struct snd_soc_dapm_route *route =
+		container_of(dobj, struct snd_soc_dapm_route, dobj);
+
+	if (pass != SOC_TPLG_PASS_GRAPH)
+		return;
+
+	if (dobj->ops && dobj->ops->dapm_route_unload)
+		dobj->ops->dapm_route_unload(comp, dobj);
+
+	list_del(&dobj->list);
+	kfree(route);
+}
+
 /* remove a widget and it's kcontrols - routes must be removed first */
 static void remove_widget(struct snd_soc_component *comp,
 	struct snd_soc_dobj *dobj, int pass)
@@ -1119,9 +1136,10 @@ static int soc_tplg_dapm_graph_elems_load(struct soc_tplg *tplg,
 	struct snd_soc_tplg_hdr *hdr)
 {
 	struct snd_soc_dapm_context *dapm = &tplg->comp->dapm;
-	struct snd_soc_dapm_route route;
 	struct snd_soc_tplg_dapm_graph_elem *elem;
-	int count = hdr->count, i;
+	struct snd_soc_dapm_route **routes;
+	int count = hdr->count, i, j;
+	int ret = 0;
 
 	if (tplg->pass != SOC_TPLG_PASS_GRAPH) {
 		tplg->pos += hdr->size + hdr->payload_size;
@@ -1140,36 +1158,85 @@ static int soc_tplg_dapm_graph_elems_load(struct soc_tplg *tplg,
 	dev_dbg(tplg->dev, "ASoC: adding %d DAPM routes for index %d\n", count,
 		hdr->index);
 
+	/* allocate memory for pointer to array of dapm routes */
+	routes = kcalloc(count, sizeof(struct snd_soc_dapm_route *),
+			 GFP_KERNEL);
+	if (!routes)
+		return -ENOMEM;
+
+	/*
+	 * allocate memory for each dapm route in the array.
+	 * This needs to be done individually so that
+	 * each route can be freed when it is removed in remove_route().
+	 */
+	for (i = 0; i < count; i++) {
+		routes[i] = kzalloc(sizeof(*routes[i]), GFP_KERNEL);
+		if (!routes[i]) {
+			/* free previously allocated memory */
+			for (j = 0; j < i; j++)
+				kfree(routes[j]);
+
+			kfree(routes);
+			return -ENOMEM;
+		}
+	}
+
 	for (i = 0; i < count; i++) {
 		elem = (struct snd_soc_tplg_dapm_graph_elem *)tplg->pos;
 		tplg->pos += sizeof(struct snd_soc_tplg_dapm_graph_elem);
 
 		/* validate routes */
 		if (strnlen(elem->source, SNDRV_CTL_ELEM_ID_NAME_MAXLEN) ==
-			SNDRV_CTL_ELEM_ID_NAME_MAXLEN)
-			return -EINVAL;
+			    SNDRV_CTL_ELEM_ID_NAME_MAXLEN) {
+			ret = -EINVAL;
+			break;
+		}
 		if (strnlen(elem->sink, SNDRV_CTL_ELEM_ID_NAME_MAXLEN) ==
-			SNDRV_CTL_ELEM_ID_NAME_MAXLEN)
-			return -EINVAL;
+			    SNDRV_CTL_ELEM_ID_NAME_MAXLEN) {
+			ret = -EINVAL;
+			break;
+		}
 		if (strnlen(elem->control, SNDRV_CTL_ELEM_ID_NAME_MAXLEN) ==
-			SNDRV_CTL_ELEM_ID_NAME_MAXLEN)
-			return -EINVAL;
+			    SNDRV_CTL_ELEM_ID_NAME_MAXLEN) {
+			ret = -EINVAL;
+			break;
+		}
+
+		routes[i]->source = elem->source;
+		routes[i]->sink = elem->sink;
 
-		route.source = elem->source;
-		route.sink = elem->sink;
-		route.connected = NULL; /* set to NULL atm for tplg users */
+		/* set to NULL atm for tplg users */
+		routes[i]->connected = NULL;
 		if (strnlen(elem->control, SNDRV_CTL_ELEM_ID_NAME_MAXLEN) == 0)
-			route.control = NULL;
+			routes[i]->control = NULL;
 		else
-			route.control = elem->control;
+			routes[i]->control = elem->control;
+
+		/* add route dobj to dobj_list */
+		routes[i]->dobj.type = SND_SOC_DOBJ_GRAPH;
+		routes[i]->dobj.ops = tplg->ops;
+		routes[i]->dobj.index = tplg->index;
+		list_add(&routes[i]->dobj.list, &tplg->comp->dobj_list);
 
-		soc_tplg_add_route(tplg, &route);
+		soc_tplg_add_route(tplg, routes[i]);
 
 		/* add route, but keep going if some fail */
-		snd_soc_dapm_add_routes(dapm, &route, 1);
+		snd_soc_dapm_add_routes(dapm, routes[i], 1);
 	}
 
-	return 0;
+	/* free memory allocated for all dapm routes in case of error */
+	if (ret < 0)
+		for (i = 0; i < count ; i++)
+			kfree(routes[i]);
+
+	/*
+	 * free pointer to array of dapm routes as this is no longer needed.
+	 * The memory allocated for each dapm route will be freed
+	 * when it is removed in remove_route().
+	 */
+	kfree(routes);
+
+	return ret;
 }
 
 static struct snd_kcontrol_new *soc_tplg_dapm_widget_dmixer_create(
@@ -2570,6 +2637,9 @@ int snd_soc_tplg_component_remove(struct snd_soc_component *comp, u32 index)
 			case SND_SOC_DOBJ_BYTES:
 				remove_bytes(comp, dobj, pass);
 				break;
+			case SND_SOC_DOBJ_GRAPH:
+				remove_route(comp, dobj, pass);
+				break;
 			case SND_SOC_DOBJ_WIDGET:
 				remove_widget(comp, dobj, pass);
 				break;
-- 
2.20.1
