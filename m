From: fuweix.tang@intel.com
Subject: [PATCH][resend] topology: Allow a data section to
	contain multiple tuples objects
Date: Thu, 27 Apr 2017 14:46:00 +0800
Message-ID: <1493275560-11535-1-git-send-email-fuweix.tang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 430D62668B2
 for <alsa-devel@alsa-project.org>; Thu, 27 Apr 2017 08:46:05 +0200 (CEST)
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, Mengdong Lin <mengdong.lin@linux.intel.com>, Fuwei Tang <fuweix.tang@intel.com>, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

It's easy to use a vendor tuples object to define a C structure instance as
vendor specific parameter for kernel drivers. And sometimes the kernel drivers
may want a group of structures. So this patch will allow user to define multiple
vendor tuples objects in a data section, to avoid defining multiple data
sections and each data section only has 1 vendor tuples object.

There is no ABI change in this patch.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>
Signed-off-by: Fuwei Tang <fuweix.tang@intel.com>
---
 include/topology.h  | 14 ++++++++++
 src/topology/data.c | 78 ++++++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 74 insertions(+), 18 deletions(-)

diff --git a/include/topology.h b/include/topology.h
index 1bebe1e..ccb3a00 100644
--- a/include/topology.h
+++ b/include/topology.h
@@ -214,6 +214,20 @@ extern "C" {
  * The keyword tuples is to define vendor specific tuples. Please refer to
  * section Vendor Tokens and Vendor tuples.
  *
+ * It's easy to use a vendor tuples object to define a C structure instance.
+ * And a data section can include multiple vendor tuples objects:
+ *
+ * <pre>
+ * SectionData."data element name" {
+ *	index "1"	#Index number
+ *	tuples [
+ *		"id of the 1st vendor tuples section"
+ *		"id of the 2nd vendor tuples section"
+ *		...
+ *	]
+ * };
+ * </pre>
+ *
  * <h5>How to define an element with private data</h5>
  * An element can refer to a single data section or multiple data
  * sections.
diff --git a/src/topology/data.c b/src/topology/data.c
index 00785ef..36060eb 100644
--- a/src/topology/data.c
+++ b/src/topology/data.c
@@ -408,7 +408,7 @@ static unsigned int get_tuple_size(int type)
 	}
 }
 
-/* fill a data element's private buffer with its tuples */
+/* Add a tuples object to the private buffer of its parent data element */
 static int copy_tuples(struct tplg_elem *elem,
 	struct tplg_vendor_tuples *tuples, struct tplg_vendor_tokens *tokens)
 {
@@ -423,12 +423,9 @@ static int copy_tuples(struct tplg_elem *elem,
 	unsigned int i, j;
 	int token_val;
 
-	if (priv) {
-		SNDERR("error: %s has more data than tuples\n", elem->id);
-		return -EINVAL;
-	}
+	size = priv ? priv->size : 0; /* original private data size */
 
-	size = 0;
+	/* scan each tuples set (one set per type) */
 	for (i = 0; i < tuples->num_sets ; i++) {
 		tuple_set = tuples->set[i];
 		set_size = sizeof(struct snd_soc_tplg_vendor_array)
@@ -448,7 +445,7 @@ static int copy_tuples(struct tplg_elem *elem,
 			return -ENOMEM;
 
 		off = priv->size;
-		priv->size = size;
+		priv->size = size; /* update private data size */
 
 		array = (struct snd_soc_tplg_vendor_array *)(priv->data + off);
 		array->size = set_size;
@@ -495,6 +492,7 @@ static int build_tuples(snd_tplg_t *tplg, struct tplg_elem *elem)
 	struct tplg_ref *ref;
 	struct list_head *base, *pos;
 	struct tplg_elem *tuples, *tokens;
+	int err;
 
 	base = &elem->ref_list;
 	list_for_each(pos, base) {
@@ -504,23 +502,27 @@ static int build_tuples(snd_tplg_t *tplg, struct tplg_elem *elem)
 		if (!ref->id || ref->type != SND_TPLG_TYPE_TUPLE)
 			continue;
 
-		tplg_dbg("look up tuples %s\n", ref->id);
+		tplg_dbg("tuples '%s' used by data '%s'\n", ref->id, elem->id);
 
 		if (!ref->elem)
 			ref->elem = tplg_elem_lookup(&tplg->tuple_list,
 				ref->id, SND_TPLG_TYPE_TUPLE, elem->index);
 		tuples = ref->elem;
-		if (!tuples)
+		if (!tuples) {
+			SNDERR("error: cannot find tuples %s\n", ref->id);
 			return -EINVAL;
+		}
 
-		tplg_dbg("found tuples %s\n", tuples->id);
 		tokens = get_tokens(tplg, tuples);
-		if (!tokens)
+		if (!tokens) {
+			SNDERR("error: cannot find token for %s\n", ref->id);
 			return -EINVAL;
+		}
 
-		tplg_dbg("found tokens %s\n", tokens->id);
-		/* a data object can only have one tuples object */
-		return copy_tuples(elem, tuples->tuples, tokens->tokens);
+		/* a data object can have multiple tuples objects */
+		err = copy_tuples(elem, tuples->tuples, tokens->tokens);
+		if (err < 0)
+			return err;
 	}
 
 	return 0;
@@ -689,6 +691,47 @@ static int parse_tuple_sets(snd_config_t *cfg,
 	return 0;
 }
 
+/* Parse tuples references for a data element, either a single tuples section
+ * or a list of tuples sections.
+ */
+static int parse_tuples_refs(snd_config_t *cfg,
+	struct tplg_elem *elem)
+{
+	snd_config_type_t  type;
+	snd_config_iterator_t i, next;
+	snd_config_t *n;
+	const char *val = NULL;
+
+	type = snd_config_get_type(cfg);
+
+	/* refer to a single tuples section */
+	if (type == SND_CONFIG_TYPE_STRING) {
+		if (snd_config_get_string(cfg, &val) < 0)
+			return -EINVAL;
+		tplg_dbg("\ttuples: %s\n", val);
+		return tplg_ref_add(elem, SND_TPLG_TYPE_TUPLE, val);
+	}
+
+	if (type != SND_CONFIG_TYPE_COMPOUND) {
+		SNDERR("error: compound type expected for %s", elem->id);
+		return -EINVAL;
+	}
+
+	/* refer to a list of data sections */
+	snd_config_for_each(i, next, cfg) {
+		const char *val;
+
+		n = snd_config_iterator_entry(i);
+		if (snd_config_get_string(n, &val) < 0)
+			continue;
+
+		tplg_dbg("\ttuples: %s\n", val);
+		tplg_ref_add(elem, SND_TPLG_TYPE_TUPLE, val);
+	}
+
+	return 0;
+}
+
 /* Parse private data references for the element, either a single data section
  * or a list of data sections.
  */
@@ -1002,10 +1045,9 @@ int tplg_parse_data(snd_tplg_t *tplg, snd_config_t *cfg,
 		}
 
 		if (strcmp(id, "tuples") == 0) {
-			if (snd_config_get_string(n, &val) < 0)
-				return -EINVAL;
-			tplg_dbg(" Data: %s\n", val);
-			tplg_ref_add(elem, SND_TPLG_TYPE_TUPLE, val);
+			err = parse_tuples_refs(n, elem);
+			if (err < 0)
+				return err;
 			continue;
 		}
 
-- 
2.7.4
