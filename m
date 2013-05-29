From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: [PATCH 2/2] dma: Set PAUSE_RESUME capability
	for drivers which support it
Date: Wed, 29 May 2013 13:42:23 +0200
Message-ID: <1369827743-5533-2-git-send-email-lars@metafoo.de>
References: <1369827743-5533-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <1369827743-5533-1-git-send-email-lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Scott Jiang <scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Steven Miao <realmz6-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Set the newly introduced PAUSE_RESUME capability for driver which support
pausing/resuming the DMA stream.

Signed-off-by: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
---
 drivers/dma/amba-pl08x.c    | 1 +
 drivers/dma/at_hdmac.c      | 1 +
 drivers/dma/coh901318.c     | 1 +
 drivers/dma/dw_dmac.c       | 1 +
 drivers/dma/ipu/ipu_idmac.c | 1 +
 drivers/dma/mmp_tdma.c      | 1 +
 drivers/dma/mxs-dma.c       | 1 +
 drivers/dma/omap-dma.c      | 1 +
 drivers/dma/sa11x0-dma.c    | 1 +
 drivers/dma/sirf-dma.c      | 1 +
 drivers/dma/ste_dma40.c     | 1 +
 11 files changed, 11 insertions(+)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 8bad254..fa25199 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -1873,6 +1873,7 @@ static int pl08x_probe(struct amba_device *adev, const struct amba_id *id)
 
 	/* Initialize slave engine */
 	dma_cap_set(DMA_SLAVE, pl08x->slave.cap_mask);
+	dma_cap_set(DMA_PAUSE_RESUME, pl08x->slave.cap_mask);
 	pl08x->slave.dev = &adev->dev;
 	pl08x->slave.device_alloc_chan_resources = pl08x_alloc_chan_resources;
 	pl08x->slave.device_free_chan_resources = pl08x_free_chan_resources;
diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 5ce8936..d7a44a8 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -1431,6 +1431,7 @@ static int __init at_dma_probe(struct platform_device *pdev)
 	dma_cap_set(DMA_MEMCPY, at91sam9rl_config.cap_mask);
 	dma_cap_set(DMA_MEMCPY, at91sam9g45_config.cap_mask);
 	dma_cap_set(DMA_SLAVE, at91sam9g45_config.cap_mask);
+	dma_cap_set(DMA_PAUSE_RESUME, at91sam9g45_config.cap_mask);
 
 	/* get DMA parameters from controller type */
 	plat_dat = at_dma_get_driver_data(pdev);
diff --git a/drivers/dma/coh901318.c b/drivers/dma/coh901318.c
index 3b23061..95ef299 100644
--- a/drivers/dma/coh901318.c
+++ b/drivers/dma/coh901318.c
@@ -2697,6 +2697,7 @@ static int __init coh901318_probe(struct platform_device *pdev)
 
 	dma_cap_zero(base->dma_slave.cap_mask);
 	dma_cap_set(DMA_SLAVE, base->dma_slave.cap_mask);
+	dma_cap_set(DMA_PAUSE_RESUME, base->dma_slave.cap_mask);
 
 	base->dma_slave.device_alloc_chan_resources = coh901318_alloc_chan_resources;
 	base->dma_slave.device_free_chan_resources = coh901318_free_chan_resources;
diff --git a/drivers/dma/dw_dmac.c b/drivers/dma/dw_dmac.c
index 2e5deaa..23d5ea5f 100644
--- a/drivers/dma/dw_dmac.c
+++ b/drivers/dma/dw_dmac.c
@@ -1832,6 +1832,7 @@ static int dw_probe(struct platform_device *pdev)
 
 	dma_cap_set(DMA_MEMCPY, dw->dma.cap_mask);
 	dma_cap_set(DMA_SLAVE, dw->dma.cap_mask);
+	dma_cap_set(DMA_PAUSE_RESUME, dw->dma.cap_mask);
 	if (pdata->is_private)
 		dma_cap_set(DMA_PRIVATE, dw->dma.cap_mask);
 	dw->dma.dev = &pdev->dev;
diff --git a/drivers/dma/ipu/ipu_idmac.c b/drivers/dma/ipu/ipu_idmac.c
index d39c2cd..5a4eabb 100644
--- a/drivers/dma/ipu/ipu_idmac.c
+++ b/drivers/dma/ipu/ipu_idmac.c
@@ -1607,6 +1607,7 @@ static int __init ipu_idmac_init(struct ipu *ipu)
 
 	dma_cap_set(DMA_SLAVE, dma->cap_mask);
 	dma_cap_set(DMA_PRIVATE, dma->cap_mask);
