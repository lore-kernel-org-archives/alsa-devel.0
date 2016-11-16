From: mengdong.lin@linux.intel.com
Subject: [PATCH 3/7] topology: Parse physical DAIs in text conf
	file
Date: Wed, 16 Nov 2016 14:42:33 +0800
Message-ID: <1f422f8b916c098f4cab848790ba06d3d4847c3b.1479277829.git.mengdong.lin@linux.intel.com>
References: <cover.1479277829.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 8BDDE266C3D
 for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2016 07:40:47 +0100 (CET)
In-Reply-To: <cover.1479277829.git.mengdong.lin@linux.intel.com>
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

Add support for parsing physical DAIs in the text configuration file.
The syntax of physical DAIs is described in document in topology.h

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/topology.h b/include/topology.h
index c52c580..0581b1c 100644
--- a/include/topology.h
+++ b/include/topology.h
@@ -663,6 +663,36 @@ extern "C" {
  * }
  * </pre>
  *
+ * <h4>Physical DAI</h4>
+ * A physical DAI (e.g. backend DAI for DPCM) is defined as a new section
+ * that can include a unique ID, playback and capture stream capabilities,
+ * optional flags, and private data. <br>
+ * Its PCM stream capablities are same as those for PCM objects,
+ * please refer to section 'PCM Capabilities'.
+ *
+ * <pre>
+ * SectionDAI."name" {
+ *
+ *	index "1"			# Index number
+ *
+ *	id "0"				# used for binding to the Backend DAI
+ *
+ *	pcm."playback" {
+ *		capabilities "capabilities1"	# capabilities for playback
+ *	}
+ *
+ *	pcm."capture" {
+ *		capabilities "capabilities2"	# capabilities for capture
+ *	}
+ *
+ *	symmetric_rates "true"			# optional flags
+ *	symmetric_channels "true"
+ *	symmetric_sample_bits "false"
+ *
+ *	data "name"			# optional private data
+ * }
+ * </pre>
+ *
  * <h4>Manifest Private Data</h4>
  * Manfiest may have private data. Users need to define a manifest section
  * and add the references to 1 or multiple data sections. Please refer to
