From: miguel.aguilar@ridgerun.com
Subject: [PATCH 1/5] MFD: DaVinci Voice Codec
Date: Thu, 21 Jan 2010 11:39:44 -0600
Message-ID: <1264095584-765-1-git-send-email-miguel.aguilar@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.navvo.net (mail.navvo.net [74.208.67.6])
	by alsa0.perex.cz (Postfix) with ESMTP id 613B8103865
	for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2010 18:39:52 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: davinci-linux-open-source@linux.davincidsp.com
Cc: alsa-devel@alsa-project.org, clark.becker@ridgerun.com, nsekhar@ti.com, broonie@opensource.wolfsonmicro.com, diego.dompe@ridgerun.com, nsnehaprabha@ti.com, todd.fischer@ridgerun.com, Miguel Aguilar <miguel.aguilar@ridgerun.com>
List-Id: alsa-devel@alsa-project.org

From: Miguel Aguilar <miguel.aguilar@ridgerun.com>

This is the MFD driver for the DaVinci Voice codec, it has two clients:

* Voice codec interface
* Voice codec CQ93VC

Signed-off-by: Miguel Aguilar <miguel.aguilar@ridgerun.com>
---
 drivers/mfd/Kconfig                    |    4 +
 drivers/mfd/Makefile                   |    1 +
 drivers/mfd/davinci_voicecodec.c       |  189 ++++++++++++++++++++++++++++++++
 include/linux/mfd/davinci_voicecodec.h |  126 +++++++++++++++++++++
 4 files changed, 320 insertions(+), 0 deletions(-)
 create mode 100644 drivers/mfd/davinci_voicecodec.c
 create mode 100644 include/linux/mfd/davinci_voicecodec.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 8782978..6e93c0b 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -43,6 +43,10 @@ config MFD_SH_MOBILE_SDHI
 	  This driver supports the SDHI hardware block found in many
 	  SuperH Mobile SoCs.
 
+config MFD_DAVINCI_VOICECODEC
+	tristate
+	select MFD_CORE
+
 config MFD_DM355EVM_MSP
 	bool "DaVinci DM355 EVM microcontroller"
 	depends on I2C && MACH_DAVINCI_DM355_EVM
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index ca2f2c4..f5c617f 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_MFD_SH_MOBILE_SDHI)		+= sh_mobile_sdhi.o
 obj-$(CONFIG_HTC_EGPIO)		+= htc-egpio.o
 obj-$(CONFIG_HTC_PASIC3)	+= htc-pasic3.o
 
+obj-$(CONFIG_MFD_DAVINCI_VOICECODEC)	+= davinci_voicecodec.o
 obj-$(CONFIG_MFD_DM355EVM_MSP)	+= dm355evm_msp.o
 
 obj-$(CONFIG_MFD_T7L66XB)	+= t7l66xb.o
