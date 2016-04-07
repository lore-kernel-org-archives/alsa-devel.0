From: mengdong.lin@linux.intel.com
Subject: [PATCH v3 6/7] topology: Add support for parsing
	vendor tuples
Date: Thu,  7 Apr 2016 15:29:43 +0800
Message-ID: <0a5a828c0b70c0db40ea4ac197c10cc02172d7c6.1460013338.git.mengdong.lin@linux.intel.com>
References: <cover.1460013338.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 20FD2265177
 for <alsa-devel@alsa-project.org>; Thu,  7 Apr 2016 09:27:21 +0200 (CEST)
In-Reply-To: <cover.1460013338.git.mengdong.lin@linux.intel.com>
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, mengdong.lin@intel.com, vinod.koul@intel.com, rakesh.a.ughreja@intel.com, liam.r.girdwood@intel.com, hardik.t.shah@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

Vendor can define several tuple arrays in 'SectionVendorTuples', as
well as the reference to a vendor token list object.

A later patche will copy vendor tuples in ABI format to the private
buffer of its parent data object in the building phase.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/topology.h b/include/topology.h
index 0df112c..b47f422 100644
--- a/include/topology.h
+++ b/include/topology.h
@@ -579,6 +579,7 @@ enum snd_tplg_type {
 	SND_TPLG_TYPE_CC,		/*!< Hostless codec <-> codec link */
 	SND_TPLG_TYPE_MANIFEST,		/*!< Topology manifest */
 	SND_TPLG_TYPE_TOKEN,		/*!< Vendor tokens */
+	SND_TPLG_TYPE_TUPLE,		/*!< Vendor tuples */
 };
 
 /**
diff --git a/src/topology/data.c b/src/topology/data.c
index 8455c15..606fcd3 100644
--- a/src/topology/data.c
+++ b/src/topology/data.c
@@ -253,6 +253,175 @@ static int tplg_parse_data_hex(snd_config_t *cfg, struct tplg_elem *elem,
 	return ret;
 }
 
+static int parse_tuple_set(snd_tplg_t *tplg, snd_config_t *cfg,
+	struct tplg_tuple_set **s)
+{
+	snd_config_iterator_t i, next;
+	snd_config_t *n;
+	const char *id, *value;
+	struct tplg_tuple_set *set;
+	unsigned int type, num_tuples = 0;
+	struct tplg_tuple *tuple;
+	unsigned long int tuple_val;
+	int len;
+
+	snd_config_get_id(cfg, &id);
+
+	if (strcmp(id, "uuid") == 0)
+		type = SND_SOC_TPLG_TUPLE_TYPE_UUID;
+	else if (strcmp(id, "string") == 0)
+		type = SND_SOC_TPLG_TUPLE_TYPE_STRING;
+	else if (strcmp(id, "bool") == 0)
+		type = SND_SOC_TPLG_TUPLE_TYPE_BOOL;
+	else if (strcmp(id, "byte") == 0)
+		type = SND_SOC_TPLG_TUPLE_TYPE_BYTE;
+	else if (strcmp(id, "short") == 0)
+		type = SND_SOC_TPLG_TUPLE_TYPE_SHORT;
+	else if (strcmp(id, "word") == 0)
+		type = SND_SOC_TPLG_TUPLE_TYPE_WORD;
+	else {
+		SNDERR("error: invalid tuple type '%s'\n", id);
+		return -EINVAL;
+	}
+
+	snd_config_for_each(i, next, cfg)
+		num_tuples++;
+	if (!num_tuples)
+		return 0;
+
+	tplg_dbg("\t %d %s tuples:\n", num_tuples, id);
+	set = calloc(1, sizeof(*set) + num_tuples * sizeof(struct tplg_tuple));
+	if (!set)
+		return -ENOMEM;
+
+	set->type = type;
+
+	snd_config_for_each(i, next, cfg) {
+
+		n = snd_config_iterator_entry(i);
+
+		/* get id */
+		if (snd_config_get_id(n, &id) < 0)
+			continue;
+
+		/* get value */
+		if (snd_config_get_string(n, &value) < 0)
+			continue;
+
+		tuple = &set->tuple[set->num_tuples];
+		elem_copy_text(tuple->token, id,
+				SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
+
+		switch (type) {
+		case SND_SOC_TPLG_TUPLE_TYPE_UUID:
+			len = strlen(value);
+			if (len > 16 || len == 0) {
+				SNDERR("error: tuple %s: invalid uuid\n", id);
+				goto err;
+			}
+
+			memcpy(tuple->uuid, value, len);
+			tplg_dbg("\t\t%s = %s\n", tuple->token, tuple->uuid);
+			break;
+
+		case SND_SOC_TPLG_TUPLE_TYPE_STRING:
+			elem_copy_text(tuple->string, value,
+				SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
+			tplg_dbg("\t\t%s = %s\n", tuple->token, tuple->string);
+			break;
+
+		case SND_SOC_TPLG_TUPLE_TYPE_BOOL:
+			if (strcmp(value, "true") == 0)
+				tuple->value = 1;
+			tplg_dbg("\t\t%s = %d\n", tuple->token, tuple->value);
+			break;
+
+		case SND_SOC_TPLG_TUPLE_TYPE_BYTE:
+		case SND_SOC_TPLG_TUPLE_TYPE_SHORT:
+		case SND_SOC_TPLG_TUPLE_TYPE_WORD:
+			errno = 0;
+			/* no support for negative value */
+			tuple_val = strtoul(value, NULL, 0);
+			if ((errno == ERANGE && tuple_val == ULONG_MAX)
+				|| (errno != 0 && tuple_val == 0)) {
+				SNDERR("error: tuple %s:strtoul fail\n", id);
+				goto err;
+			}
+
+			if ((type == SND_SOC_TPLG_TUPLE_TYPE_WORD
+					&& tuple_val > UINT_MAX)
+				|| (type == SND_SOC_TPLG_TUPLE_TYPE_SHORT
+					&& tuple_val > USHRT_MAX)
+				|| (type == SND_SOC_TPLG_TUPLE_TYPE_BYTE
+					&& tuple_val > UCHAR_MAX)) {
+				SNDERR("error: tuple %s: invalid value\n", id);
+				goto err;
+			}
+
+			tuple->value = (unsigned int) tuple_val;
+			tplg_dbg("\t\t%s = 0x%x\n", tuple->token, tuple->value);
+			break;
+
+		default:
+			break;
+		}
+
+		set->num_tuples++;
+	}
+
+	*s = set;
+	return 0;
+
+err:
+	free(set);
+	return -EINVAL;
+}
+
+static int parse_tuple_sets(snd_tplg_t *tplg, snd_config_t *cfg,
+	struct tplg_vendor_tuples *tuples)
+{
+	snd_config_iterator_t i, next;
+	snd_config_t *n;
+	const char *id;
+	unsigned int num_tuple_sets = 0;
+	int err;
+
+	if (snd_config_get_type(cfg) != SND_CONFIG_TYPE_COMPOUND) {
+		SNDERR("error: compound type expected for %s", id);
+		return -EINVAL;
+	}
+
+	snd_config_for_each(i, next, cfg) {
+		num_tuple_sets++;
+	}
+
+	if (!num_tuple_sets)
+		return 0;
+
+	tuples->set = calloc(1, num_tuple_sets * sizeof(void *));
+	if (!tuples->set)
+		return -ENOMEM;
+
+	snd_config_for_each(i, next, cfg) {
+		n = snd_config_iterator_entry(i);
+		if (snd_config_get_type(n) != SND_CONFIG_TYPE_COMPOUND) {
+			SNDERR("error: compound type expected for %s, is %d",
+			id, snd_config_get_type(n));
+			return -EINVAL;
+		}
+
+		err = parse_tuple_set(tplg, n, &tuples->set[tuples->num_sets]);
+		if (err < 0)
+			return err;
+
+		/* overlook empty tuple sets */
+		if (tuples->set[tuples->num_sets])
+			tuples->num_sets++;
+	}
+
+	return 0;
+}
+
 /* Parse vendor tokens
  */
 int tplg_parse_tokens(snd_tplg_t *tplg, snd_config_t *cfg,
@@ -304,10 +473,71 @@ int tplg_parse_tokens(snd_tplg_t *tplg, snd_config_t *cfg,
 	return 0;
 }
 
+/* Parse vendor tuples.
+ */
+int tplg_parse_tuples(snd_tplg_t *tplg, snd_config_t *cfg,
+	void *private ATTRIBUTE_UNUSED)
+{
+	snd_config_iterator_t i, next;
+	snd_config_t *n;
+	const char *id, *value;
+	struct tplg_elem *elem;
+	struct tplg_vendor_tuples *tuples;
+	int err;
+
+	elem = tplg_elem_new_common(tplg, cfg, NULL, SND_TPLG_TYPE_TUPLE);
+	if (!elem)
+		return -ENOMEM;
+
+	tplg_dbg(" Vendor Tuples: %s\n", elem->id);
+
+	tuples = calloc(1, sizeof(*tuples));
+	if (!tuples)
+		return -ENOMEM;
+	elem->tuples = tuples;
+
+	snd_config_for_each(i, next, cfg) {
+
+		n = snd_config_iterator_entry(i);
+		if (snd_config_get_id(n, &id) < 0)
+			continue;
+
+		if (strcmp(id, "tokens") == 0) {
+			if (snd_config_get_string(n, &value) < 0)
+				return -EINVAL;
+			tplg_ref_add(elem, SND_TPLG_TYPE_TOKEN, value);
+			tplg_dbg("\t refer to vendor tokens: %s\n", value);
+		}
+
+		if (strcmp(id, "tuples") == 0) {
+			err = parse_tuple_sets(tplg, n, tuples);
+			if (err < 0)
+				return err;
+		}
+	}
+
+	return 0;
+}
+
+/* Free handler of tuples */
+void tplg_free_tuples(void *obj)
+{
+	struct tplg_vendor_tuples *tuples = (struct tplg_vendor_tuples *)obj;
+	int i;
+
+	if (!tuples || !tuples->set)
+		return;
+
+	for (i = 0; i < tuples->num_sets; i++)
+		free(tuples->set[i]);
+
+	free(tuples->set);
+}
+
 /* Parse Private data.
  *
  * Object private data can either be from file or defined as bytes, shorts,
- * words.
+ * words, tuples.
  */
 int tplg_parse_data(snd_tplg_t *tplg, snd_config_t *cfg,
 	void *private ATTRIBUTE_UNUSED)
@@ -365,6 +595,14 @@ int tplg_parse_data(snd_tplg_t *tplg, snd_config_t *cfg,
 			continue;
 		}
 
+		if (strcmp(id, "tuples") == 0) {
+			if (snd_config_get_string(n, &val) < 0)
+				return -EINVAL;
+			tplg_dbg(" Data: %s\n", val);
+			tplg_ref_add(elem, SND_TPLG_TYPE_TUPLE, val);
+			continue;
+		}
+
 		if (strcmp(id, "index") == 0) {
 			if (snd_config_get_string(n, &val) < 0)
 				return -EINVAL;
diff --git a/src/topology/elem.c b/src/topology/elem.c
index 95e3fd4..50414f0 100644
--- a/src/topology/elem.c
+++ b/src/topology/elem.c
@@ -196,6 +196,10 @@ struct tplg_elem* tplg_elem_new_common(snd_tplg_t *tplg,
 	case SND_TPLG_TYPE_TOKEN:
 		list_add_tail(&elem->list, &tplg->token_list);
 		break;
+	case SND_TPLG_TYPE_TUPLE:
+		list_add_tail(&elem->list, &tplg->tuple_list);
+		elem->free = tplg_free_tuples;
+		break;
 	default:
 		free(elem);
 		return NULL;
diff --git a/src/topology/parser.c b/src/topology/parser.c
index 264abc8..0d967b4 100644
--- a/src/topology/parser.c
+++ b/src/topology/parser.c
@@ -181,6 +181,14 @@ static int tplg_parse_config(snd_tplg_t *tplg, snd_config_t *cfg)
 			continue;
 		}
 
+		if (strcmp(id, "SectionVendorTuples") == 0) {
+			err = tplg_parse_compound(tplg, n, tplg_parse_tuples,
+				NULL);
+			if (err < 0)
+				return err;
+			continue;
+		}
+
 		SNDERR("error: unknown section %s\n", id);
 	}
 	return 0;
@@ -416,6 +424,7 @@ snd_tplg_t *snd_tplg_new(void)
 	INIT_LIST_HEAD(&tplg->enum_list);
 	INIT_LIST_HEAD(&tplg->bytes_ext_list);
 	INIT_LIST_HEAD(&tplg->token_list);
+	INIT_LIST_HEAD(&tplg->tuple_list);
 
 	return tplg;
 }
