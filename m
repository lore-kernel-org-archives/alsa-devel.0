From: mengdong.lin@linux.intel.com
Subject: [PATCH 21/22] topology: Support configuring physical
	DAIs by C API
Date: Thu, 27 Oct 2016 15:15:11 +0800
Message-ID: <3d1bf6bfae560f90dac949ea5e64aeffbbf8df92.1477549962.git.mengdong.lin@linux.intel.com>
References: <cover.1477549962.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 083202672C7
 for <alsa-devel@alsa-project.org>; Thu, 27 Oct 2016 09:13:58 +0200 (CEST)
In-Reply-To: <cover.1477549962.git.mengdong.lin@linux.intel.com>
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

From: Guneshwor Singh <guneshwor.o.singh@intel.com>

In addition to text conf file, BE (Back End) DAI configurations can
also be added by C API. This patch defines the template to add BE DAI
configurations from C API.

Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/topology.h b/include/topology.h
index c0a4f07..7b0f3ad 100644
--- a/include/topology.h
+++ b/include/topology.h
@@ -987,6 +987,21 @@ struct snd_tplg_hw_config_template {
 	unsigned int *rx_chanmap;       /* array of slot number */
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
@@ -1023,6 +1038,7 @@ typedef struct snd_tplg_obj_template {
 		struct snd_tplg_graph_template *graph;		/*!< Graph elements */
 		struct snd_tplg_pcm_template *pcm;		/*!< PCM elements */
 		struct snd_tplg_link_template *link;		/*!< BE and CC Links */
+		struct snd_tplg_be_dai_template *dai;		/*!< Physical DAI */
 	};
 } snd_tplg_obj_template_t;
 
diff --git a/src/topology/parser.c b/src/topology/parser.c
index 72efef4..4afa576 100644
--- a/src/topology/parser.c
+++ b/src/topology/parser.c
@@ -364,6 +364,8 @@ int snd_tplg_add_object(snd_tplg_t *tplg, snd_tplg_obj_template_t *t)
 		return tplg_add_graph_object(tplg, t);
 	case SND_TPLG_TYPE_PCM:
 		return tplg_add_pcm_object(tplg, t);
+	case SND_TPLG_TYPE_DAI:
+		return tplg_add_dai_object(tplg, t);
 	case SND_TPLG_TYPE_LINK:
 	case SND_TPLG_TYPE_BE:
 	case SND_TPLG_TYPE_CC:
diff --git a/src/topology/pcm.c b/src/topology/pcm.c
index b255978..e1d266a 100644
--- a/src/topology/pcm.c
+++ b/src/topology/pcm.c
@@ -1235,3 +1235,58 @@ int tplg_add_link_object(snd_tplg_t *tplg, snd_tplg_obj_template_t *t)
 
 	return 0;
 }
+
+int tplg_add_dai_object(snd_tplg_t *tplg, snd_tplg_obj_template_t *t)
+{
+	struct snd_tplg_be_dai_template *dai_tpl = t->dai;
+	struct snd_soc_tplg_dai *dai, *_dai;
+	struct tplg_elem *elem;
+	int i;
+
+	tplg_dbg("DAI %s\n", dai_tpl->dai_name);
+
+	elem = tplg_elem_new_common(tplg, NULL, dai_tpl->dai_name,
+		SND_TPLG_TYPE_DAI);
+	if (!elem)
+		return -ENOMEM;
+
+	dai = elem->dai;
+	dai->size = elem->size;
+
+	elem_copy_text(dai->dai_name, dai_tpl->dai_name,
+		SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
+	dai->dai_id = dai_tpl->dai_id;
+
+	/* stream caps */
+	dai->playback = dai_tpl->playback;
+	dai->capture = dai_tpl->capture;
+
+	for (i = 0; i < 2; i++) {
+		if (dai_tpl->caps[i])
+			tplg_add_stream_caps(&dai->caps[i], dai_tpl->caps[i]);
+	}
+
+	/* flags */
+	dai->flag_mask = dai_tpl->flag_mask;
+	dai->flags = dai_tpl->flags;
+
+	/* private data */
+	if (dai_tpl->priv != NULL) {
+		_dai = realloc(dai,
+			elem->size + dai_tpl->priv->size);
+		if (!_dai) {
+			tplg_elem_free(elem);
+			return -ENOMEM;
+		}
+
+		dai = _dai;
+		dai->priv.size = dai_tpl->priv->size;
+
+		elem->dai = dai;
+		elem->size += dai->priv.size;
+		memcpy(dai->priv.data, dai_tpl->priv->data,
+		       dai->priv.size);
+	}
+
+	return 0;
+}
diff --git a/src/topology/tplg_local.h b/src/topology/tplg_local.h
index eeeb0f1..807462b 100644
--- a/src/topology/tplg_local.h
+++ b/src/topology/tplg_local.h
@@ -297,3 +297,4 @@ int tplg_build_pcms(snd_tplg_t *tplg, unsigned int type);
 int tplg_build_links(snd_tplg_t *tplg, unsigned int type);
 int tplg_add_link_object(snd_tplg_t *tplg, snd_tplg_obj_template_t *t);
 int tplg_add_pcm_object(snd_tplg_t *tplg, snd_tplg_obj_template_t *t);
+int tplg_add_dai_object(snd_tplg_t *tplg, snd_tplg_obj_template_t *t);
-- 
2.5.0
