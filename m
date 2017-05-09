From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/2] dmaengine: dw: Remove AVR32 bits from the driver
Date: Tue,  9 May 2017 19:18:37 +0300
Message-ID: <20170509161837.48301-3-andriy.shevchenko@linux.intel.com>
References: <20170509161837.48301-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170509161837.48301-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>, linux-kernel@vger.kernel.org, Haavard Skinnemoen <hskinnemoen@gmail.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, dmaengine@vger.kernel.org, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

AVR32 is gone. Now it's time to clean up the driver by removing
leftovers that was used by AVR32 related code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/dw/Kconfig |   7 +-
 drivers/dma/dw/core.c  | 332 +------------------------------------------------
 drivers/dma/dw/regs.h  |  50 ++------
 include/linux/dma/dw.h |  21 ----
 4 files changed, 14 insertions(+), 396 deletions(-)

diff --git a/drivers/dma/dw/Kconfig b/drivers/dma/dw/Kconfig
index 5a37b9fcf40d..04b9728c1d26 100644
--- a/drivers/dma/dw/Kconfig
+++ b/drivers/dma/dw/Kconfig
@@ -6,17 +6,12 @@ config DW_DMAC_CORE
 	tristate
 	select DMA_ENGINE
 
-config DW_DMAC_BIG_ENDIAN_IO
-	bool
-
 config DW_DMAC
 	tristate "Synopsys DesignWare AHB DMA platform driver"
 	select DW_DMAC_CORE
-	select DW_DMAC_BIG_ENDIAN_IO if AVR32
-	default y if CPU_AT32AP7000
 	help
 	  Support the Synopsys DesignWare AHB DMA controller. This
-	  can be integrated in chips such as the Atmel AT32ap7000.
+	  can be integrated in chips such as the Intel Cherrytrail.
 
 config DW_DMAC_PCI
 	tristate "Synopsys DesignWare AHB DMA PCI driver"
diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index e500950dad82..f43e6dafe446 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -561,92 +561,14 @@ static void dwc_handle_error(struct dw_dma *dw, struct dw_dma_chan *dwc)
 	dwc_descriptor_complete(dwc, bad_desc, true);
 }
 
