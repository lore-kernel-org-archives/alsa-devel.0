From: mengdong.lin@linux.intel.com
Subject: [PATCH 09/13] topology: Parse HW configurations of
	physical DAI links in text conf file
Date: Sun,  6 Nov 2016 13:14:04 +0800
Message-ID: <9850053565f494d3188bd523399fe0626bb422e8.1478407716.git.mengdong.lin@linux.intel.com>
References: <cover.1478407716.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id C2C612665B0
 for <alsa-devel@alsa-project.org>; Sun,  6 Nov 2016 06:12:35 +0100 (CET)
In-Reply-To: <cover.1478407716.git.mengdong.lin@linux.intel.com>
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

Users can configure the runtime supported HW configurations of a physical
link by SectionHWConfig. A physical link can refer multiple HW config
sections in SectionLink.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/topology.h b/include/topology.h
index 0978ccf..85818ac 100644
--- a/include/topology.h
+++ b/include/topology.h
@@ -631,10 +631,31 @@ extern "C" {
  *
  *	id "0"				# used for binding to the link
  *
+ *	hw_configs [	# runtime supported HW configurations, optional
+ *		"config1"
+ *		"config2"
+ *		...
+ *	]
+ *
+ *	default_hw_conf_id "1"		#default HW config ID for init
+ *
  *	data "name"			# optional private data
  * }
  * </pre>
  *
+ * A physical link can refer to multiple runtime supported hardware
+ * configurations, which is defined by SectionHWConfig.
+ *
+ * <pre>
+ * SectionHWConfig."name" {
+ *
+ *	id "1"				# used for binding to the config
+ *	format "I2S"			# physical audio format.
+ *	bclk   "master"			# Platform is master of bit clock
+ *	fsync  "slave"			# Platform is slave of fsync
+ * }
+ * </pre>
+ *
  * <h4>Manifest Private Data</h4>
  * Manfiest may have private data. Users need to define a manifest section
  * and add the references to 1 or multiple data sections. Please refer to
@@ -706,6 +727,7 @@ enum snd_tplg_type {
 	SND_TPLG_TYPE_TOKEN,		/*!< Vendor tokens */
 	SND_TPLG_TYPE_TUPLE,		/*!< Vendor tuples */
 	SND_TPLG_TYPE_LINK,		/*!< Physical DAI link */
+	SND_TPLG_TYPE_HW_CONFIG,	/*!< Link HW config */
 };
 
 /**
diff --git a/src/topology/elem.c b/src/topology/elem.c
index f7ff070..01dce1f 100644
--- a/src/topology/elem.c
+++ b/src/topology/elem.c
@@ -208,6 +208,10 @@ struct tplg_elem* tplg_elem_new_common(snd_tplg_t *tplg,
 		list_add_tail(&elem->list, &tplg->tuple_list);
 		elem->free = tplg_free_tuples;
 		break;
+	case SND_TPLG_TYPE_HW_CONFIG:
+		list_add_tail(&elem->list, &tplg->hw_cfg_list);
+		obj_size = sizeof(struct snd_soc_tplg_hw_config);
+		break;
 	default:
 		free(elem);
 		return NULL;
diff --git a/src/topology/parser.c b/src/topology/parser.c
index 238943c..7d0486c 100644
--- a/src/topology/parser.c
+++ b/src/topology/parser.c
@@ -133,6 +133,14 @@ static int tplg_parse_config(snd_tplg_t *tplg, snd_config_t *cfg)
 			continue;
 		}
 
+		if (strcmp(id, "SectionHWConfig") == 0) {
+			err = tplg_parse_compound(tplg, n, tplg_parse_hw_config,
+				NULL);
+			if (err < 0)
+				return err;
+			continue;
+		}
+
 		if (strcmp(id, "SectionLink") == 0
 			|| strcmp(id, "SectionBE") == 0) {
 			err = tplg_parse_compound(tplg, n, tplg_parse_link,
@@ -455,6 +463,7 @@ snd_tplg_t *snd_tplg_new(void)
 	INIT_LIST_HEAD(&tplg->bytes_ext_list);
 	INIT_LIST_HEAD(&tplg->token_list);
 	INIT_LIST_HEAD(&tplg->tuple_list);
+	INIT_LIST_HEAD(&tplg->hw_cfg_list);
 
 	return tplg;
 }
@@ -480,6 +489,7 @@ void snd_tplg_free(snd_tplg_t *tplg)
 	tplg_elem_free_list(&tplg->bytes_ext_list);
 	tplg_elem_free_list(&tplg->token_list);
 	tplg_elem_free_list(&tplg->tuple_list);
+	tplg_elem_free_list(&tplg->hw_cfg_list);
 
 	free(tplg);
 }
diff --git a/src/topology/pcm.c b/src/topology/pcm.c
index 7b67d91..e92d2b9 100644
--- a/src/topology/pcm.c
+++ b/src/topology/pcm.c
@@ -162,6 +162,34 @@ static int build_link(snd_tplg_t *tplg, struct tplg_elem *elem)
 	if (err < 0)
 		return err;
 
+	/* hw configs */
+	base = &elem->ref_list;
+	list_for_each(pos, base) {
+
+		ref = list_entry(pos, struct tplg_ref, list);
+
+		switch (ref->type) {
+		case SND_TPLG_TYPE_HW_CONFIG:
+			ref->elem = tplg_elem_lookup(&tplg->hw_cfg_list,
+					ref->id, SND_TPLG_TYPE_HW_CONFIG);
+			if (!ref->elem) {
+				SNDERR("error: cannot find HW config '%s'"
+				" referenced by link '%s'\n",
+				ref->id, elem->id);
+				return -EINVAL;
+			}
+
+			memcpy(&link->hw_config[num_hw_configs],
+				ref->elem->hw_cfg,
+				sizeof(struct snd_soc_tplg_hw_config));
+			num_hw_configs++;
+			break;
+
+		default:
+			break;
+		}
+	}
+
 	/* add link to manifest */
 	tplg->manifest.dai_link_elems++;
 
