From: Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH v3] clk: x86: Add Atom PMC platform clocks
Date: Fri,  9 Sep 2016 16:23:37 +0300
Message-ID: <1473427417-9166-1-git-send-email-irina.tirdea@intel.com>
Return-path: <linux-clk-owner@vger.kernel.org>
Sender: linux-clk-owner@vger.kernel.org
To: linux-clk@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Pierre-Louis Bossart <pierre-louis.bossart@intel.com>, Irina Tirdea <irina.tirdea@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The BayTrail and CherryTrail platforms provide platform clocks
through their Power Management Controller (PMC).

The SoC supports up to 6 clocks (PMC_PLT_CLK[5:0]) with a
frequency of either 19.2 MHz (PLL) or 25 MHz (XTAL) for BayTrail
an a frequency of 19.2 MHz (XTAL) for CherryTrail. These clocks
are available for general system use, where appropriate, and each
have Control & Frequency register fields associated with them.

For example, the usage for platform clocks suggested in the datasheet
is the following:
  PLT_CLK[2:0] - Camera
  PLT_CLK[3] - Audio Codec
  PLT_CLK[4] -
  PLT_CLK[5] - COMMs

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---

Notes:
    Submitting this patch through the clock tree as requested by
    Mark Brown. This patch specifically enables the audio MCLK
    required by Baytrail CR devices (support already merged in
    Mark's tree)

Changes from v2:
 - move clk platform data structures to a separate include file
 - store clk_hw pointer for the fixed rate clocks

Changes from v1:
 - register the clk device as child of pmc device
 - pass iomem pointer from pmc driver to clk driver to avoid using
pmc_atom_read()/write() and use readl/writel API instead
 - use devm_clk_hw_register/clkdev_hw_create instead of
clk_register/clkdev_create

 arch/x86/Kconfig                          |   1 +
 arch/x86/include/asm/pmc_atom.h           |   3 +
 arch/x86/platform/atom/pmc_atom.c         |  78 +++++-
 drivers/clk/x86/Makefile                  |   1 +
 drivers/clk/x86/clk-byt-plt.c             | 381 ++++++++++++++++++++++++++++++
 include/linux/platform_data/clk-byt-plt.h |  31 +++
 6 files changed, 492 insertions(+), 3 deletions(-)
 create mode 100644 drivers/clk/x86/clk-byt-plt.c
 create mode 100644 include/linux/platform_data/clk-byt-plt.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2a1f0ce..3e603a8 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2744,6 +2744,7 @@ config X86_DMA_REMAP
 config PMC_ATOM
 	def_bool y
         depends on PCI
+	select COMMON_CLK
 
 config VMD
 	depends on PCI_MSI
diff --git a/arch/x86/include/asm/pmc_atom.h b/arch/x86/include/asm/pmc_atom.h
index aa8744c..2d310cf 100644
--- a/arch/x86/include/asm/pmc_atom.h
+++ b/arch/x86/include/asm/pmc_atom.h
@@ -50,6 +50,9 @@
 				BIT_ORED_DEDICATED_IRQ_GPSC | \
 				BIT_SHARED_IRQ_GPSS)
 
+/* Platform clock control registers */
+#define PMC_CLK_CTL_0		0x60
+
 /* The timers acumulate time spent in sleep state */
 #define	PMC_S0IR_TMR		0x80
 #define	PMC_S0I1_TMR		0x84
diff --git a/arch/x86/platform/atom/pmc_atom.c b/arch/x86/platform/atom/pmc_atom.c
index 964ff4f..b353893 100644
--- a/arch/x86/platform/atom/pmc_atom.c
+++ b/arch/x86/platform/atom/pmc_atom.c
@@ -21,6 +21,8 @@
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
 #include <linux/io.h>
+#include <linux/platform_device.h>
+#include <linux/platform_data/clk-byt-plt.h>
 
 #include <asm/pmc_atom.h>
 
@@ -37,6 +39,11 @@ struct pmc_reg_map {
 	const struct pmc_bit_map *pss;
 };
 
