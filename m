From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 05/10] ASoC: Move DAI structure definitions
	into new soc-dai.h
Date: Fri, 21 Nov 2008 14:48:28 +0000
Message-ID: <1227278913-25313-5-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081121144734.GA25238@rakim.wolfsonmicro.main>
	<1227278913-25313-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227278913-25313-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227278913-25313-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227278913-25313-4-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 55354244DE
	for <alsa-devel@alsa-project.org>; Fri, 21 Nov 2008 15:48:36 +0100 (CET)
In-Reply-To: <1227278913-25313-4-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

ASoC v2 factors most of the contents of soc.h out into separate headers,
including soc-dai.h for the DAI. Factor the existing DAI API out into
this file in order to prepare for backporting of the ASoC v2 DAI API.
Also backport some of Liam's improvements to the documentation.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc-dai.h |  209 +++++++++++++++++++++++++++++++++++++++++++++++
 include/sound/soc.h     |  148 +---------------------------------
 2 files changed, 211 insertions(+), 146 deletions(-)
 create mode 100644 include/sound/soc-dai.h

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
new file mode 100644
index 0000000..08b8f70
--- /dev/null
+++ b/include/sound/soc-dai.h
@@ -0,0 +1,209 @@
+/*
+ * linux/sound/soc-dai.h -- ALSA SoC Layer
+ *
+ * Copyright:	2005-2008 Wolfson Microelectronics. PLC.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Digital Audio Interface (DAI) API.
+ */
+
+#ifndef __LINUX_SND_SOC_DAI_H
+#define __LINUX_SND_SOC_DAI_H
+
+
+#include <linux/list.h>
+
+struct snd_pcm_substream;
+
+/*
+ * DAI hardware audio formats.
+ *
+ * Describes the physical PCM data formating and clocking. Add new formats
+ * to the end.
+ */
+#define SND_SOC_DAIFMT_I2S		0 /* I2S mode */
+#define SND_SOC_DAIFMT_RIGHT_J		1 /* Right Justified mode */
+#define SND_SOC_DAIFMT_LEFT_J		2 /* Left Justified mode */
+#define SND_SOC_DAIFMT_DSP_A		3 /* L data msb after FRM LRC */
+#define SND_SOC_DAIFMT_DSP_B		4 /* L data msb during FRM LRC */
+#define SND_SOC_DAIFMT_AC97		5 /* AC97 */
+
+/* left and right justified also known as MSB and LSB respectively */
+#define SND_SOC_DAIFMT_MSB		SND_SOC_DAIFMT_LEFT_J
+#define SND_SOC_DAIFMT_LSB		SND_SOC_DAIFMT_RIGHT_J
+
+/*
+ * DAI Clock gating.
+ *
+ * DAI bit clocks can be be gated (disabled) when not the DAI is not
+ * sending or receiving PCM data in a frame. This can be used to save power.
+ */
+#define SND_SOC_DAIFMT_CONT		(0 << 4) /* continuous clock */
+#define SND_SOC_DAIFMT_GATED		(1 << 4) /* clock is gated */
+
+/*
+ * DAI Left/Right Clocks.
+ *
+ * Specifies whether the DAI can support different samples for similtanious
+ * playback and capture. This usually requires a seperate physical frame
+ * clock for playback and capture.
+ */
+#define SND_SOC_DAIFMT_SYNC		(0 << 5) /* Tx FRM = Rx FRM */
+#define SND_SOC_DAIFMT_ASYNC		(1 << 5) /* Tx FRM ~ Rx FRM */
+
+/*
+ * TDM
+ *
+ * Time Division Multiplexing. Allows PCM data to be multplexed with other
+ * data on the DAI.
+ */
+#define SND_SOC_DAIFMT_TDM		(1 << 6)
+
+/*
+ * DAI hardware signal inversions.
+ *
+ * Specifies whether the DAI can also support inverted clocks for the specified
+ * format.
+ */
+#define SND_SOC_DAIFMT_NB_NF		(0 << 8) /* normal bit clock + frame */
+#define SND_SOC_DAIFMT_NB_IF		(1 << 8) /* normal bclk + inv frm */
+#define SND_SOC_DAIFMT_IB_NF		(2 << 8) /* invert bclk + nor frm */
+#define SND_SOC_DAIFMT_IB_IF		(3 << 8) /* invert bclk + frm */
+
+/*
+ * DAI hardware clock masters.
+ *
+ * This is wrt the codec, the inverse is true for the interface
+ * i.e. if the codec is clk and frm master then the interface is
+ * clk and frame slave.
+ */
+#define SND_SOC_DAIFMT_CBM_CFM		(0 << 12) /* codec clk & frm master */
+#define SND_SOC_DAIFMT_CBS_CFM		(1 << 12) /* codec clk slave & frm master */
+#define SND_SOC_DAIFMT_CBM_CFS		(2 << 12) /* codec clk master & frame slave */
+#define SND_SOC_DAIFMT_CBS_CFS		(3 << 12) /* codec clk & frm slave */
+
+#define SND_SOC_DAIFMT_FORMAT_MASK	0x000f
+#define SND_SOC_DAIFMT_CLOCK_MASK	0x00f0
+#define SND_SOC_DAIFMT_INV_MASK		0x0f00
+#define SND_SOC_DAIFMT_MASTER_MASK	0xf000
+
+/*
+ * Master Clock Directions
+ */
+#define SND_SOC_CLOCK_IN		0
+#define SND_SOC_CLOCK_OUT		1
+
+struct snd_soc_dai_ops;
+struct snd_soc_dai;
+struct snd_ac97_bus_ops;
+
+/* Digital Audio Interface clocking API.*/
+int snd_soc_dai_set_sysclk(struct snd_soc_dai *dai, int clk_id,
+	unsigned int freq, int dir);
+
+int snd_soc_dai_set_clkdiv(struct snd_soc_dai *dai,
+	int div_id, int div);
+
+int snd_soc_dai_set_pll(struct snd_soc_dai *dai,
+	int pll_id, unsigned int freq_in, unsigned int freq_out);
+
+/* Digital Audio interface formatting */
+int snd_soc_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt);
+
+int snd_soc_dai_set_tdm_slot(struct snd_soc_dai *dai,
+	unsigned int mask, int slots);
+
+int snd_soc_dai_set_tristate(struct snd_soc_dai *dai, int tristate);
+
+/* Digital Audio Interface mute */
+int snd_soc_dai_digital_mute(struct snd_soc_dai *dai, int mute);
+
+/*
+ * Digital Audio Interface.
+ *
+ * Describes the Digital Audio Interface in terms of it's ALSA, DAI and AC97
+ * operations an capabilities. Codec and platfom drivers will register a this
+ * structure for every DAI they have.
+ *
+ * This structure covers the clocking, formating and ALSA operations for each
+ * interface a
+ */
+struct snd_soc_dai_ops {
+	/*
+	 * DAI clocking configuration, all optional.
+	 * Called by soc_card drivers, normally in their hw_params.
+	 */
+	int (*set_sysclk)(struct snd_soc_dai *dai,
+		int clk_id, unsigned int freq, int dir);
+	int (*set_pll)(struct snd_soc_dai *dai,
+		int pll_id, unsigned int freq_in, unsigned int freq_out);
+	int (*set_clkdiv)(struct snd_soc_dai *dai, int div_id, int div);
+
+	/*
+	 * DAI format configuration
+	 * Called by soc_card drivers, normally in their hw_params.
+	 */
+	int (*set_fmt)(struct snd_soc_dai *dai, unsigned int fmt);
+	int (*set_tdm_slot)(struct snd_soc_dai *dai,
+		unsigned int mask, int slots);
+	int (*set_tristate)(struct snd_soc_dai *dai, int tristate);
+
+	/*
+	 * DAI digital mute - optional.
+	 * Called by soc-core to minimise any pops.
+	 */
+	int (*digital_mute)(struct snd_soc_dai *dai, int mute);
+};
+
+/*
+ * Digital Audio Interface runtime data.
+ *
+ * Holds runtime data for a DAI.
+ */
+struct snd_soc_dai {
+	/* DAI description */
+	char *name;
+	unsigned int id;
+	unsigned char type;
+
+	/* DAI callbacks */
+	int (*probe)(struct platform_device *pdev,
+		     struct snd_soc_dai *dai);
+	void (*remove)(struct platform_device *pdev,
+		       struct snd_soc_dai *dai);
+	int (*suspend)(struct platform_device *pdev,
+		struct snd_soc_dai *dai);
+	int (*resume)(struct platform_device *pdev,
+		struct snd_soc_dai *dai);
+
+	/* ops */
+	struct snd_soc_ops ops;
+	struct snd_soc_dai_ops dai_ops;
+
+	/* DAI capabilities */
+	struct snd_soc_pcm_stream capture;
+	struct snd_soc_pcm_stream playback;
+
+	/* DAI runtime info */
+	struct snd_pcm_runtime *runtime;
+	struct snd_soc_codec *codec;
+	unsigned int active;
+	unsigned char pop_wait:1;
+	void *dma_data;
+
+	/* DAI private data */
+	void *private_data;
+
+	/* parent codec/platform */
+	union {
+		struct snd_soc_codec *codec;
+		struct snd_soc_platform *platform;
+	};
+
+	struct list_head list;
+};
+
+#endif
diff --git a/include/sound/soc.h b/include/sound/soc.h
index 3be17b3..e4465f7 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -151,76 +151,6 @@ enum snd_soc_bias_level {
 #define SND_SOC_DAI_PCM		0x4
 #define SND_SOC_DAI_AC97_BUS	0x8	/* for custom i.e. non ac97_codec.c */
 
-/*
- * DAI hardware audio formats
- */
-#define SND_SOC_DAIFMT_I2S		0	/* I2S mode */
-#define SND_SOC_DAIFMT_RIGHT_J	1	/* Right justified mode */
-#define SND_SOC_DAIFMT_LEFT_J	2	/* Left Justified mode */
-#define SND_SOC_DAIFMT_DSP_A	3	/* L data msb after FRM or LRC */
-#define SND_SOC_DAIFMT_DSP_B	4	/* L data msb during FRM or LRC */
-#define SND_SOC_DAIFMT_AC97		5	/* AC97 */
-
-#define SND_SOC_DAIFMT_MSB 	SND_SOC_DAIFMT_LEFT_J
-#define SND_SOC_DAIFMT_LSB	SND_SOC_DAIFMT_RIGHT_J
-
-/*
- * DAI Gating
- */
-#define SND_SOC_DAIFMT_CONT			(0 << 4)	/* continuous clock */
-#define SND_SOC_DAIFMT_GATED		(1 << 4)	/* clock is gated when not Tx/Rx */
-
-/*
- * DAI Sync
- * Synchronous LR (Left Right) clocks and Frame signals.
- */
-#define SND_SOC_DAIFMT_SYNC		(0 << 5)	/* Tx FRM = Rx FRM */
-#define SND_SOC_DAIFMT_ASYNC		(1 << 5)	/* Tx FRM ~ Rx FRM */
-
-/*
- * TDM
- */
-#define SND_SOC_DAIFMT_TDM		(1 << 6)
-
-/*
- * DAI hardware signal inversions
- */
-#define SND_SOC_DAIFMT_NB_NF		(0 << 8)	/* normal bclk + frm */
-#define SND_SOC_DAIFMT_NB_IF		(1 << 8)	/* normal bclk + inv frm */
-#define SND_SOC_DAIFMT_IB_NF		(2 << 8)	/* invert bclk + nor frm */
-#define SND_SOC_DAIFMT_IB_IF		(3 << 8)	/* invert bclk + frm */
-
-/*
- * DAI hardware clock masters
- * This is wrt the codec, the inverse is true for the interface
- * i.e. if the codec is clk and frm master then the interface is
- * clk and frame slave.
- */
-#define SND_SOC_DAIFMT_CBM_CFM	(0 << 12) /* codec clk & frm master */
-#define SND_SOC_DAIFMT_CBS_CFM	(1 << 12) /* codec clk slave & frm master */
-#define SND_SOC_DAIFMT_CBM_CFS	(2 << 12) /* codec clk master & frame slave */
-#define SND_SOC_DAIFMT_CBS_CFS	(3 << 12) /* codec clk & frm slave */
-
-#define SND_SOC_DAIFMT_FORMAT_MASK		0x000f
-#define SND_SOC_DAIFMT_CLOCK_MASK		0x00f0
-#define SND_SOC_DAIFMT_INV_MASK			0x0f00
-#define SND_SOC_DAIFMT_MASTER_MASK		0xf000
-
-
-/*
- * Master Clock Directions
- */
-#define SND_SOC_CLOCK_IN	0
-#define SND_SOC_CLOCK_OUT	1
-
-/*
- * AC97 codec ID's bitmask
- */
-#define SND_SOC_DAI_AC97_ID0	(1 << 0)
-#define SND_SOC_DAI_AC97_ID1	(1 << 1)
-#define SND_SOC_DAI_AC97_ID2	(1 << 2)
-#define SND_SOC_DAI_AC97_ID3	(1 << 3)
-
 struct snd_soc_device;
 struct snd_soc_pcm_stream;
 struct snd_soc_ops;
@@ -260,27 +190,6 @@ int snd_soc_new_ac97_codec(struct snd_soc_codec *codec,
 	struct snd_ac97_bus_ops *ops, int num);
 void snd_soc_free_ac97_codec(struct snd_soc_codec *codec);
 
-/* Digital Audio Interface clocking API.*/
-int snd_soc_dai_set_sysclk(struct snd_soc_dai *dai, int clk_id,
-	unsigned int freq, int dir);
-
-int snd_soc_dai_set_clkdiv(struct snd_soc_dai *dai,
-	int div_id, int div);
-
-int snd_soc_dai_set_pll(struct snd_soc_dai *dai,
-	int pll_id, unsigned int freq_in, unsigned int freq_out);
-
-/* Digital Audio interface formatting */
-int snd_soc_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt);
-
-int snd_soc_dai_set_tdm_slot(struct snd_soc_dai *dai,
-	unsigned int mask, int slots);
-
-int snd_soc_dai_set_tristate(struct snd_soc_dai *dai, int tristate);
-
-/* Digital Audio Interface mute */
-int snd_soc_dai_digital_mute(struct snd_soc_dai *dai, int mute);
-
 /*
  *Controls
  */