@@ -523,6 +551,54 @@ int tplg_parse_pcm(snd_tplg_t *tplg,
 	return 0;
 }
 
+/* parse physical link runtime supported HW configs in text conf file */
+static int parse_hw_config_refs(snd_tplg_t *tplg, snd_config_t *cfg,
+				struct tplg_elem *elem)
+{
+	struct snd_soc_tplg_link_config *link = elem->link;
+	snd_config_type_t  type;
+	snd_config_iterator_t i, next;
+	snd_config_t *n;
+	const char *id, *val = NULL;
+
+	if (snd_config_get_id(cfg, &id) < 0)
+		return -EINVAL;
+	type = snd_config_get_type(cfg);
+
+	/* refer to a single HW config */
+	if (type == SND_CONFIG_TYPE_STRING) {
+		if (snd_config_get_string(cfg, &val) < 0)
+			return -EINVAL;
+
+		link->num_hw_configs = 1;
+		return tplg_ref_add(elem, SND_TPLG_TYPE_HW_CONFIG, val);
+	}
+
+	if (type != SND_CONFIG_TYPE_COMPOUND) {
+		SNDERR("error: compound type expected for %s", id);
+		return -EINVAL;
+	}
+
+	/* refer to a list of HW configs */
+	snd_config_for_each(i, next, cfg) {
+		const char *val;
+
+		n = snd_config_iterator_entry(i);
+		if (snd_config_get_string(n, &val) < 0)
+			continue;
+
+		if (link->num_hw_configs >= SND_SOC_TPLG_HW_CONFIG_MAX) {
+			SNDERR("error: exceed max hw configs for link %s", id);
+			return -EINVAL;
+		}
+
+		link->num_hw_configs++;
+		return tplg_ref_add(elem, SND_TPLG_TYPE_HW_CONFIG, val);
+	}
+
+	return 0;
+}
+
 /* Parse a physical link element in text conf file */
 int tplg_parse_link(snd_tplg_t *tplg,
 	snd_config_t *cfg, void *private ATTRIBUTE_UNUSED)
@@ -573,6 +649,21 @@ int tplg_parse_link(snd_tplg_t *tplg,
 			continue;
 		}
 
