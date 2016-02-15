From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: Add FE DAI links dynamically"
	to the asoc tree
Date: Mon, 15 Feb 2016 20:25:45 +0000
Message-ID: <E1aVPiL-0005WB-SM@finisterre>
References: <63bf4fab85ff738ce381eaebc6c5a028c0c5592b.1451550513.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 061F12606DE
 for <alsa-devel@alsa-project.org>; Mon, 15 Feb 2016 21:26:02 +0100 (CET)
In-Reply-To: <63bf4fab85ff738ce381eaebc6c5a028c0c5592b.1451550513.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mengdong Lin <mengdong.lin@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: topology: Add FE DAI links dynamically

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

>From acfc7d46cddcf71cf18772bbe8717b84eac5f672 Mon Sep 17 00:00:00 2001
From: Mengdong Lin <mengdong.lin@linux.intel.com>
Date: Fri, 15 Jan 2016 16:13:37 +0800
Subject: [PATCH] ASoC: topology: Add FE DAI links dynamically

Topology will also create FE DAI links dynamically from the PCM
objects. These links will be removed when the component is removed
and its topology info is unloaded.

The component driver can implement link_load/unload ops for extra
intialization (e.g. error check) and destruction.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>
Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc-topology.h |  6 ++++
 sound/soc/soc-topology.c     | 70 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/include/sound/soc-topology.h b/include/sound/soc-topology.h
index 78813ad..b897b9d 100644
--- a/include/sound/soc-topology.h
+++ b/include/sound/soc-topology.h
@@ -125,6 +125,12 @@ struct snd_soc_tplg_ops {
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
diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 446ac9a..0eb01e8 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -340,6 +340,16 @@ static int soc_tplg_dai_load(struct soc_tplg *tplg,
 	return 0;
 }
 
+/* pass link configurations to component driver for extra intialization */
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
@@ -512,6 +522,24 @@ static void remove_dai(struct snd_soc_component *comp,
 	kfree(dai_drv);
 }
 
+/* remove link configurations */
+static void remove_link(struct snd_soc_component *comp,
+	struct snd_soc_dobj *dobj, int pass)
+{
+	struct snd_soc_dai_link *link =
+		container_of(dobj, struct snd_soc_dai_link, dobj);
+
+	if (pass != SOC_TPLG_PASS_PCM_DAI)
+		return;
+
+	if (dobj->ops && dobj->ops->link_unload)
+		dobj->ops->link_unload(comp, dobj);
+
+	list_del(&dobj->list);
+	snd_soc_remove_dai_link(comp->card, link);
+	kfree(link);
+}
+
 /* bind a kcontrol to it's IO handlers */
 static int soc_tplg_kcontrol_bind_io(struct snd_soc_tplg_ctl_hdr *hdr,
 	struct snd_kcontrol_new *k,
@@ -1603,10 +1631,47 @@ static int soc_tplg_dai_create(struct soc_tplg *tplg,
 	return snd_soc_register_dai(tplg->comp, dai_drv);
 }
 
+static int soc_tplg_link_create(struct soc_tplg *tplg,
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
+/* create a FE DAI and DAI link from the PCM object */
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
+	return  soc_tplg_link_create(tplg, pcm);
 }
 
 static int soc_tplg_pcm_elems_load(struct soc_tplg *tplg,
@@ -1890,6 +1955,9 @@ int snd_soc_tplg_component_remove(struct snd_soc_component *comp, u32 index)
 			case SND_SOC_DOBJ_PCM:
 				remove_dai(comp, dobj, pass);
 				break;
+			case SND_SOC_DOBJ_DAI_LINK:
+				remove_link(comp, dobj, pass);
+				break;
 			default:
 				dev_err(comp->dev, "ASoC: invalid component type %d for removal\n",
 					dobj->type);
-- 
2.7.0
