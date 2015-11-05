From: mengdong.lin@linux.intel.com
Subject: [PATCH 8/9] topology: Add C API support for BE and CC
	Links.
Date: Thu,  5 Nov 2015 20:49:23 +0800
Message-ID: <6445f5d02d43e4707c21d35fa57b30bc8f361880.1446726689.git.mengdong.lin@linux.intel.com>
References: <cover.1446726689.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 91F25265EB3
 for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2015 13:33:57 +0100 (CET)
In-Reply-To: <cover.1446726689.git.mengdong.lin@linux.intel.com>
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, mengdong.lin@intel.com, vinod.koul@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com, subhransu.s.prusty@intel.com, Vedang Patel <vedang.patel@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Vedang Patel <vedang.patel@intel.com>

Adding BE and CC Link support for C API reference. This will be used
to populate the .hw_params element for BE and .params for CC, enabling
us to update already existing DAI Links created by the kernel.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/topology.h b/include/topology.h
index 9b84bd9..ccd69d7 100644
--- a/include/topology.h
+++ b/include/topology.h
@@ -648,6 +648,28 @@ struct snd_tplg_widget_template {
 	struct snd_tplg_ctl_template *ctl[0];	/*!< array of widget controls */
 };
 
+/** \struct snd_tplg_stream_template
+ * \brief Stream configurations.
+ */
+struct snd_tplg_stream_template {
+	const char *name;	/*!< name of the stream config */
+	int format;		/*!< SNDRV_PCM_FMTBIT_* */
+	int rate;		/*!< SNDRV_PCM_RATE_* */
+	int period_bytes;	/*!< size of period in bytes */
+	int buffer_bytes;	/*!< size of buffer in bytes. */
+	int channels;		/*!< number of channels */
+};
+
+/** \struct snd_tplg_link_template
+ * \brief Template type for BE and CC DAI Links.
+ */
+struct snd_tplg_link_template {
+	const char *name;	/*!< link name */
+	int id;	/*!< unique ID - used to match with existing BE and CC links */
+	int num_streams;	/*!< number of configs */
+	struct snd_tplg_stream_template stream[0]; /*!< supported configs */
+};
+
 /** \struct snd_tplg_obj_template
  * \brief Generic Template Object
  */
@@ -662,6 +684,7 @@ typedef struct snd_tplg_obj_template {
 		struct snd_tplg_bytes_template *bytes_ctl;	/*!< Bytes control */
 		struct snd_tplg_enum_template *enum_ctl;	/*!< Enum control */
 		struct snd_tplg_graph_template *graph;		/*!< Graph elements */
+		struct snd_tplg_link_template *link;		/*!< BE and CC Links */
 	};
 } snd_tplg_obj_template_t;
 
diff --git a/src/topology/builder.c b/src/topology/builder.c
index 8d57a8b..154bd63 100644
--- a/src/topology/builder.c
+++ b/src/topology/builder.c
@@ -221,10 +221,10 @@ static int write_block(snd_tplg_t *tplg, struct list_head *base,
 			SND_SOC_TPLG_TYPE_PCM, "pcm");
 	case SND_TPLG_TYPE_BE:
 		return write_elem_block(tplg, base, size,
-			SND_SOC_TPLG_TYPE_DAI_LINK, "be");
+			SND_SOC_TPLG_TYPE_BACKEND_LINK, "be");
 	case SND_TPLG_TYPE_CC:
 		return write_elem_block(tplg, base, size,
-			SND_SOC_TPLG_TYPE_DAI_LINK, "cc");
+			SND_SOC_TPLG_TYPE_CODEC_LINK, "cc");
 	case SND_TPLG_TYPE_DATA:
 		return write_elem_block(tplg, base, size,
 			SND_SOC_TPLG_TYPE_PDATA, "data");
diff --git a/src/topology/parser.c b/src/topology/parser.c
index ab5ca1b..1851459 100644
--- a/src/topology/parser.c
+++ b/src/topology/parser.c
@@ -311,6 +311,9 @@ int snd_tplg_add_object(snd_tplg_t *tplg, snd_tplg_obj_template_t *t)
 		return tplg_add_widget_object(tplg, t);
 	case SND_TPLG_TYPE_DAPM_GRAPH:
 		return tplg_add_graph_object(tplg, t);
+	case SND_TPLG_TYPE_BE:
+	case SND_TPLG_TYPE_CC:
+		return tplg_add_link_object(tplg, t);
 	default:
 		SNDERR("error: invalid object type %d\n", t->type);
 		return -EINVAL;
diff --git a/src/topology/pcm.c b/src/topology/pcm.c
index ec26f9c..c2b2b98 100644
--- a/src/topology/pcm.c
+++ b/src/topology/pcm.c
@@ -480,3 +480,49 @@ int tplg_parse_cc(snd_tplg_t *tplg,
 
 	return 0;
 }
+
+/* copy stream object */
+static void tplg_add_stream_object(struct snd_soc_tplg_stream *strm,
+				struct snd_tplg_stream_template *strm_tpl)
+{
+	elem_copy_text(strm->name, strm_tpl->name,
+		SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
+	strm->format = strm_tpl->format;
+	strm->rate = strm_tpl->rate;
+	strm->period_bytes = strm_tpl->period_bytes;
+	strm->buffer_bytes = strm_tpl->buffer_bytes;
+	strm->channels = strm_tpl->channels;
+}
+
+int tplg_add_link_object(snd_tplg_t *tplg, snd_tplg_obj_template_t *t)
+{
+	struct snd_tplg_link_template *link = t->link;
+	struct snd_soc_tplg_link_config *lk;
+	struct tplg_elem *elem;
+	int i;
+
+	if (t->type != SND_TPLG_TYPE_BE && t->type != SND_TPLG_TYPE_CC)
+		return -EINVAL;
+
+	/* here type can be either BE or CC. */
+	elem = tplg_elem_new_common(tplg, NULL, link->name, t->type);
+	if (!elem)
+		return -ENOMEM;
+
+	if (t->type == SND_TPLG_TYPE_BE) {
+		tplg_dbg("BE Link: %s", link->name);
+		lk = elem->be;
+	} else {
+		tplg_dbg("CC Link: %s", link->name);
+		lk = elem->cc;
+	}
+
+	lk->size = elem->size;
+	lk->id = link->id;
+	lk->num_streams = link->num_streams;
+
+	for (i = 0; i < lk->num_streams; i++)
+		tplg_add_stream_object(&lk->stream[i], &link->stream[i]);
+
+	return 0;
+}
-- 
1.9.1
