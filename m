From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v3 04/14] ASoC: SOF: Add support for IPC IO
	between DSP and Host
Date: Tue, 11 Dec 2018 15:23:08 -0600
Message-ID: <20181211212318.28644-5-pierre-louis.bossart@linux.intel.com>
References: <20181211212318.28644-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20181211212318.28644-1-pierre-louis.bossart@linux.intel.com>
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
Cc: Daniel Baluta <daniel.baluta@gmail.com>, andriy.shevchenko@intel.com, tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Alan Cox <alan@linux.intel.com>, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Liam Girdwood <liam.r.girdwood@linux.intel.com>

Define an IPC ABI for all host <--> DSP communication. This ABI should
be transport agnostic. i.e. it should work on MMIO and SPI/I2C style
interfaces.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/sof/control.h   | 125 ++++++
 include/sound/sof/dai-intel.h | 175 ++++++++
 include/sound/sof/dai.h       |  75 ++++
 include/sound/sof/header.h    | 158 +++++++
 include/sound/sof/info.h      | 118 +++++
 include/sound/sof/pm.h        |  48 ++
 include/sound/sof/stream.h    | 149 +++++++
 include/sound/sof/trace.h     |  66 +++
 sound/soc/sof/ipc.c           | 813 ++++++++++++++++++++++++++++++++++
 9 files changed, 1727 insertions(+)
 create mode 100644 include/sound/sof/control.h
 create mode 100644 include/sound/sof/dai-intel.h
 create mode 100644 include/sound/sof/dai.h
 create mode 100644 include/sound/sof/header.h
 create mode 100644 include/sound/sof/info.h
 create mode 100644 include/sound/sof/pm.h
 create mode 100644 include/sound/sof/stream.h
 create mode 100644 include/sound/sof/trace.h
 create mode 100644 sound/soc/sof/ipc.c

