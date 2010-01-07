From: miguel.aguilar@ridgerun.com
Subject: [PATCH 1/2] ASoC: DaVinci: Voice Codec Support
Date: Thu,  7 Jan 2010 16:18:11 -0600
Message-ID: <1262902691-15059-1-git-send-email-miguel.aguilar@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.navvo.net (mail.navvo.net [74.208.67.6])
	by alsa0.perex.cz (Postfix) with ESMTP id 76FC92442A
	for <alsa-devel@alsa-project.org>; Thu,  7 Jan 2010 23:18:25 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: davinci-linux-open-source@linux.davincidsp.com, nsnehaprabha@ti.com
Cc: alsa-devel@alsa-project.org, clark.becker@ridgerun.com, santiago.nunez@ridgerun.com, diego.dompe@ridgerun.com, todd.fischer@ridgerun.com, Miguel Aguilar <miguel.aguilar@ridgerun.com>
List-Id: alsa-devel@alsa-project.org

From: Miguel Aguilar <miguel.aguilar@ridgerun.com>

There are two clients for the MFD driver:
* Voice Codec Interface.
* Voice Codec itself, CQ0093.

Signed-off-by: Miguel Aguilar <miguel.aguilar@ridgerun.com>
---
 drivers/mfd/Kconfig                    |    5 +
 drivers/mfd/Makefile                   |    1 +
 drivers/mfd/davinci_voicecodec.c       |  216 ++++++++++++++++++++
 include/linux/mfd/davinci_voicecodec.h |  113 +++++++++++
 sound/soc/codecs/Kconfig               |    4 +
 sound/soc/codecs/Makefile              |    2 +
 sound/soc/codecs/cq93vc.c              |  342 ++++++++++++++++++++++++++++++++
 sound/soc/codecs/cq93vc.h              |   29 +++
 sound/soc/davinci/Kconfig              |   10 +-
 sound/soc/davinci/Makefile             |    2 +
 sound/soc/davinci/davinci-vcif.h       |   28 +++
 11 files changed, 750 insertions(+), 2 deletions(-)
 create mode 100644 drivers/mfd/davinci_voicecodec.c
 create mode 100644 include/linux/mfd/davinci_voicecodec.h
 create mode 100644 sound/soc/codecs/cq93vc.c
 create mode 100644 sound/soc/codecs/cq93vc.h
 create mode 100644 sound/soc/davinci/davinci-vcif.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 8782978..efeba26 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -43,6 +43,11 @@ config MFD_SH_MOBILE_SDHI
 	  This driver supports the SDHI hardware block found in many
 	  SuperH Mobile SoCs.
 
+config MFD_DAVINCI_VOICECODEC
+	bool "DaVinci Voice Codec"
+	help
+	 This driver supports the DaVinci voice codec and its interface.
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
index 0000000..94dbeaa
--- /dev/null
+++ b/drivers/mfd/davinci_voicecodec.c
@@ -0,0 +1,216 @@
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
+#include <linux/mfd/core.h>
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
+static int davinci_vc_client_dev_register(struct davinci_vc *davinci_vc,
+				       const char *name,
+				       struct platform_device **pdev)
+{
+	int ret;
+
+	*pdev = platform_device_alloc(name, -1);
+	if (pdev == NULL) {
+		dev_err(davinci_vc->dev, "failed to allocate %s\n", name);
+		return -ENODEV;
+	}
+
+	(*pdev)->dev.parent = davinci_vc->dev;
+	platform_set_drvdata(*pdev, davinci_vc);
+	ret = platform_device_add(*pdev);
+	if (ret != 0) {
+		dev_err(davinci_vc->dev, "failed to register %s: %d\n", name,
+			ret);
+		platform_device_put(*pdev);
+		*pdev = NULL;
+		return ret;
+	}
+
+	return 0;
+}
+
+static int __init davinci_vc_probe(struct platform_device *pdev)
+{
+	struct davinci_vc *davinci_vc;
+	struct resource *res, *mem;
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
+
+	/* Register voice codec interface */
+	ret = davinci_vc_client_dev_register(davinci_vc, "davinci_vcif",
+				       &(davinci_vc->davinci_vcif.pdev));
+	if (ret != 0) {
+		dev_err(&pdev->dev, "fail to register client device\n");
+		goto fail4;
+	}
+
+	/* Register voice codec */
+	ret = davinci_vc_client_dev_register(davinci_vc, "cq93vc",
+				       &(davinci_vc->cq93vc.pdev));
+	if (ret != 0) {
+		dev_err(&pdev->dev, "fail to register client device\n");
+		goto fail5;
+	}
+
+	return 0;
+
+fail5:
+	platform_device_unregister(davinci_vc->davinci_vcif.pdev);
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
+	platform_device_unregister(davinci_vc->cq93vc.pdev);
+	platform_device_unregister(davinci_vc->davinci_vcif.pdev);
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
index 0000000..6a1757a
--- /dev/null
+++ b/include/linux/mfd/davinci_voicecodec.h
@@ -0,0 +1,113 @@
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
+	struct clk *clk;
+
+	/* Memory resources */
+	void __iomem *base;
+	resource_size_t pbase;
+	size_t base_size;
+
+	/* Client devices */
+	struct davinci_vcif davinci_vcif;
+	struct cq93vc cq93vc;
+};
+
+#endif
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 52b005f..a759d06 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -21,6 +21,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_AK4535 if I2C
 	select SND_SOC_AK4642 if I2C
 	select SND_SOC_AK4671 if I2C
