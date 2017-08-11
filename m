From: srinivas.kandagatla@linaro.org
Subject: [RFC PATCH 4/9] ASoC: qcom: qdsp6v2: Add support to
	Q6ASM
Date: Fri, 11 Aug 2017 15:29:47 +0200
Message-ID: <20170811132952.32572-5-srinivas.kandagatla@linaro.org>
References: <20170811132952.32572-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f50.google.com (mail-it0-f50.google.com
 [209.85.214.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 01C7E267660
 for <alsa-devel@alsa-project.org>; Fri, 11 Aug 2017 15:30:12 +0200 (CEST)
Received: by mail-it0-f50.google.com with SMTP id 77so27766842itj.1
 for <alsa-devel@alsa-project.org>; Fri, 11 Aug 2017 06:30:12 -0700 (PDT)
In-Reply-To: <20170811132952.32572-1-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Banajit Goswami <bgoswami@codeaurora.org>, alsa-devel@alsa-project.org
Cc: kwestfie@codeaurora.org, linux-arm-msm@vger.kernel.org, Patrick Lai <plai@codeaurora.org>, sboyd@codeaurora.org, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, lkasam@qti.qualcomm.com
List-Id: alsa-devel@alsa-project.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds basic support to Q6 ASM (Audio Strem Manager) module on
Q6DSP. ASM supports up to 8 concurrent streams. each stream can be setup
as playback/capture. ASM provides top control functions like
Pause/flush/resume for playback and record. ASM can Create/destroy encoder,
decoder and also provides POPP dynamic services.

This patch adds support to basic features to allow hdmi playback.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/sound/qcom,q6asm.txt       |   15 +
 include/dt-bindings/sound/qcom,asm.h               |   13 +
 sound/soc/qcom/Kconfig                             |    6 +
 sound/soc/qcom/qdsp6v2/Makefile                    |    1 +
 sound/soc/qcom/qdsp6v2/q6asm-v2.h                  |  176 ++++
 sound/soc/qcom/qdsp6v2/q6asm.c                     | 1008 ++++++++++++++++++++
 6 files changed, 1219 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6asm.txt
 create mode 100644 include/dt-bindings/sound/qcom,asm.h
 create mode 100644 sound/soc/qcom/qdsp6v2/q6asm-v2.h
 create mode 100644 sound/soc/qcom/qdsp6v2/q6asm.c

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6asm.txt b/Documentation/devicetree/bindings/sound/qcom,q6asm.txt
new file mode 100644
index 0000000..a658ba6
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,q6asm.txt
@@ -0,0 +1,15 @@
+Qualcomm Q6ASM (Q6 Audio Stream Manager) binding
+
+This bindings describe the Qualcomm Q6 ASM module on QDSP,
+which is used by audio drivers.
+
+- compatible:
+
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "qcom,q6asm-v<VERSION-NUMBER>" example: "qcom,q6asm-v2"
+
+= EXAMPLE
+	q6asm {
+		compatible = "qcom,q6asm-v2";
+	};
diff --git a/include/dt-bindings/sound/qcom,asm.h b/include/dt-bindings/sound/qcom,asm.h
new file mode 100644
index 0000000..0f93349
--- /dev/null
+++ b/include/dt-bindings/sound/qcom,asm.h
@@ -0,0 +1,13 @@
+#ifndef __DT_ASM_H__
+#define __DT_ASM_H__
+
+#define MSM_FRONTEND_DAI_MULTIMEDIA1	0
+#define MSM_FRONTEND_DAI_MULTIMEDIA2	1
+#define	MSM_FRONTEND_DAI_MULTIMEDIA3	2
+#define MSM_FRONTEND_DAI_MULTIMEDIA4	3
+#define MSM_FRONTEND_DAI_MULTIMEDIA5	4
+#define MSM_FRONTEND_DAI_MULTIMEDIA6	5
+#define	MSM_FRONTEND_DAI_MULTIMEDIA7	6
+#define	MSM_FRONTEND_DAI_MULTIMEDIA8	7
+
+#endif
diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 72f6fa4..bd49813 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -52,10 +52,16 @@ config SND_SOC_QDSP6V2_ADM
 	tristate
 	default n
 
+config SND_SOC_QDSP6V2_ASM
+	tristate
+	default n
+
+
 config SND_SOC_QDSP6V2
 	tristate "SoC ALSA audio driver for QDSP6V2"
 	select SND_SOC_QDSP6V2_AFE
 	select SND_SOC_QDSP6V2_ADM
+	select SND_SOC_QDSP6V2_ASM
 	help
 	 To add support for MSM QDSP6V2 Soc Audio.
 	 This will enable sound soc platform specific
diff --git a/sound/soc/qcom/qdsp6v2/Makefile b/sound/soc/qcom/qdsp6v2/Makefile
index a2b8b0b..00b0549 100644
--- a/sound/soc/qcom/qdsp6v2/Makefile
+++ b/sound/soc/qcom/qdsp6v2/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_SND_SOC_QDSP6V2_AFE) += q6afe.o
 obj-$(CONFIG_SND_SOC_QDSP6V2_ADM) += q6adm.o
+obj-$(CONFIG_SND_SOC_QDSP6V2_ASM) += q6asm.o
diff --git a/sound/soc/qcom/qdsp6v2/q6asm-v2.h b/sound/soc/qcom/qdsp6v2/q6asm-v2.h
new file mode 100644
index 0000000..6a6afcd
--- /dev/null
+++ b/sound/soc/qcom/qdsp6v2/q6asm-v2.h
@@ -0,0 +1,176 @@
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
+#ifndef __Q6_ASM_V2_H__
+#define __Q6_ASM_V2_H__
+
+#include <linux/soc/qcom/apr.h>
+#include <linux/list.h>
+
+/* ASM client callback events */
+#define CMD_PAUSE			0x0001
+#define ASM_CLIENT_EVENT_CMD_PAUSE_DONE		0x1001
+#define CMD_FLUSH				0x0002
+#define ASM_CLIENT_EVENT_CMD_FLUSH_DONE		0x1002
+#define CMD_EOS				0x0003
+#define ASM_CLIENT_EVENT_CMD_EOS_DONE		0x1003
+#define CMD_CLOSE				0x0004
+#define ASM_CLIENT_EVENT_CMD_CLOSE_DONE		0x1004
+#define CMD_OUT_FLUSH				0x0005
+#define ASM_CLIENT_EVENT_CMD_OUT_FLUSH_DONE	0x1005
+#define CMD_SUSPEND				0x0006
+#define ASM_CLIENT_EVENT_CMD_SUSPEND_DONE	0x1006
+#define ASM_CLIENT_EVENT_CMD_RUN_DONE		0x1008
+#define ASM_CLIENT_EVENT_DATA_WRITE_DONE	0x1009
+
+#define MAX_SESSIONS	16
+#define NO_TIMESTAMP    0xFF00
+#define FORMAT_LINEAR_PCM   0x0000
+
+struct audio_client;
+struct audio_buffer;
+struct audio_port_data {
+	struct audio_buffer *buf;
+	uint32_t max_buf_cnt;
+	uint32_t dsp_buf;
+	uint32_t cpu_buf;
+	uint32_t mem_map_handle;
+};
+
+typedef void (*app_cb) (uint32_t opcode, uint32_t token,
+			uint32_t *payload, void *priv);
+struct audio_client {
+	int session;
+	app_cb cb;
+	int cmd_state;
+	void *priv;
+	uint32_t io_mode;
+	uint64_t time_stamp;
+	struct apr_svc *apr;
+	struct mutex cmd_lock;
+	/* idx:1 out port, 0: in port */
+	struct audio_port_data port[2];
+	wait_queue_head_t cmd_wait;
+	int perf_mode;
+	int stream_id;
+	struct device *dev;
+};
+#if IS_ENABLED(CONFIG_SND_SOC_QDSP6V2_ASM)
+struct q6asm *q6asm_get(struct device *dev);
+void q6asm_put(struct q6asm *a);
+struct audio_client *q6asm_audio_client_alloc(struct q6asm *a,
+					      struct device *dev,
+					      app_cb cb, void *priv);
+void q6asm_audio_client_free(struct audio_client *ac);
+int q6asm_write_nolock(struct audio_client *ac, uint32_t len, uint32_t msw_ts,
+		       uint32_t lsw_ts, uint32_t flags);
+int q6asm_open_write(struct audio_client *ac, uint32_t format,
+		     uint16_t bits_per_sample);
+int q6asm_media_format_block_multi_ch_pcm(struct audio_client *ac,
+					  uint32_t rate, uint32_t channels,
+					  bool use_default_chmap,
+					  char *channel_map,
+					  uint16_t bits_per_sample);
+int q6asm_run(struct audio_client *ac, uint32_t flags, uint32_t msw_ts,
+	      uint32_t lsw_ts);
+int q6asm_run_nowait(struct audio_client *ac, uint32_t flags, uint32_t msw_ts,
+		     uint32_t lsw_ts);
+int q6asm_cmd(struct audio_client *ac, int cmd);
+int q6asm_cmd_nowait(struct audio_client *ac, int cmd);
+int q6asm_map_memory_regions(unsigned int dir,
+			     struct audio_client *ac,
+			     void *data,
+			     dma_addr_t phys,
+			     unsigned int bufsz, unsigned int bufcnt);
+int q6asm_unmap_memory_regions(unsigned int dir, struct audio_client *ac);
+#else
+
+static inline struct q6asm *q6asm_get(struct device *dev)
+{
+	return PTR_ERR(-ENOSYS);
+}
+
+static inline void q6asm_put(struct q6asm *a)
+{
+}
+
+static inline struct audio_client *q6asm_audio_client_alloc(struct q6asm *a,
+							    struct device *dev,
+							    app_cb cb,
+							    void *priv)
+{
+	return PTR_ERR(-ENOSYS);
+}
+
+static inline void q6asm_audio_client_free(struct audio_client *ac)
+{
+}
+
+static inline int q6asm_write_nolock(struct audio_client *ac, uint32_t len,
+				     uint32_t msw_ts, uint32_t lsw_ts,
+				     uint32_t flags)
+{
+	return -ENOSYS;
+}
+static inline int q6asm_open_write(struct audio_client *ac, uint32_t format,
+				   uint16_t bits_per_sample)
+{
+	return -ENOSYS;
+}
+static inline int q6asm_media_format_block_multi_ch_pcm(struct audio_client *a,
+							uint32_t r, uint32_t c,
+							bool use_default_chmap,
+							char *channel_map,
+							uint16_t bps)
+{
+	return -ENOSYS;
+}
+
+static inline int q6asm_run(struct audio_client *ac, uint32_t flags,
+			    uint32_t msw_ts, uint32_t lsw_ts)
+{
+	return -ENOSYS;
+}
+
+static inline int q6asm_run_nowait(struct audio_client *ac,
+				   uint32_t flags, uint32_t msw_ts,
+				   uint32_t lsw_ts);
+{
+	return -ENOSYS;
+}
+
+static inline int q6asm_cmd(struct audio_client *ac, int cmd)
+{
+	return -ENOSYS;
+}
+
+static inline int q6asm_cmd_nowait(struct audio_client *ac, int cmd)
+{
+	return -ENOSYS;
+}
+
+static inline int q6asm_map_memory_regions(unsigned int dir
+					   struct audio_client *ac,
+					   void *data,
+					   dma_addr_t phys,
+					   unsigned int bufsz,
+					   unsigned int bufcnt)
+{
+	return -ENOSYS;
+}
+
+static inline int q6asm_unmap_memory_regions(unsigned int dir,
+					     struct audio_client *ac)
+{
+	return -ENOSYS;
+}
+#endif
+#endif /* __Q6_ASM_H__ */
diff --git a/sound/soc/qcom/qdsp6v2/q6asm.c b/sound/soc/qcom/qdsp6v2/q6asm.c
new file mode 100644
index 0000000..330f3b3
--- /dev/null
+++ b/sound/soc/qcom/qdsp6v2/q6asm.c
@@ -0,0 +1,1008 @@
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
+#include <linux/mutex.h>
+#include <linux/wait.h>
+#include <linux/sched.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <uapi/sound/asound.h>
+#include <linux/slab.h>
+#include <linux/mm.h>
+#include "q6asm-v2.h"
+#include "common.h"
+
+#define ASM_STREAM_CMD_CLOSE			0x00010BCD
+#define ASM_STREAM_CMD_FLUSH			0x00010BCE
+#define ASM_SESSION_CMD_PAUSE			0x00010BD3
+#define ASM_DATA_CMD_EOS			0x00010BDB
+#define DEFAULT_POPP_TOPOLOGY			0x00010BE4
+#define ASM_STREAM_CMD_FLUSH_READBUFS		0x00010C09
+#define ASM_CMD_SHARED_MEM_MAP_REGIONS		0x00010D92
+#define ASM_CMDRSP_SHARED_MEM_MAP_REGIONS	0x00010D93
+#define ASM_CMD_SHARED_MEM_UNMAP_REGIONS	0x00010D94
+#define ASM_DATA_CMD_MEDIA_FMT_UPDATE_V2	0x00010D98
+#define ASM_DATA_EVENT_WRITE_DONE_V2		0x00010D99
+#define ASM_SESSION_CMD_RUN_V2			0x00010DAA
+#define ASM_MEDIA_FMT_MULTI_CHANNEL_PCM_V2	0x00010DA5
+#define ASM_DATA_CMD_WRITE_V2			0x00010DAB
+#define ASM_SESSION_CMD_SUSPEND			0x00010DEC
+#define ASM_STREAM_CMD_OPEN_WRITE_V3		0x00010DB3
+
+#define ASM_LEGACY_STREAM_SESSION	0
+#define ASM_END_POINT_DEVICE_MATRIX	0
+#define DEFAULT_APP_TYPE		0
+#define TUN_WRITE_IO_MODE		0x0008	/* tunnel read write mode */
+#define TUN_READ_IO_MODE		0x0004	/* tunnel read write mode */
+#define SYNC_IO_MODE			0x0001
+#define ASYNC_IO_MODE			0x0002
+#define SESSION_MAX			MAX_SESSIONS
+#define ASM_SHIFT_GAPLESS_MODE_FLAG	31
+#define ADSP_MEMORY_MAP_SHMEM8_4K_POOL	3
+
+struct avs_cmd_shared_mem_map_regions {
+	struct apr_hdr hdr;
+	u16 mem_pool_id;
+	u16 num_regions;
+	u32 property_flag;
+} __packed;
+
+struct avs_shared_map_region_payload {
+	u32 shm_addr_lsw;
+	u32 shm_addr_msw;
+	u32 mem_size_bytes;
+} __packed;
+
+struct avs_cmd_shared_mem_unmap_regions {
+	struct apr_hdr hdr;
+	u32 mem_map_handle;
+} __packed;
+
+struct asm_data_cmd_media_fmt_update_v2 {
+	u32 fmt_blk_size;
+} __packed;
+
+struct asm_multi_channel_pcm_fmt_blk_v2 {
+	struct apr_hdr hdr;
+	struct asm_data_cmd_media_fmt_update_v2 fmt_blk;
+	u16 num_channels;
+	u16 bits_per_sample;
+	u32 sample_rate;
+	u16 is_signed;
+	u16 reserved;
+	u8 channel_mapping[8];
+} __packed;
+
+struct asm_data_cmd_write_v2 {
+	struct apr_hdr hdr;
+	u32 buf_addr_lsw;
+	u32 buf_addr_msw;
+	u32 mem_map_handle;
+	u32 buf_size;
+	u32 seq_id;
+	u32 timestamp_lsw;
+	u32 timestamp_msw;
+	u32 flags;
+} __packed;
+
+struct asm_stream_cmd_open_write_v3 {
+	struct apr_hdr hdr;
+	uint32_t mode_flags;
+	uint16_t sink_endpointype;
+	uint16_t bits_per_sample;
+	uint32_t postprocopo_id;
+	uint32_t dec_fmt_id;
+} __packed;
+
+struct asm_session_cmd_run_v2 {
+	struct apr_hdr hdr;
+	u32 flags;
+	u32 time_lsw;
+	u32 time_msw;
+} __packed;
+
+struct audio_buffer {
+	dma_addr_t phys;
+	void *data;
+	uint32_t used;
+	uint32_t size;		/* size of buffer */
+};
+
+struct q6asm {
+	struct apr_svc *mmap_apr;
+	int mem_state;
+	struct device *dev;
+	wait_queue_head_t mem_wait;
+	struct mutex	session_lock;
+	struct audio_client *session[SESSION_MAX + 1];
+};
+
+struct q6asm *__q6asm;
+
+static int q6asm_session_alloc(struct audio_client *ac)
+{
+	int n = -EINVAL;
+
+	mutex_lock(&__q6asm->session_lock);
+	for (n = 1; n <= SESSION_MAX; n++) {
+		if (!__q6asm->session[n]) {
+			__q6asm->session[n] = ac;
+			break;
+		}
+	}
+	mutex_unlock(&__q6asm->session_lock);
+
+	return n;
+}
+
+static bool q6asm_is_valid_audio_client(struct audio_client *ac)
+{
+	int n;
+
+	for (n = 1; n <= SESSION_MAX; n++) {
+		if (__q6asm->session[n] == ac)
+			return 1;
+	}
+
+	return 0;
+}
+
+static void q6asm_session_free(struct audio_client *ac)
+{
+	mutex_lock(&__q6asm->session_lock);
+	__q6asm->session[ac->session] = 0;
+	ac->session = 0;
+	ac->perf_mode = LEGACY_PCM_MODE;
+	mutex_unlock(&__q6asm->session_lock);
+}
+
+static inline void q6asm_add_mmaphdr(struct audio_client *ac,
+				     struct apr_hdr *hdr, u32 pkt_size,
+				     bool cmd_flg, u32 token)
+{
+	hdr->hdr_field = APR_SEQ_CMD_HDR_FIELD;
+	hdr->src_port = 0;
+	hdr->dest_port = 0;
+	hdr->pkt_size = pkt_size;
+	if (cmd_flg)
+		hdr->token = token;
+}
+
+static inline void q6asm_add_hdr(struct audio_client *ac, struct apr_hdr *hdr,
+				 uint32_t pkt_size, bool cmd_flg,
+				 uint32_t stream_id)
+{
+	hdr->hdr_field = APR_SEQ_CMD_HDR_FIELD;
+	hdr->src_svc = ((struct apr_svc *)ac->apr)->id;
+	hdr->src_domain = APR_DOMAIN_APPS;
+	hdr->dest_svc = APR_SVC_ASM;
+	hdr->dest_domain = APR_DOMAIN_ADSP;
+	hdr->src_port = ((ac->session << 8) & 0xFF00) | (stream_id);
+	hdr->dest_port = ((ac->session << 8) & 0xFF00) | (stream_id);
+	hdr->pkt_size = pkt_size;
+	if (cmd_flg)
+		hdr->token = ac->session;
+}
+
+static int __q6asm_memory_unmap(struct audio_client *ac,
+				phys_addr_t buf_add, int dir)
+{
+	struct avs_cmd_shared_mem_unmap_regions mem_unmap;
+	int rc;
+
+	q6asm_add_mmaphdr(ac, &mem_unmap.hdr, sizeof(mem_unmap), true,
+			  ((ac->session << 8) | dir));
+	__q6asm->mem_state = -1;
+
+	mem_unmap.hdr.opcode = ASM_CMD_SHARED_MEM_UNMAP_REGIONS;
+	mem_unmap.mem_map_handle = ac->port[dir].mem_map_handle;
+
+	if (mem_unmap.mem_map_handle == 0) {
+		dev_err(ac->dev, "invalid mem handle\n");
+		return -EINVAL;
+	}
+
+	rc = apr_send_pkt(__q6asm->mmap_apr, (uint32_t *) &mem_unmap);
+	if (rc < 0)
+		return rc;
+
+	rc = wait_event_timeout(__q6asm->mem_wait, (__q6asm->mem_state >= 0),
+				5 * HZ);
+	if (!rc) {
+		dev_err(ac->dev, "CMD timeout for memory_unmap 0x%x\n",
+			mem_unmap.mem_map_handle);
+		return -ETIMEDOUT;
+	} else if (__q6asm->mem_state > 0) {
+		return adsp_err_get_lnx_err_code(__q6asm->mem_state);
+	}
+	ac->port[dir].mem_map_handle = 0;
+
+	return 0;
+}
+
+int q6asm_unmap_memory_regions(unsigned int dir, struct audio_client *ac)
+{
+	struct audio_port_data *port;
+	int cnt = 0;
+	int rc = 0;
+
+	mutex_lock(&ac->cmd_lock);
+	port = &ac->port[dir];
+	if (!port->buf) {
+		mutex_unlock(&ac->cmd_lock);
+		return 0;
+	}
+
+	cnt = port->max_buf_cnt - 1;
+	if (cnt >= 0) {
+		rc = __q6asm_memory_unmap(ac, port->buf[dir].phys, dir);
+		if (rc < 0) {
+			dev_err(ac->dev, "%s: Memory_unmap_regions failed %d\n",
+				__func__, rc);
+			mutex_unlock(&ac->cmd_lock);
+			return rc;
+		}
+	}
+
+	port->max_buf_cnt = 0;
+	kfree(port->buf);
+	port->buf = NULL;
+	mutex_unlock(&ac->cmd_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(q6asm_unmap_memory_regions);
+
+static int __q6asm_memory_map_regions(struct audio_client *ac, int dir,
+				      uint32_t period_sz, uint32_t periods,
+				      bool is_contiguous)
+{
+	struct avs_cmd_shared_mem_map_regions *mmap_regions = NULL;
+	struct avs_shared_map_region_payload *mregions = NULL;
+	struct audio_port_data *port = NULL;
+	struct audio_buffer *ab = NULL;
+	void *mmap_region_cmd = NULL;
+	void *payload = NULL;
+	int rc = 0;
+	int i = 0;
+	int cmd_size = 0;
+	uint32_t num_regions;
+	uint32_t buf_sz;
+
+	num_regions = is_contiguous ? 1 : periods;
+	buf_sz = is_contiguous ? (period_sz * periods) : period_sz;
+	buf_sz = PAGE_ALIGN(buf_sz);
+
+	cmd_size = sizeof(*mmap_regions) + (sizeof(*mregions) * num_regions);
+
+	mmap_region_cmd = kzalloc(cmd_size, GFP_KERNEL);
+	if (!mmap_region_cmd)
+		return -ENOMEM;
+
+	mmap_regions = (struct avs_cmd_shared_mem_map_regions *)mmap_region_cmd;
+	q6asm_add_mmaphdr(ac, &mmap_regions->hdr, cmd_size, true,
+			  ((ac->session << 8) | dir));
+	__q6asm->mem_state = -1;
+
+	mmap_regions->hdr.opcode = ASM_CMD_SHARED_MEM_MAP_REGIONS;
+	mmap_regions->mem_pool_id = ADSP_MEMORY_MAP_SHMEM8_4K_POOL;
+	mmap_regions->num_regions = num_regions;
+	mmap_regions->property_flag = 0x00;
+
+	payload = ((u8 *) mmap_region_cmd +
+		   sizeof(struct avs_cmd_shared_mem_map_regions));
+
+	mregions = (struct avs_shared_map_region_payload *)payload;
+
+	ac->port[dir].mem_map_handle = 0;
+	port = &ac->port[dir];
+
+	for (i = 0; i < num_regions; i++) {
+		ab = &port->buf[i];
+		mregions->shm_addr_lsw = lower_32_bits(ab->phys);
+		mregions->shm_addr_msw = upper_32_bits(ab->phys);
+		mregions->mem_size_bytes = buf_sz;
+		++mregions;
+	}
+
+	rc = apr_send_pkt(__q6asm->mmap_apr, (uint32_t *) mmap_region_cmd);
+	if (rc < 0)
+		goto fail_cmd;
+
+	rc = wait_event_timeout(__q6asm->mem_wait, (__q6asm->mem_state >= 0),
+				5 * HZ);
+	if (!rc) {
+		dev_err(ac->dev, "timeout. waited for memory_map\n");
+		rc = -ETIMEDOUT;
+		goto fail_cmd;
+	}
+
+	if (__q6asm->mem_state > 0) {
+		rc = adsp_err_get_lnx_err_code(__q6asm->mem_state);
+		goto fail_cmd;
+	}
+	rc = 0;
+fail_cmd:
+	kfree(mmap_region_cmd);
+	return rc;
+}
+
+int q6asm_map_memory_regions(unsigned int dir, struct audio_client *ac,
+			     void *data, dma_addr_t phys,
+			     unsigned int period_sz, unsigned int periods)
+{
+	struct audio_buffer *buf;
+	int cnt;
+	int rc;
+
+	if (ac->port[dir].buf) {
+		dev_err(ac->dev, "Buffer already allocated\n");
+		return 0;
+	}
+
+	mutex_lock(&ac->cmd_lock);
+
+	buf = kzalloc(((sizeof(struct audio_buffer)) * periods), GFP_KERNEL);
+	if (!buf) {
+		mutex_unlock(&ac->cmd_lock);
+		return -ENOMEM;
+	}
+
+
+	ac->port[dir].buf = buf;
+
+	buf[0].data = data;
+	buf[0].phys = phys;
+	buf[0].used = dir ^ 1;
+	buf[0].size = period_sz;
+	cnt = 1;
+	while (cnt < periods) {
+		if (period_sz > 0) {
+			buf[cnt].data = buf[0].data + (cnt * period_sz);
+			buf[cnt].phys = buf[0].phys + (cnt * period_sz);
+			buf[cnt].used = dir ^ 1;
+			buf[cnt].size = period_sz;
+		}
+		cnt++;
+	}
+
+	ac->port[dir].max_buf_cnt = periods;
+	mutex_unlock(&ac->cmd_lock);
+
+	rc = __q6asm_memory_map_regions(ac, dir, period_sz, periods, 1);
+	if (rc < 0) {
+		dev_err(ac->dev,
+			"CMD Memory_map_regions failed %d for size %d\n", rc,
+			period_sz);
+
+
+		ac->port[dir].max_buf_cnt = 0;
+		kfree(buf);
+		ac->port[dir].buf = NULL;
+
+		return rc;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(q6asm_map_memory_regions);
+
+void q6asm_audio_client_free(struct audio_client *ac)
+{
+	apr_deregister(ac->apr);
+	q6asm_session_free(ac);
+	kfree(ac);
+}
+EXPORT_SYMBOL_GPL(q6asm_audio_client_free);
+
+static struct audio_client *q6asm_get_audio_client(int session_id)
+{
+	if ((session_id <= 0) || (session_id > SESSION_MAX)) {
+		pr_err("%s: invalid session: %d\n", __func__, session_id);
+		goto err;
+	}
+
+	if (!__q6asm->session[session_id]) {
+		pr_err("%s: session not active: %d\n", __func__, session_id);
+		goto err;
+	}
+	return __q6asm->session[session_id];
+err:
+	return NULL;
+}
+
+static int32_t q6asm_srvc_callback(struct apr_client_data *data, void *priv)
+{
+	struct audio_client *ac = NULL;
+	struct audio_port_data *port;
+	uint32_t sid = 0;
+	uint32_t dir = 0;
+	uint32_t *payload;
+
+	if (!data) {
+		pr_err("%s: Invalid CB\n", __func__);
+		return 0;
+	}
+
+	payload = data->payload;
+	sid = (data->token >> 8) & 0x0F;
+	ac = q6asm_get_audio_client(sid);
+	if (!ac) {
+		pr_debug("%s: session[%d] already freed\n", __func__, sid);
+		return 0;
+	}
+
+	if (data->opcode == APR_BASIC_RSP_RESULT) {
+		switch (payload[0]) {
+		case ASM_CMD_SHARED_MEM_MAP_REGIONS:
+		case ASM_CMD_SHARED_MEM_UNMAP_REGIONS:
+			if (payload[1] != 0) {
+				dev_err(ac->dev,
+					"cmd = 0x%x returned error = 0x%x sid:%d\n",
+					payload[0], payload[1], sid);
+				__q6asm->mem_state = payload[1];
+			} else {
+				__q6asm->mem_state = 0;
+			}
+
+			wake_up(&__q6asm->mem_wait);
+			dev_vdbg(ac->dev, "%s: Payload = [0x%x] status[0x%x]\n",
+				 __func__, payload[0], payload[1]);
+			break;
+		default:
+			pr_debug("%s: command[0x%x] not expecting rsp\n",
+				 __func__, payload[0]);
+			break;
+		}
+		return 0;
+	}
+
+	dir = (data->token & 0x0F);
+	port = &ac->port[dir];
+
+	switch (data->opcode) {
+	case ASM_CMDRSP_SHARED_MEM_MAP_REGIONS:{
+			__q6asm->mem_state = 0;
+			ac->port[dir].mem_map_handle = payload[0];
+			wake_up(&__q6asm->mem_wait);
+			break;
+		}
+	case ASM_CMD_SHARED_MEM_UNMAP_REGIONS:{
+			__q6asm->mem_state = 0;
+			ac->port[dir].mem_map_handle = 0;
+			wake_up(&__q6asm->mem_wait);
+
+			break;
+		}
+	default:
+		pr_debug("%s: command[0x%x]success [0x%x]\n",
+			 __func__, payload[0], payload[1]);
+	}
+	if (ac->cb)
+		ac->cb(data->opcode, data->token, data->payload, ac->priv);
+	return 0;
+}
+
+static int32_t q6asm_callback(struct apr_client_data *data, void *priv)
+{
+	struct audio_client *ac = (struct audio_client *)priv;
+	uint32_t token;
+	uint32_t *payload;
+	uint32_t wakeup_flag = 1;
+	uint32_t client_event = 0;
+
+	if (data == NULL)
+		return -EINVAL;
+
+	if (!q6asm_is_valid_audio_client(ac))
+		return -EINVAL;
+
+	payload = data->payload;
+	if (data->opcode == APR_BASIC_RSP_RESULT) {
+		token = data->token;
+		switch (payload[0]) {
+		case ASM_SESSION_CMD_PAUSE:
+			client_event = ASM_CLIENT_EVENT_CMD_PAUSE_DONE;
+			break;
+		case ASM_SESSION_CMD_SUSPEND:
+			client_event = ASM_CLIENT_EVENT_CMD_SUSPEND_DONE;
+			break;
+		case ASM_DATA_CMD_EOS:
+			client_event = ASM_CLIENT_EVENT_CMD_EOS_DONE;
+			break;
+		case ASM_STREAM_CMD_CLOSE:
+			client_event = ASM_CLIENT_EVENT_CMD_CLOSE_DONE;
+			break;
+		case ASM_STREAM_CMD_FLUSH:
+			client_event = ASM_CLIENT_EVENT_CMD_FLUSH_DONE;
+			break;
+		case ASM_SESSION_CMD_RUN_V2:
+			client_event = ASM_CLIENT_EVENT_CMD_RUN_DONE;
+			break;
+
+		case ASM_STREAM_CMD_FLUSH_READBUFS:
+			if (token != ac->session) {
+				dev_err(ac->dev, "session invalid\n");
+				return -EINVAL;
+			}
+		case ASM_STREAM_CMD_OPEN_WRITE_V3:
+		case ASM_DATA_CMD_MEDIA_FMT_UPDATE_V2:
+			if (payload[1] != 0) {
+				dev_err(ac->dev,
+					"cmd = 0x%x returned error = 0x%x\n",
+					payload[0], payload[1]);
+				if (wakeup_flag) {
+					ac->cmd_state = payload[1];
+					wake_up(&ac->cmd_wait);
+				}
+				return 0;
+			}
+			if (ac->cmd_state && wakeup_flag) {
+				ac->cmd_state = 0;
+				wake_up(&ac->cmd_wait);
+			}
+			if (ac->cb)
+				ac->cb(data->opcode, data->token,
+				       (uint32_t *) data->payload, ac->priv);
+			break;
+		default:
+			dev_err(ac->dev, "command[0x%x] not expecting rsp\n",
+				payload[0]);
+			break;
+		}
+
+		if (ac->cb)
+			ac->cb(client_event, data->token,
+			       data->payload, ac->priv);
+
+		return 0;
+	}
+
+	switch (data->opcode) {
+	case ASM_DATA_EVENT_WRITE_DONE_V2:{
+			struct audio_port_data *port =
+			    &ac->port[SNDRV_PCM_STREAM_PLAYBACK];
+
+			client_event = ASM_CLIENT_EVENT_DATA_WRITE_DONE;
+
+			if (ac->io_mode & SYNC_IO_MODE) {
+				dma_addr_t phys = port->buf[data->token].phys;
+
+				if (lower_32_bits(phys) != payload[0] ||
+				    upper_32_bits(phys) != payload[1]) {
+					dev_err(ac->dev, "Expected addr %pa\n",
+						&port->buf[data->token].phys);
+					return -EINVAL;
+				}
+				token = data->token;
+				port->buf[token].used = 1;
+			}
+			break;
+		}
+	}
+	if (ac->cb)
+		ac->cb(client_event, data->token, data->payload, ac->priv);
+
+	return 0;
+}
+
+struct audio_client *q6asm_audio_client_alloc(struct q6asm *a,
+					      struct device *dev,
+					      app_cb cb, void *priv)
+{
+	struct audio_client *ac;
+	int n;
+
+	ac = kzalloc(sizeof(struct audio_client), GFP_KERNEL);
+	if (!ac)
+		return NULL;
+
+	n = q6asm_session_alloc(ac);
+	if (n <= 0) {
+		dev_err(dev, "ASM Session alloc fail n=%d\n", n);
+		goto fail_session;
+	}
+
+	ac->session = n;
+	ac->cb = cb;
+	ac->dev = dev;
+	ac->priv = priv;
+	ac->io_mode = SYNC_IO_MODE;
+	ac->perf_mode = LEGACY_PCM_MODE;
+	/* DSP expects stream id from 1 */
+	ac->stream_id = 1;
+	ac->apr = apr_register(dev, "ADSP", "ASM", q6asm_callback,
+			       ((ac->session) << 8 | 0x0001), ac);
+
+	if (ac->apr == NULL) {
+		dev_err(dev, "Registration with APR failed\n");
+		goto fail_apr1;
+	}
+
+	/* Common mmap APR service */
+	if (!a->mmap_apr) {
+		a->mmap_apr = apr_register(a->dev, "ADSP", "ASM",
+					   q6asm_srvc_callback,
+					   0x0FFFFFFFF, NULL);
+		if (a->mmap_apr == NULL) {
+			pr_err("Unable to register q6asm mmap service\n");
+			goto fail_mmap;
+		}
+	}
+
+	init_waitqueue_head(&ac->cmd_wait);
+	mutex_init(&ac->cmd_lock);
+	ac->cmd_state = 0;
+
+	pr_debug("%s: session[%d]\n", __func__, ac->session);
+
+	return ac;
+fail_mmap:
+	apr_deregister(ac->apr);
+fail_apr1:
+	q6asm_session_free(ac);
+fail_session:
+	kfree(ac);
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(q6asm_audio_client_alloc);
+
+static int __q6asm_open_write(struct audio_client *ac, uint32_t format,
+			      uint16_t bits_per_sample, uint32_t stream_id,
+			      bool is_gapless_mode)
+{
+	struct asm_stream_cmd_open_write_v3 open;
+	int rc;
+
+	q6asm_add_hdr(ac, &open.hdr, sizeof(open), true, stream_id);
+	ac->cmd_state = -1;
+	dev_vdbg(ac->dev, "%s: token = 0x%x, stream_id  %d, session 0x%x\n",
+		 __func__, open.hdr.token, stream_id, ac->session);
+	open.hdr.opcode = ASM_STREAM_CMD_OPEN_WRITE_V3;
+	open.mode_flags = 0x00;
+	open.mode_flags |= ASM_LEGACY_STREAM_SESSION;
+	if (is_gapless_mode)
+		open.mode_flags |= 1 << ASM_SHIFT_GAPLESS_MODE_FLAG;
+
+	/* source endpoint : matrix */
+	open.sink_endpointype = ASM_END_POINT_DEVICE_MATRIX;
+	open.bits_per_sample = bits_per_sample;
+	open.postprocopo_id = DEFAULT_POPP_TOPOLOGY;
+
+	switch (format) {
+	case FORMAT_LINEAR_PCM:
+		open.dec_fmt_id = ASM_MEDIA_FMT_MULTI_CHANNEL_PCM_V2;
+		break;
+	default:
+		dev_err(ac->dev, "Invalid format 0x%x\n", format);
+		return -EINVAL;
+	}
+	rc = apr_send_pkt(ac->apr, (uint32_t *) &open);
+	if (rc < 0)
+		return rc;
+
+	rc = wait_event_timeout(ac->cmd_wait, (ac->cmd_state >= 0), 5 * HZ);
+	if (!rc) {
+		dev_err(ac->dev, "timeout on open write\n");
+		return -ETIMEDOUT;
+	}
+
+	if (ac->cmd_state > 0)
+		return adsp_err_get_lnx_err_code(ac->cmd_state);
+
+	ac->io_mode |= TUN_WRITE_IO_MODE;
+
+	return 0;
+}
+
+int q6asm_open_write(struct audio_client *ac, uint32_t format,
+		     uint16_t bits_per_sample)
+{
+	return __q6asm_open_write(ac, format, bits_per_sample,
+				  ac->stream_id, false);
+}
+EXPORT_SYMBOL_GPL(q6asm_open_write);
+
+static int __q6asm_run(struct audio_client *ac, uint32_t flags,
+	      uint32_t msw_ts, uint32_t lsw_ts, bool wait)
+{
+	struct asm_session_cmd_run_v2 run;
+	int rc;
+
+	q6asm_add_hdr(ac, &run.hdr, sizeof(run), true, ac->stream_id);
+	ac->cmd_state = -1;
+
+	run.hdr.opcode = ASM_SESSION_CMD_RUN_V2;
+	run.flags = flags;
+	run.time_lsw = lsw_ts;
+	run.time_msw = msw_ts;
+
+	rc = apr_send_pkt(ac->apr, (uint32_t *) &run);
+	if (rc < 0)
+		return rc;
+
+	if (wait) {
+		rc = wait_event_timeout(ac->cmd_wait, (ac->cmd_state >= 0),
+					5 * HZ);
+		if (!rc) {
+			dev_err(ac->dev, "timeout on run cmd\n");
+			return -ETIMEDOUT;
+		}
+		if (ac->cmd_state > 0)
+			return adsp_err_get_lnx_err_code(ac->cmd_state);
+	}
+
+	return 0;
+}
+
+int q6asm_run(struct audio_client *ac, uint32_t flags,
+	      uint32_t msw_ts, uint32_t lsw_ts)
+{
+	return __q6asm_run(ac, flags, msw_ts, lsw_ts, true);
+}
+EXPORT_SYMBOL_GPL(q6asm_run);
+
+int q6asm_run_nowait(struct audio_client *ac, uint32_t flags,
+	      uint32_t msw_ts, uint32_t lsw_ts)
+{
+	return __q6asm_run(ac, flags, msw_ts, lsw_ts, false);
+}
+EXPORT_SYMBOL_GPL(q6asm_run_nowait);
+
+int q6asm_media_format_block_multi_ch_pcm(struct audio_client *ac,
+					  uint32_t rate, uint32_t channels,
+					  bool use_default_chmap,
+					  char *channel_map,
+					  uint16_t bits_per_sample)
+{
+	struct asm_multi_channel_pcm_fmt_blk_v2 fmt;
+	u8 *channel_mapping;
+	int rc = 0;
+
+	q6asm_add_hdr(ac, &fmt.hdr, sizeof(fmt), true, ac->stream_id);
+	ac->cmd_state = -1;
+
+	fmt.hdr.opcode = ASM_DATA_CMD_MEDIA_FMT_UPDATE_V2;
+	fmt.fmt_blk.fmt_blk_size = sizeof(fmt) - sizeof(fmt.hdr) -
+	    sizeof(fmt.fmt_blk);
+	fmt.num_channels = channels;
+	fmt.bits_per_sample = bits_per_sample;
+	fmt.sample_rate = rate;
+	fmt.is_signed = 1;
+
+	channel_mapping = fmt.channel_mapping;
+
+	if (use_default_chmap) {
+		if (q6dsp_map_channels(channel_mapping, channels)) {
+			dev_err(ac->dev, " map channels failed %d\n", channels);
+			return -EINVAL;
+		}
+	} else {
+		memcpy(channel_mapping, channel_map,
+		       PCM_FORMAT_MAX_NUM_CHANNEL);
+	}
+
+	rc = apr_send_pkt(ac->apr, (uint32_t *) &fmt);
+	if (rc < 0)
+		goto fail_cmd;
+
+	rc = wait_event_timeout(ac->cmd_wait, (ac->cmd_state >= 0), 5 * HZ);
+	if (!rc) {
+		dev_err(ac->dev, "timeout on format update\n");
+		return -ETIMEDOUT;
+	}
+	if (ac->cmd_state > 0)
+		return adsp_err_get_lnx_err_code(ac->cmd_state);
+
+	return 0;
+fail_cmd:
+	return rc;
+}
+EXPORT_SYMBOL_GPL(q6asm_media_format_block_multi_ch_pcm);
+
+int q6asm_write_nolock(struct audio_client *ac, uint32_t len, uint32_t msw_ts,
+		       uint32_t lsw_ts, uint32_t flags)
+{
+	struct asm_data_cmd_write_v2 write;
+	struct audio_port_data *port;
+	struct audio_buffer *ab;
+	int dsp_buf = 0;
+	int rc = 0;
+
+	if (ac->io_mode & SYNC_IO_MODE) {
+		port = &ac->port[SNDRV_PCM_STREAM_PLAYBACK];
+		q6asm_add_hdr(ac, &write.hdr, sizeof(write), false,
+			      ac->stream_id);
+
+		dsp_buf = port->dsp_buf;
+		ab = &port->buf[dsp_buf];
+
+		write.hdr.token = port->dsp_buf;
+		write.hdr.opcode = ASM_DATA_CMD_WRITE_V2;
+		write.buf_addr_lsw = lower_32_bits(ab->phys);
+		write.buf_addr_msw = upper_32_bits(ab->phys);
+		write.buf_size = len;
+		write.seq_id = port->dsp_buf;
+		write.timestamp_lsw = lsw_ts;
+		write.timestamp_msw = msw_ts;
+		write.mem_map_handle =
+		    ac->port[SNDRV_PCM_STREAM_PLAYBACK].mem_map_handle;
+
+		if (flags == NO_TIMESTAMP)
+			write.flags = (flags & 0x800000FF);
+		else
+			write.flags = (0x80000000 | flags);
+
+		port->dsp_buf++;
+
+		if (port->dsp_buf >= port->max_buf_cnt)
+			port->dsp_buf = 0;
+
+		rc = apr_send_pkt(ac->apr, (uint32_t *) &write);
+		if (rc < 0)
+			return rc;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(q6asm_write_nolock);
+
+static void q6asm_reset_buf_state(struct audio_client *ac)
+{
+	int cnt = 0;
+	int loopcnt = 0;
+	int used;
+	struct audio_port_data *port = NULL;
+
+	if (ac->io_mode & SYNC_IO_MODE) {
+		used = (ac->io_mode & TUN_WRITE_IO_MODE ? 1 : 0);
+		mutex_lock(&ac->cmd_lock);
+		for (loopcnt = 0; loopcnt <= SNDRV_PCM_STREAM_CAPTURE;
+		     loopcnt++) {
+			port = &ac->port[loopcnt];
+			cnt = port->max_buf_cnt - 1;
+			port->dsp_buf = 0;
+			port->cpu_buf = 0;
+			while (cnt >= 0) {
+				if (!port->buf)
+					continue;
+				port->buf[cnt].used = used;
+				cnt--;
+			}
+		}
+		mutex_unlock(&ac->cmd_lock);
+	}
+}
+
+static int __q6asm_cmd(struct audio_client *ac, int cmd, bool wait)
+{
+	int stream_id = ac->stream_id;
+	struct apr_hdr hdr;
+	int rc;
+
+	q6asm_add_hdr(ac, &hdr, sizeof(hdr), true, stream_id);
+	ac->cmd_state = -1;
+	switch (cmd) {
+	case CMD_PAUSE:
+		hdr.opcode = ASM_SESSION_CMD_PAUSE;
+		break;
+	case CMD_SUSPEND:
+		hdr.opcode = ASM_SESSION_CMD_SUSPEND;
+		break;
+	case CMD_FLUSH:
+		hdr.opcode = ASM_STREAM_CMD_FLUSH;
+		break;
+	case CMD_OUT_FLUSH:
+		hdr.opcode = ASM_STREAM_CMD_FLUSH_READBUFS;
+		break;
+	case CMD_EOS:
+		hdr.opcode = ASM_DATA_CMD_EOS;
+		ac->cmd_state = 0;
+		break;
+	case CMD_CLOSE:
+		hdr.opcode = ASM_STREAM_CMD_CLOSE;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	rc = apr_send_pkt(ac->apr, (uint32_t *) &hdr);
+	if (rc < 0)
+		return rc;
+
+	if (!wait)
+		return 0;
+
+	rc = wait_event_timeout(ac->cmd_wait, (ac->cmd_state >= 0), 5 * HZ);
+	if (!rc) {
+		dev_err(ac->dev, "timeout response for opcode[0x%x]\n",
+			hdr.opcode);
+		return -ETIMEDOUT;
+	}
+	if (ac->cmd_state > 0)
+		return adsp_err_get_lnx_err_code(ac->cmd_state);
+
+	if (cmd == CMD_FLUSH)
+		q6asm_reset_buf_state(ac);
+
+	return 0;
+}
+
+int q6asm_cmd(struct audio_client *ac, int cmd)
+{
+	return __q6asm_cmd(ac, cmd, true);
+}
+EXPORT_SYMBOL_GPL(q6asm_cmd);
+
+int q6asm_cmd_nowait(struct audio_client *ac, int cmd)
+{
+	return __q6asm_cmd(ac, cmd, false);
+}
+EXPORT_SYMBOL_GPL(q6asm_cmd_nowait);
+
+struct q6asm *q6asm_get(struct device *dev)
+{
+	if (!__q6asm)
+		return ERR_PTR(-EPROBE_DEFER);
+
+	return __q6asm;
+}
+EXPORT_SYMBOL_GPL(q6asm_get);
+
+void q6asm_put(struct q6asm *a)
+{
+}
+EXPORT_SYMBOL_GPL(q6asm_put);
+
+static int q6asm_probe(struct platform_device *pdev)
+{
+	__q6asm = kzalloc(sizeof(*__q6asm), GFP_KERNEL);
+	if (!__q6asm)
+		return -ENOMEM;
+
+	__q6asm->dev = &pdev->dev;
+	__q6asm->mem_state = 0;
+	init_waitqueue_head(&__q6asm->mem_wait);
+	mutex_init(&__q6asm->session_lock);
+
+	return 0;
+}
+
+static int q6asm_remove(struct platform_device *pdev)
+{
+	if (__q6asm->mmap_apr)
+		return apr_deregister(__q6asm->mmap_apr);
+
+	kfree(__q6asm);
+	__q6asm = NULL;
+
+	return 0;
+}
+
+static const struct of_device_id qcom_q6asm_match[] = {
+	{.compatible = "qcom,q6asm-v2",},
+	{}
+};
+
+static struct platform_driver qcom_q6asm_driver = {
+	.probe = q6asm_probe,
+	.remove = q6asm_remove,
+	.driver = {
+		   .name = "qcom-q6asm",
+		   .of_match_table = qcom_q6asm_match,
+		   },
+};
+
+module_platform_driver(qcom_q6asm_driver);
+MODULE_AUTHOR("Srinivas Kandagatla <srinivas.kandagatla@linaro.org");
+MODULE_DESCRIPTION("q6 Audio Stream Manager driver");
+MODULE_LICENSE("GPL v2");
-- 
2.9.3
