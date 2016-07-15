From: mengdong.lin@linux.intel.com
Subject: [PATCH v2 4/5] topology: Parse vendor private data for
	manifest
Date: Fri, 15 Jul 2016 20:19:41 +0800
Message-ID: <9b41b27a1318e80f6720decf3d490a8aac78c903.1468583255.git.mengdong.lin@linux.intel.com>
References: <cover.1468583255.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id C1729266A84
 for <alsa-devel@alsa-project.org>; Fri, 15 Jul 2016 14:14:43 +0200 (CEST)
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

In text conf file, user can define a manifest section and let it refer
to private data sections, in the same syntax as other element types.

The text conf file can have at most 1 manifest section.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/topology.h b/include/topology.h
index 89bed6c..644e548 100644
--- a/include/topology.h
+++ b/include/topology.h
@@ -586,6 +586,20 @@ extern "C" {
  * }
  * </pre>
  *
+ * <h4>Manifest Private Data</h4>
+ * Manfiest may have private data. Users need to define a manifest section
+ * and add the references to 1 or multiple data sections. Please refer to
+ * section 'How to define an element with private data'. <br>
+ * And the text conf file can have at most 1 manifest section. <br><br>
+ *
+ * Manifest section is defined as follows :-
+ *
+ * <pre>
+ * SectionManifest"name" {
+ *
+ *	data "name"			# optional private data
+ * }
+ * </pre>
  */
 
 /** Maximum number of channels supported in one control */
diff --git a/src/topology/data.c b/src/topology/data.c
index a0c5ea2..245a834 100644
--- a/src/topology/data.c
+++ b/src/topology/data.c
@@ -26,6 +26,10 @@ struct snd_soc_tplg_private *get_priv_data(struct tplg_elem *elem)
 	struct snd_soc_tplg_private *priv = NULL;
 
 	switch (elem->type) {
+	case SND_TPLG_TYPE_MANIFEST:
+		priv = &elem->manifest->priv;
+		break;
+
 	case SND_TPLG_TYPE_MIXER:
 		priv = &elem->mixer_ctrl->priv;
 		break;
@@ -834,6 +838,103 @@ void tplg_free_tuples(void *obj)
 	free(tuples->set);
 }
 
