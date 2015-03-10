From: han.lu@intel.com
Subject: [PATCH v2 3/8] ASoC: Intel: add function to
	enable/disable sound effect module waves
Date: Tue, 10 Mar 2015 10:41:22 +0800
Message-ID: <1425955287-29661-3-git-send-email-han.lu@intel.com>
References: <1425955287-29661-1-git-send-email-han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id DF02A261785
 for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2015 03:41:49 +0100 (CET)
In-Reply-To: <1425955287-29661-1-git-send-email-han.lu@intel.com>
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

Signed-off-by: Lu, Han <han.lu@intel.com>

diff --git a/sound/soc/intel/sst-haswell-ipc.c b/sound/soc/intel/sst-haswell-ipc.c
index 63740e3..265d754 100644
--- a/sound/soc/intel/sst-haswell-ipc.c
+++ b/sound/soc/intel/sst-haswell-ipc.c
@@ -79,6 +79,15 @@
 #define IPC_LOG_ID_MASK		(0xf << IPC_LOG_ID_SHIFT)
 #define IPC_LOG_ID(x)		(x << IPC_LOG_ID_SHIFT)
 
+/* Module Message */
+#define IPC_MODULE_OPERATION_SHIFT	20
+#define IPC_MODULE_OPERATION_MASK	(0xf << IPC_MODULE_OPERATION_SHIFT)
+#define IPC_MODULE_OPERATION(x)	(x << IPC_MODULE_OPERATION_SHIFT)
+
+#define IPC_MODULE_ID_SHIFT	16
+#define IPC_MODULE_ID_MASK	(0xf << IPC_MODULE_ID_SHIFT)
+#define IPC_MODULE_ID(x)	(x << IPC_MODULE_ID_SHIFT)
+
 /* IPC message timeout (msecs) */
 #define IPC_TIMEOUT_MSECS	300
 #define IPC_BOOT_MSECS		200
@@ -115,6 +124,7 @@ enum ipc_glb_type {
 	IPC_GLB_ENTER_DX_STATE = 12,
 	IPC_GLB_GET_MIXER_STREAM_INFO = 13,	/* Request mixer stream params */
 	IPC_GLB_DEBUG_LOG_MESSAGE = 14,		/* Message to or from the debug logger. */
+	IPC_GLB_MODULE_OPERATION = 15,		/* Message to loadable fw module */
 	IPC_GLB_REQUEST_TRANSFER = 16, 		/* < Request Transfer for host */
 	IPC_GLB_MAX_IPC_MESSAGE_TYPE = 17,	/* Maximum message number */
 };
@@ -133,6 +143,16 @@ enum ipc_glb_reply {
 	IPC_GLB_REPLY_SOURCE_NOT_STARTED = 10,	/* Source was not started. */
 };
 
+enum ipc_module_operation {
+	IPC_MODULE_NOTIFICATION = 0,
+	IPC_MODULE_ENABLE = 1,
+	IPC_MODULE_DISABLE = 2,
+	IPC_MODULE_GET_PARAMETER = 3,
+	IPC_MODULE_SET_PARAMETER = 4,
+	IPC_MODULE_GET_INFO = 5,
+	IPC_MODULE_MAX_MESSAGE
+};
+
 /* Stream Message - Types */
 enum ipc_str_operation {
 	IPC_STR_RESET = 0,
@@ -352,6 +372,16 @@ static inline u32 msg_get_notify_reason(u32 msg)
 	return (msg & IPC_STG_TYPE_MASK) >> IPC_STG_TYPE_SHIFT;
 }
 
