From: mengdong.lin@linux.intel.com
Subject: [PATCH v3 4/8] ASoC: topology: ABI - Add HW
	configurations to BE DAI links
Date: Thu, 29 Sep 2016 14:09:24 +0800
Message-ID: <c8b6f40c2407f173c4ac402df465c02f36fbb78a.1475127338.git.mengdong.lin@linux.intel.com>
References: <cover.1475127338.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 222482614A0
 for <alsa-devel@alsa-project.org>; Thu, 29 Sep 2016 08:02:48 +0200 (CEST)
In-Reply-To: <cover.1475127338.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, rakesh.a.ughreja@intel.com, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

Define the types and ABI struct for runtime supported hardware configs
of backend DAI links, e.g. audio hardware formats.

The default HW config ID will help topology to find the DAI format to set
on init.

Topology provides this as a fallback if such HW settings are not available
in ACPI or device tree, to avoid hard code in drivers.

It's only for config items that can be programmed by SW or FW, not for
physical things like link connections or GPIO used for HP etc.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
index de563d6..5d06d65 100644
--- a/include/uapi/sound/asoc.h
+++ b/include/uapi/sound/asoc.h
@@ -39,6 +39,11 @@
  */
 #define SND_SOC_TPLG_STREAM_CONFIG_MAX  8
 
+/*
+ * Maximum number of BE/CC link HW configs
+ */
+#define SND_SOC_TPLG_HW_CONFIG_MAX	8
+
 /* individual kcontrol info types - can be mixed with other types */
 #define SND_SOC_TPLG_CTL_VOLSW		1
 #define SND_SOC_TPLG_CTL_VOLSW_SX	2
@@ -292,6 +297,35 @@ struct snd_soc_tplg_stream {
 	__le32 channels;	/* channels */
 } __attribute__((packed));
 
+
+/*
+ * Describes a single BE or CC link runtime supported hardware config,
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
@@ -480,6 +514,9 @@ struct snd_soc_tplg_link_config {
 	__le32 id;              /* unique ID - used to match */
 	struct snd_soc_tplg_stream stream[SND_SOC_TPLG_STREAM_CONFIG_MAX]; /* supported configs playback and captrure */
 	__le32 num_streams;     /* number of streams */
+	struct snd_soc_tplg_hw_config hw_config[SND_SOC_TPLG_HW_CONFIG_MAX]; /* hw configs */
+	__le32 num_hw_configs;         /* number of hw configs */
+	__le32 default_hw_config_id;   /* default hw config ID for init */
 } __attribute__((packed));
 
 /*
-- 
2.5.0