+	select SND_SOC_CQ0093VC
 	select SND_SOC_CS4270 if I2C
 	select SND_SOC_MAX9877 if I2C
 	select SND_SOC_PCM3008
@@ -108,6 +109,9 @@ config SND_SOC_AK4642
 config SND_SOC_AK4671
 	tristate
 
+config SND_SOC_CQ0093VC
+	tristate
+
 # Cirrus Logic CS4270 Codec
 config SND_SOC_CS4270
 	tristate
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index dbaecb1..674db53 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -8,6 +8,7 @@ snd-soc-ak4104-objs := ak4104.o
 snd-soc-ak4535-objs := ak4535.o
 snd-soc-ak4642-objs := ak4642.o
 snd-soc-ak4671-objs := ak4671.o
+snd-soc-cq93vc-objs := cq93vc.o
 snd-soc-cs4270-objs := cs4270.o
 snd-soc-cx20442-objs := cx20442.o
 snd-soc-l3-objs := l3.o
@@ -64,6 +65,7 @@ obj-$(CONFIG_SND_SOC_AK4104)	+= snd-soc-ak4104.o
 obj-$(CONFIG_SND_SOC_AK4535)	+= snd-soc-ak4535.o
 obj-$(CONFIG_SND_SOC_AK4642)	+= snd-soc-ak4642.o
 obj-$(CONFIG_SND_SOC_AK4671)	+= snd-soc-ak4671.o
+obj-$(CONFIG_SND_SOC_CQ0093VC)	+= snd-soc-cq93vc.o
 obj-$(CONFIG_SND_SOC_CS4270)	+= snd-soc-cs4270.o
 obj-$(CONFIG_SND_SOC_CX20442)	+= snd-soc-cx20442.o
 obj-$(CONFIG_SND_SOC_L3)	+= snd-soc-l3.o
