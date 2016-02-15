From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: Add FE DAIs dynamically" to
	the asoc tree
Date: Mon, 15 Feb 2016 20:25:48 +0000
Message-ID: <E1aVPiO-0005We-0f@finisterre>
References: <e04cb24bfa0553a6a4fc9c8da765a30b9672e35f.1451550513.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 16E0C2606B2
 for <alsa-devel@alsa-project.org>; Mon, 15 Feb 2016 21:26:01 +0100 (CET)
In-Reply-To: <e04cb24bfa0553a6a4fc9c8da765a30b9672e35f.1451550513.git.mengdong.lin@linux.intel.com>
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

   ASoC: topology: Add FE DAIs dynamically

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

>From 64527e8a352968bda529f01df1c9dd5fe581ff04 Mon Sep 17 00:00:00 2001
From: Mengdong Lin <mengdong.lin@linux.intel.com>
Date: Fri, 15 Jan 2016 16:13:28 +0800
Subject: [PATCH] ASoC: topology: Add FE DAIs dynamically

Topology will create FE DAIs dynamically from the PCM objects,
and register them to the component.

A PCM topoplogy object describes a FE DAI and DAI link. Later
patch will add FE DAI links as well.

Change tplg load ops for DAI:
- Only process a DAI.
- Pass the DAI driver pointer to the component driver for
  extra initialization.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>
Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc-topology.h |  15 ++---
 include/sound/soc.h          |   2 +-
 sound/soc/soc-topology.c     | 129 +++++++++++++++++++++++++++++--------------
 3 files changed, 92 insertions(+), 54 deletions(-)

diff --git a/include/sound/soc-topology.h b/include/sound/soc-topology.h
index 5b68e3f..78813ad 100644
--- a/include/sound/soc-topology.h
+++ b/include/sound/soc-topology.h
@@ -56,12 +56,6 @@ struct snd_soc_dobj_widget {
 	unsigned int kcontrol_enum:1;	/* this widget is an enum kcontrol */
 };
 
