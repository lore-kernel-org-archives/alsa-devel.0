From: mengdong.lin@linux.intel.com
Subject: [PATCH v2 11/11] ASoC: topology: Able to create BE DAI
	links
Date: Fri,  9 Sep 2016 19:46:59 +0800
Message-ID: <ba747bcb41db2b6efec4b131d793135165cabc69.1473420558.git.mengdong.lin@linux.intel.com>
References: <cover.1473420558.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id AFD2226646C
 for <alsa-devel@alsa-project.org>; Fri,  9 Sep 2016 13:40:50 +0200 (CEST)
In-Reply-To: <cover.1473420558.git.mengdong.lin@linux.intel.com>
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

Topology will check with ASoC if a BE (Backend) link already exists by
checking its ID. If the BE link doesn't exist, topology will create it
and the link_load ops and card's add_dai_link will be called for machine
specific init.

The reason we need topology to create BE DAI links is same as that for
BE DAIs: Due to the SoC pin count limitation, not all the interface
pins are taken out of the SoC to connect various peripherals. Sometimes
BIOS does have enough info about the physical pin output types and their
connections to peripherals while we want to create BE DAI links based on
what is actually used on a platform. So we choose topology to give us such
info and help driver to create BE links dynamically.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 17e0b74..3f71f1d 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -49,9 +49,10 @@
 #define SOC_TPLG_PASS_GRAPH		5
 #define SOC_TPLG_PASS_PINS		6
 #define SOC_TPLG_PASS_BE_DAI		7
+#define SOC_TPLG_PASS_LINK		8
 
 #define SOC_TPLG_PASS_START	SOC_TPLG_PASS_MANIFEST
