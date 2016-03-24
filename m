From: mengdong.lin@linux.intel.com
Subject: [PATCH 7/7] topology: Build data objects with tuples
Date: Thu, 24 Mar 2016 11:07:45 +0800
Message-ID: <aa0044f1f25549fa319bfab4acaa5bb36d5abe1f.1458788076.git.mengdong.lin@linux.intel.com>
References: <cover.1458788076.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 19C44265D57
 for <alsa-devel@alsa-project.org>; Thu, 24 Mar 2016 04:05:47 +0100 (CET)
In-Reply-To: <cover.1458788076.git.mengdong.lin@linux.intel.com>
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

For data objects with tuples, the parser will bind the vendor tuples
and tokens, copy the tuples to the private buffer of its parent data
object. Then later the builder will export the vendor tuples as private
binary data for the control or widgets objects.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/src/topology/data.c b/src/topology/data.c
index 0d07842..589d48d 100644
--- a/src/topology/data.c
+++ b/src/topology/data.c
@@ -253,6 +253,198 @@ static int tplg_parse_data_hex(snd_config_t *cfg, struct tplg_elem *elem,
 	return ret;
 }
 
+/* get the token integer value from its id */
+static int get_token_value(const char *token_id,
+	struct tplg_vendor_tokens *tokens)
+{
+	int i;
+
+	for (i = 0; i < tokens->num_tokens; i++) {
+		if (strcmp(token_id, tokens->token[i].id) == 0)
+			return tokens->token[i].value;
+	}
+
+	SNDERR("error: cannot find token id '%s'\n", token_id);
+	return -1;
+}
+
+/* get the vendor tokens referred by the vendor tuples */
+static struct tplg_elem *get_tokens(snd_tplg_t *tplg, struct tplg_elem *elem)
+{
+	struct tplg_ref *ref;
+	struct list_head *base, *pos;
+	int err = 0;
+
+	base = &elem->ref_list;
+	list_for_each(pos, base) {
+
+		ref = list_entry(pos, struct tplg_ref, list);
+
+		if (!ref->id || ref->type != SND_TPLG_TYPE_TOKEN)
+			continue;
+
+		if (!ref->elem) {
+			ref->elem = tplg_elem_lookup(&tplg->token_list,
+						ref->id, SND_TPLG_TYPE_TOKEN);
+		}
+
+		return ref->elem;
+	}
+
+	return NULL;
+}
+
+/* check if a data element has tuples */
+static bool has_tuples(struct tplg_elem *elem)
+{
+	struct tplg_ref *ref;
+	struct list_head *base, *pos;
+	int err = 0;
+
+	base = &elem->ref_list;
+	list_for_each(pos, base) {
+
+		ref = list_entry(pos, struct tplg_ref, list);
+		if (ref->id && ref->type == SND_TPLG_TYPE_TUPLE)
+			return true;
+	}
+
+	return false;
+}
+
+/* get size of a tuple element from its type */
+static unsigned int get_tuple_size(int type)
+{
+	switch (type) {
+
+	case SND_SOC_TPLG_TUPLE_TYPE_UUID:
+		return sizeof(struct snd_soc_tplg_vendor_uuid_elem);
+
+	case SND_SOC_TPLG_TUPLE_TYPE_STRING:
+		return sizeof(struct snd_soc_tplg_vendor_string_elem);
+
+	default:
+		return sizeof(struct snd_soc_tplg_vendor_value_elem);
+	}
+}
+
+/* fill a data element's private buffer with its tuples */
+static int copy_tuples(struct tplg_elem *elem,
+	struct tplg_vendor_tuples *tuples, struct tplg_vendor_tokens *tokens)
+{
+	struct snd_soc_tplg_private *priv = elem->data;
+	struct tplg_tuple_set *tuple_set;
+	struct tplg_tuple *tuple;
+	struct snd_soc_tplg_vendor_array *array;
+	struct snd_soc_tplg_vendor_uuid_elem *uuid;
+	struct snd_soc_tplg_vendor_string_elem *string;
+	struct snd_soc_tplg_vendor_value_elem *value;
+	int set_size, size, off;
+	int i, j, token_val;
+
+	if (priv) {
+		SNDERR("error: %s has more data than tuples\n", elem->id);
+		return -EINVAL;
+	}
+
+	size = 0;
+	for (i = 0; i < tuples->num_sets ; i++) {
+		tuple_set = tuples->set[i];
+		set_size = sizeof(struct snd_soc_tplg_vendor_array)
+			+ get_tuple_size(tuple_set->type)
+			* tuple_set->num_tuples;
+		size += set_size;
+		if (size > TPLG_MAX_PRIV_SIZE) {
+			SNDERR("error: data too big %d\n", size);
+			return -EINVAL;
+		}
+
+		if (priv != NULL)
+			priv = realloc(priv, sizeof(*priv) + size);
+		else
+			priv = calloc(1, sizeof(*priv) + size);
+		if (!priv)
+			return -ENOMEM;
+
+		off = priv->size;
+		priv->size = size;
+
+		array = (struct snd_soc_tplg_vendor_array *)(priv->data + off);
+		array->size = set_size;
+		array->type = tuple_set->type;
+		array->num_elems = tuple_set->num_tuples;
+
+		/* fill the private data buffer */
+		for (j = 0; j < tuple_set->num_tuples; j++) {
+			tuple = &tuple_set->tuple[j];
+			token_val = get_token_value(tuple->token, tokens);
+			if (token_val  < 0)
+				return -EINVAL;
+
+			switch (tuple_set->type) {
+			case SND_SOC_TPLG_TUPLE_TYPE_UUID:
+				uuid = &array->uuid[j];
+				uuid->token = token_val;
+				memcpy(uuid->uuid, tuple->uuid, 16);
+				break;
+
+			case SND_SOC_TPLG_TUPLE_TYPE_STRING:
+				string = &array->string[j];
+				string->token = token_val;
+				elem_copy_text(string->string, tuple->string,
+					SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
+				break;
+
+			default:
+				value = &array->value[j];
+				value->token = token_val;
+				value->value = tuple->value;
+				break;
+			}
+		}
+	}
+
+	elem->data = priv;
+	return 0;
+}
+
+/* build a data element from its tuples */
+static int build_tuples(snd_tplg_t *tplg, struct tplg_elem *elem)
+{
+	struct tplg_ref *ref;
+	struct list_head *base, *pos;
+	struct tplg_elem *tuples, *tokens;
+
+	base = &elem->ref_list;
+	list_for_each(pos, base) {
+
+		ref = list_entry(pos, struct tplg_ref, list);
+
+		if (!ref->id || ref->type != SND_TPLG_TYPE_TUPLE)
+			continue;
+
+		tplg_dbg("look up tuples %s\n", ref->id);
+
+		if (!ref->elem)
+			ref->elem = tplg_elem_lookup(&tplg->tuple_list,
+						ref->id, SND_TPLG_TYPE_TUPLE);
+		tuples = ref->elem;
+		if (!tuples)
+			return -EINVAL;
+
+		tplg_dbg("found tuples %s\n", tuples->id);
+		tokens = get_tokens(tplg, tuples);
+		if (!tokens)
+			return -EINVAL;
+
+		tplg_dbg("found tokens %s\n", tokens->id);
+		/* a data object can only have one tuples object */
+		return copy_tuples(elem, tuples->tuples, tokens->tokens);
+	}
+
+	return 0;
+}
+
 static int parse_tuple_set(snd_tplg_t *tplg, snd_config_t *cfg,
 	struct tplg_tuple_set **s)
 {
@@ -650,3 +842,24 @@ int tplg_copy_data(struct tplg_elem *elem, struct tplg_elem *ref)
 	memcpy(priv->data, ref->data->data, priv_data_size);
 	return 0;
 }
+
+/* check data objects and build those with tuples */
+int tplg_build_data(snd_tplg_t *tplg)
+{
+	struct list_head *base, *pos;
+	struct tplg_elem *elem;
+	int err = 0;
+
+	base = &tplg->pdata_list;
+	list_for_each(pos, base) {
+
+		elem = list_entry(pos, struct tplg_elem, list);
+		if (has_tuples(elem)) {
+			err = build_tuples(tplg, elem);
+			if (err < 0)
+				return err;
+		}
+	}
+
+	return 0;
+}
diff --git a/src/topology/parser.c b/src/topology/parser.c
index 0d967b4..30d91f9 100644
--- a/src/topology/parser.c
+++ b/src/topology/parser.c
@@ -242,6 +242,10 @@ static int tplg_build_integ(snd_tplg_t *tplg)
 {
 	int err;
 
+	err = tplg_build_data(tplg);
+	if (err <  0)
+		return err;
+
 	err = tplg_build_controls(tplg);
 	if (err <  0)
 		return err;
diff --git a/src/topology/tplg_local.h b/src/topology/tplg_local.h
index 4d59a1f..4c601d4 100644
--- a/src/topology/tplg_local.h
+++ b/src/topology/tplg_local.h
@@ -222,6 +222,7 @@ int tplg_parse_be(snd_tplg_t *tplg,
 int tplg_parse_cc(snd_tplg_t *tplg,
 	snd_config_t *cfg, void *private ATTRIBUTE_UNUSED);
 
+int tplg_build_data(snd_tplg_t *tplg);
 int tplg_build_controls(snd_tplg_t *tplg);
 int tplg_build_widgets(snd_tplg_t *tplg);
 int tplg_build_routes(snd_tplg_t *tplg);
-- 
2.5.0
