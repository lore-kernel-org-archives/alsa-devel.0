From: mengdong.lin@linux.intel.com
Subject: [PATCH 2/5] topology: Parse BE DAIs in text conf file
Date: Mon,  3 Oct 2016 23:04:01 +0800
Message-ID: <dbd74209bfd651da18a02b148971c35268996867.1475505267.git.mengdong.lin@linux.intel.com>
References: <cover.1475505267.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id B0BD6266B91
 for <alsa-devel@alsa-project.org>; Mon,  3 Oct 2016 17:03:23 +0200 (CEST)
In-Reply-To: <cover.1475505267.git.mengdong.lin@linux.intel.com>
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

From: Guneshwor Singh <guneshwor.o.singh@intel.com>

Add support for parsing BE (Back End) DAIs in the text configuration file.
The syntax of BE DAIs is described in document in topology.h

Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/topology.h b/include/topology.h
index 0675b52..da45848 100644
--- a/include/topology.h
+++ b/include/topology.h
@@ -609,6 +609,33 @@ extern "C" {
  * }
  * </pre>
  *
+ * <h4>Back End DAI</h4>
+ * A BE (Back End) DAI is defined as a new section that can include a
+ * unique ID, playback and capture stream capabilities and optional flags.
+ * <br> Its PCM stream capablities are same as those for PCM objects,
+ * please refer to section 'PCM Capabilities'.
+ *
+ * <pre>
+ * SectionBEDAI."name" {
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
+ * }
+ * </pre>
+ *
  * <h4>Manifest Private Data</h4>
  * Manfiest may have private data. Users need to define a manifest section
  * and add the references to 1 or multiple data sections. Please refer to
