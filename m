From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH 2/3] ASoC: Intel: Add PM support to HSW/BDW IPC
	driver
Date: Wed, 29 Oct 2014 17:40:42 +0000
Message-ID: <1414604443-7712-2-git-send-email-liam.r.girdwood@linux.intel.com>
References: <1414604443-7712-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 849D42604E5
 for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2014 18:44:25 +0100 (CET)
In-Reply-To: <1414604443-7712-1-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Add PM and RTD3 support to the HSW/BDW IPC driver. This patch
saves and restores the DSP context, loads and unloads FW and drops
any pending IPC messages after suspend.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 sound/soc/intel/sst-haswell-ipc.c | 256 +++++++++++++++++++++++++++++++++++++-
 sound/soc/intel/sst-haswell-ipc.h |   7 ++
 2 files changed, 258 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/sst-haswell-ipc.c b/sound/soc/intel/sst-haswell-ipc.c
index 770d467..b37d3ee 100644
--- a/sound/soc/intel/sst-haswell-ipc.c
+++ b/sound/soc/intel/sst-haswell-ipc.c
@@ -30,6 +30,7 @@
 #include <linux/firmware.h>
 #include <linux/dma-mapping.h>
 #include <linux/debugfs.h>
+#include <linux/pm_runtime.h>
 
 #include "sst-haswell-ipc.h"
 #include "sst-dsp.h"
