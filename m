From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH 5/7] ASoC: Intel: Add DMA firmware loading
	support
Date: Mon, 20 Oct 2014 15:06:50 +0100
Message-ID: <1413814012-5619-5-git-send-email-liam.r.girdwood@linux.intel.com>
References: <1413814012-5619-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 23A4D2606EF
 for <alsa-devel@alsa-project.org>; Mon, 20 Oct 2014 16:07:46 +0200 (CEST)
In-Reply-To: <1413814012-5619-1-git-send-email-liam.r.girdwood@linux.intel.com>
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

Add support for DMA to load firmware modules to the DSP memory blocks.
Two DMA engines are supported, DesignWare and Intel MID.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 sound/soc/intel/sst-dsp-priv.h |   4 +
 sound/soc/intel/sst-dsp.c      |   7 ++
 sound/soc/intel/sst-dsp.h      |   7 ++
 sound/soc/intel/sst-firmware.c | 265 ++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 280 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/sst-dsp-priv.h b/sound/soc/intel/sst-dsp-priv.h
index 2a9f0ff..be81b86 100644
--- a/sound/soc/intel/sst-dsp-priv.h
+++ b/sound/soc/intel/sst-dsp-priv.h
@@ -348,6 +348,10 @@ struct sst_mem_block *sst_mem_block_register(struct sst_dsp *dsp, u32 offset,
 	void *private);
 void sst_mem_block_unregister_all(struct sst_dsp *dsp);
 
+/* Create/Free DMA resources */
+int sst_dma_new(struct sst_dsp *sst);
+void sst_dma_free(struct sst_dma *dma);
+
 u32 sst_dsp_get_offset(struct sst_dsp *dsp, u32 offset,
 	enum sst_mem_type type);
 #endif
diff --git a/sound/soc/intel/sst-dsp.c b/sound/soc/intel/sst-dsp.c
index 372c4b8..d0fc685 100644
--- a/sound/soc/intel/sst-dsp.c
+++ b/sound/soc/intel/sst-dsp.c
@@ -367,6 +367,10 @@ struct sst_dsp *sst_dsp_new(struct device *dev,
 	if (err)
 		goto irq_err;
 
+	err = sst_dma_new(sst);
+	if (err)
+		dev_warn(dev, "sst_dma_new failed %d\n", err);
+
 	return sst;
 
 irq_err:
@@ -382,6 +386,9 @@ void sst_dsp_free(struct sst_dsp *sst)
 	free_irq(sst->irq, sst);
 	if (sst->ops->free)
 		sst->ops->free(sst);
+
+	if (sst->dma)
+		sst_dma_free(sst->dma);
 }
 EXPORT_SYMBOL_GPL(sst_dsp_free);
 