@@ -644,6 +671,7 @@ enum snd_tplg_type {
 	SND_TPLG_TYPE_PCM,		/*!< PCM stream device */
 	SND_TPLG_TYPE_DAPM_WIDGET,	/*!< DAPM widget */
 	SND_TPLG_TYPE_DAPM_GRAPH,	/*!< DAPM graph elements */
+	SND_TPLG_TYPE_BE_DAI,
 	SND_TPLG_TYPE_BE,		/*!< BE DAI link */
 	SND_TPLG_TYPE_CC,		/*!< Hostless codec <-> codec link */
 	SND_TPLG_TYPE_MANIFEST,		/*!< Topology manifest */
diff --git a/src/topology/data.c b/src/topology/data.c
index 59bc970..4798086 100644
--- a/src/topology/data.c
+++ b/src/topology/data.c
@@ -46,6 +46,10 @@ struct snd_soc_tplg_private *get_priv_data(struct tplg_elem *elem)
 		priv = &elem->widget->priv;
 		break;
 
+	case SND_TPLG_TYPE_BE_DAI:
+		priv = &elem->be_dai->priv;
+		break;
+
 	default:
 		SNDERR("error: '%s': no support for private data for type %d\n",
 			elem->id, elem->type);
diff --git a/src/topology/elem.c b/src/topology/elem.c
index 029c9ab..8b84257 100644
--- a/src/topology/elem.c
+++ b/src/topology/elem.c
@@ -189,6 +189,10 @@ struct tplg_elem* tplg_elem_new_common(snd_tplg_t *tplg,
 		list_add_tail(&elem->list, &tplg->pcm_list);
 		obj_size = sizeof(struct snd_soc_tplg_pcm);
 		break;
+	case SND_TPLG_TYPE_BE_DAI:
+		list_add_tail(&elem->list, &tplg->be_dai_list);
+		obj_size = sizeof(struct snd_soc_tplg_be_dai);
+		break;
 	case SND_TPLG_TYPE_BE:
 		list_add_tail(&elem->list, &tplg->be_list);
 		obj_size = sizeof(struct snd_soc_tplg_link_config);
diff --git a/src/topology/parser.c b/src/topology/parser.c
index 3ab64f4..aa1b33e 100644
--- a/src/topology/parser.c
+++ b/src/topology/parser.c
@@ -133,6 +133,14 @@ static int tplg_parse_config(snd_tplg_t *tplg, snd_config_t *cfg)
 			continue;
 		}
 
+		if (strcmp(id, "SectionBEDAI") == 0) {
+			err = tplg_parse_compound(tplg, n,
+				tplg_parse_be_dai, NULL);
+			if (err < 0)
+				return err;
+			continue;
+		}
+
 		if (strcmp(id, "SectionBE") == 0) {
 			err = tplg_parse_compound(tplg, n, tplg_parse_be,
 				NULL);
@@ -440,6 +448,7 @@ snd_tplg_t *snd_tplg_new(void)
 	INIT_LIST_HEAD(&tplg->tlv_list);
 	INIT_LIST_HEAD(&tplg->widget_list);
 	INIT_LIST_HEAD(&tplg->pcm_list);
+	INIT_LIST_HEAD(&tplg->be_dai_list);
 	INIT_LIST_HEAD(&tplg->be_list);
 	INIT_LIST_HEAD(&tplg->cc_list);
 	INIT_LIST_HEAD(&tplg->route_list);
@@ -465,6 +474,7 @@ void snd_tplg_free(snd_tplg_t *tplg)
 	tplg_elem_free_list(&tplg->tlv_list);
 	tplg_elem_free_list(&tplg->widget_list);
 	tplg_elem_free_list(&tplg->pcm_list);
+	tplg_elem_free_list(&tplg->be_dai_list);
 	tplg_elem_free_list(&tplg->be_list);
 	tplg_elem_free_list(&tplg->cc_list);
 	tplg_elem_free_list(&tplg->route_list);
diff --git a/src/topology/pcm.c b/src/topology/pcm.c
index 0a90cb9..7e2f68f 100644
--- a/src/topology/pcm.c
+++ b/src/topology/pcm.c
@@ -266,6 +266,7 @@ static int tplg_parse_streams(snd_tplg_t *tplg ATTRIBUTE_UNUSED,
 	snd_config_t *n;
 	struct tplg_elem *elem = private;
 	struct snd_soc_tplg_pcm *pcm;
+	struct snd_soc_tplg_be_dai *be_dai;
 	unsigned int *playback, *capture;
 	struct snd_soc_tplg_stream_caps *caps;
 	const char *id, *value;
@@ -282,6 +283,14 @@ static int tplg_parse_streams(snd_tplg_t *tplg ATTRIBUTE_UNUSED,
 		capture = &pcm->capture;
 		caps = pcm->caps;
 		break;
+
+	case SND_TPLG_TYPE_BE_DAI:
+		be_dai = elem->be_dai;
+		playback = &be_dai->playback;
+		capture = &be_dai->capture;
+		caps = be_dai->caps;
+		break;
+
 	default:
 		return -EINVAL;
 	}
@@ -435,6 +444,123 @@ int tplg_parse_pcm(snd_tplg_t *tplg,
 	return 0;
 }
 
+static int get_be_dai_flag(snd_config_t *n,
+	struct snd_soc_tplg_be_dai *be_dai, unsigned int mask)
+{
+	const char *val = NULL;
+
+	if (snd_config_get_string(n, &val) < 0)
+		return -EINVAL;
+
+	be_dai->flag_mask |= mask;
+	if (strcmp(val, "true") == 0)
+		be_dai->flags |= mask;
+	else
+		be_dai->flags &= ~mask;
+
+	return 0;
+}
+
+/* Parse back end DAI */
+int tplg_parse_be_dai(snd_tplg_t *tplg,
+	snd_config_t *cfg, void *private ATTRIBUTE_UNUSED)
+{
+	struct snd_soc_tplg_be_dai *be_dai;
+	struct tplg_elem *elem;
+	snd_config_iterator_t i, next;
+	snd_config_t *n;
+	const char *id, *val = NULL;
+	int err;
+
+	elem = tplg_elem_new_common(tplg, cfg, NULL, SND_TPLG_TYPE_BE_DAI);
+	if (!elem)
+		return -ENOMEM;
+
+	be_dai = elem->be_dai;
+	be_dai->size = elem->size;
+	elem_copy_text(be_dai->dai_name, elem->id,
+		SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
+
+	tplg_dbg(" BE DAI: %s\n", elem->id);
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
+			be_dai->dai_id = atoi(val);
+			tplg_dbg("\t%s: %d\n", id, be_dai->dai_id);
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
+			err = get_be_dai_flag(n, be_dai,
+				SND_SOC_TPLG_DAI_FLGBIT_SYMMETRIC_RATES);
+			if (err < 0)
+				return err;
+			continue;
+		}
+
+		if (strcmp(id, "symmetric_channels") == 0) {
+			err = get_be_dai_flag(n, be_dai,
+				SND_SOC_TPLG_DAI_FLGBIT_SYMMETRIC_CHANNELS);
+			if (err < 0)
+				return err;
+			continue;
+		}
+
+		if (strcmp(id, "symmetric_sample_bits") == 0) {
+			err = get_be_dai_flag(n, be_dai,
+				SND_SOC_TPLG_DAI_FLGBIT_SYMMETRIC_SAMPLEBITS);
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
 int tplg_parse_be(snd_tplg_t *tplg,
 	snd_config_t *cfg, void *private ATTRIBUTE_UNUSED)
 {
diff --git a/src/topology/tplg_local.h b/src/topology/tplg_local.h
index cfde4cc..e548ade 100644
--- a/src/topology/tplg_local.h
+++ b/src/topology/tplg_local.h
@@ -64,6 +64,7 @@ struct snd_tplg {
 	struct list_head tlv_list;
 	struct list_head widget_list;
 	struct list_head pcm_list;
+	struct list_head be_dai_list;
 	struct list_head be_list;
 	struct list_head cc_list;
 	struct list_head route_list;
@@ -144,6 +145,7 @@ struct tplg_elem {
 		struct snd_soc_tplg_bytes_control *bytes_ext;
 		struct snd_soc_tplg_dapm_widget *widget;
 		struct snd_soc_tplg_pcm *pcm;
+		struct snd_soc_tplg_be_dai *be_dai;
 		struct snd_soc_tplg_link_config *be;
 		struct snd_soc_tplg_link_config *cc;
 		struct snd_soc_tplg_dapm_graph_elem *route;
@@ -221,6 +223,9 @@ int tplg_parse_stream_caps(snd_tplg_t *tplg,
 int tplg_parse_pcm(snd_tplg_t *tplg,
 	snd_config_t *cfg, void *private ATTRIBUTE_UNUSED);
 
+int tplg_parse_be_dai(snd_tplg_t *tplg,
+	snd_config_t *cfg, void *private ATTRIBUTE_UNUSED);
+
 int tplg_parse_be(snd_tplg_t *tplg,
 	snd_config_t *cfg, void *private ATTRIBUTE_UNUSED);
 
-- 
2.5.0
