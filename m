From: mengdong.lin@linux.intel.com
Subject: [PATCH 2/9] topology: ABI - Separate PCM & BE/CC link
	support and bump ABI version to 4
Date: Thu,  5 Nov 2015 20:48:30 +0800
Message-ID: <4a14ca621473b0533798bfdf389c7d579c441d88.1446726689.git.mengdong.lin@linux.intel.com>
References: <cover.1446726689.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 1495C265DF6
 for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2015 13:33:04 +0100 (CET)
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

The struct snd_soc_tplg_pcm_dai is renamed to snd_soc_tplg_pcm.
This struct will now be used to handle data related to PCMs
(FE DAI & DAI links). It's not for BE, because BE DAI mappings will be
provided by ACPI/FDT data.

Remove the unused struct snd_soc_tplg_pcm_cfg_caps. We are using
snd_soc_tplg_stream and snd_soc_stream_caps instead.

Define the topology type for BE DAI link: SND_SOC_TPLG_TYPE_BACKEND_LINK.

Define struct snd_soc_tplg_link_config to configure BE & CC links.

Bump ABI version to 4.

Signed-off-by: Vedang Patel <vedang.patel@intel.com>
Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/sound/asoc.h b/include/sound/asoc.h
index c5e08c4..ddc28ce 100644
--- a/include/sound/asoc.h
+++ b/include/sound/asoc.h
@@ -74,7 +74,7 @@
 #define SND_SOC_TPLG_NUM_TEXTS		16
 
 /* ABI version */
-#define SND_SOC_TPLG_ABI_VERSION	0x3
+#define SND_SOC_TPLG_ABI_VERSION	0x4
 
 /* Max size of TLV data */
 #define SND_SOC_TPLG_TLV_SIZE		32
@@ -94,7 +94,8 @@
 #define SND_SOC_TPLG_TYPE_PCM		7
 #define SND_SOC_TPLG_TYPE_MANIFEST	8
 #define SND_SOC_TPLG_TYPE_CODEC_LINK	9
-#define SND_SOC_TPLG_TYPE_PDATA		10
+#define SND_SOC_TPLG_TYPE_BACKEND_LINK	10
+#define SND_SOC_TPLG_TYPE_PDATA		11
 #define SND_SOC_TPLG_TYPE_MAX	SND_SOC_TPLG_TYPE_PDATA
 
 /* vendor block IDs - please add new vendor types to end */
@@ -370,30 +371,46 @@ struct snd_soc_tplg_dapm_widget {
 	 */
 } __attribute__((packed));
 
-struct snd_soc_tplg_pcm_cfg_caps {
-	struct snd_soc_tplg_stream_caps caps;
-	struct snd_soc_tplg_stream_config configs[SND_SOC_TPLG_STREAM_CONFIG_MAX];
-	__le32 num_configs;	/* number of configs */
-} __attribute__((packed));
 
 /*
- * Describes SW/FW specific features of PCM or DAI link.
+ * Describes SW/FW specific features of PCM (FE DAI & DAI link).
  *
- * File block representation for PCM/DAI-Link :-
+ * File block representation for PCM :-
  * +-----------------------------------+-----+
  * | struct snd_soc_tplg_hdr           |  1  |
  * +-----------------------------------+-----+
- * | struct snd_soc_tplg_dapm_pcm_dai  |  N  |
+ * | struct snd_soc_tplg_pcm           |  N  |
  * +-----------------------------------+-----+
  */