@@ -338,61 +247,6 @@ struct snd_soc_ops {
 	int (*trigger)(struct snd_pcm_substream *, int);
 };
 
-/* ASoC DAI ops */
-struct snd_soc_dai_ops {
-	/* DAI clocking configuration */
-	int (*set_sysclk)(struct snd_soc_dai *dai,
-		int clk_id, unsigned int freq, int dir);
-	int (*set_pll)(struct snd_soc_dai *dai,
-		int pll_id, unsigned int freq_in, unsigned int freq_out);
-	int (*set_clkdiv)(struct snd_soc_dai *dai, int div_id, int div);
-
-	/* DAI format configuration */
-	int (*set_fmt)(struct snd_soc_dai *dai, unsigned int fmt);
-	int (*set_tdm_slot)(struct snd_soc_dai *dai,
-		unsigned int mask, int slots);
-	int (*set_tristate)(struct snd_soc_dai *dai, int tristate);
-
-	/* digital mute */
-	int (*digital_mute)(struct snd_soc_dai *dai, int mute);
-};
-
-/* SoC  DAI (Digital Audio Interface) */
-struct snd_soc_dai {
-	/* DAI description */
-	char *name;
-	unsigned int id;
-	unsigned char type;
-
-	/* DAI callbacks */
-	int (*probe)(struct platform_device *pdev,
-		     struct snd_soc_dai *dai);
-	void (*remove)(struct platform_device *pdev,
-		       struct snd_soc_dai *dai);
-	int (*suspend)(struct platform_device *pdev,
-		struct snd_soc_dai *dai);
-	int (*resume)(struct platform_device *pdev,
-		struct snd_soc_dai *dai);
-
-	/* ops */
-	struct snd_soc_ops ops;
-	struct snd_soc_dai_ops dai_ops;
-
-	/* DAI capabilities */
-	struct snd_soc_pcm_stream capture;
-	struct snd_soc_pcm_stream playback;
-
-	/* DAI runtime info */
-	struct snd_pcm_runtime *runtime;
-	struct snd_soc_codec *codec;
-	unsigned int active;
-	unsigned char pop_wait:1;
-	void *dma_data;
-
-	/* DAI private data */
-	void *private_data;
-};
-
 /* SoC Audio Codec */
 struct snd_soc_codec {
 	char *name;
@@ -543,4 +397,6 @@ struct soc_enum {
 	void *dapm;
 };
 
+#include <sound/soc-dai.h>
+
 #endif
-- 
1.5.6.5
