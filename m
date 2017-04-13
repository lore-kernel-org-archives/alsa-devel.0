From: fuweix.tang@intel.com
Subject: [PATCH 3/4] topology: Look up references for an object
	based on its index
Date: Thu, 13 Apr 2017 14:52:46 +0800
Message-ID: <b7bc244682b73301575072f129eb8857884811ba.1492065639.git.fuweix.tang@intel.com>
References: <cover.1492065639.git.fuweix.tang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id A505A267031
 for <alsa-devel@alsa-project.org>; Thu, 13 Apr 2017 08:53:02 +0200 (CEST)
In-Reply-To: <cover.1492065639.git.fuweix.tang@intel.com>
In-Reply-To: <cover.1492065639.git.fuweix.tang@intel.com>
References: <cover.1492065639.git.fuweix.tang@intel.com>
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, Fuwei Tang <fuweix.tang@intel.com>, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

From: Fuwei Tang <fuweix.tang@intel.com>

We can distinguish different use cases by the object index value, the default
value is 0, meaning applicable for all use cases, defined by macro "SND_TOLG_INDEX_ALL".
An element can only refer to other elements for "all" use cases or the same use
cases, i.e. it can only refer to elements with index value "SND_TOLG_INDEX_ALL"
or the same index value as itself.
The object list has been sorted in ascending order of index, so when we look up
a reference for an object, we traverse the object list it depends on, if we have
not found the reference until index of the object list is greater than index of
the object, we give up and return an error.

Signed-off-by: Fuwei Tang <fuweix.tang@intel.com>
Reviewed-by: Mengdong Lin <mengdong.lin@linux.intel.com>
---
 include/topology.h        | 10 +++++++---
 src/topology/ctl.c        |  4 ++--
 src/topology/dapm.c       | 18 +++++++++---------
 src/topology/data.c       |  6 +++---
 src/topology/elem.c       |  7 ++++++-
 src/topology/pcm.c        | 22 ++++++++++++----------
 src/topology/tplg_local.h |  3 ++-
 7 files changed, 41 insertions(+), 29 deletions(-)

