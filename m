From: mengdong.lin@linux.intel.com
Subject: [PATCH 10/22] topology: ABI - Update physical DAI link
	configurations to ABI v5
Date: Thu, 27 Oct 2016 15:13:12 +0800
Message-ID: <efa9a8c580a6232e43359df5b64e7751c496331e.1477549962.git.mengdong.lin@linux.intel.com>
References: <cover.1477549962.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id B8F5426688A
 for <alsa-devel@alsa-project.org>; Thu, 27 Oct 2016 09:11:57 +0200 (CEST)
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

This patch update physicals DAI link config to ABI v5:

- Define the types and ABI struct for runtime supported hardware configs
  e.g. audio hardware formats. The default HW config ID will help topology
  to find the DAI format to set on init. Topology provides this as a
  fallback if such HW settings are not available in ACPI or device tree,
  to avoid hard code in drivers. It's only for config items that can be
  programmed by SW or FW, not for physical things like link connections
  or GPIO used for HP etc.

- Add flags. The flags will be used to configure an existing physical
  links.

- Add private data. The private data is reserved for future extension.

- Add name and stream name to BE DAI links. Kernel can also use name and
  stream name to find an existing physical link and configure it.

Kernel can handle the ABI update in a backward compatible way via patch
'ASoC: topology: Add support to configure existing physical DAI links'.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/sound/asoc.h b/include/sound/asoc.h
index 8e9ee39..9dd4d53 100644
--- a/include/sound/asoc.h
+++ b/include/sound/asoc.h
@@ -30,6 +30,11 @@
  */
 #define SND_SOC_TPLG_STREAM_CONFIG_MAX  8
 
+/*
+ * Maximum number of physical link's hardware configs
+ */
+#define SND_SOC_TPLG_HW_CONFIG_MAX	8
+
 /* individual kcontrol info types - can be mixed with other types */
 #define SND_SOC_TPLG_CTL_VOLSW		1
 #define SND_SOC_TPLG_CTL_VOLSW_SX	2
@@ -280,6 +285,35 @@ struct snd_soc_tplg_stream {
 	__le32 channels;	/* channels */
 } __attribute__((packed));
 
+
+/*
+ * Describes a physical link's runtime supported hardware config,
+ * i.e. hardware audio formats.
+ */
+struct snd_soc_tplg_hw_config {
+	__le32 size;            /* in bytes of this structure */
+	__le32 id;		/* unique ID - - used to match */
+	__le32 fmt;		/* SND_SOC_DAI_FORMAT_ format value */
+	__u8 clock_gated;	/* 1 if clock can be gated to save power */
+	__u8 invert_bclk;	/* 1 for inverted BCLK, 0 for normal */
+	__u8 invert_fsync;	/* 1 for inverted frame clock, 0 for normal */
+	__u8 bclk_master;	/* 1 for master of BCLK, 0 for slave */
+	__u8 fsync_master;	/* 1 for master of FSYNC, 0 for slave */
+	__u8 mclk_direction;    /* 0 for input, 1 for output */
+	__le16 reserved;	/* for 32bit alignment */
+	__le32 mclk_rate;	/* MCLK or SYSCLK freqency in Hz */
+	__le32 bclk_rate;	/* BCLK freqency in Hz */
+	__le32 fsync_rate;	/* frame clock in Hz */
+	__le32 tdm_slots;	/* number of TDM slots in use */
+	__le32 tdm_slot_width;	/* width in bits for each slot */
+	__le32 tx_slots;	/* bit mask for active Tx slots */
+	__le32 rx_slots;	/* bit mask for active Rx slots */
+	__le32 tx_channels;	/* number of Tx channels */
+	__le32 tx_chanmap[SND_SOC_TPLG_MAX_CHAN]; /* array of slot number */
+	__le32 rx_channels;	/* number of Rx channels */
+	__le32 rx_chanmap[SND_SOC_TPLG_MAX_CHAN]; /* array of slot number */
+} __attribute__((packed));
+
 /*
  * Manifest. List totals for each payload type. Not used in parsing, but will
  * be passed to the component driver before any other objects in order for any
@@ -452,9 +486,9 @@ struct snd_soc_tplg_pcm {
 
 
 /*
- * Describes the BE or CC link runtime supported configs or params
+ * Describes the physical link runtime supported configs or params
  *
- * File block representation for BE/CC link config :-
+ * File block representation for physical link config :-
  * +-----------------------------------+-----+
  * | struct snd_soc_tplg_hdr           |  1  |
  * +-----------------------------------+-----+
@@ -464,7 +498,15 @@ struct snd_soc_tplg_pcm {
 struct snd_soc_tplg_link_config {
 	__le32 size;            /* in bytes of this structure */
 	__le32 id;              /* unique ID - used to match */
+	char name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN]; /* name - used to match */
+	char stream_name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN]; /* stream name - used to match */
 	struct snd_soc_tplg_stream stream[SND_SOC_TPLG_STREAM_CONFIG_MAX]; /* supported configs playback and captrure */
 	__le32 num_streams;     /* number of streams */
+	struct snd_soc_tplg_hw_config hw_config[SND_SOC_TPLG_HW_CONFIG_MAX]; /* hw configs */
+	__le32 num_hw_configs;         /* number of hw configs */
+	__le32 default_hw_config_id;   /* default hw config ID for init */
+	__le32 flag_mask;       /* bitmask of flags to configure */
+	__le32 flags;           /* SND_SOC_TPLG_LNK_FLGBIT_* flag value */
+	struct snd_soc_tplg_private priv;
 } __attribute__((packed));
 #endif
-- 
2.5.0
