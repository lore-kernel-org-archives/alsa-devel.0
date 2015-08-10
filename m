From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH v2 3/3] topology: A API calls to directly build
	topology data from templates
Date: Mon, 10 Aug 2015 19:13:49 +0100
Message-ID: <1439230429-6173-4-git-send-email-liam.r.girdwood@linux.intel.com>
References: <1439230429-6173-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 01A622659D7
 for <alsa-devel@alsa-project.org>; Mon, 10 Aug 2015 20:13:58 +0200 (CEST)
In-Reply-To: <1439230429-6173-1-git-send-email-liam.r.girdwood@linux.intel.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, Mengdong Lin <mengdong.lin@intel.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <liam.r.girdwood@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@intel.com>

Add some new API calls so that applications can directly build topology data
using template structures.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>
Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 include/topology.h        |  26 +++++
 src/topology/ctl.c        | 291 ++++++++++++++++++++++++++++++++++++++++++++++
 src/topology/dapm.c       | 182 ++++++++++++++++++++++++++---
 src/topology/elem.c       |  17 +++
 src/topology/parser.c     |  57 +++++++++
 src/topology/tplg_local.h |  11 ++
 6 files changed, 570 insertions(+), 14 deletions(-)

diff --git a/include/topology.h b/include/topology.h
index aee43de..6ff8c5f 100644
--- a/include/topology.h
+++ b/include/topology.h
@@ -664,6 +664,32 @@ typedef struct snd_tplg_obj_template {
 		struct snd_tplg_graph_template *graph;		/*!< Graph elements */
 	};
 } snd_tplg_obj_template_t;
+
+/**
+ * \brief Register topology template object.
+ * \param tplg Topology instance.
+ * \param t Template object.
+ * \return Zero on success, otherwise a negative error code
+ */
+int snd_tplg_add_object(snd_tplg_t *tplg, snd_tplg_obj_template_t *t);
+
+/**
+ * \brief Build all registered topology data into binary file.
+ * \param tplg Topology instance.
+ * \param outfile Binary topology output file.
+ * \return Zero on success, otherwise a negative error code
+ */
+int snd_tplg_build(snd_tplg_t *tplg, const char *outfile);
+
+/**
+ * \brief Attach private data to topology manifest.
+ * \param tplg Topology instance.
+ * \param data Private data.
+ * \param len Length of data in bytes.
+ * \return Zero on success, otherwise a negative error code
+ */
+int snd_tplg_set_manifest_data(snd_tplg_t *tplg, const void *data, int len);
+
 /* \} */
 
 #ifdef __cplusplus
diff --git a/src/topology/ctl.c b/src/topology/ctl.c
index 35f684b..14027a3 100644
--- a/src/topology/ctl.c
+++ b/src/topology/ctl.c
@@ -19,6 +19,8 @@
 #include "list.h"
 #include "tplg_local.h"
 
