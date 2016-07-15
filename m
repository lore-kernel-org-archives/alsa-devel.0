From: mengdong.lin@linux.intel.com
Subject: [PATCH v2 2/5] topology: Merge lookup for data
	reference into tplg_copy_data()
Date: Fri, 15 Jul 2016 20:18:11 +0800
Message-ID: <c6dc081280f9a97d74d8ad94d15b898212e1d529.1468583255.git.mengdong.lin@linux.intel.com>
References: <cover.1468583255.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A9CC266A80
 for <alsa-devel@alsa-project.org>; Fri, 15 Jul 2016 14:13:13 +0200 (CEST)
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

Code refactor to reduce function calls. Now tplg_copy_data() can look up
a referenced data element and merge its data.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/src/topology/ctl.c b/src/topology/ctl.c
index 7ded0a4..592dded 100644
--- a/src/topology/ctl.c
+++ b/src/topology/ctl.c
@@ -140,9 +140,9 @@ static int tplg_build_mixer_control(snd_tplg_t *tplg,
 				 err = copy_tlv(elem, ref->elem);
 
 		} else if (ref->type == SND_TPLG_TYPE_DATA) {
-			ref->elem = tplg_elem_lookup(&tplg->pdata_list,
-						ref->id, SND_TPLG_TYPE_DATA);
-			 err = tplg_copy_data(elem, ref->elem);
+			err = tplg_copy_data(tplg, elem, ref);
+			if (err < 0)
+				return err;
 		}
 
 		if (!ref->elem) {
@@ -188,9 +188,9 @@ static int tplg_build_enum_control(snd_tplg_t *tplg,
 				copy_enum_texts(elem, ref->elem);
 
 		} else if (ref->type == SND_TPLG_TYPE_DATA) {
-			ref->elem = tplg_elem_lookup(&tplg->pdata_list,
-						ref->id, SND_TPLG_TYPE_DATA);
-			err = tplg_copy_data(elem, ref->elem);
+			err = tplg_copy_data(tplg, elem, ref);
+			if (err < 0)
+				return err;
 		}
 		if (!ref->elem) {
 			SNDERR("error: cannot find '%s' referenced by"
@@ -208,6 +208,7 @@ static int tplg_build_bytes_control(snd_tplg_t *tplg, struct tplg_elem *elem)
 {
 	struct tplg_ref *ref;
 	struct list_head *base, *pos;
+	int err;
 
 	base = &elem->ref_list;
 
@@ -217,18 +218,11 @@ static int tplg_build_bytes_control(snd_tplg_t *tplg, struct tplg_elem *elem)
 		if (ref->id == NULL || ref->elem)
 			continue;
 
-		/* bytes control only reference one private data section */
-		ref->elem = tplg_elem_lookup(&tplg->pdata_list,
-			ref->id, SND_TPLG_TYPE_DATA);
-		if (!ref->elem) {
-			SNDERR("error: cannot find data '%s'"
-				" referenced by control '%s'\n",
-				ref->id, elem->id);
-			return -EINVAL;
+		 if (ref->type == SND_TPLG_TYPE_DATA) {
+			err = tplg_copy_data(tplg, elem, ref);
+			if (err < 0)
+				return err;
 		}
-
-		/* copy texts to enum elem */
-		return tplg_copy_data(elem, ref->elem);
 	}
 
 	return 0;
diff --git a/src/topology/dapm.c b/src/topology/dapm.c
index d8eb10c..4d343b2 100644
--- a/src/topology/dapm.c
+++ b/src/topology/dapm.c
@@ -191,12 +191,11 @@ static int tplg_build_widget(snd_tplg_t *tplg,
 			break;
 
 		case SND_TPLG_TYPE_DATA:
-			if (!ref->elem)
-				ref->elem = tplg_elem_lookup(&tplg->pdata_list,
-						ref->id, SND_TPLG_TYPE_DATA);
-			if (ref->elem)
-				err = tplg_copy_data(elem, ref->elem);
+			err = tplg_copy_data(tplg, elem, ref);
+			if (err < 0)
+				return err;
 			break;
+
 		default:
 			break;
 		}
diff --git a/src/topology/data.c b/src/topology/data.c
index 0c5469a..e60114e 100644
--- a/src/topology/data.c
+++ b/src/topology/data.c
@@ -889,22 +889,30 @@ int tplg_parse_data(snd_tplg_t *tplg, snd_config_t *cfg,
 	return err;
 }
 
-/* Merge data from a referenced data element to the parent element's
- * private data buffer.
+/* Find a referenced data element and copy its data to the parent
+ * element's private data buffer.
  * An element can refer to multiple data sections. Data of these sections
  * will be merged in the their reference order.
  */
-int tplg_copy_data(struct tplg_elem *elem, struct tplg_elem *ref)
+int tplg_copy_data(snd_tplg_t *tplg, struct tplg_elem *elem,
+		   struct tplg_ref *ref)
 {
+	struct tplg_elem *ref_elem;
 	struct snd_soc_tplg_private *priv, *old_priv;
 	int priv_data_size, old_priv_data_size;
 	void *obj;
 
-	if (!ref)
+	ref_elem = tplg_elem_lookup(&tplg->pdata_list,
+				     ref->id, SND_TPLG_TYPE_DATA);
+	if (!ref_elem) {
+		SNDERR("error: cannot find data '%s' referenced by"
+		" element '%s'\n", ref->id, elem->id);
 		return -EINVAL;
+	}
 
 	tplg_dbg("Data '%s' used by '%s'\n", ref->id, elem->id);
-	if (!ref->data || !ref->data->size) /* overlook empty private data */
+	/* overlook empty private data */
+	if (!ref_elem->data || !ref_elem->data->size)
 		return 0;
 
 	old_priv = get_priv_data(elem);
@@ -912,7 +920,7 @@ int tplg_copy_data(struct tplg_elem *elem, struct tplg_elem *ref)
 		return -EINVAL;
 	old_priv_data_size = old_priv->size;
 
-	priv_data_size = ref->data->size;
+	priv_data_size = ref_elem->data->size;
 	obj = realloc(elem->obj,
 			elem->size + priv_data_size);
 	if (!obj)
@@ -926,9 +934,9 @@ int tplg_copy_data(struct tplg_elem *elem, struct tplg_elem *ref)
 	/* merge the new data block */
 	elem->size += priv_data_size;
 	priv->size = priv_data_size + old_priv_data_size;
-	ref->compound_elem = 1;
+	ref_elem->compound_elem = 1;
 	memcpy(priv->data + old_priv_data_size,
-	       ref->data->data, priv_data_size);
+	       ref_elem->data->data, priv_data_size);
 	return 0;
 }
 
diff --git a/src/topology/tplg_local.h b/src/topology/tplg_local.h
index 4daa540..518b81e 100644
--- a/src/topology/tplg_local.h
+++ b/src/topology/tplg_local.h
@@ -228,7 +228,9 @@ int tplg_build_widgets(snd_tplg_t *tplg);
 int tplg_build_routes(snd_tplg_t *tplg);
 int tplg_build_pcm_dai(snd_tplg_t *tplg, unsigned int type);
 
-int tplg_copy_data(struct tplg_elem *elem, struct tplg_elem *ref);
+int tplg_copy_data(snd_tplg_t *tplg, struct tplg_elem *elem,
+		   struct tplg_ref *ref);
+
 int tplg_parse_data_refs(snd_config_t *cfg, struct tplg_elem *elem);
 
 int tplg_ref_add(struct tplg_elem *elem, int type, const char* id);
-- 
2.5.0