@@ -735,6 +765,7 @@ enum snd_tplg_type {
 	SND_TPLG_TYPE_TUPLE,		/*!< Vendor tuples */
 	SND_TPLG_TYPE_LINK,		/*!< Physical DAI link */
 	SND_TPLG_TYPE_HW_CONFIG,	/*!< Link HW config */
+	SND_TPLG_TYPE_DAI,		/*!< Physical DAI */
 };
 
 /**
diff --git a/src/topology/data.c b/src/topology/data.c
index 59bc970..0d5c430 100644
--- a/src/topology/data.c
+++ b/src/topology/data.c
@@ -46,6 +46,10 @@ struct snd_soc_tplg_private *get_priv_data(struct tplg_elem *elem)
 		priv = &elem->widget->priv;
 		break;
 
+	case SND_TPLG_TYPE_DAI:
+		priv = &elem->dai->priv;
+		break;
+
 	default:
 		SNDERR("error: '%s': no support for private data for type %d\n",
 			elem->id, elem->type);
diff --git a/src/topology/elem.c b/src/topology/elem.c
index 01dce1f..1a5ac84 100644
--- a/src/topology/elem.c
+++ b/src/topology/elem.c
@@ -192,6 +192,10 @@ struct tplg_elem* tplg_elem_new_common(snd_tplg_t *tplg,
 		list_add_tail(&elem->list, &tplg->pcm_list);
 		obj_size = sizeof(struct snd_soc_tplg_pcm);
 		break;
+	case SND_TPLG_TYPE_DAI:
+		list_add_tail(&elem->list, &tplg->dai_list);
+		obj_size = sizeof(struct snd_soc_tplg_dai);
+		break;
 	case SND_TPLG_TYPE_BE:
 	case SND_TPLG_TYPE_LINK:
 		list_add_tail(&elem->list, &tplg->be_list);
diff --git a/src/topology/parser.c b/src/topology/parser.c
index 7d0486c..72efef4 100644
--- a/src/topology/parser.c
+++ b/src/topology/parser.c
@@ -133,6 +133,14 @@ static int tplg_parse_config(snd_tplg_t *tplg, snd_config_t *cfg)
 			continue;
 		}
 
+		if (strcmp(id, "SectionDAI") == 0) {
+			err = tplg_parse_compound(tplg, n,
+				tplg_parse_dai, NULL);
+			if (err < 0)
+				return err;
+			continue;
+		}
+
 		if (strcmp(id, "SectionHWConfig") == 0) {
 			err = tplg_parse_compound(tplg, n, tplg_parse_hw_config,
 				NULL);
@@ -450,6 +458,7 @@ snd_tplg_t *snd_tplg_new(void)
 	INIT_LIST_HEAD(&tplg->tlv_list);
 	INIT_LIST_HEAD(&tplg->widget_list);
 	INIT_LIST_HEAD(&tplg->pcm_list);
+	INIT_LIST_HEAD(&tplg->dai_list);
 	INIT_LIST_HEAD(&tplg->be_list);
 	INIT_LIST_HEAD(&tplg->cc_list);
 	INIT_LIST_HEAD(&tplg->route_list);
@@ -476,6 +485,7 @@ void snd_tplg_free(snd_tplg_t *tplg)
 	tplg_elem_free_list(&tplg->tlv_list);
 	tplg_elem_free_list(&tplg->widget_list);
 	tplg_elem_free_list(&tplg->pcm_list);
+	tplg_elem_free_list(&tplg->dai_list);
 	tplg_elem_free_list(&tplg->be_list);
 	tplg_elem_free_list(&tplg->cc_list);
 	tplg_elem_free_list(&tplg->route_list);
diff --git a/src/topology/pcm.c b/src/topology/pcm.c
index a9d3277..4093e2f 100644
--- a/src/topology/pcm.c
+++ b/src/topology/pcm.c
@@ -341,6 +341,7 @@ static int tplg_parse_streams(snd_tplg_t *tplg ATTRIBUTE_UNUSED,
 	snd_config_t *n;
 	struct tplg_elem *elem = private;
 	struct snd_soc_tplg_pcm *pcm;
+	struct snd_soc_tplg_dai *dai;
 	unsigned int *playback, *capture;
 	struct snd_soc_tplg_stream_caps *caps;
 	const char *id, *value;
@@ -357,6 +358,14 @@ static int tplg_parse_streams(snd_tplg_t *tplg ATTRIBUTE_UNUSED,
 		capture = &pcm->capture;
 		caps = pcm->caps;
 		break;
+
+	case SND_TPLG_TYPE_DAI:
+		dai = elem->dai;
+		playback = &dai->playback;
+		capture = &dai->capture;
+		caps = dai->caps;
+		break;
+
 	default:
 		return -EINVAL;
 	}
@@ -557,6 +566,109 @@ int tplg_parse_pcm(snd_tplg_t *tplg,
 	return 0;
 }
 
+/* Parse physical DAI */
+int tplg_parse_dai(snd_tplg_t *tplg,
+	snd_config_t *cfg, void *private ATTRIBUTE_UNUSED)
+{
+	struct snd_soc_tplg_dai *dai;
+	struct tplg_elem *elem;
+	snd_config_iterator_t i, next;
+	snd_config_t *n;
+	const char *id, *val = NULL;
+	int err;
+
+	elem = tplg_elem_new_common(tplg, cfg, NULL, SND_TPLG_TYPE_DAI);
+	if (!elem)
+		return -ENOMEM;
+
+	dai = elem->dai;
+	dai->size = elem->size;
+	elem_copy_text(dai->dai_name, elem->id,
+		SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
+
+	tplg_dbg(" DAI: %s\n", elem->id);
+
+	snd_config_for_each(i, next, cfg) {
+
+		n = snd_config_iterator_entry(i);
+		if (snd_config_get_id(n, &id) < 0)
+			continue;
+
+		/* skip comments */
+		if (strcmp(id, "comment") == 0)
+			continue;
+		if (id[0] == '#')
+			continue;
+
+		if (strcmp(id, "index") == 0) {
+			if (snd_config_get_string(n, &val) < 0)
+				return -EINVAL;
+
+			elem->index = atoi(val);
+			tplg_dbg("\t%s: %d\n", id, elem->index);
+			continue;
+		}
+
+		if (strcmp(id, "id") == 0) {
+			if (snd_config_get_string(n, &val) < 0)
+				return -EINVAL;
+
+			dai->dai_id = atoi(val);
+			tplg_dbg("\t%s: %d\n", id, dai->dai_id);
+			continue;
+		}
+
+		/* stream capabilities */
+		if (strcmp(id, "pcm") == 0) {
+			err = tplg_parse_compound(tplg, n,
+				tplg_parse_streams, elem);
+			if (err < 0)
+				return err;
+			continue;
+		}
+
+		/* flags */
+		if (strcmp(id, "symmetric_rates") == 0) {
+			err = parse_flag(n,
+				SND_SOC_TPLG_DAI_FLGBIT_SYMMETRIC_RATES,
+				&dai->flag_mask, &dai->flags);
+			if (err < 0)
+				return err;
+			continue;
+		}
+
+		if (strcmp(id, "symmetric_channels") == 0) {
+			err = parse_flag(n,
+				SND_SOC_TPLG_DAI_FLGBIT_SYMMETRIC_CHANNELS,
+				&dai->flag_mask, &dai->flags);
+			if (err < 0)
+				return err;
+			continue;
+		}
+
+		if (strcmp(id, "symmetric_sample_bits") == 0) {
+			err = parse_flag(n,
+				SND_SOC_TPLG_DAI_FLGBIT_SYMMETRIC_SAMPLEBITS,
+				&dai->flag_mask, &dai->flags);
+			if (err < 0)
+				return err;
+			continue;
+		}
+
+		/* private data */
+		if (strcmp(id, "data") == 0) {
+			if (snd_config_get_string(n, &val) < 0)
+				return -EINVAL;
+
+			tplg_ref_add(elem, SND_TPLG_TYPE_DATA, val);
+			tplg_dbg("\t%s: %s\n", id, val);
+			continue;
+		}
+	}
+
+	return 0;
+}
+
 /* parse physical link runtime supported HW configs in text conf file */
 static int parse_hw_config_refs(snd_tplg_t *tplg, snd_config_t *cfg,
 				struct tplg_elem *elem)
diff --git a/src/topology/tplg_local.h b/src/topology/tplg_local.h
index 9e67bf8..eeeb0f1 100644
--- a/src/topology/tplg_local.h
+++ b/src/topology/tplg_local.h
@@ -64,6 +64,7 @@ struct snd_tplg {
 	struct list_head tlv_list;
 	struct list_head widget_list;
 	struct list_head pcm_list;
+	struct list_head dai_list;
 	struct list_head be_list;
 	struct list_head cc_list;
 	struct list_head route_list;
@@ -145,6 +146,7 @@ struct tplg_elem {
 		struct snd_soc_tplg_bytes_control *bytes_ext;
 		struct snd_soc_tplg_dapm_widget *widget;
 		struct snd_soc_tplg_pcm *pcm;
+		struct snd_soc_tplg_dai *dai;
 		struct snd_soc_tplg_link_config *link;/* physical link */
 		struct snd_soc_tplg_dapm_graph_elem *route;
 		struct snd_soc_tplg_stream *stream_cfg;
@@ -222,6 +224,9 @@ int tplg_parse_stream_caps(snd_tplg_t *tplg,
 int tplg_parse_pcm(snd_tplg_t *tplg,
 	snd_config_t *cfg, void *private ATTRIBUTE_UNUSED);
 
+int tplg_parse_dai(snd_tplg_t *tplg, snd_config_t *cfg,
+		   void *private ATTRIBUTE_UNUSED);
+
 int tplg_parse_link(snd_tplg_t *tplg,
 	snd_config_t *cfg, void *private ATTRIBUTE_UNUSED);
 
-- 
2.5.0
