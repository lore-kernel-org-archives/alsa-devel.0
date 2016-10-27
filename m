From: mengdong.lin@linux.intel.com
Subject: [PATCH 13/22] topology: Parse HW configurations of
	physical DAI links defined by C API
Date: Thu, 27 Oct 2016 15:13:42 +0800
Message-ID: <b4997cf09aba52de6cf591913128f9f6081429cc.1477549962.git.mengdong.lin@linux.intel.com>
References: <cover.1477549962.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 15B6F267330
 for <alsa-devel@alsa-project.org>; Thu, 27 Oct 2016 09:12:27 +0200 (CEST)
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

From: Mengdong Lin <mengdong.lin@linux.intel.com>

Add HW configurations to C API template of physical link configuration.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/topology.h b/include/topology.h
index d1ce69c..8323dd9 100644
--- a/include/topology.h
+++ b/include/topology.h
@@ -898,6 +898,33 @@ struct snd_tplg_pcm_template {
 	struct snd_tplg_stream_template stream[0]; /*!< supported configs */
 };
 
+ /** \struct snd_tplg_hw_config_template
+ * \brief Template type to describe a physical link runtime supported
+ * hardware config, i.e. hardware audio formats.
+ */
+struct snd_tplg_hw_config_template {
+	int id;                         /* unique ID - - used to match */
+	unsigned int fmt;               /* SND_SOC_DAI_FORMAT_ format value */
+	unsigned char clock_gated;      /* 1 if clock can be gated to save power */
+	unsigned char  invert_bclk;     /* 1 for inverted BCLK, 0 for normal */
+	unsigned char  invert_fsync;    /* 1 for inverted frame clock, 0 for normal */
+	unsigned char  bclk_master;     /* 1 for master of BCLK, 0 for slave */
+	unsigned char  fsync_master;    /* 1 for master of FSYNC, 0 for slave */
+	unsigned char  mclk_direction;  /* 0 for input, 1 for output */
+	unsigned short reserved;        /* for 32bit alignment */
+	unsigned int mclk_rate;	        /* MCLK or SYSCLK freqency in Hz */
+	unsigned int bclk_rate;	        /* BCLK freqency in Hz */
+	unsigned int fsync_rate;        /* frame clock in Hz */
+	unsigned int tdm_slots;         /* number of TDM slots in use */
+	unsigned int tdm_slot_width;    /* width in bits for each slot */
+	unsigned int tx_slots;          /* bit mask for active Tx slots */
+	unsigned int rx_slots;          /* bit mask for active Rx slots */
+	unsigned int tx_channels;       /* number of Tx channels */
+	unsigned int *tx_chanmap;       /* array of slot number */
+	unsigned int rx_channels;       /* number of Rx channels */
+	unsigned int *rx_chanmap;       /* array of slot number */
+};
+
 /** \struct snd_tplg_link_template
  * \brief Template type for BE and CC DAI Links.
  */