+#define ENUM_VAL_SIZE 	(SNDRV_CTL_ELEM_ID_NAME_MAXLEN >> 2)
+
 /* copy referenced TLV to the mixer control */
 static int copy_tlv(struct tplg_elem *elem, struct tplg_elem *ref)
 {
@@ -606,3 +608,292 @@ int tplg_parse_control_mixer(snd_tplg_t *tplg,
 
 	return 0;
 }
+
+static int init_ctl_hdr(struct snd_soc_tplg_ctl_hdr *hdr,
+		struct snd_tplg_ctl_template *t)
+{
+	hdr->size = sizeof(struct snd_soc_tplg_ctl_hdr);
+	hdr->type = t->type;
+
+	elem_copy_text(hdr->name, t->name,
+		SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
+
+	/* clean up access flag */
+	if (t->access == 0)
+		t->access = SNDRV_CTL_ELEM_ACCESS_READWRITE;
+	t->access &= (SNDRV_CTL_ELEM_ACCESS_READWRITE |
+		SNDRV_CTL_ELEM_ACCESS_VOLATILE |
+		SNDRV_CTL_ELEM_ACCESS_INACTIVE |
+		SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE |
+		SNDRV_CTL_ELEM_ACCESS_TLV_COMMAND |
+		SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK);
+
+	hdr->access = t->access;
+	hdr->ops.get = t->ops.get;
+	hdr->ops.put = t->ops.put;
+	hdr->ops.info = t->ops.info;
+
+	/* TLV */
+	if (hdr->access & SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE
+		&& !(hdr->access & SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK)) {
+
+		struct snd_tplg_tlv_template *tlvt = t->tlv;
+		struct snd_soc_tplg_ctl_tlv *tlv = &hdr->tlv;
+		struct snd_tplg_tlv_dbscale_template *scalet;
+		struct snd_soc_tplg_tlv_dbscale *scale;
+
+		if (!tlvt) {
+			SNDERR("error: missing TLV data\n");
+			return -EINVAL;
+		}
+
+		tlv->size = sizeof(struct snd_soc_tplg_ctl_tlv);
+		tlv->type = tlvt->type;
+
+		switch (tlvt->type) {
+		case SNDRV_CTL_TLVT_DB_SCALE:
+			scalet = container_of(tlvt,
+				struct snd_tplg_tlv_dbscale_template, hdr);
+			scale = &tlv->scale;
+			scale->min = scalet->min;
+			scale->step = scalet->step;
+			scale->mute = scalet->mute;
+			break;
+
+		/* TODO: add support for other TLV types */
+		default:
+			SNDERR("error: unsupported TLV type %d\n", tlv->type);
+			break;
+		}
+	}
+
+	return 0;
+}
+
+int tplg_add_mixer(snd_tplg_t *tplg, struct snd_tplg_mixer_template *mixer,
+	struct tplg_elem **e)
+{
+	struct snd_soc_tplg_private *priv = mixer->priv;
+	struct snd_soc_tplg_mixer_control *mc;
+	struct tplg_elem *elem;
+	int ret, i;
+
+	tplg_dbg(" Control Mixer: %s\n", mixer->hdr.name);
+
+	if (mixer->hdr.type != SND_SOC_TPLG_TYPE_MIXER) {
+		SNDERR("error: invalid mixer type %d\n", mixer->hdr.type);
+		return -EINVAL;
+	}
+
+	elem = tplg_elem_new_common(tplg, NULL, mixer->hdr.name,
+		SND_TPLG_TYPE_MIXER);
+	if (!elem)
+		return -ENOMEM;
+
+	/* init new mixer */
+	mc = elem->mixer_ctrl;
+	mc->size = elem->size;
+	ret =  init_ctl_hdr(&mc->hdr, &mixer->hdr);
+	if (ret < 0) {
+		tplg_elem_free(elem);
+		return ret;
+	}
+
+	mc->min = mixer->min;
+	mc->max = mixer->max;
+	mc->platform_max = mixer->platform_max;
+	mc->invert = mixer->invert;
+
+	/* set channel reg to default state */
+	for (i = 0; i < SND_SOC_TPLG_MAX_CHAN; i++)
+		mc->channel[i].reg = -1;
+
+	if (mixer->map)
+		mc->num_channels = mixer->map->num_channels;
+	for (i = 0; i < mc->num_channels; i++) {
+		struct snd_tplg_channel_elem *channel = &mixer->map->channel[i];
+
+		mc->channel[i].size = channel->size;
+		mc->channel[i].reg = channel->reg;
+		mc->channel[i].shift = channel->shift;
+		mc->channel[i].id = channel->id;
+	}
+
+	/* priv data */
+	if (priv) {
+		mc = realloc(mc, elem->size + priv->size);
+		if (!mc) {
+			tplg_elem_free(elem);
+			return -ENOMEM;
+		}
+
+		elem->mixer_ctrl = mc;
+		elem->size += priv->size;
+		mc->priv.size = priv->size;
+		memcpy(mc->priv.data, priv->data,  priv->size);
+        }
+
+	if (e)
+		*e = elem;
+	return 0;
+}
+
+int tplg_add_enum(snd_tplg_t *tplg, struct snd_tplg_enum_template *enum_ctl,
+	struct tplg_elem **e)
+{
+	struct snd_soc_tplg_enum_control *ec;
+	struct tplg_elem *elem;
+	int ret, i;
+
+	tplg_dbg(" Control Enum: %s\n", enum_ctl->hdr.name);
+
+	if (enum_ctl->hdr.type != SND_SOC_TPLG_TYPE_ENUM) {
+		SNDERR("error: invalid enum type %d\n", enum_ctl->hdr.type);
+		return -EINVAL;
+	}
+
+	elem = tplg_elem_new_common(tplg, NULL, enum_ctl->hdr.name,
+		SND_TPLG_TYPE_ENUM);
+	if (!elem)
+		return -ENOMEM;
+
+	ec = elem->enum_ctrl;
+	ec->size = elem->size;
+	ret = init_ctl_hdr(&ec->hdr, &enum_ctl->hdr);
+	if (ret < 0) {
+		tplg_elem_free(elem);
+		return ret;
+	}
+
+	ec->items = enum_ctl->items;
+	if (ec->items > SND_SOC_TPLG_NUM_TEXTS)
+		ec->items = SND_SOC_TPLG_NUM_TEXTS;
+
+	ec->mask = enum_ctl->mask;
+	ec->count = enum_ctl->items;
+
+	if (enum_ctl->texts != NULL) {
+		for (i = 0; i < ec->items; i++) {
+			if (enum_ctl->texts[i] != NULL)
+				strncpy(ec->texts[i], enum_ctl->texts[i],
+					SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
+		}
+	}
+
+	if (enum_ctl->values != NULL) {
+		for (i = 0; i < ec->items; i++) {
+			if (enum_ctl->values[i])
+				continue;
+
+			memcpy(&ec->values[i * sizeof(int) * ENUM_VAL_SIZE],
+				enum_ctl->values[i],
+				sizeof(int) * ENUM_VAL_SIZE);
+		}
+	}
+
+	if (enum_ctl->priv != NULL) {
+		ec = realloc(ec,
+			elem->size + enum_ctl->priv->size);
+		if (!ec) {
+			tplg_elem_free(elem);
+			return -ENOMEM;
+		}
+
+		elem->enum_ctrl = ec;
+		elem->size += enum_ctl->priv->size;
+
+		memcpy(ec->priv.data, enum_ctl->priv->data,
+			enum_ctl->priv->size);
+
+		ec->priv.size = enum_ctl->priv->size;
+	}
+
+	if (e)
+		*e = elem;
+	return 0;
+}
+
+int tplg_add_bytes(snd_tplg_t *tplg, struct snd_tplg_bytes_template *bytes_ctl,
+	struct tplg_elem **e)
+{
+	struct snd_soc_tplg_bytes_control *be;
+	struct tplg_elem *elem;
+	int ret;
+
+	tplg_dbg(" Control Bytes: %s\n", bytes_ctl->hdr.name);
+
+	if (bytes_ctl->hdr.type != SND_SOC_TPLG_TYPE_BYTES) {
+		SNDERR("error: invalid bytes type %d\n", bytes_ctl->hdr.type);
+		return -EINVAL;
+	}
+
+	elem = tplg_elem_new_common(tplg, NULL, bytes_ctl->hdr.name,
+		SND_TPLG_TYPE_BYTES);
+	if (!elem)
+		return -ENOMEM;
+
+	be = elem->bytes_ext;
+	be->size = elem->size;
+	ret = init_ctl_hdr(&be->hdr, &bytes_ctl->hdr);
+	if (ret < 0) {
+		tplg_elem_free(elem);
+		return ret;
+	}
+
+	be->max = bytes_ctl->max;
+	be->mask = bytes_ctl->mask;
+	be->base = bytes_ctl->base;
+	be->num_regs = bytes_ctl->num_regs;
+	be->ext_ops.put = bytes_ctl->ext_ops.put;
+	be->ext_ops.get = bytes_ctl->ext_ops.get;
+
+	if (bytes_ctl->priv != NULL) {
+		be = realloc(be,
+			elem->size + bytes_ctl->priv->size);
+		if (!be) {
+			tplg_elem_free(elem);
+			return -ENOMEM;
+		}
+		elem->bytes_ext = be;
+		elem->size += bytes_ctl->priv->size;
+
+		memcpy(be->priv.data, bytes_ctl->priv->data,
+			bytes_ctl->priv->size);
+
+		be->priv.size = bytes_ctl->priv->size;
+	}
+
+	/* check on TLV bytes control */
+	if (be->hdr.access & SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK) {
+		if (be->hdr.access & SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE
+			!= SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE) {
+			SNDERR("error: Invalid TLV bytes control access 0x%x\n",
+				be->hdr.access);
+			return -EINVAL;
+		}
+
+		if (!be->max) {
+			tplg_elem_free(elem);
+			return -EINVAL;
+		}
+	}
+
+	if (e)
+		*e = elem;
+	return 0;
+}
+
+int tplg_add_mixer_object(snd_tplg_t *tplg, snd_tplg_obj_template_t *t)
+{
+	return tplg_add_mixer(tplg, t->mixer, NULL);
+}
+
+int tplg_add_enum_object(snd_tplg_t *tplg, snd_tplg_obj_template_t *t)
+{
+	return tplg_add_enum(tplg, t->enum_ctl, NULL);
+}
+
+int tplg_add_bytes_object(snd_tplg_t *tplg, snd_tplg_obj_template_t *t)
+{
+	return tplg_add_bytes(tplg, t->bytes_ctl, NULL);
+}
diff --git a/src/topology/dapm.c b/src/topology/dapm.c
index 3458aa7..5b3500f 100644
--- a/src/topology/dapm.c
+++ b/src/topology/dapm.c
@@ -142,8 +142,6 @@ static int tplg_build_widget(snd_tplg_t *tplg,
 	list_for_each(pos, base) {
 
 		ref = list_entry(pos, struct tplg_ref, list);
-		if (ref->id == NULL || ref->elem)
-			continue;
 
 		switch (ref->type) {
 		case SND_TPLG_TYPE_MIXER:
@@ -162,6 +160,14 @@ static int tplg_build_widget(snd_tplg_t *tplg,
 				err = copy_dapm_control(elem, ref->elem);
 			break;
 
+		case SND_TPLG_TYPE_BYTES:
+			if (!ref->elem)
+				ref->elem = tplg_elem_lookup(&tplg->bytes_ext_list,
+						ref->id, SND_TPLG_TYPE_BYTES);
+			if (ref->elem)
+				err = copy_dapm_control(elem, ref->elem);
+			break;
+
 		case SND_TPLG_TYPE_DATA:
 			if (!ref->elem)
 				ref->elem = tplg_elem_lookup(&tplg->pdata_list,
@@ -278,6 +284,28 @@ int tplg_build_routes(snd_tplg_t *tplg)
 	return 0;
 }
 
+struct tplg_elem* tplg_elem_new_route(snd_tplg_t *tplg)
+{
+	struct tplg_elem *elem;
+	struct snd_soc_tplg_dapm_graph_elem *line;
+
+	elem = tplg_elem_new();
+	if (!elem)
+		return NULL;
+
+	list_add_tail(&elem->list, &tplg->route_list);
+	strcpy(elem->id, "line");
+	elem->type = SND_TPLG_TYPE_DAPM_GRAPH;
+	elem->size = sizeof(*line);
+
+	line = calloc(1, sizeof(*line));
+	if (!line)
+		return NULL;
+	elem->route = line;
+
+	return elem;
+}
+
 #define LINE_SIZE	1024
 
 /* line is defined as '"source, control, sink"' */
@@ -334,7 +362,7 @@ static int tplg_parse_routes(snd_tplg_t *tplg, snd_config_t *cfg)
 	snd_config_iterator_t i, next;
 	snd_config_t *n;
 	struct tplg_elem *elem;
-	struct snd_soc_tplg_dapm_graph_elem *line = NULL;
+	struct snd_soc_tplg_dapm_graph_elem *line;
 	int err;
 
 	snd_config_for_each(i, next, cfg) {
@@ -344,20 +372,11 @@ static int tplg_parse_routes(snd_tplg_t *tplg, snd_config_t *cfg)
 		if (snd_config_get_string(n, &val) < 0)
 			continue;
 
-		elem = tplg_elem_new();
+		elem = tplg_elem_new_route(tplg);
 		if (!elem)
 			return -ENOMEM;
 
-		list_add_tail(&elem->list, &tplg->route_list);
-		strcpy(elem->id, "line");
-		elem->type = SND_TPLG_TYPE_DAPM_GRAPH;
-		elem->size = sizeof(*line);
-
-		line = calloc(1, sizeof(*line));
-		if (!line)
-			return -ENOMEM;
-
-		elem->route = line;
+		line = elem->route;
 
 		err = tplg_parse_line(val, line);
 		if (err < 0)
@@ -558,3 +577,138 @@ int tplg_parse_dapm_widget(snd_tplg_t *tplg,
 
 	return 0;
 }
+
+int tplg_add_route(snd_tplg_t *tplg, struct snd_tplg_graph_elem *t)
+{
+	struct tplg_elem *elem;
+	struct snd_soc_tplg_dapm_graph_elem *line;
+
+	if (!t->src || !t->sink)
+		return -EINVAL;
+
+	elem = tplg_elem_new_route(tplg);
+	if (!elem)
+		return -ENOMEM;
+
+	line = elem->route;
+	elem_copy_text(line->source, t->src, SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
+	if (t->ctl)
+		elem_copy_text(line->control, t->ctl,
+			SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
+	elem_copy_text(line->sink, t->sink, SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
+
+	return 0;
+}
+
+int tplg_add_graph_object(snd_tplg_t *tplg, snd_tplg_obj_template_t *t)
+{
+	struct snd_tplg_graph_template *gt =  t->graph;
+	int i, ret;
+
+	for (i = 0; i < gt->count; i++) {
+		ret = tplg_add_route(tplg, gt->elem + i);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+int tplg_add_widget_object(snd_tplg_t *tplg, snd_tplg_obj_template_t *t)
+{
+	struct snd_tplg_widget_template *wt = t->widget;
+	struct snd_soc_tplg_dapm_widget *w;
+	struct tplg_elem *elem;
+	int i, ret = 0;
+
+	tplg_dbg("Widget: %s\n", wt->name);
+
+	elem = tplg_elem_new_common(tplg, NULL, wt->name,
+		SND_TPLG_TYPE_DAPM_WIDGET);
+	if (!elem)
+		return -ENOMEM;
+
+	/* init new widget */
+	w = elem->widget;
+	w->size = elem->size;
+
+	w->id = wt->id;
+	elem_copy_text(w->name, wt->name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
+	if (wt->sname)
+		elem_copy_text(w->sname, wt->sname,
+		SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
+	w->reg = wt->reg;
+	w->shift = wt->shift;
+	w->mask = wt->mask;
+	w->subseq = wt->subseq;
+	w->invert = wt->invert;
+	w->ignore_suspend = wt->ignore_suspend;
+	w->event_flags = wt->event_flags;
+	w->event_type = wt->event_type;
+
+	if (wt->priv != NULL) {
+		w = realloc(w,
+			elem->size + wt->priv->size);
+		if (!w) {
+			tplg_elem_free(elem);
+			return -ENOMEM;
+		}
+
+		elem->widget = w;
+		elem->size += wt->priv->size;
+
+		memcpy(w->priv.data, wt->priv->data,
+			wt->priv->size);
+		w->priv.size = wt->priv->size;
+	}
+
+	/* add controls to the widget's reference list */
+	for (i = 0 ; i < wt->num_ctls; i++) {
+		struct snd_tplg_ctl_template *ct = wt->ctl[i];
+		struct tplg_elem *elem_ctl;
+		struct snd_tplg_mixer_template *mt;
+		struct snd_tplg_bytes_template *bt;
+		struct snd_tplg_enum_template *et;
+
+		if (!ct) {
+			tplg_elem_free(elem);
+			return -EINVAL;
+		}
+
+		switch (ct->type) {
+		case SND_SOC_TPLG_TYPE_MIXER:
+			mt = container_of(ct, struct snd_tplg_mixer_template, hdr);
+			ret = tplg_add_mixer(tplg, mt, &elem_ctl);
+			break;
+
+		case SND_SOC_TPLG_TYPE_BYTES:
+			bt = container_of(ct, struct snd_tplg_bytes_template, hdr);
+			ret = tplg_add_bytes(tplg, bt, &elem_ctl);
+			break;
+
+		case SND_SOC_TPLG_TYPE_ENUM:
+			et = container_of(ct, struct snd_tplg_enum_template, hdr);
+			ret = tplg_add_enum(tplg, bt, &elem_ctl);
+			break;
+
+		default:
+			SNDERR("error: widget %s: invalid type %d for ctl %d\n",
+				wt->name, ct->type, i);
+			ret = -EINVAL;
+			break;
+		}
+
+		if (ret < 0) {
+			tplg_elem_free(elem);
+			return ret;
+		}
+
+		ret = tplg_ref_add_elem(elem, elem_ctl);
+		if (ret < 0) {
+			tplg_elem_free(elem);
+			return ret;
+		}
+	}
+
+	return 0;
+}
diff --git a/src/topology/elem.c b/src/topology/elem.c
index daabe75..d784236 100644
--- a/src/topology/elem.c
+++ b/src/topology/elem.c
@@ -35,6 +35,23 @@ int tplg_ref_add(struct tplg_elem *elem, int type, const char* id)
 	return 0;
 }
 
+/* directly add a reference elem */
+int tplg_ref_add_elem(struct tplg_elem *elem, struct tplg_elem *elem_ref)
+{
+	struct tplg_ref *ref;
+
+	ref = calloc(1, sizeof(*ref));
+	if (!ref)
+		return -ENOMEM;
+
+	ref->type = elem_ref->type;
+	ref->elem = elem_ref;
+	elem_copy_text(ref->id,  elem_ref->id, SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
+
+	list_add_tail(&ref->list, &elem->ref_list);
+	return 0;
+}
+
 void tplg_ref_free_list(struct list_head *base)
 {
 	struct list_head *pos, *npos;
diff --git a/src/topology/parser.c b/src/topology/parser.c
index 3e3e2b3..497eb42 100644
--- a/src/topology/parser.c
+++ b/src/topology/parser.c
@@ -309,6 +309,63 @@ out_close:
 	return err;
 }
 
+int snd_tplg_add_object(snd_tplg_t *tplg, snd_tplg_obj_template_t *t)
+{
+	switch (t->type) {
+	case SND_TPLG_TYPE_MIXER:
+		return tplg_add_mixer_object(tplg, t);
+	case SND_TPLG_TYPE_ENUM:
+		return tplg_add_enum_object(tplg, t);
+	case SND_TPLG_TYPE_BYTES:
+		return tplg_add_bytes_object(tplg, t);
+	case SND_TPLG_TYPE_DAPM_WIDGET:
+		return tplg_add_widget_object(tplg, t);
+	case SND_TPLG_TYPE_DAPM_GRAPH:
+		return tplg_add_graph_object(tplg, t);
+	default:
+		SNDERR("error: invalid object type %d\n", t->type);
+		return -EINVAL;
+	};
+}
+
+int snd_tplg_build(snd_tplg_t *tplg, const char *outfile)
+{
+	int err;
+
+	/* delete any old output files */
+	unlink(outfile);
+
+	tplg->out_fd =
+		open(outfile, O_RDWR | O_CREAT, S_IRWXU | S_IRWXG | S_IRWXO);
+	if (tplg->out_fd < 0) {
+		SNDERR("error: failed to open %s err %d\n",
+			outfile, -errno);
+		return -errno;
+	}
+
+	err = tplg_build_integ(tplg);
+	if (err < 0) {
+		SNDERR("error: failed to check topology integrity\n");
+		goto out;
+	}
+
+	err = tplg_write_data(tplg);
+	if (err < 0) {
+		SNDERR("error: failed to write data %d\n", err);
+		goto out;
+	}
+
+out:
+	close(tplg->out_fd);
+	return err;
+}
+
+int snd_tplg_set_manifest_data(snd_tplg_t *tplg, const void *data, int len)
+{
+	tplg->manifest.priv.size = len;
+	tplg->manifest_pdata = data;
+}
+
 void snd_tplg_verbose(snd_tplg_t *tplg, int verbose)
 {
 	tplg->verbose = verbose;
diff --git a/src/topology/tplg_local.h b/src/topology/tplg_local.h
index 953d822..97ee33e 100644
--- a/src/topology/tplg_local.h
+++ b/src/topology/tplg_local.h
@@ -34,6 +34,10 @@
 #define ALSA_TPLG_DIR	ALSA_CONFIG_DIR "/topology"
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof(x[0]))
 
+#define container_of(ptr, type, member) ({                      \
+	 const typeof( ((type *)0)->member ) *__mptr = (ptr);    \
+	(type *)( (char *)__mptr - offsetof(type,member) );})
+
 /** The name of the environment variable containing the tplg directory */
 #define ALSA_CONFIG_TPLG_VAR "ALSA_CONFIG_TPLG"
 
@@ -191,6 +195,7 @@ int tplg_build_pcm_dai(snd_tplg_t *tplg, unsigned int type);
 int tplg_copy_data(struct tplg_elem *elem, struct tplg_elem *ref);
 
 int tplg_ref_add(struct tplg_elem *elem, int type, const char* id);
+int tplg_ref_add_elem(struct tplg_elem *elem, struct tplg_elem *elem_ref);
 
 struct tplg_elem *tplg_elem_new(void);
 void tplg_elem_free(struct tplg_elem *elem);
@@ -215,3 +220,9 @@ int tplg_parse_ops(snd_tplg_t *tplg ATTRIBUTE_UNUSED,
 
 struct tplg_elem *lookup_pcm_dai_stream(struct list_head *base,
 	const char* id);
+
+int tplg_add_mixer_object(snd_tplg_t *tplg, snd_tplg_obj_template_t *t);
+int tplg_add_enum_object(snd_tplg_t *tplg, snd_tplg_obj_template_t *t);
+int tplg_add_bytes_object(snd_tplg_t *tplg, snd_tplg_obj_template_t *t);
+int tplg_add_widget_object(snd_tplg_t *tplg, snd_tplg_obj_template_t *t);
+int tplg_add_graph_object(snd_tplg_t *tplg, snd_tplg_obj_template_t *t);
-- 
2.1.4