diff --git a/include/topology.h b/include/topology.h
index 593eaa6..1bebe1e 100644
--- a/include/topology.h
+++ b/include/topology.h
@@ -356,9 +356,10 @@ extern "C" {
  * </pre>
  *
  * The section name is used to define the mixer name. The index number can be
- * used to identify topology objects groups. This allows driver operations on
- * objects with index number N and can be used to add/remove pipelines of
- * objects whilst other objects are unaffected.
+ * used to identify topology objects groups(index "0" is common, fit for all
+ * user cases).This allows driver operations on objects with index number N and
+ * can be used to add/remove pipelines of objects whilst other objects are
+ * unaffected.
  *
  * <h5>Byte Controls</h5>
  * A byte control is defined as a new section that can include channel mapping,
@@ -752,6 +753,9 @@ enum snd_tplg_type {
 	SND_TPLG_TYPE_DAI,		/*!< Physical DAI */
 };
 
+/** Fit for all user cases */
+#define SND_TPLG_INDEX_ALL  0
+
 /**
  * \brief Create a new topology parser instance.
  * \return New topology parser instance
diff --git a/src/topology/ctl.c b/src/topology/ctl.c
index 1b160a2..f09fb68 100644
--- a/src/topology/ctl.c
+++ b/src/topology/ctl.c
@@ -135,7 +135,7 @@ static int tplg_build_mixer_control(snd_tplg_t *tplg,
 
 		if (ref->type == SND_TPLG_TYPE_TLV) {
 			ref->elem = tplg_elem_lookup(&tplg->tlv_list,
-						ref->id, SND_TPLG_TYPE_TLV);
+				ref->id, SND_TPLG_TYPE_TLV, elem->index);
 			if (ref->elem)
 				 err = copy_tlv(elem, ref->elem);
 
@@ -185,7 +185,7 @@ static int tplg_build_enum_control(snd_tplg_t *tplg,
 
 		if (ref->type == SND_TPLG_TYPE_TEXT) {
 			ref->elem = tplg_elem_lookup(&tplg->text_list,
-						ref->id, SND_TPLG_TYPE_TEXT);
+				ref->id, SND_TPLG_TYPE_TEXT, elem->index);
 			if (ref->elem)
 				copy_enum_texts(elem, ref->elem);
 
diff --git a/src/topology/dapm.c b/src/topology/dapm.c
index ba5d9fe..13aa1c4 100644
--- a/src/topology/dapm.c
+++ b/src/topology/dapm.c
@@ -176,7 +176,7 @@ static int tplg_build_widget(snd_tplg_t *tplg,
 		case SND_TPLG_TYPE_MIXER:
 			if (!ref->elem)
 				ref->elem = tplg_elem_lookup(&tplg->mixer_list,
-						ref->id, SND_TPLG_TYPE_MIXER);
+				ref->id, SND_TPLG_TYPE_MIXER, elem->index);
 			if (ref->elem)
 				err = copy_dapm_control(elem, ref->elem);
 			break;
@@ -184,7 +184,7 @@ static int tplg_build_widget(snd_tplg_t *tplg,
 		case SND_TPLG_TYPE_ENUM:
 			if (!ref->elem)
 				ref->elem = tplg_elem_lookup(&tplg->enum_list,
-						ref->id, SND_TPLG_TYPE_ENUM);
+				ref->id, SND_TPLG_TYPE_ENUM, elem->index);
 			if (ref->elem)
 				err = copy_dapm_control(elem, ref->elem);
 			break;
@@ -192,7 +192,7 @@ static int tplg_build_widget(snd_tplg_t *tplg,
 		case SND_TPLG_TYPE_BYTES:
 			if (!ref->elem)
 				ref->elem = tplg_elem_lookup(&tplg->bytes_ext_list,
-						ref->id, SND_TPLG_TYPE_BYTES);
+				ref->id, SND_TPLG_TYPE_BYTES, elem->index);
 			if (ref->elem)
 				err = copy_dapm_control(elem, ref->elem);
 			break;
@@ -271,17 +271,17 @@ int tplg_build_routes(snd_tplg_t *tplg)
 
 		}
 		if (!tplg_elem_lookup(&tplg->widget_list, route->sink,
-			SND_TPLG_TYPE_DAPM_WIDGET)) {
+			SND_TPLG_TYPE_DAPM_WIDGET, elem->index)) {
 			SNDERR("warning: undefined sink widget/stream '%s'\n",
 				route->sink);
 		}
 
 		/* validate control name */
 		if (strlen(route->control)) {
-			if (!tplg_elem_lookup(&tplg->mixer_list,
-				route->control, SND_TPLG_TYPE_MIXER) &&
-			!tplg_elem_lookup(&tplg->enum_list,
-				route->control, SND_TPLG_TYPE_ENUM)) {
+			if (!tplg_elem_lookup(&tplg->mixer_list, route->control,
+					SND_TPLG_TYPE_MIXER, elem->index) &&
+			!tplg_elem_lookup(&tplg->enum_list, route->control,
+					SND_TPLG_TYPE_ENUM, elem->index)) {
 				SNDERR("warning: Undefined mixer/enum control '%s'\n",
 					route->control);
 			}
@@ -294,7 +294,7 @@ int tplg_build_routes(snd_tplg_t *tplg)
 
 		}
 		if (!tplg_elem_lookup(&tplg->widget_list, route->source,
-			SND_TPLG_TYPE_DAPM_WIDGET)) {
+			SND_TPLG_TYPE_DAPM_WIDGET, elem->index)) {
 			SNDERR("warning: Undefined source widget/stream '%s'\n",
 				route->source);
 		}
diff --git a/src/topology/data.c b/src/topology/data.c
index 7b92cea..61882b8 100644
--- a/src/topology/data.c
+++ b/src/topology/data.c
@@ -366,7 +366,7 @@ static struct tplg_elem *get_tokens(snd_tplg_t *tplg, struct tplg_elem *elem)
 
 		if (!ref->elem) {
 			ref->elem = tplg_elem_lookup(&tplg->token_list,
-						ref->id, SND_TPLG_TYPE_TOKEN);
+				ref->id, SND_TPLG_TYPE_TOKEN, elem->index);
 		}
 
 		return ref->elem;
@@ -508,7 +508,7 @@ static int build_tuples(snd_tplg_t *tplg, struct tplg_elem *elem)
 
 		if (!ref->elem)
 			ref->elem = tplg_elem_lookup(&tplg->tuple_list,
-						ref->id, SND_TPLG_TYPE_TUPLE);
+				ref->id, SND_TPLG_TYPE_TUPLE, elem->index);
 		tuples = ref->elem;
 		if (!tuples)
 			return -EINVAL;
