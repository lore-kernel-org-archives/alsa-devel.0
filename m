From: srinivas.kandagatla@linaro.org
Subject: [RFC PATCH 2/9] ASoC: qcom: qdsp6v2: Add support to Q6AFE
Date: Fri, 11 Aug 2017 15:29:45 +0200
Message-ID: <20170811132952.32572-3-srinivas.kandagatla@linaro.org>
References: <20170811132952.32572-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170811132952.32572-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Banajit Goswami <bgoswami@codeaurora.org>, alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.com>, Patrick Lai <plai@codeaurora.org>, linux-kernel@vger.kernel.org, kwestfie@codeaurora.org, linux-arm-msm@vger.kernel.org, lkasam@qti.qualcomm.com, sboyd@codeaurora.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds support to q6 AFE (Audio Front End) module on Q6DSP.

AFE module sits right at the other end of cpu where the codec/audio
devices are connected.

AFE provides abstraced interfaces to both hardware and virtual devices.
Each AFE tx/rx port can be configured to connect to one of the hardware
devices like codec, hdmi, slimbus, i2s and so on. AFE services include
starting, stopping, and if needed, any configurations of the ports.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/sound/qcom,q6afe.txt       |  15 +
 include/dt-bindings/sound/qcom,afe.h               |   8 +
 sound/soc/qcom/Kconfig                             |  13 +
 sound/soc/qcom/Makefile                            |   3 +
 sound/soc/qcom/qdsp6v2/Makefile                    |   1 +
 sound/soc/qcom/qdsp6v2/common.h                    | 225 ++++++++++
 sound/soc/qcom/qdsp6v2/q6afe-v2.h                  |  62 +++
 sound/soc/qcom/qdsp6v2/q6afe.c                     | 499 +++++++++++++++++++++
 8 files changed, 826 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6afe.txt
 create mode 100644 include/dt-bindings/sound/qcom,afe.h
 create mode 100644 sound/soc/qcom/qdsp6v2/Makefile
 create mode 100644 sound/soc/qcom/qdsp6v2/common.h
 create mode 100644 sound/soc/qcom/qdsp6v2/q6afe-v2.h
 create mode 100644 sound/soc/qcom/qdsp6v2/q6afe.c

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6afe.txt b/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
new file mode 100644
index 0000000..0ae5771
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
@@ -0,0 +1,15 @@
+Qualcomm Q6AFE (Q6 Audio FrontEnd) binding
+
+This bindings describe the Qualcomm Q6 AFE module on QDSP,
+which is used by audio drivers.
+
+- compatible:
+
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "qcom,q6afe-v<VERSION-NUMBER>" example: "qcom,q6asm-v2"
+
+= EXAMPLE
+	q6afe {
+		compatible = "qcom,q6afe-v2";
+	};
diff --git a/include/dt-bindings/sound/qcom,afe.h b/include/dt-bindings/sound/qcom,afe.h
new file mode 100644
index 0000000..2e58cde
--- /dev/null
+++ b/include/dt-bindings/sound/qcom,afe.h
@@ -0,0 +1,8 @@
+#ifndef __DT_AFE_H__
+#define __DT_AFE_H__
+
+/* Audio Front End (AFE) Ports */
+#define AFE_PORT_HDMI_RX	8
+#define AFE_PORT_MAX		9
+
+#endif
diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 8ec9a07..dad3fa1 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -43,3 +43,16 @@ config SND_SOC_APQ8016_SBC
           Support for Qualcomm Technologies LPASS audio block in
           APQ8016 SOC-based systems.
           Say Y if you want to use audio devices on MI2S.
+
+config SND_SOC_QDSP6V2_AFE
+	tristate
+	default n
+
+config SND_SOC_QDSP6V2
+	tristate "SoC ALSA audio driver for QDSP6V2"
+	select SND_SOC_QDSP6V2_AFE
+	help
+	 To add support for MSM QDSP6V2 Soc Audio.
+	 This will enable sound soc platform specific
+	 audio drivers. This includes q6asm, q6adm,
+	 q6afe interfaces to DSP using apr.
diff --git a/sound/soc/qcom/Makefile b/sound/soc/qcom/Makefile
index 79e5c50..a51bf0a 100644
--- a/sound/soc/qcom/Makefile
+++ b/sound/soc/qcom/Makefile
@@ -15,3 +15,6 @@ snd-soc-apq8016-sbc-objs := apq8016_sbc.o
 
 obj-$(CONFIG_SND_SOC_STORM) += snd-soc-storm.o
 obj-$(CONFIG_SND_SOC_APQ8016_SBC) += snd-soc-apq8016-sbc.o