diff --git a/sound/soc/codecs/cq93vc.c b/sound/soc/codecs/cq93vc.c
new file mode 100644
index 0000000..f420e01
--- /dev/null
+++ b/sound/soc/codecs/cq93vc.c
@@ -0,0 +1,342 @@
+/*
+ * ALSA SoC CQ0093 Voice Codec Driver for DaVinci platforms
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
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/delay.h>
+#include <linux/pm.h>
+#include <linux/i2c.h>
+#include <linux/platform_device.h>
+#include <linux/device.h>
+#include <linux/clk.h>
+#include <linux/mfd/davinci_voicecodec.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dai.h>
+#include <sound/soc-dapm.h>
+#include <sound/initval.h>
+
+#include <mach/dm365.h>
+
+#include "cq93vc.h"
+
+static inline unsigned int cq93vc_read(struct snd_soc_codec *codec,
+						unsigned int reg)
+{
+	struct davinci_vc *davinci_vc = codec->control_data;
+
+	return readl(davinci_vc->base + reg);
+}
+
+static inline int cq93vc_write(struct snd_soc_codec *codec, unsigned int reg,
+		       unsigned int value)
+{
+	struct davinci_vc *davinci_vc = codec->control_data;
+
+	writel(value, davinci_vc->base + reg);
+
+	return 0;
+}
+
+static const struct snd_kcontrol_new cq93vc_snd_controls[] = {
+	SOC_SINGLE("PGA Capture Volume", DAVINCI_VC_REG05, 0, 0x03, 0),
+	SOC_SINGLE("Mono DAC Playback Volume", DAVINCI_VC_REG09, 0, 0x3f, 0),
+};
+
+static int cq93vc_mute(struct snd_soc_dai *dai, int mute)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	u8 reg = cq93vc_read(codec, DAVINCI_VC_REG09) & ~DAVINCI_VC_REG09_MUTE;
+
+	if (mute)
+		cq93vc_write(codec, DAVINCI_VC_REG09,
+			     reg | DAVINCI_VC_REG09_MUTE);
+	else
+		cq93vc_write(codec, DAVINCI_VC_REG09, reg);
+
+	return 0;
+}
+
+static int cq93vc_add_controls(struct snd_soc_codec *codec)
+{
+	int err, i;
+
+	for (i = 0; i < ARRAY_SIZE(cq93vc_snd_controls); i++) {
+		err = snd_ctl_add(codec->card,
+				  snd_soc_cnew(&cq93vc_snd_controls[i],
+					       codec, NULL));
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
+static int cq93vc_set_dai_sysclk(struct snd_soc_dai *codec_dai,
+				 int clk_id, unsigned int freq, int dir)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct davinci_vc *davinci_vc = codec->control_data;
+
+	switch (freq) {
+	case 22579200:
+	case 27000000:
+	case 33868800:
+		davinci_vc->cq93vc.sysclk = freq;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int cq93vc_set_bias_level(struct snd_soc_codec *codec,
+				enum snd_soc_bias_level level)
+{
+	switch (level) {
+	case SND_SOC_BIAS_ON:
+		cq93vc_write(codec, DAVINCI_VC_REG12,
+			     DAVINCI_VC_REG12_POWER_ALL_ON);
+		break;
+	case SND_SOC_BIAS_PREPARE:
+		break;
+	case SND_SOC_BIAS_STANDBY:
+		cq93vc_write(codec, DAVINCI_VC_REG12,
+			     DAVINCI_VC_REG12_POWER_ALL_OFF);
+		break;
+	case SND_SOC_BIAS_OFF:
+		/* force all power off */
+		cq93vc_write(codec, DAVINCI_VC_REG12,
+			     DAVINCI_VC_REG12_POWER_ALL_OFF);
+		break;
+	}
+	codec->bias_level = level;
+
+	return 0;
+}
+
+#define CQ93VC_RATES	(SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000)
+#define CQ93VC_FORMATS	(SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S16_LE)
+
+static struct snd_soc_dai_ops cq93vc_dai_ops = {
+	.digital_mute	= cq93vc_mute,
+	.set_sysclk	= cq93vc_set_dai_sysclk,
+};
+
+struct snd_soc_dai cq93vc_dai = {
+	.name = "CQ93VC",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = CQ93VC_RATES,
+		.formats = CQ93VC_FORMATS,},
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = CQ93VC_RATES,
+		.formats = CQ93VC_FORMATS,},
+	.ops = &cq93vc_dai_ops,
+};
+EXPORT_SYMBOL_GPL(cq93vc_dai);
+
+static int cq93vc_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec = socdev->card->codec;
+
+	cq93vc_set_bias_level(codec, SND_SOC_BIAS_OFF);
+
+	return 0;
+}
+
+static int cq93vc_resume(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec = socdev->card->codec;
+
+	cq93vc_set_bias_level(codec, codec->suspend_bias_level);
+
+	return 0;
+}
+
+static struct snd_soc_codec *cq93vc_codec;
+
+static int cq93vc_probe(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+	struct snd_soc_codec *codec;
+	int ret;
+
+	socdev->card->codec = cq93vc_codec;
+	codec = socdev->card->codec;
+
+	/* Set the PGA Gain to 18 dB */
+	cq93vc_write(codec, DAVINCI_VC_REG05, DAVINCI_VC_REG05_PGA_GAIN);
+
+	/* Set the DAC digital attenuation to 0 dB */
+	cq93vc_write(codec, DAVINCI_VC_REG09, DAVINCI_VC_REG09_DIG_ATTEN);
+
+	/* Register pcms */
+	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
+	if (ret < 0) {
+		dev_err(dev, "%s: failed to create pcms\n", pdev->name);
+		return ret;
+	}
+
+	/* Set controls */
+	cq93vc_add_controls(codec);
+
+	/* Off, with power on */
+	cq93vc_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+
+	return 0;
+}
+
+static int cq93vc_remove(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec = socdev->card->codec;
+
+	/* Power down chip */
+	if (codec->control_data)
+		cq93vc_set_bias_level(codec, SND_SOC_BIAS_OFF);
+
+	snd_soc_free_pcms(socdev);
+	snd_soc_dapm_free(socdev);
+
+	return 0;
+}
+
+struct snd_soc_codec_device soc_codec_dev_cq93vc = {
+	.probe = cq93vc_probe,
+	.remove = cq93vc_remove,
+	.suspend = cq93vc_suspend,
+	.resume = cq93vc_resume,
+};
+EXPORT_SYMBOL_GPL(soc_codec_dev_cq93vc);
+
+static __init int cq93vc_codec_probe(struct platform_device *pdev)
+{
+	struct davinci_vc *davinci_vc = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec;
+	int ret;
+
+	codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
+	if (codec == NULL) {
+		dev_dbg(davinci_vc->dev,
+			"could not allocate memory for codec data\n");
+		return -ENOMEM;
+	}
+
+	davinci_vc->cq93vc.codec = codec;
+
+	cq93vc_dai.dev = &pdev->dev;
+
+	mutex_init(&codec->mutex);
+	INIT_LIST_HEAD(&codec->dapm_widgets);
+	INIT_LIST_HEAD(&codec->dapm_paths);
+	codec->dev = &pdev->dev;
+	codec->name = "CQ93VC";
+	codec->owner = THIS_MODULE;
+	codec->read = cq93vc_read;
+	codec->write = cq93vc_write;
+	codec->set_bias_level = cq93vc_set_bias_level;
+	codec->dai = &cq93vc_dai;
+	codec->num_dai = 1;
+	codec->control_data = davinci_vc;
+
+	cq93vc_codec = codec;
+
+	ret = snd_soc_register_dai(&cq93vc_dai);
+	if (ret != 0) {
+		dev_err(davinci_vc->dev, "could register dai\n");
+		goto fail1;
+	}
+	return 0;
+
+fail1:
+	kfree(codec);
+	cq93vc_codec = NULL;
+
+	return ret;
+}
+
+static int __devexit cq93vc_codec_remove(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec = socdev->card->codec;
+
+	snd_soc_unregister_dai(&cq93vc_dai);
+
+	kfree(codec);
+	cq93vc_codec = NULL;
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int cq93vc_codec_suspend(struct platform_device *pdev, pm_message_t m)
+{
+	return snd_soc_suspend_device(&pdev->dev);
+}
+
+static int cq93vc_codec_resume(struct platform_device *pdev)
+{
+	return snd_soc_resume_device(&pdev->dev);
+}
+#else
+#define cq93vc_codec_suspend NULL
+#define cq93vc_codec_resume NULL
+#endif
+
+static struct platform_driver cq93vc_codec_driver = {
+	.driver = {
+		   .name = "cq93vc",
+		   .owner = THIS_MODULE,
+		   },
+	.probe = cq93vc_codec_probe,
+	.remove = __devexit_p(cq93vc_codec_remove),
+	.suspend = cq93vc_codec_suspend,
+	.resume = cq93vc_codec_resume,
+};
+
+static __init int cq93vc_init(void)
+{
+	return platform_driver_probe(&cq93vc_codec_driver, cq93vc_codec_probe);
+}
+module_init(cq93vc_init);
+
+static __exit void cq93vc_exit(void)
+{
+	platform_driver_unregister(&cq93vc_codec_driver);
+}
+module_exit(cq93vc_exit);
+
+MODULE_DESCRIPTION("Texas Instruments DaVinci ASoC CQ0093 Voice Codec Driver");
+MODULE_AUTHOR("Miguel Aguilar");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/cq93vc.h b/sound/soc/codecs/cq93vc.h
new file mode 100644
index 0000000..845b196
--- /dev/null
+++ b/sound/soc/codecs/cq93vc.h
@@ -0,0 +1,29 @@
+/*
+ * ALSA SoC CQ0093 Voice Codec Driver for DaVinci platforms
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
+#ifndef _CQ93VC_H
+#define _CQ93VC_H
+
+extern struct snd_soc_dai cq93vc_dai;
+extern struct snd_soc_codec_device soc_codec_dev_cq93vc;
+
+#endif
diff --git a/sound/soc/davinci/Kconfig b/sound/soc/davinci/Kconfig
index 047ee39..3aa04e6 100644
--- a/sound/soc/davinci/Kconfig
+++ b/sound/soc/davinci/Kconfig
@@ -12,15 +12,21 @@ config SND_DAVINCI_SOC_I2S
 config SND_DAVINCI_SOC_MCASP
 	tristate
 
+config SND_DAVINCI_SOC_VCIF
+	tristate
+
 config SND_DAVINCI_SOC_EVM
 	tristate "SoC Audio support for DaVinci DM6446, DM355 or DM365 EVM"
 	depends on SND_DAVINCI_SOC
-	depends on MACH_DAVINCI_EVM || MACH_DAVINCI_DM355_EVM  || MACH_DAVINCI_DM365_EVM
+	depends on MACH_DAVINCI_EVM || MACH_DAVINCI_DM355_EVM || MACH_DAVINCI_DM365_EVM
 	select SND_DAVINCI_SOC_I2S
 	select SND_SOC_TLV320AIC3X
+	select MFD_DAVINCI_VOICECODEC
+	select SND_DAVINCI_SOC_VCIF
+	select SND_SOC_CQ0093VC
 	help
 	  Say Y if you want to add support for SoC audio on TI
-	  DaVinci DM6446 or DM355 EVM platforms.
+	  DaVinci DM6446, DM355 or DM365 EVM platforms.
 
 config  SND_DM6467_SOC_EVM
 	tristate "SoC Audio support for DaVinci DM6467 EVM"
diff --git a/sound/soc/davinci/Makefile b/sound/soc/davinci/Makefile
index a6939d7..a93679d 100644
--- a/sound/soc/davinci/Makefile
+++ b/sound/soc/davinci/Makefile
@@ -2,10 +2,12 @@
 snd-soc-davinci-objs := davinci-pcm.o
 snd-soc-davinci-i2s-objs := davinci-i2s.o
 snd-soc-davinci-mcasp-objs:= davinci-mcasp.o
+snd-soc-davinci-vcif-objs:= davinci-vcif.o
 
 obj-$(CONFIG_SND_DAVINCI_SOC) += snd-soc-davinci.o
 obj-$(CONFIG_SND_DAVINCI_SOC_I2S) += snd-soc-davinci-i2s.o
 obj-$(CONFIG_SND_DAVINCI_SOC_MCASP) += snd-soc-davinci-mcasp.o
+obj-$(CONFIG_SND_DAVINCI_SOC_VCIF) += snd-soc-davinci-vcif.o
 
 # DAVINCI Machine Support
 snd-soc-evm-objs := davinci-evm.o
diff --git a/sound/soc/davinci/davinci-vcif.h b/sound/soc/davinci/davinci-vcif.h
new file mode 100644
index 0000000..571c994
--- /dev/null
+++ b/sound/soc/davinci/davinci-vcif.h
@@ -0,0 +1,28 @@
+/*
+ * ALSA SoC Voice Codec Interface for TI DAVINCI processor
+ *
+ * Copyright (C) 2010 Texas Instruments.
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
+#ifndef _DAVINCI_VCIF_H
+#define _DAVINCI_VCIF_H
+
+extern struct snd_soc_dai davinci_vcif_dai;
+
+#endif
-- 
1.6.0.4