@@ -1036,7 +1036,7 @@ int tplg_copy_data(snd_tplg_t *tplg, struct tplg_elem *elem,
 	void *obj;
 
 	ref_elem = tplg_elem_lookup(&tplg->pdata_list,
-				     ref->id, SND_TPLG_TYPE_DATA);
+				     ref->id, SND_TPLG_TYPE_DATA, elem->index);
 	if (!ref_elem) {
 		SNDERR("error: cannot find data '%s' referenced by"
 		" element '%s'\n", ref->id, elem->id);
diff --git a/src/topology/elem.c b/src/topology/elem.c
index 3ed655a..89a4ac9 100644
--- a/src/topology/elem.c
+++ b/src/topology/elem.c
@@ -107,7 +107,7 @@ void tplg_elem_free_list(struct list_head *base)
 }
 
 struct tplg_elem *tplg_elem_lookup(struct list_head *base, const char* id,
-	unsigned int type)
+	unsigned int type, int index)
 {
 	struct list_head *pos;
 	struct tplg_elem *elem;
@@ -121,6 +121,11 @@ struct tplg_elem *tplg_elem_lookup(struct list_head *base, const char* id,
 
 		if (!strcmp(elem->id, id) && elem->type == type)
 			return elem;
+		/* SND_TPLG_INDEX_ALL is the default value "0" and applicable
+		   for all use cases */
+		if ((elem->index != SND_TPLG_INDEX_ALL)
+			&& (elem->index > index))
+			break;
 	}
 
 	return NULL;
diff --git a/src/topology/pcm.c b/src/topology/pcm.c
index ed50c9c..788cc8c 100644
--- a/src/topology/pcm.c
+++ b/src/topology/pcm.c
@@ -55,14 +55,14 @@ static void copy_stream_caps(const char *id,
 
 /* find and copy the referenced stream caps */
 static int tplg_build_stream_caps(snd_tplg_t *tplg,
-	const char *id, struct snd_soc_tplg_stream_caps *caps)
+	const char *id, int index, struct snd_soc_tplg_stream_caps *caps)
 {
 	struct tplg_elem *ref_elem = NULL;
 	unsigned int i;
 
 	for (i = 0; i < 2; i++) {
 		ref_elem = tplg_elem_lookup(&tplg->pcm_caps_list,
-			caps[i].name, SND_TPLG_TYPE_STREAM_CAPS);
+			caps[i].name, SND_TPLG_TYPE_STREAM_CAPS, index);
 
 		if (ref_elem != NULL)
 			copy_stream_caps(id, &caps[i], ref_elem);
@@ -78,9 +78,10 @@ static int build_pcm(snd_tplg_t *tplg, struct tplg_elem *elem)
 	struct list_head *base, *pos;
 	int err;
 
-	err = tplg_build_stream_caps(tplg, elem->id, elem->pcm->caps);
-		if (err < 0)
-			return err;
+	err = tplg_build_stream_caps(tplg, elem->id, elem->index,
+						elem->pcm->caps);
+	if (err < 0)
+		return err;
 
 	/* merge private data from the referenced data elements */
 	base = &elem->ref_list;
@@ -138,7 +139,8 @@ static int tplg_build_dai(snd_tplg_t *tplg, struct tplg_elem *elem)
 	int err = 0;
 
 	/* get playback & capture stream caps */
-	err = tplg_build_stream_caps(tplg, elem->id, elem->dai->caps);
+	err = tplg_build_stream_caps(tplg, elem->id, elem->index,
+						elem->dai->caps);
 	if (err < 0)
 		return err;
 
@@ -186,7 +188,7 @@ int tplg_build_dais(snd_tplg_t *tplg, unsigned int type)
 }
 
 static int tplg_build_stream_cfg(snd_tplg_t *tplg,
-	struct snd_soc_tplg_stream *stream, int num_streams)
+	struct snd_soc_tplg_stream *stream, int num_streams, int index)
 {
 	struct snd_soc_tplg_stream *strm;
 	struct tplg_elem *ref_elem;
@@ -195,7 +197,7 @@ static int tplg_build_stream_cfg(snd_tplg_t *tplg,
 	for (i = 0; i < num_streams; i++) {
 		strm = stream + i;
 		ref_elem = tplg_elem_lookup(&tplg->pcm_config_list,
-			strm->name, SND_TPLG_TYPE_STREAM_CONFIG);
+			strm->name, SND_TPLG_TYPE_STREAM_CONFIG, index);
 
 		if (ref_elem && ref_elem->stream_cfg)
 			*strm = *ref_elem->stream_cfg;
@@ -212,7 +214,7 @@ static int build_link(snd_tplg_t *tplg, struct tplg_elem *elem)
 	int num_hw_configs = 0, err = 0;
 
 	err = tplg_build_stream_cfg(tplg, link->stream,
-				    link->num_streams);
+				    link->num_streams, elem->index);
 	if (err < 0)
 		return err;
 
@@ -225,7 +227,7 @@ static int build_link(snd_tplg_t *tplg, struct tplg_elem *elem)
 		switch (ref->type) {
 		case SND_TPLG_TYPE_HW_CONFIG:
 			ref->elem = tplg_elem_lookup(&tplg->hw_cfg_list,
-					ref->id, SND_TPLG_TYPE_HW_CONFIG);
+				ref->id, SND_TPLG_TYPE_HW_CONFIG, elem->index);
 			if (!ref->elem) {
 				SNDERR("error: cannot find HW config '%s'"
 				" referenced by link '%s'\n",
diff --git a/src/topology/tplg_local.h b/src/topology/tplg_local.h
index eb2f7bd..eb7eac5 100644
--- a/src/topology/tplg_local.h
+++ b/src/topology/tplg_local.h
@@ -259,7 +259,8 @@ void tplg_elem_free(struct tplg_elem *elem);
 void tplg_elem_free_list(struct list_head *base);
 struct tplg_elem *tplg_elem_lookup(struct list_head *base,
 				const char* id,
-				unsigned int type);
+				unsigned int type,
+				int index);
 struct tplg_elem* tplg_elem_new_common(snd_tplg_t *tplg,
 	snd_config_t *cfg, const char *name, enum snd_tplg_type type);
 
-- 
2.7.4