-struct snd_soc_tplg_pcm_dai {
+struct snd_soc_tplg_pcm {
 	__le32 size;		/* in bytes of this structure */
-	char name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
-	__le32 id;			/* unique ID - used to match */
-	__le32 playback;		/* supports playback mode */
-	__le32 capture;			/* supports capture mode */
-	__le32 compress;		/* 1 = compressed; 0 = PCM */
-	struct snd_soc_tplg_pcm_cfg_caps capconf[2];	/* capabilities and configs */
+	char pcm_name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
+	char dai_name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
+	__le32 pcm_id;		/* unique ID - used to match */
+	__le32 dai_id;		/* unique ID - used to match */
+	__le32 playback;	/* supports playback mode */
+	__le32 capture;		/* supports capture mode */
+	__le32 compress;	/* 1 = compressed; 0 = PCM */
+	struct snd_soc_tplg_stream stream[SND_SOC_TPLG_STREAM_CONFIG_MAX]; /* for DAI link */
+	__le32 num_streams;	/* number of streams */
+	struct snd_soc_tplg_stream_caps caps[2]; /* playback and capture for DAI */
 } __attribute__((packed));
 
+
+/*
+ * Describes the BE or CC link runtime supported configs or params
+ *
+ * File block representation for BE/CC link config :-
+ * +-----------------------------------+-----+
+ * | struct snd_soc_tplg_hdr           |  1  |
+ * +-----------------------------------+-----+
+ * | struct snd_soc_tplg_link_config   |  N  |
+ * +-----------------------------------+-----+
+ */
+struct snd_soc_tplg_link_config {
+	__le32 size;            /* in bytes of this structure */
+	__le32 id;              /* unique ID - used to match */
+	struct snd_soc_tplg_stream stream[SND_SOC_TPLG_STREAM_CONFIG_MAX]; /* supported configs playback and captrure */
+	__le32 num_streams;     /* number of streams */
+} __attribute__((packed));
 #endif
diff --git a/src/topology/elem.c b/src/topology/elem.c
index d784236..12d6a72 100644
--- a/src/topology/elem.c
+++ b/src/topology/elem.c
@@ -171,7 +171,7 @@ struct tplg_elem* tplg_elem_new_common(snd_tplg_t *tplg,
 		break;
 	case SND_TPLG_TYPE_STREAM_CONFIG:
 		list_add_tail(&elem->list, &tplg->pcm_config_list);
-		obj_size = sizeof(struct snd_soc_tplg_stream_config);
+		obj_size = sizeof(struct snd_soc_tplg_stream);
 		break;
 	case SND_TPLG_TYPE_STREAM_CAPS:
 		list_add_tail(&elem->list, &tplg->pcm_caps_list);
@@ -179,15 +179,15 @@ struct tplg_elem* tplg_elem_new_common(snd_tplg_t *tplg,
 		break;
 	case SND_TPLG_TYPE_PCM:
 		list_add_tail(&elem->list, &tplg->pcm_list);
-		obj_size = sizeof(struct snd_soc_tplg_pcm_dai);
+		obj_size = sizeof(struct snd_soc_tplg_pcm);
 		break;
 	case SND_TPLG_TYPE_BE:
 		list_add_tail(&elem->list, &tplg->be_list);
-		obj_size = sizeof(struct snd_soc_tplg_pcm_dai);
+		obj_size = sizeof(struct snd_soc_tplg_link_config);
 		break;
 	case SND_TPLG_TYPE_CC:
 		list_add_tail(&elem->list, &tplg->cc_list);
-		obj_size = sizeof(struct snd_soc_tplg_pcm_dai);
+		obj_size = sizeof(struct snd_soc_tplg_link_config);
 		break;
 	default:
 		free(elem);
diff --git a/src/topology/parser.c b/src/topology/parser.c
index 6671055..ab5ca1b 100644
--- a/src/topology/parser.c
+++ b/src/topology/parser.c
@@ -116,14 +116,6 @@ static int tplg_parse_config(snd_tplg_t *tplg, snd_config_t *cfg)
 			continue;
 		}
 
-		if (strcmp(id, "SectionPCMConfig") == 0) {
-			err = tplg_parse_compound(tplg, n,
-				tplg_parse_pcm_config, NULL);
-			if (err < 0)
-				return err;
-			continue;
-		}
-
 		if (strcmp(id, "SectionPCMCapabilities") == 0) {
 			err = tplg_parse_compound(tplg, n,
 				tplg_parse_pcm_caps, NULL);
@@ -241,15 +233,15 @@ static int tplg_build_integ(snd_tplg_t *tplg)
 	if (err <  0)
 		return err;
 
-	err = tplg_build_pcm_dai(tplg, SND_TPLG_TYPE_PCM);
+	err = tplg_build_pcm(tplg, SND_TPLG_TYPE_PCM);
 	if (err <  0)
 		return err;
 
-	err = tplg_build_pcm_dai(tplg, SND_TPLG_TYPE_BE);
+	err = tplg_build_link_cfg(tplg, SND_TPLG_TYPE_BE);
 	if (err <  0)
 		return err;
 
-	err = tplg_build_pcm_dai(tplg, SND_TPLG_TYPE_CC);
+	err = tplg_build_link_cfg(tplg, SND_TPLG_TYPE_CC);
 	if (err <  0)
 		return err;
 
diff --git a/src/topology/pcm.c b/src/topology/pcm.c
index 18d5f0b..8559376 100644
--- a/src/topology/pcm.c
+++ b/src/topology/pcm.c
@@ -23,7 +23,7 @@ struct tplg_elem *lookup_pcm_dai_stream(struct list_head *base, const char* id)
 {
 	struct list_head *pos;
 	struct tplg_elem *elem;
-	struct snd_soc_tplg_pcm_dai *pcm_dai;
+	struct snd_soc_tplg_pcm *pcm;
 
 	list_for_each(pos, base) {
 
@@ -31,10 +31,9 @@ struct tplg_elem *lookup_pcm_dai_stream(struct list_head *base, const char* id)
 		if (elem->type != SND_TPLG_TYPE_PCM)
 			return NULL;
 
-		pcm_dai = elem->pcm;
+		pcm = elem->pcm;
 
-		if (pcm_dai && (!strcmp(pcm_dai->capconf[0].caps.name, id)
-			|| !strcmp(pcm_dai->capconf[1].caps.name, id)))
+		if (pcm && !strcmp(pcm->dai_name, id))
 			return elem;
 	}
 
@@ -53,84 +52,38 @@ static void copy_pcm_caps(const char *id, struct snd_soc_tplg_stream_caps *caps,
 	*caps =  *ref_caps;
 }
 
-/* copy referenced config to the pcm */
-static void copy_pcm_config(const char *id,
-	struct snd_soc_tplg_stream_config *cfg, struct tplg_elem *ref_elem)
-{
-	struct snd_soc_tplg_stream_config *ref_cfg = ref_elem->stream_cfg;
-
-	tplg_dbg("Copy pcm config (%ld bytes) from '%s' to '%s' \n",
-		sizeof(*cfg), ref_elem->id, id);
-
-	*cfg = *ref_cfg;
-}
-
 /* check referenced config and caps for a pcm */
-static int tplg_build_pcm_cfg_caps(snd_tplg_t *tplg, struct tplg_elem *elem)
+static int tplg_build_pcm_caps(snd_tplg_t *tplg, struct tplg_elem *elem)
 {
 	struct tplg_elem *ref_elem = NULL;
-	struct snd_soc_tplg_pcm_cfg_caps *capconf;
-	struct snd_soc_tplg_pcm_dai *pcm_dai;
-	unsigned int i, j;
+	struct snd_soc_tplg_pcm *pcm;
+	struct snd_soc_tplg_stream_caps *caps;
+	struct snd_soc_tplg_stream *stream;
+	unsigned int i;
 
-	switch (elem->type) {
-	case SND_TPLG_TYPE_PCM:
-		pcm_dai = elem->pcm;
-		break;
-	case SND_TPLG_TYPE_BE:
-		pcm_dai = elem->be;
-		break;
-	case SND_TPLG_TYPE_CC:
-		pcm_dai = elem->cc;
-		break;
-	default:
-		return -EINVAL;
-	}
+	pcm = elem->pcm;
 
 	for (i = 0; i < 2; i++) {
-		capconf = &pcm_dai->capconf[i];
+		caps = &pcm->caps[i];
 
 		ref_elem = tplg_elem_lookup(&tplg->pcm_caps_list,
-			capconf->caps.name, SND_TPLG_TYPE_STREAM_CAPS);
+			caps->name, SND_TPLG_TYPE_STREAM_CAPS);
 
 		if (ref_elem != NULL)
-			copy_pcm_caps(elem->id, &capconf->caps, ref_elem);
-
-		for (j = 0; j < capconf->num_configs; j++) {
-			ref_elem = tplg_elem_lookup(&tplg->pcm_config_list,
-				capconf->configs[j].name,
-				SND_TPLG_TYPE_STREAM_CONFIG);
-
-			if (ref_elem != NULL)
-				copy_pcm_config(elem->id,
-					&capconf->configs[j],
-					ref_elem);
-		}
+			copy_pcm_caps(elem->id, caps, ref_elem);
 	}
 
 	return 0;
 }
 
-int tplg_build_pcm_dai(snd_tplg_t *tplg, unsigned int type)
+/* build FE DAI/PCM configurations */
+int tplg_build_pcm(snd_tplg_t *tplg, unsigned int type)
 {
 	struct list_head *base, *pos;
 	struct tplg_elem *elem;
 	int err = 0;
 
-	switch (type) {
-	case SND_TPLG_TYPE_PCM:
-		base = &tplg->pcm_list;
-		break;
-	case SND_TPLG_TYPE_BE:
-		base = &tplg->be_list;
-		break;
-	case SND_TPLG_TYPE_CC:
-		base = &tplg->cc_list;
-		break;
-	default:
-		return -EINVAL;
-	}
-
+	base = &tplg->pcm_list;
 	list_for_each(pos, base) {
 
 		elem = list_entry(pos, struct tplg_elem, list);
@@ -139,7 +92,7 @@ int tplg_build_pcm_dai(snd_tplg_t *tplg, unsigned int type)
 			return -EINVAL;
 		}
 
-		err = tplg_build_pcm_cfg_caps(tplg, elem);
+		err = tplg_build_pcm_caps(tplg, elem);
 		if (err < 0)
 			return err;
 	}
@@ -147,113 +100,61 @@ int tplg_build_pcm_dai(snd_tplg_t *tplg, unsigned int type)
 	return 0;
 }
 
-/* PCM stream configuration */
-static int tplg_parse_stream_cfg(snd_tplg_t *tplg ATTRIBUTE_UNUSED,
-	snd_config_t *cfg, void *private)
+static int tplg_build_stream_cfg(snd_tplg_t *tplg,
+	struct snd_soc_tplg_stream *stream, int num_streams)
 {
-	snd_config_iterator_t i, next;
-	snd_config_t *n;
-	struct snd_soc_tplg_stream_config *sc = private;
-	struct snd_soc_tplg_stream *stream;
-	const char *id, *val;
-	snd_pcm_format_t format;
+	struct snd_soc_tplg_stream *strm;
+	struct tplg_elem *ref_elem;
+	int i;
 
-	snd_config_get_id(cfg, &id);
-
-	if (strcmp(id, "playback") == 0)
-		stream = &sc->playback;
-	else if (strcmp(id, "capture") == 0)
-		stream = &sc->capture;
-	else
-		return -EINVAL;
-
-	tplg_dbg("\t%s:\n", id);
+	for (i = 0; i < num_streams; i++) {
+		strm = stream + i;
+		ref_elem = tplg_elem_lookup(&tplg->pcm_config_list,
+			strm->name, SND_TPLG_TYPE_STREAM_CONFIG);
 
-	stream->size = sizeof(*stream);
-
-	snd_config_for_each(i, next, cfg) {
-
-		n = snd_config_iterator_entry(i);
-
-		if (snd_config_get_id(n, &id) < 0)
-			return -EINVAL;
-
-		if (snd_config_get_string(n, &val) < 0)
-			return -EINVAL;
-
-		if (strcmp(id, "format") == 0) {
-			format = snd_pcm_format_value(val);
-			if (format == SND_PCM_FORMAT_UNKNOWN) {
-				SNDERR("error: unsupported stream format %s\n",
-					val);
-				return -EINVAL;
-			}
-
-			stream->format = format;
-			tplg_dbg("\t\t%s: %s\n", id, val);
-			continue;
-		}
-
-		if (strcmp(id, "rate") == 0) {
-			stream->rate = atoi(val);
-			tplg_dbg("\t\t%s: %d\n", id, stream->rate);
-			continue;
-		}
-
-		if (strcmp(id, "channels") == 0) {
-			stream->channels = atoi(val);
-			tplg_dbg("\t\t%s: %d\n", id, stream->channels);
-			continue;
-		}
-
-		if (strcmp(id, "tdm_slot") == 0) {
-			stream->tdm_slot = strtol(val, NULL, 16);
-			tplg_dbg("\t\t%s: 0x%x\n", id, stream->tdm_slot);
-			continue;
-		}
+		if (ref_elem && ref_elem->stream_cfg)
+			*strm = *ref_elem->stream_cfg;
 	}
 
 	return 0;
 }
 
-/* Parse pcm configuration */
-int tplg_parse_pcm_config(snd_tplg_t *tplg,
-	snd_config_t *cfg, void *private ATTRIBUTE_UNUSED)
+/* build BE/CC DAI link configurations */
+int tplg_build_link_cfg(snd_tplg_t *tplg, unsigned int type)
 {
-	struct snd_soc_tplg_stream_config *sc;
+	struct list_head *base, *pos;
 	struct tplg_elem *elem;
-	snd_config_iterator_t i, next;
-	snd_config_t *n;
-	const char *id;
-	int err;
-
-	elem = tplg_elem_new_common(tplg, cfg, NULL, SND_TPLG_TYPE_STREAM_CONFIG);
-	if (!elem)
-		return -ENOMEM;
+	struct snd_soc_tplg_link_config *link;
+	int err = 0;
 
-	sc = elem->stream_cfg;
-	sc->size = elem->size;
+	switch (type) {
+	case SND_TPLG_TYPE_BE:
+		base = &tplg->be_list;
+		break;
+	case SND_TPLG_TYPE_CC:
+		base = &tplg->cc_list;
+		break;
+	default:
+		return -EINVAL;
+	}
 
-	tplg_dbg(" PCM Config: %s\n", elem->id);
+	list_for_each(pos, base) {
 
-	snd_config_for_each(i, next, cfg) {
-		n = snd_config_iterator_entry(i);
-		if (snd_config_get_id(n, &id) < 0)
-			continue;
+		elem = list_entry(pos, struct tplg_elem, list);
+		if (elem->type != type) {
+			SNDERR("error: invalid elem '%s'\n", elem->id);
+			return -EINVAL;
+		}
 
-		/* skip comments */
-		if (strcmp(id, "comment") == 0)
-			continue;
-		if (id[0] == '#')
-			continue;
+		if (type == SND_TPLG_TYPE_BE)
+			link = elem->be;
+		else
+			link = elem->cc;
 
-		if (strcmp(id, "config") == 0) {
-			err = tplg_parse_compound(tplg, n,
-				tplg_parse_stream_cfg, sc);
-			if (err < 0)
-				return err;
-			continue;
-		}
+		err = tplg_build_stream_cfg(tplg, link->stream,
+			link->num_streams);
+		if (err < 0)
+			return err;
 	}
 
 	return 0;
@@ -360,49 +261,18 @@ int tplg_parse_pcm_caps(snd_tplg_t *tplg,
 	return 0;
 }
 
-static int tplg_parse_pcm_cfg(snd_tplg_t *tplg ATTRIBUTE_UNUSED,
-	snd_config_t *cfg, void *private)
-{
-	struct snd_soc_tplg_pcm_cfg_caps *capconf = private;
-	struct snd_soc_tplg_stream_config *configs = capconf->configs;
-	unsigned int *num_configs = &capconf->num_configs;
-	const char *value;
-
-	if (*num_configs == SND_SOC_TPLG_STREAM_CONFIG_MAX)
-		return -EINVAL;
-
-	if (snd_config_get_string(cfg, &value) < 0)
-		return EINVAL;
-
-	elem_copy_text(configs[*num_configs].name, value,
-		SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
-
-	*num_configs += 1;
-
-	tplg_dbg("\t\t\t%s\n", value);
-
-	return 0;
-}
-
-/* Parse the cap and config of a pcm */
-int tplg_parse_pcm_cap_cfg(snd_tplg_t *tplg, snd_config_t *cfg,
+/* Parse the caps of a pcm stream */
+int tplg_parse_stream_caps(snd_tplg_t *tplg, snd_config_t *cfg,
 	void *private)
 {
 	snd_config_iterator_t i, next;
 	snd_config_t *n;
 	struct tplg_elem *elem = private;
-	struct snd_soc_tplg_pcm_dai *pcm_dai;
+	struct snd_soc_tplg_pcm *pcm;
 	const char *id, *value;
 	int err, stream;
 
-	if (elem->type == SND_TPLG_TYPE_PCM)
-		pcm_dai = elem->pcm;
-	else if (elem->type == SND_TPLG_TYPE_BE)
-		pcm_dai = elem->be;
-	else if (elem->type == SND_TPLG_TYPE_CC)
-		pcm_dai = elem->cc;
-	else
-		return -EINVAL;
+	pcm = elem->pcm;
 
 	snd_config_get_id(cfg, &id);
 
@@ -410,10 +280,10 @@ int tplg_parse_pcm_cap_cfg(snd_tplg_t *tplg, snd_config_t *cfg,
 
 	if (strcmp(id, "playback") == 0) {
 		stream = SND_SOC_TPLG_STREAM_PLAYBACK;
-		pcm_dai->playback = 1;
+		pcm->playback = 1;
 	} else if (strcmp(id, "capture") == 0) {
 		stream = SND_SOC_TPLG_STREAM_CAPTURE;
-		pcm_dai->capture = 1;
+		pcm->capture = 1;
 	} else
 		return -EINVAL;
 
@@ -429,21 +299,12 @@ int tplg_parse_pcm_cap_cfg(snd_tplg_t *tplg, snd_config_t *cfg,
 			if (snd_config_get_string(n, &value) < 0)
 				continue;
 
-			elem_copy_text(pcm_dai->capconf[stream].caps.name, value,
+			elem_copy_text(pcm->caps[stream].name, value,
 				SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
 
 			tplg_dbg("\t\t%s\n\t\t\t%s\n", id, value);
 			continue;
 		}
-
-		if (strcmp(id, "configs") == 0) {
-			tplg_dbg("\t\tconfigs:\n");
-			err = tplg_parse_compound(tplg, n, tplg_parse_pcm_cfg,
-				&pcm_dai->capconf[stream]);
-			if (err < 0)
-				return err;
-			continue;
-		}
 	}
 
 	return 0;
@@ -453,7 +314,7 @@ int tplg_parse_pcm_cap_cfg(snd_tplg_t *tplg, snd_config_t *cfg,
 int tplg_parse_pcm(snd_tplg_t *tplg,
 	snd_config_t *cfg, void *private ATTRIBUTE_UNUSED)
 {
-	struct snd_soc_tplg_pcm_dai *pcm_dai;
+	struct snd_soc_tplg_pcm *pcm;
 	struct tplg_elem *elem;
 	snd_config_iterator_t i, next;
 	snd_config_t *n;
@@ -464,9 +325,9 @@ int tplg_parse_pcm(snd_tplg_t *tplg,
 	if (!elem)
 		return -ENOMEM;
 
-	pcm_dai = elem->pcm;
-	pcm_dai->size = elem->size;
-	elem_copy_text(pcm_dai->name, elem->id, SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
+	pcm = elem->pcm;
+	pcm->size = elem->size;
+	elem_copy_text(pcm->dai_name, elem->id, SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
 
 	tplg_dbg(" PCM: %s\n", elem->id);
 
@@ -495,14 +356,14 @@ int tplg_parse_pcm(snd_tplg_t *tplg,
 			if (snd_config_get_string(n, &val) < 0)
 				return -EINVAL;
 
-			pcm_dai->id = atoi(val);
-			tplg_dbg("\t%s: %d\n", id, pcm_dai->id);
+			pcm->dai_id = atoi(val);
+			tplg_dbg("\t%s: %d\n", id, pcm->dai_id);
 			continue;
 		}
 
 		if (strcmp(id, "pcm") == 0) {
 			err = tplg_parse_compound(tplg, n,
-				tplg_parse_pcm_cap_cfg, elem);
+				tplg_parse_stream_caps, elem);
 			if (err < 0)
 				return err;
 			continue;
@@ -512,11 +373,10 @@ int tplg_parse_pcm(snd_tplg_t *tplg,
 	return 0;
 }
 
-/* Parse be */
 int tplg_parse_be(snd_tplg_t *tplg,
 	snd_config_t *cfg, void *private ATTRIBUTE_UNUSED)
 {
-	struct snd_soc_tplg_pcm_dai *pcm_dai;
+	struct snd_soc_tplg_link_config *link;
 	struct tplg_elem *elem;
 	snd_config_iterator_t i, next;
 	snd_config_t *n;
@@ -527,9 +387,8 @@ int tplg_parse_be(snd_tplg_t *tplg,
 	if (!elem)
 		return -ENOMEM;
 
-	pcm_dai = elem->be;
-	pcm_dai->size = elem->size;
-	elem_copy_text(pcm_dai->name, elem->id, SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
+	link = elem->be;
+	link->size = elem->size;
 
 	tplg_dbg(" BE: %s\n", elem->id);
 
@@ -558,16 +417,8 @@ int tplg_parse_be(snd_tplg_t *tplg,
 			if (snd_config_get_string(n, &val) < 0)
 				return -EINVAL;
 
-			pcm_dai->id = atoi(val);
-			tplg_dbg("\t%s: %d\n", id, pcm_dai->id);
-			continue;
-		}
-
-		if (strcmp(id, "be") == 0) {
-			err = tplg_parse_compound(tplg, n,
-				tplg_parse_pcm_cap_cfg, elem);
-			if (err < 0)
-				return err;
+			link->id = atoi(val);
+			tplg_dbg("\t%s: %d\n", id, link->id);
 			continue;
 		}
 	}
@@ -579,7 +430,7 @@ int tplg_parse_be(snd_tplg_t *tplg,
 int tplg_parse_cc(snd_tplg_t *tplg,
 	snd_config_t *cfg, void *private ATTRIBUTE_UNUSED)
 {
-	struct snd_soc_tplg_pcm_dai *pcm_dai;
+	struct snd_soc_tplg_link_config *link;
 	struct tplg_elem *elem;
 	snd_config_iterator_t i, next;
 	snd_config_t *n;
@@ -590,8 +441,8 @@ int tplg_parse_cc(snd_tplg_t *tplg,
 	if (!elem)
 		return -ENOMEM;
 
-	pcm_dai = elem->cc;
-	pcm_dai->size = elem->size;
+	link = elem->cc;
+	link->size = elem->size;
 
 	tplg_dbg(" CC: %s\n", elem->id);
 
@@ -620,18 +471,11 @@ int tplg_parse_cc(snd_tplg_t *tplg,
 			if (snd_config_get_string(n, &val) < 0)
 				return -EINVAL;
 
-			pcm_dai->id = atoi(val);
-			tplg_dbg("\t%s: %d\n", id, pcm_dai->id);
+			link->id = atoi(val);
+			tplg_dbg("\t%s: %d\n", id, link->id);
 			continue;
 		}
 
-		if (strcmp(id, "cc") == 0) {
-			err = tplg_parse_compound(tplg, n,
-				tplg_parse_pcm_cap_cfg, elem);
-			if (err < 0)
-				return err;
-			continue;
-		}
 	}
 
 	return 0;
diff --git a/src/topology/tplg_local.h b/src/topology/tplg_local.h
index d2b9aa6..e9c8e29 100644
--- a/src/topology/tplg_local.h
+++ b/src/topology/tplg_local.h
@@ -108,11 +108,11 @@ struct tplg_elem {
 		struct snd_soc_tplg_enum_control *enum_ctrl;
 		struct snd_soc_tplg_bytes_control *bytes_ext;
 		struct snd_soc_tplg_dapm_widget *widget;
-		struct snd_soc_tplg_pcm_dai *pcm;
-		struct snd_soc_tplg_pcm_dai *be;
-		struct snd_soc_tplg_pcm_dai *cc;
+		struct snd_soc_tplg_pcm *pcm;
+		struct snd_soc_tplg_link_config *be;
+		struct snd_soc_tplg_link_config *cc;
 		struct snd_soc_tplg_dapm_graph_elem *route;
-		struct snd_soc_tplg_stream_config *stream_cfg;
+		struct snd_soc_tplg_stream *stream_cfg;
 		struct snd_soc_tplg_stream_caps *stream_caps;
 
 		/* these do not map to UAPI structs but are internal only */
@@ -164,15 +164,9 @@ int tplg_parse_dapm_graph(snd_tplg_t *tplg, snd_config_t *cfg,
 int tplg_parse_dapm_widget(snd_tplg_t *tplg,
 	snd_config_t *cfg, void *private ATTRIBUTE_UNUSED);
 
-int tplg_parse_pcm_config(snd_tplg_t *tplg,
-	snd_config_t *cfg, void *private ATTRIBUTE_UNUSED);
-
 int tplg_parse_pcm_caps(snd_tplg_t *tplg,
 	snd_config_t *cfg, void *private ATTRIBUTE_UNUSED);
 
-int tplg_parse_pcm_cap_cfg(snd_tplg_t *tplg, snd_config_t *cfg,
-	void *private);
-
 int tplg_parse_pcm(snd_tplg_t *tplg,
 	snd_config_t *cfg, void *private ATTRIBUTE_UNUSED);
 
-- 
1.9.1