diff --git a/drivers/mfd/davinci_voicecodec.c b/drivers/mfd/davinci_voicecodec.c
new file mode 100644
index 0000000..9886aa8
--- /dev/null
+++ b/drivers/mfd/davinci_voicecodec.c
@@ -0,0 +1,189 @@
+/*
+ * DaVinci Voice Codec Core Interface for TI platforms
+ *
+ * Copyright (C) 2010 Texas Instruments, Inc
+ *
+ * Author: Miguel Aguilar <miguel.aguilar@ridgerun.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/clk.h>
+
+#include <sound/pcm.h>
+
+#include <linux/mfd/davinci_voicecodec.h>
+
+u32 davinci_vc_read(struct davinci_vc *davinci_vc, int reg)
+{
+	return __raw_readl(davinci_vc->base + reg);
+}
+
+void davinci_vc_write(struct davinci_vc *davinci_vc,
+					   int reg, u32 val)
+{
+	__raw_writel(val, davinci_vc->base + reg);
+}
+
+static int __init davinci_vc_probe(struct platform_device *pdev)
+{
+	struct davinci_vc *davinci_vc;
+	struct resource *res, *mem;
+	struct mfd_cell *cell = NULL;
+	int ret;
+
+	davinci_vc = kzalloc(sizeof(struct davinci_vc), GFP_KERNEL);
+	if (!davinci_vc) {
+		dev_dbg(&pdev->dev,
+			    "could not allocate memory for private data\n");
+		return -ENOMEM;
+	}
+
+	davinci_vc->clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR(davinci_vc->clk)) {
+		dev_dbg(&pdev->dev,
+			    "could not get the clock for voice codec\n");
+		ret = -ENODEV;
+		goto fail1;
+	}
+	clk_enable(davinci_vc->clk);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "no mem resource\n");
+		ret = -ENODEV;
+		goto fail2;
+	}
+
+	davinci_vc->pbase = res->start;
+	davinci_vc->base_size = resource_size(res);
+
+	mem = request_mem_region(davinci_vc->pbase, davinci_vc->base_size,
+				 pdev->name);
+	if (!mem) {
+		dev_err(&pdev->dev, "VCIF region already claimed\n");
+		ret = -EBUSY;
+		goto fail2;
+	}
+
+	davinci_vc->base = ioremap(davinci_vc->pbase, davinci_vc->base_size);
+	if (!davinci_vc->base) {
+		dev_err(&pdev->dev, "can't ioremap mem resource.\n");
+		ret = -ENOMEM;
+		goto fail3;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "no DMA resource\n");
+		return -ENXIO;
+	}
+
+	davinci_vc->davinci_vcif.dma_tx_channel = res->start;
+	davinci_vc->davinci_vcif.dma_tx_addr =
+		(dma_addr_t)(io_v2p(davinci_vc->base) + DAVINCI_VC_WFIFO);
+
+	res = platform_get_resource(pdev, IORESOURCE_DMA, 1);
+	if (!res) {
+		dev_err(&pdev->dev, "no DMA resource\n");
+		return -ENXIO;
+	}
+
+	davinci_vc->davinci_vcif.dma_rx_channel = res->start;
+	davinci_vc->davinci_vcif.dma_rx_addr =
+		(dma_addr_t)(io_v2p(davinci_vc->base) + DAVINCI_VC_RFIFO);
+
+	davinci_vc->dev = &pdev->dev;
+	davinci_vc->pdev = pdev;
+
+	/* Voice codec interface client */
+	cell = &davinci_vc->cells[DAVINCI_VC_VCIF_CELL];
+	cell->name = "davinci_vcif";
+	cell->driver_data = davinci_vc;
+
+	/* Voice codec CQ93VC client */
+	cell = &davinci_vc->cells[DAVINCI_VC_CQ93VC_CELL];
+	cell->name = "cq93vc";
+	cell->driver_data = davinci_vc;
+
+	ret = mfd_add_devices(&pdev->dev, pdev->id, davinci_vc->cells,
+			      DAVINCI_VC_CELLS, NULL, 0);
+	if (ret != 0) {
+		dev_err(&pdev->dev, "fail to register client devices\n");
+		goto fail4;
+	}
+
+	return 0;
+
+fail4:
+	iounmap(davinci_vc->base);
+fail3:
+	release_mem_region(davinci_vc->pbase, davinci_vc->base_size);
+fail2:
+	clk_disable(davinci_vc->clk);
+	clk_put(davinci_vc->clk);
+	davinci_vc->clk = NULL;
+fail1:
+	kfree(davinci_vc);
+
+	return ret;
+}
+
+static int __devexit davinci_vc_remove(struct platform_device *pdev)
+{
+	struct davinci_vc *davinci_vc = platform_get_drvdata(pdev);
+
+	mfd_remove_devices(&pdev->dev);
+
+	iounmap(davinci_vc->base);
+	release_mem_region(davinci_vc->pbase, davinci_vc->base_size);
+
+	clk_disable(davinci_vc->clk);
+	clk_put(davinci_vc->clk);
+	davinci_vc->clk = NULL;
+
+	kfree(davinci_vc);
+
+	return 0;
+}
+
+static struct platform_driver davinci_vc_driver = {
+	.driver	= {
+		.name = "davinci_voicecodec",
+		.owner = THIS_MODULE,
+	},
+	.remove	= __devexit_p(davinci_vc_remove),
+};
+
+static int __init davinci_vc_init(void)
+{
+	return platform_driver_probe(&davinci_vc_driver, davinci_vc_probe);
+}
+module_init(davinci_vc_init);
+
+static void __exit davinci_vc_exit(void)
+{
+	platform_driver_unregister(&davinci_vc_driver);
+}
+module_exit(davinci_vc_exit);
+
+MODULE_AUTHOR("Miguel Aguilar");
+MODULE_DESCRIPTION("Texas Instruments DaVinci Voice Codec Core Interface");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/davinci_voicecodec.h b/include/linux/mfd/davinci_voicecodec.h
new file mode 100644
index 0000000..0ab6132
--- /dev/null
+++ b/include/linux/mfd/davinci_voicecodec.h
@@ -0,0 +1,126 @@
+/*
+ * DaVinci Voice Codec Core Interface for TI platforms
+ *
+ * Copyright (C) 2010 Texas Instruments, Inc
+ *
+ * Author: Miguel Aguilar <miguel.aguilar@ridgerun.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#ifndef __LINUX_MFD_DAVINCI_VOICECODEC_H_
+#define __LINUX_MFD_DAVINIC_VOICECODEC_H_
+
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/mfd/core.h>
+
+#include <mach/edma.h>
+
+/*
+ * Register values.
+ */
+#define DAVINCI_VC_PID			0x00
+#define DAVINCI_VC_CTRL			0x04
+#define DAVINCI_VC_INTEN		0x08
+#define DAVINCI_VC_INTSTATUS		0x0c
+#define DAVINCI_VC_INTCLR		0x10
+#define DAVINCI_VC_EMUL_CTRL		0x14
+#define DAVINCI_VC_RFIFO		0x20
+#define DAVINCI_VC_WFIFO		0x24
+#define DAVINCI_VC_FIFOSTAT		0x28
+#define DAVINCI_VC_TST_CTRL		0x2C
+#define DAVINCI_VC_REG05		0x94
+#define DAVINCI_VC_REG09		0xA4
+#define DAVINCI_VC_REG12		0xB0
+
+/* DAVINCI_VC_CTRL bit fields */
+#define DAVINCI_VC_CTRL_MASK		0x5500
+#define DAVINCI_VC_CTRL_RSTADC		BIT(0)
+#define DAVINCI_VC_CTRL_RSTDAC		BIT(1)
+#define DAVINCI_VC_CTRL_RD_BITS_8	BIT(4)
+#define DAVINCI_VC_CTRL_RD_UNSIGNED	BIT(5)
+#define DAVINCI_VC_CTRL_WD_BITS_8	BIT(6)
+#define DAVINCI_VC_CTRL_WD_UNSIGNED	BIT(7)
+#define DAVINCI_VC_CTRL_RFIFOEN		BIT(8)
+#define DAVINCI_VC_CTRL_RFIFOCL		BIT(9)
+#define DAVINCI_VC_CTRL_RFIFOMD_WORD_1	BIT(10)
+#define DAVINCI_VC_CTRL_WFIFOEN		BIT(12)
+#define DAVINCI_VC_CTRL_WFIFOCL		BIT(13)
+#define DAVINCI_VC_CTRL_WFIFOMD_WORD_1	BIT(14)
+
+/* DAVINCI_VC_INT bit fields */
+#define DAVINCI_VC_INT_MASK		0x3F
+#define DAVINCI_VC_INT_RDRDY_MASK	BIT(0)
+#define DAVINCI_VC_INT_RERROVF_MASK	BIT(1)
+#define DAVINCI_VC_INT_RERRUDR_MASK	BIT(2)
+#define DAVINCI_VC_INT_WDREQ_MASK	BIT(3)
+#define DAVINCI_VC_INT_WERROVF_MASKBIT	BIT(4)
+#define DAVINCI_VC_INT_WERRUDR_MASK	BIT(5)
+
+/* DAVINCI_VC_REG05 bit fields */
+#define DAVINCI_VC_REG05_PGA_GAIN	0x07
+
+/* DAVINCI_VC_REG09 bit fields */
+#define DAVINCI_VC_REG09_MUTE		0x40
+#define DAVINCI_VC_REG09_DIG_ATTEN	0x3F
+
+/* DAVINCI_VC_REG12 bit fields */
+#define DAVINCI_VC_REG12_POWER_ALL_ON	0xFD
+#define DAVINCI_VC_REG12_POWER_ALL_OFF	0x00
+
+#define DAVINCI_VC_CELLS		2
+
+enum davinci_vc_cells {
+	DAVINCI_VC_VCIF_CELL,
+	DAVINCI_VC_CQ93VC_CELL,
+};
+
+struct davinci_vcif {
+	struct platform_device	*pdev;
+	u32 dma_tx_channel;
+	u32 dma_rx_channel;
+	dma_addr_t dma_tx_addr;
+	dma_addr_t dma_rx_addr;
+};
+
+struct cq93vc {
+	struct platform_device *pdev;
+	struct snd_soc_codec *codec;
+	u32 sysclk;
+};
+
+struct davinci_vc;
+
+struct davinci_vc {
+	/* Device data */
+	struct device *dev;
+	struct platform_device *pdev;
+	struct clk *clk;
+
+	/* Memory resources */
+	void __iomem *base;
+	resource_size_t pbase;
+	size_t base_size;
+
+	/* MFD cells */
+	struct mfd_cell cells[DAVINCI_VC_CELLS];
+
+	/* Client devices */
+	struct davinci_vcif davinci_vcif;
+	struct cq93vc cq93vc;
+};
+
+#endif
-- 
1.6.0.4