+/* Parse manifest's data references
+ */
+int tplg_parse_manifest_data(snd_tplg_t *tplg, snd_config_t *cfg,
+	void *private ATTRIBUTE_UNUSED)
+{
+	struct snd_soc_tplg_manifest *manifest;
+	struct tplg_elem *elem;
+	snd_config_iterator_t i, next;
+	snd_config_t *n;
+	const char *id;
+	int err;
+
+	if (!list_empty(&tplg->manifest_list)) {
+		SNDERR("error: already has manifest data\n");
+		return -EINVAL;
+	}
+
+	elem = tplg_elem_new_common(tplg, cfg, NULL, SND_TPLG_TYPE_MANIFEST);
+	if (!elem)
+		return -ENOMEM;
+
+	manifest = elem->manifest;
+	manifest->size = elem->size;
+
+	tplg_dbg(" Manifest: %s\n", elem->id);
+
+	snd_config_for_each(i, next, cfg) {
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
+
+		if (strcmp(id, "data") == 0) {
+			err = tplg_parse_data_refs(n, elem);
+			if (err < 0)
+				return err;
+			continue;
+		}
+	}
+
+	return 0;
+}
+
+/* merge private data of manifest */
+int tplg_build_manifest_data(snd_tplg_t *tplg)
+{
+	struct list_head *base, *pos;
+	struct tplg_elem *elem = NULL;
+	struct tplg_ref *ref;
+	struct snd_soc_tplg_manifest *manifest;
+	int err = 0;
+
+	base = &tplg->manifest_list;
+	list_for_each(pos, base) {
+
+		elem = list_entry(pos, struct tplg_elem, list);
+		break;
+	}
+
+	if (!elem) /* no manifest data */
+		return 0;
+
+	base = &elem->ref_list;
+
+	/* for each ref in this manifest elem */
+	list_for_each(pos, base) {
+
+		ref = list_entry(pos, struct tplg_ref, list);
+		if (ref->id == NULL || ref->elem)
+			continue;
+
+		if (ref->type == SND_TPLG_TYPE_DATA) {
+			err = tplg_copy_data(tplg, elem, ref);
+			if (err < 0)
+				return err;
+		}
+	}
+
+	manifest = elem->manifest;
+	if (!manifest->priv.size) /* no manifest data */
+		return 0;
+
+	tplg->manifest_pdata = malloc(manifest->priv.size);
+	if (!tplg->manifest_pdata)
+		return -ENOMEM;
+
+	tplg->manifest.priv.size = manifest->priv.size;
+	memcpy(tplg->manifest_pdata, manifest->priv.data, manifest->priv.size);
+	return 0;
+}
+
 /* Parse Private data.
  *
  * Object private data can either be from file or defined as bytes, shorts,
diff --git a/src/topology/elem.c b/src/topology/elem.c
index 50414f0..029c9ab 100644
--- a/src/topology/elem.c
+++ b/src/topology/elem.c
@@ -150,6 +150,10 @@ struct tplg_elem* tplg_elem_new_common(snd_tplg_t *tplg,
 	case SND_TPLG_TYPE_DATA:
 		list_add_tail(&elem->list, &tplg->pdata_list);
 		break;
+	case SND_TPLG_TYPE_MANIFEST:
+		list_add_tail(&elem->list, &tplg->manifest_list);
+		obj_size = sizeof(struct snd_soc_tplg_manifest);
+		break;
 	case SND_TPLG_TYPE_TEXT:
 		list_add_tail(&elem->list, &tplg->text_list);
 		break;
diff --git a/src/topology/parser.c b/src/topology/parser.c
index f6fc944..3ab64f4 100644
--- a/src/topology/parser.c
+++ b/src/topology/parser.c
@@ -189,6 +189,15 @@ static int tplg_parse_config(snd_tplg_t *tplg, snd_config_t *cfg)
 			continue;
 		}
 
+		if (strcmp(id, "SectionManifest") == 0) {
+			err = tplg_parse_compound(tplg, n,
+						  tplg_parse_manifest_data,
+				NULL);
+			if (err < 0)
+				return err;
+			continue;
+		}
+
 		SNDERR("error: unknown section %s\n", id);
 	}
 	return 0;
@@ -246,6 +255,10 @@ static int tplg_build_integ(snd_tplg_t *tplg)
 	if (err <  0)
 		return err;
 
+	err = tplg_build_manifest_data(tplg);
+	if (err <  0)
+		return err;
+
 	err = tplg_build_controls(tplg);
 	if (err <  0)
 		return err;
@@ -374,8 +387,16 @@ out:
 
 int snd_tplg_set_manifest_data(snd_tplg_t *tplg, const void *data, int len)
 {
+	if (len <= 0)
+		return 0;
+
 	tplg->manifest.priv.size = len;
-	tplg->manifest_pdata = data;
+
+	tplg->manifest_pdata = malloc(len);
+	if (!tplg->manifest_pdata)
+		return -ENOMEM;
+
+	memcpy(tplg->manifest_pdata, data, len);
 	return 0;
 }
 
@@ -423,6 +444,7 @@ snd_tplg_t *snd_tplg_new(void)
 	INIT_LIST_HEAD(&tplg->cc_list);
 	INIT_LIST_HEAD(&tplg->route_list);
 	INIT_LIST_HEAD(&tplg->pdata_list);
+	INIT_LIST_HEAD(&tplg->manifest_list);
 	INIT_LIST_HEAD(&tplg->text_list);
 	INIT_LIST_HEAD(&tplg->pcm_config_list);
 	INIT_LIST_HEAD(&tplg->pcm_caps_list);
@@ -437,6 +459,9 @@ snd_tplg_t *snd_tplg_new(void)
 
 void snd_tplg_free(snd_tplg_t *tplg)
 {
+	if (tplg->manifest_pdata)
+		free(tplg->manifest_pdata);
+
 	tplg_elem_free_list(&tplg->tlv_list);
 	tplg_elem_free_list(&tplg->widget_list);
 	tplg_elem_free_list(&tplg->pcm_list);
@@ -444,6 +469,7 @@ void snd_tplg_free(snd_tplg_t *tplg)
 	tplg_elem_free_list(&tplg->cc_list);
 	tplg_elem_free_list(&tplg->route_list);
 	tplg_elem_free_list(&tplg->pdata_list);
+	tplg_elem_free_list(&tplg->manifest_list);
 	tplg_elem_free_list(&tplg->text_list);
 	tplg_elem_free_list(&tplg->pcm_config_list);
 	tplg_elem_free_list(&tplg->pcm_caps_list);
diff --git a/src/topology/tplg_local.h b/src/topology/tplg_local.h
index 48db813..4d79aa7 100644
--- a/src/topology/tplg_local.h
+++ b/src/topology/tplg_local.h
@@ -58,7 +58,7 @@ struct snd_tplg {
 
 	/* manifest */
 	struct snd_soc_tplg_manifest manifest;
-	const void *manifest_pdata;	/* copied by builder at file write */
+	void *manifest_pdata;	/* copied by builder at file write */
 
 	/* list of each element type */
 	struct list_head tlv_list;
@@ -71,6 +71,7 @@ struct snd_tplg {
 	struct list_head pdata_list;
 	struct list_head token_list;
 	struct list_head tuple_list;
+	struct list_head manifest_list;
 	struct list_head pcm_config_list;
 	struct list_head pcm_caps_list;
 
@@ -154,6 +155,7 @@ struct tplg_elem {
 		struct snd_soc_tplg_private *data;
 		struct tplg_vendor_tokens *tokens;
 		struct tplg_vendor_tuples *tuples;
+		struct snd_soc_tplg_manifest *manifest;
 	};
 
 	/* an element may refer to other elements:
@@ -195,6 +197,9 @@ int tplg_parse_tuples(snd_tplg_t *tplg, snd_config_t *cfg,
 
 void tplg_free_tuples(void *obj);
 
+int tplg_parse_manifest_data(snd_tplg_t *tplg, snd_config_t *cfg,
+	void *private ATTRIBUTE_UNUSED);
+
 int tplg_parse_control_bytes(snd_tplg_t *tplg,
 	snd_config_t *cfg, void *private ATTRIBUTE_UNUSED);
 
@@ -223,6 +228,7 @@ int tplg_parse_cc(snd_tplg_t *tplg,
 	snd_config_t *cfg, void *private ATTRIBUTE_UNUSED);
 
 int tplg_build_data(snd_tplg_t *tplg);
+int tplg_build_manifest_data(snd_tplg_t *tplg);
 int tplg_build_controls(snd_tplg_t *tplg);
 int tplg_build_widgets(snd_tplg_t *tplg);
 int tplg_build_routes(snd_tplg_t *tplg);
-- 
2.5.0
