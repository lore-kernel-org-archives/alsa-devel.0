From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 8/8] ASoC: Intel: Bxtn: Add Broxton DSP support
Date: Fri, 11 Mar 2016 10:12:56 +0530
Message-ID: <1457671376-18667-9-git-send-email-vinod.koul@intel.com>
References: <1457671376-18667-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id AB9F52664BB
 for <alsa-devel@alsa-project.org>; Fri, 11 Mar 2016 05:39:12 +0100 (CET)
In-Reply-To: <1457671376-18667-1-git-send-email-vinod.koul@intel.com>
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
Cc: Kranthi G <gudishax.kranthikumar@intel.com>, Dharageswari R <dharageswari.r@intel.com>, patches.audio@intel.com, Jayachandran B <jayachandran.b@intel.com>, Ramesh Babu <ramesh.babu@intel.com>, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, GuruprasadX Pawse <guruprasadx.pawse@intel.com>, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

Broxton DSP is mostly similar to Skylake one but with subtle
differences like no Code Load DMA and uses HDA DMA for code
loading, DSP D0 and D3 sequences are different.

These changes are comprehended by adding different DSP power up
and down handlers, and new loader ops and also adding prepare and
trigger which HDA DSP DMA requires

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Jayachandran B <jayachandran.b@intel.com>
Signed-off-by: GuruprasadX Pawse <guruprasadx.pawse@intel.com>
Signed-off-by: Kranthi G <gudishax.kranthikumar@intel.com>
Signed-off-by: Dharageswari R <dharageswari.r@intel.com>
Signed-off-by: Ramesh Babu <ramesh.babu@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/Kconfig                |   1 +
 sound/soc/intel/skylake/Makefile       |   2 +-
 sound/soc/intel/skylake/bxt-sst.c      | 328 +++++++++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-messages.c | 120 ++++++++++++
 sound/soc/intel/skylake/skl-sst-dsp.h  |  13 ++
 5 files changed, 463 insertions(+), 1 deletion(-)
 create mode 100644 sound/soc/intel/skylake/bxt-sst.c

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index cb968da5a308..7b485597643d 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -153,6 +153,7 @@ config SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH
 config SND_SOC_INTEL_SKYLAKE
 	tristate
 	select SND_HDA_EXT_CORE
+	select SND_HDA_DSP_LOADER
 	select SND_SOC_TOPOLOGY
 	select SND_HDA_I915
 	select SND_SOC_INTEL_SST
diff --git a/sound/soc/intel/skylake/Makefile b/sound/soc/intel/skylake/Makefile
index 914b6dab9bea..c28f5d0e1d99 100644
--- a/sound/soc/intel/skylake/Makefile
+++ b/sound/soc/intel/skylake/Makefile
@@ -5,6 +5,6 @@ obj-$(CONFIG_SND_SOC_INTEL_SKYLAKE) += snd-soc-skl.o
 
 # Skylake IPC Support
 snd-soc-skl-ipc-objs := skl-sst-ipc.o skl-sst-dsp.o skl-sst-cldma.o \
-		skl-sst.o
+		skl-sst.o bxt-sst.o
 
 obj-$(CONFIG_SND_SOC_INTEL_SKYLAKE) += snd-soc-skl-ipc.o
diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
new file mode 100644
index 000000000000..965ce40ce752
--- /dev/null
+++ b/sound/soc/intel/skylake/bxt-sst.c
@@ -0,0 +1,328 @@
+/*
+ *  bxt-sst.c - DSP library functions for BXT platform
+ *
+ *  Copyright (C) 2015-16 Intel Corp
+ *  Author:Rafal Redzimski <rafal.f.redzimski@intel.com>
+ *	   Jeeja KP <jeeja.kp@intel.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/firmware.h>
+#include <linux/device.h>
+
+#include "../common/sst-dsp.h"
+#include "../common/sst-dsp-priv.h"
+#include "skl-sst-ipc.h"
+
+#define BXT_BASEFW_TIMEOUT	3000
+#define BXT_INIT_TIMEOUT	500
+#define BXT_IPC_PURGE_FW	0x01004000
+
+#define BXT_ROM_INIT		0x5
+#define BXT_ADSP_SRAM0_BASE	0x80000
+
+/* Firmware status window */
+#define BXT_ADSP_FW_STATUS	BXT_ADSP_SRAM0_BASE
+#define BXT_ADSP_ERROR_CODE     (BXT_ADSP_FW_STATUS + 0x4)
+
+#define BXT_ADSP_SRAM1_BASE	0xA0000
+
+static unsigned int bxt_get_errorcode(struct sst_dsp *ctx)
+{
+	 return sst_dsp_shim_read(ctx, BXT_ADSP_ERROR_CODE);
+}
+
+static int sst_bxt_prepare_fw(struct sst_dsp *ctx,
+			const void *fwdata, u32 fwsize)
+{
+	int stream_tag, ret, i;
+	u32 reg;
+
+	stream_tag = ctx->dsp_ops.prepare(ctx->dev, 0x40, fwsize, &ctx->dmab);
+	if (stream_tag < 0) {
+		dev_err(ctx->dev, "Failed to prepare DMA FW loading err: %x\n",
+				stream_tag);
+		return stream_tag;
+	}
+
+	ctx->dsp_ops.stream_tag = stream_tag;
+	memcpy(ctx->dmab.area, fwdata, fwsize);
+
+	/* Purge FW request */
+	sst_dsp_shim_write(ctx, SKL_ADSP_REG_HIPCI, SKL_ADSP_REG_HIPCI_BUSY |
+					 BXT_IPC_PURGE_FW | (stream_tag - 1));
+
+	ret = skl_dsp_enable_core(ctx);
+	if (ret < 0) {
+		dev_err(ctx->dev, "Boot dsp core failed ret: %d\n", ret);
+		ret = -EIO;
+		goto base_fw_load_failed;
+	}
+
+	for (i = BXT_INIT_TIMEOUT; i > 0; --i) {
+		reg = sst_dsp_shim_read(ctx, SKL_ADSP_REG_HIPCIE);
+
+		if (reg & SKL_ADSP_REG_HIPCIE_DONE) {
+			sst_dsp_shim_update_bits_forced(ctx,
+					SKL_ADSP_REG_HIPCIE,
+					SKL_ADSP_REG_HIPCIE_DONE,
+					SKL_ADSP_REG_HIPCIE_DONE);
+			break;
+		}
+		mdelay(1);
+	}
+	if (!i) {
+		dev_info(ctx->dev, "Waiting for HIPCIE done, reg: 0x%x\n", reg);
+		sst_dsp_shim_update_bits(ctx, SKL_ADSP_REG_HIPCIE,
+				SKL_ADSP_REG_HIPCIE_DONE,
+				SKL_ADSP_REG_HIPCIE_DONE);
+	}
+
+	/* enable Interrupt */
+	skl_ipc_int_enable(ctx);
+	skl_ipc_op_int_enable(ctx);
+
+	for (i = BXT_INIT_TIMEOUT; i > 0; --i) {
+		if (SKL_FW_INIT ==
+				(sst_dsp_shim_read(ctx, BXT_ADSP_FW_STATUS) &
+				SKL_FW_STS_MASK)) {
+
+			dev_info(ctx->dev, "ROM loaded, continue FW loading\n");
+			break;
+		}
+		mdelay(1);
+	}
+	if (!i) {
+		dev_err(ctx->dev, "Timeout for ROM init, HIPCIE: 0x%x\n", reg);
+		ret = -EIO;
+		goto base_fw_load_failed;
+	}
+
+	return ret;
+
+base_fw_load_failed:
+	ctx->dsp_ops.cleanup(ctx->dev, &ctx->dmab, stream_tag);
+	skl_dsp_disable_core(ctx);
+	return ret;
+}
+
+static int sst_transfer_fw_host_dma(struct sst_dsp *ctx)
+{
+	int ret;
+
+	ctx->dsp_ops.trigger(ctx->dev, true, ctx->dsp_ops.stream_tag);
+	ret = sst_dsp_register_poll(ctx, BXT_ADSP_FW_STATUS, SKL_FW_STS_MASK,
+			BXT_ROM_INIT, BXT_BASEFW_TIMEOUT, "Firmware boot");
+
+	ctx->dsp_ops.trigger(ctx->dev, false, ctx->dsp_ops.stream_tag);
+	ctx->dsp_ops.cleanup(ctx->dev, &ctx->dmab, ctx->dsp_ops.stream_tag);
+
+	return ret;
+}
+
+static int bxt_load_base_firmware(struct sst_dsp *ctx)
+{
+	const struct firmware *fw = NULL;
+	struct skl_sst *skl = ctx->thread_context;
+	int ret;
+
+	ret = request_firmware(&fw, ctx->fw_name, ctx->dev);
+	if (ret < 0) {
+		dev_err(ctx->dev, "Request firmware failed %d\n", ret);
+		goto sst_load_base_firmware_failed;
+	}
+
+	ret = sst_bxt_prepare_fw(ctx, fw->data, fw->size);
+	/* Retry Enabling core and ROM load. Retry seemed to help */
+	if (ret < 0) {
+		ret = sst_bxt_prepare_fw(ctx, fw->data, fw->size);
+		if (ret < 0) {
+			dev_err(ctx->dev, "Core En/ROM load fail:%d\n", ret);
+			goto sst_load_base_firmware_failed;
+		}
+	}
+
+	ret = sst_transfer_fw_host_dma(ctx);
+	if (ret < 0) {
+		dev_err(ctx->dev, "Transfer firmware failed %d\n", ret);
+		dev_info(ctx->dev, "Error code=0x%x: FW status=0x%x\n",
+			sst_dsp_shim_read(ctx, BXT_ADSP_ERROR_CODE),
+			sst_dsp_shim_read(ctx, BXT_ADSP_FW_STATUS));
+
+		skl_dsp_disable_core(ctx);
+	} else {
+		dev_dbg(ctx->dev, "Firmware download successful\n");
+		ret = wait_event_timeout(skl->boot_wait, skl->boot_complete,
+					msecs_to_jiffies(SKL_IPC_BOOT_MSECS));
+		if (ret == 0) {
+			dev_err(ctx->dev, "DSP boot fail, FW Ready timeout\n");
+			skl_dsp_disable_core(ctx);
+			ret = -EIO;
+		} else {
+			skl_dsp_set_state_locked(ctx, SKL_DSP_RUNNING);
+			ret = 0;
+		}
+	}
+
+sst_load_base_firmware_failed:
+	release_firmware(fw);
+	return ret;
+}
+
+static int bxt_set_dsp_D0(struct sst_dsp *ctx)
+{
+	struct skl_sst *skl = ctx->thread_context;
+	int ret;
+
+	skl->boot_complete = false;
+
+	ret = skl_dsp_enable_core(ctx);
+	if (ret < 0) {
+		dev_err(ctx->dev, "enable dsp core failed ret: %d\n", ret);
+		return ret;
+	}
+
+	/* enable interrupt */
+	skl_ipc_int_enable(ctx);
+	skl_ipc_op_int_enable(ctx);
+
+	ret = wait_event_timeout(skl->boot_wait, skl->boot_complete,
+					msecs_to_jiffies(SKL_IPC_BOOT_MSECS));
+	if (ret == 0) {
+		dev_err(ctx->dev, "ipc: error DSP boot timeout\n");
+		dev_err(ctx->dev, "Error code=0x%x: FW status=0x%x\n",
+			sst_dsp_shim_read(ctx, BXT_ADSP_ERROR_CODE),
+			sst_dsp_shim_read(ctx, BXT_ADSP_FW_STATUS));
+		return -EIO;
+	}
+
+	skl_dsp_set_state_locked(ctx, SKL_DSP_RUNNING);
+	return 0;
+}
+
+static int bxt_set_dsp_D3(struct sst_dsp *ctx)
+{
+	struct skl_ipc_dxstate_info dx;
+	struct skl_sst *skl = ctx->thread_context;
+	int ret = 0;
+
+	if (!is_skl_dsp_running(ctx))
+		return ret;
+
+	dx.core_mask = SKL_DSP_CORE0_MASK;
+	dx.dx_mask = SKL_IPC_D3_MASK;
+
+	ret = skl_ipc_set_dx(&skl->ipc, SKL_INSTANCE_ID,
+				SKL_BASE_FW_MODULE_ID, &dx);
+	if (ret < 0) {
+		dev_err(ctx->dev, "Failed to set DSP to D3 state: %d\n", ret);
+		return ret;
+	}
+
+	ret = skl_dsp_disable_core(ctx);
+	if (ret < 0) {
+		dev_err(ctx->dev, "disbale dsp core failed: %d\n", ret);
+		ret = -EIO;
+	}
+
+	skl_dsp_set_state_locked(ctx, SKL_DSP_RESET);
+	return 0;
+}
+
+static struct skl_dsp_fw_ops bxt_fw_ops = {
+	.set_state_D0 = bxt_set_dsp_D0,
+	.set_state_D3 = bxt_set_dsp_D3,
+	.load_fw = bxt_load_base_firmware,
+	.get_fw_errcode = bxt_get_errorcode,
+};
+
+static struct sst_ops skl_ops = {
+	.irq_handler = skl_dsp_sst_interrupt,
+	.write = sst_shim32_write,
+	.read = sst_shim32_read,
+	.ram_read = sst_memcpy_fromio_32,
+	.ram_write = sst_memcpy_toio_32,
+	.free = skl_dsp_free,
+};
+
+static struct sst_dsp_device skl_dev = {
+	.thread = skl_dsp_irq_thread_handler,
+	.ops = &skl_ops,
+};
+
+int bxt_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
+			const char *fw_name, struct skl_dsp_loader_ops dsp_ops,
+			struct skl_sst **dsp)
+{
+	struct skl_sst *skl;
+	struct sst_dsp *sst;
+	int ret;
+
+	skl = devm_kzalloc(dev, sizeof(*skl), GFP_KERNEL);
+	if (skl == NULL)
+		return -ENOMEM;
+
+	skl->dev = dev;
+	skl_dev.thread_context = skl;
+
+	skl->dsp = skl_dsp_ctx_init(dev, &skl_dev, irq);
+	if (!skl->dsp) {
+		dev_err(skl->dev, "skl_dsp_ctx_init failed\n");
+		return -ENODEV;
+	}
+
+	sst = skl->dsp;
+	sst->fw_name = fw_name;
+	sst->dsp_ops = dsp_ops;
+	sst->fw_ops = bxt_fw_ops;
+	sst->addr.lpe = mmio_base;
+	sst->addr.shim = mmio_base;
+
+	sst_dsp_mailbox_init(sst, (BXT_ADSP_SRAM0_BASE + SKL_ADSP_W0_STAT_SZ),
+			SKL_ADSP_W0_UP_SZ, BXT_ADSP_SRAM1_BASE, SKL_ADSP_W1_SZ);
+
+	ret = skl_ipc_init(dev, skl);
+	if (ret)
+		return ret;
+
+	skl->boot_complete = false;
+	init_waitqueue_head(&skl->boot_wait);
+
+	ret = sst->fw_ops.load_fw(sst);
+	if (ret < 0) {
+		dev_err(dev, "Load base fw failed: %x", ret);
+		return ret;
+	}
+
+	if (dsp)
+		*dsp = skl;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(bxt_sst_dsp_init);
+
+
+void bxt_sst_dsp_cleanup(struct device *dev, struct skl_sst *ctx)
+{
+	skl_ipc_free(&ctx->ipc);
+	ctx->dsp->cl_dev.ops.cl_cleanup_controller(ctx->dsp);
+
+	if (ctx->dsp->addr.lpe)
+		iounmap(ctx->dsp->addr.lpe);
+
+	ctx->dsp->ops->free(ctx->dsp);
+}
+EXPORT_SYMBOL_GPL(bxt_sst_dsp_cleanup);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Intel Broxton IPC driver");
diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index 79c5089b85d6..e3d149c68bbf 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -72,6 +72,105 @@ static void skl_dsp_enable_notification(struct skl_sst *ctx, bool enable)
 	skl_ipc_set_large_config(&ctx->ipc, &msg, (u32 *)&mask);
 }
 
