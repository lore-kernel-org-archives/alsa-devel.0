From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH 1/3] topology: Add C templates structure for
	building topology from C programs
Date: Fri,  7 Aug 2015 17:03:52 +0100
Message-ID: <1438963434-6407-2-git-send-email-liam.r.girdwood@linux.intel.com>
References: <1438963434-6407-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 13CEA26062A
 for <alsa-devel@alsa-project.org>; Fri,  7 Aug 2015 18:04:00 +0200 (CEST)
In-Reply-To: <1438963434-6407-1-git-send-email-liam.r.girdwood@linux.intel.com>
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

Define structures that can be used by applications to directly build topology
data instead of using text files. The application will build up the topology
data by populating the template structures for each object type and then
registering the template with the topology core.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>
Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 include/sound/asoc.h      |   2 +
 include/topology.h        | 178 ++++++++++++++++++++++++++++++++++++++++++++++
 src/topology/builder.c    |  38 +++++-----
 src/topology/ctl.c        |  38 +++++-----
 src/topology/dapm.c       |  28 ++++----
 src/topology/data.c       |  10 +--
 src/topology/elem.c       |  26 +++----
 src/topology/parser.c     |   6 +-
 src/topology/pcm.c        |  34 ++++-----
 src/topology/text.c       |   2 +-
 src/topology/tplg_local.h |  23 +-----
 11 files changed, 273 insertions(+), 112 deletions(-)

diff --git a/include/sound/asoc.h b/include/sound/asoc.h
index c642855..1b19739 100644
--- a/include/sound/asoc.h
+++ b/include/sound/asoc.h
@@ -15,6 +15,8 @@
 #ifndef __LINUX_UAPI_SND_ASOC_H
 #define __LINUX_UAPI_SND_ASOC_H
 
+#include <sound/type_compat.h>
+
 /*
  * Maximum number of channels topology kcontrol can represent.
  */
