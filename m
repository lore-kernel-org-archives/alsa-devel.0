From: mengdong.lin@linux.intel.com
Subject: [PATCH v2 12/13] ASoC: topology: Add support for FE
	DAI links
Date: Thu,  5 Nov 2015 18:00:06 +0800
Message-ID: <5c62e7d5a59a2e861a3708ac40fa50973112c9f8.1446717205.git.mengdong.lin@linux.intel.com>
References: <cover.1446717205.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E003265CB5
 for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2015 10:44:40 +0100 (CET)
In-Reply-To: <cover.1446717205.git.mengdong.lin@linux.intel.com>
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, mengdong.lin@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, jeeja.kp@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

FE DAI links can be created from topology.

And a machine driver can register add_dai_link ops to the soc card,
to get notified when a new DAI link is created and bind machine-specific
info to the link.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/sound/soc-topology.h b/include/sound/soc-topology.h
index b51c207..6324537 100644
--- a/include/sound/soc-topology.h
+++ b/include/sound/soc-topology.h
@@ -123,6 +123,12 @@ struct snd_soc_tplg_ops {
 	int (*dai_unload)(struct snd_soc_component *,
 		struct snd_soc_dobj *);
 
+	/* DAI link - used for any driver specific init */
+	int (*link_load)(struct snd_soc_component *,
+		struct snd_soc_dai_link *link);
+	int (*link_unload)(struct snd_soc_component *,
+		struct snd_soc_dobj *);
+
 	/* callback to handle vendor bespoke data */
 	int (*vendor_load)(struct snd_soc_component *,
 		struct snd_soc_tplg_hdr *);
diff --git a/include/sound/soc.h b/include/sound/soc.h
index 4d07a9e..31fe60a 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1039,6 +1039,7 @@ struct snd_soc_dai_link {
 	unsigned int ignore_pmdown_time:1;
 
 	struct list_head list; /* dai link list of the soc card */
+	struct snd_soc_dobj dobj;
 };
 
 struct snd_soc_codec_conf {
diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 2201261..d07c6b0 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -340,6 +340,16 @@ static int soc_tplg_dai_load(struct soc_tplg *tplg,
 	return 0;
 }
 
+/* pass dynamic FE DAI configurations to component driver */
+static int soc_tplg_dai_link_load(struct soc_tplg *tplg,
+	struct snd_soc_dai_link *link)
+{
+	if (tplg->comp && tplg->ops && tplg->ops->link_load)
+		return tplg->ops->link_load(tplg->comp, link);
+
+	return 0;
+}
+
 /* tell the component driver that all firmware has been loaded in this request */
 static void soc_tplg_complete(struct soc_tplg *tplg)
 {
@@ -1617,10 +1627,46 @@ static int soc_tplg_dai_create(struct soc_tplg *tplg,
 	return snd_soc_add_dai(tplg->comp, dai_drv);
 }
 
+static int soc_tplg_fe_link_create(struct soc_tplg *tplg,
+	struct snd_soc_tplg_pcm *pcm)
+{
+	struct snd_soc_dai_link *link;
+	int ret;
+
+	link = kzalloc(sizeof(struct snd_soc_dai_link), GFP_KERNEL);
+	if (link == NULL)
+		return -ENOMEM;
+
+	link->name = pcm->pcm_name;
+	link->stream_name = pcm->pcm_name;
+
+	/* pass control to component driver for optional further init */
+	ret = soc_tplg_dai_link_load(tplg, link);
+	if (ret < 0) {
+		dev_err(tplg->comp->dev, "ASoC: FE link loading failed\n");
+		kfree(link);
+		return ret;
+	}
+
+	link->dobj.index = tplg->index;
+	link->dobj.ops = tplg->ops;
+	link->dobj.type = SND_SOC_DOBJ_DAI_LINK;
+	list_add(&link->dobj.list, &tplg->comp->dobj_list);
+
+	snd_soc_add_dai_link(tplg->comp->card, link);
+	return 0;
+}
+
 static int soc_tplg_pcm_create(struct soc_tplg *tplg,
 	struct snd_soc_tplg_pcm *pcm)
 {
-	return soc_tplg_dai_create(tplg, pcm);
+	int ret;
+
+	ret = soc_tplg_dai_create(tplg, pcm);
+	if (ret < 0)
+		return ret;
+
+	return  soc_tplg_fe_link_create(tplg, pcm);
 }
 
 static int soc_tplg_pcm_elems_load(struct soc_tplg *tplg,
-- 
1.9.1