+static int skl_dsp_setup_spib(struct device *dev, unsigned int size,
+				int stream_tag, int enable)
+{
+	struct hdac_ext_bus *ebus = dev_get_drvdata(dev);
+	struct hdac_bus *bus = ebus_to_hbus(ebus);
+	struct hdac_stream *stream = snd_hdac_get_stream(bus,
+			SNDRV_PCM_STREAM_PLAYBACK, stream_tag);
+	struct hdac_ext_stream *estream;
+
+	if (!stream)
+		return -EINVAL;
+
+	estream = stream_to_hdac_ext_stream(stream);
+	/* enable/disable SPIB for this hdac stream */
+	snd_hdac_ext_stream_spbcap_enable(ebus, enable, stream->index);
+
+	/* set the spib value */
+	snd_hdac_ext_stream_set_spib(ebus, estream, size);
+
+	return 0;
+}
+
+static int skl_dsp_prepare(struct device *dev, unsigned int format,
+			unsigned int size, struct snd_dma_buffer *dmab)
+{
+	struct hdac_ext_bus *ebus = dev_get_drvdata(dev);
+	struct hdac_bus *bus = ebus_to_hbus(ebus);
+	struct hdac_ext_stream *estream;
+	struct hdac_stream *stream;
+	struct snd_pcm_substream substream;
+	int ret;
+
+	if (!bus)
+		return -ENODEV;
+
+	memset(&substream, 0, sizeof(substream));
+	substream.stream = SNDRV_PCM_STREAM_PLAYBACK;
+
+	estream = snd_hdac_ext_stream_assign(ebus, &substream,
+					HDAC_EXT_STREAM_TYPE_HOST);
+	if (!estream)
+		return -ENODEV;
+
+	stream = hdac_stream(estream);
+
+	/* assign decouple host dma channel */
+	ret = snd_hdac_dsp_prepare(stream, format, size, dmab);
+	if (ret < 0)
+		return ret;
+
+	skl_dsp_setup_spib(dev, size, stream->stream_tag, true);
+
+	return stream->stream_tag;
+}
+
+static int skl_dsp_trigger(struct device *dev, bool start, int stream_tag)
+{
+	struct hdac_ext_bus *ebus = dev_get_drvdata(dev);
+	struct hdac_stream *stream;
+	struct hdac_bus *bus = ebus_to_hbus(ebus);
+
+	if (!bus)
+		return -ENODEV;
+
+	stream = snd_hdac_get_stream(bus,
+		SNDRV_PCM_STREAM_PLAYBACK, stream_tag);
+	if (!stream)
+		return -EINVAL;
+
+	snd_hdac_dsp_trigger(stream, start);
+
+	return 0;
+}
+
+static int skl_dsp_cleanup(struct device *dev,
+		struct snd_dma_buffer *dmab, int stream_tag)
+{
+	struct hdac_ext_bus *ebus = dev_get_drvdata(dev);
+	struct hdac_stream *stream;
+	struct hdac_ext_stream *estream;
+	struct hdac_bus *bus = ebus_to_hbus(ebus);
+
+	if (!bus)
+		return -ENODEV;
+
+	stream = snd_hdac_get_stream(bus,
+		SNDRV_PCM_STREAM_PLAYBACK, stream_tag);
+	if (!stream)
+		return -EINVAL;
+
+	estream = stream_to_hdac_ext_stream(stream);
+	skl_dsp_setup_spib(dev, 0, stream_tag, false);
+	snd_hdac_ext_stream_release(estream, HDAC_EXT_STREAM_TYPE_HOST);
+
+	snd_hdac_dsp_cleanup(stream, dmab);
+
+	return 0;
+}
+
 static struct skl_dsp_loader_ops skl_get_loader_ops(void)
 {
 	struct skl_dsp_loader_ops loader_ops;
@@ -84,6 +183,21 @@ static struct skl_dsp_loader_ops skl_get_loader_ops(void)
 	return loader_ops;
 };
 