@@ -276,6 +277,7 @@ struct sst_hsw {
 	struct sst_hsw_ipc_fw_version version;
 	struct sst_module *scratch;
 	bool fw_done;
+	struct sst_fw *sst_fw;
 
 	/* stream */
 	struct list_head stream_list;
@@ -289,6 +291,8 @@ struct sst_hsw {
 
 	/* DX */
 	struct sst_hsw_ipc_dx_reply dx;
+	void *dx_context;
+	dma_addr_t dx_context_paddr;
 
 	/* boot */
 	wait_queue_head_t boot_wait;
@@ -1707,6 +1711,237 @@ void sst_hsw_runtime_module_free(struct sst_module_runtime *runtime)
 	sst_module_runtime_free(runtime);
 }
 
+#ifdef CONFIG_PM_RUNTIME
+static int sst_hsw_dx_state_dump(struct sst_hsw *hsw)
+{
+	struct sst_dsp *sst = hsw->dsp;
+	u32 item, offset, size;
+	int ret = 0;
+
+	trace_ipc_request("PM state dump. Items #", SST_HSW_MAX_DX_REGIONS);
+
+	if (hsw->dx.entries_no > SST_HSW_MAX_DX_REGIONS) {
+		dev_err(hsw->dev,
+			"error: number of FW context regions greater than %d\n",
+			SST_HSW_MAX_DX_REGIONS);
+		memset(&hsw->dx, 0, sizeof(hsw->dx));
+		return -EINVAL;
+	}
+
+	ret = sst_dsp_dma_get_channel(sst, 0);
+	if (ret < 0) {
+		dev_err(hsw->dev, "error: cant allocate dma channel %d\n", ret);
+		return ret;
+	}
+
+	/* set on-demond mode on engine 0 channel 3 */
+	sst_dsp_shim_update_bits(sst, SST_HMDC,
+			SST_HMDC_HDDA_E0_ALLCH | SST_HMDC_HDDA_E1_ALLCH,
+			SST_HMDC_HDDA_E0_ALLCH | SST_HMDC_HDDA_E1_ALLCH);
+
+	for (item = 0; item < hsw->dx.entries_no; item++) {
+		if (hsw->dx.mem_info[item].source == SST_HSW_DX_TYPE_MEMORY_DUMP
+			&& hsw->dx.mem_info[item].offset > DSP_DRAM_ADDR_OFFSET
+			&& hsw->dx.mem_info[item].offset <
+			DSP_DRAM_ADDR_OFFSET + SST_HSW_DX_CONTEXT_SIZE) {
+
+			offset = hsw->dx.mem_info[item].offset
+					- DSP_DRAM_ADDR_OFFSET;
+			size = (hsw->dx.mem_info[item].size + 3) & (~3);
+
+			ret = sst_dsp_dma_copyfrom(sst, hsw->dx_context_paddr + offset,
+				sst->addr.lpe_base + offset, size);
+			if (ret < 0) {
+				dev_err(hsw->dev,
+					"error: FW context dump failed\n");
+				memset(&hsw->dx, 0, sizeof(hsw->dx));
+				goto out;
+			}
+		}
+	}
+
+out:
+	sst_dsp_dma_put_channel(sst);
+	return ret;
+}
+
+static int sst_hsw_dx_state_restore(struct sst_hsw *hsw)
+{
+	struct sst_dsp *sst = hsw->dsp;
+	u32 item, offset, size;
+	int ret;
+
+	for (item = 0; item < hsw->dx.entries_no; item++) {
+		if (hsw->dx.mem_info[item].source == SST_HSW_DX_TYPE_MEMORY_DUMP
+			&& hsw->dx.mem_info[item].offset > DSP_DRAM_ADDR_OFFSET
+			&& hsw->dx.mem_info[item].offset <
+			DSP_DRAM_ADDR_OFFSET + SST_HSW_DX_CONTEXT_SIZE) {
+
+			offset = hsw->dx.mem_info[item].offset
+					- DSP_DRAM_ADDR_OFFSET;
+			size = (hsw->dx.mem_info[item].size + 3) & (~3);
+
+			ret = sst_dsp_dma_copyto(sst, sst->addr.lpe_base + offset,
+				hsw->dx_context_paddr + offset, size);
+			if (ret < 0) {
+				dev_err(hsw->dev,
+					"error: FW context restore failed\n");
+				return ret;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static void sst_hsw_drop_all(struct sst_hsw *hsw)
+{
+	struct ipc_message *msg, *tmp;
+	unsigned long flags;
+	int tx_drop_cnt = 0, rx_drop_cnt = 0;
+
+	/* drop all TX and Rx messages before we stall + reset DSP */
+	spin_lock_irqsave(&hsw->dsp->spinlock, flags);
+
+	list_for_each_entry_safe(msg, tmp, &hsw->tx_list, list) {
+		list_move(&msg->list, &hsw->empty_list);
+		tx_drop_cnt++;
+	}
+
+	list_for_each_entry_safe(msg, tmp, &hsw->rx_list, list) {
+		list_move(&msg->list, &hsw->empty_list);
+		rx_drop_cnt++;
+	}
+
+	spin_unlock_irqrestore(&hsw->dsp->spinlock, flags);
+
+	if (tx_drop_cnt || rx_drop_cnt)
+		dev_err(hsw->dev, "dropped IPC msg RX=%d, TX=%d\n",
+			tx_drop_cnt, rx_drop_cnt);
+}
+
+int sst_hsw_dsp_load(struct sst_hsw *hsw)
+{
+	struct sst_dsp *dsp = hsw->dsp;
+	int ret;
+
+	dev_dbg(hsw->dev, "loading audio DSP....");
+
+	ret = sst_dsp_wake(dsp);
+	if (ret < 0) {
+		dev_err(hsw->dev, "error: failed to wake audio DSP\n");
+		return -ENODEV;
+	}
+
+	ret = sst_dsp_dma_get_channel(dsp, 0);
+	if (ret < 0) {
+		dev_err(hsw->dev, "error: cant allocate dma channel %d\n", ret);
+		return ret;
+	}
+
+	ret = sst_fw_reload(hsw->sst_fw);
+	if (ret < 0) {
+		dev_err(hsw->dev, "error: SST FW reload failed\n");
+		sst_dsp_dma_put_channel(dsp);
+		return -ENOMEM;
+	}
+
+	sst_dsp_dma_put_channel(dsp);
+	return 0;
+}
+
+static int sst_hsw_dsp_restore(struct sst_hsw *hsw)
+{
+	struct sst_dsp *dsp = hsw->dsp;
+	int ret;
+
+	dev_dbg(hsw->dev, "restoring audio DSP....");
+
+	ret = sst_dsp_dma_get_channel(dsp, 0);
+	if (ret < 0) {
+		dev_err(hsw->dev, "error: cant allocate dma channel %d\n", ret);
+		return ret;
+	}
+
+	ret = sst_hsw_dx_state_restore(hsw);
+	if (ret < 0) {
+		dev_err(hsw->dev, "error: SST FW context restore failed\n");
+		sst_dsp_dma_put_channel(dsp);
+		return -ENOMEM;
+	}
+	sst_dsp_dma_put_channel(dsp);
+
+	/* wait for DSP boot completion */
+	sst_dsp_boot(dsp);
+
+	return ret;
+}
+
+int sst_hsw_dsp_runtime_suspend(struct sst_hsw *hsw)
+{
+	int ret;
+
+	dev_dbg(hsw->dev, "audio dsp runtime suspend\n");
+
+	ret = sst_hsw_dx_set_state(hsw, SST_HSW_DX_STATE_D3, &hsw->dx);
+	if (ret < 0)
+		return ret;
+
+	sst_dsp_stall(hsw->dsp);
+
+	ret = sst_hsw_dx_state_dump(hsw);
+	if (ret < 0)
+		return ret;
+
+	sst_hsw_drop_all(hsw);
+
+	return 0;
+}
+
+int sst_hsw_dsp_runtime_sleep(struct sst_hsw *hsw)
+{
+	sst_fw_unload(hsw->sst_fw);
+	sst_block_free_scratch(hsw->dsp);
+
+	hsw->boot_complete = false;
+
+	sst_dsp_sleep(hsw->dsp);
+
+	return 0;
+}
+
+int sst_hsw_dsp_runtime_resume(struct sst_hsw *hsw)
+{
+	struct device *dev = hsw->dev;
+	int ret;
+
+	dev_dbg(dev, "audio dsp runtime resume\n");
+
+	if (hsw->boot_complete)
+		return 1; /* tell caller no action is required */
+
+	ret = sst_hsw_dsp_restore(hsw);
+	if (ret < 0)
+		dev_err(dev, "error: audio DSP boot failure\n");
+
+	ret = wait_event_timeout(hsw->boot_wait, hsw->boot_complete,
+		msecs_to_jiffies(IPC_BOOT_MSECS));
+	if (ret == 0) {
+		dev_err(hsw->dev, "error: audio DSP boot timeout\n");
+		return -EIO;
+	}
+
+	/* Set ADSP SSP port settings */
+	ret = sst_hsw_device_set_config(hsw, SST_HSW_DEVICE_SSP_0,
+					SST_HSW_DEVICE_MCLK_FREQ_24_MHZ,
+					SST_HSW_DEVICE_CLOCK_MASTER, 9);
+	if (ret < 0)
+		dev_err(dev, "error: SSP re-initialization failed\n");
+
+	return ret;
+}
+#endif
+
 static int msg_empty_list_init(struct sst_hsw *hsw)
 {
 	int i;
@@ -1738,7 +1973,6 @@ int sst_hsw_dsp_init(struct device *dev, struct sst_pdata *pdata)
 {
 	struct sst_hsw_ipc_fw_version version;
 	struct sst_hsw *hsw;
-	struct sst_fw *hsw_sst_fw;
 	int ret;
 
 	dev_dbg(dev, "initialising Audio DSP IPC\n");
@@ -1780,12 +2014,19 @@ int sst_hsw_dsp_init(struct device *dev, struct sst_pdata *pdata)
 		goto dsp_err;
 	}
 
+	/* allocate DMA buffer for context storage */
+	hsw->dx_context = dma_alloc_coherent(hsw->dsp->dma_dev,
+		SST_HSW_DX_CONTEXT_SIZE, &hsw->dx_context_paddr, GFP_KERNEL);
+	if (hsw->dx_context == NULL) {
+		ret = -ENOMEM;
+		goto dma_err;
+	}
+
 	/* keep the DSP in reset state for base FW loading */
 	sst_dsp_reset(hsw->dsp);
 
-	hsw_sst_fw = sst_fw_new(hsw->dsp, pdata->fw, hsw);
-
-	if (hsw_sst_fw == NULL) {
+	hsw->sst_fw = sst_fw_new(hsw->dsp, pdata->fw, hsw);
+	if (hsw->sst_fw == NULL) {
 		ret = -ENODEV;
 		dev_err(dev, "error: failed to load firmware\n");
 		goto fw_err;
@@ -1816,8 +2057,11 @@ int sst_hsw_dsp_init(struct device *dev, struct sst_pdata *pdata)
 
 boot_err:
 	sst_dsp_reset(hsw->dsp);
-	sst_fw_free(hsw_sst_fw);
+	sst_fw_free(hsw->sst_fw);
 fw_err:
+	dma_free_coherent(hsw->dsp->dma_dev, SST_HSW_DX_CONTEXT_SIZE,
+			hsw->dx_context, hsw->dx_context_paddr);
+dma_err:
 	sst_dsp_free(hsw->dsp);
 dsp_err:
 	kthread_stop(hsw->tx_thread);
@@ -1834,6 +2078,8 @@ void sst_hsw_dsp_free(struct device *dev, struct sst_pdata *pdata)
 
 	sst_dsp_reset(hsw->dsp);
 	sst_fw_free_all(hsw->dsp);
+	dma_free_coherent(hsw->dsp->dma_dev, SST_HSW_DX_CONTEXT_SIZE,
+			hsw->dx_context, hsw->dx_context_paddr);
 	sst_dsp_free(hsw->dsp);
 	kfree(hsw->scratch);
 	kthread_stop(hsw->tx_thread);
diff --git a/sound/soc/intel/sst-haswell-ipc.h b/sound/soc/intel/sst-haswell-ipc.h
index fe6e63f..afd0ae1 100644
--- a/sound/soc/intel/sst-haswell-ipc.h
+++ b/sound/soc/intel/sst-haswell-ipc.h
@@ -23,6 +23,7 @@
 
 #define SST_HSW_NO_CHANNELS		2
 #define SST_HSW_MAX_DX_REGIONS		14
+#define SST_HSW_DX_CONTEXT_SIZE        (640 * 1024)
 
 #define SST_HSW_FW_LOG_CONFIG_DWORDS	12
 #define SST_HSW_GLOBAL_LOG		15
@@ -492,4 +493,10 @@ struct sst_module_runtime *sst_hsw_runtime_module_create(struct sst_hsw *hsw,
 	int mod_id, int offset);
 void sst_hsw_runtime_module_free(struct sst_module_runtime *runtime);
 
+/* PM */
+int sst_hsw_dsp_runtime_resume(struct sst_hsw *hsw);
+int sst_hsw_dsp_runtime_suspend(struct sst_hsw *hsw);
+int sst_hsw_dsp_load(struct sst_hsw *hsw);
+int sst_hsw_dsp_runtime_sleep(struct sst_hsw *hsw);
+
 #endif
-- 
2.1.0