+
+#DSP lib
+obj-$(CONFIG_SND_SOC_QDSP6V2) += qdsp6v2/
diff --git a/sound/soc/qcom/qdsp6v2/Makefile b/sound/soc/qcom/qdsp6v2/Makefile
new file mode 100644
index 0000000..8069891
--- /dev/null
+++ b/sound/soc/qcom/qdsp6v2/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_SND_SOC_QDSP6V2_AFE) += q6afe.o
diff --git a/sound/soc/qcom/qdsp6v2/common.h b/sound/soc/qcom/qdsp6v2/common.h
new file mode 100644
index 0000000..cbd6e00
--- /dev/null
+++ b/sound/soc/qcom/qdsp6v2/common.h
@@ -0,0 +1,225 @@
+/*
+ * Copyright (c) 2015-2017, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+#ifndef __Q6DSP_COMMON_H__
+#define __Q6DSP_COMMON_H__
+
+/* ERROR CODES */
+/* Success. The operation completed with no errors. */
+#define ADSP_EOK          0x00000000
+/* General failure. */
+#define ADSP_EFAILED      0x00000001
+/* Bad operation parameter. */
+#define ADSP_EBADPARAM    0x00000002
+/* Unsupported routine or operation. */
+#define ADSP_EUNSUPPORTED 0x00000003
+/* Unsupported version. */
+#define ADSP_EVERSION     0x00000004
+/* Unexpected problem encountered. */
+#define ADSP_EUNEXPECTED  0x00000005
+/* Unhandled problem occurred. */
+#define ADSP_EPANIC       0x00000006
+/* Unable to allocate resource. */
+#define ADSP_ENORESOURCE  0x00000007
+/* Invalid handle. */
+#define ADSP_EHANDLE      0x00000008
+/* Operation is already processed. */
+#define ADSP_EALREADY     0x00000009
+/* Operation is not ready to be processed. */
+#define ADSP_ENOTREADY    0x0000000A
+/* Operation is pending completion. */
+#define ADSP_EPENDING     0x0000000B
+/* Operation could not be accepted or processed. */
+#define ADSP_EBUSY        0x0000000C
+/* Operation aborted due to an error. */
+#define ADSP_EABORTED     0x0000000D
+/* Operation preempted by a higher priority. */
+#define ADSP_EPREEMPTED   0x0000000E
+/* Operation requests intervention to complete. */
+#define ADSP_ECONTINUE    0x0000000F
+/* Operation requests immediate intervention to complete. */
+#define ADSP_EIMMEDIATE   0x00000010
+/* Operation is not implemented. */
+#define ADSP_ENOTIMPL     0x00000011
+/* Operation needs more data or resources. */
+#define ADSP_ENEEDMORE    0x00000012
+/* Operation does not have memory. */
+#define ADSP_ENOMEMORY    0x00000014
+/* Item does not exist. */
+#define ADSP_ENOTEXIST    0x00000015
+/* Max count for adsp error code sent to HLOS*/
+#define ADSP_ERR_MAX      (ADSP_ENOTEXIST + 1)
+/* Operation is finished. */
+#define ADSP_ETERMINATED    0x00011174
+
+/* ERROR STRING */
+/* Success. The operation completed with no errors. */
+#define ADSP_EOK_STR          "ADSP_EOK"
+/* General failure. */
+#define ADSP_EFAILED_STR      "ADSP_EFAILED"
+/* Bad operation parameter. */
+#define ADSP_EBADPARAM_STR    "ADSP_EBADPARAM"
+/* Unsupported routine or operation. */
+#define ADSP_EUNSUPPORTED_STR "ADSP_EUNSUPPORTED"
+/* Unsupported version. */
+#define ADSP_EVERSION_STR     "ADSP_EVERSION"
+/* Unexpected problem encountered. */
+#define ADSP_EUNEXPECTED_STR  "ADSP_EUNEXPECTED"
+/* Unhandled problem occurred. */
+#define ADSP_EPANIC_STR       "ADSP_EPANIC"
+/* Unable to allocate resource. */
+#define ADSP_ENORESOURCE_STR  "ADSP_ENORESOURCE"
+/* Invalid handle. */
+#define ADSP_EHANDLE_STR      "ADSP_EHANDLE"
+/* Operation is already processed. */
+#define ADSP_EALREADY_STR     "ADSP_EALREADY"
+/* Operation is not ready to be processed. */
+#define ADSP_ENOTREADY_STR    "ADSP_ENOTREADY"
+/* Operation is pending completion. */
+#define ADSP_EPENDING_STR     "ADSP_EPENDING"
+/* Operation could not be accepted or processed. */
+#define ADSP_EBUSY_STR        "ADSP_EBUSY"
+/* Operation aborted due to an error. */
+#define ADSP_EABORTED_STR     "ADSP_EABORTED"
+/* Operation preempted by a higher priority. */
+#define ADSP_EPREEMPTED_STR   "ADSP_EPREEMPTED"
+/* Operation requests intervention to complete. */
+#define ADSP_ECONTINUE_STR    "ADSP_ECONTINUE"
+/* Operation requests immediate intervention to complete. */
+#define ADSP_EIMMEDIATE_STR   "ADSP_EIMMEDIATE"
+/* Operation is not implemented. */
+#define ADSP_ENOTIMPL_STR     "ADSP_ENOTIMPL"
+/* Operation needs more data or resources. */
+#define ADSP_ENEEDMORE_STR    "ADSP_ENEEDMORE"
+/* Operation does not have memory. */
+#define ADSP_ENOMEMORY_STR    "ADSP_ENOMEMORY"
+/* Item does not exist. */
+#define ADSP_ENOTEXIST_STR    "ADSP_ENOTEXIST"
+/* Unexpected error code. */
+#define ADSP_ERR_MAX_STR      "ADSP_ERR_MAX"
+
+#define PCM_FORMAT_MAX_NUM_CHANNEL  8
+#define PCM_CHANNEL_NULL 0
+
+#define PCM_CHANNEL_FL    1	/* Front left channel. */
+#define PCM_CHANNEL_FR    2	/* Front right channel. */
+#define PCM_CHANNEL_FC    3	/* Front center channel. */
+#define PCM_CHANNEL_LS   4	/* Left surround channel. */
+#define PCM_CHANNEL_RS   5	/* Right surround channel. */
+#define PCM_CHANNEL_LFE  6	/* Low frequency effect channel. */
+#define PCM_CHANNEL_CS   7	/* Center surround channel; Rear center ch */
+#define PCM_CHANNEL_LB   8	/* Left back channel; Rear left channel. */
+#define PCM_CHANNEL_RB   9	/* Right back channel; Rear right channel. */
+#define PCM_CHANNELS   10	/* Top surround channel. */
+
+static inline int q6dsp_map_channels(u8 *ch_map, int ch)
+{
+	memset(ch_map, 0, PCM_FORMAT_MAX_NUM_CHANNEL);
+
+	if (ch == 1) {
+		ch_map[0] = PCM_CHANNEL_FC;
+	} else if (ch == 2) {
+		ch_map[0] = PCM_CHANNEL_FL;
+		ch_map[1] = PCM_CHANNEL_FR;
+	} else if (ch == 3) {
+		ch_map[0] = PCM_CHANNEL_FL;
+		ch_map[1] = PCM_CHANNEL_FR;
+		ch_map[2] = PCM_CHANNEL_FC;
+	} else if (ch == 4) {
+		ch_map[0] = PCM_CHANNEL_FL;
+		ch_map[1] = PCM_CHANNEL_FR;
+		ch_map[2] = PCM_CHANNEL_LS;
+		ch_map[3] = PCM_CHANNEL_RS;
+	} else if (ch == 5) {
+		ch_map[0] = PCM_CHANNEL_FL;
+		ch_map[1] = PCM_CHANNEL_FR;
+		ch_map[2] = PCM_CHANNEL_FC;
+		ch_map[3] = PCM_CHANNEL_LS;
+		ch_map[4] = PCM_CHANNEL_RS;
+	} else if (ch == 6) {
+		ch_map[0] = PCM_CHANNEL_FL;
+		ch_map[1] = PCM_CHANNEL_FR;
+		ch_map[2] = PCM_CHANNEL_LFE;
+		ch_map[3] = PCM_CHANNEL_FC;
+		ch_map[4] = PCM_CHANNEL_LS;
+		ch_map[5] = PCM_CHANNEL_RS;
+	} else if (ch == 8) {
+		ch_map[0] = PCM_CHANNEL_FL;
+		ch_map[1] = PCM_CHANNEL_FR;
+		ch_map[2] = PCM_CHANNEL_LFE;
+		ch_map[3] = PCM_CHANNEL_FC;
+		ch_map[4] = PCM_CHANNEL_LS;
+		ch_map[5] = PCM_CHANNEL_RS;
+		ch_map[6] = PCM_CHANNEL_LB;
+		ch_map[7] = PCM_CHANNEL_RB;
+	} else {
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+enum {
+	LEGACY_PCM_MODE = 0,
+	LOW_LATENCY_PCM_MODE,
+	ULTRA_LOW_LATENCY_PCM_MODE,
+	ULL_POST_PROCESSING_PCM_MODE,
+};
+
+struct adsp_err_code {
+	int		lnx_err_code;
+	char	*adsp_err_str;
+};
+
+static struct adsp_err_code adsp_err_code_info[ADSP_ERR_MAX+1] = {
+	{ 0, ADSP_EOK_STR},
+	{ -ENOTRECOVERABLE, ADSP_EFAILED_STR},
+	{ -EINVAL, ADSP_EBADPARAM_STR},
+	{ -ENOSYS, ADSP_EUNSUPPORTED_STR},
+	{ -ENOPROTOOPT, ADSP_EVERSION_STR},
+	{ -ENOTRECOVERABLE, ADSP_EUNEXPECTED_STR},
+	{ -ENOTRECOVERABLE, ADSP_EPANIC_STR},
+	{ -ENOSPC, ADSP_ENORESOURCE_STR},
+	{ -EBADR, ADSP_EHANDLE_STR},
+	{ -EALREADY, ADSP_EALREADY_STR},
+	{ -EPERM, ADSP_ENOTREADY_STR},
+	{ -EINPROGRESS, ADSP_EPENDING_STR},
+	{ -EBUSY, ADSP_EBUSY_STR},
+	{ -ECANCELED, ADSP_EABORTED_STR},
+	{ -EAGAIN, ADSP_EPREEMPTED_STR},
+	{ -EAGAIN, ADSP_ECONTINUE_STR},
+	{ -EAGAIN, ADSP_EIMMEDIATE_STR},
+	{ -EAGAIN, ADSP_ENOTIMPL_STR},
+	{ -ENODATA, ADSP_ENEEDMORE_STR},
+	{ -EADV, ADSP_ERR_MAX_STR},
+	{ -ENOMEM, ADSP_ENOMEMORY_STR},
+	{ -ENODEV, ADSP_ENOTEXIST_STR},
+	{ -EADV, ADSP_ERR_MAX_STR},
+};
+
+static inline int adsp_err_get_lnx_err_code(u32 adsp_error)
+{
+	if (adsp_error > ADSP_ERR_MAX)
+		return adsp_err_code_info[ADSP_ERR_MAX].lnx_err_code;
+	else
+		return adsp_err_code_info[adsp_error].lnx_err_code;
+}
+
+static inline char *adsp_err_get_err_str(u32 adsp_error)
+{
+	if (adsp_error > ADSP_ERR_MAX)
+		return adsp_err_code_info[ADSP_ERR_MAX].adsp_err_str;
+	else
+		return adsp_err_code_info[adsp_error].adsp_err_str;
+}
+
+#endif /* __Q6DSP_COMMON_H__ */
diff --git a/sound/soc/qcom/qdsp6v2/q6afe-v2.h b/sound/soc/qcom/qdsp6v2/q6afe-v2.h
new file mode 100644
index 0000000..bb73709
--- /dev/null
+++ b/sound/soc/qcom/qdsp6v2/q6afe-v2.h
@@ -0,0 +1,62 @@
+#ifndef __Q6AFE_V2_H__
+#define __Q6AFE_V2_H__
+#include <dt-bindings/sound/qcom,afe.h>
+#define MSM_AFE_PORT_TYPE_RX 0
+#define MSM_AFE_PORT_TYPE_TX 1
+#define AFE_MAX_PORTS AFE_PORT_MAX
+
+struct q6afe_hdmi_cfg {
+	u16                  datatype;
+	u16                  channel_allocation;
+	u32                  sample_rate;
+	u16                  bit_width;
+};
+
+struct q6afe_port;
+
+#if IS_ENABLED(CONFIG_SND_SOC_QDSP6V2_AFE)
+
+struct q6afe_port *q6afe_port_get(struct device *dev, const char *name);
+int q6afe_get_port_index(struct q6afe_port *p);
+int q6afe_port_stop(struct q6afe_port *port);
+int q6afe_port_put(struct q6afe_port *port);
+int q6afe_get_port_id(int index);
+int q6afe_hdmi_port_start(struct q6afe_port *port,
+			  struct q6afe_hdmi_cfg *cfg);
+
+#else
+
+static inline int q6afe_get_port_id(int index)
+{
+	return -ENOSYS;
+}
+
+static inline int q6afe_get_port_index(struct q6afe_port *p)
+{
+	return -ENOSYS;
+}
+static inline struct q6afe_port *q6afe_port_get(struct device *dev,
+						const char *name)
+{
+	return ERR_PTR(-ENOSYS);
+}
+
+static inline int q6afe_hdmi_port_start(struct q6afe_port *port,
+					struct q6afe_hdmi_cfg *cfg)
+{
+	return -ENOSYS;
+}
+
+static inline int q6afe_port_stop(struct q6afe_port *port)
+{
+	return -ENOSYS;
+}
+
+static inline int q6afe_port_put(struct q6afe_port *port)
+{
+	return -ENOSYS;
+}
+
+#endif
+
+#endif /* __Q6AFE_V2_H__ */
diff --git a/sound/soc/qcom/qdsp6v2/q6afe.c b/sound/soc/qcom/qdsp6v2/q6afe.c
new file mode 100644
index 0000000..ebb9f54
--- /dev/null
+++ b/sound/soc/qcom/qdsp6v2/q6afe.c
@@ -0,0 +1,499 @@
+/* Copyright (c) 2012-2017, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/kernel.h>
+#include <linux/uaccess.h>
+#include <linux/wait.h>
+#include <linux/jiffies.h>
+#include <linux/sched.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <dt-bindings/sound/qcom,afe.h>
+#include <linux/delay.h>
+#include <linux/soc/qcom/apr.h>
+#include "common.h"
+#include "q6afe-v2.h"
+
+/* AFE Cmds */
+#define AFE_PORT_CMD_DEVICE_START	0x000100E5
+#define AFE_PORT_CMD_DEVICE_STOP	0x000100E6
+#define AFE_PORT_CMD_SET_PARAM_V2	0x000100EF
+#define AFE_PORT_CMDRSP_GET_PARAM_V2	0x00010106
+#define AFE_PARAM_ID_HDMI_CONFIG	0x00010210
+#define AFE_MODULE_AUDIO_DEV_INTERFACE	0x0001020C
+
+/* Port IDs */
+#define AFE_API_VERSION_HDMI_CONFIG	0x1
+#define AFE_PORT_ID_MULTICHAN_HDMI_RX       0x100E
+#define TIMEOUT_MS 1000
+#define AFE_CMD_RESP_AVAIL	0
+#define AFE_CMD_RESP_NONE	1
+
+struct q6afe_port {
+	wait_queue_head_t wait;
+	int token;
+	int id;
+	int cfg_type;
+	union {
+		struct q6afev2 *v2;
+	} afe;
+	struct list_head	node;
+};
+
+struct q6afev2 {
+	void *apr;
+	struct device *dev;
+	int state;
+	int status;
+
+	struct mutex afe_cmd_lock;
+	struct list_head port_list;
+	struct mutex port_list_lock;
+	struct list_head node;
+};
+
+struct afe_port_cmd_device_start {
+	struct apr_hdr hdr;
+	u16 port_id;
+	u16 reserved;
+} __packed;
+
+struct afe_port_cmd_device_stop {
+	struct apr_hdr hdr;
+	u16 port_id;
+	u16 reserved;
+/* Reserved for 32-bit alignment. This field must be set to 0.*/
+} __packed;
+
+struct afe_port_param_data_v2 {
+	u32 module_id;
+	u32 param_id;
+	u16 param_size;
+	u16 reserved;
+} __packed;
+
+struct afe_port_cmd_set_param_v2 {
+	u16 port_id;
+	u16 payload_size;
+	u32 payload_address_lsw;
+	u32 payload_address_msw;
+	u32 mem_map_handle;
+} __packed;
+
+struct afe_param_id_hdmi_multi_chan_audio_cfg {
+	u32 hdmi_cfg_minor_version;
+	u16 datatype;
+	u16 channel_allocation;
+	u32 sample_rate;
+	u16 bit_width;
+	u16 reserved;
+} __packed;
+
+union afe_port_config {
+	struct afe_param_id_hdmi_multi_chan_audio_cfg hdmi_multi_ch;
+} __packed;
+
+struct afe_audioif_config_command {
+	struct apr_hdr hdr;
+	struct afe_port_cmd_set_param_v2 param;
+	struct afe_port_param_data_v2 pdata;
+	union afe_port_config port;
+} __packed;
+
+struct afe_port_map {
+	int port_id;
+	int token;
+	int is_rx;
+};
+
+struct q6afev2  *__afe;
+/* Port map of index vs real hw port ids */
+static struct afe_port_map port_maps[AFE_PORT_MAX] = {
+		[AFE_PORT_HDMI_RX] = { AFE_PORT_ID_MULTICHAN_HDMI_RX,
+				       AFE_PORT_HDMI_RX, 1},
+};
+
+static struct q6afev2 *of_parse_q6afe_port(struct device *dev, const char *name,
+					   int *id)
+{
+	struct of_phandle_args args;
+	int ret;
+
+	ret = of_parse_phandle_with_fixed_args(dev->of_node, name, 1, 0, &args);
+	if (ret < 0) {
+		dev_err(dev, "Failed to parse qcom,afe-port\n");
+		return NULL;
+	}
+
+	*id = args.args[0];
+
+	if (__afe && __afe->dev->of_node == args.np)
+		return __afe;
+
+	return NULL;
+}
+
+static struct q6afe_port *afe_find_port(struct q6afev2 *afe, int token)
+{
+	struct q6afe_port *p;
+
+	list_for_each_entry(p, &afe->port_list, node)
+		if (p->token == token)
+			return p;
+
+	return NULL;
+}
+
+static int32_t afe_callback(struct apr_client_data *data, void *priv)
+{
+	struct q6afev2 *afe = priv;
+	struct q6afe_port *port;
+
+	if (!data) {
+		dev_err(afe->dev, "%s: Invalid param data\n", __func__);
+		return -EINVAL;
+	}
+
+	if (data->payload_size) {
+		uint32_t *payload = data->payload;
+
+		if (data->opcode == APR_BASIC_RSP_RESULT) {
+			if (payload[1] != 0) {
+				afe->status = payload[1];
+				dev_err(afe->dev,
+					"cmd = 0x%x returned error = 0x%x\n",
+					payload[0], payload[1]);
+			}
+			switch (payload[0]) {
+			case AFE_PORT_CMD_SET_PARAM_V2:
+			case AFE_PORT_CMD_DEVICE_STOP:
+			case AFE_PORT_CMD_DEVICE_START:
+				afe->state = AFE_CMD_RESP_AVAIL;
+				port = afe_find_port(afe, data->token);
+				if (port)
+					wake_up(&port->wait);
+
+				break;
+			default:
+				dev_err(afe->dev, "Unknown cmd 0x%x\n",
+					payload[0]);
+				break;
+			}
+		}
+	}
+	return 0;
+}
+
+int q6afe_get_port_id(int index)
+{
+	if (index < 0 || index > AFE_PORT_MAX) {
+		pr_err("%s: AFE port index[%d] invalid!\n", __func__, index);
+		return -EINVAL;
+	}
+
+	return port_maps[index].port_id;
+}
+EXPORT_SYMBOL_GPL(q6afe_get_port_id);
+
+static int afe_apr_send_pkt(struct q6afev2 *afe, void *data,
+			    wait_queue_head_t *wait)
+{
+	int ret;
+
+	if (wait)
+		afe->state = AFE_CMD_RESP_NONE;
+
+	afe->status = 0;
+	ret = apr_send_pkt(afe->apr, data);
+	if (ret > 0) {
+		if (wait) {
+			ret = wait_event_timeout(*wait,
+						 (afe->state ==
+						 AFE_CMD_RESP_AVAIL),
+						 msecs_to_jiffies(TIMEOUT_MS));
+			if (!ret) {
+				ret = -ETIMEDOUT;
+			} else if (afe->status > 0) {
+				dev_err(afe->dev, "DSP returned error[%s]\n",
+				       adsp_err_get_err_str(afe->status));
+				ret = adsp_err_get_lnx_err_code(afe->status);
+			} else {
+				ret = 0;
+			}
+		} else {
+			ret = 0;
+		}
+	} else if (ret == 0) {
+		dev_err(afe->dev, "packet not transmitted\n");
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static int afe_send_cmd_port_start(struct q6afe_port *port)
+{
+	u16 port_id = port->id;
+	struct afe_port_cmd_device_start start;
+	struct q6afev2 *afe = port->afe.v2;
+	int ret, index;
+
+	index = port->token;
+	start.hdr.hdr_field = APR_HDR_FIELD(APR_MSG_TYPE_SEQ_CMD,
+					    APR_HDR_LEN(APR_HDR_SIZE),
+					    APR_PKT_VER);
+	start.hdr.pkt_size = sizeof(start);
+	start.hdr.src_port = 0;
+	start.hdr.dest_port = 0;
+	start.hdr.token = index;
+	start.hdr.opcode = AFE_PORT_CMD_DEVICE_START;
+	start.port_id = port_id;
+
+	ret = afe_apr_send_pkt(afe, &start, &port->wait);
+	if (ret)
+		dev_err(afe->dev, "AFE enable for port 0x%x failed %d\n",
+		       port_id, ret);
+
+	return ret;
+}
+
+static int afe_port_start(struct q6afe_port *port,
+			  union afe_port_config *afe_config)
+{
+	struct afe_audioif_config_command config;
+	struct q6afev2 *afe = port->afe.v2;
+	int ret = 0;
+	int port_id = port->id;
+	int cfg_type;
+	int index = 0;
+
+	if (!afe_config) {
+		dev_err(afe->dev, "Error, no configuration data\n");
+		ret = -EINVAL;
+		return ret;
+	}
+
+	index = port->token;
+
+	mutex_lock(&afe->afe_cmd_lock);
+	/* Also send the topology id here: */
+	config.hdr.hdr_field = APR_HDR_FIELD(APR_MSG_TYPE_SEQ_CMD,
+					     APR_HDR_LEN(APR_HDR_SIZE),
+					     APR_PKT_VER);
+	config.hdr.pkt_size = sizeof(config);
+	config.hdr.src_port = 0;
+	config.hdr.dest_port = 0;
+	config.hdr.token = index;
+
+	cfg_type = port->cfg_type;
+	config.hdr.opcode = AFE_PORT_CMD_SET_PARAM_V2;
+	config.param.port_id = port_id;
+	config.param.payload_size = sizeof(config) - sizeof(struct apr_hdr) -
+	    sizeof(config.param);
+	config.param.payload_address_lsw = 0x00;
+	config.param.payload_address_msw = 0x00;
+	config.param.mem_map_handle = 0x00;
+	config.pdata.module_id = AFE_MODULE_AUDIO_DEV_INTERFACE;
+	config.pdata.param_id = cfg_type;
+	config.pdata.param_size = sizeof(config.port);
+
+	config.port = *afe_config;
+
+	ret = afe_apr_send_pkt(afe, &config, &port->wait);
+	if (ret) {
+		dev_err(afe->dev, "AFE enable for port 0x%x failed %d\n",
+			port_id, ret);
+		goto fail_cmd;
+	}
+
+	ret = afe_send_cmd_port_start(port);
+
+fail_cmd:
+	mutex_unlock(&afe->afe_cmd_lock);
+	return ret;
+}
+
+int q6afe_get_port_index(struct q6afe_port *p)
+{
+	return p->token;
+}
+
+int q6afe_port_stop(struct q6afe_port *port)
+{
+	int port_id = port->id;
+	struct afe_port_cmd_device_stop stop;
+	struct q6afev2 *afe = port->afe.v2;
+	int ret = 0;
+	int index = 0;
+
+	port_id = port->id;
+	index = port->token;
+	if (index < 0 || index > AFE_PORT_MAX) {
+		dev_err(afe->dev, "AFE port index[%d] invalid!\n", index);
+		return -EINVAL;
+	}
+
+	stop.hdr.hdr_field = APR_HDR_FIELD(APR_MSG_TYPE_SEQ_CMD,
+					   APR_HDR_LEN(APR_HDR_SIZE),
+					   APR_PKT_VER);
+	stop.hdr.pkt_size = sizeof(stop);
+	stop.hdr.src_port = 0;
+	stop.hdr.dest_port = 0;
+	stop.hdr.token = index;
+	stop.hdr.opcode = AFE_PORT_CMD_DEVICE_STOP;
+	stop.port_id = port_id;
+	stop.reserved = 0;
+
+	ret = afe_apr_send_pkt(afe, &stop, &port->wait);
+	if (ret)
+		dev_err(afe->dev, "AFE close failed %d\n", ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(q6afe_port_stop);
+
+int q6afe_hdmi_port_start(struct q6afe_port *port, struct q6afe_hdmi_cfg *cfg)
+{
+	union afe_port_config port_cfg;
+
+	port_cfg.hdmi_multi_ch.hdmi_cfg_minor_version =
+	    AFE_API_VERSION_HDMI_CONFIG;
+	port_cfg.hdmi_multi_ch.datatype = cfg->datatype;
+	port_cfg.hdmi_multi_ch.channel_allocation = cfg->channel_allocation;
+	port_cfg.hdmi_multi_ch.sample_rate = cfg->sample_rate;
+	port_cfg.hdmi_multi_ch.bit_width = cfg->bit_width;
+
+	return afe_port_start(port, &port_cfg);
+}
+EXPORT_SYMBOL_GPL(q6afe_hdmi_port_start);
+
+struct q6afe_port *q6afe_port_get(struct device *dev, const char *name)
+{
+	int port_id, index = 0;
+	struct q6afev2 *afe = of_parse_q6afe_port(dev, name, &index);
+	struct q6afe_port *port;
+	int token;
+	int cfg_type;
+
+	if (!afe) {
+		dev_err(dev, "Unable to find instance of afe service\n");
+		return ERR_PTR(-ENOENT);
+	}
+
+	token = index;
+	if (token < 0 || token > AFE_PORT_MAX) {
+		dev_err(dev, "AFE port token[%d] invalid!\n", token);
+		return ERR_PTR(-EINVAL);
+	}
+
+	port_id = port_maps[index].port_id;
+
+	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
+	if (!port)
+		return ERR_PTR(-ENOMEM);
+
+	init_waitqueue_head(&port->wait);
+
+	port->token = token;
+	port->id = port_id;
+
+	port->afe.v2 = afe;
+	switch (port_id) {
+	case AFE_PORT_ID_MULTICHAN_HDMI_RX:
+		cfg_type = AFE_PARAM_ID_HDMI_CONFIG;
+		break;
+	default:
+		dev_err(dev, "Invalid port id 0x%x\n", port_id);
+		return ERR_PTR(-EINVAL);
+	}
+
+	port->cfg_type = cfg_type;
+
+	mutex_lock(&afe->port_list_lock);
+	list_add_tail(&port->node, &afe->port_list);
+	mutex_unlock(&afe->port_list_lock);
+
+	return port;
+
+}
+EXPORT_SYMBOL_GPL(q6afe_port_get);
+
+int q6afe_port_put(struct q6afe_port *port)
+{
+	struct q6afev2 *afe = port->afe.v2;
+
+	mutex_lock(&afe->port_list_lock);
+	list_del(&port->node);
+	mutex_unlock(&afe->port_list_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(q6afe_port_put);
+
+static int q6afev2_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct device *dev = &pdev->dev;
+
+	__afe = kzalloc(sizeof(*__afe), GFP_KERNEL);
+	if (!__afe)
+		return -ENOMEM;
+
+	__afe->apr = apr_register(dev, "ADSP", "AFE",
+				afe_callback, 0xFFFFFFFF, __afe);
+	if (__afe->apr == NULL) {
+		dev_err(dev, "Unable to register AFE\n");
+		ret = -ENODEV;
+	}
+
+	mutex_init(&__afe->afe_cmd_lock);
+	__afe->dev = dev;
+	INIT_LIST_HEAD(&__afe->port_list);
+	mutex_init(&__afe->port_list_lock);
+
+	platform_set_drvdata(pdev, __afe);
+	return 0;
+}
+
+static int q6afev2_remove(struct platform_device *pdev)
+{
+	int rval;
+
+	rval = apr_deregister(__afe->apr);
+	if (rval < 0)
+		return rval;
+
+	kfree(__afe);
+	__afe = NULL;
+
+	return 0;
+}
+
+static const struct of_device_id qcom_q6afe_match[] = {
+	{.compatible = "qcom,q6afe-v2",},
+	{}
+};
+
+static struct platform_driver qcom_q6afe_driver = {
+	.probe = q6afev2_probe,
+	.remove = q6afev2_remove,
+	.driver = {
+		   .name = "qcom-q6afe-v2",
+		   .of_match_table = qcom_q6afe_match,
+		   },
+};
+
+module_platform_driver(qcom_q6afe_driver);
+MODULE_AUTHOR("Srinivas Kandagatla <srinivas.kandagatla@linaro.org");
+MODULE_DESCRIPTION("q6 Audio Front End driver");
+MODULE_LICENSE("GPL v2");
-- 
2.9.3