+struct pmc_data {
+	const struct pmc_reg_map *map;
+	const struct pmc_clk *clks;
+};
+
 struct pmc_dev {
 	u32 base_addr;
 	void __iomem *regmap;
@@ -50,6 +57,29 @@ struct pmc_dev {
 static struct pmc_dev pmc_device;
 static u32 acpi_base_addr;
 
+static const struct pmc_clk byt_clks[] = {
+	{
+		.name = "xtal",
+		.freq = 25000000,
+		.parent_name = NULL,
+	},
+	{
+		.name = "pll",
+		.freq = 19200000,
+		.parent_name = "xtal",
+	},
+	{},
+};
+
+static const struct pmc_clk cht_clks[] = {
+	{
+		.name = "xtal",
+		.freq = 19200000,
+		.parent_name = NULL,
+	},
+	{},
+};
+
 static const struct pmc_bit_map d3_sts_0_map[] = {
 	{"LPSS1_F0_DMA",	BIT_LPSS1_F0_DMA},
 	{"LPSS1_F1_PWM1",	BIT_LPSS1_F1_PWM1},
@@ -169,6 +199,16 @@ static const struct pmc_reg_map cht_reg_map = {
 	.pss		= cht_pss_map,
 };
 
+static const struct pmc_data byt_data = {
+	.map = &byt_reg_map,
+	.clks = byt_clks,
+};
+
+static const struct pmc_data cht_data = {
+	.map = &cht_reg_map,
+	.clks = cht_clks,
+};
+
 static inline u32 pmc_reg_read(struct pmc_dev *pmc, int reg_offset)
 {
 	return readl(pmc->regmap + reg_offset);
@@ -382,10 +422,36 @@ static int pmc_dbgfs_register(struct pmc_dev *pmc)
 }
 #endif /* CONFIG_DEBUG_FS */
 
+static int pmc_setup_clks(struct pci_dev *pdev, void __iomem *pmc_regmap,
+			  const struct pmc_data *pmc_data)
+{
+	struct platform_device *clkdev;
+	struct pmc_clk_data *clk_data;
+
+	clk_data = kzalloc(sizeof(*clk_data), GFP_KERNEL);
+	if (!clk_data)
+		return -ENOMEM;
+
+	clk_data->base = pmc_regmap + PMC_CLK_CTL_0;
+	clk_data->clks = pmc_data->clks;
+
+	clkdev = platform_device_register_data(&pdev->dev, "clk-byt-plt", -1,
+					       clk_data, sizeof(*clk_data));
+	if (IS_ERR(clkdev)) {
+		kfree(clk_data);
+		return PTR_ERR(clkdev);
+	}
+
+	kfree(clk_data);
+
+	return 0;
+}
+
 static int pmc_setup_dev(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	struct pmc_dev *pmc = &pmc_device;
-	const struct pmc_reg_map *map = (struct pmc_reg_map *)ent->driver_data;
+	const struct pmc_data *data = (struct pmc_data *)ent->driver_data;
+	const struct pmc_reg_map *map = data->map;
 	int ret;
 
 	/* Obtain ACPI base address */
@@ -414,6 +480,12 @@ static int pmc_setup_dev(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (ret)
 		dev_warn(&pdev->dev, "debugfs register failed\n");
 
+	/* Register platform clocks - PMC_PLT_CLK [5:0] */
+	ret = pmc_setup_clks(pdev, pmc->regmap, data);
+	if (ret)
+		dev_warn(&pdev->dev, "platform clocks register failed: %d\n",
+			 ret);
+
 	pmc->init = true;
 	return ret;
 }
@@ -424,8 +496,8 @@ static int pmc_setup_dev(struct pci_dev *pdev, const struct pci_device_id *ent)
  * used by pci_match_id() call below.
  */
 static const struct pci_device_id pmc_pci_ids[] = {
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_VLV_PMC), (kernel_ulong_t)&byt_reg_map },
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_CHT_PMC), (kernel_ulong_t)&cht_reg_map },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_VLV_PMC), (kernel_ulong_t)&byt_data },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_CHT_PMC), (kernel_ulong_t)&cht_data },
 	{ 0, },
 };
 
diff --git a/drivers/clk/x86/Makefile b/drivers/clk/x86/Makefile
index 0478138..cbdc8cc 100644
--- a/drivers/clk/x86/Makefile
+++ b/drivers/clk/x86/Makefile
@@ -1,2 +1,3 @@
 clk-x86-lpss-objs		:= clk-lpt.o
 obj-$(CONFIG_X86_INTEL_LPSS)	+= clk-x86-lpss.o
