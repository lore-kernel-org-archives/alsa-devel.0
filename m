From: srinivas.kandagatla@linaro.org
Subject: [RFC PATCH 3/9] ASoC: qcom: qdsp6v2: Add support to Q6ADM
Date: Fri, 11 Aug 2017 15:29:46 +0200
Message-ID: <20170811132952.32572-4-srinivas.kandagatla@linaro.org>
References: <20170811132952.32572-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170811132952.32572-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Banajit Goswami <bgoswami@codeaurora.org>, alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.com>, Patrick Lai <plai@codeaurora.org>, linux-kernel@vger.kernel.org, kwestfie@codeaurora.org, linux-arm-msm@vger.kernel.org, lkasam@qti.qualcomm.com, sboyd@codeaurora.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds support to q6 ADM (Audio Device Manager) module in
q6dsp. ADM performs routing between audio streams and AFE ports.
It does Rate matching for streams going to devices driven by
different clocks, it handles volume ramping, Mixing with channel
and bit-width. ADM creates and destroys dynamic COPP services
for device-related audio processing as needed.

This patch adds basic support to ADM.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/sound/qcom,q6adm.txt       |  15 +
 sound/soc/qcom/Kconfig                             |   5 +
 sound/soc/qcom/qdsp6v2/Makefile                    |   1 +
 sound/soc/qcom/qdsp6v2/q6adm-v2.h                  |  76 +++
 sound/soc/qcom/qdsp6v2/q6adm.c                     | 603 +++++++++++++++++++++
 5 files changed, 700 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6adm.txt
 create mode 100644 sound/soc/qcom/qdsp6v2/q6adm-v2.h
 create mode 100644 sound/soc/qcom/qdsp6v2/q6adm.c

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6adm.txt b/Documentation/devicetree/bindings/sound/qcom,q6adm.txt
new file mode 100644
index 0000000..859d0cc
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,q6adm.txt
@@ -0,0 +1,15 @@
+Qualcomm Q6ADM (Q6 Audio Device Manager) binding
+
+This bindings describe the Qualcomm Q6 ADM module on QDSP,
+which is used by audio drivers.
+
+- compatible:
+
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "qcom,q6adm-v<VERSION-NUMBER>" example: "qcom,q6adm-v2"
+
+= EXAMPLE
+	q6adm {
+		compatible = "qcom,q6adm-v2";
+	};
diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index dad3fa1..72f6fa4 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -48,9 +48,14 @@ config SND_SOC_QDSP6V2_AFE
 	tristate
 	default n
 
+config SND_SOC_QDSP6V2_ADM
+	tristate
+	default n
+
 config SND_SOC_QDSP6V2
 	tristate "SoC ALSA audio driver for QDSP6V2"
 	select SND_SOC_QDSP6V2_AFE
+	select SND_SOC_QDSP6V2_ADM
 	help
 	 To add support for MSM QDSP6V2 Soc Audio.
 	 This will enable sound soc platform specific