diff --git a/sound/soc/intel/sst-dsp.h b/sound/soc/intel/sst-dsp.h
index 3165dfa..17ee923 100644
--- a/sound/soc/intel/sst-dsp.h
+++ b/sound/soc/intel/sst-dsp.h
@@ -245,6 +245,13 @@ void sst_memcpy_fromio_32(struct sst_dsp *sst,
 /* DSP reset & boot */
 void sst_dsp_reset(struct sst_dsp *sst);
 int sst_dsp_boot(struct sst_dsp *sst);
+/* DMA */
+int sst_dsp_dma_get_channel(struct sst_dsp *dsp, int chan_id);
+void sst_dsp_dma_put_channel(struct sst_dsp *dsp);
+int sst_dsp_dma_copyfrom(struct sst_dsp *sst, dma_addr_t dest_addr,
+	dma_addr_t src_addr, size_t size);
+int sst_dsp_dma_copyto(struct sst_dsp *sst, dma_addr_t dest_addr,
+	dma_addr_t src_addr, size_t size);
 
 /* Msg IO */
 void sst_dsp_ipc_msg_tx(struct sst_dsp *dsp, u32 msg);
diff --git a/sound/soc/intel/sst-firmware.c b/sound/soc/intel/sst-firmware.c
index b36843e..684f15d 100644
--- a/sound/soc/intel/sst-firmware.c
+++ b/sound/soc/intel/sst-firmware.c
@@ -23,6 +23,11 @@
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/pci.h>
+#include <linux/acpi.h>
+
+/* supported DMA engine drivers */
+#include <linux/platform_data/dma-dw.h>
+#include <linux/dma/dw.h>
 
 #include <asm/page.h>
 #include <asm/pgtable.h>
@@ -30,8 +35,21 @@
 #include "sst-dsp.h"
 #include "sst-dsp-priv.h"
 
+#define SST_DMA_RESOURCES	2
+#define SST_DSP_DMA_MAX_BURST	0x3
 #define SST_HSW_BLOCK_ANY	0xffffffff
 
+#define SST_HSW_MASK_DMA_ADDR_DSP 0xfff00000
+
+struct sst_dma {
+	struct sst_dsp *sst;
+
+	struct dw_dma_chip *chip;
+
+	struct dma_async_tx_descriptor *desc;
+	struct dma_chan *ch;
+};
+
 static void sst_memcpy32(volatile void __iomem *dest, void *src, u32 bytes)
 {
 	u32 i;
@@ -41,6 +59,60 @@ static void sst_memcpy32(volatile void __iomem *dest, void *src, u32 bytes)
 		memcpy_toio(dest + i, src + i, 4);
 }
 
+static void sst_dma_transfer_complete(void *arg)
+{
+	struct sst_dsp *sst = (struct sst_dsp *)arg;
+
+	dev_dbg(sst->dev, "DMA: callback\n");
+}
+
+static int sst_dsp_dma_copy(struct sst_dsp *sst, dma_addr_t dest_addr,
+	dma_addr_t src_addr, size_t size)
+{
+	struct dma_async_tx_descriptor *desc;
+	struct sst_dma *dma = sst->dma;
+
+	if (dma->ch == NULL) {
+		dev_err(sst->dev, "error: no DMA channel\n");
+		return -ENODEV;
+	}
+
+	dev_dbg(sst->dev, "DMA: src: 0x%lx dest 0x%lx size %zu\n",
+		(unsigned long)src_addr, (unsigned long)dest_addr, size);
+
+	desc = dma->ch->device->device_prep_dma_memcpy(dma->ch, dest_addr,
+		src_addr, size, DMA_CTRL_ACK);
+	if (!desc){
+		dev_err(sst->dev, "error: dma prep memcpy failed\n");
+		return -EINVAL;
+	}
+
+	desc->callback = sst_dma_transfer_complete;
+	desc->callback_param = sst;
+
+	desc->tx_submit(desc);
+	dma_wait_for_async_tx(desc);
+
+	return 0;
+}
+
+/* copy to DSP */
+int sst_dsp_dma_copyto(struct sst_dsp *sst, dma_addr_t dest_addr,
+	dma_addr_t src_addr, size_t size)
+{
+	return sst_dsp_dma_copy(sst, dest_addr | SST_HSW_MASK_DMA_ADDR_DSP,
+			src_addr, size);
+}
+EXPORT_SYMBOL_GPL(sst_dsp_dma_copyto);
+
+/* copy from DSP */
+int sst_dsp_dma_copyfrom(struct sst_dsp *sst, dma_addr_t dest_addr,
+	dma_addr_t src_addr, size_t size)
+{
+	return sst_dsp_dma_copy(sst, dest_addr,
+		src_addr | SST_HSW_MASK_DMA_ADDR_DSP, size);
+}
+EXPORT_SYMBOL_GPL(sst_dsp_dma_copyfrom);
 
 /* remove module from memory - callers hold locks */
 static void block_list_remove(struct sst_dsp *dsp,
@@ -100,6 +172,168 @@ err:
 	return ret;
 }
 
+struct dw_dma_platform_data dw_pdata = {
+	.is_private = 1,
+	.chan_allocation_order = CHAN_ALLOCATION_ASCENDING,
+	.chan_priority = CHAN_PRIORITY_ASCENDING,
+};
+
+static struct dw_dma_chip *dw_probe(struct device *dev, struct resource *mem,
+	int irq)
+{
+	struct dw_dma_chip *chip;
+	int err;
+
+	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return ERR_PTR(-ENOMEM);
+
+	chip->irq = irq;
+	chip->regs = devm_ioremap_resource(dev, mem);
+	if (IS_ERR(chip->regs))
+		return ERR_CAST(chip->regs);
+
+	err = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(31));
+	if (err)
+		return ERR_PTR(err);
+
+	chip->dev = dev;
+	err = dw_dma_probe(chip, &dw_pdata);
+	if (err)
+		return ERR_PTR(err);
+
+	return chip;
+}
+
+static void dw_remove(struct dw_dma_chip *chip)
+{
+	dw_dma_remove(chip);
+}
+
+static bool dma_chan_filter(struct dma_chan *chan, void *param)
+{
+	struct sst_dsp *dsp = (struct sst_dsp *)param;
+
+	return chan->device->dev == dsp->dma_dev;
+}
+
+int sst_dsp_dma_get_channel(struct sst_dsp *dsp, int chan_id)
+{
+	struct sst_dma *dma = dsp->dma;
+	struct dma_slave_config slave;
+	dma_cap_mask_t mask;
+	int ret;
+
+	/* The Intel MID DMA engine driver needs the slave config set but
+	 * Synopsis DMA engine driver safely ignores the slave config */
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+	dma_cap_set(DMA_MEMCPY, mask);
+
+	dma->ch = dma_request_channel(mask, dma_chan_filter, dsp);
+	if (dma->ch == NULL) {
+		dev_err(dsp->dev, "error: DMA request channel failed\n");
+		return -EIO;
+	}
+
+	memset(&slave, 0, sizeof(slave));
+	slave.direction = DMA_MEM_TO_DEV;
+	slave.src_addr_width =
+		slave.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	slave.src_maxburst = slave.dst_maxburst = SST_DSP_DMA_MAX_BURST;
+
+	ret = dmaengine_slave_config(dma->ch, &slave);
+	if (ret) {
+		dev_err(dsp->dev, "error: unable to set DMA slave config %d\n",
+			ret);
+		dma_release_channel(dma->ch);
+		dma->ch = NULL;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(sst_dsp_dma_get_channel);
+
+void sst_dsp_dma_put_channel(struct sst_dsp *dsp)
+{
+	struct sst_dma *dma = dsp->dma;
+
+	if (!dma->ch)
+		return;
+
+	dma_release_channel(dma->ch);
+	dma->ch = NULL;
+}
+EXPORT_SYMBOL_GPL(sst_dsp_dma_put_channel);
+
+int sst_dma_new(struct sst_dsp *sst)
+{
+	struct sst_pdata *sst_pdata = sst->pdata;
+	struct sst_dma *dma;
+	struct resource mem;
+	const char *dma_dev_name;
+	int ret = 0;
+
+	/* configure the correct platform data for whatever DMA engine
+	* is attached to the ADSP IP. */
+	switch (sst->pdata->dma_engine) {
+	case SST_DMA_TYPE_DW:
+		dma_dev_name = "dw_dmac";
+		break;
+	case SST_DMA_TYPE_MID:
+		dma_dev_name = "Intel MID DMA";
+		break;
+	default:
+		dev_err(sst->dev, "error: invalid DMA engine %d\n",
+			sst->pdata->dma_engine);
+		return -EINVAL;
+	}
+
+	dma = devm_kzalloc(sst->dev, sizeof(struct sst_dma), GFP_KERNEL);
+	if (!dma)
+		return -ENOMEM;
+
+	dma->sst = sst;
+
+	memset(&mem, 0, sizeof(mem));
+
+	mem.start = sst->addr.lpe_base + sst_pdata->dma_base;
+	mem.end   = sst->addr.lpe_base + sst_pdata->dma_base + sst_pdata->dma_size - 1;
+	mem.flags = IORESOURCE_MEM;
+
+	/* now register DMA engine device */
+	dma->chip = dw_probe(sst->dma_dev, &mem, sst_pdata->irq);
+	if (IS_ERR(dma->chip)) {
+		dev_err(sst->dev, "error: DMA device register failed\n");
+		ret = PTR_ERR(dma->chip);
+		goto err_dma_dev;
+	}
+
+	sst->dma = dma;
+	sst->fw_use_dma = true;
+	return 0;
+
+err_dma_dev:
+	devm_kfree(sst->dev, dma);
+	return ret;
+}
+EXPORT_SYMBOL(sst_dma_new);
+
+void sst_dma_free(struct sst_dma *dma)
+{
+
+	if (dma == NULL)
+		return;
+
+	if (dma->ch)
+		dma_release_channel(dma->ch);
+
+	if (dma->chip)
+		dw_remove(dma->chip);
+
+}
+EXPORT_SYMBOL(sst_dma_free);
+
 /* create new generic firmware object */
 struct sst_fw *sst_fw_new(struct sst_dsp *dsp, 
 	const struct firmware *fw, void *private)
@@ -130,6 +364,12 @@ struct sst_fw *sst_fw_new(struct sst_dsp *dsp,
 	/* copy FW data to DMA-able memory */
 	memcpy((void *)sst_fw->dma_buf, (void *)fw->data, fw->size);
 
+	if (dsp->fw_use_dma) {
+		err = sst_dsp_dma_get_channel(dsp, 0);
+		if (err < 0)
+			goto chan_err;
+	}
+
 	/* call core specific FW paser to load FW data into DSP */
 	err = dsp->ops->parse_fw(sst_fw);
 	if (err < 0) {
@@ -137,6 +377,9 @@ struct sst_fw *sst_fw_new(struct sst_dsp *dsp,
 		goto parse_err;
 	}
 
+	if (dsp->fw_use_dma)
+		sst_dsp_dma_put_channel(dsp);
+
 	mutex_lock(&dsp->mutex);
 	list_add(&sst_fw->list, &dsp->fw_list);
 	mutex_unlock(&dsp->mutex);
@@ -144,9 +387,13 @@ struct sst_fw *sst_fw_new(struct sst_dsp *dsp,
 	return sst_fw;
 
 parse_err:
-	dma_free_coherent(dsp->dev, sst_fw->size,
+	if (dsp->fw_use_dma)
+		sst_dsp_dma_put_channel(dsp);
+chan_err:
+	dma_free_coherent(dsp->dma_dev, sst_fw->size,
 				sst_fw->dma_buf,
 				sst_fw->dmable_fw_paddr);
+	sst_fw->dma_buf = NULL;
 	kfree(sst_fw);
 	return NULL;
 }
@@ -213,7 +460,8 @@ void sst_fw_free(struct sst_fw *sst_fw)
 	list_del(&sst_fw->list);
 	mutex_unlock(&dsp->mutex);
 
-	dma_free_coherent(dsp->dma_dev, sst_fw->size, sst_fw->dma_buf,
+	if (sst_fw->dma_buf)
+		dma_free_coherent(dsp->dma_dev, sst_fw->size, sst_fw->dma_buf,
 			sst_fw->dmable_fw_paddr);
 	kfree(sst_fw);
 }
@@ -567,7 +815,18 @@ int sst_module_alloc_blocks(struct sst_module *module)
 	}
 
 	/* copy partial module data to blocks */
-	sst_memcpy32(dsp->addr.lpe + data->offset, data->data, data->size);
+	if (dsp->fw_use_dma) {
+		ret = sst_dsp_dma_copyto(dsp,
+			dsp->addr.lpe_base + module->offset,
+			sst_fw->dmable_fw_paddr + module->data_offset,
+			module->size);
+		if (ret < 0) {
+			dev_err(dsp->dev, "error: module copy failed\n");
+			goto err;
+		}
+	} else
+		sst_memcpy32(dsp->addr.lpe + module->offset, module->data,
+			module->size);
 
 	mutex_unlock(&dsp->mutex);
 	return ret;
-- 
1.9.1
