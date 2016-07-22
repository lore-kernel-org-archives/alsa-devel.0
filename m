From: mengdong.lin@linux.intel.com
Subject: [PATCH 3/4] topology: Support adding BE DAIs by C API
Date: Fri, 22 Jul 2016 14:11:03 +0800
Message-ID: <f0e63c45d5ce2727fc6e432bf7bfe61fdc0fda37.1469165324.git.mengdong.lin@linux.intel.com>
References: <cover.1469165324.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F918266720
 for <alsa-devel@alsa-project.org>; Fri, 22 Jul 2016 08:06:05 +0200 (CEST)
In-Reply-To: <cover.1469165324.git.mengdong.lin@linux.intel.com>
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, broonie@kernel.org, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

From: Guneshwor Singh <guneshwor.o.singh@intel.com>

In addition to text conf file, BE (Back End) DAIs can also be added
by C API. This patch defines the template to add BE DAIs from C API.

Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/topology.h b/include/topology.h
index da45848..f98894f 100644
--- a/include/topology.h
+++ b/include/topology.h
@@ -894,6 +894,21 @@ struct snd_tplg_pcm_template {
 	struct snd_tplg_stream_template stream[0]; /*!< supported configs */
 };
 
+/** \struct snd_tplg_be_dai_template
+ * \brief Template type for Back End DAI.
+ */
+struct snd_tplg_be_dai_template {
+	const char *dai_name;	/*!< DAI name */
+	unsigned int dai_id;	/*!< unique ID - used to match */
+	unsigned int playback;	/*!< supports playback mode */
+	unsigned int capture;	/*!< supports capture mode */
+	struct snd_tplg_stream_caps_template *caps[2]; /*!< playback & capture for DAI */
+	unsigned int flag_mask; /*!< bitmask of flags to configure */
+	unsigned int flags;	/*!< SND_SOC_TPLG_DAI_FLGBIT_* */
+	struct snd_soc_tplg_private *priv;	/*!< private data */
+
+};
+
 /** \struct snd_tplg_link_template
  * \brief Template type for BE and CC DAI Links.
  */
@@ -919,6 +934,7 @@ typedef struct snd_tplg_obj_template {
 		struct snd_tplg_enum_template *enum_ctl;	/*!< Enum control */
 		struct snd_tplg_graph_template *graph;		/*!< Graph elements */
 		struct snd_tplg_pcm_template *pcm;		/*!< PCM elements */
+		struct snd_tplg_be_dai_template *be_dai;	/*!< BE DAI elements */
 		struct snd_tplg_link_template *link;		/*!< BE and CC Links */
 	};
 } snd_tplg_obj_template_t;
diff --git a/src/topology/parser.c b/src/topology/parser.c
index aa1b33e..02c19dd 100644
--- a/src/topology/parser.c
+++ b/src/topology/parser.c
@@ -355,6 +355,8 @@ int snd_tplg_add_object(snd_tplg_t *tplg, snd_tplg_obj_template_t *t)
 		return tplg_add_graph_object(tplg, t);
 	case SND_TPLG_TYPE_PCM:
 		return tplg_add_pcm_object(tplg, t);
+	case SND_TPLG_TYPE_BE_DAI:
+		return tplg_add_be_dai_object(tplg, t);
 	case SND_TPLG_TYPE_BE:
 	case SND_TPLG_TYPE_CC:
 		return tplg_add_link_object(tplg, t);
diff --git a/src/topology/pcm.c b/src/topology/pcm.c
index 7e2f68f..42efe4a 100644
--- a/src/topology/pcm.c
+++ b/src/topology/pcm.c
@@ -774,3 +774,58 @@ int tplg_add_link_object(snd_tplg_t *tplg, snd_tplg_obj_template_t *t)
 
 	return 0;
 }
+
+int tplg_add_be_dai_object(snd_tplg_t *tplg, snd_tplg_obj_template_t *t)
+{
+	struct snd_tplg_be_dai_template *be_tpl = t->be_dai;
+	struct snd_soc_tplg_be_dai *be, *_be;
+	struct tplg_elem *elem;
+	int i;
+
+	tplg_dbg("BE DAI %s\n", be_tpl->dai_name);
+
+	elem = tplg_elem_new_common(tplg, NULL, be_tpl->dai_name,
+		SND_TPLG_TYPE_BE_DAI);
+	if (!elem)
+		return -ENOMEM;
+
+	be = elem->be_dai;
+	be->size = elem->size;
+
+	elem_copy_text(be->dai_name, be_tpl->dai_name,
+		SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
+	be->dai_id = be_tpl->dai_id;
+
+	/* stream caps */
+	be->playback = be_tpl->playback;
+	be->capture = be_tpl->capture;
+
+	for (i = 0; i < 2; i++) {
+		if (be_tpl->caps[i])
+			tplg_add_stream_caps(&be->caps[i], be_tpl->caps[i]);
+	}
+
+	/* flags */
+	be->flag_mask = be_tpl->flag_mask;
+	be->flags = be_tpl->flags;
+
+	/* private data */
+	if (be_tpl->priv != NULL) {
+		_be = realloc(be,
+			elem->size + be_tpl->priv->size);
+		if (!_be) {
+			tplg_elem_free(elem);
+			return -ENOMEM;
+		}
+
+		be = _be;
+		be->priv.size = be_tpl->priv->size;
+
+		elem->be_dai = be;
+		elem->size += be->priv.size;
+		memcpy(be->priv.data, be_tpl->priv->data,
+		       be->priv.size);
+	}
+
+	return 0;
+}
diff --git a/src/topology/tplg_local.h b/src/topology/tplg_local.h
index e548ade..dab0162 100644
--- a/src/topology/tplg_local.h
+++ b/src/topology/tplg_local.h
@@ -293,3 +293,4 @@ int tplg_build_pcm(snd_tplg_t *tplg, unsigned int type);
 int tplg_build_link_cfg(snd_tplg_t *tplg, unsigned int type);
 int tplg_add_link_object(snd_tplg_t *tplg, snd_tplg_obj_template_t *t);
 int tplg_add_pcm_object(snd_tplg_t *tplg, snd_tplg_obj_template_t *t);
+int tplg_add_be_dai_object(snd_tplg_t *tplg, snd_tplg_obj_template_t *t);
-- 
2.5.0