@@ -436,6 +445,7 @@ void snd_tplg_free(snd_tplg_t *tplg)
 	tplg_elem_free_list(&tplg->enum_list);
 	tplg_elem_free_list(&tplg->bytes_ext_list);
 	tplg_elem_free_list(&tplg->token_list);
+	tplg_elem_free_list(&tplg->tuple_list);
 
 	free(tplg);
 }
diff --git a/src/topology/tplg_local.h b/src/topology/tplg_local.h
index 679bfff..4d59a1f 100644
--- a/src/topology/tplg_local.h
+++ b/src/topology/tplg_local.h
@@ -70,6 +70,7 @@ struct snd_tplg {
 	struct list_head text_list;
 	struct list_head pdata_list;
 	struct list_head token_list;
+	struct list_head tuple_list;
 	struct list_head pcm_config_list;
 	struct list_head pcm_caps_list;
 
@@ -97,6 +98,28 @@ struct tplg_vendor_tokens {
 	unsigned int num_tokens;
 	struct tplg_token token[0];
 };
+
+/* element for vendor tuples */
+struct tplg_tuple {
+	char token[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
+	union {
+		char string[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
+		char uuid[16];
+		unsigned int value;
+	};
+};
+
+struct tplg_tuple_set {
+	unsigned int  type; /* uuid, bool, byte, short, word, string*/
+	unsigned int  num_tuples;
+	struct tplg_tuple tuple[0];
+};
+
+struct tplg_vendor_tuples {
+	unsigned int  num_sets;
+	struct tplg_tuple_set **set;
+};
+
 /* topology element */
 struct tplg_elem {
 
@@ -130,6 +153,7 @@ struct tplg_elem {
 		struct snd_soc_tplg_ctl_tlv *tlv;
 		struct snd_soc_tplg_private *data;
 		struct tplg_vendor_tokens *tokens;
+		struct tplg_vendor_tuples *tuples;
 	};
 
 	/* an element may refer to other elements:
@@ -166,6 +190,11 @@ int tplg_parse_data(snd_tplg_t *tplg, snd_config_t *cfg,
 int tplg_parse_tokens(snd_tplg_t *tplg, snd_config_t *cfg,
 	void *private ATTRIBUTE_UNUSED);
 
+int tplg_parse_tuples(snd_tplg_t *tplg, snd_config_t *cfg,
+	void *private ATTRIBUTE_UNUSED);
+
+void tplg_free_tuples(void *obj);
+
 int tplg_parse_control_bytes(snd_tplg_t *tplg,
 	snd_config_t *cfg, void *private ATTRIBUTE_UNUSED);
 
-- 
2.5.0