diff --git a/sound/soc/qcom/qdsp6v2/Makefile b/sound/soc/qcom/qdsp6v2/Makefile
index 8069891..a2b8b0b 100644
--- a/sound/soc/qcom/qdsp6v2/Makefile
+++ b/sound/soc/qcom/qdsp6v2/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_SND_SOC_QDSP6V2_AFE) += q6afe.o
+obj-$(CONFIG_SND_SOC_QDSP6V2_ADM) += q6adm.o
diff --git a/sound/soc/qcom/qdsp6v2/q6adm-v2.h b/sound/soc/qcom/qdsp6v2/q6adm-v2.h
new file mode 100644
index 0000000..9cf369d
--- /dev/null
+++ b/sound/soc/qcom/qdsp6v2/q6adm-v2.h
@@ -0,0 +1,76 @@
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
+#ifndef __Q6_ADM_V2_H__
+#define __Q6_ADM_V2_H__
+
+#define ADM_PATH_PLAYBACK 0x1
+#define MAX_COPPS_PER_PORT 8
+#define NULL_COPP_TOPOLOGY				0x00010312
+
+/* multiple copp per stream. */
+struct route_payload {
+	unsigned int copp_idx[MAX_COPPS_PER_PORT];
+	unsigned short num_copps;
+	unsigned int session_id;
+
+	unsigned int port_id[MAX_COPPS_PER_PORT];
+	int app_type;
+	int acdb_dev_id;
+	int sample_rate;
+};
+
+struct q6adm;
+#if IS_ENABLED(CONFIG_SND_SOC_QDSP6V2_ADM)
+struct q6adm *q6adm_get(struct device *dev);
+void q6adm_put(struct q6adm *adm);
+int q6adm_open(struct q6adm *_adm, int port_id, int path, int rate,
+	       int channel_mode, int topology, int perf_mode,
+	       uint16_t bit_width, int app_type, int acdb_id);
+int q6adm_close(int port, int topology, int perf_mode);
+int q6adm_matrix_map(int path, struct route_payload payload_map, int perf_mode);
+int q6adm_connect_afe_port(int mode, int session_id, int port_id);
+
+#else
+
+static inline struct q6adm *q6adm_get(struct device *dev)
+{
+	return PTR_ERR(-ENOSYS);
+}
+
+static inline void q6adm_put(struct q6adm *adm) {}
+
+static inline int q6adm_open(struct q6adm *_adm, int port_id, int path,
+			     int rate, int channel_mode, int topology,
+			     int perf_mode, uint16_t bit_width, int app_type,
+			     int acdb_id)
+{
+	return -ENOSYS;
+}
+
+static inline int q6adm_close(int port, int topology, int perf_mode)
+{
+	return -ENOSYS;
+}
+
+static inline int q6adm_matrix_map(int path, struct route_payload payload_map,
+				 int perf_mode)
+{
+	return -ENOSYS;
+}
+
+static inline int q6adm_connect_afe_port(int mode, int session_id, int port_id)
+{
+	return -ENOSYS;
+}
+
+#endif
+#endif /* __Q6_ADM_V2_H__ */
diff --git a/sound/soc/qcom/qdsp6v2/q6adm.c b/sound/soc/qcom/qdsp6v2/q6adm.c
new file mode 100644
index 0000000..5ffda62
--- /dev/null
+++ b/sound/soc/qcom/qdsp6v2/q6adm.c
@@ -0,0 +1,603 @@
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
+#include <linux/wait.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/jiffies.h>
+#include <linux/wait.h>
+#include <linux/soc/qcom/apr.h>
+#include <linux/platform_device.h>
+#include <sound/asound.h>
+#include "q6adm-v2.h"
+#include "q6afe-v2.h"
+#include "common.h"
+
+#define ADM_CMD_DEVICE_OPEN_V5		0x00010326
+#define ADM_CMDRSP_DEVICE_OPEN_V5	0x00010329
+#define ADM_CMD_DEVICE_CLOSE_V5		0x00010327
+#define ADM_CMD_MATRIX_MAP_ROUTINGS_V5	0x00010325
+
+#define TIMEOUT_MS 1000
+#define RESET_COPP_ID 99
+#define INVALID_COPP_ID 0xFF
+/* Definition for a legacy device session. */
+#define ADM_LEGACY_DEVICE_SESSION	0
+#define ADM_MATRIX_ID_AUDIO_RX		0
+
+struct copp {
+	int afe_port;
+	int copp_idx;
+	int id;
+	int cnt;
+	int topology;
+	int mode;
+	int stat;
+	int rate;
+	int bit_width;
+	int channels;
+	int app_type;
+	int acdb_id;
+	wait_queue_head_t wait;
+	struct list_head node;
+};
+
+struct q6adm {
+	void *apr;
+	struct device *dev;
+	unsigned long copp_bitmap[AFE_MAX_PORTS];
+	struct list_head copps_list;
+	struct mutex copps_list_lock;
+	int matrix_map_stat;
+	wait_queue_head_t matrix_map_wait;
+};
+
+static struct q6adm *__adm;
+
+static struct copp *adm_find_copp(struct q6adm *adm, int port_idx, int copp_idx)
+{
+	struct copp *c;
+
+	list_for_each_entry(c, &adm->copps_list, node) {
+		if ((port_idx == c->afe_port) && (copp_idx == c->copp_idx))
+			return c;
+	}
+
+	return NULL;
+
+}
+
+static struct copp *adm_find_matching_copp(struct q6adm *adm,
+					   int port_idx, int topology,
+					   int mode, int rate,
+					   int bit_width, int app_type)
+{
+	struct copp *c;
+
+	list_for_each_entry(c, &adm->copps_list, node) {
+		if ((port_idx == c->afe_port) && (topology == c->topology) &&
+		    (mode == c->mode) && (rate == c->rate) &&
+		    (bit_width == c->bit_width) && (app_type == c->app_type))
+			return c;
+	}
+
+	return NULL;
+
+}
+
+static int32_t adm_callback(struct apr_client_data *data, void *priv)
+{
+	uint32_t *payload;
+	int port_idx, copp_idx;
+	struct copp *copp;
+
+	if (data == NULL) {
+		pr_err("%s: data parameter is null\n", __func__);
+		return -EINVAL;
+	}
+
+	payload = data->payload;
+
+	if (data->payload_size) {
+		copp_idx = (data->token) & 0XFF;
+		port_idx = ((data->token) >> 16) & 0xFF;
+		if (port_idx < 0 || port_idx >= AFE_MAX_PORTS) {
+			pr_err("%s: Invalid port idx %d token %d\n",
+			       __func__, port_idx, data->token);
+			return 0;
+		}
+		if (copp_idx < 0 || copp_idx >= MAX_COPPS_PER_PORT) {
+			pr_err("%s: Invalid copp idx %d token %d\n",
+			       __func__, copp_idx, data->token);
+			return 0;
+		}
+
+		if (data->opcode == APR_BASIC_RSP_RESULT) {
+			pr_err("%s: APR_BASIC_RSP_RESULT id 0x%x\n",
+			       __func__, payload[0]);
+			if (payload[1] != 0) {
+				pr_err("%s: cmd = 0x%x returned error = 0x%x\n",
+				       __func__, payload[0], payload[1]);
+			}
+			switch (payload[0]) {
+			case ADM_CMD_DEVICE_OPEN_V5:
+			case ADM_CMD_DEVICE_CLOSE_V5:
+				pr_err
+				    ("%s: Basic callback received, wake up.\n",
+				     __func__);
+				copp = adm_find_copp(__adm, port_idx, copp_idx);
+				if (IS_ERR_OR_NULL(copp))
+					return 0;
+
+				copp->stat = payload[1];
+				wake_up(&copp->wait);
+				break;
+			case ADM_CMD_MATRIX_MAP_ROUTINGS_V5:
+				__adm->matrix_map_stat = payload[1];
+				wake_up(&__adm->matrix_map_wait);
+				break;
+
+			default:
+				pr_err("%s: Unknown Cmd: 0x%x\n", __func__,
+				       payload[0]);
+				break;
+			}
+			return 0;
+		}
+
+		switch (data->opcode) {
+		case ADM_CMDRSP_DEVICE_OPEN_V5:{
+				struct adm_cmd_rsp_device_open_v5 {
+					u32 status;
+					u16 copp_id;
+					u16 reserved;
+				} __packed *open = data->payload;
+				copp = adm_find_copp(__adm, port_idx, copp_idx);
+				if (IS_ERR_OR_NULL(copp))
+					return 0;
+
+				if (open->copp_id == INVALID_COPP_ID) {
+					pr_err("%s: invalid coppid rxed %d\n",
+					       __func__, open->copp_id);
+					copp->stat = ADSP_EBADPARAM;
+					wake_up(&copp->wait);
+					break;
+				}
+				copp->stat = payload[0];
+				copp->id = open->copp_id;
+				pr_debug("%s: coppid rxed=%d\n", __func__,
+					 open->copp_id);
+				wake_up(&copp->wait);
+
+			}
+			break;
+		default:
+			pr_err("%s: Unknown cmd:0x%x\n", __func__,
+			       data->opcode);
+			break;
+		}
+	}
+	return 0;
+}
+
+static struct copp *adm_alloc_copp(struct q6adm *adm, int port_idx)
+{
+	struct copp *c;
+	int idx;
+
+	idx = find_first_zero_bit(&adm->copp_bitmap[port_idx],
+				  MAX_COPPS_PER_PORT);
+
+	if (idx > MAX_COPPS_PER_PORT)
+		return ERR_PTR(-EBUSY);
+
+	set_bit(idx, &adm->copp_bitmap[port_idx]);
+
+	c = devm_kzalloc(adm->dev, sizeof(*c), GFP_KERNEL);
+	if (!c)
+		return ERR_PTR(-ENOMEM);
+	c->copp_idx = idx;
+	c->afe_port = port_idx;
+
+	init_waitqueue_head(&c->wait);
+
+	mutex_lock(&adm->copps_list_lock);
+	list_add_tail(&c->node, &adm->copps_list);
+	mutex_unlock(&adm->copps_list_lock);
+
+	return c;
+}
+
+static void adm_free_copp(struct q6adm *adm, struct copp *c, int port_idx)
+{
+	clear_bit(c->copp_idx, &adm->copp_bitmap[port_idx]);
+	mutex_lock(&adm->copps_list_lock);
+	list_del(&c->node);
+	mutex_unlock(&adm->copps_list_lock);
+}
+
+int q6adm_open(struct q6adm *_adm, int port_id, int path, int rate,
+	       int channel_mode, int topology, int perf_mode,
+	       uint16_t bit_width, int app_type, int acdb_id)
+{
+	struct adm_cmd_device_open_v5 {
+		struct apr_hdr hdr;
+		u16 flags;
+		u16 mode_of_operation;
+		u16 endpoint_id_1;
+		u16 endpoint_id_2;
+		u32 topology_id;
+		u16 dev_num_channel;
+		u16 bit_width;
+		u32 sample_rate;
+		u8 dev_channel_mapping[8];
+	} __packed open;
+	int ret = 0;
+	int port_idx, flags;
+	int tmp_port = q6afe_get_port_id(port_id);
+	struct copp *copp;
+
+	pr_info("%s:port %#x path:%d rate:%d mode:%d perf_mode:%d,topo_id %d\n",
+		__func__, port_id, path, rate, channel_mode, perf_mode,
+		topology);
+
+	port_idx = port_id;
+	if (port_idx < 0) {
+		pr_err("%s: Invalid port_id 0x%x\n", __func__, port_id);
+		return -EINVAL;
+	}
+
+	flags = ADM_LEGACY_DEVICE_SESSION;
+	copp = adm_find_matching_copp(__adm, port_idx, topology, perf_mode,
+				      rate, bit_width, app_type);
+
+	if (!copp) {
+		copp = adm_alloc_copp(__adm, port_idx);
+		if (IS_ERR_OR_NULL(copp))
+			return PTR_ERR(copp);
+
+		copp->cnt = 0;
+		copp->topology = topology;
+		copp->mode = perf_mode;
+		copp->rate = rate;
+		copp->channels = channel_mode;
+		copp->bit_width = bit_width;
+		copp->app_type = app_type;
+	}
+
+
+	/* Create a COPP if port id are not enabled */
+	if (copp->cnt == 0) {
+		pr_err("%s: open ADM: port_idx: %d, copp_idx: %d\n", __func__,
+		       port_idx, copp->copp_idx);
+
+		open.hdr.hdr_field = APR_HDR_FIELD(APR_MSG_TYPE_SEQ_CMD,
+						   APR_HDR_LEN(APR_HDR_SIZE),
+						   APR_PKT_VER);
+		open.hdr.pkt_size = sizeof(open);
+		open.hdr.src_svc = APR_SVC_ADM;
+		open.hdr.src_domain = APR_DOMAIN_APPS;
+		open.hdr.src_port = tmp_port;
+		open.hdr.dest_svc = APR_SVC_ADM;
+		open.hdr.dest_domain = APR_DOMAIN_ADSP;
+		open.hdr.dest_port = tmp_port;
+		open.hdr.token = port_idx << 16 | copp->copp_idx;
+		open.hdr.opcode = ADM_CMD_DEVICE_OPEN_V5;
+		open.flags = flags;
+		open.mode_of_operation = path;
+		open.endpoint_id_1 = tmp_port;
+		open.topology_id = topology;
+		open.dev_num_channel = channel_mode & 0x00FF;
+		open.bit_width = bit_width;
+		open.sample_rate = rate;
+
+		ret = q6dsp_map_channels(&open.dev_channel_mapping[0],
+					 channel_mode);
+
+		if (ret)
+			return ret;
+
+		pr_debug("%s: port_id=0x%x rate=%d topology_id=0x%X\n",
+			 __func__, open.endpoint_id_1, open.sample_rate,
+			 open.topology_id);
+
+		copp->stat = -1;
+		ret = apr_send_pkt(__adm->apr, (uint32_t *)&open);
+		if (ret < 0) {
+			pr_err("%s: port_id: 0x%x for[0x%x] failed %d\n",
+			       __func__, tmp_port, port_id, ret);
+			return -EINVAL;
+		}
+		/* Wait for the callback with copp id */
+		ret =
+		    wait_event_timeout(copp->wait, copp->stat >= 0,
+				       msecs_to_jiffies(TIMEOUT_MS));
+		if (!ret) {
+			pr_err("ADM timedout port_id: 0x%x for [0x%x]\n",
+			       tmp_port, port_id);
+			return -EINVAL;
+		} else if (copp->stat > 0) {
+			pr_err("%s: DSP returned error[%s]\n",
+			       __func__, adsp_err_get_err_str(copp->stat));
+			return adsp_err_get_lnx_err_code(copp->stat);
+		}
+	}
+	copp->cnt++;
+	return copp->copp_idx;
+}
+EXPORT_SYMBOL_GPL(q6adm_open);
+
+int q6adm_matrix_map(int path, struct route_payload payload_map, int perf_mode)
+{
+	struct adm_cmd_matrix_map_routings_v5 {
+		struct apr_hdr hdr;
+		u32 matrix_id;
+		u32 num_sessions;
+	} __packed *route;
+
+	struct adm_session_map_node_v5 {
+		u16 session_id;
+		u16 num_copps;
+	} __packed *node;
+
+	uint16_t *copps_list;
+	int cmd_size = 0;
+	int ret = 0, i = 0;
+	void *payload = NULL;
+	void *matrix_map = NULL;
+	int port_idx, copp_idx;
+	struct copp *copp;
+
+	/* Assumes port_ids have already been validated during adm_open */
+	cmd_size = (sizeof(*route) +
+		    sizeof(*node) + (sizeof(uint32_t) * payload_map.num_copps));
+	matrix_map = kzalloc(cmd_size, GFP_KERNEL);
+	if (!matrix_map)
+		return -ENOMEM;
+
+	route = (struct adm_cmd_matrix_map_routings_v5 *)matrix_map;
+	route->hdr.hdr_field = APR_HDR_FIELD(APR_MSG_TYPE_SEQ_CMD,
+					     APR_HDR_LEN(APR_HDR_SIZE),
+					     APR_PKT_VER);
+	route->hdr.pkt_size = cmd_size;
+	route->hdr.src_svc = 0;
+	route->hdr.src_domain = APR_DOMAIN_APPS;
+	route->hdr.src_port = 0; /* Ignored */
+	route->hdr.dest_svc = APR_SVC_ADM;
+	route->hdr.dest_domain = APR_DOMAIN_ADSP;
+	route->hdr.dest_port = 0; /* Ignored */
+	route->hdr.token = 0;
+	route->hdr.opcode = ADM_CMD_MATRIX_MAP_ROUTINGS_V5;
+	route->num_sessions = 1;
+
+	switch (path) {
+	case ADM_PATH_PLAYBACK:
+		route->matrix_id = ADM_MATRIX_ID_AUDIO_RX;
+		break;
+	default:
+		pr_err("%s: Wrong path set[%d]\n", __func__, path);
+		break;
+	}
+
+	payload = ((u8 *) matrix_map + sizeof(*route));
+	node = (struct adm_session_map_node_v5 *)payload;
+
+	node->session_id = payload_map.session_id;
+	node->num_copps = payload_map.num_copps;
+	payload = (u8 *) node + sizeof(*node);
+	copps_list = (uint16_t *) payload;
+
+	for (i = 0; i < payload_map.num_copps; i++) {
+		port_idx = payload_map.port_id[i];
+		if (port_idx < 0) {
+			pr_err("%s: Invalid port_id 0x%x\n", __func__,
+			       payload_map.port_id[i]);
+			return -EINVAL;
+		}
+		copp_idx = payload_map.copp_idx[i];
+
+		copp = adm_find_copp(__adm, port_idx, copp_idx);
+		if (IS_ERR_OR_NULL(copp))
+			return -EINVAL;
+
+		copps_list[i] = copp->id;
+	}
+
+	__adm->matrix_map_stat = -1;
+
+	ret = apr_send_pkt(__adm->apr, (uint32_t *) matrix_map);
+	if (ret < 0) {
+		pr_err("%s: routing for syream %d failed ret %d\n",
+		       __func__, payload_map.session_id, ret);
+		ret = -EINVAL;
+		goto fail_cmd;
+	}
+	ret = wait_event_timeout(__adm->matrix_map_wait,
+				 __adm->matrix_map_stat >= 0,
+				 msecs_to_jiffies(TIMEOUT_MS));
+	if (!ret) {
+		pr_err("%s: routing for syream %d failed\n", __func__,
+		       payload_map.session_id);
+		ret = -EINVAL;
+		goto fail_cmd;
+	} else if (__adm->matrix_map_stat > 0) {
+		pr_err("%s: DSP returned error[%s]\n", __func__,
+		       adsp_err_get_err_str(__adm->matrix_map_stat));
+		ret = adsp_err_get_lnx_err_code(__adm->matrix_map_stat);
+		goto fail_cmd;
+	}
+
+fail_cmd:
+	kfree(matrix_map);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(q6adm_matrix_map);
+
+static void adm_reset_copp(struct copp *c)
+{
+	c->id = RESET_COPP_ID;
+	c->cnt = 0;
+	c->topology = 0;
+	c->mode = 0;
+	c->stat = -1;
+	c->rate = 0;
+	c->channels = 0;
+	c->bit_width = 0;
+	c->app_type = 0;
+}
+
+int q6adm_close(int port_id, int perf_mode, int copp_idx)
+{
+	struct apr_hdr close;
+	struct copp *copp;
+
+	int ret = 0, port_idx;
+	int copp_id = RESET_COPP_ID;
+
+	pr_err("%s: port_id=0x%x perf_mode: %d copp_idx: %d\n", __func__,
+	       port_id, perf_mode, copp_idx);
+
+	port_idx = port_id;
+	if (port_idx < 0) {
+		pr_err("%s: Invalid port_id 0x%x\n", __func__, port_id);
+		return -EINVAL;
+	}
+
+	if ((copp_idx < 0) || (copp_idx >= MAX_COPPS_PER_PORT)) {
+		pr_err("%s: Invalid copp idx: %d\n", __func__, copp_idx);
+		return -EINVAL;
+	}
+
+	copp = adm_find_copp(__adm, port_id, copp_idx);
+	if (IS_ERR_OR_NULL(copp))
+		return -EINVAL;
+
+	copp->cnt--;
+	if (!copp->cnt) {
+		copp_id = copp->id;
+		pr_err("%s: Closing ADM port_idx:%d copp_idx:%d copp_id:0x%x\n",
+		       __func__, port_idx, copp_idx, copp_id);
+
+		close.hdr_field = APR_HDR_FIELD(APR_MSG_TYPE_SEQ_CMD,
+						APR_HDR_LEN(APR_HDR_SIZE),
+						APR_PKT_VER);
+		close.pkt_size = sizeof(close);
+		close.src_svc = APR_SVC_ADM;
+		close.src_domain = APR_DOMAIN_APPS;
+		close.src_port = port_id;
+		close.dest_svc = APR_SVC_ADM;
+		close.dest_domain = APR_DOMAIN_ADSP;
+		close.dest_port = copp_id;
+		close.token = port_idx << 16 | copp_idx;
+		close.opcode = ADM_CMD_DEVICE_CLOSE_V5;
+
+		ret = apr_send_pkt(__adm->apr, (uint32_t *) &close);
+		if (ret < 0) {
+			pr_err("%s: ADM close failed %d\n", __func__, ret);
+			return -EINVAL;
+		}
+
+		ret = wait_event_timeout(copp->wait, copp->stat >= 0,
+					 msecs_to_jiffies(TIMEOUT_MS));
+		if (!ret) {
+			pr_err("%s: ADM cmd Route timedout for port 0x%x\n",
+			       __func__, port_id);
+			return -EINVAL;
+		} else if (copp->stat > 0) {
+			pr_err("%s: DSP returned error[%s]\n",
+			       __func__, adsp_err_get_err_str(copp->stat));
+			return adsp_err_get_lnx_err_code(copp->stat);
+		}
+
+		adm_reset_copp(copp);
+		adm_free_copp(__adm, copp, port_id);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(q6adm_close);
+
+void q6adm_put(struct q6adm *adm)
+{
+
+}
+EXPORT_SYMBOL_GPL(q6adm_put);
+
+struct q6adm *q6adm_get(struct device *dev)
+{
+	if (!__adm)
+		return ERR_PTR(-EPROBE_DEFER);
+
+	return __adm;
+}
+EXPORT_SYMBOL_GPL(q6adm_get);
+
+static int q6adm_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	__adm = kzalloc(sizeof(*__adm), GFP_KERNEL);
+	if (!__adm)
+		return -ENOMEM;
+
+	__adm->apr = NULL;
+	__adm->dev = &pdev->dev;
+	__adm->matrix_map_stat = 0;
+	init_waitqueue_head(&__adm->matrix_map_wait);
+
+	INIT_LIST_HEAD(&__adm->copps_list);
+	mutex_init(&__adm->copps_list_lock);
+
+	__adm->apr = apr_register(&pdev->dev, "ADSP", "ADM", adm_callback,
+				0xFFFFFFFF, &__adm);
+	if (__adm->apr == NULL) {
+		pr_err("%s: Unable to register ADM\n", __func__);
+		ret = -ENODEV;
+		return ret;
+	}
+
+	return 0;
+}
+
+static int q6adm_exit(struct platform_device *pdev)
+{
+	int rval;
+
+	rval = apr_deregister(__adm->apr);
+	if (rval < 0)
+		return rval;
+
+	kfree(__adm);
+	__adm = NULL;
+
+	return 0;
+}
+
+static const struct of_device_id qcom_q6adm_match[] = {
+	{.compatible = "qcom,q6adm-v2",},
+	{}
+};
+
+static struct platform_driver qcom_q6adm_driver = {
+	.probe = q6adm_probe,
+	.remove = q6adm_exit,
+	.driver = {
+		   .name = "qcom-q6adm",
+		   .of_match_table = qcom_q6adm_match,
+		   },
+};
+
+module_platform_driver(qcom_q6adm_driver);
+MODULE_AUTHOR("Srinivas Kandagatla <srinivas.kandagatla@linaro.org");
+MODULE_DESCRIPTION("q6 Audio Device Manager driver");
+MODULE_LICENSE("GPL v2");
-- 
2.9.3