-/* dynamic PCM DAI object */
-struct snd_soc_dobj_pcm_dai {
-	struct snd_soc_tplg_pcm_dai *pd;
-	unsigned int count;
-};
-
 /* generic dynamic object - all dynamic objects belong to this struct */
 struct snd_soc_dobj {
 	enum snd_soc_dobj_type type;
@@ -71,7 +65,6 @@ struct snd_soc_dobj {
 	union {
 		struct snd_soc_dobj_control control;
 		struct snd_soc_dobj_widget widget;
-		struct snd_soc_dobj_pcm_dai pcm_dai;
 	};
 	void *private; /* core does not touch this */
 };
@@ -126,10 +119,10 @@ struct snd_soc_tplg_ops {
 	int (*widget_unload)(struct snd_soc_component *,
 		struct snd_soc_dobj *);
 
-	/* FE - used for any driver specific init */
-	int (*pcm_dai_load)(struct snd_soc_component *,
-		struct snd_soc_tplg_pcm_dai *pcm_dai, int num_fe);
-	int (*pcm_dai_unload)(struct snd_soc_component *,
+	/* FE DAI - used for any driver specific init */
+	int (*dai_load)(struct snd_soc_component *,
+		struct snd_soc_dai_driver *dai_drv);
+	int (*dai_unload)(struct snd_soc_component *,
 		struct snd_soc_dobj *);
 
 	/* callback to handle vendor bespoke data */
diff --git a/include/sound/soc.h b/include/sound/soc.h
index 7afb72c..02b4a21 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -27,7 +27,6 @@
 #include <sound/compress_driver.h>
 #include <sound/control.h>
 #include <sound/ac97_codec.h>
-#include <sound/soc-topology.h>
 
 /*
  * Convenience kcontrol builders
@@ -404,6 +403,7 @@ struct snd_soc_jack_zone;
 struct snd_soc_jack_pin;
 #include <sound/soc-dapm.h>
 #include <sound/soc-dpcm.h>
+#include <sound/soc-topology.h>
 
 struct snd_soc_jack_gpio;
 
diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 6963ba2..446ac9a 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -330,12 +330,12 @@ static int soc_tplg_widget_load(struct soc_tplg *tplg,
 	return 0;
 }
 
-/* pass dynamic FEs configurations to component driver */
-static int soc_tplg_pcm_dai_load(struct soc_tplg *tplg,
-	struct snd_soc_tplg_pcm_dai *pcm_dai, int num_pcm_dai)
+/* pass DAI configurations to component driver for extra intialization */
+static int soc_tplg_dai_load(struct soc_tplg *tplg,
+	struct snd_soc_dai_driver *dai_drv)
 {
-	if (tplg->comp && tplg->ops && tplg->ops->pcm_dai_load)
-		return tplg->ops->pcm_dai_load(tplg->comp, pcm_dai, num_pcm_dai);
+	if (tplg->comp && tplg->ops && tplg->ops->dai_load)
+		return tplg->ops->dai_load(tplg->comp, dai_drv);
 
 	return 0;
 }
@@ -495,18 +495,21 @@ static void remove_widget(struct snd_soc_component *comp,
 	/* widget w is freed by soc-dapm.c */
 }
 
-/* remove PCM DAI configurations */
-static void remove_pcm_dai(struct snd_soc_component *comp,
+/* remove DAI configurations */
+static void remove_dai(struct snd_soc_component *comp,
 	struct snd_soc_dobj *dobj, int pass)
 {
+	struct snd_soc_dai_driver *dai_drv =
+		container_of(dobj, struct snd_soc_dai_driver, dobj);
+
 	if (pass != SOC_TPLG_PASS_PCM_DAI)
 		return;
 
-	if (dobj->ops && dobj->ops->pcm_dai_unload)
-		dobj->ops->pcm_dai_unload(comp, dobj);
+	if (dobj->ops && dobj->ops->dai_unload)
+		dobj->ops->dai_unload(comp, dobj);
 
 	list_del(&dobj->list);
-	kfree(dobj);
+	kfree(dai_drv);
 }
 
 /* bind a kcontrol to it's IO handlers */
@@ -1544,18 +1547,79 @@ static int soc_tplg_dapm_complete(struct soc_tplg *tplg)
 	return 0;
 }
 
-static int soc_tplg_pcm_dai_elems_load(struct soc_tplg *tplg,
+static int soc_tplg_dai_create(struct soc_tplg *tplg,
+	struct snd_soc_tplg_pcm *pcm)
+{
+	struct snd_soc_dai_driver *dai_drv;
+	struct snd_soc_pcm_stream *stream;
+	struct snd_soc_tplg_stream_caps *caps;
+	int ret;
+
+	dai_drv = kzalloc(sizeof(struct snd_soc_dai_driver), GFP_KERNEL);
+	if (dai_drv == NULL)
+		return -ENOMEM;
+
+	dai_drv->name = pcm->dai_name;
+	dai_drv->id = pcm->dai_id;
+
+	if (pcm->playback) {
+		stream = &dai_drv->playback;
+		caps = &pcm->caps[SND_SOC_TPLG_STREAM_PLAYBACK];
+
+		stream->stream_name = kstrdup(caps->name, GFP_KERNEL);
+		stream->channels_min = caps->channels_min;
+		stream->channels_max = caps->channels_max;
+		stream->rates = snd_pcm_rate_range_to_bits(caps->rate_min,
+							caps->rate_max);
+		stream->formats = caps->formats;
+	}
+
+	if (pcm->capture) {
+		stream = &dai_drv->capture;
+		caps = &pcm->caps[SND_SOC_TPLG_STREAM_CAPTURE];
+
+		stream->stream_name = kstrdup(caps->name, GFP_KERNEL);
+		stream->channels_min = caps->channels_min;
+		stream->channels_max = caps->channels_max;
+		stream->rates = snd_pcm_rate_range_to_bits(caps->rate_min,
+							caps->rate_max);
+		stream->formats = caps->formats;
+	}
+
+	/* pass control to component driver for optional further init */
+	ret = soc_tplg_dai_load(tplg, dai_drv);
+	if (ret < 0) {
+		dev_err(tplg->comp->dev, "ASoC: DAI loading failed\n");
+		kfree(dai_drv);
+		return ret;
+	}
+
+	dai_drv->dobj.index = tplg->index;
+	dai_drv->dobj.ops = tplg->ops;
+	dai_drv->dobj.type = SND_SOC_DOBJ_PCM;
+	list_add(&dai_drv->dobj.list, &tplg->comp->dobj_list);
+
+	/* register the DAI to the component */
+	return snd_soc_register_dai(tplg->comp, dai_drv);
+}
+
+static int soc_tplg_pcm_create(struct soc_tplg *tplg,
+	struct snd_soc_tplg_pcm *pcm)
+{
+	return soc_tplg_dai_create(tplg, pcm);
+}
+
+static int soc_tplg_pcm_elems_load(struct soc_tplg *tplg,
 	struct snd_soc_tplg_hdr *hdr)
 {
-	struct snd_soc_tplg_pcm_dai *pcm_dai;
-	struct snd_soc_dobj *dobj;
+	struct snd_soc_tplg_pcm *pcm;
 	int count = hdr->count;
-	int ret;
+	int i;
 
 	if (tplg->pass != SOC_TPLG_PASS_PCM_DAI)
 		return 0;
 
-	pcm_dai = (struct snd_soc_tplg_pcm_dai *)tplg->pos;
+	pcm = (struct snd_soc_tplg_pcm *)tplg->pos;
 
 	if (soc_tplg_check_elem_count(tplg,
 		sizeof(struct snd_soc_tplg_pcm), count,
@@ -1565,31 +1629,16 @@ static int soc_tplg_pcm_dai_elems_load(struct soc_tplg *tplg,
 		return -EINVAL;
 	}
 
+	/* create the FE DAIs and DAI links */
+	for (i = 0; i < count; i++) {
+		soc_tplg_pcm_create(tplg, pcm);
+		pcm++;
+	}
+
 	dev_dbg(tplg->dev, "ASoC: adding %d PCM DAIs\n", count);
 	tplg->pos += sizeof(struct snd_soc_tplg_pcm) * count;
 
-	dobj = kzalloc(sizeof(struct snd_soc_dobj), GFP_KERNEL);
-	if (dobj == NULL)
-		return -ENOMEM;
-
-	/* Call the platform driver call back to register the dais */
-	ret = soc_tplg_pcm_dai_load(tplg, pcm_dai, count);
-	if (ret < 0) {
-		dev_err(tplg->comp->dev, "ASoC: PCM DAI loading failed\n");
-		goto err;
-	}
-
-	dobj->type = get_dobj_type(hdr, NULL);
-	dobj->pcm_dai.count = count;
-	dobj->pcm_dai.pd = pcm_dai;
-	dobj->ops = tplg->ops;
-	dobj->index = tplg->index;
-	list_add(&dobj->list, &tplg->comp->dobj_list);
 	return 0;
-
-err:
-	kfree(dobj);
-	return ret;
 }
 
 static int soc_tplg_manifest_load(struct soc_tplg *tplg,
@@ -1681,9 +1730,7 @@ static int soc_tplg_load_header(struct soc_tplg *tplg,
 	case SND_SOC_TPLG_TYPE_DAPM_WIDGET:
 		return soc_tplg_dapm_widget_elems_load(tplg, hdr);
 	case SND_SOC_TPLG_TYPE_PCM:
-	case SND_SOC_TPLG_TYPE_DAI_LINK:
-	case SND_SOC_TPLG_TYPE_CODEC_LINK:
-		return soc_tplg_pcm_dai_elems_load(tplg, hdr);
+		return soc_tplg_pcm_elems_load(tplg, hdr);
 	case SND_SOC_TPLG_TYPE_MANIFEST:
 		return soc_tplg_manifest_load(tplg, hdr);
 	default:
@@ -1841,9 +1888,7 @@ int snd_soc_tplg_component_remove(struct snd_soc_component *comp, u32 index)
 				remove_widget(comp, dobj, pass);
 				break;
 			case SND_SOC_DOBJ_PCM:
-			case SND_SOC_DOBJ_DAI_LINK:
-			case SND_SOC_DOBJ_CODEC_LINK:
-				remove_pcm_dai(comp, dobj, pass);
+				remove_dai(comp, dobj, pass);
 				break;
 			default:
 				dev_err(comp->dev, "ASoC: invalid component type %d for removal\n",
-- 
2.7.0
