From: mengdong.lin@linux.intel.com
Subject: [PATCH v2 1/5] topology: An element can refer to
	multipe data sections in text conf file
Date: Fri, 15 Jul 2016 20:17:43 +0800
Message-ID: <08b6ea8dd92cc6b1376f51253c2efb4de8098bcd.1468583255.git.mengdong.lin@linux.intel.com>
References: <cover.1468583255.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id C95A1266A7D
 for <alsa-devel@alsa-project.org>; Fri, 15 Jul 2016 14:12:45 +0200 (CEST)
In-Reply-To: <cover.1468583255.git.mengdong.lin@linux.intel.com>
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, mengdong.lin@intel.com, o-takashi@sakamocchi.jp, liam.r.girdwood@intel.com, shreyas.nc@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

Previously in text conf file, an element can only refer to one data
section (SectionData). Now it can also refer to a list of data sections.
Thus users can split groups of firmware parameters to multiple data
sections, and put them all in the reference list.

Finally, data of these data sections will be merged, in the same order as
they are in the reference list, as the element's private data for kernel.

We still support the original syntax of reference to a single data
section. The doc is updated for the syntax extension.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/topology.h b/include/topology.h
index 9d57ce3..d666505 100644
--- a/include/topology.h
+++ b/include/topology.h
@@ -213,6 +213,34 @@ extern "C" {
  * The keyword tuples is to define vendor specific tuples. Please refer to
  * section Vendor Tokens and Vendor tuples.
  *
+ * <h5>How to define an element with private data</h5>
+ * An element can refer to a single data section or multiple data
+ * sections.
+ *
+ * <h6>To refer to a single data section:</h6>
+ * <pre>
+ * Sectionxxx."element name" {
+ *    ...
+ *	data "name of data section"		# optional private data
+ * }
+ * </pre>
+ *
+ * <h6>To refer to multiple data sections:</h6>
+ * <pre>
+ * Sectionxxx."element name" {
+ *	...
+ *	data [						# optional private data
+ *		"name of 1st data section"
+ *		"name of 2nd data section"
+ *		...
+ *	]
+ * }
+ * </pre>
+ * And data of these sections will be merged in the same order as they are
+ * in the list, as the element's private data for kernel.
+ *
+ * </pre>
+ *
  *  <h6>Vendor Tokens</h6>
  * A vendor token list is defined as a new section. Each token element is
  * a pair of string ID and integer value. And both the ID and value are
diff --git a/src/topology/ctl.c b/src/topology/ctl.c
index b948ac0..7ded0a4 100644
--- a/src/topology/ctl.c
+++ b/src/topology/ctl.c
@@ -447,11 +447,9 @@ int tplg_parse_control_bytes(snd_tplg_t *tplg,
 		}
 
 		if (strcmp(id, "data") == 0) {
-			if (snd_config_get_string(n, &val) < 0)
-				return -EINVAL;
-
-			tplg_ref_add(elem, SND_TPLG_TYPE_DATA, val);
-			tplg_dbg("\t%s: %s\n", id, val);
+			err = tplg_parse_data_refs(n, elem);
+			if (err < 0)
+				return err;
 			continue;
 		}
 
@@ -587,11 +585,9 @@ int tplg_parse_control_enum(snd_tplg_t *tplg, snd_config_t *cfg,
 		}
 
 		if (strcmp(id, "data") == 0) {
-			if (snd_config_get_string(n, &val) < 0)
-				return -EINVAL;
-
-			tplg_ref_add(elem, SND_TPLG_TYPE_DATA, val);
-			tplg_dbg("\t%s: %s\n", id, val);
+			err = tplg_parse_data_refs(n, elem);
+			if (err < 0)
+				return err;
 			continue;
 		}
 
@@ -725,11 +721,9 @@ int tplg_parse_control_mixer(snd_tplg_t *tplg,
 		}
 
 		if (strcmp(id, "data") == 0) {
-			if (snd_config_get_string(n, &val) < 0)
-				return -EINVAL;
-
-			tplg_ref_add(elem, SND_TPLG_TYPE_DATA, val);
-			tplg_dbg("\t%s: %s\n", id, val);
+			err = tplg_parse_data_refs(n, elem);
+			if (err < 0)
+				return err;
 			continue;
 		}
 
diff --git a/src/topology/dapm.c b/src/topology/dapm.c
index 278d605..d8eb10c 100644
--- a/src/topology/dapm.c
+++ b/src/topology/dapm.c
@@ -598,11 +598,9 @@ int tplg_parse_dapm_widget(snd_tplg_t *tplg,
 		}
 
 		if (strcmp(id, "data") == 0) {
-			if (snd_config_get_string(n, &val) < 0)
-				return -EINVAL;
-
-			tplg_ref_add(elem, SND_TPLG_TYPE_DATA, val);
-			tplg_dbg("\t%s: %s\n", id, val);
+			err = tplg_parse_data_refs(n, elem);
+			if (err < 0)
+				return err;
 			continue;
 		}
 	}
diff --git a/src/topology/data.c b/src/topology/data.c
index c0a098c..0c5469a 100644
--- a/src/topology/data.c
+++ b/src/topology/data.c
@@ -20,6 +20,36 @@
 #include "tplg_local.h"
 #include <ctype.h>
 