-/* --------------------- Cyclic DMA API extensions -------------------- */
-
-dma_addr_t dw_dma_get_src_addr(struct dma_chan *chan)
-{
-	struct dw_dma_chan *dwc = to_dw_dma_chan(chan);
-	return channel_readl(dwc, SAR);
-}
-EXPORT_SYMBOL(dw_dma_get_src_addr);
-
-dma_addr_t dw_dma_get_dst_addr(struct dma_chan *chan)
-{
-	struct dw_dma_chan *dwc = to_dw_dma_chan(chan);
-	return channel_readl(dwc, DAR);
-}
-EXPORT_SYMBOL(dw_dma_get_dst_addr);
-
-/* Called with dwc->lock held and all DMAC interrupts disabled */
-static void dwc_handle_cyclic(struct dw_dma *dw, struct dw_dma_chan *dwc,
-		u32 status_block, u32 status_err, u32 status_xfer)
-{
-	unsigned long flags;
-
-	if (status_block & dwc->mask) {
-		void (*callback)(void *param);
-		void *callback_param;
-
-		dev_vdbg(chan2dev(&dwc->chan), "new cyclic period llp 0x%08x\n",
-				channel_readl(dwc, LLP));
-		dma_writel(dw, CLEAR.BLOCK, dwc->mask);
-
-		callback = dwc->cdesc->period_callback;
-		callback_param = dwc->cdesc->period_callback_param;
-
-		if (callback)
-			callback(callback_param);
-	}
-
-	/*
-	 * Error and transfer complete are highly unlikely, and will most
-	 * likely be due to a configuration error by the user.
-	 */
-	if (unlikely(status_err & dwc->mask) ||
-			unlikely(status_xfer & dwc->mask)) {
-		unsigned int i;
-
-		dev_err(chan2dev(&dwc->chan),
-			"cyclic DMA unexpected %s interrupt, stopping DMA transfer\n",
-			status_xfer ? "xfer" : "error");
-
-		spin_lock_irqsave(&dwc->lock, flags);
-
-		dwc_dump_chan_regs(dwc);
-
-		dwc_chan_disable(dw, dwc);
-
-		/* Make sure DMA does not restart by loading a new list */
-		channel_writel(dwc, LLP, 0);
-		channel_writel(dwc, CTL_LO, 0);
-		channel_writel(dwc, CTL_HI, 0);
-
-		dma_writel(dw, CLEAR.BLOCK, dwc->mask);
-		dma_writel(dw, CLEAR.ERROR, dwc->mask);
-		dma_writel(dw, CLEAR.XFER, dwc->mask);
-
-		for (i = 0; i < dwc->cdesc->periods; i++)
-			dwc_dump_lli(dwc, dwc->cdesc->desc[i]);
-
-		spin_unlock_irqrestore(&dwc->lock, flags);
-	}
-
-	/* Re-enable interrupts */
-	channel_set_bit(dw, MASK.BLOCK, dwc->mask);
-}
-
-/* ------------------------------------------------------------------------- */
-
 static void dw_dma_tasklet(unsigned long data)
 {
 	struct dw_dma *dw = (struct dw_dma *)data;
 	struct dw_dma_chan *dwc;
-	u32 status_block;
 	u32 status_xfer;
 	u32 status_err;
 	unsigned int i;
 
-	status_block = dma_readl(dw, RAW.BLOCK);
 	status_xfer = dma_readl(dw, RAW.XFER);
 	status_err = dma_readl(dw, RAW.ERROR);
 
@@ -655,8 +577,7 @@ static void dw_dma_tasklet(unsigned long data)
 	for (i = 0; i < dw->dma.chancnt; i++) {
 		dwc = &dw->chan[i];
 		if (test_bit(DW_DMA_IS_CYCLIC, &dwc->flags))
-			dwc_handle_cyclic(dw, dwc, status_block, status_err,
-					status_xfer);
+			dev_vdbg(dw->dma.dev, "Cyclic xfer is not implemented\n");
 		else if (status_err & (1 << i))
 			dwc_handle_error(dw, dwc);
 		else if (status_xfer & (1 << i))
@@ -1264,255 +1185,6 @@ static void dwc_free_chan_resources(struct dma_chan *chan)
 	dev_vdbg(chan2dev(chan), "%s: done\n", __func__);
 }
 
-/* --------------------- Cyclic DMA API extensions -------------------- */
-
-/**
- * dw_dma_cyclic_start - start the cyclic DMA transfer
- * @chan: the DMA channel to start
- *
- * Must be called with soft interrupts disabled. Returns zero on success or
- * -errno on failure.
- */
-int dw_dma_cyclic_start(struct dma_chan *chan)
-{
-	struct dw_dma_chan	*dwc = to_dw_dma_chan(chan);
-	struct dw_dma		*dw = to_dw_dma(chan->device);
-	unsigned long		flags;
-
-	if (!test_bit(DW_DMA_IS_CYCLIC, &dwc->flags)) {
-		dev_err(chan2dev(&dwc->chan), "missing prep for cyclic DMA\n");
-		return -ENODEV;
-	}
-
-	spin_lock_irqsave(&dwc->lock, flags);
-
-	/* Enable interrupts to perform cyclic transfer */
-	channel_set_bit(dw, MASK.BLOCK, dwc->mask);
-
-	dwc_dostart(dwc, dwc->cdesc->desc[0]);
-
-	spin_unlock_irqrestore(&dwc->lock, flags);
-
-	return 0;
-}
-EXPORT_SYMBOL(dw_dma_cyclic_start);
-
-/**
- * dw_dma_cyclic_stop - stop the cyclic DMA transfer
- * @chan: the DMA channel to stop
- *
- * Must be called with soft interrupts disabled.
- */
-void dw_dma_cyclic_stop(struct dma_chan *chan)
-{
-	struct dw_dma_chan	*dwc = to_dw_dma_chan(chan);
-	struct dw_dma		*dw = to_dw_dma(dwc->chan.device);
-	unsigned long		flags;
-
-	spin_lock_irqsave(&dwc->lock, flags);
-
-	dwc_chan_disable(dw, dwc);
-
-	spin_unlock_irqrestore(&dwc->lock, flags);
-}
-EXPORT_SYMBOL(dw_dma_cyclic_stop);
-
-/**
- * dw_dma_cyclic_prep - prepare the cyclic DMA transfer
- * @chan: the DMA channel to prepare
- * @buf_addr: physical DMA address where the buffer starts
- * @buf_len: total number of bytes for the entire buffer
- * @period_len: number of bytes for each period
- * @direction: transfer direction, to or from device
- *
- * Must be called before trying to start the transfer. Returns a valid struct
- * dw_cyclic_desc if successful or an ERR_PTR(-errno) if not successful.
- */
-struct dw_cyclic_desc *dw_dma_cyclic_prep(struct dma_chan *chan,
-		dma_addr_t buf_addr, size_t buf_len, size_t period_len,
-		enum dma_transfer_direction direction)
-{
-	struct dw_dma_chan		*dwc = to_dw_dma_chan(chan);
-	struct dma_slave_config		*sconfig = &dwc->dma_sconfig;
-	struct dw_cyclic_desc		*cdesc;
-	struct dw_cyclic_desc		*retval = NULL;
-	struct dw_desc			*desc;
-	struct dw_desc			*last = NULL;
-	u8				lms = DWC_LLP_LMS(dwc->dws.m_master);
-	unsigned long			was_cyclic;
-	unsigned int			reg_width;
-	unsigned int			periods;
-	unsigned int			i;
-	unsigned long			flags;
-
-	spin_lock_irqsave(&dwc->lock, flags);
-	if (dwc->nollp) {
-		spin_unlock_irqrestore(&dwc->lock, flags);
-		dev_dbg(chan2dev(&dwc->chan),
-				"channel doesn't support LLP transfers\n");
-		return ERR_PTR(-EINVAL);
-	}
-
-	if (!list_empty(&dwc->queue) || !list_empty(&dwc->active_list)) {
-		spin_unlock_irqrestore(&dwc->lock, flags);
-		dev_dbg(chan2dev(&dwc->chan),
-				"queue and/or active list are not empty\n");
-		return ERR_PTR(-EBUSY);
-	}
-
-	was_cyclic = test_and_set_bit(DW_DMA_IS_CYCLIC, &dwc->flags);
-	spin_unlock_irqrestore(&dwc->lock, flags);
-	if (was_cyclic) {
-		dev_dbg(chan2dev(&dwc->chan),
-				"channel already prepared for cyclic DMA\n");
-		return ERR_PTR(-EBUSY);
-	}
-
-	retval = ERR_PTR(-EINVAL);
-
-	if (unlikely(!is_slave_direction(direction)))
-		goto out_err;
-
-	dwc->direction = direction;
-
-	if (direction == DMA_MEM_TO_DEV)
-		reg_width = __ffs(sconfig->dst_addr_width);
-	else
-		reg_width = __ffs(sconfig->src_addr_width);
-
-	periods = buf_len / period_len;
-
-	/* Check for too big/unaligned periods and unaligned DMA buffer. */
-	if (period_len > (dwc->block_size << reg_width))
-		goto out_err;
-	if (unlikely(period_len & ((1 << reg_width) - 1)))
-		goto out_err;
-	if (unlikely(buf_addr & ((1 << reg_width) - 1)))
-		goto out_err;
-
-	retval = ERR_PTR(-ENOMEM);
-
-	cdesc = kzalloc(sizeof(struct dw_cyclic_desc), GFP_KERNEL);
-	if (!cdesc)
-		goto out_err;
-
-	cdesc->desc = kzalloc(sizeof(struct dw_desc *) * periods, GFP_KERNEL);
-	if (!cdesc->desc)
-		goto out_err_alloc;
-
-	for (i = 0; i < periods; i++) {
-		desc = dwc_desc_get(dwc);
-		if (!desc)
-			goto out_err_desc_get;
-
-		switch (direction) {
-		case DMA_MEM_TO_DEV:
-			lli_write(desc, dar, sconfig->dst_addr);
-			lli_write(desc, sar, buf_addr + period_len * i);
-			lli_write(desc, ctllo, (DWC_DEFAULT_CTLLO(chan)
-				| DWC_CTLL_DST_WIDTH(reg_width)
-				| DWC_CTLL_SRC_WIDTH(reg_width)
-				| DWC_CTLL_DST_FIX
-				| DWC_CTLL_SRC_INC
-				| DWC_CTLL_INT_EN));
-
-			lli_set(desc, ctllo, sconfig->device_fc ?
-					DWC_CTLL_FC(DW_DMA_FC_P_M2P) :
-					DWC_CTLL_FC(DW_DMA_FC_D_M2P));
-
-			break;
-		case DMA_DEV_TO_MEM:
-			lli_write(desc, dar, buf_addr + period_len * i);
-			lli_write(desc, sar, sconfig->src_addr);
-			lli_write(desc, ctllo, (DWC_DEFAULT_CTLLO(chan)
-				| DWC_CTLL_SRC_WIDTH(reg_width)
-				| DWC_CTLL_DST_WIDTH(reg_width)
-				| DWC_CTLL_DST_INC
-				| DWC_CTLL_SRC_FIX
-				| DWC_CTLL_INT_EN));
-
-			lli_set(desc, ctllo, sconfig->device_fc ?
-					DWC_CTLL_FC(DW_DMA_FC_P_P2M) :
-					DWC_CTLL_FC(DW_DMA_FC_D_P2M));
-
-			break;
-		default:
-			break;
-		}
-
-		lli_write(desc, ctlhi, period_len >> reg_width);
-		cdesc->desc[i] = desc;
-
-		if (last)
-			lli_write(last, llp, desc->txd.phys | lms);
-
-		last = desc;
-	}
-
-	/* Let's make a cyclic list */
-	lli_write(last, llp, cdesc->desc[0]->txd.phys | lms);
-
-	dev_dbg(chan2dev(&dwc->chan),
-			"cyclic prepared buf %pad len %zu period %zu periods %d\n",
-			&buf_addr, buf_len, period_len, periods);
-
-	cdesc->periods = periods;
-	dwc->cdesc = cdesc;
-
-	return cdesc;
-
-out_err_desc_get:
-	while (i--)
-		dwc_desc_put(dwc, cdesc->desc[i]);
-out_err_alloc:
-	kfree(cdesc);
-out_err:
-	clear_bit(DW_DMA_IS_CYCLIC, &dwc->flags);
-	return (struct dw_cyclic_desc *)retval;
-}
-EXPORT_SYMBOL(dw_dma_cyclic_prep);
-
-/**
- * dw_dma_cyclic_free - free a prepared cyclic DMA transfer
- * @chan: the DMA channel to free
- */
-void dw_dma_cyclic_free(struct dma_chan *chan)
-{
-	struct dw_dma_chan	*dwc = to_dw_dma_chan(chan);
-	struct dw_dma		*dw = to_dw_dma(dwc->chan.device);
-	struct dw_cyclic_desc	*cdesc = dwc->cdesc;
-	unsigned int		i;
-	unsigned long		flags;
-
-	dev_dbg(chan2dev(&dwc->chan), "%s\n", __func__);
-
-	if (!cdesc)
-		return;
-
-	spin_lock_irqsave(&dwc->lock, flags);
-
-	dwc_chan_disable(dw, dwc);
-
-	dma_writel(dw, CLEAR.BLOCK, dwc->mask);
-	dma_writel(dw, CLEAR.ERROR, dwc->mask);
-	dma_writel(dw, CLEAR.XFER, dwc->mask);
-
-	spin_unlock_irqrestore(&dwc->lock, flags);
-
-	for (i = 0; i < cdesc->periods; i++)
-		dwc_desc_put(dwc, cdesc->desc[i]);
-
-	kfree(cdesc->desc);
-	kfree(cdesc);
-
-	dwc->cdesc = NULL;
-
-	clear_bit(DW_DMA_IS_CYCLIC, &dwc->flags);
-}
-EXPORT_SYMBOL(dw_dma_cyclic_free);
-
-/*----------------------------------------------------------------------*/
-
 int dw_dma_probe(struct dw_dma_chip *chip)
 {
 	struct dw_dma_platform_data *pdata;
@@ -1642,7 +1314,7 @@ int dw_dma_probe(struct dw_dma_chip *chip)
 		if (autocfg) {
 			unsigned int r = DW_DMA_MAX_NR_CHANNELS - i - 1;
 			void __iomem *addr = &__dw_regs(dw)->DWC_PARAMS[r];
-			unsigned int dwc_params = dma_readl_native(addr);
+			unsigned int dwc_params = readl(addr);
 
 			dev_dbg(chip->dev, "DWC_PARAMS[%d]: 0x%08x\n", i,
 					   dwc_params);
diff --git a/drivers/dma/dw/regs.h b/drivers/dma/dw/regs.h
index 32a328721c88..09e7dfdbb790 100644
--- a/drivers/dma/dw/regs.h
+++ b/drivers/dma/dw/regs.h
@@ -116,20 +116,6 @@ struct dw_dma_regs {
 	DW_REG(GLOBAL_CFG);
 };
 
-/*
- * Big endian I/O access when reading and writing to the DMA controller
- * registers.  This is needed on some platforms, like the Atmel AVR32
- * architecture.
- */
-
-#ifdef CONFIG_DW_DMAC_BIG_ENDIAN_IO
-#define dma_readl_native ioread32be
-#define dma_writel_native iowrite32be
-#else
-#define dma_readl_native readl
-#define dma_writel_native writel
-#endif
-
 /* Bitfields in DW_PARAMS */
 #define DW_PARAMS_NR_CHAN	8		/* number of channels */
 #define DW_PARAMS_NR_MASTER	11		/* number of AHB masters */
@@ -280,7 +266,6 @@ struct dw_dma_chan {
 	unsigned long		flags;
 	struct list_head	active_list;
 	struct list_head	queue;
-	struct dw_cyclic_desc	*cdesc;
 
 	unsigned int		descs_allocated;
 
@@ -302,9 +287,9 @@ __dwc_regs(struct dw_dma_chan *dwc)
 }
 
 #define channel_readl(dwc, name) \
-	dma_readl_native(&(__dwc_regs(dwc)->name))
+	readl(&(__dwc_regs(dwc)->name))
 #define channel_writel(dwc, name, val) \
-	dma_writel_native((val), &(__dwc_regs(dwc)->name))
+	writel((val), &(__dwc_regs(dwc)->name))
 
 static inline struct dw_dma_chan *to_dw_dma_chan(struct dma_chan *chan)
 {
@@ -333,9 +318,9 @@ static inline struct dw_dma_regs __iomem *__dw_regs(struct dw_dma *dw)
 }
 
 #define dma_readl(dw, name) \
-	dma_readl_native(&(__dw_regs(dw)->name))
+	readl(&(__dw_regs(dw)->name))
 #define dma_writel(dw, name, val) \
-	dma_writel_native((val), &(__dw_regs(dw)->name))
+	writel((val), &(__dw_regs(dw)->name))
 
 #define idma32_readq(dw, name)				\
 	hi_lo_readq(&(__dw_regs(dw)->name))
@@ -352,43 +337,30 @@ static inline struct dw_dma *to_dw_dma(struct dma_device *ddev)
 	return container_of(ddev, struct dw_dma, dma);
 }
 
-#ifdef CONFIG_DW_DMAC_BIG_ENDIAN_IO
-typedef __be32 __dw32;
-#else
-typedef __le32 __dw32;
-#endif
-
 /* LLI == Linked List Item; a.k.a. DMA block descriptor */
 struct dw_lli {
 	/* values that are not changed by hardware */
-	__dw32		sar;
-	__dw32		dar;
-	__dw32		llp;		/* chain to next lli */
-	__dw32		ctllo;
+	__le32		sar;
+	__le32		dar;
+	__le32		llp;		/* chain to next lli */
+	__le32		ctllo;
 	/* values that may get written back: */
-	__dw32		ctlhi;
+	__le32		ctlhi;
 	/* sstat and dstat can snapshot peripheral register state.
 	 * silicon config may discard either or both...
 	 */
-	__dw32		sstat;
-	__dw32		dstat;
+	__le32		sstat;
+	__le32		dstat;
 };
 
 struct dw_desc {
 	/* FIRST values the hardware uses */
 	struct dw_lli			lli;
 
-#ifdef CONFIG_DW_DMAC_BIG_ENDIAN_IO
-#define lli_set(d, reg, v)		((d)->lli.reg |= cpu_to_be32(v))
-#define lli_clear(d, reg, v)		((d)->lli.reg &= ~cpu_to_be32(v))
-#define lli_read(d, reg)		be32_to_cpu((d)->lli.reg)
-#define lli_write(d, reg, v)		((d)->lli.reg = cpu_to_be32(v))
-#else
 #define lli_set(d, reg, v)		((d)->lli.reg |= cpu_to_le32(v))
 #define lli_clear(d, reg, v)		((d)->lli.reg &= ~cpu_to_le32(v))
 #define lli_read(d, reg)		le32_to_cpu((d)->lli.reg)
 #define lli_write(d, reg, v)		((d)->lli.reg = cpu_to_le32(v))
-#endif
 
 	/* THEN values for driver housekeeping */
 	struct list_head		desc_node;
diff --git a/include/linux/dma/dw.h b/include/linux/dma/dw.h
index b63b25814d77..e166cac8e870 100644
--- a/include/linux/dma/dw.h
+++ b/include/linux/dma/dw.h
@@ -50,25 +50,4 @@ static inline int dw_dma_probe(struct dw_dma_chip *chip) { return -ENODEV; }
 static inline int dw_dma_remove(struct dw_dma_chip *chip) { return 0; }
 #endif /* CONFIG_DW_DMAC_CORE */
 
-/* DMA API extensions */
-struct dw_desc;
-
-struct dw_cyclic_desc {
-	struct dw_desc	**desc;
-	unsigned long	periods;
-	void		(*period_callback)(void *param);
-	void		*period_callback_param;
-};
-
-struct dw_cyclic_desc *dw_dma_cyclic_prep(struct dma_chan *chan,
-		dma_addr_t buf_addr, size_t buf_len, size_t period_len,
-		enum dma_transfer_direction direction);
-void dw_dma_cyclic_free(struct dma_chan *chan);
-int dw_dma_cyclic_start(struct dma_chan *chan);
-void dw_dma_cyclic_stop(struct dma_chan *chan);
-
-dma_addr_t dw_dma_get_src_addr(struct dma_chan *chan);
-
-dma_addr_t dw_dma_get_dst_addr(struct dma_chan *chan);
-
 #endif /* _DMA_DW_H */
-- 
2.11.0
