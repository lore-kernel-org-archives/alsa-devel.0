From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH v7 09/17] irqchip: Add driver for Cirrus Logic Madera codecs
Date: Mon, 15 Jan 2018 12:41:57 +0000
Message-ID: <20180115124205.29042-10-rf@opensource.wolfsonmicro.com>
References: <20180115124205.29042-1-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20180115124205.29042-1-rf@opensource.wolfsonmicro.com>
Sender: linux-gpio-owner@vger.kernel.org
To: lee.jones@linaro.org, broonie@kernel.org, linus.walleij@linaro.org, gnurou@gmail.com, robh+dt@kernel.org, tglx@linutronix.de, jason@lakedaemon.net
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The Cirrus Logic Madera codecs (Cirrus Logic CS47L35/85/90/91 and WM1840)
are highly complex devices containing up to 7 programmable DSPs and many
other internal sources of interrupts plus a number of GPIOs that can be
used as interrupt inputs. The large number (>150) of internal interrupt
sources are managed by an on-board interrupt controller.

This driver provides the handling for the interrupt controller. As the
codec is accessed via regmap, we can make use of the generic IRQ
functionality from regmap to do most of the work. Only around half of
the possible interrupt source are currently of interest from the driver
so only this subset is defined. Others can be added in future if needed.

The KConfig options are not user-configurable because this driver is
mandatory so is automatically included when the parent MFD driver is
selected.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 MAINTAINERS                              |   2 +
 drivers/irqchip/Kconfig                  |   3 +
 drivers/irqchip/Makefile                 |   1 +
 drivers/irqchip/irq-madera.c             | 301 +++++++++++++++++++++++++++++++
 include/linux/irqchip/irq-madera-pdata.h |  23 +++
 include/linux/irqchip/irq-madera.h       |  98 ++++++++++
 6 files changed, 428 insertions(+)
 create mode 100644 drivers/irqchip/irq-madera.c
 create mode 100644 include/linux/irqchip/irq-madera-pdata.h
 create mode 100644 include/linux/irqchip/irq-madera.h

diff --git a/MAINTAINERS b/MAINTAINERS
index aa7f3a9dfa77..6e79d651639b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3496,7 +3496,9 @@ T:	git https://github.com/CirrusLogic/linux-drivers.git
 W:	https://github.com/CirrusLogic/linux-drivers/wiki
 S:	Supported
 F:	Documentation/devicetree/bindings/mfd/madera.txt