+	dma_cap_set(DMA_PAUSE_RESUME, dma->cap_mask);
 
 	/* Compulsory common fields */
 	dma->dev				= ipu->dev;
diff --git a/drivers/dma/mmp_tdma.c b/drivers/dma/mmp_tdma.c
index 43d5a6c..a296aee 100644
--- a/drivers/dma/mmp_tdma.c
+++ b/drivers/dma/mmp_tdma.c
@@ -572,6 +572,7 @@ static int mmp_tdma_probe(struct platform_device *pdev)
 
 	dma_cap_set(DMA_SLAVE, tdev->device.cap_mask);
 	dma_cap_set(DMA_CYCLIC, tdev->device.cap_mask);
+	dma_cap_set(DMA_PAUSE_RESUME, tdev->device.cap_mask);
 	tdev->device.dev = &pdev->dev;
 	tdev->device.device_alloc_chan_resources =
 					mmp_tdma_alloc_chan_resources;
diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index 7195930..19fe380 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -753,6 +753,7 @@ static int __init mxs_dma_probe(struct platform_device *pdev)
 
 	dma_cap_set(DMA_SLAVE, mxs_dma->dma_device.cap_mask);
 	dma_cap_set(DMA_CYCLIC, mxs_dma->dma_device.cap_mask);
+	dma_cap_set(DMA_PAUSE_RESUME, mxs_dma->dma_device.cap_mask);
 
 	INIT_LIST_HEAD(&mxs_dma->dma_device.channels);
 
diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index ec3fc4f..fe8643b 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -608,6 +608,7 @@ static int omap_dma_probe(struct platform_device *pdev)
 
 	dma_cap_set(DMA_SLAVE, od->ddev.cap_mask);
 	dma_cap_set(DMA_CYCLIC, od->ddev.cap_mask);
+	dma_cap_set(DMA_PAUSE_RESUME, od->ddev.cap_mask);
 	od->ddev.device_alloc_chan_resources = omap_dma_alloc_chan_resources;
 	od->ddev.device_free_chan_resources = omap_dma_free_chan_resources;
 	od->ddev.device_tx_status = omap_dma_tx_status;
diff --git a/drivers/dma/sa11x0-dma.c b/drivers/dma/sa11x0-dma.c
index 461a91a..81eefb3 100644
--- a/drivers/dma/sa11x0-dma.c
+++ b/drivers/dma/sa11x0-dma.c
@@ -942,6 +942,7 @@ static int sa11x0_dma_probe(struct platform_device *pdev)
 
 	dma_cap_set(DMA_SLAVE, d->slave.cap_mask);
 	dma_cap_set(DMA_CYCLIC, d->slave.cap_mask);
+	dma_cap_set(DMA_PAUSE_RESUME, d->slave.cap_mask);
 	d->slave.device_prep_slave_sg = sa11x0_dma_prep_slave_sg;
 	d->slave.device_prep_dma_cyclic = sa11x0_dma_prep_dma_cyclic;
 	ret = sa11x0_dma_init_dmadev(&d->slave, &pdev->dev);
diff --git a/drivers/dma/sirf-dma.c b/drivers/dma/sirf-dma.c
index 1765a0a..163e8e5 100644
--- a/drivers/dma/sirf-dma.c
+++ b/drivers/dma/sirf-dma.c
@@ -687,6 +687,7 @@ static int sirfsoc_dma_probe(struct platform_device *op)
 	dma_cap_set(DMA_CYCLIC, dma->cap_mask);
 	dma_cap_set(DMA_INTERLEAVE, dma->cap_mask);
 	dma_cap_set(DMA_PRIVATE, dma->cap_mask);
+	dma_cap_set(DMA_PAUSE_RESUME, dma->cap_mask);
 
 	for (i = 0; i < dma->chancnt; i++) {
 		schan = &sdma->channels[i];
diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 71bf4ec..c1dc544 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -2918,6 +2918,7 @@ static int __init d40_dmaengine_init(struct d40_base *base,
 	dma_cap_zero(base->dma_slave.cap_mask);
 	dma_cap_set(DMA_SLAVE, base->dma_slave.cap_mask);
 	dma_cap_set(DMA_CYCLIC, base->dma_slave.cap_mask);
+	dma_cap_set(DMA_PAUSE_RESUME, base->dma_slave.cap_mask);
 
 	d40_ops_init(base, &base->dma_slave);
 
-- 
1.8.0
