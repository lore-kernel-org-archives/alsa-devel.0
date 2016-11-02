From: mengdong.lin@linux.intel.com
Subject: [PATCH v7 02/11] ASoC: topology: Only use valid names
	of PCM for the kernel DAI & DAI link
Date: Thu,  3 Nov 2016 01:02:59 +0800
Message-ID: <f2e808ea2d0185ee310a5bae58317d253838641b.1478071138.git.mengdong.lin@linux.intel.com>
References: <cover.1478071138.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A1A42666FA
 for <alsa-devel@alsa-project.org>; Wed,  2 Nov 2016 18:01:34 +0100 (CET)
In-Reply-To: <cover.1478071138.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, rakesh.a.ughreja@intel.com, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

User space may not always set a valid FE DAI driver's name, FE DAI link's
name, stream name or cpu DAI name. In such cases, there are all ZERO in
these name string buffers of a topology PCM object. This patch will only
duplicate valid name strings for kernel FE DAI driver and DAI link when
creating them from topology, and free the name strings when destroying
them.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 03edde5..0f1c8eb 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -523,6 +523,7 @@ static void remove_dai(struct snd_soc_component *comp,
 	if (dobj->ops && dobj->ops->dai_unload)
 		dobj->ops->dai_unload(comp, dobj);
 
+	kfree(dai_drv->name);
 	list_del(&dobj->list);
 	kfree(dai_drv);
 }
@@ -540,6 +541,10 @@ static void remove_link(struct snd_soc_component *comp,
 	if (dobj->ops && dobj->ops->link_unload)
 		dobj->ops->link_unload(comp, dobj);
 
+	kfree(link->name);
+	kfree(link->stream_name);
+	kfree(link->cpu_dai_name);
+
 	list_del(&dobj->list);
 	snd_soc_remove_dai_link(comp->card, link);
 	kfree(link);
@@ -1638,7 +1643,8 @@ static int soc_tplg_dai_create(struct soc_tplg *tplg,
 	if (dai_drv == NULL)
 		return -ENOMEM;
 
-	dai_drv->name = pcm->dai_name;
+	if (strlen(pcm->dai_name))
+		dai_drv->name = kstrdup(pcm->dai_name, GFP_KERNEL);
 	dai_drv->id = pcm->dai_id;
 
 	if (pcm->playback) {
@@ -1681,11 +1687,15 @@ static int soc_tplg_link_create(struct soc_tplg *tplg,
 	if (link == NULL)
 		return -ENOMEM;
 
-	link->name = pcm->pcm_name;
-	link->stream_name = pcm->pcm_name;
+	if (strlen(pcm->pcm_name)) {
+		link->name = kstrdup(pcm->pcm_name, GFP_KERNEL);
+		link->stream_name = kstrdup(pcm->pcm_name, GFP_KERNEL);
+	}
 	link->id = pcm->pcm_id;
 
-	link->cpu_dai_name = pcm->dai_name;
+	if (strlen(pcm->dai_name))
+		link->cpu_dai_name = kstrdup(pcm->dai_name, GFP_KERNEL);
+
 	link->codec_name = "snd-soc-dummy";
 	link->codec_dai_name = "snd-soc-dummy-dai";
 
-- 
2.7.4
