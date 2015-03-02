From: han.lu@intel.com
Subject: [PATCH 6/8] ASoC: Intel: add function to set parameter
	to sound effect module waves
Date: Mon,  2 Mar 2015 15:36:16 +0800
Message-ID: <1425281778-17513-6-git-send-email-han.lu@intel.com>
References: <1425281778-17513-1-git-send-email-han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 181612605AB
 for <alsa-devel@alsa-project.org>; Mon,  2 Mar 2015 08:38:16 +0100 (CET)
In-Reply-To: <1425281778-17513-1-git-send-email-han.lu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
Cc: "Lu, Han" <han.lu@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Lu, Han" <han.lu@intel.com>

Add function to set parameters to module waves. The parameters can be set
only when module is enabled, and parameter size is limited to 500 Bytes.

Signed-off-by: Lu, Han <han.lu@intel.com>

diff --git a/sound/soc/intel/sst-haswell-ipc.c b/sound/soc/intel/sst-haswell-ipc.c
index d6ccb46..7dda402 100644
--- a/sound/soc/intel/sst-haswell-ipc.c
+++ b/sound/soc/intel/sst-haswell-ipc.c
@@ -2170,6 +2170,67 @@ int sst_hsw_module_disable(struct sst_hsw *hsw,
 	return ret;
 }
 
+int sst_hsw_module_set_param(struct sst_hsw *hsw,
+	u32 module_id, u32 instance_id, u32 parameter_id,
+	u32 param_size, char *param)
+{
+	int ret;
+	unsigned char *data = NULL;
+	u32 header = 0;
+	u32 payload_size = 0, transfer_parameter_size = 0;
+	dma_addr_t dma_addr = 0;
+	struct sst_hsw_transfer_parameter *parameter;
+	struct device *dev = hsw->dev;
+
+	header = IPC_GLB_TYPE(IPC_GLB_MODULE_OPERATION) |
+			IPC_MODULE_OPERATION(IPC_MODULE_SET_PARAMETER) |
+			IPC_MODULE_ID(module_id);
+	dev_dbg(dev, "sst_hsw_module_set_param header=%x\n", header);
+
+	payload_size = param_size +
+		sizeof(struct sst_hsw_transfer_parameter) -
+		sizeof(struct sst_hsw_transfer_list);
+	dev_dbg(dev, "parameter size : %d\n", param_size);
+	dev_dbg(dev, "payload size   : %d\n", payload_size);
+
+	if (payload_size <= SST_HSW_IPC_MAX_SHORT_PARAMETER_SIZE) {
+		/* short parameter, mailbox can contain data */
+		dev_dbg(dev, "transfer parameter size : %d\n",
+			transfer_parameter_size);
+
+		transfer_parameter_size = ALIGN(payload_size, 4);
+		dev_dbg(dev, "transfer parameter aligned size : %d\n",
+			transfer_parameter_size);
+
+		parameter = kzalloc(transfer_parameter_size, GFP_KERNEL);
+		if (parameter == NULL)
+			return -ENOMEM;
+
+		memcpy(parameter->data, param, param_size);
+	} else {
+		dev_warn(dev, "transfer parameter size too large!");
+		return 0;
+	}
+
+	parameter->parameter_id = parameter_id;
+	parameter->data_size = param_size;
+
+	ret = ipc_tx_message_wait(hsw, header,
+		parameter, transfer_parameter_size , NULL, 0);
+	if (ret < 0)
+		dev_err(dev, "ipc: module set parameter failed - %d\n", ret);
+	else
+		dev_info(dev, "ipc: module set parameter success\n");
+
+	kfree(parameter);
+
+	if (data)
+		dma_free_coherent(hsw->dsp->dma_dev,
+			param_size, (void *)data, dma_addr);
+
+	return ret;
+}
+
 static struct sst_dsp_device hsw_dev = {
 	.thread = hsw_irq_thread,
 	.ops = &haswell_ops,
diff --git a/sound/soc/intel/sst-haswell-ipc.h b/sound/soc/intel/sst-haswell-ipc.h
index 48290a1..16bec43 100644
--- a/sound/soc/intel/sst-haswell-ipc.h
+++ b/sound/soc/intel/sst-haswell-ipc.h
@@ -37,6 +37,7 @@
 #define SST_HSW_IPC_MAX_PAYLOAD_SIZE	400
 #define SST_HSW_MAX_INFO_SIZE		64
 #define SST_HSW_BUILD_HASH_LENGTH	40
+#define SST_HSW_IPC_MAX_SHORT_PARAMETER_SIZE	500
 
 struct sst_hsw;
 struct sst_hsw_stream;
@@ -187,6 +188,28 @@ enum sst_hsw_performance_action {
 	SST_HSW_PERF_STOP = 1,
 };
 
+struct sst_hsw_transfer_info {
+	uint32_t destination;       /* destination address */
+	uint32_t reverse:1;         /* if 1 data flows from destination */
+	uint32_t size:31;           /* transfer size in bytes.*/
+	uint16_t first_page_offset; /* offset to data in the first page. */
+	uint8_t  packed_pages;   /* page addresses. Each occupies 20 bits */
+} __attribute__((packed));
+
+struct sst_hsw_transfer_list {
+	uint32_t transfers_count;
+	struct sst_hsw_transfer_info transfers;
+} __attribute__((packed));
+
+struct sst_hsw_transfer_parameter {
+	uint32_t parameter_id;
+	uint32_t data_size;
+	union {
+		uint8_t data[1];
+		struct sst_hsw_transfer_list transfer_list;
+	};
+} __attribute__((packed));
+
 /* SST firmware module info */
 struct sst_hsw_module_info {
 	u8 name[SST_HSW_MAX_INFO_SIZE];
@@ -487,6 +510,9 @@ int sst_hsw_module_enable(struct sst_hsw *hsw,
 	u32 module_id, u32 instance_id);
 int sst_hsw_module_disable(struct sst_hsw *hsw,
 	u32 module_id, u32 instance_id);
+int sst_hsw_module_set_param(struct sst_hsw *hsw,
+	u32 module_id, u32 instance_id, u32 parameter_id,
+	u32 param_size, char *param);
 
 /* runtime module management */
 struct sst_module_runtime *sst_hsw_runtime_module_create(struct sst_hsw *hsw,
-- 
1.9.1
