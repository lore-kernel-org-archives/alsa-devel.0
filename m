From: mengdong.lin@linux.intel.com
Subject: [PATCH 5/6] topology: Parse and build private data for
	PCM
Date: Fri,  4 Nov 2016 07:08:12 +0800
Message-ID: <ffae623ead96e1063e7301769c977f97a35ea1fa.1478212626.git.mengdong.lin@linux.intel.com>
References: <cover.1478212626.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id C2D3E267356
 for <alsa-devel@alsa-project.org>; Fri,  4 Nov 2016 00:06:59 +0100 (CET)
In-Reply-To: <cover.1478212626.git.mengdong.lin@linux.intel.com>
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

From: Mengdong Lin <mengdong.lin@linux.intel.com>

Users can define private for PCM (FE DAI & DAI links) elements by both
text conf file and C API:

- Text conf file may define multiple data blocks for a PCM and they will
  be merged in building phase;

- Add private data to C API template of PCM object.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/topology.h b/include/topology.h
index b6a6f19..481b408 100644
--- a/include/topology.h
+++ b/include/topology.h
@@ -611,6 +611,8 @@ extern "C" {
  *	symmetric_rates			"true"
  *	symmetric_channels		"true"
  *	symmetric_sample_bits		"false"
+ *
+ *	data "name"			# optional private data
  * }
  * </pre>
  *
@@ -870,6 +872,7 @@ struct snd_tplg_pcm_template {
 	struct snd_tplg_stream_caps_template *caps[2]; /*!< playback & capture for DAI */
 	unsigned int flag_mask; /*!< bitmask of flags to configure */
 	unsigned int flags;     /*!< flag value SND_SOC_TPLG_LNK_FLGBIT_* */
+	struct snd_soc_tplg_private *priv;	/*!< private data */
 	int num_streams;	/*!< number of supported configs */
 	struct snd_tplg_stream_template stream[0]; /*!< supported configs */
 };
diff --git a/src/topology/pcm.c b/src/topology/pcm.c
index 77b7605..3f54e94 100644
--- a/src/topology/pcm.c
+++ b/src/topology/pcm.c
@@ -73,12 +73,32 @@ static int tplg_build_stream_caps(snd_tplg_t *tplg,
 /* build a PCM (FE DAI & DAI link) element */
 static int build_pcm(snd_tplg_t *tplg, struct tplg_elem *elem)
 {
+	struct tplg_ref *ref;
+	struct list_head *base, *pos;
 	int err;
 
 	err = tplg_build_stream_caps(tplg, elem->id, elem->pcm->caps);
 		if (err < 0)
 			return err;
 
+	/* merge private data from the referenced data elements */
+	base = &elem->ref_list;
+	list_for_each(pos, base) {
+
+		ref = list_entry(pos, struct tplg_ref, list);
+		if (ref->type == SND_TPLG_TYPE_DATA) {
+			err = tplg_copy_data(tplg, elem, ref);
+			if (err < 0)
+				return err;
+		}
+		if (!ref->elem) {
+			SNDERR("error: cannot find '%s' referenced by"
+				" PCM '%s'\n", ref->id, elem->id);
+			return -EINVAL;
+		} else if (err < 0)
+			return err;
+	}
+
 	return 0;
 }
 
@@ -394,7 +414,7 @@ static int parse_flag(snd_config_t *n, unsigned int mask_in,
 	return 0;
 }
 
-/* Parse pcm (for front end DAI & DAI link) */
+/* Parse PCM (for front end DAI & DAI link) in text conf file */
 int tplg_parse_pcm(snd_tplg_t *tplg,
 	snd_config_t *cfg, void *private ATTRIBUTE_UNUSED)
 {
@@ -501,6 +521,7 @@ int tplg_parse_be(snd_tplg_t *tplg,
 	snd_config_iterator_t i, next;
 	snd_config_t *n;
 	const char *id, *val = NULL;
+	int err;
 
 	elem = tplg_elem_new_common(tplg, cfg, NULL, SND_TPLG_TYPE_BE);
 	if (!elem)
@@ -540,6 +561,13 @@ int tplg_parse_be(snd_tplg_t *tplg,
 			tplg_dbg("\t%s: %d\n", id, link->id);
 			continue;
 		}
+
+		if (strcmp(id, "data") == 0) {
+			err = tplg_parse_data_refs(n, elem);
+			if (err < 0)
+				return err;
+			continue;
+		}
 	}
 
 	return 0;
@@ -633,10 +661,11 @@ static void tplg_add_stream_caps(struct snd_soc_tplg_stream_caps *caps,
 	caps->sig_bits = caps_tpl->sig_bits;
 }
 
+/* Add a PCM element (FE DAI & DAI link) from C API */
 int tplg_add_pcm_object(snd_tplg_t *tplg, snd_tplg_obj_template_t *t)
 {
 	struct snd_tplg_pcm_template *pcm_tpl = t->pcm;
-	struct snd_soc_tplg_pcm *pcm;
+	struct snd_soc_tplg_pcm *pcm, *_pcm;
 	struct tplg_elem *elem;
 	int i;
 
@@ -675,6 +704,25 @@ int tplg_add_pcm_object(snd_tplg_t *tplg, snd_tplg_obj_template_t *t)
 	for (i = 0; i < pcm_tpl->num_streams; i++)
 		tplg_add_stream_object(&pcm->stream[i], &pcm_tpl->stream[i]);
 
+	/* private data */
+	if (pcm_tpl->priv != NULL && pcm_tpl->priv->size) {
+		tplg_dbg("\t priv data size %d\n", pcm_tpl->priv->size);
+		_pcm = realloc(pcm,
+			elem->size + pcm_tpl->priv->size);
+		if (!_pcm) {
+			tplg_elem_free(elem);
+			return -ENOMEM;
+		}
+
+		pcm = _pcm;
+		elem->pcm = pcm;
+		elem->size += pcm_tpl->priv->size;
+
+		memcpy(pcm->priv.data, pcm_tpl->priv->data,
+			pcm_tpl->priv->size);
+		pcm->priv.size = pcm_tpl->priv->size;
+	}
+
 	return 0;
 }
 
-- 
2.7.4