-#define SOC_TPLG_PASS_END	SOC_TPLG_PASS_BE_DAI
+#define SOC_TPLG_PASS_END	SOC_TPLG_PASS_LINK
 
 struct soc_tplg {
 	const struct firmware *fw;
@@ -493,6 +494,7 @@ static void remove_link(struct snd_soc_component *comp,
 
 	list_del(&dobj->list);
 	snd_soc_remove_dai_link(comp->card, link);
+	kfree(link->codecs);
 	kfree(link);
 }
 
@@ -1631,6 +1633,29 @@ static void set_link_flags(struct snd_soc_dai_link *link,
 	if (flag_mask & SND_SOC_TPLG_LNK_FLGBIT_IGNORE_POWERDOWN_TIME)
 		link->ignore_pmdown_time =
 		flags & SND_SOC_TPLG_LNK_FLGBIT_IGNORE_POWERDOWN_TIME ? 1 : 0;
+
+	if (flag_mask & SND_SOC_TPLG_LNK_FLGBIT_SYMMETRIC_RATES)
+		link->symmetric_rates =
+			flags & SND_SOC_TPLG_LNK_FLGBIT_SYMMETRIC_RATES ? 1 : 0;
+
+	if (flag_mask & SND_SOC_TPLG_LNK_FLGBIT_SYMMETRIC_CHANNELS)
+		link->symmetric_channels =
+			flags & SND_SOC_TPLG_LNK_FLGBIT_SYMMETRIC_CHANNELS ?
+			1 : 0;
+
+	if (flag_mask & SND_SOC_TPLG_LNK_FLGBIT_SYMMETRIC_SAMPLEBITS)
+		link->symmetric_samplebits =
+			flags & SND_SOC_TPLG_LNK_FLGBIT_SYMMETRIC_SAMPLEBITS ?
+			1 : 0;
+
+	if (flag_mask & SND_SOC_TPLG_LNK_FLGBIT_DPCM_PLAYBACK)
+		link->dpcm_playback =
+			flags & SND_SOC_TPLG_LNK_FLGBIT_DPCM_PLAYBACK ? 1 : 0;
+
+	if (flag_mask & SND_SOC_TPLG_LNK_FLGBIT_DPCM_CAPTURE)
+		link->dpcm_capture =
+			flags & SND_SOC_TPLG_LNK_FLGBIT_DPCM_CAPTURE ? 1 : 0;
+
 }
 
 /* create the FE DAI link */
@@ -1862,6 +1887,189 @@ static int soc_tplg_be_dai_elems_load(struct soc_tplg *tplg,
 	return 0;
 }
 
+/* *
+ * set_be_link_hw_format - Set the HW audio format of the BE DAI link.
+ * @tplg: topology context
+ * @cfg: topology BE DAI link configs.
+ *
+ * Topology context contains a list of supported HW formats (configs) and
+ * a default format ID for the BE link. This function will use this default ID
+ * to choose the HW format to set the link's DAI format for init.
+ */
+static void set_be_link_hw_format(struct snd_soc_dai_link *link,
+			struct snd_soc_tplg_link_config *cfg)
+{
+	struct snd_soc_tplg_hw_config *hw_config;
+	unsigned char bclk_master, fsync_master;
+	unsigned char invert_bclk, invert_fsync;
+	int i;
+
+	for (i = 0; i < cfg->num_hw_configs; i++) {
+		hw_config = &cfg->hw_config[i];
+		if (hw_config->id != cfg->default_hw_config_id)
+			continue;
+
+		link->dai_fmt = hw_config->fmt & SND_SOC_DAIFMT_FORMAT_MASK;
+
+		/* clock signal polarity */
+		invert_bclk = hw_config->invert_bclk;
+		invert_fsync = hw_config->invert_fsync;
+		if (!invert_bclk && !invert_fsync)
+			link->dai_fmt |= SND_SOC_DAIFMT_NB_NF;
+		else if (!invert_bclk && invert_fsync)
+			link->dai_fmt |= SND_SOC_DAIFMT_NB_IF;
+		else if (invert_bclk && !invert_fsync)
+			link->dai_fmt |= SND_SOC_DAIFMT_IB_NF;
+		else
+			link->dai_fmt |= SND_SOC_DAIFMT_IB_IF;
+
+		/* clock masters */
+		bclk_master = hw_config->bclk_master;
+		fsync_master = hw_config->fsync_master;
+		if (!bclk_master && !fsync_master)
+			link->dai_fmt |= SND_SOC_DAIFMT_CBM_CFM;
+		else if (bclk_master && !fsync_master)
+			link->dai_fmt |= SND_SOC_DAIFMT_CBS_CFM;
+		else if (!bclk_master && fsync_master)
+			link->dai_fmt |= SND_SOC_DAIFMT_CBM_CFS;
+		else
+			link->dai_fmt |= SND_SOC_DAIFMT_CBS_CFS;
+
+		return;
+	}
+}
+
+/* create a BE DAI link */
+static int soc_tplg_be_link_create(struct soc_tplg *tplg,
+	struct snd_soc_tplg_link_config *cfg)
+{
+	struct snd_soc_dai_link *link;
+	int i, ret = 0;
+
+	dev_dbg(tplg->dev,
+		"Adding BE link %s, stream name %s\n",
+		cfg->name, cfg->stream_name);
+
+	link = kzalloc(sizeof(struct snd_soc_dai_link), GFP_KERNEL);
+	if (link == NULL)
+		return -ENOMEM;
+
+	/* id and names */
+	if (strlen(cfg->name))
+		link->name = cfg->name;
+	if (strlen(cfg->stream_name))
+		link->stream_name = cfg->stream_name;
+	link->id = cfg->id;
+
+	/* components */
+	if (strlen(cfg->cpu.name))
+		link->cpu_name = cfg->cpu.name;
+	link->cpu_dai_name = cfg->cpu.dai_name;
+
+	if (!cfg->num_codecs || !cfg->codecs) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	link->num_codecs = cfg->num_codecs;
+	link->codecs = kcalloc(link->num_codecs,
+			       sizeof(struct snd_soc_dai_link_component),
+			       GFP_KERNEL);
+	if (!link->codecs) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	for (i = 0; i < link->num_codecs ; i++) {
+		if (strlen(cfg->codecs[i].name))
+			link->codecs[i].name = cfg->codecs[i].name;
+		link->codecs[i].dai_name = cfg->codecs[i].dai_name;
+	}
+
+	/* hw format */
+	if (cfg->num_hw_configs)
+		set_be_link_hw_format(link, cfg);
+
+	/* flags */
+	link->no_pcm = 1;
+	if (cfg->flag_mask)
+		set_link_flags(link, cfg->flag_mask, cfg->flags);
+
+	/* pass control to component driver for optional further init */
+	ret = soc_tplg_dai_link_load(tplg, link);
+	if (ret < 0) {
+		dev_err(tplg->dev, "ASoC: BE link loading failed\n");
+		goto err;
+	}
+
+	link->dobj.index = tplg->index;
+	link->dobj.ops = tplg->ops;
+	link->dobj.type = SND_SOC_DOBJ_DAI_LINK;
+	list_add(&link->dobj.list, &tplg->comp->dobj_list);
+
+	snd_soc_add_dai_link(tplg->comp->card, link);
+	return 0;
+
+err:
+	if (link) {
+		kfree(link->codecs);
+		kfree(link->params);
+		kfree(link);
+	}
+
+	return ret;
+}
+
+/* Config an existing or create a new BE DAI link */
+static int soc_tplg_be_link_config(struct soc_tplg *tplg,
+	struct snd_soc_tplg_link_config *cfg)
+{
+	struct snd_soc_dai_link *link;
+
+	link = snd_soc_find_dai_link(tplg->comp->card, cfg->id);
+	if (!link)
+		return soc_tplg_be_link_create(tplg, cfg);
+
+	/* TODO: configure existing BE links. No user request atm. */
+	return 0;
+}
+
+
+/* Load BE link elements from the topology context */
+static int soc_tplg_be_link_elems_load(struct soc_tplg *tplg,
+	struct snd_soc_tplg_hdr *hdr)
+{
+	struct snd_soc_tplg_link_config *link;
+	int count = hdr->count;
+	int i;
+
+	if (tplg->pass != SOC_TPLG_PASS_LINK) {
+		tplg->pos += hdr->size + hdr->payload_size;
+		return 0;
+	};
+
+	if (soc_tplg_check_elem_count(tplg,
+		sizeof(struct snd_soc_tplg_link_config), count,
+		hdr->payload_size, "BE DAI link")) {
+		dev_err(tplg->dev, "ASoC: invalid count %d for BE DAI link elems\n",
+			count);
+		return -EINVAL;
+	}
+
+	/* config or create the BE DAI links */
+	for (i = 0; i < count; i++) {
+		link = (struct snd_soc_tplg_link_config *)tplg->pos;
+		if (link->size != sizeof(*link)) {
+			dev_err(tplg->dev, "ASoC: invalid link config size\n");
+			return -EINVAL;
+		}
+
+		soc_tplg_be_link_config(tplg, link);
+		tplg->pos += (sizeof(*link) + link->priv.size);
+	}
+
+	return 0;
+}
 
 static int soc_tplg_manifest_load(struct soc_tplg *tplg,
 				  struct snd_soc_tplg_hdr *hdr)
@@ -1968,6 +2176,8 @@ static int soc_tplg_load_header(struct soc_tplg *tplg,
 		return soc_tplg_pcm_elems_load(tplg, hdr);
 	case SND_SOC_TPLG_TYPE_BE_DAI:
 		return soc_tplg_be_dai_elems_load(tplg, hdr);
+	case SND_SOC_TPLG_TYPE_BACKEND_LINK:
+		return soc_tplg_be_link_elems_load(tplg, hdr);
 	case SND_SOC_TPLG_TYPE_MANIFEST:
 		return soc_tplg_manifest_load(tplg, hdr);
 	default:
-- 
2.5.0