+static inline u32 msg_get_module_operation(u32 msg)
+{
+	return (msg & IPC_MODULE_OPERATION_MASK) >> IPC_MODULE_OPERATION_SHIFT;
+}
+
+static inline u32 msg_get_module_id(u32 msg)
+{
+	return (msg & IPC_MODULE_ID_MASK) >> IPC_MODULE_ID_SHIFT;
+}
+
 u32 create_channel_map(enum sst_hsw_channel_config config)
 {
 	switch (config) {
@@ -795,6 +825,31 @@ static int hsw_process_reply(struct sst_hsw *hsw, u32 header)
 	return 1;
 }
 
+static int hsw_module_message(struct sst_hsw *hsw, u32 header)
+{
+	u32 operation, module_id;
+	int handled = 0;
+
+	operation = msg_get_module_operation(header);
+	module_id = msg_get_module_id(header);
+	dev_dbg(hsw->dev, "received module message header: 0x%8.8x\n",
+			header);
+	dev_dbg(hsw->dev, "operation: 0x%8.8x module_id: 0x%8.8x\n",
+			operation, module_id);
+
+	switch (operation) {
+	case IPC_MODULE_NOTIFICATION:
+		dev_dbg(hsw->dev, "module notification received");
+		handled = 1;
+		break;
+	default:
+		handled = hsw_process_reply(hsw, header);
+		break;
+	}
+
+	return handled;
+}
+
 static int hsw_stream_message(struct sst_hsw *hsw, u32 header)
 {
 	u32 stream_msg, stream_id, stage_type;
@@ -890,6 +945,9 @@ static int hsw_process_notification(struct sst_hsw *hsw)
 	case IPC_GLB_DEBUG_LOG_MESSAGE:
 		handled = hsw_log_message(hsw, header);
 		break;
+	case IPC_GLB_MODULE_OPERATION:
+		handled = hsw_module_message(hsw, header);
+		break;
 	default:
 		dev_err(hsw->dev, "error: unexpected type %d hdr 0x%8.8x\n",
 			type, header);
@@ -1917,6 +1975,17 @@ bool sst_hsw_is_module_loaded(struct sst_hsw *hsw, u32 module_id)
 		return true;
 }
 
+bool sst_hsw_is_module_active(struct sst_hsw *hsw, u32 module_id)
+{
+	struct sst_module *module;
+
+	module = sst_module_get_from_id(hsw->dsp, module_id);
+	if (module != NULL && module->state == SST_MODULE_STATE_ACTIVE)
+		return true;
+	else
+		return false;
+}
+
 int sst_hsw_module_load(struct sst_hsw *hsw,
 	u32 module_id, u32 instance_id, char *name)
 {
@@ -1972,6 +2041,112 @@ out:
 	return ret;
 }
 
+int sst_hsw_module_enable(struct sst_hsw *hsw,
+	u32 module_id, u32 instance_id)
+{
+	int ret;
+	u32 header = 0;
+	struct sst_hsw_ipc_module_config config;
+	struct sst_module *module;
+	struct sst_module_runtime *runtime;
+	struct device *dev = hsw->dev;
+	struct sst_dsp *dsp = hsw->dsp;
+
+	if (!sst_hsw_is_module_loaded(hsw, module_id)) {
+		dev_dbg(dev, "module %d not loaded\n", module_id);
+		return 0;
+	}
+
+	if (sst_hsw_is_module_active(hsw, module_id)) {
+		dev_info(dev, "module %d already enabled\n", module_id);
+		return 0;
+	}
+
+	module = sst_module_get_from_id(dsp, module_id);
+	if (module == NULL) {
+		dev_err(dev, "module %d not valid\n", module_id);
+		return -ENXIO;
+	}
+
+	runtime = sst_module_runtime_get_from_id(module, module_id);
+	if (runtime == NULL) {
+		dev_err(dev, "runtime %d not valid", module_id);
+		return -ENXIO;
+	}
+
+	header = IPC_GLB_TYPE(IPC_GLB_MODULE_OPERATION) |
+			IPC_MODULE_OPERATION(IPC_MODULE_ENABLE) |
+			IPC_MODULE_ID(module_id);
+	dev_dbg(dev, "module enable header: %x\n", header);
+
+	config.map.module_entries_count = 1;
+	config.map.module_entries[0].module_id = module->id;
+	config.map.module_entries[0].entry_point = module->entry;
+
+	config.persistent_mem.offset =
+		sst_dsp_get_offset(dsp,
+			runtime->persistent_offset, SST_MEM_DRAM);
+	config.persistent_mem.size = module->persistent_size;
+
+	config.scratch_mem.offset =
+		sst_dsp_get_offset(dsp,
+			dsp->scratch_offset, SST_MEM_DRAM);
+	config.scratch_mem.size = module->scratch_size;
+	dev_dbg(dev, "mod %d enable p:%d @ %x, s:%d @ %x, ep: %x",
+		config.map.module_entries[0].module_id,
+		config.persistent_mem.size,
+		config.persistent_mem.offset,
+		config.scratch_mem.size, config.scratch_mem.offset,
+		config.map.module_entries[0].entry_point);
+
+	ret = ipc_tx_message_wait(hsw, header,
+			&config, sizeof(config), NULL, 0);
+	if (ret < 0)
+		dev_err(dev, "ipc: module enable failed - %d\n", ret);
+	else
+		module->state = SST_MODULE_STATE_ACTIVE;
+
+	return ret;
+}
+
+int sst_hsw_module_disable(struct sst_hsw *hsw,
+	u32 module_id, u32 instance_id)
+{
+	int ret;
+	u32 header;
+	struct sst_module *module;
+	struct device *dev = hsw->dev;
+	struct sst_dsp *dsp = hsw->dsp;
+
+	if (!sst_hsw_is_module_loaded(hsw, module_id)) {
+		dev_dbg(dev, "module %d not loaded\n", module_id);
+		return 0;
+	}
+
+	if (!sst_hsw_is_module_active(hsw, module_id)) {
+		dev_info(dev, "module %d already disabled\n", module_id);
+		return 0;
+	}
+
+	module = sst_module_get_from_id(dsp, module_id);
+	if (module == NULL) {
+		dev_err(dev, "module %d not valid\n", module_id);
+		return -ENXIO;
+	}
+
+	header = IPC_GLB_TYPE(IPC_GLB_MODULE_OPERATION) |
+			IPC_MODULE_OPERATION(IPC_MODULE_DISABLE) |
+			IPC_MODULE_ID(module_id);
+
+	ret = ipc_tx_message_wait(hsw, header,  NULL, 0, NULL, 0);
+	if (ret < 0)
+		dev_err(dev, "module disable failed - %d\n", ret);
+	else
+		module->state = SST_MODULE_STATE_INITIALIZED;
+
+	return ret;
+}
+
 static struct sst_dsp_device hsw_dev = {
 	.thread = hsw_irq_thread,
 	.ops = &haswell_ops,
diff --git a/sound/soc/intel/sst-haswell-ipc.h b/sound/soc/intel/sst-haswell-ipc.h
index 208724b..30c65b2 100644
--- a/sound/soc/intel/sst-haswell-ipc.h
+++ b/sound/soc/intel/sst-haswell-ipc.h
@@ -215,6 +215,12 @@ struct sst_hsw_fx_enable {
 	struct sst_hsw_memory_info persistent_mem;
 } __attribute__((packed));
 
+struct sst_hsw_ipc_module_config {
+	struct sst_hsw_module_map map;
+	struct sst_hsw_memory_info persistent_mem;
+	struct sst_hsw_memory_info scratch_mem;
+} __attribute__((packed));
+
 struct sst_hsw_get_fx_param {
 	u32 parameter_id;
 	u32 param_size;
@@ -470,9 +476,14 @@ struct sst_dsp *sst_hsw_get_dsp(struct sst_hsw *hsw);
 /* fw module function */
 void sst_hsw_init_module_state(struct sst_hsw *hsw);
 bool sst_hsw_is_module_loaded(struct sst_hsw *hsw, u32 module_id);
+bool sst_hsw_is_module_active(struct sst_hsw *hsw, u32 module_id);
 
 int sst_hsw_module_load(struct sst_hsw *hsw,
 	u32 module_id, u32 instance_id, char *name);
+int sst_hsw_module_enable(struct sst_hsw *hsw,
+	u32 module_id, u32 instance_id);
+int sst_hsw_module_disable(struct sst_hsw *hsw,
+	u32 module_id, u32 instance_id);
 
 /* runtime module management */
 struct sst_module_runtime *sst_hsw_runtime_module_create(struct sst_hsw *hsw,
-- 
1.9.1
