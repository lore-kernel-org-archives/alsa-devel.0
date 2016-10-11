From: mengdong.lin@linux.intel.com
Subject: [PATCH v5 08/11] ASoC: topology: Add support to
	configure existing physical DAI links
Date: Tue, 11 Oct 2016 13:31:24 +0800
Message-ID: <880e2c45405ba6071979a86d6d80fbe1bba3fc44.1476162939.git.mengdong.lin@linux.intel.com>
References: <cover.1476162939.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id CCED32666C0
 for <alsa-devel@alsa-project.org>; Tue, 11 Oct 2016 07:30:32 +0200 (CEST)
In-Reply-To: <cover.1476162939.git.mengdong.lin@linux.intel.com>
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

Topology will find an existing physical link (including BE link for
DPCM) by checking its ID, name and stream name, and configure its physical
audio format and flags.

This support is backward compatible for old ABI v4.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 62d8a73..2964e39 100644
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
 
 /*
  * Old version of ABI structs, supported for backward compatibility.
@@ -101,6 +102,14 @@ struct snd_soc_tplg_pcm_v4 {
 	struct snd_soc_tplg_stream_caps_v4 caps[2]; /* playback and capture for DAI */
 } __packed;
 
+/* Physical link config v4 */
+struct snd_soc_tplg_link_config_v4 {
+	__le32 size;            /* in bytes of this structure */
+	__le32 id;              /* unique ID - used to match */
+	struct snd_soc_tplg_stream stream[SND_SOC_TPLG_STREAM_CONFIG_MAX]; /* supported configs playback and captrure */
+	__le32 num_streams;     /* number of streams */
+} __packed;
+
 /* topology context */
 struct soc_tplg {
 	const struct firmware *fw;
@@ -1876,7 +1885,6 @@ static int soc_tplg_pcm_elems_load(struct soc_tplg *tplg,
 		/* create the FE DAIs and DAI links */
 		soc_tplg_pcm_create(tplg, _pcm);
 
-
 		/* offset by version-specific struct size and
 		 * real priv data size
 		 */
@@ -1891,6 +1899,196 @@ static int soc_tplg_pcm_elems_load(struct soc_tplg *tplg,
 	return 0;
 }
 
+/**
+ * set_link_hw_format - Set the HW audio format of the physical DAI link.
+ * @tplg: topology context
+ * @cfg: physical link configs.
+ *
+ * Topology context contains a list of supported HW formats (configs) and
+ * a default format ID for the physical link. This function will use this
+ * default ID to choose the HW format to set the link's DAI format for init.
+ */
+static void set_link_hw_format(struct snd_soc_dai_link *link,
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
+	}
+}
+
+/**
+ * link_new_ver - Create a new physical link config from the old
+ * version of source.
+ * @toplogy: topology context
+ * @src: old version of phyical link config as a source
+ * @link: latest version of physical link config created from the source
+ *
+ * Support from vesion 4. User need free the returned link config manually.
+ */
+static int link_new_ver(struct soc_tplg *tplg,
+			struct snd_soc_tplg_link_config *src,
+			struct snd_soc_tplg_link_config **link)
+{
+	struct snd_soc_tplg_link_config *dest;
+	struct snd_soc_tplg_link_config_v4 *src_v4;
+	int i;
+
+	*link = NULL;
+
+	if (src->size != sizeof(struct snd_soc_tplg_link_config_v4)) {
+		dev_err(tplg->dev, "ASoC: invalid physical link config size\n");
+		return -EINVAL;
+	}
+
+	dev_warn(tplg->dev, "ASoC: old version of physical link config\n");
+
+	src_v4 = (struct snd_soc_tplg_link_config_v4 *)src;
+	dest = kzalloc(sizeof(*dest), GFP_KERNEL);
+	if (!dest)
+		return -ENOMEM;
+
+	dest->size = sizeof(*dest);
+	dest->id = src_v4->id;
+	dest->num_streams = src_v4->num_streams;
+	for (i = 0; i < dest->num_streams; i++)
+		memcpy(&dest->stream[i], &src_v4->stream[i],
+		       sizeof(struct snd_soc_tplg_stream));
+
+	*link = dest;
+	return 0;
+}
+
+/* Find and configure an existing physical DAI link */
+static int soc_tplg_link_config(struct soc_tplg *tplg,
+	struct snd_soc_tplg_link_config *cfg)
+{
+	struct snd_soc_dai_link *link;
+	const char *name, *stream_name;
+	int ret;
+
+	name = strlen(cfg->name) ? cfg->name : NULL;
+	stream_name = strlen(cfg->stream_name) ? cfg->stream_name : NULL;
+
+	link = snd_soc_find_dai_link(tplg->comp->card, cfg->id,
+				     name, stream_name);
+	if (!link) {
+		dev_err(tplg->dev, "ASoC: physical link %s (id %d) not exist\n",
+			name, cfg->id);
+		return -EINVAL;
+	}
+
+	/* hw format */
+	if (cfg->num_hw_configs)
+		set_link_hw_format(link, cfg);
+
+	/* flags */
+	if (cfg->flag_mask)
+		set_link_flags(link, cfg->flag_mask, cfg->flags);
+
+	/* pass control to component driver for optional further init */
+	ret = soc_tplg_dai_link_load(tplg, link);
+	if (ret < 0) {
+		dev_err(tplg->dev, "ASoC: physical link loading failed\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+
+/* Load physical link config elements from the topology context */
+static int soc_tplg_link_elems_load(struct soc_tplg *tplg,
+	struct snd_soc_tplg_hdr *hdr)
+{
+	struct snd_soc_tplg_link_config *link, *_link;
+	int count = hdr->count;
+	int i, ret;
+	bool abi_match;
+
+	if (tplg->pass != SOC_TPLG_PASS_LINK) {
+		tplg->pos += hdr->size + hdr->payload_size;
+		return 0;
+	};
+
+	/* check the element size and count */
+	link = (struct snd_soc_tplg_link_config *)tplg->pos;
+	if (link->size > sizeof(struct snd_soc_tplg_link_config)
+		|| link->size < sizeof(struct snd_soc_tplg_link_config_v4)) {
+		dev_err(tplg->dev, "ASoC: invalid size %d for physical link elems\n",
+			link->size);
+		return -EINVAL;
+	}
+
+	if (soc_tplg_check_elem_count(tplg,
+		link->size, count,
+		hdr->payload_size, "physical link config")) {
+		dev_err(tplg->dev, "ASoC: invalid count %d for physical link elems\n",
+			count);
+		return -EINVAL;
+	}
+
+	/* config physical DAI links */
+	for (i = 0; i < count; i++) {
+		link = (struct snd_soc_tplg_link_config *)tplg->pos;
+		if (link->size == sizeof(*link)) {
+			abi_match = true;
+			_link = link;
+		} else {
+			abi_match = false;
+			ret = link_new_ver(tplg, link, &_link);
+			if (ret < 0)
+				return ret;
+		}
+
+		ret = soc_tplg_link_config(tplg, _link);
+		if (ret < 0)
+			return ret;
+
+		/* offset by version-specific struct size and
+		 * real priv data size
+		 */
+		tplg->pos += link->size + _link->priv.size;
+
+		if (!abi_match)
+			kfree(_link); /* free the duplicated one */
+	}
+
+	return 0;
+}
+
 /* *
  * soc_tplg_be_dai_config - Find and configure an existing BE DAI.
  * @tplg: topology context
@@ -2140,6 +2338,10 @@ static int soc_tplg_load_header(struct soc_tplg *tplg,
 		return soc_tplg_pcm_elems_load(tplg, hdr);
 	case SND_SOC_TPLG_TYPE_BE_DAI:
 		return soc_tplg_be_dai_elems_load(tplg, hdr);
+	case SND_SOC_TPLG_TYPE_DAI_LINK:
+	case SND_SOC_TPLG_TYPE_BACKEND_LINK:
+		/* physical link configurations */
+		return soc_tplg_link_elems_load(tplg, hdr);
 	case SND_SOC_TPLG_TYPE_MANIFEST:
 		return soc_tplg_manifest_load(tplg, hdr);
 	default:
-- 
2.5.0
