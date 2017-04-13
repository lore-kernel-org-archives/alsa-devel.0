From: fuweix.tang@intel.com
Subject: [PATCH 1/4] topology: Insert new element based on its
	index value
Date: Thu, 13 Apr 2017 14:52:44 +0800
Message-ID: <e66116f15b18105a993a73047069b2ebe2ed438e.1492065639.git.fuweix.tang@intel.com>
References: <cover.1492065639.git.fuweix.tang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C486266AD7
 for <alsa-devel@alsa-project.org>; Thu, 13 Apr 2017 08:53:00 +0200 (CEST)
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

When creating a new element, insert it into the list in the ascending order of
index value.

Signed-off-by: Fuwei Tang <fuweix.tang@intel.com>
Reviewed-by: Mengdong Lin <mengdong.lin@linux.intel.com>
---
 src/topology/elem.c | 67 +++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 49 insertions(+), 18 deletions(-)

diff --git a/src/topology/elem.c b/src/topology/elem.c
index efcf3e9..3ed655a 100644
--- a/src/topology/elem.c
+++ b/src/topology/elem.c
@@ -126,14 +126,33 @@ struct tplg_elem *tplg_elem_lookup(struct list_head *base, const char* id,
 	return NULL;
 }
 
+/* insert a new element into list in the ascending order of index value*/
+static void tplg_elem_insert(struct tplg_elem *elem_p, struct list_head *list)
+{
+	struct list_head *pos, *p = &(elem_p->list);
+	struct tplg_elem *elem;
+
+	list_for_each(pos, list) {
+		elem = list_entry(pos, struct tplg_elem, list);
+		if (elem_p->index < elem->index)
+			break;
+	}
+	p->prev = pos->prev;
+	pos->prev->next = p;
+	pos->prev = p;
+	p->next = pos;
+}
+
 /* create a new common element and object */
 struct tplg_elem* tplg_elem_new_common(snd_tplg_t *tplg,
 	snd_config_t *cfg, const char *name, enum snd_tplg_type type)
 {
 	struct tplg_elem *elem;
-	const char *id;
+	const char *id, *val = NULL;
 	int obj_size = 0;
 	void *obj;
+	snd_config_iterator_t i, next;
+	snd_config_t *n;
 
 	if (!cfg && !name)
 		return NULL;
@@ -147,75 +166,87 @@ struct tplg_elem* tplg_elem_new_common(snd_tplg_t *tplg,
 		snd_config_get_id(cfg, &id);
 		elem_copy_text(elem->id, id, SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
 		elem->id[SNDRV_CTL_ELEM_ID_NAME_MAXLEN - 1] = 0;
+		/* as we insert new elem based on the index value, move index
+		   parsing here */
+		snd_config_for_each(i, next, cfg) {
+			n = snd_config_iterator_entry(i);
+			if (snd_config_get_id(n, &id))
+				continue;
+			if (strcmp(id, "index") == 0) {
+				if (snd_config_get_string(n, &val) < 0)
+					return NULL;
+				elem->index = atoi(val);
+			}
+		}
 	} else if (name != NULL)
 		elem_copy_text(elem->id, name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
 
 	switch (type) {
 	case SND_TPLG_TYPE_DATA:
-		list_add_tail(&elem->list, &tplg->pdata_list);
+		tplg_elem_insert(elem, &tplg->pdata_list);
 		break;
 	case SND_TPLG_TYPE_MANIFEST:
-		list_add_tail(&elem->list, &tplg->manifest_list);
+		tplg_elem_insert(elem, &tplg->manifest_list);
 		obj_size = sizeof(struct snd_soc_tplg_manifest);
 		break;
 	case SND_TPLG_TYPE_TEXT:
-		list_add_tail(&elem->list, &tplg->text_list);
+		tplg_elem_insert(elem, &tplg->text_list);
 		obj_size = sizeof(struct tplg_texts);
 		break;
 	case SND_TPLG_TYPE_TLV:
-		list_add_tail(&elem->list, &tplg->tlv_list);
+		tplg_elem_insert(elem, &tplg->tlv_list);
 		elem->size = sizeof(struct snd_soc_tplg_ctl_tlv);
 		break;
 	case SND_TPLG_TYPE_BYTES:
-		list_add_tail(&elem->list, &tplg->bytes_ext_list);
+		tplg_elem_insert(elem, &tplg->bytes_ext_list);
 		obj_size = sizeof(struct snd_soc_tplg_bytes_control);
 		break;
 	case SND_TPLG_TYPE_ENUM:
-		list_add_tail(&elem->list, &tplg->enum_list);
+		tplg_elem_insert(elem, &tplg->enum_list);
 		obj_size = sizeof(struct snd_soc_tplg_enum_control);
 		break;
 	case SND_TPLG_TYPE_MIXER:
-		list_add_tail(&elem->list, &tplg->mixer_list);
+		tplg_elem_insert(elem, &tplg->mixer_list);
 		obj_size = sizeof(struct snd_soc_tplg_mixer_control);
 		break;
 	case SND_TPLG_TYPE_DAPM_WIDGET:
-		list_add_tail(&elem->list, &tplg->widget_list);
+		tplg_elem_insert(elem, &tplg->widget_list);
 		obj_size = sizeof(struct snd_soc_tplg_dapm_widget);
 		break;
 	case SND_TPLG_TYPE_STREAM_CONFIG:
-		list_add_tail(&elem->list, &tplg->pcm_config_list);
+		tplg_elem_insert(elem, &tplg->pcm_config_list);
 		obj_size = sizeof(struct snd_soc_tplg_stream);
 		break;
 	case SND_TPLG_TYPE_STREAM_CAPS:
-		list_add_tail(&elem->list, &tplg->pcm_caps_list);
+		tplg_elem_insert(elem, &tplg->pcm_caps_list);
 		obj_size = sizeof(struct snd_soc_tplg_stream_caps);
 		break;
 	case SND_TPLG_TYPE_PCM:
-		list_add_tail(&elem->list, &tplg->pcm_list);
+		tplg_elem_insert(elem, &tplg->pcm_list);
 		obj_size = sizeof(struct snd_soc_tplg_pcm);
 		break;
 	case SND_TPLG_TYPE_DAI:
-		list_add_tail(&elem->list, &tplg->dai_list);
+		tplg_elem_insert(elem, &tplg->dai_list);
 		obj_size = sizeof(struct snd_soc_tplg_dai);
 		break;
 	case SND_TPLG_TYPE_BE:
 	case SND_TPLG_TYPE_LINK:
-		list_add_tail(&elem->list, &tplg->be_list);
+		tplg_elem_insert(elem, &tplg->be_list);
 		obj_size = sizeof(struct snd_soc_tplg_link_config);
 		break;
 	case SND_TPLG_TYPE_CC:
-		list_add_tail(&elem->list, &tplg->cc_list);
+		tplg_elem_insert(elem, &tplg->cc_list);
 		obj_size = sizeof(struct snd_soc_tplg_link_config);
 		break;
 	case SND_TPLG_TYPE_TOKEN:
-		list_add_tail(&elem->list, &tplg->token_list);
+		tplg_elem_insert(elem, &tplg->token_list);
 		break;
 	case SND_TPLG_TYPE_TUPLE:
-		list_add_tail(&elem->list, &tplg->tuple_list);
+		tplg_elem_insert(elem, &tplg->tuple_list);
 		elem->free = tplg_free_tuples;
 		break;
 	case SND_TPLG_TYPE_HW_CONFIG:
-		list_add_tail(&elem->list, &tplg->hw_cfg_list);
+		tplg_elem_insert(elem, &tplg->hw_cfg_list);
 		obj_size = sizeof(struct snd_soc_tplg_hw_config);
 		break;
 	default:
-- 
2.7.4