+/* Get private data buffer of an element */
+struct snd_soc_tplg_private *get_priv_data(struct tplg_elem *elem)
+{
+	struct snd_soc_tplg_private *priv = NULL;
+
+	switch (elem->type) {
+	case SND_TPLG_TYPE_MIXER:
+		priv = &elem->mixer_ctrl->priv;
+		break;
+
+	case SND_TPLG_TYPE_ENUM:
+		priv = &elem->enum_ctrl->priv;
+		break;
+
+	case SND_TPLG_TYPE_BYTES:
+		priv = &elem->bytes_ext->priv;
+		break;
+
+	case SND_TPLG_TYPE_DAPM_WIDGET:
+		priv = &elem->widget->priv;
+		break;
+
+	default:
+		SNDERR("error: '%s': no support for private data for type %d\n",
+			elem->id, elem->type);
+	}
+
+	return priv;
+}
+
 /* Get Private data from a file. */
 static int tplg_parse_data_file(snd_config_t *cfg, struct tplg_elem *elem)
 {
@@ -614,6 +644,48 @@ static int parse_tuple_sets(snd_tplg_t *tplg, snd_config_t *cfg,
 	return 0;
 }
 
+/* Parse private data references for the element, either a single data section
+ * or a list of data sections.
+ */
+int tplg_parse_data_refs(snd_config_t *cfg,
+	struct tplg_elem *elem)
+{
+	snd_config_type_t  type;
+	snd_config_iterator_t i, next;
+	snd_config_t *n;
+	const char *val = NULL;
+
+	type = snd_config_get_type(cfg);
+
+	/* refer to a single data section */
+	if (type == SND_CONFIG_TYPE_STRING) {
+		if (snd_config_get_string(cfg, &val) < 0)
+			return -EINVAL;
+
+		tplg_dbg("\tdata: %s\n", val);
+		return tplg_ref_add(elem, SND_TPLG_TYPE_DATA, val);
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
+		tplg_dbg("\tdata: %s\n", val);
+		tplg_ref_add(elem, SND_TPLG_TYPE_DATA, val);
+	}
+
+	return 0;
+}
+
 /* Parse vendor tokens
  */
 int tplg_parse_tokens(snd_tplg_t *tplg, snd_config_t *cfg,
@@ -817,11 +889,15 @@ int tplg_parse_data(snd_tplg_t *tplg, snd_config_t *cfg,
 	return err;
 }
 
-/* copy private data into the bytes extended control */
+/* Merge data from a referenced data element to the parent element's
+ * private data buffer.
+ * An element can refer to multiple data sections. Data of these sections
+ * will be merged in the their reference order.
+ */
 int tplg_copy_data(struct tplg_elem *elem, struct tplg_elem *ref)
 {
-	struct snd_soc_tplg_private *priv;
-	int priv_data_size;
+	struct snd_soc_tplg_private *priv, *old_priv;
+	int priv_data_size, old_priv_data_size;
 	void *obj;
 
 	if (!ref)
@@ -831,6 +907,11 @@ int tplg_copy_data(struct tplg_elem *elem, struct tplg_elem *ref)
 	if (!ref->data || !ref->data->size) /* overlook empty private data */
 		return 0;
 
+	old_priv = get_priv_data(elem);
+	if (!old_priv)
+		return -EINVAL;
+	old_priv_data_size = old_priv->size;
+
 	priv_data_size = ref->data->size;
 	obj = realloc(elem->obj,
 			elem->size + priv_data_size);
@@ -838,33 +919,16 @@ int tplg_copy_data(struct tplg_elem *elem, struct tplg_elem *ref)
 		return -ENOMEM;
 	elem->obj = obj;
 
-	switch (elem->type) {
-	case SND_TPLG_TYPE_MIXER:
-		priv = &elem->mixer_ctrl->priv;
-		break;
-
-	case SND_TPLG_TYPE_ENUM:
-		priv = &elem->enum_ctrl->priv;
-		break;
-
-	case SND_TPLG_TYPE_BYTES:
-		priv = &elem->bytes_ext->priv;
-		break;
-
-	case SND_TPLG_TYPE_DAPM_WIDGET:
-		priv = &elem->widget->priv;
-		break;
-
-	default:
-		SNDERR("error: elem '%s': type %d private data not supported \n",
-			elem->id, elem->type);
+	priv = get_priv_data(elem);
+	if (!priv)
 		return -EINVAL;
-	}
 
+	/* merge the new data block */
 	elem->size += priv_data_size;
-	priv->size = priv_data_size;
+	priv->size = priv_data_size + old_priv_data_size;
 	ref->compound_elem = 1;
-	memcpy(priv->data, ref->data->data, priv_data_size);
+	memcpy(priv->data + old_priv_data_size,
+	       ref->data->data, priv_data_size);
 	return 0;
 }
 
diff --git a/src/topology/tplg_local.h b/src/topology/tplg_local.h
index 9239aef..4daa540 100644
--- a/src/topology/tplg_local.h
+++ b/src/topology/tplg_local.h
@@ -229,6 +229,7 @@ int tplg_build_routes(snd_tplg_t *tplg);
 int tplg_build_pcm_dai(snd_tplg_t *tplg, unsigned int type);
 
 int tplg_copy_data(struct tplg_elem *elem, struct tplg_elem *ref);
+int tplg_parse_data_refs(snd_config_t *cfg, struct tplg_elem *elem);
 
 int tplg_ref_add(struct tplg_elem *elem, int type, const char* id);
 int tplg_ref_add_elem(struct tplg_elem *elem, struct tplg_elem *elem_ref);
-- 
2.5.0
