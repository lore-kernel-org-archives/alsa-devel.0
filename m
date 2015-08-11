From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH v3 2/3] topology: Add C templates structure for
	building topology from C programs
Date: Tue, 11 Aug 2015 18:23:16 +0100
Message-ID: <1439313797-6169-3-git-send-email-liam.r.girdwood@linux.intel.com>
References: <1439313797-6169-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A88526056B
 for <alsa-devel@alsa-project.org>; Tue, 11 Aug 2015 19:27:13 +0200 (CEST)
In-Reply-To: <1439313797-6169-1-git-send-email-liam.r.girdwood@linux.intel.com>
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
 include/topology.h        | 176 ++++++++++++++++++++++++++++++++++++++++++++++
 src/topology/tplg_local.h |  18 -----
 2 files changed, 176 insertions(+), 18 deletions(-)

diff --git a/include/topology.h b/include/topology.h
index 0cb2d79..aee43de 100644
--- a/include/topology.h
+++ b/include/topology.h
@@ -456,9 +456,30 @@ extern "C" {
  *
  */
 
+/** Maximum number of channels supported in one control */
+#define SND_TPLG_MAX_CHAN		8
+
 /** Topology context */
 typedef struct snd_tplg snd_tplg_t;
 
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
 /**
  * \brief Create a new topology parser instance.
  * \return New topology parser instance
@@ -488,6 +509,161 @@ int snd_tplg_build_file(snd_tplg_t *tplg, const char *infile,
  */
 void snd_tplg_verbose(snd_tplg_t *tplg, int verbose);
 
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
 /* \} */
 
 #ifdef __cplusplus
diff --git a/src/topology/tplg_local.h b/src/topology/tplg_local.h
index 3982cc7..ec63045 100644
--- a/src/topology/tplg_local.h
+++ b/src/topology/tplg_local.h
@@ -39,24 +39,6 @@
 struct tplg_ref;
 struct tplg_elem;
 
-/** Topology object types */
-enum snd_tplg_type {
-	SND_TPLG_TYPE_TLV = 0,		/*!< TLV Data */
-	SND_TPLG_TYPE_MIXER,		/*!< Mixer control*/
-	SND_TPLG_TYPE_ENUM,		/*!< Enumerated control */
-	SND_TPLG_TYPE_TEXT,		/*!< Text data */
-	SND_TPLG_TYPE_DATA,		/*!< Private data */
-	SND_TPLG_TYPE_BYTES,		/*!< Byte control */
-	SND_TPLG_TYPE_STREAM_CONFIG,	/*!< PCM Stream configuration */
-	SND_TPLG_TYPE_STREAM_CAPS,	/*!< PCM Stream capabilities */
-	SND_TPLG_TYPE_PCM,		/*!< PCM stream device */
-	SND_TPLG_TYPE_DAPM_WIDGET,	/*!< DAPM widget */
-	SND_TPLG_TYPE_DAPM_GRAPH,	/*!< DAPM graph elements */
-	SND_TPLG_TYPE_BE,		/*!< BE DAI link */
-	SND_TPLG_TYPE_CC,		/*!< Hostless codec <-> codec link */
-	SND_TPLG_TYPE_MANIFEST,		/*!< Topology manifest */
-};
-
 struct snd_tplg {
 
 	/* opaque vendor data */
-- 
2.1.4