diff --git a/include/topology.h b/include/topology.h
index 0cb2d79..7d44232 100644
--- a/include/topology.h
+++ b/include/topology.h
@@ -456,6 +456,9 @@ extern "C" {
  *
  */
 
+/** Maximum number of channels supported in one control */
+#define SND_TPLG_MAX_CHAN		8
+
 /** Topology context */
 typedef struct snd_tplg snd_tplg_t;
 
@@ -488,6 +491,181 @@ int snd_tplg_build_file(snd_tplg_t *tplg, const char *infile,
  */
 void snd_tplg_verbose(snd_tplg_t *tplg, int verbose);
 
+/** Topology object types */
+enum snd_tplg_type {
+	SND_TPLG_TYPE_TLV = 0,		/*!< TLV Data */
+	SND_TPLG_TYPE_MIXER,		/*!< Mixer control*/
+	SND_TPLG_TYPE_ENUM,		/*!< Enumerated control */
+	SND_TPLG_TYPE_TEXT,		/*!< Text data */
+	SND_TPLG_TYPE_DATA,		/*!< Private data */
+	SND_TPLG_TYPE_BYTES,		/*!< Byte control */
+	SND_TPLG_TYPE_STREAM_CONFIG,	/*!< PCM Stream configuration */
+	SND_TPLG_TYPE_STREAM_CAPS,	/*!< PCM Stream capabilities */
+	SND_TPLG_TYPE_PCM,		/*!< PCM stream device */
+	SND_TPLG_TYPE_DAPM_WIDGET,	/*!< DAPM widget */
+	SND_TPLG_TYPE_DAPM_GRAPH,	/*!< DAPM graph elements */
+	SND_TPLG_TYPE_BE,		/*!< BE DAI link */
+	SND_TPLG_TYPE_CC,		/*!< Hostless codec <-> codec link */
+	SND_TPLG_TYPE_MANIFEST,		/*!< Topology manifest */
+};
+
+/** \struct snd_tplg_tlv_template
+ * \brief Template type for all TLV objects.
+ */
+struct snd_tplg_tlv_template {
+	int type;	 /*!< TLV type SNDRV_CTL_TLVT_ */
+};
+
+/** \struct snd_tplg_tlv_dbscale_template
+ * \brief Template type for TLV Scale objects.
+ */
+struct snd_tplg_tlv_dbscale_template {
+	struct snd_tplg_tlv_template hdr;	/*!< TLV type header */
+	int min;			/*!< dB minimum value in 0.1dB */
+	int step;			/*!< dB step size in 0.1dB */
+	int mute;			/*!< is min dB value mute ? */
+};
+
+/** \struct snd_tplg_channel_template
+ * \brief Template type for single channel mapping.
+ */
+struct snd_tplg_channel_elem {
+	int size;	/*!< size in bytes of this structure */
+	int reg;	/*!< channel control register */
+	int shift;	/*!< channel shift for control bits */
+	int id;		/*!< ID maps to Left, Right, LFE etc */
+};
+
+/** \struct snd_tplg_channel_map_template
+ * \brief Template type for channel mapping.
+ */
+struct snd_tplg_channel_map_template {
+	int num_channels;	/*!< number of channel mappings */
+	struct snd_tplg_channel_elem channel[SND_TPLG_MAX_CHAN];	/*!< mapping */
+};
+
+/** \struct snd_tplg_pdata_template
+ * \brief Template type for private data objects.
+ */
+struct snd_tplg_pdata_template {
+	unsigned int length;	/*!< data length */
+	const void *data;	/*!< data */
+};
+
+/** \struct snd_tplg_io_ops_template
+ * \brief Template type for object operations mapping.
+ */
+struct snd_tplg_io_ops_template {
+	int get;	/*!< get callback ID */
+	int put;	/*!< put callback ID */
+	int info;	/*!< info callback ID */
+};
+
+/** \struct snd_tplg_ctl_template
+ * \brief Template type for control objects.
+ */
+struct snd_tplg_ctl_template {
+	int type;		/*!< Control type */
+	const char *name;	/*!< Control name */
+	int access;		/*!< Control access */
+	struct snd_tplg_io_ops_template ops;	/*!< operations */
+	struct snd_tplg_tlv_template *tlv; /*!< non NULL means we have TLV data */
+};
+
+/** \struct snd_tplg_mixer_template
+ * \brief Template type for mixer control objects.
+ */
+struct snd_tplg_mixer_template {
+	struct snd_tplg_ctl_template hdr;	/*!< control type header */
+	struct snd_tplg_channel_map_template *map;	/*!< channel map */
+	int min;	/*!< min value for mixer */
+	int max;	/*!< max value for mixer */
+	int platform_max;	/*!< max value for platform control */
+	int invert;	/*!< whether controls bits are inverted */
+	struct snd_soc_tplg_private *priv;	/*!< control private data */
+};
+
+/** \struct snd_tplg_enum_template
+ * \brief Template type for enumerated control objects.
+ */
+struct snd_tplg_enum_template {
+	struct snd_tplg_ctl_template hdr;	/*!< control type header */
+	struct snd_tplg_channel_map_template *map;	/*!< channel map */
+	int items;	/*!< number of enumerated items in control */
+	int mask;	/*!< register mask size */
+	const char **texts;	/*!< control text items */
+	const int **values;	/*!< control value items */
+	struct snd_soc_tplg_private *priv;	/*!< control private data */
+};
+
+/** \struct snd_tplg_bytes_template
+ * \brief Template type for TLV Scale objects.
+ */
+struct snd_tplg_bytes_template {
+	struct snd_tplg_ctl_template hdr;	/*!< control type header */
+	int max;		/*!< max byte control value */
+	int mask;		/*!< byte control mask */
+	int base;		/*!< base register */
+	int num_regs;		/*!< number of registers */
+	struct snd_tplg_io_ops_template ext_ops;	/*!< ops mapping */
+	struct snd_soc_tplg_private *priv;	/*!< control private data */
+};
+
+/** \struct snd_tplg_graph_elem
+ * \brief Template type for single DAPM graph element.
+ */
+struct snd_tplg_graph_elem {
+	const char *src;	/*!< source widget name */
+	const char *ctl;	/*!< control name or NULL if no control */
+	const char *sink;	/*!< sink widget name */
+};
+
+/** \struct snd_tplg_graph_template
+ * \brief Template type for array of DAPM graph elements.
+ */
+struct snd_tplg_graph_template {
+	int count;		/*!< Number of graph elements */
+	struct snd_tplg_graph_elem elem[0];	/*!< graph elements */
+};
+
+/** \struct snd_tplg_widget_template
+ * \brief Template type for DAPM widget objects.
+ */
+struct snd_tplg_widget_template {
+	int id;			/*!< SND_SOC_DAPM_CTL */
+	const char *name;	/*!< widget name */
+	const char *sname;	/*!< stream name (certain widgets only) */
+	int reg;		/*!< negative reg = no direct dapm */
+	int shift;		/*!< bits to shift */
+	int mask;		/*!< non-shifted mask */
+	int subseq;		/*!< sort within widget type */
+	unsigned int invert;		/*!< invert the power bit */
+	unsigned int ignore_suspend;	/*!< kept enabled over suspend */
+	unsigned short event_flags;	/*!< PM event sequence flags */
+	unsigned short event_type;	/*!< PM event sequence type */
+	struct snd_soc_tplg_private *priv;	/*!< widget private data */
+	int num_ctls;			/*!< Number of controls used by widget */
+	struct snd_tplg_ctl_template *ctl[0];	/*!< array of widget controls */
+};
+
+/** \struct snd_tplg_obj_template
+ * \brief Generic Template Object
+ */
+typedef struct snd_tplg_obj_template {
+	enum snd_tplg_type type;	/*!< template object type */
+	int index;		/*!< group index for object */
+	int version;		/*!< optional vendor specific version details */
+	int vendor_type;	/*!< optional vendor specific type info */
+	union {
+		struct snd_tplg_widget_template *widget;	/*!< DAPM widget */
+		struct snd_tplg_mixer_template *mixer;		/*!< Mixer control */
+		struct snd_tplg_bytes_template *bytes_ctl;	/*!< Bytes control */
+		struct snd_tplg_enum_template *enum_ctl;	/*!< Enum control */
+		struct snd_tplg_graph_template *graph;		/*!< Graph elements */
+	};
+} snd_tplg_obj_template_t;
+
+
 /* \} */
 
 #ifdef __cplusplus
diff --git a/src/topology/builder.c b/src/topology/builder.c
index a944866..3bccd44 100644
--- a/src/topology/builder.c
+++ b/src/topology/builder.c
@@ -141,7 +141,7 @@ static int write_elem_block(snd_tplg_t *tplg,
 		if (elem->compound_elem)
 			continue;
 
-		if (elem->type != OBJECT_TYPE_DAPM_GRAPH)
+		if (elem->type != SND_TPLG_TYPE_DAPM_GRAPH)
 			verbose(tplg, " %s '%s': write %d bytes\n",
 				obj_name, elem->id, elem->size);
 		else
@@ -202,31 +202,31 @@ static int write_block(snd_tplg_t *tplg, struct list_head *base,
 
 	/* write each elem for this block */
 	switch (type) {
-	case OBJECT_TYPE_MIXER:
+	case SND_TPLG_TYPE_MIXER:
 		return write_elem_block(tplg, base, size,
 			SND_SOC_TPLG_TYPE_MIXER, "mixer");
-	case OBJECT_TYPE_BYTES:
+	case SND_TPLG_TYPE_BYTES:
 		return write_elem_block(tplg, base, size,
 			SND_SOC_TPLG_TYPE_BYTES, "bytes");
-	case OBJECT_TYPE_ENUM:
+	case SND_TPLG_TYPE_ENUM:
 		return write_elem_block(tplg, base, size,
 			SND_SOC_TPLG_TYPE_ENUM, "enum");
-	case OBJECT_TYPE_DAPM_GRAPH:
+	case SND_TPLG_TYPE_DAPM_GRAPH:
 		return write_elem_block(tplg, base, size,
 			SND_SOC_TPLG_TYPE_DAPM_GRAPH, "route");
-	case OBJECT_TYPE_DAPM_WIDGET:
+	case SND_TPLG_TYPE_DAPM_WIDGET:
 		return write_elem_block(tplg, base, size,
 			SND_SOC_TPLG_TYPE_DAPM_WIDGET, "widget");
-	case OBJECT_TYPE_PCM:
+	case SND_TPLG_TYPE_PCM:
 		return write_elem_block(tplg, base, size,
 			SND_SOC_TPLG_TYPE_PCM, "pcm");
-	case OBJECT_TYPE_BE:
+	case SND_TPLG_TYPE_BE:
 		return write_elem_block(tplg, base, size,
 			SND_SOC_TPLG_TYPE_DAI_LINK, "be");
-	case OBJECT_TYPE_CC:
+	case SND_TPLG_TYPE_CC:
 		return write_elem_block(tplg, base, size,
 			SND_SOC_TPLG_TYPE_DAI_LINK, "cc");
-	case OBJECT_TYPE_DATA:
+	case SND_TPLG_TYPE_DATA:
 		return write_elem_block(tplg, base, size,
 			SND_SOC_TPLG_TYPE_PDATA, "data");
 	default:
@@ -280,7 +280,7 @@ int tplg_write_data(snd_tplg_t *tplg)
 
 	/* write mixer elems. */
 	ret = write_block(tplg, &tplg->mixer_list,
-		OBJECT_TYPE_MIXER);
+		SND_TPLG_TYPE_MIXER);
 	if (ret < 0) {
 		SNDERR("failed to write control elems %d\n", ret);
 		return ret;
@@ -288,7 +288,7 @@ int tplg_write_data(snd_tplg_t *tplg)
 
 	/* write enum control elems. */
 	ret = write_block(tplg, &tplg->enum_list,
-		OBJECT_TYPE_ENUM);
+		SND_TPLG_TYPE_ENUM);
 	if (ret < 0) {
 		SNDERR("failed to write control elems %d\n", ret);
 		return ret;
@@ -296,7 +296,7 @@ int tplg_write_data(snd_tplg_t *tplg)
 
 	/* write bytes extended control elems. */
 	ret = write_block(tplg, &tplg->bytes_ext_list,
-		OBJECT_TYPE_BYTES);
+		SND_TPLG_TYPE_BYTES);
 	if (ret < 0) {
 		SNDERR("failed to write control elems %d\n", ret);
 		return ret;
@@ -304,7 +304,7 @@ int tplg_write_data(snd_tplg_t *tplg)
 
 	/* write widget elems */
 	ret = write_block(tplg, &tplg->widget_list,
-		OBJECT_TYPE_DAPM_WIDGET);
+		SND_TPLG_TYPE_DAPM_WIDGET);
 	if (ret < 0) {
 		SNDERR("failed to write widget elems %d\n", ret);
 		return ret;
@@ -312,7 +312,7 @@ int tplg_write_data(snd_tplg_t *tplg)
 
 	/* write pcm elems */
 	ret = write_block(tplg, &tplg->pcm_list,
-		OBJECT_TYPE_PCM);
+		SND_TPLG_TYPE_PCM);
 	if (ret < 0) {
 		SNDERR("failed to write pcm elems %d\n", ret);
 		return ret;
@@ -320,7 +320,7 @@ int tplg_write_data(snd_tplg_t *tplg)
 
 	/* write be elems */
 	ret = write_block(tplg, &tplg->be_list,
-		OBJECT_TYPE_BE);
+		SND_TPLG_TYPE_BE);
 	if (ret < 0) {
 		SNDERR("failed to write be elems %d\n", ret);
 		return ret;
@@ -328,7 +328,7 @@ int tplg_write_data(snd_tplg_t *tplg)
 
 	/* write cc elems */
 	ret = write_block(tplg, &tplg->cc_list,
-		OBJECT_TYPE_CC);
+		SND_TPLG_TYPE_CC);
 	if (ret < 0) {
 		SNDERR("failed to write cc elems %d\n", ret);
 		return ret;
@@ -336,7 +336,7 @@ int tplg_write_data(snd_tplg_t *tplg)
 
 	/* write route elems */
 	ret = write_block(tplg, &tplg->route_list,
-		OBJECT_TYPE_DAPM_GRAPH);
+		SND_TPLG_TYPE_DAPM_GRAPH);
 	if (ret < 0) {
 		SNDERR("failed to write graph elems %d\n", ret);
 		return ret;
@@ -344,7 +344,7 @@ int tplg_write_data(snd_tplg_t *tplg)
 
 	/* write private data */
 	ret = write_block(tplg, &tplg->pdata_list,
-		OBJECT_TYPE_DATA);
+		SND_TPLG_TYPE_DATA);
 	if (ret < 0) {
 		SNDERR("failed to write private data %d\n", ret);
 		return ret;
diff --git a/src/topology/ctl.c b/src/topology/ctl.c
index 930b508..35f684b 100644
--- a/src/topology/ctl.c
+++ b/src/topology/ctl.c
@@ -49,15 +49,15 @@ static int tplg_build_mixer_control(snd_tplg_t *tplg,
 		if (ref->id == NULL || ref->elem)
 			continue;
 
-		if (ref->type == OBJECT_TYPE_TLV) {
+		if (ref->type == SND_TPLG_TYPE_TLV) {
 			ref->elem = tplg_elem_lookup(&tplg->tlv_list,
-						ref->id, OBJECT_TYPE_TLV);
+						ref->id, SND_TPLG_TYPE_TLV);
 			if (ref->elem)
 				 err = copy_tlv(elem, ref->elem);
 
-		} else if (ref->type == OBJECT_TYPE_DATA) {
+		} else if (ref->type == SND_TPLG_TYPE_DATA) {
 			ref->elem = tplg_elem_lookup(&tplg->pdata_list,
-						ref->id, OBJECT_TYPE_DATA);
+						ref->id, SND_TPLG_TYPE_DATA);
 			 err = tplg_copy_data(elem, ref->elem);
 		}
 
@@ -97,15 +97,15 @@ static int tplg_build_enum_control(snd_tplg_t *tplg,
 		if (ref->id == NULL || ref->elem)
 			continue;
 
-		if (ref->type == OBJECT_TYPE_TEXT) {
+		if (ref->type == SND_TPLG_TYPE_TEXT) {
 			ref->elem = tplg_elem_lookup(&tplg->text_list,
-						ref->id, OBJECT_TYPE_TEXT);
+						ref->id, SND_TPLG_TYPE_TEXT);
 			if (ref->elem)
 				copy_enum_texts(elem, ref->elem);
 
-		} else if (ref->type == OBJECT_TYPE_DATA) {
+		} else if (ref->type == SND_TPLG_TYPE_DATA) {
 			ref->elem = tplg_elem_lookup(&tplg->pdata_list,
-						ref->id, OBJECT_TYPE_DATA);
+						ref->id, SND_TPLG_TYPE_DATA);
 			err = tplg_copy_data(elem, ref->elem);
 		}
 		if (!ref->elem) {
@@ -135,7 +135,7 @@ static int tplg_build_bytes_control(snd_tplg_t *tplg, struct tplg_elem *elem)
 
 		/* bytes control only reference one private data section */
 		ref->elem = tplg_elem_lookup(&tplg->pdata_list,
-			ref->id, OBJECT_TYPE_DATA);
+			ref->id, SND_TPLG_TYPE_DATA);
 		if (!ref->elem) {
 			SNDERR("error: cannot find data '%s'"
 				" referenced by control '%s'\n",
@@ -260,7 +260,7 @@ int tplg_parse_tlv(snd_tplg_t *tplg, snd_config_t *cfg,
 	int err = 0;
 	struct tplg_elem *elem;
 
-	elem = tplg_elem_new_common(tplg, cfg, NULL, OBJECT_TYPE_TLV);
+	elem = tplg_elem_new_common(tplg, cfg, NULL, SND_TPLG_TYPE_TLV);
 	if (!elem)
 		return -ENOMEM;
 
@@ -294,7 +294,7 @@ int tplg_parse_control_bytes(snd_tplg_t *tplg,
 	const char *id, *val = NULL;
 	int err;
 
-	elem = tplg_elem_new_common(tplg, cfg, NULL, OBJECT_TYPE_BYTES);
+	elem = tplg_elem_new_common(tplg, cfg, NULL, SND_TPLG_TYPE_BYTES);
 	if (!elem)
 		return -ENOMEM;
 
@@ -365,7 +365,7 @@ int tplg_parse_control_bytes(snd_tplg_t *tplg,
 			if (snd_config_get_string(n, &val) < 0)
 				return -EINVAL;
 
-			tplg_ref_add(elem, OBJECT_TYPE_DATA, val);
+			tplg_ref_add(elem, SND_TPLG_TYPE_DATA, val);
 			tplg_dbg("\t%s: %s\n", id, val);
 			continue;
 		}
@@ -374,7 +374,7 @@ int tplg_parse_control_bytes(snd_tplg_t *tplg,
 			if (snd_config_get_string(n, &val) < 0)
 				return -EINVAL;
 
-			err = tplg_ref_add(elem, OBJECT_TYPE_TLV, val);
+			err = tplg_ref_add(elem, SND_TPLG_TYPE_TLV, val);
 			if (err < 0)
 				return err;
 
@@ -399,7 +399,7 @@ int tplg_parse_control_enum(snd_tplg_t *tplg, snd_config_t *cfg,
 	const char *id, *val = NULL;
 	int err, j;
 
-	elem = tplg_elem_new_common(tplg, cfg, NULL, OBJECT_TYPE_ENUM);
+	elem = tplg_elem_new_common(tplg, cfg, NULL, SND_TPLG_TYPE_ENUM);
 	if (!elem)
 		return -ENOMEM;
 
@@ -440,7 +440,7 @@ int tplg_parse_control_enum(snd_tplg_t *tplg, snd_config_t *cfg,
 			if (snd_config_get_string(n, &val) < 0)
 				return -EINVAL;
 
-			tplg_ref_add(elem, OBJECT_TYPE_TEXT, val);
+			tplg_ref_add(elem, SND_TPLG_TYPE_TEXT, val);
 			tplg_dbg("\t%s: %s\n", id, val);
 			continue;
 		}
@@ -473,7 +473,7 @@ int tplg_parse_control_enum(snd_tplg_t *tplg, snd_config_t *cfg,
 			if (snd_config_get_string(n, &val) < 0)
 				return -EINVAL;
 
-			tplg_ref_add(elem, OBJECT_TYPE_DATA, val);
+			tplg_ref_add(elem, SND_TPLG_TYPE_DATA, val);
 			tplg_dbg("\t%s: %s\n", id, val);
 			continue;
 		}
@@ -496,7 +496,7 @@ int tplg_parse_control_mixer(snd_tplg_t *tplg,
 	const char *id, *val = NULL;
 	int err, j;
 
-	elem = tplg_elem_new_common(tplg, cfg, NULL, OBJECT_TYPE_MIXER);
+	elem = tplg_elem_new_common(tplg, cfg, NULL, SND_TPLG_TYPE_MIXER);
 	if (!elem)
 		return -ENOMEM;
 
@@ -584,7 +584,7 @@ int tplg_parse_control_mixer(snd_tplg_t *tplg,
 			if (snd_config_get_string(n, &val) < 0)
 				return -EINVAL;
 
-			err = tplg_ref_add(elem, OBJECT_TYPE_TLV, val);
+			err = tplg_ref_add(elem, SND_TPLG_TYPE_TLV, val);
 			if (err < 0)
 				return err;
 
@@ -598,7 +598,7 @@ int tplg_parse_control_mixer(snd_tplg_t *tplg,
 			if (snd_config_get_string(n, &val) < 0)
 				return -EINVAL;
 
-			tplg_ref_add(elem, OBJECT_TYPE_DATA, val);
+			tplg_ref_add(elem, SND_TPLG_TYPE_DATA, val);
 			tplg_dbg("\t%s: %s\n", id, val);
 			continue;
 		}
diff --git a/src/topology/dapm.c b/src/topology/dapm.c
index 02dd676..132b4a1 100644
--- a/src/topology/dapm.c
+++ b/src/topology/dapm.c
@@ -74,7 +74,7 @@ static int tplg_parse_dapm_mixers(snd_config_t *cfg, struct tplg_elem *elem)
 		if (snd_config_get_string(n, &value) < 0)
 			continue;
 
-		tplg_ref_add(elem, OBJECT_TYPE_MIXER, value);
+		tplg_ref_add(elem, SND_TPLG_TYPE_MIXER, value);
 		tplg_dbg("\t\t %s\n", value);
 	}
 
@@ -96,7 +96,7 @@ static int tplg_parse_dapm_enums(snd_config_t *cfg, struct tplg_elem *elem)
 		if (snd_config_get_string(n, &value) < 0)
 			continue;
 
-		tplg_ref_add(elem, OBJECT_TYPE_ENUM, value);
+		tplg_ref_add(elem, SND_TPLG_TYPE_ENUM, value);
 		tplg_dbg("\t\t %s\n", value);
 	}
 
@@ -107,8 +107,6 @@ static int tplg_parse_dapm_enums(snd_config_t *cfg, struct tplg_elem *elem)
 static int copy_dapm_control(struct tplg_elem *elem, struct tplg_elem *ref)
 {
 	struct snd_soc_tplg_dapm_widget *widget = elem->widget;
-	struct snd_soc_tplg_mixer_control *mixer_ctrl = ref->mixer_ctrl;
-	struct snd_soc_tplg_enum_control *enum_ctrl = ref->enum_ctrl;
 
 	tplg_dbg("Control '%s' used by '%s'\n", ref->id, elem->id);
 	tplg_dbg("\tparent size: %d + %d -> %d, priv size -> %d\n",
@@ -148,21 +146,21 @@ static int tplg_build_widget(snd_tplg_t *tplg,
 			continue;
 
 		switch (ref->type) {
-		case OBJECT_TYPE_MIXER:
+		case SND_TPLG_TYPE_MIXER:
 			ref->elem = tplg_elem_lookup(&tplg->mixer_list,
 						ref->id, OBJECT_TYPE_MIXER);
+		case SND_TPLG_TYPE_ENUM:
 			if (ref->elem)
 				err = copy_dapm_control(elem, ref->elem);
 			break;
 
-		case OBJECT_TYPE_ENUM:
 			ref->elem = tplg_elem_lookup(&tplg->enum_list,
 						ref->id, OBJECT_TYPE_ENUM);
 			if (ref->elem)
 				err = copy_dapm_control(elem, ref->elem);
 			break;
 
-		case OBJECT_TYPE_DATA:
+		case SND_TPLG_TYPE_DATA:
 			ref->elem = tplg_elem_lookup(&tplg->pdata_list,
 						ref->id, OBJECT_TYPE_DATA);
 			if (ref->elem)
@@ -197,7 +195,7 @@ int tplg_build_widgets(snd_tplg_t *tplg)
 	list_for_each(pos, base) {
 
 		elem = list_entry(pos, struct tplg_elem, list);
-		if (!elem->widget || elem->type != OBJECT_TYPE_DAPM_WIDGET) {
+		if (!elem->widget || elem->type != SND_TPLG_TYPE_DAPM_WIDGET) {
 			SNDERR("error: invalid widget '%s'\n",
 				elem->id);
 			return -EINVAL;
@@ -225,7 +223,7 @@ int tplg_build_routes(snd_tplg_t *tplg)
 	list_for_each(pos, base) {
 		elem = list_entry(pos, struct tplg_elem, list);
 
-		if (!elem->route || elem->type != OBJECT_TYPE_DAPM_GRAPH) {
+		if (!elem->route || elem->type != SND_TPLG_TYPE_DAPM_GRAPH) {
 			SNDERR("error: invalid route '%s'\n",
 				elem->id);
 			return -EINVAL;
@@ -242,7 +240,7 @@ int tplg_build_routes(snd_tplg_t *tplg)
 
 		}
 		if (!tplg_elem_lookup(&tplg->widget_list, route->sink,
-			OBJECT_TYPE_DAPM_WIDGET)) {
+			SND_TPLG_TYPE_DAPM_WIDGET)) {
 			SNDERR("warning: undefined sink widget/stream '%s'\n",
 				route->sink);
 		}
@@ -250,9 +248,9 @@ int tplg_build_routes(snd_tplg_t *tplg)
 		/* validate control name */
 		if (strlen(route->control)) {
 			if (!tplg_elem_lookup(&tplg->mixer_list,
-				route->control, OBJECT_TYPE_MIXER) &&
+				route->control, SND_TPLG_TYPE_MIXER) &&
 			!tplg_elem_lookup(&tplg->enum_list,
-				route->control, OBJECT_TYPE_ENUM)) {
+				route->control, SND_TPLG_TYPE_ENUM)) {
 				SNDERR("warning: Undefined mixer/enum control '%s'\n",
 					route->control);
 			}
@@ -265,7 +263,7 @@ int tplg_build_routes(snd_tplg_t *tplg)
 
 		}
 		if (!tplg_elem_lookup(&tplg->widget_list, route->source,
-			OBJECT_TYPE_DAPM_WIDGET)) {
+			SND_TPLG_TYPE_DAPM_WIDGET)) {
 			SNDERR("warning: Undefined source widget/stream '%s'\n",
 				route->source);
 		}
@@ -417,7 +415,7 @@ int tplg_parse_dapm_widget(snd_tplg_t *tplg,
 	const char *id, *val = NULL;
 	int widget_type, err;
 
-	elem = tplg_elem_new_common(tplg, cfg, NULL, OBJECT_TYPE_DAPM_WIDGET);
+	elem = tplg_elem_new_common(tplg, cfg, NULL, SND_TPLG_TYPE_DAPM_WIDGET);
 	if (!elem)
 		return -ENOMEM;
 
@@ -549,7 +547,7 @@ int tplg_parse_dapm_widget(snd_tplg_t *tplg,
 			if (snd_config_get_string(n, &val) < 0)
 				return -EINVAL;
 
-			tplg_ref_add(elem, OBJECT_TYPE_DATA, val);
+			tplg_ref_add(elem, SND_TPLG_TYPE_DATA, val);
 			tplg_dbg("\t%s: %s\n", id, val);
 			continue;
 		}
diff --git a/src/topology/data.c b/src/topology/data.c
index 0901851..4ee1f8a 100644
--- a/src/topology/data.c
+++ b/src/topology/data.c
@@ -268,7 +268,7 @@ int tplg_parse_data(snd_tplg_t *tplg, snd_config_t *cfg,
 	int err = 0;
 	struct tplg_elem *elem;
 
-	elem = tplg_elem_new_common(tplg, cfg, NULL, OBJECT_TYPE_DATA);
+	elem = tplg_elem_new_common(tplg, cfg, NULL, SND_TPLG_TYPE_DATA);
 	if (!elem)
 		return -ENOMEM;
 
@@ -350,7 +350,7 @@ int tplg_copy_data(struct tplg_elem *elem, struct tplg_elem *ref)
 	priv_data_size = ref->data->size;
 
 	switch (elem->type) {
-	case OBJECT_TYPE_MIXER:
+	case SND_TPLG_TYPE_MIXER:
 		elem->mixer_ctrl = realloc(elem->mixer_ctrl,
 			elem->size + priv_data_size);
 		if (!elem->mixer_ctrl)
@@ -358,7 +358,7 @@ int tplg_copy_data(struct tplg_elem *elem, struct tplg_elem *ref)
 		priv = &elem->mixer_ctrl->priv;
 		break;
 
-	case OBJECT_TYPE_ENUM:
+	case SND_TPLG_TYPE_ENUM:
 		elem->enum_ctrl = realloc(elem->enum_ctrl,
 			elem->size + priv_data_size);
 		if (!elem->enum_ctrl)
@@ -366,7 +366,7 @@ int tplg_copy_data(struct tplg_elem *elem, struct tplg_elem *ref)
 		priv = &elem->enum_ctrl->priv;
 		break;
 
-	case OBJECT_TYPE_BYTES:
+	case SND_TPLG_TYPE_BYTES:
 		elem->bytes_ext = realloc(elem->bytes_ext,
 			elem->size + priv_data_size);
 		if (!elem->bytes_ext)
@@ -375,7 +375,7 @@ int tplg_copy_data(struct tplg_elem *elem, struct tplg_elem *ref)
 		break;
 
 
-	case OBJECT_TYPE_DAPM_WIDGET:
+	case SND_TPLG_TYPE_DAPM_WIDGET:
 		elem->widget = realloc(elem->widget,
 			elem->size + priv_data_size);
 		if (!elem->widget)
diff --git a/src/topology/elem.c b/src/topology/elem.c
index 7fee653..daabe75 100644
--- a/src/topology/elem.c
+++ b/src/topology/elem.c
@@ -103,7 +103,7 @@ struct tplg_elem *tplg_elem_lookup(struct list_head *base, const char* id,
 
 /* create a new common element and object */
 struct tplg_elem* tplg_elem_new_common(snd_tplg_t *tplg,
-	snd_config_t *cfg, const char *name, enum object_type type)
+	snd_config_t *cfg, const char *name, enum snd_tplg_type type)
 {
 	struct tplg_elem *elem;
 	const char *id;
@@ -126,49 +126,49 @@ struct tplg_elem* tplg_elem_new_common(snd_tplg_t *tplg,
 		elem_copy_text(elem->id, name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
 
 	switch (type) {
-	case OBJECT_TYPE_DATA:
+	case SND_TPLG_TYPE_DATA:
 		list_add_tail(&elem->list, &tplg->pdata_list);
 		break;
-	case OBJECT_TYPE_TEXT:
+	case SND_TPLG_TYPE_TEXT:
 		list_add_tail(&elem->list, &tplg->text_list);
 		break;
-	case OBJECT_TYPE_TLV:
+	case SND_TPLG_TYPE_TLV:
 		list_add_tail(&elem->list, &tplg->tlv_list);
 		elem->size = sizeof(struct snd_soc_tplg_ctl_tlv);
 		break;
-	case OBJECT_TYPE_BYTES:
+	case SND_TPLG_TYPE_BYTES:
 		list_add_tail(&elem->list, &tplg->bytes_ext_list);
 		obj_size = sizeof(struct snd_soc_tplg_bytes_control);
 		break;
-	case OBJECT_TYPE_ENUM:
+	case SND_TPLG_TYPE_ENUM:
 		list_add_tail(&elem->list, &tplg->enum_list);
 		obj_size = sizeof(struct snd_soc_tplg_enum_control);
 		break;
-	case OBJECT_TYPE_MIXER:
+	case SND_TPLG_TYPE_MIXER:
 		list_add_tail(&elem->list, &tplg->mixer_list);
 		obj_size = sizeof(struct snd_soc_tplg_mixer_control);
 		break;
-	case OBJECT_TYPE_DAPM_WIDGET:
+	case SND_TPLG_TYPE_DAPM_WIDGET:
 		list_add_tail(&elem->list, &tplg->widget_list);
 		obj_size = sizeof(struct snd_soc_tplg_dapm_widget);
 		break;
-	case OBJECT_TYPE_STREAM_CONFIG:
+	case SND_TPLG_TYPE_STREAM_CONFIG:
 		list_add_tail(&elem->list, &tplg->pcm_config_list);
 		obj_size = sizeof(struct snd_soc_tplg_stream_config);
 		break;
-	case OBJECT_TYPE_STREAM_CAPS:
+	case SND_TPLG_TYPE_STREAM_CAPS:
 		list_add_tail(&elem->list, &tplg->pcm_caps_list);
 		obj_size = sizeof(struct snd_soc_tplg_stream_caps);
 		break;
-	case OBJECT_TYPE_PCM:
+	case SND_TPLG_TYPE_PCM:
 		list_add_tail(&elem->list, &tplg->pcm_list);
 		obj_size = sizeof(struct snd_soc_tplg_pcm_dai);
 		break;
-	case OBJECT_TYPE_BE:
+	case SND_TPLG_TYPE_BE:
 		list_add_tail(&elem->list, &tplg->be_list);
 		obj_size = sizeof(struct snd_soc_tplg_pcm_dai);
 		break;
-	case OBJECT_TYPE_CC:
+	case SND_TPLG_TYPE_CC:
 		list_add_tail(&elem->list, &tplg->cc_list);
 		obj_size = sizeof(struct snd_soc_tplg_pcm_dai);
 		break;
diff --git a/src/topology/parser.c b/src/topology/parser.c
index ed25bb8..3e3e2b3 100644
--- a/src/topology/parser.c
+++ b/src/topology/parser.c
@@ -241,15 +241,15 @@ static int tplg_build_integ(snd_tplg_t *tplg)
 	if (err <  0)
 		return err;
 
-	err = tplg_build_pcm_dai(tplg, OBJECT_TYPE_PCM);
+	err = tplg_build_pcm_dai(tplg, SND_TPLG_TYPE_PCM);
 	if (err <  0)
 		return err;
 
-	err = tplg_build_pcm_dai(tplg, OBJECT_TYPE_BE);
+	err = tplg_build_pcm_dai(tplg, SND_TPLG_TYPE_BE);
 	if (err <  0)
 		return err;
 
-	err = tplg_build_pcm_dai(tplg, OBJECT_TYPE_CC);
+	err = tplg_build_pcm_dai(tplg, SND_TPLG_TYPE_CC);
 	if (err <  0)
 		return err;
 
diff --git a/src/topology/pcm.c b/src/topology/pcm.c
index deae47b..6e42aa1 100644
--- a/src/topology/pcm.c
+++ b/src/topology/pcm.c
@@ -28,7 +28,7 @@ struct tplg_elem *lookup_pcm_dai_stream(struct list_head *base, const char* id)
 	list_for_each(pos, base) {
 
 		elem = list_entry(pos, struct tplg_elem, list);
-		if (elem->type != OBJECT_TYPE_PCM)
+		if (elem->type != SND_TPLG_TYPE_PCM)
 			return NULL;
 
 		pcm_dai = elem->pcm;
@@ -74,13 +74,13 @@ static int tplg_build_pcm_cfg_caps(snd_tplg_t *tplg, struct tplg_elem *elem)
 	unsigned int i, j;
 
 	switch (elem->type) {
-	case OBJECT_TYPE_PCM:
+	case SND_TPLG_TYPE_PCM:
 		pcm_dai = elem->pcm;
 		break;
-	case OBJECT_TYPE_BE:
+	case SND_TPLG_TYPE_BE:
 		pcm_dai = elem->be;
 		break;
-	case OBJECT_TYPE_CC:
+	case SND_TPLG_TYPE_CC:
 		pcm_dai = elem->cc;
 		break;
 	default:
@@ -91,7 +91,7 @@ static int tplg_build_pcm_cfg_caps(snd_tplg_t *tplg, struct tplg_elem *elem)
 		capconf = &pcm_dai->capconf[i];
 
 		ref_elem = tplg_elem_lookup(&tplg->pcm_caps_list,
-			capconf->caps.name, OBJECT_TYPE_STREAM_CAPS);
+			capconf->caps.name, SND_TPLG_TYPE_STREAM_CAPS);
 
 		if (ref_elem != NULL)
 			copy_pcm_caps(elem->id, &capconf->caps, ref_elem);
@@ -99,7 +99,7 @@ static int tplg_build_pcm_cfg_caps(snd_tplg_t *tplg, struct tplg_elem *elem)
 		for (j = 0; j < capconf->num_configs; j++) {
 			ref_elem = tplg_elem_lookup(&tplg->pcm_config_list,
 				capconf->configs[j].name,
-				OBJECT_TYPE_STREAM_CONFIG);
+				SND_TPLG_TYPE_STREAM_CONFIG);
 
 			if (ref_elem != NULL)
 				copy_pcm_config(elem->id,
@@ -118,13 +118,13 @@ int tplg_build_pcm_dai(snd_tplg_t *tplg, unsigned int type)
 	int err = 0;
 
 	switch (type) {
-	case OBJECT_TYPE_PCM:
+	case SND_TPLG_TYPE_PCM:
 		base = &tplg->pcm_list;
 		break;
-	case OBJECT_TYPE_BE:
+	case SND_TPLG_TYPE_BE:
 		base = &tplg->be_list;
 		break;
-	case OBJECT_TYPE_CC:
+	case SND_TPLG_TYPE_CC:
 		base = &tplg->cc_list;
 		break;
 	default:
@@ -228,7 +228,7 @@ int tplg_parse_pcm_config(snd_tplg_t *tplg,
 	const char *id;
 	int err;
 
-	elem = tplg_elem_new_common(tplg, cfg, NULL, OBJECT_TYPE_STREAM_CONFIG);
+	elem = tplg_elem_new_common(tplg, cfg, NULL, SND_TPLG_TYPE_STREAM_CONFIG);
 	if (!elem)
 		return -ENOMEM;
 
@@ -294,7 +294,7 @@ int tplg_parse_pcm_caps(snd_tplg_t *tplg,
 	char *s;
 	int err;
 
-	elem = tplg_elem_new_common(tplg, cfg, NULL, OBJECT_TYPE_STREAM_CAPS);
+	elem = tplg_elem_new_common(tplg, cfg, NULL, SND_TPLG_TYPE_STREAM_CAPS);
 	if (!elem)
 		return -ENOMEM;
 
@@ -396,11 +396,11 @@ int tplg_parse_pcm_cap_cfg(snd_tplg_t *tplg, snd_config_t *cfg,
 	const char *id, *value;
 	int err, stream;
 
-	if (elem->type == OBJECT_TYPE_PCM)
+	if (elem->type == SND_TPLG_TYPE_PCM)
 		pcm_dai = elem->pcm;
-	else if (elem->type == OBJECT_TYPE_BE)
+	else if (elem->type == SND_TPLG_TYPE_BE)
 		pcm_dai = elem->be;
-	else if (elem->type == OBJECT_TYPE_CC)
+	else if (elem->type == SND_TPLG_TYPE_CC)
 		pcm_dai = elem->cc;
 	else
 		return -EINVAL;
@@ -461,7 +461,7 @@ int tplg_parse_pcm(snd_tplg_t *tplg,
 	const char *id, *val = NULL;
 	int err;
 
-	elem = tplg_elem_new_common(tplg, cfg, NULL, OBJECT_TYPE_PCM);
+	elem = tplg_elem_new_common(tplg, cfg, NULL, SND_TPLG_TYPE_PCM);
 	if (!elem)
 		return -ENOMEM;
 
@@ -524,7 +524,7 @@ int tplg_parse_be(snd_tplg_t *tplg,
 	const char *id, *val = NULL;
 	int err;
 
-	elem = tplg_elem_new_common(tplg, cfg, NULL, OBJECT_TYPE_BE);
+	elem = tplg_elem_new_common(tplg, cfg, NULL, SND_TPLG_TYPE_BE);
 	if (!elem)
 		return -ENOMEM;
 
@@ -587,7 +587,7 @@ int tplg_parse_cc(snd_tplg_t *tplg,
 	const char *id, *val = NULL;
 	int err;
 
-	elem = tplg_elem_new_common(tplg, cfg, NULL, OBJECT_TYPE_CC);
+	elem = tplg_elem_new_common(tplg, cfg, NULL, SND_TPLG_TYPE_CC);
 	if (!elem)
 		return -ENOMEM;
 
diff --git a/src/topology/text.c b/src/topology/text.c
index 7128056..0c6594a 100644
--- a/src/topology/text.c
+++ b/src/topology/text.c
@@ -64,7 +64,7 @@ int tplg_parse_text(snd_tplg_t *tplg, snd_config_t *cfg,
 	int err = 0;
 	struct tplg_elem *elem;
 
-	elem = tplg_elem_new_common(tplg, cfg, NULL, OBJECT_TYPE_TEXT);
+	elem = tplg_elem_new_common(tplg, cfg, NULL, SND_TPLG_TYPE_TEXT);
 	if (!elem)
 		return -ENOMEM;
 
diff --git a/src/topology/tplg_local.h b/src/topology/tplg_local.h
index ad38945..5c45eb8 100644
--- a/src/topology/tplg_local.h
+++ b/src/topology/tplg_local.h
@@ -40,24 +40,6 @@
 struct tplg_ref;
 struct tplg_elem;
 
-/* internal topology object type not used by kernel */
-enum object_type {
-	OBJECT_TYPE_TLV = 0,
-	OBJECT_TYPE_MIXER,
-	OBJECT_TYPE_ENUM,
-	OBJECT_TYPE_TEXT,
-	OBJECT_TYPE_DATA,
-	OBJECT_TYPE_BYTES,
-	OBJECT_TYPE_STREAM_CONFIG,
-	OBJECT_TYPE_STREAM_CAPS,
-	OBJECT_TYPE_PCM,
-	OBJECT_TYPE_DAPM_WIDGET,
-	OBJECT_TYPE_DAPM_GRAPH,
-	OBJECT_TYPE_BE,
-	OBJECT_TYPE_CC,
-	OBJECT_TYPE_MANIFEST,
-};
-
 struct snd_tplg {
 
 	/* opaque vendor data */
@@ -114,7 +96,7 @@ struct tplg_elem {
 	char texts[SND_SOC_TPLG_NUM_TEXTS][SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
 
 	int index;
-	enum object_type type;
+	enum snd_tplg_type type;
 
 	int size; /* total size of this object inc pdata and ref objects */
 	int compound_elem; /* dont write this element as individual elem */
@@ -209,6 +191,7 @@ int tplg_build_pcm_dai(snd_tplg_t *tplg, unsigned int type);
 int tplg_copy_data(struct tplg_elem *elem, struct tplg_elem *ref);
 
 int tplg_ref_add(struct tplg_elem *elem, int type, const char* id);
+int tplg_ref_add_elem(struct tplg_elem *elem, struct tplg_elem *elem_ref);
 
 struct tplg_elem *tplg_elem_new(void);
 void tplg_elem_free(struct tplg_elem *elem);
@@ -217,7 +200,7 @@ struct tplg_elem *tplg_elem_lookup(struct list_head *base,
 				const char* id,
 				unsigned int type);
 struct tplg_elem* tplg_elem_new_common(snd_tplg_t *tplg,
-	snd_config_t *cfg, const char *name, enum object_type type);
+	snd_config_t *cfg, const char *name, enum snd_tplg_type type);
 
 static inline void elem_copy_text(char *dest, const char *src, int len)
 {
-- 
2.1.4