+		if (strcmp(id, "hw_configs") == 0) {
+			err = parse_hw_config_refs(tplg, n, elem);
+			if (err < 0)
+				return err;
+			continue;
+		}
+
+		if (strcmp(id, "default_hw_conf_id") == 0) {
+			if (snd_config_get_string(n, &val) < 0)
+				return -EINVAL;
+
+			link->default_hw_config_id = atoi(val);
+			continue;
+		}
+
 		if (strcmp(id, "data") == 0) {
 			err = tplg_parse_data_refs(n, elem);
 			if (err < 0)
@@ -638,6 +729,110 @@ int tplg_parse_cc(snd_tplg_t *tplg,
 	return 0;
 }
 
+static int get_audio_hw_format(const char *val)
+{
+	if (!strlen(val))
+		return -EINVAL;
+
+	if (!strcmp(val, "I2S"))
+		return SND_SOC_DAI_FORMAT_I2S;
+
+	if (!strcmp(val, "RIGHT_J"))
+		return SND_SOC_DAI_FORMAT_RIGHT_J;
+
+	if (!strcmp(val, "LEFT_J"))
+		return SND_SOC_DAI_FORMAT_LEFT_J;
+
+	if (!strcmp(val, "DSP_A"))
+		return SND_SOC_DAI_FORMAT_DSP_A;
+
+	if (!strcmp(val, "LEFT_B"))
+		return SND_SOC_DAI_FORMAT_DSP_B;
+
+	if (!strcmp(val, "AC97"))
+		return SND_SOC_DAI_FORMAT_AC97;
+
+	if (!strcmp(val, "PDM"))
+		return SND_SOC_DAI_FORMAT_PDM;
+
+	SNDERR("error: invalid audio HW format %s\n", val);
+	return -EINVAL;
+}
+
+int tplg_parse_hw_config(snd_tplg_t *tplg, snd_config_t *cfg,
+			 void *private ATTRIBUTE_UNUSED)
+{
+
+	struct snd_soc_tplg_hw_config *hw_cfg;
+	struct tplg_elem *elem;
+	snd_config_iterator_t i, next;
+	snd_config_t *n;
+	const char *id, *val = NULL;
+	int ret;
+
+	elem = tplg_elem_new_common(tplg, cfg, NULL, SND_TPLG_TYPE_HW_CONFIG);
+	if (!elem)
+		return -ENOMEM;
+
+	hw_cfg = elem->hw_cfg;
+	hw_cfg->size = elem->size;
+
+	tplg_dbg(" Link HW config: %s\n", elem->id);
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
+		if (strcmp(id, "id") == 0) {
+			if (snd_config_get_string(n, &val) < 0)
+				return -EINVAL;
+
+			hw_cfg->id = atoi(val);
+			tplg_dbg("\t%s: %d\n", id, hw_cfg->id);
+			continue;
+		}
+
+		if (strcmp(id, "format") == 0) {
+			if (snd_config_get_string(n, &val) < 0)
+				return -EINVAL;
+
+			ret = get_audio_hw_format(val);
+			if (ret < 0)
+				return ret;
+			hw_cfg->fmt = ret;
+			continue;
+		}
+
+		if (strcmp(id, "bclk") == 0) {
+			if (snd_config_get_string(n, &val) < 0)
+				return -EINVAL;
+
+			if (!strcmp(val, "master"))
+				hw_cfg->bclk_master = true;
+			continue;
+		}
+
+		if (strcmp(id, "fsync") == 0) {
+			if (snd_config_get_string(n, &val) < 0)
+				return -EINVAL;
+
+			if (!strcmp(val, "master"))
+				hw_cfg->fsync_master = true;
+			continue;
+		}
+	}
+
+	return 0;
+}
+
 /* copy stream object */
 static void tplg_add_stream_object(struct snd_soc_tplg_stream *strm,
 				struct snd_tplg_stream_template *strm_tpl)
diff --git a/src/topology/tplg_local.h b/src/topology/tplg_local.h
index 947f27e..9e67bf8 100644
--- a/src/topology/tplg_local.h
+++ b/src/topology/tplg_local.h
@@ -74,6 +74,7 @@ struct snd_tplg {
 	struct list_head manifest_list;
 	struct list_head pcm_config_list;
 	struct list_head pcm_caps_list;
+	struct list_head hw_cfg_list;
 
 	/* type-specific control lists */
 	struct list_head mixer_list;
@@ -148,6 +149,7 @@ struct tplg_elem {
 		struct snd_soc_tplg_dapm_graph_elem *route;
 		struct snd_soc_tplg_stream *stream_cfg;
 		struct snd_soc_tplg_stream_caps *stream_caps;
+		struct snd_soc_tplg_hw_config *hw_cfg;
 
 		/* these do not map to UAPI structs but are internal only */
 		struct snd_soc_tplg_ctl_tlv *tlv;
@@ -226,6 +228,9 @@ int tplg_parse_link(snd_tplg_t *tplg,
 int tplg_parse_cc(snd_tplg_t *tplg,
 	snd_config_t *cfg, void *private ATTRIBUTE_UNUSED);
 
+int tplg_parse_hw_config(snd_tplg_t *tplg, snd_config_t *cfg,
+			 void *private ATTRIBUTE_UNUSED);
+
 int tplg_build_data(snd_tplg_t *tplg);
 int tplg_build_manifest_data(snd_tplg_t *tplg);
 int tplg_build_controls(snd_tplg_t *tplg);
-- 
2.7.4