+F:	include/linux/irqchip/irq-madera*
 F:	include/linux/mfd/madera/*
+F:	drivers/irqchip/irq-madera*
 F:	drivers/mfd/madera*
 F:	drivers/mfd/cs47l*
 
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index c70476b34a53..d128c902b670 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -144,6 +144,9 @@ config IMGPDC_IRQ
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
 
+config MADERA_IRQ
+	bool
+
 config IRQ_MIPS_CPU
 	bool
 	select GENERIC_IRQ_CHIP
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index d2df34a54d38..4aa3fbdb7929 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_ARCH_S3C24XX)		+= irq-s3c24xx.o
 obj-$(CONFIG_DW_APB_ICTL)		+= irq-dw-apb-ictl.o
 obj-$(CONFIG_METAG)			+= irq-metag-ext.o
 obj-$(CONFIG_METAG_PERFCOUNTER_IRQS)	+= irq-metag.o
+obj-$(CONFIG_MADERA_IRQ)		+= irq-madera.o
 obj-$(CONFIG_CLPS711X_IRQCHIP)		+= irq-clps711x.o
 obj-$(CONFIG_OMPIC)			+= irq-ompic.o
 obj-$(CONFIG_OR1K_PIC)			+= irq-or1k-pic.o
diff --git a/drivers/irqchip/irq-madera.c b/drivers/irqchip/irq-madera.c
new file mode 100644
index 000000000000..d80c459cddd7
--- /dev/null
+++ b/drivers/irqchip/irq-madera.c
@@ -0,0 +1,301 @@
+/*
+ * Interrupt support for Cirrus Logic Madera codecs
+ *
+ * Copyright 2016-2017 Cirrus Logic
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/gpio.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_gpio.h>
+#include <linux/of_irq.h>
+#include <linux/irqchip/irq-madera.h>
+#include <linux/irqchip/irq-madera-pdata.h>
+#include <linux/mfd/madera/core.h>
+#include <linux/mfd/madera/pdata.h>
+#include <linux/mfd/madera/registers.h>
+
+struct madera_irq_priv {
+	struct device			*dev;
+	int				irq;
+	struct regmap_irq_chip_data	*irq_data;
+	struct madera			*madera;
+};
+
+#define MADERA_IRQ(_irq, _reg)						     \
+	[MADERA_IRQ_ ## _irq] = { .reg_offset = (_reg) - MADERA_IRQ1_STATUS_2, \
+				.mask = MADERA_ ## _irq ## _EINT1 }
+
+static const struct regmap_irq madera_irqs[MADERA_NUM_IRQ] = {
+	MADERA_IRQ(FLL1_LOCK,		MADERA_IRQ1_STATUS_2),
+	MADERA_IRQ(FLL2_LOCK,		MADERA_IRQ1_STATUS_2),
+	MADERA_IRQ(FLL3_LOCK,		MADERA_IRQ1_STATUS_2),
+	MADERA_IRQ(FLLAO_LOCK,		MADERA_IRQ1_STATUS_2),
+
+	MADERA_IRQ(MICDET1,		MADERA_IRQ1_STATUS_6),
+	MADERA_IRQ(MICDET2,		MADERA_IRQ1_STATUS_6),
+	MADERA_IRQ(HPDET,		MADERA_IRQ1_STATUS_6),
+
+	MADERA_IRQ(MICD_CLAMP_RISE,	MADERA_IRQ1_STATUS_7),
+	MADERA_IRQ(MICD_CLAMP_FALL,	MADERA_IRQ1_STATUS_7),
+	MADERA_IRQ(JD1_RISE,		MADERA_IRQ1_STATUS_7),
+	MADERA_IRQ(JD1_FALL,		MADERA_IRQ1_STATUS_7),
+
+	MADERA_IRQ(ASRC2_IN1_LOCK,	MADERA_IRQ1_STATUS_9),
+	MADERA_IRQ(ASRC2_IN2_LOCK,	MADERA_IRQ1_STATUS_9),
+	MADERA_IRQ(ASRC1_IN1_LOCK,	MADERA_IRQ1_STATUS_9),
+	MADERA_IRQ(ASRC1_IN2_LOCK,	MADERA_IRQ1_STATUS_9),
+	MADERA_IRQ(DRC2_SIG_DET,	MADERA_IRQ1_STATUS_9),
+	MADERA_IRQ(DRC1_SIG_DET,	MADERA_IRQ1_STATUS_9),
+
+	MADERA_IRQ(DSP_IRQ1,		MADERA_IRQ1_STATUS_11),
+	MADERA_IRQ(DSP_IRQ2,		MADERA_IRQ1_STATUS_11),
+	MADERA_IRQ(DSP_IRQ3,		MADERA_IRQ1_STATUS_11),
+	MADERA_IRQ(DSP_IRQ4,		MADERA_IRQ1_STATUS_11),
+	MADERA_IRQ(DSP_IRQ5,		MADERA_IRQ1_STATUS_11),
+	MADERA_IRQ(DSP_IRQ6,		MADERA_IRQ1_STATUS_11),
+	MADERA_IRQ(DSP_IRQ7,		MADERA_IRQ1_STATUS_11),
+	MADERA_IRQ(DSP_IRQ8,		MADERA_IRQ1_STATUS_11),
+	MADERA_IRQ(DSP_IRQ9,		MADERA_IRQ1_STATUS_11),
+	MADERA_IRQ(DSP_IRQ10,		MADERA_IRQ1_STATUS_11),
+	MADERA_IRQ(DSP_IRQ11,		MADERA_IRQ1_STATUS_11),
+	MADERA_IRQ(DSP_IRQ12,		MADERA_IRQ1_STATUS_11),
+	MADERA_IRQ(DSP_IRQ13,		MADERA_IRQ1_STATUS_11),
+	MADERA_IRQ(DSP_IRQ14,		MADERA_IRQ1_STATUS_11),
+	MADERA_IRQ(DSP_IRQ15,		MADERA_IRQ1_STATUS_11),
+	MADERA_IRQ(DSP_IRQ16,		MADERA_IRQ1_STATUS_11),
+
+	MADERA_IRQ(HP3R_SC,		MADERA_IRQ1_STATUS_12),
+	MADERA_IRQ(HP3L_SC,		MADERA_IRQ1_STATUS_12),
+	MADERA_IRQ(HP2R_SC,		MADERA_IRQ1_STATUS_12),
+	MADERA_IRQ(HP2L_SC,		MADERA_IRQ1_STATUS_12),
+	MADERA_IRQ(HP1R_SC,		MADERA_IRQ1_STATUS_12),
+	MADERA_IRQ(HP1L_SC,		MADERA_IRQ1_STATUS_12),
+
+	MADERA_IRQ(SPK_OVERHEAT_WARN,	MADERA_IRQ1_STATUS_15),
+	MADERA_IRQ(SPK_OVERHEAT,	MADERA_IRQ1_STATUS_15),
+
+	MADERA_IRQ(DSP1_BUS_ERR,	MADERA_IRQ1_STATUS_33),
+	MADERA_IRQ(DSP2_BUS_ERR,	MADERA_IRQ1_STATUS_33),
+	MADERA_IRQ(DSP3_BUS_ERR,	MADERA_IRQ1_STATUS_33),
+	MADERA_IRQ(DSP4_BUS_ERR,	MADERA_IRQ1_STATUS_33),
+	MADERA_IRQ(DSP5_BUS_ERR,	MADERA_IRQ1_STATUS_33),
+	MADERA_IRQ(DSP6_BUS_ERR,	MADERA_IRQ1_STATUS_33),
+	MADERA_IRQ(DSP7_BUS_ERR,	MADERA_IRQ1_STATUS_33),
+};
+
+static const struct regmap_irq_chip madera_irq = {
+	.name		= "madera IRQ",
+	.status_base	= MADERA_IRQ1_STATUS_2,
+	.mask_base	= MADERA_IRQ1_MASK_2,
+	.ack_base	= MADERA_IRQ1_STATUS_2,
+	.runtime_pm	= true,
+	.num_regs	= 32,
+	.irqs		= madera_irqs,
+	.num_irqs	= ARRAY_SIZE(madera_irqs),
+};
+
+static int madera_map_irq(struct madera *madera, int irq)
+{
+	struct madera_irq_priv *priv = dev_get_drvdata(madera->irq_dev);
+
+	if (!madera->irq_dev)
+		return -ENOENT;
+
+	return regmap_irq_get_virq(priv->irq_data, irq);
+}
+
+int madera_request_irq(struct madera *madera, int irq, const char *name,
+			irq_handler_t handler, void *data)
+{
+	irq = madera_map_irq(madera, irq);
+
+	if (irq < 0)
+		return irq;
+
+	return request_threaded_irq(irq, NULL, handler, IRQF_ONESHOT, name,
+				    data);
+
+}
+EXPORT_SYMBOL_GPL(madera_request_irq);
+
+void madera_free_irq(struct madera *madera, int irq, void *data)
+{
+	irq = madera_map_irq(madera, irq);
+
+	if (irq < 0)
+		return;
+
+	free_irq(irq, data);
+}
+EXPORT_SYMBOL_GPL(madera_free_irq);
+
+int madera_set_irq_wake(struct madera *madera, int irq, int on)
+{
+	irq = madera_map_irq(madera, irq);
+
+	if (irq < 0)
+		return irq;
+
+	return irq_set_irq_wake(irq, on);
+}
+EXPORT_SYMBOL_GPL(madera_set_irq_wake);
+
+#ifdef CONFIG_PM_SLEEP
+static int madera_suspend_noirq(struct device *dev)
+{
+	struct madera_irq_priv *priv = dev_get_drvdata(dev);
+
+	dev_dbg(priv->dev, "No IRQ suspend, reenabling IRQ\n");
+
+	enable_irq(priv->irq);
+
+	return 0;
+}
+
+static int madera_suspend(struct device *dev)
+{
+	struct madera_irq_priv *priv = dev_get_drvdata(dev);
+
+	dev_dbg(priv->dev, "Suspend, disabling IRQ\n");
+
+	disable_irq(priv->irq);
+
+	return 0;
+}
+
+static int madera_resume_noirq(struct device *dev)
+{
+	struct madera_irq_priv *priv = dev_get_drvdata(dev);
+
+	dev_dbg(priv->dev, "No IRQ resume, disabling IRQ\n");
+
+	disable_irq(priv->irq);
+
+	return 0;
+}
+
+static int madera_resume(struct device *dev)
+{
+	struct madera_irq_priv *priv = dev_get_drvdata(dev);
+
+	dev_dbg(priv->dev, "Resume, reenabling IRQ\n");
+
+	enable_irq(priv->irq);
+
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops madera_irq_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(madera_suspend, madera_resume)
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(madera_suspend_noirq,
+				      madera_resume_noirq)
+};
+
+static int madera_irq_probe(struct platform_device *pdev)
+{
+	struct madera *madera = dev_get_drvdata(pdev->dev.parent);
+	struct madera_irq_priv *priv;
+	struct irq_data *irq_data;
+	unsigned int irq_flags = madera->pdata.irqchip.irq_flags;
+	int ret;
+
+	dev_dbg(&pdev->dev, "probe\n");
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = &pdev->dev;
+	priv->madera = madera;
+	priv->irq = madera->irq;
+
+	/* Read the flags from the interrupt controller if not specified */
+	if (!irq_flags) {
+		irq_data = irq_get_irq_data(priv->irq);
+		if (!irq_data) {
+			dev_err(priv->dev, "Invalid IRQ: %d\n", priv->irq);
+			return -EINVAL;
+		}
+
+		irq_flags = irqd_get_trigger_type(irq_data);
+
+		/* Codec defaults to trigger low, use this if no flags given */
+		if (irq_flags == IRQ_TYPE_NONE)
+			irq_flags = IRQF_TRIGGER_LOW;
+	}
+
+	if (irq_flags & (IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING)) {
+		dev_err(priv->dev, "Host interrupt not level-triggered\n");
+		return -EINVAL;
+	}
+
+	if (irq_flags & IRQF_TRIGGER_HIGH) {
+		ret = regmap_update_bits(madera->regmap, MADERA_IRQ1_CTRL,
+					 MADERA_IRQ_POL_MASK, 0);
+		if (ret) {
+			dev_err(priv->dev,
+				"Failed to set IRQ polarity: %d\n", ret);
+			return ret;
+		}
+	}
+
+	/*
+	 * NOTE: regmap registers this against the OF node of the parent of
+	 * the regmap - that is, against the mfd driver
+	 */
+	ret = regmap_add_irq_chip(madera->regmap, priv->irq, IRQF_ONESHOT, 0,
+				  &madera_irq, &priv->irq_data);
+	if (ret) {
+		dev_err(priv->dev, "add_irq_chip failed: %d\n", ret);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, priv);
+	madera->irq_dev = priv->dev;
+
+	return 0;
+}
+
+static int madera_irq_remove(struct platform_device *pdev)
+{
+	struct madera_irq_priv *priv = platform_get_drvdata(pdev);
+
+	/*
+	 * The IRQ is disabled by the parent MFD driver before
+	 * it starts cleaning up all child drivers
+	 */
+
+	priv->madera->irq_dev = NULL;
+
+	regmap_del_irq_chip(priv->irq, priv->irq_data);
+	free_irq(priv->irq, priv);
+
+	return 0;
+}
+
+static struct platform_driver madera_irq_driver = {
+	.probe	= madera_irq_probe,
+	.remove = madera_irq_remove,
+	.driver = {
+		.name	= "madera-irq",
+		.pm	= &madera_irq_pm_ops,
+	}
+};
+module_platform_driver(madera_irq_driver);
+
+MODULE_DESCRIPTION("Madera IRQ driver");
+MODULE_AUTHOR("Richard Fitzgerald <rf@opensource.wolfsonmicro.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/irqchip/irq-madera-pdata.h b/include/linux/irqchip/irq-madera-pdata.h
new file mode 100644
index 000000000000..1b6cc31d5980
--- /dev/null
+++ b/include/linux/irqchip/irq-madera-pdata.h
@@ -0,0 +1,23 @@
+/*
+ * Platform data for Cirrus Logic Madera codecs irqchip driver
+ *
+ * Copyright 2016-2017 Cirrus Logic
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef IRQCHIP_MADERA_PDATA_H
+#define IRQCHIP_MADERA_PDATA_H
+
+/**
+ * struct madera_irqchip_pdata - Configuration for Madera devices IRQ driver
+ *
+ * @irq_flags: Mode for primary IRQ (defaults to active low)
+ */
+struct madera_irqchip_pdata {
+	unsigned int irq_flags;
+};
+
+#endif
diff --git a/include/linux/irqchip/irq-madera.h b/include/linux/irqchip/irq-madera.h
new file mode 100644
index 000000000000..a7bc5fb8350e
--- /dev/null
+++ b/include/linux/irqchip/irq-madera.h
@@ -0,0 +1,98 @@
+/*
+ * Interrupt support for Cirrus Logic Madera codecs
+ *
+ * Copyright 2016-2017 Cirrus Logic
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef IRQCHIP_MADERA_H
+#define IRQCHIP_MADERA_H
+
+#include <linux/interrupt.h>
+
+#define MADERA_IRQ_FLL1_LOCK		0
+#define MADERA_IRQ_FLL2_LOCK		1
+#define MADERA_IRQ_FLL3_LOCK		2
+#define MADERA_IRQ_FLLAO_LOCK		3
+#define MADERA_IRQ_CLK_SYS_ERR		4
+#define MADERA_IRQ_CLK_ASYNC_ERR	5
+#define MADERA_IRQ_CLK_DSP_ERR		6
+#define MADERA_IRQ_HPDET		7
+#define MADERA_IRQ_MICDET1		8
+#define MADERA_IRQ_MICDET2		9
+#define MADERA_IRQ_JD1_RISE		10
+#define MADERA_IRQ_JD1_FALL		11
+#define MADERA_IRQ_JD2_RISE		12
+#define MADERA_IRQ_JD2_FALL		13
+#define MADERA_IRQ_MICD_CLAMP_RISE	14
+#define MADERA_IRQ_MICD_CLAMP_FALL	15
+#define MADERA_IRQ_DRC2_SIG_DET		16
+#define MADERA_IRQ_DRC1_SIG_DET		17
+#define MADERA_IRQ_ASRC1_IN1_LOCK	18
+#define MADERA_IRQ_ASRC1_IN2_LOCK	19
+#define MADERA_IRQ_ASRC2_IN1_LOCK	20
+#define MADERA_IRQ_ASRC2_IN2_LOCK	21
+#define MADERA_IRQ_DSP_IRQ1		22
+#define MADERA_IRQ_DSP_IRQ2		23
+#define MADERA_IRQ_DSP_IRQ3		24
+#define MADERA_IRQ_DSP_IRQ4		25
+#define MADERA_IRQ_DSP_IRQ5		26
+#define MADERA_IRQ_DSP_IRQ6		27
+#define MADERA_IRQ_DSP_IRQ7		28
+#define MADERA_IRQ_DSP_IRQ8		29
+#define MADERA_IRQ_DSP_IRQ9		30
+#define MADERA_IRQ_DSP_IRQ10		31
+#define MADERA_IRQ_DSP_IRQ11		32
+#define MADERA_IRQ_DSP_IRQ12		33
+#define MADERA_IRQ_DSP_IRQ13		34
+#define MADERA_IRQ_DSP_IRQ14		35
+#define MADERA_IRQ_DSP_IRQ15		36
+#define MADERA_IRQ_DSP_IRQ16		37
+#define MADERA_IRQ_HP1L_SC		38
+#define MADERA_IRQ_HP1R_SC		39
+#define MADERA_IRQ_HP2L_SC		40
+#define MADERA_IRQ_HP2R_SC		41
+#define MADERA_IRQ_HP3L_SC		42
+#define MADERA_IRQ_HP3R_SC		43
+#define MADERA_IRQ_SPKOUTL_SC		44
+#define MADERA_IRQ_SPKOUTR_SC		45
+#define MADERA_IRQ_HP1L_ENABLE_DONE	46
+#define MADERA_IRQ_HP1R_ENABLE_DONE	47
+#define MADERA_IRQ_HP2L_ENABLE_DONE	48
+#define MADERA_IRQ_HP2R_ENABLE_DONE	49
+#define MADERA_IRQ_HP3L_ENABLE_DONE	50
+#define MADERA_IRQ_HP3R_ENABLE_DONE	51
+#define MADERA_IRQ_SPKOUTL_ENABLE_DONE	52
+#define MADERA_IRQ_SPKOUTR_ENABLE_DONE	53
+#define MADERA_IRQ_SPK_SHUTDOWN		54
+#define MADERA_IRQ_SPK_OVERHEAT		55
+#define MADERA_IRQ_SPK_OVERHEAT_WARN	56
+#define MADERA_IRQ_GPIO1		57
+#define MADERA_IRQ_GPIO2		58
+#define MADERA_IRQ_GPIO3		59
+#define MADERA_IRQ_GPIO4		60
+#define MADERA_IRQ_GPIO5		61
+#define MADERA_IRQ_GPIO6		62
+#define MADERA_IRQ_GPIO7		63
+#define MADERA_IRQ_GPIO8		64
+#define MADERA_IRQ_DSP1_BUS_ERR		65
+#define MADERA_IRQ_DSP2_BUS_ERR		66
+#define MADERA_IRQ_DSP3_BUS_ERR		67
+#define MADERA_IRQ_DSP4_BUS_ERR		68
+#define MADERA_IRQ_DSP5_BUS_ERR		69
+#define MADERA_IRQ_DSP6_BUS_ERR		70
+#define MADERA_IRQ_DSP7_BUS_ERR		71
+
+#define MADERA_NUM_IRQ			72
+
+struct madera;
+
+int madera_request_irq(struct madera *madera, int irq, const char *name,
+		       irq_handler_t handler, void *data);
+void madera_free_irq(struct madera *madera, int irq, void *data);
+int madera_set_irq_wake(struct madera *madera, int irq, int on);
+
+#endif
-- 
2.11.0