+obj-$(CONFIG_PMC_ATOM)		+= clk-byt-plt.o
diff --git a/drivers/clk/x86/clk-byt-plt.c b/drivers/clk/x86/clk-byt-plt.c
new file mode 100644
index 0000000..9dbf4b0
--- /dev/null
+++ b/drivers/clk/x86/clk-byt-plt.c
@@ -0,0 +1,381 @@
+/*
+ * Intel Atom platform clocks driver for BayTrail and CherryTrail SoC.
+ *
+ * Copyright (C) 2016, Intel Corporation
+ * Author: Irina Tirdea <irina.tirdea@intel.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/clkdev.h>
+#include <linux/platform_data/clk-byt-plt.h>
+
+#define PLT_CLK_NAME_BASE	"pmc_plt_clk_"
+#define PLT_CLK_DRIVER_NAME	"clk-byt-plt"
+
+#define PMC_CLK_CTL_SIZE	4
+#define PMC_CLK_NUM		6
+#define PMC_MASK_CLK_CTL	GENMASK(1, 0)
+#define PMC_MASK_CLK_FREQ	BIT(2)
+#define PMC_CLK_CTL_GATED_ON_D3	0x0
+#define PMC_CLK_CTL_FORCE_ON	0x1
+#define PMC_CLK_CTL_FORCE_OFF	0x2
+#define PMC_CLK_CTL_RESERVED	0x3
+#define PMC_CLK_FREQ_XTAL	0x0	/* 25 MHz */
+#define PMC_CLK_FREQ_PLL	0x4	/* 19.2 MHz */
+
+struct clk_plt_fixed {
+	struct clk_hw *clk;
+	struct clk_lookup *lookup;
+};
+
+struct clk_plt {
+	struct clk_hw hw;
+	void __iomem *reg;
+	struct clk_lookup *lookup;
+	spinlock_t lock;
+};
+
+#define to_clk_plt(_hw) container_of(_hw, struct clk_plt, hw)
+
+struct clk_plt_data {
+	struct clk_plt_fixed **parents;
+	u8 nparents;
+	struct clk_plt *clks[PMC_CLK_NUM];
+};
+
+static inline int plt_reg_to_parent(int reg)
+{
+	switch (reg & PMC_MASK_CLK_FREQ) {
+	case PMC_CLK_FREQ_XTAL:
+		return 0;	/* index 0 in parents[] */
+	case PMC_CLK_FREQ_PLL:
+		return 1;	/* index 1 in parents[] */
+	}
+
+	return 0;
+}
+
+static inline int plt_parent_to_reg(int index)
+{
+	switch (index) {
+	case 0:	/* index 0 in parents[] */
+		return PMC_CLK_FREQ_XTAL;
+	case 1:	/* index 0 in parents[] */
+		return PMC_CLK_FREQ_PLL;
+	}
+
+	return PMC_CLK_FREQ_XTAL;
+}
+
+static inline int plt_reg_to_enabled(int reg)
+{
+	switch (reg & PMC_MASK_CLK_CTL) {
+	case PMC_CLK_CTL_GATED_ON_D3:
+	case PMC_CLK_CTL_FORCE_ON:
+		return 1;	/* enabled */
+	case PMC_CLK_CTL_FORCE_OFF:
+	case PMC_CLK_CTL_RESERVED:
+	default:
+		return 0;	/* disabled */
+	}
+}
+
+static void plt_clk_reg_update(struct clk_plt *clk, u32 mask, u32 val)
+{
+	u32 orig, tmp;
+	unsigned long flags = 0;
+
+	spin_lock_irqsave(&clk->lock, flags);
+
+	orig = readl(clk->reg);
+
+	tmp = orig & ~mask;
+	tmp |= val & mask;
+
+	if (tmp != orig)
+		writel(tmp, clk->reg);
+
+	spin_unlock_irqrestore(&clk->lock, flags);
+}
+
+static int plt_clk_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct clk_plt *clk = to_clk_plt(hw);
+
+	plt_clk_reg_update(clk, PMC_MASK_CLK_FREQ, plt_parent_to_reg(index));
+
+	return 0;
+}
+
+static u8 plt_clk_get_parent(struct clk_hw *hw)
+{
+	struct clk_plt *clk = to_clk_plt(hw);
+	u32 value;
+
+	value = readl(clk->reg);
+
+	return plt_reg_to_parent(value);
+}
+
+static int plt_clk_enable(struct clk_hw *hw)
+{
+	struct clk_plt *clk = to_clk_plt(hw);
+
+	plt_clk_reg_update(clk, PMC_MASK_CLK_CTL, PMC_CLK_CTL_FORCE_ON);
+
+	return 0;
+}
+
+static void plt_clk_disable(struct clk_hw *hw)
+{
+	struct clk_plt *clk = to_clk_plt(hw);
+
+	plt_clk_reg_update(clk, PMC_MASK_CLK_CTL, PMC_CLK_CTL_FORCE_OFF);
+}
+
+static int plt_clk_is_enabled(struct clk_hw *hw)
+{
+	struct clk_plt *clk = to_clk_plt(hw);
+	u32 value;
+
+	value = readl(clk->reg);
+
+	return plt_reg_to_enabled(value);
+}
+
+static const struct clk_ops plt_clk_ops = {
+	.enable = plt_clk_enable,
+	.disable = plt_clk_disable,
+	.is_enabled = plt_clk_is_enabled,
+	.get_parent = plt_clk_get_parent,
+	.set_parent = plt_clk_set_parent,
+	.determine_rate = __clk_mux_determine_rate,
+};
+
+static struct clk_plt *plt_clk_register(struct platform_device *pdev, int id,
+					void __iomem *base,
+					const char **parent_names,
+					int num_parents)
+{
+	struct clk_plt *pclk;
+	struct clk_init_data init;
+	int ret;
+
+	pclk = devm_kzalloc(&pdev->dev, sizeof(*pclk), GFP_KERNEL);
+	if (!pclk)
+		return ERR_PTR(-ENOMEM);
+
+	init.name =  kasprintf(GFP_KERNEL, "%s%d", PLT_CLK_NAME_BASE, id);
+	init.ops = &plt_clk_ops;
+	init.flags = 0;
+	init.parent_names = parent_names;
+	init.num_parents = num_parents;
+
+	pclk->hw.init = &init;
+	pclk->reg = base + id * PMC_CLK_CTL_SIZE;
+	spin_lock_init(&pclk->lock);
+
+	ret = devm_clk_hw_register(&pdev->dev, &pclk->hw);
+	if (ret)
+		goto err_free_init;
+
+	pclk->lookup = clkdev_hw_create(&pclk->hw, init.name, NULL);
+	if (!pclk->lookup) {
+		ret = -ENOMEM;
+		goto err_free_init;
+	}
+
+	kfree(init.name);
+
+	return pclk;
+
+err_free_init:
+	kfree(init.name);
+	return ERR_PTR(ret);
+}
+
+static void plt_clk_unregister(struct clk_plt *pclk)
+{
+	clkdev_drop(pclk->lookup);
+}
+
+static struct clk_plt_fixed *plt_clk_register_fixed_rate(struct platform_device *pdev,
+						 const char *name,
+						 const char *parent_name,
+						 unsigned long fixed_rate)
+{
+	struct clk_plt_fixed *pclk;
+	int ret = 0;
+
+	pclk = devm_kzalloc(&pdev->dev, sizeof(*pclk), GFP_KERNEL);
+	if (!pclk)
+		return ERR_PTR(-ENOMEM);
+
+	pclk->clk = clk_hw_register_fixed_rate(&pdev->dev, name, parent_name,
+					       0, fixed_rate);
+	if (IS_ERR(pclk->clk))
+		return ERR_CAST(pclk->clk);
+
+	pclk->lookup = clkdev_hw_create(pclk->clk, name, NULL);
+	if (!pclk->lookup) {
+		ret = -ENOMEM;
+		goto err_clk_unregister;
+	}
+
+	return pclk;
+
+err_clk_unregister:
+	clk_hw_unregister_fixed_rate(pclk->clk);
+	return ERR_PTR(ret);
+}
+
+static void plt_clk_unregister_fixed_rate(struct clk_plt_fixed *pclk)
+{
+	clkdev_drop(pclk->lookup);
+	clk_hw_unregister_fixed_rate(pclk->clk);
+}
+
+static const char **plt_clk_register_parents(struct platform_device *pdev,
+					     struct clk_plt_data *data,
+					     const struct pmc_clk *clks)
+{
+	const char **parent_names;
+	int i, err;
+
+	data->nparents = 0;
+	while (clks[data->nparents].name)
+		data->nparents++;
+
+	data->parents = devm_kzalloc(&pdev->dev,
+				     sizeof(*data->parents) * data->nparents,
+				     GFP_KERNEL);
+	if (!data->parents) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	parent_names = kcalloc(data->nparents, sizeof(*parent_names),
+			       GFP_KERNEL);
+	if (!parent_names) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	for (i = 0; i < data->nparents; i++) {
+		data->parents[i] =
+			plt_clk_register_fixed_rate(pdev, clks[i].name,
+						    clks[i].parent_name,
+						    clks[i].freq);
+		if (IS_ERR(data->parents[i])) {
+			err = PTR_ERR(data->parents[i]);
+			goto err_unreg;
+		}
+		parent_names[i] = kstrdup_const(clks[i].name, GFP_KERNEL);
+	}
+
+	return parent_names;
+
+err_unreg:
+	for (i--; i >= 0; i--) {
+		plt_clk_unregister_fixed_rate(data->parents[i]);
+		kfree_const(parent_names[i]);
+	}
+	kfree(parent_names);
+err_out:
+	data->nparents = 0;
+	return ERR_PTR(err);
+}
+
+static void plt_clk_unregister_parents(struct clk_plt_data *data)
+{
+	int i;
+
+	for (i = 0; i < data->nparents; i++)
+		plt_clk_unregister_fixed_rate(data->parents[i]);
+}
+
+static int plt_clk_probe(struct platform_device *pdev)
+{
+	struct clk_plt_data *data;
+	int i, err;
+	const char **parent_names;
+	const struct pmc_clk_data *pmc_data;
+
+	pmc_data = dev_get_platdata(&pdev->dev);
+	if (!pmc_data || !pmc_data->clks)
+		return -EINVAL;
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	parent_names = plt_clk_register_parents(pdev, data, pmc_data->clks);
+	if (IS_ERR(parent_names))
+		return PTR_ERR(parent_names);
+
+	for (i = 0; i < PMC_CLK_NUM; i++) {
+		data->clks[i] = plt_clk_register(pdev, i, pmc_data->base,
+						 parent_names, data->nparents);
+		if (IS_ERR(data->clks[i])) {
+			err = PTR_ERR(data->clks[i]);
+			goto err_unreg_clk_plt;
+		}
+	}
+
+	for (i = 0; i < data->nparents; i++)
+		kfree_const(parent_names[i]);
+	kfree(parent_names);
+
+	dev_set_drvdata(&pdev->dev, data);
+	return 0;
+
+err_unreg_clk_plt:
+	for (i--; i >= 0; i--)
+		plt_clk_unregister(data->clks[i]);
+	plt_clk_unregister_parents(data);
+	for (i = 0; i < data->nparents; i++)
+		kfree_const(parent_names[i]);
+	kfree(parent_names);
+	return err;
+}
+
+static int plt_clk_remove(struct platform_device *pdev)
+{
+	struct clk_plt_data *data;
+	int i;
+
+	data = dev_get_drvdata(&pdev->dev);
+	if (!data)
+		return 0;
+
+	for (i = 0; i < PMC_CLK_NUM; i++)
+		plt_clk_unregister(data->clks[i]);
+	plt_clk_unregister_parents(data);
+	return 0;
+}
+
+static struct platform_driver plt_clk_driver = {
+	.driver = {
+		.name = PLT_CLK_DRIVER_NAME,
+	},
+	.probe = plt_clk_probe,
+	.remove = plt_clk_remove,
+};
+module_platform_driver(plt_clk_driver);
+
+MODULE_DESCRIPTION("Intel Atom platform clocks driver");
+MODULE_AUTHOR("Irina Tirdea <irina.tirdea@intel.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/platform_data/clk-byt-plt.h b/include/linux/platform_data/clk-byt-plt.h
new file mode 100644
index 0000000..e6bca9c
--- /dev/null
+++ b/include/linux/platform_data/clk-byt-plt.h
@@ -0,0 +1,31 @@
+/*
+ * Intel Atom platform clocks for BayTrail and CherryTrail SoC.
+ *
+ * Copyright (C) 2016, Intel Corporation
+ * Author: Irina Tirdea <irina.tirdea@intel.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#ifndef __CLK_BYT_PLT_H
+#define __CLK_BYT_PLT_H
+
+struct pmc_clk {
+	const char *name;
+	unsigned long freq;
+	const char *parent_name;
+};
+
+struct pmc_clk_data {
+	void __iomem *base;
+	const struct pmc_clk *clks;
+};
+
+#endif /* __CLK_BYT_PLT_H */
-- 
1.9.1

