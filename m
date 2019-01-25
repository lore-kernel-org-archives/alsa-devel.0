From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 7/7] ASoC: topology: unload physical dai link
	in remove
Date: Fri, 25 Jan 2019 14:06:48 -0600
Message-ID: <20190125200648.12470-8-pierre-louis.bossart@linux.intel.com>
References: <20190125200648.12470-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id E170B267350
 for <alsa-devel@alsa-project.org>; Fri, 25 Jan 2019 21:07:01 +0100 (CET)
In-Reply-To: <20190125200648.12470-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Bard liao <yung-chuan.liao@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Bard liao <yung-chuan.liao@linux.intel.com>

soc_tplg_link_config() will find the physical dai link and call
soc_tplg_dai_link_load() to load the BE dai link. Currently remove_link()
is only used to remove the FE dai link which is created by the topology.
The BE dai link cannot however be unloaded in snd_soc_tplg_component
_remove(), which is problematic if anything needs to be released or
reinitialized.

This patch aligns the definitions of dynamic types with the existing
UAPI and adds a new remove_backend_link() routine to unload the the BE
dai link when snd_soc_tplg_component_remove() is invoked.

Signed-off-by: Bard liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/soc-topology.h |  1 +
 sound/soc/soc-topology.c     | 31 +++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/sound/soc-topology.h b/include/sound/soc-topology.h
index 8c43cfc240fa..5223896de26f 100644
--- a/include/sound/soc-topology.h
+++ b/include/sound/soc-topology.h
@@ -45,6 +45,7 @@ enum snd_soc_dobj_type {
 	SND_SOC_DOBJ_DAI_LINK,
 	SND_SOC_DOBJ_PCM,
 	SND_SOC_DOBJ_CODEC_LINK,
+	SND_SOC_DOBJ_BACKEND_LINK,
 };
 
 /* dynamic control object */
diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 23d421370e6c..49e6fd76d9bc 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -557,6 +557,24 @@ static void remove_link(struct snd_soc_component *comp,
 	kfree(link);
 }
 
+/* unload dai link */
+static void remove_backend_link(struct snd_soc_component *comp,
+	struct snd_soc_dobj *dobj, int pass)
+{
+	if (pass != SOC_TPLG_PASS_LINK)
+		return;
+
+	if (dobj->ops && dobj->ops->link_unload)
+		dobj->ops->link_unload(comp, dobj);
+
+	/*
+	 * We don't free the link here as what remove_link() do since BE
+	 * links are not allocated by topology.
+	 */
+
+	list_del(&dobj->list);
+}
+
 /* bind a kcontrol to it's IO handlers */
 static int soc_tplg_kcontrol_bind_io(struct snd_soc_tplg_ctl_hdr *hdr,
 	struct snd_kcontrol_new *k,
@@ -2163,6 +2181,12 @@ static int soc_tplg_link_config(struct soc_tplg *tplg,
 		return ret;
 	}
 
+	/* for unloading it in snd_soc_tplg_component_remove */
+	link->dobj.index = tplg->index;
+	link->dobj.ops = tplg->ops;
+	link->dobj.type = SND_SOC_DOBJ_BACKEND_LINK;
+	list_add(&link->dobj.list, &tplg->comp->dobj_list);
+
 	return 0;
 }
 
@@ -2649,6 +2673,13 @@ int snd_soc_tplg_component_remove(struct snd_soc_component *comp, u32 index)
 			case SND_SOC_DOBJ_DAI_LINK:
 				remove_link(comp, dobj, pass);
 				break;
+			case SND_SOC_DOBJ_BACKEND_LINK:
+				/*
+				 * call link_unload ops if extra
+				 * deinitialization is needed.
+				 */
+				remove_backend_link(comp, dobj, pass);
+				break;
 			default:
 				dev_err(comp->dev, "ASoC: invalid component type %d for removal\n",
 					dobj->type);
-- 
2.17.1