+static struct skl_dsp_loader_ops bxt_get_loader_ops(void)
+{
+	struct skl_dsp_loader_ops loader_ops;
+
+	memset(&loader_ops, 0, sizeof(loader_ops));
+
+	loader_ops.alloc_dma_buf = skl_alloc_dma_buf;
+	loader_ops.free_dma_buf = skl_free_dma_buf;
+	loader_ops.prepare = skl_dsp_prepare;
+	loader_ops.trigger = skl_dsp_trigger;
+	loader_ops.cleanup = skl_dsp_cleanup;
+
+	return loader_ops;
+};
+
 static const struct skl_dsp_ops dsp_ops[] = {
 	{
 		.id = 0x9d70,
@@ -91,6 +205,12 @@ static const struct skl_dsp_ops dsp_ops[] = {
 		.init = skl_sst_dsp_init,
 		.cleanup = skl_sst_dsp_cleanup
 	},
+	{
+		.id = 0x5a98,
+		.loader_ops = bxt_get_loader_ops,
+		.init = bxt_sst_dsp_init,
+		.cleanup = bxt_sst_dsp_cleanup
+	},
 };
 
 static int skl_get_dsp_ops(int pci_id)
diff --git a/sound/soc/intel/skylake/skl-sst-dsp.h b/sound/soc/intel/skylake/skl-sst-dsp.h
index b6e310d49dd6..ff31e6615251 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.h
+++ b/sound/soc/intel/skylake/skl-sst-dsp.h
@@ -124,10 +124,19 @@ struct skl_dsp_fw_ops {
 };
 
 struct skl_dsp_loader_ops {
+	int stream_tag;
+
 	int (*alloc_dma_buf)(struct device *dev,
 		struct snd_dma_buffer *dmab, size_t size);
 	int (*free_dma_buf)(struct device *dev,
 		struct snd_dma_buffer *dmab);
+	int (*prepare)(struct device *dev, unsigned int format,
+				unsigned int byte_size,
+				struct snd_dma_buffer *bufp);
+	int (*trigger)(struct device *dev, bool start, int stream_tag);
+
+	int (*cleanup)(struct device *dev, struct snd_dma_buffer *dmab,
+				 int stream_tag);
 };
 
 struct skl_load_module_info {
@@ -160,6 +169,10 @@ int skl_dsp_boot(struct sst_dsp *ctx);
 int skl_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 		const char *fw_name, struct skl_dsp_loader_ops dsp_ops,
 		struct skl_sst **dsp);
+int bxt_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
+		const char *fw_name, struct skl_dsp_loader_ops dsp_ops,
+		struct skl_sst **dsp);
 void skl_sst_dsp_cleanup(struct device *dev, struct skl_sst *ctx);
+void bxt_sst_dsp_cleanup(struct device *dev, struct skl_sst *ctx);
 
 #endif /*__SKL_SST_DSP_H__*/
-- 
1.9.1