diff --git a/include/sound/sof/control.h b/include/sound/sof/control.h
new file mode 100644
index 000000000000..7d7d2eba7d76
--- /dev/null
+++ b/include/sound/sof/control.h
@@ -0,0 +1,125 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/*
+ * This file is provided under a dual BSD/GPLv2 license.  When using or
+ * redistributing this file, you may do so under either license.
+ *
+ * Copyright(c) 2018 Intel Corporation. All rights reserved.
+ */
+
+#ifndef __INCLUDE_SOUND_SOF_CONTROL_H__
+#define __INCLUDE_SOUND_SOF_CONTROL_H__
+
+#include <uapi/sound/sof/header.h>
+#include <sound/sof/header.h>
+
+/*
+ * Component Mixers and Controls
+ */
+
+/* channel positions - uses same values as ALSA */
+enum sof_ipc_chmap {
+	SOF_CHMAP_UNKNOWN = 0,
+	SOF_CHMAP_NA,		/**< N/A, silent */
+	SOF_CHMAP_MONO,		/**< mono stream */
+	SOF_CHMAP_FL,		/**< front left */
+	SOF_CHMAP_FR,		/**< front right */
+	SOF_CHMAP_RL,		/**< rear left */
+	SOF_CHMAP_RR,		/**< rear right */
+	SOF_CHMAP_FC,		/**< front centre */
+	SOF_CHMAP_LFE,		/**< LFE */
+	SOF_CHMAP_SL,		/**< side left */
+	SOF_CHMAP_SR,		/**< side right */
+	SOF_CHMAP_RC,		/**< rear centre */
+	SOF_CHMAP_FLC,		/**< front left centre */
+	SOF_CHMAP_FRC,		/**< front right centre */
+	SOF_CHMAP_RLC,		/**< rear left centre */
+	SOF_CHMAP_RRC,		/**< rear right centre */
+	SOF_CHMAP_FLW,		/**< front left wide */
+	SOF_CHMAP_FRW,		/**< front right wide */
+	SOF_CHMAP_FLH,		/**< front left high */
+	SOF_CHMAP_FCH,		/**< front centre high */
+	SOF_CHMAP_FRH,		/**< front right high */
+	SOF_CHMAP_TC,		/**< top centre */
+	SOF_CHMAP_TFL,		/**< top front left */
+	SOF_CHMAP_TFR,		/**< top front right */
+	SOF_CHMAP_TFC,		/**< top front centre */
+	SOF_CHMAP_TRL,		/**< top rear left */
+	SOF_CHMAP_TRR,		/**< top rear right */
+	SOF_CHMAP_TRC,		/**< top rear centre */
+	SOF_CHMAP_TFLC,		/**< top front left centre */
+	SOF_CHMAP_TFRC,		/**< top front right centre */
+	SOF_CHMAP_TSL,		/**< top side left */
+	SOF_CHMAP_TSR,		/**< top side right */
+	SOF_CHMAP_LLFE,		/**< left LFE */
+	SOF_CHMAP_RLFE,		/**< right LFE */
+	SOF_CHMAP_BC,		/**< bottom centre */
+	SOF_CHMAP_BLC,		/**< bottom left centre */
+	SOF_CHMAP_BRC,		/**< bottom right centre */
+	SOF_CHMAP_LAST = SOF_CHMAP_BRC,
+};
+
+/* control data type and direction */
+enum sof_ipc_ctrl_type {
+	/*  per channel data - uses struct sof_ipc_ctrl_value_chan */
+	SOF_CTRL_TYPE_VALUE_CHAN_GET = 0,
+	SOF_CTRL_TYPE_VALUE_CHAN_SET,
+	/* component data - uses struct sof_ipc_ctrl_value_comp */
+	SOF_CTRL_TYPE_VALUE_COMP_GET,
+	SOF_CTRL_TYPE_VALUE_COMP_SET,
+	/* bespoke data - struct struct sof_abi_hdr */
+	SOF_CTRL_TYPE_DATA_GET,
+	SOF_CTRL_TYPE_DATA_SET,
+};
+
+/* control command type */
+enum sof_ipc_ctrl_cmd {
+	SOF_CTRL_CMD_VOLUME = 0, /**< maps to ALSA volume style controls */
+	SOF_CTRL_CMD_ENUM,	/**< maps to ALSA enum style controls */
+	SOF_CTRL_CMD_SWITCH,	/**< maps to ALSA switch style controls */
+	SOF_CTRL_CMD_BINARY,	/**< maps to ALSA binary style controls */
+};
+
+/* generic channel mapped value data */
+struct sof_ipc_ctrl_value_chan {
+	uint32_t channel;	/**< channel map - enum sof_ipc_chmap */
+	uint32_t value;
+} __packed;
+
+/* generic component mapped value data */
+struct sof_ipc_ctrl_value_comp {
+	uint32_t index;	/**< component source/sink/control index in control */
+	union {
+		uint32_t uvalue;
+		int32_t svalue;
+	};
+} __packed;
+
+/* generic control data */
+struct sof_ipc_ctrl_data {
+	struct sof_ipc_reply rhdr;
+	uint32_t comp_id;
+
+	/* control access and data type */
+	uint32_t type;		/**< enum sof_ipc_ctrl_type */
+	uint32_t cmd;		/**< enum sof_ipc_ctrl_cmd */
+	uint32_t index;		/**< control index for comps > 1 control */
+
+	/* control data - can either be appended or DMAed from host */
+	struct sof_ipc_host_buffer buffer;
+	uint32_t num_elems;	/**< in array elems or bytes for data type */
+
+	/* reserved for future use */
+	uint32_t reserved[8];
+
+	/* control data - add new types if needed */
+	union {
+		/* channel values can be used by volume type controls */
+		struct sof_ipc_ctrl_value_chan chanv[0];
+		/* component values used by routing controls like mux, mixer */
+		struct sof_ipc_ctrl_value_comp compv[0];
+		/* data can be used by binary controls */
+		struct sof_abi_hdr data[0];
+	};
+} __packed;
+
+#endif
diff --git a/include/sound/sof/dai-intel.h b/include/sound/sof/dai-intel.h
new file mode 100644
index 000000000000..700e1ed23450
--- /dev/null
+++ b/include/sound/sof/dai-intel.h
@@ -0,0 +1,175 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/*
+ * This file is provided under a dual BSD/GPLv2 license.  When using or
+ * redistributing this file, you may do so under either license.
+ *
+ * Copyright(c) 2018 Intel Corporation. All rights reserved.
+ */
+
+#ifndef __INCLUDE_SOUND_SOF_DAI_INTEL_H__
+#define __INCLUDE_SOUND_SOF_DAI_INTEL_H__
+
+#include <sound/sof/header.h>
+
+ /* ssc1: TINTE */
+#define SOF_DAI_INTEL_SSP_QUIRK_TINTE		(1 << 0)
+ /* ssc1: PINTE */
+#define SOF_DAI_INTEL_SSP_QUIRK_PINTE		(1 << 1)
+ /* ssc2: SMTATF */
+#define SOF_DAI_INTEL_SSP_QUIRK_SMTATF		(1 << 2)
+ /* ssc2: MMRATF */
+#define SOF_DAI_INTEL_SSP_QUIRK_MMRATF		(1 << 3)
+ /* ssc2: PSPSTWFDFD */
+#define SOF_DAI_INTEL_SSP_QUIRK_PSPSTWFDFD	(1 << 4)
+ /* ssc2: PSPSRWFDFD */
+#define SOF_DAI_INTEL_SSP_QUIRK_PSPSRWFDFD	(1 << 5)
+ /* here is the possibility to define others aux macros */
+
+#define SOF_DAI_INTEL_SSP_FRAME_PULSE_WIDTH_MAX		38
+#define SOF_DAI_INTEL_SSP_SLOT_PADDING_MAX		31
+
+/* SSP clocks control settings
+ *
+ * Macros for clks_control field in sof_ipc_dai_ssp_params struct.
+ */
+
+/* mclk 0 disable */
+#define SOF_DAI_INTEL_SSP_MCLK_0_DISABLE		BIT(0)
+/* mclk 1 disable */
+#define SOF_DAI_INTEL_SSP_MCLK_1_DISABLE		BIT(1)
+/* mclk keep active */
+#define SOF_DAI_INTEL_SSP_CLKCTRL_MCLK_KA		BIT(2)
+/* bclk keep active */
+#define SOF_DAI_INTEL_SSP_CLKCTRL_BCLK_KA		BIT(3)
+/* fs keep active */
+#define SOF_DAI_INTEL_SSP_CLKCTRL_FS_KA			BIT(4)
+/* bclk idle */
+#define SOF_DAI_INTEL_SSP_CLKCTRL_BCLK_IDLE_HIGH	BIT(5)
+
+/* SSP Configuration Request - SOF_IPC_DAI_SSP_CONFIG */
+struct sof_ipc_dai_ssp_params {
+	struct sof_ipc_hdr hdr;
+	uint16_t reserved1;
+	uint16_t mclk_id;
+
+	uint32_t mclk_rate;	/* mclk frequency in Hz */
+	uint32_t fsync_rate;	/* fsync frequency in Hz */
+	uint32_t bclk_rate;	/* bclk frequency in Hz */
+
+	/* TDM */
+	uint32_t tdm_slots;
+	uint32_t rx_slots;
+	uint32_t tx_slots;
+
+	/* data */
+	uint32_t sample_valid_bits;
+	uint16_t tdm_slot_width;
+	uint16_t reserved2;	/* alignment */
+
+	/* MCLK */
+	uint32_t mclk_direction;
+
+	uint16_t frame_pulse_width;
+	uint16_t tdm_per_slot_padding_flag;
+	uint32_t clks_control;
+	uint32_t quirks;
+} __packed;
+
+/* HDA Configuration Request - SOF_IPC_DAI_HDA_CONFIG */
+struct sof_ipc_dai_hda_params {
+	struct sof_ipc_hdr hdr;
+	uint32_t link_dma_ch;
+} __packed;
+
+/* DMIC Configuration Request - SOF_IPC_DAI_DMIC_CONFIG */
+
+/* This struct is defined per 2ch PDM controller available in the platform.
+ * Normally it is sufficient to set the used microphone specific enables to 1
+ * and keep other parameters as zero. The customizations are:
+ *
+ * 1. If a device mixes different microphones types with different polarity
+ * and/or the absolute polarity matters the PCM signal from a microphone
+ * can be inverted with the controls.
+ *
+ * 2. If the microphones in a stereo pair do not appear in captured stream
+ * in desired order due to board schematics choises they can be swapped with
+ * the clk_edge parameter.
+ *
+ * 3. If PDM bit errors are seen in capture (poor quality) the skew parameter
+ * that delays the sampling time of data by half cycles of DMIC source clock
+ * can be tried for improvement. However there is no guarantee for this to fix
+ * data integrity problems.
+ */
+struct sof_ipc_dai_dmic_pdm_ctrl {
+	struct sof_ipc_hdr hdr;
+	uint16_t id;		/**< PDM controller ID */
+
+	uint16_t enable_mic_a;	/**< Use A (left) channel mic (0 or 1)*/
+	uint16_t enable_mic_b;	/**< Use B (right) channel mic (0 or 1)*/
+
+	uint16_t polarity_mic_a; /**< Optionally invert mic A signal (0 or 1) */
+	uint16_t polarity_mic_b; /**< Optionally invert mic B signal (0 or 1) */
+
+	uint16_t clk_edge;	/**< Optionally swap data clock edge (0 or 1) */
+	uint16_t skew;		/**< Adjust PDM data sampling vs. clock (0..15) */
+
+	uint16_t reserved[3];	/**< Make sure the total size is 4 bytes aligned */
+} __packed;
+
+/* This struct contains the global settings for all 2ch PDM controllers. The
+ * version number used in configuration data is checked vs. version used by
+ * device driver src/drivers/dmic.c need to match. It is incremented from
+ * initial value 1 if updates done for the to driver would alter the operation
+ * of the microhone.
+ *
+ * Note: The microphone clock (pdmclk_min, pdmclk_max, duty_min, duty_max)
+ * parameters need to be set as defined in microphone data sheet. E.g. clock
+ * range 1.0 - 3.2 MHz is usually supported microphones. Some microphones are
+ * multi-mode capable and there may be denied mic clock frequencies between
+ * the modes. In such case set the clock range limits of the desired mode to
+ * avoid the driver to set clock to an illegal rate.
+ *
+ * The duty cycle could be set to 48-52% if not known. Generally these
+ * parameters can be altered within data sheet specified limits to match
+ * required audio application performance power.
+ *
+ * The microphone clock needs to be usually about 50-80 times the used audio
+ * sample rate. With highest sample rates above 48 kHz this can relaxed
+ * somewhat.
+ *
+ * The parameter wake_up_time describes how long time the microphone needs
+ * for the data line to produce valid output from mic clock start. The driver
+ * will mute the captured audio for the given time. The min_clock_on_time
+ * parameter is used to prevent too short clock bursts to happen. The driver
+ * will keep the clock active after capture stop if this time is not yet
+ * met. The unit for both is microseconds (us). Exceed of 100 ms will be
+ * treated as an error.
+ */
+struct sof_ipc_dai_dmic_params {
+	struct sof_ipc_hdr hdr;
+	uint32_t driver_ipc_version;	/**< Version (1..N) */
+
+	uint32_t pdmclk_min;	/**< Minimum microphone clock in Hz (100000..N) */
+	uint32_t pdmclk_max;	/**< Maximum microphone clock in Hz (min...N) */
+
+	uint32_t fifo_fs_a;	/**< FIFO A sample rate in Hz (8000..96000) */
+	uint32_t fifo_fs_b;	/**< FIFO B sample rate in Hz (8000..96000) */
+	uint16_t fifo_bits_a;	/**< FIFO A word length (16 or 32) */
+	uint16_t fifo_bits_b;	/**< FIFO B word length (16 or 32) */
+
+	uint16_t duty_min;	/**< Min. mic clock duty cycle in % (20..80) */
+	uint16_t duty_max;	/**< Max. mic clock duty cycle in % (min..80) */
+
+	uint32_t num_pdm_active; /**< Number of active pdm controllers */
+
+	uint32_t wake_up_time;      /**< Time from clock start to data (us) */
+	uint32_t min_clock_on_time; /**< Min. time that clk is kept on (us) */
+
+	/* reserved for future use */
+	uint32_t reserved[6];
+
+	/**< variable number of pdm controller config */
+	struct sof_ipc_dai_dmic_pdm_ctrl pdm[0];
+} __packed;
+
+#endif
diff --git a/include/sound/sof/dai.h b/include/sound/sof/dai.h
new file mode 100644
index 000000000000..3b67c93ff101
--- /dev/null
+++ b/include/sound/sof/dai.h
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/*
+ * This file is provided under a dual BSD/GPLv2 license.  When using or
+ * redistributing this file, you may do so under either license.
+ *
+ * Copyright(c) 2018 Intel Corporation. All rights reserved.
+ */
+
+#ifndef __INCLUDE_SOUND_SOF_DAI_H__
+#define __INCLUDE_SOUND_SOF_DAI_H__
+
+#include <sound/sof/header.h>
+#include <sound/sof/dai-intel.h>
+
+/*
+ * DAI Configuration.
+ *
+ * Each different DAI type will have it's own structure and IPC cmd.
+ */
+
+#define SOF_DAI_FMT_I2S		1 /**< I2S mode */
+#define SOF_DAI_FMT_RIGHT_J	2 /**< Right Justified mode */
+#define SOF_DAI_FMT_LEFT_J	3 /**< Left Justified mode */
+#define SOF_DAI_FMT_DSP_A	4 /**< L data MSB after FRM LRC */
+#define SOF_DAI_FMT_DSP_B	5 /**< L data MSB during FRM LRC */
+#define SOF_DAI_FMT_PDM		6 /**< Pulse density modulation */
+
+#define SOF_DAI_FMT_CONT	(1 << 4) /**< continuous clock */
+#define SOF_DAI_FMT_GATED	(0 << 4) /**< clock is gated */
+
+#define SOF_DAI_FMT_NB_NF	(0 << 8) /**< normal bit clock + frame */
+#define SOF_DAI_FMT_NB_IF	(2 << 8) /**< normal BCLK + inv FRM */
+#define SOF_DAI_FMT_IB_NF	(3 << 8) /**< invert BCLK + nor FRM */
+#define SOF_DAI_FMT_IB_IF	(4 << 8) /**< invert BCLK + FRM */
+
+#define SOF_DAI_FMT_CBM_CFM	(0 << 12) /**< codec clk & FRM master */
+#define SOF_DAI_FMT_CBS_CFM	(2 << 12) /**< codec clk slave & FRM master */
+#define SOF_DAI_FMT_CBM_CFS	(3 << 12) /**< codec clk master & frame slave */
+#define SOF_DAI_FMT_CBS_CFS	(4 << 12) /**< codec clk & FRM slave */
+
+#define SOF_DAI_FMT_FORMAT_MASK		0x000f
+#define SOF_DAI_FMT_CLOCK_MASK		0x00f0
+#define SOF_DAI_FMT_INV_MASK		0x0f00
+#define SOF_DAI_FMT_MASTER_MASK		0xf000
+
+/** \brief Types of DAI */
+enum sof_ipc_dai_type {
+	SOF_DAI_INTEL_NONE = 0,		/**< None */
+	SOF_DAI_INTEL_SSP,		/**< Intel SSP */
+	SOF_DAI_INTEL_DMIC,		/**< Intel DMIC */
+	SOF_DAI_INTEL_HDA,		/**< Intel HD/A */
+};
+
+/* general purpose DAI configuration */
+struct sof_ipc_dai_config {
+	struct sof_ipc_cmd_hdr hdr;
+	uint32_t type;		/**< DAI type - enum sof_ipc_dai_type */
+	uint32_t dai_index;	/**< index of this type dai */
+
+	/* physical protocol and clocking */
+	uint16_t format;	/**< SOF_DAI_FMT_ */
+	uint16_t reserved16;	/**< alignment */
+
+	/* reserved for future use */
+	uint32_t reserved[8];
+
+	/* HW specific data */
+	union {
+		struct sof_ipc_dai_ssp_params ssp;
+		struct sof_ipc_dai_dmic_params dmic;
+		struct sof_ipc_dai_hda_params hda;
+	};
+} __packed;
+
+#endif
diff --git a/include/sound/sof/header.h b/include/sound/sof/header.h
new file mode 100644
index 000000000000..ccb6a004b37b
--- /dev/null
+++ b/include/sound/sof/header.h
@@ -0,0 +1,158 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/*
+ * This file is provided under a dual BSD/GPLv2 license.  When using or
+ * redistributing this file, you may do so under either license.
+ *
+ * Copyright(c) 2018 Intel Corporation. All rights reserved.
+ */
+
+#ifndef __INCLUDE_SOUND_SOF_HEADER_H__
+#define __INCLUDE_SOUND_SOF_HEADER_H__
+
+#include <uapi/sound/sof/abi.h>
+
+/** \addtogroup sof_uapi uAPI
+ *  SOF uAPI specification.
+ *  @{
+ */
+
+/*
+ * IPC messages have a prefixed 32 bit identifier made up as follows :-
+ *
+ * 0xGCCCNNNN where
+ * G is global cmd type (4 bits)
+ * C is command type (12 bits)
+ * I is the ID number (16 bits) - monotonic and overflows
+ *
+ * This is sent at the start of the IPM message in the mailbox. Messages should
+ * not be sent in the doorbell (special exceptions for firmware .
+ */
+
+/* Global Message - Generic */
+#define SOF_GLB_TYPE_SHIFT			28
+#define SOF_GLB_TYPE_MASK			(0xf << SOF_GLB_TYPE_SHIFT)
+#define SOF_GLB_TYPE(x)				((x) << SOF_GLB_TYPE_SHIFT)
+
+/* Command Message - Generic */
+#define SOF_CMD_TYPE_SHIFT			16
+#define SOF_CMD_TYPE_MASK			(0xfff << SOF_CMD_TYPE_SHIFT)
+#define SOF_CMD_TYPE(x)				((x) << SOF_CMD_TYPE_SHIFT)
+
+/* Global Message Types */
+#define SOF_IPC_GLB_REPLY			SOF_GLB_TYPE(0x1U)
+#define SOF_IPC_GLB_COMPOUND			SOF_GLB_TYPE(0x2U)
+#define SOF_IPC_GLB_TPLG_MSG			SOF_GLB_TYPE(0x3U)
+#define SOF_IPC_GLB_PM_MSG			SOF_GLB_TYPE(0x4U)
+#define SOF_IPC_GLB_COMP_MSG			SOF_GLB_TYPE(0x5U)
+#define SOF_IPC_GLB_STREAM_MSG			SOF_GLB_TYPE(0x6U)
+#define SOF_IPC_FW_READY			SOF_GLB_TYPE(0x7U)
+#define SOF_IPC_GLB_DAI_MSG			SOF_GLB_TYPE(0x8U)
+#define SOF_IPC_GLB_TRACE_MSG			SOF_GLB_TYPE(0x9U)
+
+/*
+ * DSP Command Message Types
+ */
+
+/* topology */
+#define SOF_IPC_TPLG_COMP_NEW			SOF_CMD_TYPE(0x001)
+#define SOF_IPC_TPLG_COMP_FREE			SOF_CMD_TYPE(0x002)
+#define SOF_IPC_TPLG_COMP_CONNECT		SOF_CMD_TYPE(0x003)
+#define SOF_IPC_TPLG_PIPE_NEW			SOF_CMD_TYPE(0x010)
+#define SOF_IPC_TPLG_PIPE_FREE			SOF_CMD_TYPE(0x011)
+#define SOF_IPC_TPLG_PIPE_CONNECT		SOF_CMD_TYPE(0x012)
+#define SOF_IPC_TPLG_PIPE_COMPLETE		SOF_CMD_TYPE(0x013)
+#define SOF_IPC_TPLG_BUFFER_NEW			SOF_CMD_TYPE(0x020)
+#define SOF_IPC_TPLG_BUFFER_FREE		SOF_CMD_TYPE(0x021)
+
+/* PM */
+#define SOF_IPC_PM_CTX_SAVE			SOF_CMD_TYPE(0x001)
+#define SOF_IPC_PM_CTX_RESTORE			SOF_CMD_TYPE(0x002)
+#define SOF_IPC_PM_CTX_SIZE			SOF_CMD_TYPE(0x003)
+#define SOF_IPC_PM_CLK_SET			SOF_CMD_TYPE(0x004)
+#define SOF_IPC_PM_CLK_GET			SOF_CMD_TYPE(0x005)
+#define SOF_IPC_PM_CLK_REQ			SOF_CMD_TYPE(0x006)
+#define SOF_IPC_PM_CORE_ENABLE			SOF_CMD_TYPE(0x007)
+
+/* component runtime config - multiple different types */
+#define SOF_IPC_COMP_SET_VALUE			SOF_CMD_TYPE(0x001)
+#define SOF_IPC_COMP_GET_VALUE			SOF_CMD_TYPE(0x002)
+#define SOF_IPC_COMP_SET_DATA			SOF_CMD_TYPE(0x003)
+#define SOF_IPC_COMP_GET_DATA			SOF_CMD_TYPE(0x004)
+
+/* DAI messages */
+#define SOF_IPC_DAI_CONFIG			SOF_CMD_TYPE(0x001)
+#define SOF_IPC_DAI_LOOPBACK			SOF_CMD_TYPE(0x002)
+
+/* stream */
+#define SOF_IPC_STREAM_PCM_PARAMS		SOF_CMD_TYPE(0x001)
+#define SOF_IPC_STREAM_PCM_PARAMS_REPLY		SOF_CMD_TYPE(0x002)
+#define SOF_IPC_STREAM_PCM_FREE			SOF_CMD_TYPE(0x003)
+#define SOF_IPC_STREAM_TRIG_START		SOF_CMD_TYPE(0x004)
+#define SOF_IPC_STREAM_TRIG_STOP		SOF_CMD_TYPE(0x005)
+#define SOF_IPC_STREAM_TRIG_PAUSE		SOF_CMD_TYPE(0x006)
+#define SOF_IPC_STREAM_TRIG_RELEASE		SOF_CMD_TYPE(0x007)
+#define SOF_IPC_STREAM_TRIG_DRAIN		SOF_CMD_TYPE(0x008)
+#define SOF_IPC_STREAM_TRIG_XRUN		SOF_CMD_TYPE(0x009)
+#define SOF_IPC_STREAM_POSITION			SOF_CMD_TYPE(0x00a)
+#define SOF_IPC_STREAM_VORBIS_PARAMS		SOF_CMD_TYPE(0x010)
+#define SOF_IPC_STREAM_VORBIS_FREE		SOF_CMD_TYPE(0x011)
+
+/* trace and debug */
+#define SOF_IPC_TRACE_DMA_PARAMS		SOF_CMD_TYPE(0x001)
+#define SOF_IPC_TRACE_DMA_POSITION		SOF_CMD_TYPE(0x002)
+
+/* Get message component id */
+#define SOF_IPC_MESSAGE_ID(x)			((x) & 0xffff)
+
+/* maximum message size for mailbox Tx/Rx */
+#define SOF_IPC_MSG_MAX_SIZE			384
+
+/*
+ * Structure Header - Header for all IPC structures except command structs.
+ * The size can be greater than the structure size and that means there is
+ * extended bespoke data beyond the end of the structure including variable
+ * arrays.
+ */
+
+struct sof_ipc_hdr {
+	uint32_t size;			/**< size of structure */
+} __packed;
+
+/*
+ * Command Header - Header for all IPC commands. Identifies IPC message.
+ * The size can be greater than the structure size and that means there is
+ * extended bespoke data beyond the end of the structure including variable
+ * arrays.
+ */
+
+struct sof_ipc_cmd_hdr {
+	uint32_t size;			/**< size of structure */
+	uint32_t cmd;			/**< SOF_IPC_GLB_ + cmd */
+} __packed;
+
+/*
+ * Generic reply message. Some commands override this with their own reply
+ * types that must include this at start.
+ */
+struct sof_ipc_reply {
+	struct sof_ipc_cmd_hdr hdr;
+	int32_t error;			/**< negative error numbers */
+}  __packed;
+
+/*
+ * Compound commands - SOF_IPC_GLB_COMPOUND.
+ *
+ * Compound commands are sent to the DSP as a single IPC operation. The
+ * commands are split into blocks and each block has a header. This header
+ * identifies the command type and the number of commands before the next
+ * header.
+ */
+
+struct sof_ipc_compound_hdr {
+	struct sof_ipc_cmd_hdr hdr;
+	uint32_t count;		/**< count of 0 means end of compound sequence */
+}  __packed;
+
+/** @}*/
+
+#endif
diff --git a/include/sound/sof/info.h b/include/sound/sof/info.h
new file mode 100644
index 000000000000..21dae04d8183
--- /dev/null
+++ b/include/sound/sof/info.h
@@ -0,0 +1,118 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/*
+ * This file is provided under a dual BSD/GPLv2 license.  When using or
+ * redistributing this file, you may do so under either license.
+ *
+ * Copyright(c) 2018 Intel Corporation. All rights reserved.
+ */
+
+#ifndef __INCLUDE_SOUND_SOF_INFO_H__
+#define __INCLUDE_SOUND_SOF_INFO_H__
+
+#include <sound/sof/header.h>
+#include <sound/sof/stream.h>
+
+/*
+ * Firmware boot and version
+ */
+
+#define SOF_IPC_MAX_ELEMS	16
+
+/* extended data types that can be appended onto end of sof_ipc_fw_ready */
+enum sof_ipc_ext_data {
+	SOF_IPC_EXT_DMA_BUFFER = 0,
+	SOF_IPC_EXT_WINDOW,
+};
+
+/* FW version - SOF_IPC_GLB_VERSION */
+struct sof_ipc_fw_version {
+	struct sof_ipc_hdr hdr;
+	uint16_t major;
+	uint16_t minor;
+	uint16_t micro;
+	uint16_t build;
+	uint8_t date[12];
+	uint8_t time[10];
+	uint8_t tag[6];
+	uint32_t abi_version;
+
+	/* reserved for future use */
+	uint32_t reserved[4];
+} __packed;
+
+/* FW ready Message - sent by firmware when boot has completed */
+struct sof_ipc_fw_ready {
+	struct sof_ipc_cmd_hdr hdr;
+	uint32_t dspbox_offset;	 /* dsp initiated IPC mailbox */
+	uint32_t hostbox_offset; /* host initiated IPC mailbox */
+	uint32_t dspbox_size;
+	uint32_t hostbox_size;
+	struct sof_ipc_fw_version version;
+
+	/* Miscellaneous debug flags showing build/debug features enabled */
+	union {
+		uint64_t reserved;
+		struct {
+			uint64_t build:1;
+			uint64_t locks:1;
+			uint64_t locks_verbose:1;
+			uint64_t gdb:1;
+		} bits;
+	} debug;
+
+	/* reserved for future use */
+	uint32_t reserved[4];
+} __packed;
+
+/*
+ * Extended Firmware data. All optional, depends on platform/arch.
+ */
+enum sof_ipc_region {
+	SOF_IPC_REGION_DOWNBOX	= 0,
+	SOF_IPC_REGION_UPBOX,
+	SOF_IPC_REGION_TRACE,
+	SOF_IPC_REGION_DEBUG,
+	SOF_IPC_REGION_STREAM,
+	SOF_IPC_REGION_REGS,
+	SOF_IPC_REGION_EXCEPTION,
+};
+
+struct sof_ipc_ext_data_hdr {
+	struct sof_ipc_cmd_hdr hdr;
+	uint32_t type;		/**< SOF_IPC_EXT_ */
+} __packed;
+
+struct sof_ipc_dma_buffer_elem {
+	struct sof_ipc_hdr hdr;
+	uint32_t type;		/**< SOF_IPC_REGION_ */
+	uint32_t id;		/**< platform specific - used to map to host memory */
+	struct sof_ipc_host_buffer buffer;
+} __packed;
+
+/* extended data DMA buffers for IPC, trace and debug */
+struct sof_ipc_dma_buffer_data {
+	struct sof_ipc_ext_data_hdr ext_hdr;
+	uint32_t num_buffers;
+
+	/* host files in buffer[n].buffer */
+	struct sof_ipc_dma_buffer_elem buffer[];
+}  __packed;
+
+struct sof_ipc_window_elem {
+	struct sof_ipc_hdr hdr;
+	uint32_t type;		/**< SOF_IPC_REGION_ */
+	uint32_t id;		/**< platform specific - used to map to host memory */
+	uint32_t flags;		/**< R, W, RW, etc - to define */
+	uint32_t size;		/**< size of region in bytes */
+	/* offset in window region as windows can be partitioned */
+	uint32_t offset;
+} __packed;
+
+/* extended data memory windows for IPC, trace and debug */
+struct sof_ipc_window {
+	struct sof_ipc_ext_data_hdr ext_hdr;
+	uint32_t num_windows;
+	struct sof_ipc_window_elem window[];
+}  __packed;
+
+#endif
diff --git a/include/sound/sof/pm.h b/include/sound/sof/pm.h
new file mode 100644
index 000000000000..8ae3ad45bdf7
--- /dev/null
+++ b/include/sound/sof/pm.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/*
+ * This file is provided under a dual BSD/GPLv2 license.  When using or
+ * redistributing this file, you may do so under either license.
+ *
+ * Copyright(c) 2018 Intel Corporation. All rights reserved.
+ */
+
+#ifndef __INCLUDE_SOUND_SOF_PM_H__
+#define __INCLUDE_SOUND_SOF_PM_H__
+
+#include <sound/sof/header.h>
+
+/*
+ * PM
+ */
+
+/* PM context element */
+struct sof_ipc_pm_ctx_elem {
+	struct sof_ipc_hdr hdr;
+	uint32_t type;
+	uint32_t size;
+	uint64_t addr;
+}  __packed;
+
+/*
+ * PM context - SOF_IPC_PM_CTX_SAVE, SOF_IPC_PM_CTX_RESTORE,
+ * SOF_IPC_PM_CTX_SIZE
+ */
+struct sof_ipc_pm_ctx {
+	struct sof_ipc_cmd_hdr hdr;
+	struct sof_ipc_host_buffer buffer;
+	uint32_t num_elems;
+	uint32_t size;
+
+	/* reserved for future use */
+	uint32_t reserved[8];
+
+	struct sof_ipc_pm_ctx_elem elems[];
+} __packed;
+
+/* enable or disable cores - SOF_IPC_PM_CORE_ENABLE */
+struct sof_ipc_pm_core_config {
+	struct sof_ipc_cmd_hdr hdr;
+	uint32_t enable_mask;
+} __packed;
+
+#endif
diff --git a/include/sound/sof/stream.h b/include/sound/sof/stream.h
new file mode 100644
index 000000000000..0b436649f1e4
--- /dev/null
+++ b/include/sound/sof/stream.h
@@ -0,0 +1,149 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/*
+ * This file is provided under a dual BSD/GPLv2 license.  When using or
+ * redistributing this file, you may do so under either license.
+ *
+ * Copyright(c) 2018 Intel Corporation. All rights reserved.
+ */
+
+#ifndef __INCLUDE_SOUND_SOF_STREAM_H__
+#define __INCLUDE_SOUND_SOF_STREAM_H__
+
+#include <sound/sof/header.h>
+
+/*
+ * Stream configuration.
+ */
+
+#define SOF_IPC_MAX_CHANNELS			8
+
+/* common sample rates for use in masks */
+#define SOF_RATE_8000		(1 <<  0) /**< 8000Hz  */
+#define SOF_RATE_11025		(1 <<  1) /**< 11025Hz */
+#define SOF_RATE_12000		(1 <<  2) /**< 12000Hz */
+#define SOF_RATE_16000		(1 <<  3) /**< 16000Hz */
+#define SOF_RATE_22050		(1 <<  4) /**< 22050Hz */
+#define SOF_RATE_24000		(1 <<  5) /**< 24000Hz */
+#define SOF_RATE_32000		(1 <<  6) /**< 32000Hz */
+#define SOF_RATE_44100		(1 <<  7) /**< 44100Hz */
+#define SOF_RATE_48000		(1 <<  8) /**< 48000Hz */
+#define SOF_RATE_64000		(1 <<  9) /**< 64000Hz */
+#define SOF_RATE_88200		(1 << 10) /**< 88200Hz */
+#define SOF_RATE_96000		(1 << 11) /**< 96000Hz */
+#define SOF_RATE_176400		(1 << 12) /**< 176400Hz */
+#define SOF_RATE_192000		(1 << 13) /**< 192000Hz */
+
+/* continuous and non-standard rates for flexibility */
+#define SOF_RATE_CONTINUOUS	(1 << 30)  /**< range */
+#define SOF_RATE_KNOT		(1 << 31)  /**< non-continuous */
+
+/* generic PCM flags for runtime settings */
+#define SOF_PCM_FLAG_XRUN_STOP	(1 << 0) /**< Stop on any XRUN */
+
+/* stream PCM frame format */
+enum sof_ipc_frame {
+	SOF_IPC_FRAME_S16_LE = 0,
+	SOF_IPC_FRAME_S24_4LE,
+	SOF_IPC_FRAME_S32_LE,
+	SOF_IPC_FRAME_FLOAT,
+	/* other formats here */
+};
+
+/* stream buffer format */
+enum sof_ipc_buffer_format {
+	SOF_IPC_BUFFER_INTERLEAVED,
+	SOF_IPC_BUFFER_NONINTERLEAVED,
+	/* other formats here */
+};
+
+/* stream direction */
+enum sof_ipc_stream_direction {
+	SOF_IPC_STREAM_PLAYBACK = 0,
+	SOF_IPC_STREAM_CAPTURE,
+};
+
+/* stream ring info */
+struct sof_ipc_host_buffer {
+	struct sof_ipc_hdr hdr;
+	uint32_t phy_addr;
+	uint32_t pages;
+	uint32_t size;
+	uint32_t offset;
+	uint32_t reserved[2];
+} __packed;
+
+struct sof_ipc_stream_params {
+	struct sof_ipc_hdr hdr;
+	struct sof_ipc_host_buffer buffer;
+	uint32_t direction;	/**< enum sof_ipc_stream_direction */
+	uint32_t frame_fmt;	/**< enum sof_ipc_frame */
+	uint32_t buffer_fmt;	/**< enum sof_ipc_buffer_format */
+	uint32_t rate;
+	uint16_t stream_tag;
+	uint16_t channels;
+	uint16_t sample_valid_bytes;
+	uint16_t sample_container_bytes;
+
+	/* for notifying host period has completed - 0 means no period IRQ */
+	uint32_t host_period_bytes;
+
+	uint32_t reserved[2];
+	uint16_t chmap[SOF_IPC_MAX_CHANNELS];	/**< channel map - SOF_CHMAP_ */
+} __packed;
+
+/* PCM params info - SOF_IPC_STREAM_PCM_PARAMS */
+struct sof_ipc_pcm_params {
+	struct sof_ipc_cmd_hdr hdr;
+	uint32_t comp_id;
+	uint32_t flags;		/**< generic PCM flags - SOF_PCM_FLAG_ */
+	uint32_t reserved[2];
+	struct sof_ipc_stream_params params;
+}  __packed;
+
+/* PCM params info reply - SOF_IPC_STREAM_PCM_PARAMS_REPLY */
+struct sof_ipc_pcm_params_reply {
+	struct sof_ipc_reply rhdr;
+	uint32_t comp_id;
+	uint32_t posn_offset;
+} __packed;
+
+/* free stream - SOF_IPC_STREAM_PCM_PARAMS */
+struct sof_ipc_stream {
+	struct sof_ipc_cmd_hdr hdr;
+	uint32_t comp_id;
+} __packed;
+
+/* flags indicating which time stamps are in sync with each other */
+#define	SOF_TIME_HOST_SYNC	(1 << 0)
+#define	SOF_TIME_DAI_SYNC	(1 << 1)
+#define	SOF_TIME_WALL_SYNC	(1 << 2)
+#define	SOF_TIME_STAMP_SYNC	(1 << 3)
+
+/* flags indicating which time stamps are valid */
+#define	SOF_TIME_HOST_VALID	(1 << 8)
+#define	SOF_TIME_DAI_VALID	(1 << 9)
+#define	SOF_TIME_WALL_VALID	(1 << 10)
+#define	SOF_TIME_STAMP_VALID	(1 << 11)
+
+/* flags indicating time stamps are 64bit else 3use low 32bit */
+#define	SOF_TIME_HOST_64	(1 << 16)
+#define	SOF_TIME_DAI_64		(1 << 17)
+#define	SOF_TIME_WALL_64	(1 << 18)
+#define	SOF_TIME_STAMP_64	(1 << 19)
+
+struct sof_ipc_stream_posn {
+	struct sof_ipc_reply rhdr;
+	uint32_t comp_id;	/**< host component ID */
+	uint32_t flags;		/**< SOF_TIME_ */
+	uint32_t wallclock_hz;	/**< frequency of wallclock in Hz */
+	uint32_t timestamp_ns;	/**< resolution of timestamp in ns */
+	uint64_t host_posn;	/**< host DMA position in bytes */
+	uint64_t dai_posn;	/**< DAI DMA position in bytes */
+	uint64_t comp_posn;	/**< comp position in bytes */
+	uint64_t wallclock;	/**< audio wall clock */
+	uint64_t timestamp;	/**< system time stamp */
+	uint32_t xrun_comp_id;	/**< comp ID of XRUN component */
+	int32_t xrun_size;	/**< XRUN size in bytes */
+}  __packed;
+
+#endif
diff --git a/include/sound/sof/trace.h b/include/sound/sof/trace.h
new file mode 100644
index 000000000000..49f0f310d902
--- /dev/null
+++ b/include/sound/sof/trace.h
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/*
+ * This file is provided under a dual BSD/GPLv2 license.  When using or
+ * redistributing this file, you may do so under either license.
+ *
+ * Copyright(c) 2018 Intel Corporation. All rights reserved.
+ */
+
+#ifndef __INCLUDE_SOUND_SOF_TRACE_H__
+#define __INCLUDE_SOUND_SOF_TRACE_H__
+
+#include <sound/sof/header.h>
+#include <sound/sof/stream.h>
+
+/*
+ * DMA for Trace
+ */
+
+#define SOF_TRACE_FILENAME_SIZE		32
+
+/* DMA for Trace params info - SOF_IPC_DEBUG_DMA_PARAMS */
+struct sof_ipc_dma_trace_params {
+	struct sof_ipc_cmd_hdr hdr;
+	struct sof_ipc_host_buffer buffer;
+	uint32_t stream_tag;
+}  __packed;
+
+/* DMA for Trace params info - SOF_IPC_DEBUG_DMA_PARAMS */
+struct sof_ipc_dma_trace_posn {
+	struct sof_ipc_reply rhdr;
+	uint32_t host_offset;	/* Offset of DMA host buffer */
+	uint32_t overflow;	/* overflow bytes if any */
+	uint32_t messages;	/* total trace messages */
+}  __packed;
+
+/*
+ * Commom debug
+ */
+
+/*
+ * SOF panic codes
+ */
+#define SOF_IPC_PANIC_MAGIC			0x0dead000
+#define SOF_IPC_PANIC_MAGIC_MASK		0x0ffff000
+#define SOF_IPC_PANIC_CODE_MASK			0x00000fff
+#define SOF_IPC_PANIC_MEM			(SOF_IPC_PANIC_MAGIC | 0x0)
+#define SOF_IPC_PANIC_WORK			(SOF_IPC_PANIC_MAGIC | 0x1)
+#define SOF_IPC_PANIC_IPC			(SOF_IPC_PANIC_MAGIC | 0x2)
+#define SOF_IPC_PANIC_ARCH			(SOF_IPC_PANIC_MAGIC | 0x3)
+#define SOF_IPC_PANIC_PLATFORM			(SOF_IPC_PANIC_MAGIC | 0x4)
+#define SOF_IPC_PANIC_TASK			(SOF_IPC_PANIC_MAGIC | 0x5)
+#define SOF_IPC_PANIC_EXCEPTION			(SOF_IPC_PANIC_MAGIC | 0x6)
+#define SOF_IPC_PANIC_DEADLOCK			(SOF_IPC_PANIC_MAGIC | 0x7)
+#define SOF_IPC_PANIC_STACK			(SOF_IPC_PANIC_MAGIC | 0x8)
+#define SOF_IPC_PANIC_IDLE			(SOF_IPC_PANIC_MAGIC | 0x9)
+#define SOF_IPC_PANIC_WFI			(SOF_IPC_PANIC_MAGIC | 0xa)
+
+/* panic info include filename and line number */
+struct sof_ipc_panic_info {
+	struct sof_ipc_hdr hdr;
+	uint32_t code;			/* SOF_IPC_PANIC_ */
+	char filename[SOF_TRACE_FILENAME_SIZE];
+	uint32_t linenum;
+}  __packed;
+
+#endif
diff --git a/sound/soc/sof/ipc.c b/sound/soc/sof/ipc.c
new file mode 100644
index 000000000000..918cd7b732dd
--- /dev/null
+++ b/sound/soc/sof/ipc.c
@@ -0,0 +1,813 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+//
+// This file is provided under a dual BSD/GPLv2 license.  When using or
+// redistributing this file, you may do so under either license.
+//
+// Copyright(c) 2018 Intel Corporation. All rights reserved.
+//
+// Author: Liam Girdwood <liam.r.girdwood@linux.intel.com>
+//
+// Generic IPC layer that can work over MMIO and SPI/I2C. PHY layer provided
+// by platform driver code.
+//
+
+#include "sof-priv.h"
+#include "ops.h"
+
+/*
+ * IPC message default size and timeout (msecs).
+ * TODO: allow platforms to set size and timeout.
+ */
+#define IPC_TIMEOUT_MSECS	300
+#define IPC_EMPTY_LIST_SIZE	8
+
+static void ipc_trace_message(struct snd_sof_dev *sdev, u32 msg_id);
+static void ipc_stream_message(struct snd_sof_dev *sdev, u32 msg_cmd);
+
+/*
+ * IPC message Tx/Rx message handling.
+ */
+
+/* SOF generic IPC data */
+struct snd_sof_ipc {
+	struct snd_sof_dev *sdev;
+
+	/* TX message work and status */
+	wait_queue_head_t wait_txq;
+	struct work_struct tx_kwork;
+	u32 msg_pending;
+
+	/* Rx Message work and status */
+	struct work_struct rx_kwork;
+
+	/* lists */
+	struct list_head tx_list;
+	struct list_head reply_list;
+	struct list_head empty_list;
+};
+
+/* locks held by caller */
+static struct snd_sof_ipc_msg *msg_get_empty(struct snd_sof_ipc *ipc)
+{
+	struct snd_sof_ipc_msg *msg = NULL;
+
+	/* get first empty message in the list */
+	if (!list_empty(&ipc->empty_list)) {
+		msg = list_first_entry(&ipc->empty_list, struct snd_sof_ipc_msg,
+				       list);
+		list_del(&msg->list);
+	}
+
+	return msg;
+}
+
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_DEBUG_VERBOSE_IPC)
+static void ipc_log_header(struct device *dev, u8 *text, u32 cmd)
+{
+	u8 *str;
+	u32 glb;
+	u32 type;
+
+	glb = cmd & SOF_GLB_TYPE_MASK;
+	type = cmd & SOF_CMD_TYPE_MASK;
+
+	switch (glb) {
+	case SOF_IPC_GLB_REPLY:
+		str = "GLB_REPLY"; break;
+	case SOF_IPC_GLB_COMPOUND:
+		str = "GLB_COMPOUND"; break;
+	case SOF_IPC_GLB_TPLG_MSG:
+		switch (type) {
+		case SOF_IPC_TPLG_COMP_NEW:
+			str = "GLB_TPLG_MSG: COMP_NEW"; break;
+		case SOF_IPC_TPLG_COMP_FREE:
+			str = "GLB_TPLG_MSG: COMP_FREE"; break;
+		case SOF_IPC_TPLG_COMP_CONNECT:
+			str = "GLB_TPLG_MSG: COMP_CONNECT"; break;
+		case SOF_IPC_TPLG_PIPE_NEW:
+			str = "GLB_TPLG_MSG: PIPE_NEW"; break;
+		case SOF_IPC_TPLG_PIPE_FREE:
+			str = "GLB_TPLG_MSG: PIPE_FREE"; break;
+		case SOF_IPC_TPLG_PIPE_CONNECT:
+			str = "GLB_TPLG_MSG: PIPE_CONNECT"; break;
+		case SOF_IPC_TPLG_PIPE_COMPLETE:
+			str = "GLB_TPLG_MSG: PIPE_COMPLETE"; break;
+		case SOF_IPC_TPLG_BUFFER_NEW:
+			str = "GLB_TPLG_MSG: BUFFER_NEW"; break;
+		case SOF_IPC_TPLG_BUFFER_FREE:
+			str = "GLB_TPLG_MSG: BUFFER_FREE"; break;
+		default:
+			str = "GLB_TPLG_MSG: unknown type"; break;
+		}
+		break;
+	case SOF_IPC_GLB_PM_MSG:
+		switch (type) {
+		case SOF_IPC_PM_CTX_SAVE:
+			str = "GLB_PM_MSG: CTX_SAVE"; break;
+		case SOF_IPC_PM_CTX_RESTORE:
+			str = "GLB_PM_MSG: CTX_RESTORE"; break;
+		case SOF_IPC_PM_CTX_SIZE:
+			str = "GLB_PM_MSG: CTX_SIZE"; break;
+		case SOF_IPC_PM_CLK_SET:
+			str = "GLB_PM_MSG: CLK_SET"; break;
+		case SOF_IPC_PM_CLK_GET:
+			str = "GLB_PM_MSG: CLK_GET"; break;
+		case SOF_IPC_PM_CLK_REQ:
+			str = "GLB_PM_MSG: CLK_REQ"; break;
+		case SOF_IPC_PM_CORE_ENABLE:
+			str = "GLB_PM_MSG: CORE_ENABLE"; break;
+		default:
+			str = "GLB_PM_MSG: unknown type"; break;
+		}
+		break;
+	case SOF_IPC_GLB_COMP_MSG:
+		switch (type) {
+		case SOF_IPC_COMP_SET_VALUE:
+			str = "GLB_COMP_MSG: SET_VALUE"; break;
+		case SOF_IPC_COMP_GET_VALUE:
+			str = "GLB_COMP_MSG: GET_VALUE"; break;
+		case SOF_IPC_COMP_SET_DATA:
+			str = "GLB_COMP_MSG: SET_DATA"; break;
+		case SOF_IPC_COMP_GET_DATA:
+			str = "GLB_COMP_MSG: GET_DATA"; break;
+		default:
+			str = "GLB_COMP_MSG: unknown type"; break;
+		}
+		break;
+	case SOF_IPC_GLB_STREAM_MSG:
+		switch (type) {
+		case SOF_IPC_STREAM_PCM_PARAMS:
+			str = "GLB_STREAM_MSG: PCM_PARAMS"; break;
+		case SOF_IPC_STREAM_PCM_PARAMS_REPLY:
+			str = "GLB_STREAM_MSG: PCM_REPLY"; break;
+		case SOF_IPC_STREAM_PCM_FREE:
+			str = "GLB_STREAM_MSG: PCM_FREE"; break;
+		case SOF_IPC_STREAM_TRIG_START:
+			str = "GLB_STREAM_MSG: TRIG_START"; break;
+		case SOF_IPC_STREAM_TRIG_STOP:
+			str = "GLB_STREAM_MSG: TRIG_STOP"; break;
+		case SOF_IPC_STREAM_TRIG_PAUSE:
+			str = "GLB_STREAM_MSG: TRIG_PAUSE"; break;
+		case SOF_IPC_STREAM_TRIG_RELEASE:
+			str = "GLB_STREAM_MSG: TRIG_RELEASE"; break;
+		case SOF_IPC_STREAM_TRIG_DRAIN:
+			str = "GLB_STREAM_MSG: TRIG_DRAIN"; break;
+		case SOF_IPC_STREAM_TRIG_XRUN:
+			str = "GLB_STREAM_MSG: TRIG_XRUN"; break;
+		case SOF_IPC_STREAM_POSITION:
+			str = "GLB_STREAM_MSG: POSITION"; break;
+		case SOF_IPC_STREAM_VORBIS_PARAMS:
+			str = "GLB_STREAM_MSG: VORBIS_PARAMS"; break;
+		case SOF_IPC_STREAM_VORBIS_FREE:
+			str = "GLB_STREAM_MSG: VORBIS_FREE"; break;
+		default:
+			str = "GLB_STREAM_MSG: unknown type"; break;
+		}
+		break;
+	case SOF_IPC_FW_READY:
+		str = "FW_READY"; break;
+	case SOF_IPC_GLB_DAI_MSG:
+		switch (type) {
+		case SOF_IPC_DAI_CONFIG:
+			str = "GLB_DAI_MSG: CONFIG"; break;
+		case SOF_IPC_DAI_LOOPBACK:
+			str = "GLB_DAI_MSG: LOOPBACK"; break;
+		default:
+			str = "GLB_DAI_MSG: unknown type"; break;
+		}
+		break;
+	case SOF_IPC_GLB_TRACE_MSG:
+		str = "GLB_TRACE_MSG"; break;
+	default:
+		str = "unknown GLB command"; break;
+	}
+
+	dev_dbg(dev, "%s: 0x%x: %s\n", text, cmd, str);
+}
+#else
+static inline void ipc_log_header(struct device *dev, u8 *text, u32 cmd)
+{
+	dev_dbg(dev, "%s: 0x%x\n", text, cmd);
+}
+#endif
+
+/* wait for IPC message reply */
+static int tx_wait_done(struct snd_sof_ipc *ipc, struct snd_sof_ipc_msg *msg,
+			void *reply_data)
+{
+	struct snd_sof_dev *sdev = ipc->sdev;
+	struct sof_ipc_cmd_hdr *hdr = (struct sof_ipc_cmd_hdr *)msg->msg_data;
+	unsigned long flags;
+	int ret;
+
+	/* wait for DSP IPC completion */
+	ret = wait_event_timeout(msg->waitq, msg->ipc_complete,
+				 msecs_to_jiffies(IPC_TIMEOUT_MSECS));
+
+	spin_lock_irqsave(&sdev->ipc_lock, flags);
+
+	if (ret == 0) {
+		dev_err(sdev->dev, "error: ipc timed out for 0x%x size 0x%x\n",
+			hdr->cmd, hdr->size);
+		snd_sof_dsp_dbg_dump(ipc->sdev, SOF_DBG_REGS | SOF_DBG_MBOX);
+		snd_sof_trace_notify_for_error(ipc->sdev);
+		ret = -ETIMEDOUT;
+	} else {
+		/* copy the data returned from DSP */
+		ret = snd_sof_dsp_get_reply(sdev, msg);
+		if (msg->reply_size)
+			memcpy(reply_data, msg->reply_data, msg->reply_size);
+		if (ret < 0)
+			dev_err(sdev->dev, "error: ipc error for 0x%x size 0x%zx\n",
+				hdr->cmd, msg->reply_size);
+		else
+			ipc_log_header(sdev->dev, "ipc tx succeeded", hdr->cmd);
+	}
+
+	/* return message body to empty list */
+	list_move(&msg->list, &ipc->empty_list);
+
+	spin_unlock_irqrestore(&sdev->ipc_lock, flags);
+
+	snd_sof_dsp_cmd_done(sdev, SOF_IPC_DSP_REPLY);
+
+	/* continue to schedule any remaining messages... */
+	snd_sof_ipc_msgs_tx(sdev);
+
+	return ret;
+}
+
+/* send IPC message from host to DSP */
+int sof_ipc_tx_message(struct snd_sof_ipc *ipc, u32 header,
+		       void *msg_data, size_t msg_bytes, void *reply_data,
+		       size_t reply_bytes)
+{
+	struct snd_sof_dev *sdev = ipc->sdev;
+	struct snd_sof_ipc_msg *msg;
+	unsigned long flags;
+
+	spin_lock_irqsave(&sdev->ipc_lock, flags);
+
+	/* get an empty message */
+	msg = msg_get_empty(ipc);
+	if (!msg) {
+		spin_unlock_irqrestore(&sdev->ipc_lock, flags);
+		return -EBUSY;
+	}
+
+	msg->header = header;
+	msg->msg_size = msg_bytes;
+	msg->reply_size = reply_bytes;
+	msg->ipc_complete = false;
+
+	/* attach any data */
+	if (msg_bytes)
+		memcpy(msg->msg_data, msg_data, msg_bytes);
+
+	/* add message to transmit list */
+	list_add_tail(&msg->list, &ipc->tx_list);
+
+	/* schedule the message if not busy */
+	if (snd_sof_dsp_is_ready(sdev))
+		schedule_work(&ipc->tx_kwork);
+
+	spin_unlock_irqrestore(&sdev->ipc_lock, flags);
+
+	/* now wait for completion */
+	return tx_wait_done(ipc, msg, reply_data);
+}
+EXPORT_SYMBOL(sof_ipc_tx_message);
+
+/* send next IPC message in list */
+static void ipc_tx_next_msg(struct work_struct *work)
+{
+	struct snd_sof_ipc *ipc =
+		container_of(work, struct snd_sof_ipc, tx_kwork);
+	struct snd_sof_dev *sdev = ipc->sdev;
+	struct snd_sof_ipc_msg *msg;
+	unsigned long flags;
+
+	spin_lock_irqsave(&sdev->ipc_lock, flags);
+
+	/* send message if HW read and message in TX list */
+	if (list_empty(&ipc->tx_list) || !snd_sof_dsp_is_ready(sdev))
+		goto out;
+
+	/* send first message in TX list */
+	msg = list_first_entry(&ipc->tx_list, struct snd_sof_ipc_msg, list);
+	list_move(&msg->list, &ipc->reply_list);
+	snd_sof_dsp_send_msg(sdev, msg);
+
+	ipc_log_header(sdev->dev, "ipc tx", msg->header);
+out:
+	spin_unlock_irqrestore(&sdev->ipc_lock, flags);
+}
+
+/* find original TX message from DSP reply */
+static struct snd_sof_ipc_msg *sof_ipc_reply_find_msg(struct snd_sof_ipc *ipc,
+						      u32 header)
+{
+	struct snd_sof_dev *sdev = ipc->sdev;
+	struct snd_sof_ipc_msg *msg;
+
+	header = SOF_IPC_MESSAGE_ID(header);
+
+	if (list_empty(&ipc->reply_list))
+		goto err;
+
+	list_for_each_entry(msg, &ipc->reply_list, list) {
+		if (SOF_IPC_MESSAGE_ID(msg->header) == header)
+			return msg;
+	}
+
+err:
+	dev_err(sdev->dev, "error: rx list empty but received 0x%x\n",
+		header);
+	return NULL;
+}
+
+/* mark IPC message as complete - locks held by caller */
+static void sof_ipc_tx_msg_reply_complete(struct snd_sof_ipc *ipc,
+					  struct snd_sof_ipc_msg *msg)
+{
+	msg->ipc_complete = true;
+	wake_up(&msg->waitq);
+}
+
+/* drop all IPC messages in preparation for DSP stall/reset */
+void sof_ipc_drop_all(struct snd_sof_ipc *ipc)
+{
+	struct snd_sof_dev *sdev = ipc->sdev;
+	struct snd_sof_ipc_msg *msg, *tmp;
+	unsigned long flags;
+
+	/* drop all TX and Rx messages before we stall + reset DSP */
+	spin_lock_irqsave(&sdev->ipc_lock, flags);
+
+	list_for_each_entry_safe(msg, tmp, &ipc->tx_list, list) {
+		list_move(&msg->list, &ipc->empty_list);
+		dev_err(sdev->dev, "error: dropped msg %d\n", msg->header);
+	}
+
+	list_for_each_entry_safe(msg, tmp, &ipc->reply_list, list) {
+		list_move(&msg->list, &ipc->empty_list);
+		dev_err(sdev->dev, "error: dropped reply %d\n", msg->header);
+	}
+
+	spin_unlock_irqrestore(&sdev->ipc_lock, flags);
+}
+EXPORT_SYMBOL(sof_ipc_drop_all);
+
+/* handle reply message from DSP */
+int snd_sof_ipc_reply(struct snd_sof_dev *sdev, u32 msg_id)
+{
+	struct snd_sof_ipc_msg *msg;
+
+	msg = sof_ipc_reply_find_msg(sdev->ipc, msg_id);
+	if (!msg) {
+		dev_err(sdev->dev, "error: can't find message header 0x%x",
+			msg_id);
+		return -EINVAL;
+	}
+
+	/* wake up and return the error if we have waiters on this message ? */
+	sof_ipc_tx_msg_reply_complete(sdev->ipc, msg);
+	return 0;
+}
+EXPORT_SYMBOL(snd_sof_ipc_reply);
+
+/* DSP firmware has sent host a message  */
+static void ipc_msgs_rx(struct work_struct *work)
+{
+	struct snd_sof_ipc *ipc =
+		container_of(work, struct snd_sof_ipc, rx_kwork);
+	struct snd_sof_dev *sdev = ipc->sdev;
+	struct sof_ipc_cmd_hdr hdr;
+	u32 cmd, type;
+	int err = -EINVAL;
+
+	/* read back header */
+	snd_sof_dsp_mailbox_read(sdev, sdev->dsp_box.offset, &hdr, sizeof(hdr));
+	ipc_log_header(sdev->dev, "ipc rx", hdr.cmd);
+
+	cmd = hdr.cmd & SOF_GLB_TYPE_MASK;
+	type = hdr.cmd & SOF_CMD_TYPE_MASK;
+
+	/* check message type */
+	switch (cmd) {
+	case SOF_IPC_GLB_REPLY:
+		dev_err(sdev->dev, "error: ipc reply unknown\n");
+		break;
+	case SOF_IPC_FW_READY:
+		/* check for FW boot completion */
+		if (!sdev->boot_complete) {
+			if (sdev->ops->fw_ready)
+				err = sdev->ops->fw_ready(sdev, cmd);
+			if (err < 0) {
+				dev_err(sdev->dev, "error: DSP firmware boot timeout %d\n",
+					err);
+			} else {
+				/* firmware boot completed OK */
+				sdev->boot_complete = true;
+				dev_dbg(sdev->dev, "booting DSP firmware completed\n");
+				wake_up(&sdev->boot_wait);
+			}
+		}
+		break;
+	case SOF_IPC_GLB_COMPOUND:
+	case SOF_IPC_GLB_TPLG_MSG:
+	case SOF_IPC_GLB_PM_MSG:
+	case SOF_IPC_GLB_COMP_MSG:
+		break;
+	case SOF_IPC_GLB_STREAM_MSG:
+		/* need to pass msg id into the function */
+		ipc_stream_message(sdev, hdr.cmd);
+		break;
+	case SOF_IPC_GLB_TRACE_MSG:
+		ipc_trace_message(sdev, type);
+		break;
+	default:
+		dev_err(sdev->dev, "error: unknown DSP message 0x%x\n", cmd);
+		break;
+	}
+
+	ipc_log_header(sdev->dev, "ipc rx done", hdr.cmd);
+
+	/* tell DSP we are done */
+	snd_sof_dsp_cmd_done(sdev, SOF_IPC_HOST_REPLY);
+}
+
+/* schedule work to transmit any IPC in queue */
+void snd_sof_ipc_msgs_tx(struct snd_sof_dev *sdev)
+{
+	schedule_work(&sdev->ipc->tx_kwork);
+}
+EXPORT_SYMBOL(snd_sof_ipc_msgs_tx);
+
+/* schedule work to handle IPC from DSP */
+void snd_sof_ipc_msgs_rx(struct snd_sof_dev *sdev)
+{
+	schedule_work(&sdev->ipc->rx_kwork);
+}
+EXPORT_SYMBOL(snd_sof_ipc_msgs_rx);
+
+/*
+ * IPC trace mechanism.
+ */
+
+static void ipc_trace_message(struct snd_sof_dev *sdev, u32 msg_id)
+{
+	struct sof_ipc_dma_trace_posn posn;
+
+	switch (msg_id) {
+	case SOF_IPC_TRACE_DMA_POSITION:
+		/* read back full message */
+		snd_sof_dsp_mailbox_read(sdev, sdev->dsp_box.offset, &posn,
+					 sizeof(posn));
+		snd_sof_trace_update_pos(sdev, &posn);
+		break;
+	default:
+		dev_err(sdev->dev, "error: unhandled trace message %x\n",
+			msg_id);
+		break;
+	}
+}
+
+/*
+ * IPC stream position.
+ */
+
+static void ipc_period_elapsed(struct snd_sof_dev *sdev, u32 msg_id)
+{
+	struct sof_ipc_stream_posn posn;
+	struct snd_sof_pcm *spcm;
+	u32 posn_offset;
+	int direction;
+
+	/* check if we have stream box */
+	if (sdev->stream_box.size == 0) {
+		/* read back full message */
+		snd_sof_dsp_mailbox_read(sdev, sdev->dsp_box.offset, &posn,
+					 sizeof(posn));
+
+		spcm = snd_sof_find_spcm_comp(sdev, posn.comp_id, &direction);
+	} else {
+		spcm = snd_sof_find_spcm_comp(sdev, msg_id, &direction);
+	}
+
+	if (!spcm) {
+		dev_err(sdev->dev,
+			"error: period elapsed for unknown stream, msg_id %d\n",
+			msg_id);
+		return;
+	}
+
+	/* have stream box read from stream box */
+	if (sdev->stream_box.size != 0) {
+		posn_offset = spcm->posn_offset[direction];
+		snd_sof_dsp_mailbox_read(sdev, posn_offset, &posn,
+					 sizeof(posn));
+
+		dev_dbg(sdev->dev, "posn mailbox: posn offset is 0x%x",
+			posn_offset);
+	}
+
+	dev_dbg(sdev->dev, "posn : host 0x%llx dai 0x%llx wall 0x%llx\n",
+		posn.host_posn, posn.dai_posn, posn.wallclock);
+
+	memcpy(&spcm->stream[direction].posn, &posn, sizeof(posn));
+
+	/* only inform ALSA for period_wakeup mode */
+	if (!spcm->stream[direction].substream->runtime->no_period_wakeup)
+		snd_pcm_period_elapsed(spcm->stream[direction].substream);
+}
+
+/* DSP notifies host of an XRUN within FW */
+static void ipc_xrun(struct snd_sof_dev *sdev, u32 msg_id)
+{
+	struct sof_ipc_stream_posn posn;
+	struct snd_sof_pcm *spcm;
+	u32 posn_offset;
+	int direction;
+
+	/* check if we have stream MMIO on this platform */
+	if (sdev->stream_box.size == 0) {
+		/* read back full message */
+		snd_sof_dsp_mailbox_read(sdev, sdev->dsp_box.offset, &posn,
+					 sizeof(posn));
+
+		spcm = snd_sof_find_spcm_comp(sdev, posn.comp_id, &direction);
+	} else {
+		spcm = snd_sof_find_spcm_comp(sdev, msg_id, &direction);
+	}
+
+	if (!spcm) {
+		dev_err(sdev->dev, "error: XRUN for unknown stream, msg_id %d\n",
+			msg_id);
+		return;
+	}
+
+	/* have stream box read from stream box */
+	if (sdev->stream_box.size != 0) {
+		posn_offset = spcm->posn_offset[direction];
+		snd_sof_dsp_mailbox_read(sdev, posn_offset, &posn,
+					 sizeof(posn));
+
+		dev_dbg(sdev->dev, "posn mailbox: posn offset is 0x%x",
+			posn_offset);
+	}
+
+	dev_dbg(sdev->dev,  "posn XRUN: host %llx comp %d size %d\n",
+		posn.host_posn, posn.xrun_comp_id, posn.xrun_size);
+
+#if defined(CONFIG_SND_SOC_SOF_DEBUG_XRUN_STOP)
+	/* stop PCM on XRUN - used for pipeline debug */
+	memcpy(&spcm->stream[direction].posn, &posn, sizeof(posn));
+	snd_pcm_stop_xrun(spcm->stream[direction].substream);
+#endif
+}
+
+/* stream notifications from DSP FW */
+static void ipc_stream_message(struct snd_sof_dev *sdev, u32 msg_cmd)
+{
+	/* get msg cmd type and msd id */
+	u32 msg_type = msg_cmd & SOF_CMD_TYPE_MASK;
+	u32 msg_id = SOF_IPC_MESSAGE_ID(msg_cmd);
+
+	switch (msg_type) {
+	case SOF_IPC_STREAM_POSITION:
+		ipc_period_elapsed(sdev, msg_id);
+		break;
+	case SOF_IPC_STREAM_TRIG_XRUN:
+		ipc_xrun(sdev, msg_id);
+		break;
+	default:
+		dev_err(sdev->dev, "error: unhandled stream message %x\n",
+			msg_id);
+		break;
+	}
+}
+
+/* get stream position IPC - use faster MMIO method if available on platform */
+int snd_sof_ipc_stream_posn(struct snd_sof_dev *sdev,
+			    struct snd_sof_pcm *spcm, int direction,
+			    struct sof_ipc_stream_posn *posn)
+{
+	struct sof_ipc_stream stream;
+	int err;
+
+	/* read position via slower IPC */
+	stream.hdr.size = sizeof(stream);
+	stream.hdr.cmd = SOF_IPC_GLB_STREAM_MSG | SOF_IPC_STREAM_POSITION;
+	stream.comp_id = spcm->stream[direction].comp_id;
+
+	/* send IPC to the DSP */
+	err = sof_ipc_tx_message(sdev->ipc,
+				 stream.hdr.cmd, &stream, sizeof(stream), &posn,
+				 sizeof(*posn));
+	if (err < 0) {
+		dev_err(sdev->dev, "error: failed to get stream %d position\n",
+			stream.comp_id);
+		return err;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(snd_sof_ipc_stream_posn);
+
+/*
+ * IPC get()/set() for kcontrols.
+ */
+
+int snd_sof_ipc_set_comp_data(struct snd_sof_ipc *ipc,
+			      struct snd_sof_control *scontrol, u32 ipc_cmd,
+			      enum sof_ipc_ctrl_type ctrl_type,
+			      enum sof_ipc_ctrl_cmd ctrl_cmd)
+{
+	struct snd_sof_dev *sdev = ipc->sdev;
+	struct sof_ipc_ctrl_data *cdata = scontrol->control_data;
+	int err;
+
+	/* read firmware volume */
+	if (scontrol->readback_offset != 0) {
+		/* we can read value header via mmaped region */
+		snd_sof_dsp_block_write(sdev, scontrol->readback_offset,
+					cdata->chanv,
+					sizeof(struct sof_ipc_ctrl_value_chan) *
+					cdata->num_elems);
+
+	} else {
+		/* write value via slower IPC */
+		cdata->rhdr.hdr.cmd = SOF_IPC_GLB_COMP_MSG | ipc_cmd;
+		cdata->cmd = ctrl_cmd;
+		cdata->type = ctrl_type;
+		cdata->rhdr.hdr.size = scontrol->size;
+		cdata->comp_id = scontrol->comp_id;
+		cdata->num_elems = scontrol->num_channels;
+
+		/* send IPC to the DSP */
+		err = sof_ipc_tx_message(sdev->ipc,
+					 cdata->rhdr.hdr.cmd, cdata,
+					 cdata->rhdr.hdr.size,
+					 cdata, cdata->rhdr.hdr.size);
+		if (err < 0) {
+			dev_err(sdev->dev, "error: failed to set control %d values\n",
+				cdata->comp_id);
+			return err;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(snd_sof_ipc_set_comp_data);
+
+int snd_sof_ipc_get_comp_data(struct snd_sof_ipc *ipc,
+			      struct snd_sof_control *scontrol, u32 ipc_cmd,
+			      enum sof_ipc_ctrl_type ctrl_type,
+			      enum sof_ipc_ctrl_cmd ctrl_cmd)
+{
+	struct snd_sof_dev *sdev = ipc->sdev;
+	struct sof_ipc_ctrl_data *cdata = scontrol->control_data;
+	int err;
+
+	/* read firmware byte counters */
+	if (scontrol->readback_offset != 0) {
+		/* we can read values via mmaped region */
+		snd_sof_dsp_block_read(sdev, scontrol->readback_offset,
+				       cdata->chanv,
+				       sizeof(struct sof_ipc_ctrl_value_chan) *
+				       cdata->num_elems);
+
+	} else {
+		/* read position via slower IPC */
+		cdata->rhdr.hdr.cmd = SOF_IPC_GLB_COMP_MSG | ipc_cmd;
+		cdata->cmd = ctrl_cmd;
+		cdata->type = ctrl_type;
+		cdata->rhdr.hdr.size = scontrol->size;
+		cdata->comp_id = scontrol->comp_id;
+		cdata->num_elems = scontrol->num_channels;
+
+		/* send IPC to the DSP */
+		err = sof_ipc_tx_message(sdev->ipc,
+					 cdata->rhdr.hdr.cmd, cdata,
+					 cdata->rhdr.hdr.size,
+					 cdata, cdata->rhdr.hdr.size);
+		if (err < 0) {
+			dev_err(sdev->dev, "error: failed to get control %d values\n",
+				cdata->comp_id);
+			return err;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(snd_sof_ipc_get_comp_data);
+
+/*
+ * IPC layer enumeration.
+ */
+
+int snd_sof_dsp_mailbox_init(struct snd_sof_dev *sdev, u32 dspbox,
+			     size_t dspbox_size, u32 hostbox,
+			     size_t hostbox_size)
+{
+	sdev->dsp_box.offset = dspbox;
+	sdev->dsp_box.size = dspbox_size;
+	sdev->host_box.offset = hostbox;
+	sdev->host_box.size = hostbox_size;
+	return 0;
+}
+EXPORT_SYMBOL(snd_sof_dsp_mailbox_init);
+
+int snd_sof_ipc_valid(struct snd_sof_dev *sdev)
+{
+	struct sof_ipc_fw_ready *ready = &sdev->fw_ready;
+	struct sof_ipc_fw_version *v = &ready->version;
+
+	dev_info(sdev->dev,
+		 " Firmware info: version %d:%d:%d-%s\n",  v->major, v->minor,
+		 v->micro, v->tag);
+	dev_info(sdev->dev,
+		 " Firmware: ABI %d:%d:%d Kernel ABI %d:%d:%d\n",
+		 SOF_ABI_VERSION_MAJOR(v->abi_version),
+		 SOF_ABI_VERSION_MINOR(v->abi_version),
+		 SOF_ABI_VERSION_PATCH(v->abi_version),
+		 SOF_ABI_MAJOR, SOF_ABI_MINOR, SOF_ABI_PATCH);
+
+	if (SOF_ABI_VERSION_INCOMPATIBLE(SOF_ABI_VERSION, v->abi_version)) {
+		dev_err(sdev->dev, "error: incompatible FW ABI version\n");
+		return -EINVAL;
+	}
+
+	if (ready->debug.bits.build) {
+		dev_info(sdev->dev,
+			 " Firmware debug build %d on %s-%s - options:\n"
+			 "  GDB: %s\n"
+			 "  lock debug: %s\n"
+			 "  lock vdebug: %s\n",
+			 v->build, v->date, v->time,
+			 ready->debug.bits.gdb ? "enabled" : "disabled",
+			 ready->debug.bits.locks ? "enabled" : "disabled",
+			 ready->debug.bits.locks_verbose ?
+			 "enabled" : "disabled");
+	}
+
+	/* copy the fw_version into debugfs at first boot */
+	memcpy(&sdev->fw_version, v, sizeof(*v));
+
+	return 0;
+}
+EXPORT_SYMBOL(snd_sof_ipc_valid);
+
+struct snd_sof_ipc *snd_sof_ipc_init(struct snd_sof_dev *sdev)
+{
+	struct snd_sof_ipc *ipc;
+	struct snd_sof_ipc_msg *msg;
+	int i;
+
+	ipc = devm_kzalloc(sdev->dev, sizeof(*ipc), GFP_KERNEL);
+	if (!ipc)
+		return NULL;
+
+	INIT_LIST_HEAD(&ipc->tx_list);
+	INIT_LIST_HEAD(&ipc->reply_list);
+	INIT_LIST_HEAD(&ipc->empty_list);
+	init_waitqueue_head(&ipc->wait_txq);
+	INIT_WORK(&ipc->tx_kwork, ipc_tx_next_msg);
+	INIT_WORK(&ipc->rx_kwork, ipc_msgs_rx);
+	ipc->sdev = sdev;
+
+	/* pre-allocate messages */
+	dev_dbg(sdev->dev, "pre-allocate %d IPC messages\n",
+		IPC_EMPTY_LIST_SIZE);
+	msg = devm_kzalloc(sdev->dev, sizeof(struct snd_sof_ipc_msg) *
+			   IPC_EMPTY_LIST_SIZE, GFP_KERNEL);
+	if (!msg)
+		return NULL;
+
+	/* pre-allocate message data */
+	for (i = 0; i < IPC_EMPTY_LIST_SIZE; i++) {
+		msg->msg_data = devm_kzalloc(sdev->dev, PAGE_SIZE, GFP_KERNEL);
+		if (!msg->msg_data)
+			return NULL;
+
+		msg->reply_data = devm_kzalloc(sdev->dev, PAGE_SIZE,
+					       GFP_KERNEL);
+		if (!msg->reply_data)
+			return NULL;
+
+		init_waitqueue_head(&msg->waitq);
+		list_add(&msg->list, &ipc->empty_list);
+		msg++;
+	}
+
+	return ipc;
+}
+EXPORT_SYMBOL(snd_sof_ipc_init);
+
+void snd_sof_ipc_free(struct snd_sof_dev *sdev)
+{
+	cancel_work_sync(&sdev->ipc->tx_kwork);
+	cancel_work_sync(&sdev->ipc->rx_kwork);
+}
+EXPORT_SYMBOL(snd_sof_ipc_free);
-- 
2.17.1