@@ -905,7 +932,11 @@ struct snd_tplg_link_template {
 	const char *name;	/*!< link name */
 	int id;	/*!< unique ID - used to match with existing BE and CC links */
 	int num_streams;	/*!< number of configs */
-	struct snd_tplg_stream_template stream[0]; /*!< supported configs */
+	struct snd_tplg_stream_template *stream;       /*!< supported configs */
+
+	struct snd_tplg_hw_config_template *hw_config; /*!< supported HW configs */
+	int num_hw_configs;		/* number of hw configs */
+	int default_hw_config_id;       /* default hw config ID for init */
 };
 
 /** \struct snd_tplg_obj_template
diff --git a/src/topology/elem.c b/src/topology/elem.c
index 724bf26..f7ff070 100644
--- a/src/topology/elem.c
+++ b/src/topology/elem.c
@@ -193,6 +193,7 @@ struct tplg_elem* tplg_elem_new_common(snd_tplg_t *tplg,
 		obj_size = sizeof(struct snd_soc_tplg_pcm);
 		break;
 	case SND_TPLG_TYPE_BE:
+	case SND_TPLG_TYPE_LINK:
 		list_add_tail(&elem->list, &tplg->be_list);
 		obj_size = sizeof(struct snd_soc_tplg_link_config);
 		break;
diff --git a/src/topology/parser.c b/src/topology/parser.c
index ed5da87..238943c 100644
--- a/src/topology/parser.c
+++ b/src/topology/parser.c
@@ -348,6 +348,7 @@ int snd_tplg_add_object(snd_tplg_t *tplg, snd_tplg_obj_template_t *t)
 		return tplg_add_graph_object(tplg, t);
 	case SND_TPLG_TYPE_PCM:
 		return tplg_add_pcm_object(tplg, t);
+	case SND_TPLG_TYPE_LINK:
 	case SND_TPLG_TYPE_BE:
 	case SND_TPLG_TYPE_CC:
 		return tplg_add_link_object(tplg, t);
diff --git a/src/topology/pcm.c b/src/topology/pcm.c
index 32beeb7..58efc2f 100644
--- a/src/topology/pcm.c
+++ b/src/topology/pcm.c
@@ -168,7 +168,7 @@ static int build_link(snd_tplg_t *tplg, struct tplg_elem *elem)
 	return 0;
 }
 
-/* build BE/CC DAI link configurations */
+/* build physical DAI link configurations */
 int tplg_build_links(snd_tplg_t *tplg, unsigned int type)
 {
 	struct list_head *base, *pos;
@@ -176,6 +176,7 @@ int tplg_build_links(snd_tplg_t *tplg, unsigned int type)
 	int err = 0;
 
 	switch (type) {
+	case SND_TPLG_TYPE_LINK:
 	case SND_TPLG_TYPE_BE:
 		base = &tplg->be_list;
 		break;
@@ -189,11 +190,6 @@ int tplg_build_links(snd_tplg_t *tplg, unsigned int type)
 	list_for_each(pos, base) {
 
 		elem = list_entry(pos, struct tplg_elem, list);
-		if (elem->type != type) {
-			SNDERR("error: invalid elem '%s'\n", elem->id);
-			return -EINVAL;
-		}
-
 		err =  build_link(tplg, elem);
 		if (err < 0)
 			return err;
@@ -759,6 +755,47 @@ int tplg_add_pcm_object(snd_tplg_t *tplg, snd_tplg_obj_template_t *t)
 	return 0;
 }
 
+/* Set link HW config from C API template */
+static int set_link_hw_config(struct snd_soc_tplg_hw_config *cfg,
+			struct snd_tplg_hw_config_template *tpl)
+{
+	int i;
+
+	cfg->size = sizeof(*cfg);
+	cfg->id = tpl->id;
+
+	cfg->fmt = tpl->fmt;
+	cfg->clock_gated = tpl->clock_gated;
+	cfg->invert_bclk = tpl->invert_bclk;
+	cfg->invert_fsync = tpl->invert_fsync;
+	cfg->bclk_master = tpl->bclk_master;
+	cfg->fsync_master = tpl->fsync_master;
+	cfg->mclk_direction = tpl->mclk_direction;
+	cfg->reserved = tpl->reserved;
+	cfg->mclk_rate = tpl->mclk_rate;
+	cfg->bclk_rate = tpl->bclk_rate;
+	cfg->fsync_rate = tpl->fsync_rate;
+
+	cfg->tdm_slots = tpl->tdm_slots;
+	cfg->tdm_slot_width = tpl->tdm_slot_width;
+	cfg->tx_slots = tpl->tx_slots;
+	cfg->rx_slots = tpl->rx_slots;
+
+	if (cfg->tx_channels > SND_SOC_TPLG_MAX_CHAN
+		|| cfg->rx_channels > SND_SOC_TPLG_MAX_CHAN)
+		return -EINVAL;
+
+	cfg->tx_channels = tpl->tx_channels;
+	for (i = 0; i < cfg->tx_channels; i++)
+		cfg->tx_chanmap[i] = tpl->tx_chanmap[i];
+
+	cfg->rx_channels = tpl->rx_channels;
+	for (i = 0; i < cfg->rx_channels; i++)
+		cfg->rx_chanmap[i] = tpl->rx_chanmap[i];
+
+	return 0;
+}
+
 /* Add a physical DAI link element from C API */
 int tplg_add_link_object(snd_tplg_t *tplg, snd_tplg_obj_template_t *t)
 {
@@ -789,5 +826,12 @@ int tplg_add_link_object(snd_tplg_t *tplg, snd_tplg_obj_template_t *t)
 	for (i = 0; i < link->num_streams; i++)
 		tplg_add_stream_object(&link->stream[i], &link_tpl->stream[i]);
 
+	/* HW configs */
+	if (link_tpl->num_hw_configs > SND_SOC_TPLG_HW_CONFIG_MAX)
+		return -EINVAL;
+	link->num_hw_configs = link_tpl->num_hw_configs;
+	link->default_hw_config_id = link_tpl->default_hw_config_id;
+	for (i = 0; i < link->num_hw_configs; i++)
+		set_link_hw_config(&link->hw_config[i], &link_tpl->hw_config[i]);
 	return 0;
 }
-- 
2.5.0
