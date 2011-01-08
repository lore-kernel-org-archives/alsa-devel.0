From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH 2/7] ASoC: tegra: Add tegra-das driver
Date: Fri,  7 Jan 2011 22:36:12 -0700
Message-ID: <1294464977-25814-3-git-send-email-swarren@nvidia.com>
References: <1294464977-25814-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id D2C941038C6
	for <alsa-devel@alsa-project.org>; Sat,  8 Jan 2011 06:36:37 +0100 (CET)
In-Reply-To: <1294464977-25814-1-git-send-email-swarren@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

The DAS (Digital Audio Switch) is a mux/crossbar which sits between
the DACs (Digital Audio Controllers) and the DAPs (Digital Audio
Ports). Audio data may be routed between DACs and DAPs in various
combinations as required by board design/application.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/soc/tegra/tegra_das.c |  263 +++++++++++++++++++++++++++++++++++++++++++
 sound/soc/tegra/tegra_das.h |  135 ++++++++++++++++++++++
 2 files changed, 398 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/tegra/tegra_das.c
 create mode 100644 sound/soc/tegra/tegra_das.h

diff --git a/sound/soc/tegra/tegra_das.c b/sound/soc/tegra/tegra_das.c
new file mode 100644
index 0000000..796d36d
--- /dev/null
+++ b/sound/soc/tegra/tegra_das.c
@@ -0,0 +1,263 @@
+/*
+ * tegra_das.c - Tegra DAS driver
+ *
+ * Author: Stephen Warren <swarren@nvidia.com>
+ * Copyright (C) 2010 - NVIDIA, Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/debugfs.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/seq_file.h>
+#include <linux/slab.h>
+#include <linux/io.h>
+#include <mach/iomap.h>
+#include <sound/soc.h>
+#include "tegra_das.h"
+
+#define DRV_NAME "tegra-das"
+
+static struct tegra_das *das;
+
+static inline void tegra_das_write(u32 reg, u32 val)
+{
+	__raw_writel(val, das->regs + reg);
+}
+
+static inline u32 tegra_das_read(u32 reg)
+{
+	return __raw_readl(das->regs + reg);
+}
+
+int tegra_das_connect_dap_to_dac(int dap, int dac)
+{
+	u32 addr;
+	u32 reg;
+
+	if (!das)
+		return -ENODEV;
+
+	addr = TEGRA_DAS_DAP_CTRL_SEL +
+		(dap * TEGRA_DAS_DAP_CTRL_SEL_STRIDE);
+	reg = dac << TEGRA_DAS_DAP_CTRL_SEL_DAP_CTRL_SEL_P;
+
+	tegra_das_write(addr, reg);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tegra_das_connect_dap_to_dac);
+
+int tegra_das_connect_dap_to_dap(int dap, int otherdap, int master,
+					int sdata1rx, int sdata2rx)
+{
+	u32 addr;
+	u32 reg;
+
+	if (!das)
+		return -ENODEV;
+
+	addr = TEGRA_DAS_DAP_CTRL_SEL +
+		(dap * TEGRA_DAS_DAP_CTRL_SEL_STRIDE);
+	reg = otherdap << TEGRA_DAS_DAP_CTRL_SEL_DAP_CTRL_SEL_P |
+		!!sdata2rx << TEGRA_DAS_DAP_CTRL_SEL_DAP_SDATA2_TX_RX_P |
+		!!sdata1rx << TEGRA_DAS_DAP_CTRL_SEL_DAP_SDATA1_TX_RX_P |
+		!!master << TEGRA_DAS_DAP_CTRL_SEL_DAP_MS_SEL_P;
+
+	tegra_das_write(addr, reg);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tegra_das_connect_dap_to_dap);
+
+int tegra_das_connect_dac_to_dap(int dac, int dap)
+{
+	u32 addr;
+	u32 reg;
+
+	if (!das)
+		return -ENODEV;
+
+	addr = TEGRA_DAS_DAC_INPUT_DATA_CLK_SEL +
+		(dac * TEGRA_DAS_DAC_INPUT_DATA_CLK_SEL_STRIDE);
+	reg = dap << TEGRA_DAS_DAC_INPUT_DATA_CLK_SEL_DAC_CLK_SEL_P |
+		dap << TEGRA_DAS_DAC_INPUT_DATA_CLK_SEL_DAC_SDATA1_SEL_P |
+		dap << TEGRA_DAS_DAC_INPUT_DATA_CLK_SEL_DAC_SDATA2_SEL_P;
+
+	tegra_das_write(addr, reg);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tegra_das_connect_dac_to_dap);
+
+#ifdef CONFIG_DEBUG_FS
+static int tegra_das_show(struct seq_file *s, void *unused)
+{
+	int i;
+	u32 addr;
+	u32 reg;
+
+	for (i = 0; i < TEGRA_DAS_DAP_CTRL_SEL_COUNT; i++) {
+		addr = TEGRA_DAS_DAP_CTRL_SEL +
+			(i * TEGRA_DAS_DAP_CTRL_SEL_STRIDE);
+		reg = tegra_das_read(addr);
+		seq_printf(s, "TEGRA_DAS_DAP_CTRL_SEL[%d] = %08x\n", i, reg);
+	}
+
+	for (i = 0; i < TEGRA_DAS_DAC_INPUT_DATA_CLK_SEL_COUNT; i++) {
+		addr = TEGRA_DAS_DAC_INPUT_DATA_CLK_SEL +
+			(i * TEGRA_DAS_DAC_INPUT_DATA_CLK_SEL_STRIDE);
+		reg = tegra_das_read(addr);
+		seq_printf(s, "TEGRA_DAS_DAC_INPUT_DATA_CLK_SEL[%d] = %08x\n",
+				 i, reg);
+	}
+
+	return 0;
+}
+
+static int tegra_das_debug_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, tegra_das_show, inode->i_private);
+}
+
+static const struct file_operations tegra_das_debug_fops = {
+	.open    = tegra_das_debug_open,
+	.read    = seq_read,
+	.llseek  = seq_lseek,
+	.release = single_release,
+};
+
+static void tegra_das_debug_add(struct tegra_das *das)
+{
+	das->debug = debugfs_create_file(DRV_NAME, S_IRUGO, asoc_debugfs_root,
+						das, &tegra_das_debug_fops);
+}
+
+static void tegra_das_debug_remove(struct tegra_das *das)
+{
+	if (das->debug)
+		debugfs_remove(das->debug);
+}
+#else
+static inline void tegra_das_debug_add(struct tegra_das *das)
+{
+}
+
+static inline void tegra_das_debug_remove(struct tegra_das *das)
+{
+}
+#endif
+
+static int __devinit tegra_das_probe(struct platform_device *pdev)
+{
+	struct resource *res, *region;
+	int ret = 0;
+
+	if (das)
+		return -ENODEV;
+
+	das = kzalloc(sizeof(struct tegra_das), GFP_KERNEL);
+	if (!das) {
+		dev_err(&pdev->dev, "Can't allocate tegra_das\n");
+		ret = -ENOMEM;
+		goto exit;
+	}
+	das->dev = &pdev->dev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "No memory resource\n");
+		ret = -ENODEV;
+		goto err_free;
+	}
+
+	region = request_mem_region(res->start, resource_size(res),
+					pdev->name);
+	if (!region) {
+		dev_err(&pdev->dev, "Memory region already claimed\n");
+		ret = -EBUSY;
+		goto err_free;
+	}
+
+	das->regs = ioremap(res->start, resource_size(res));
+	if (!das->regs) {
+		dev_err(&pdev->dev, "ioremap failed\n");
+		ret = -ENOMEM;
+		goto err_release;
+	}
+
+	tegra_das_debug_add(das);
+
+	platform_set_drvdata(pdev, das);
+
+	return 0;
+
+err_release:
+	release_mem_region(res->start, resource_size(res));
+err_free:
+	kfree(das);
+	das = 0;
+exit:
+	return ret;
+}
+
+static int __devexit tegra_das_remove(struct platform_device *pdev)
+{
+	struct resource *res;
+
+	if (!das)
+		return -ENODEV;
+
+	platform_set_drvdata(pdev, NULL);
+
+	tegra_das_debug_remove(das);
+
+	iounmap(das->regs);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	release_mem_region(res->start, resource_size(res));
+
+	kfree(das);
+	das = 0;
+
+	return 0;
+}
+
+static struct platform_driver tegra_das_driver = {
+	.probe = tegra_das_probe,
+	.remove = __devexit_p(tegra_das_remove),
+	.driver = {
+		.name = DRV_NAME,
+	},
+};
+
+static int __init tegra_das_modinit(void)
+{
+	return platform_driver_register(&tegra_das_driver);
+}
+module_init(tegra_das_modinit);
+
+static void __exit tegra_das_modexit(void)
+{
+	platform_driver_unregister(&tegra_das_driver);
+}
+module_exit(tegra_das_modexit);
+
+MODULE_AUTHOR("Stephen Warren <swarren@nvidia.com>");
+MODULE_DESCRIPTION("Tegra DAS driver");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/tegra/tegra_das.h b/sound/soc/tegra/tegra_das.h
new file mode 100644
index 0000000..2c96c7b
--- /dev/null
+++ b/sound/soc/tegra/tegra_das.h
@@ -0,0 +1,135 @@
+/*
+ * tegra_das.h - Definitions for Tegra DAS driver
+ *
+ * Author: Stephen Warren <swarren@nvidia.com>
+ * Copyright (C) 2010 - NVIDIA, Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#ifndef __TEGRA_DAS_H__
+#define __TEGRA_DAS_H__
+
+/* Register TEGRA_DAS_DAP_CTRL_SEL */
+#define TEGRA_DAS_DAP_CTRL_SEL				0x00
+#define TEGRA_DAS_DAP_CTRL_SEL_COUNT			5
+#define TEGRA_DAS_DAP_CTRL_SEL_STRIDE			4
+#define TEGRA_DAS_DAP_CTRL_SEL_DAP_MS_SEL_P		31
+#define TEGRA_DAS_DAP_CTRL_SEL_DAP_MS_SEL_S		1
+#define TEGRA_DAS_DAP_CTRL_SEL_DAP_SDATA1_TX_RX_P	30
+#define TEGRA_DAS_DAP_CTRL_SEL_DAP_SDATA1_TX_RX_S	1
+#define TEGRA_DAS_DAP_CTRL_SEL_DAP_SDATA2_TX_RX_P	29
+#define TEGRA_DAS_DAP_CTRL_SEL_DAP_SDATA2_TX_RX_S	1
+#define TEGRA_DAS_DAP_CTRL_SEL_DAP_CTRL_SEL_P		0
+#define TEGRA_DAS_DAP_CTRL_SEL_DAP_CTRL_SEL_S		5
+
+/* Values for field TEGRA_DAS_DAP_CTRL_SEL_DAP_CTRL_SEL */
+#define TEGRA_DAS_DAP_SEL_DAC1	0
+#define TEGRA_DAS_DAP_SEL_DAC2	1
+#define TEGRA_DAS_DAP_SEL_DAC3	2
+#define TEGRA_DAS_DAP_SEL_DAP1	16
+#define TEGRA_DAS_DAP_SEL_DAP2	17
+#define TEGRA_DAS_DAP_SEL_DAP3	18
+#define TEGRA_DAS_DAP_SEL_DAP4	19
+#define TEGRA_DAS_DAP_SEL_DAP5	20
+
+/* Register TEGRA_DAS_DAC_INPUT_DATA_CLK_SEL */
+#define TEGRA_DAS_DAC_INPUT_DATA_CLK_SEL			0x40
+#define TEGRA_DAS_DAC_INPUT_DATA_CLK_SEL_COUNT			3
+#define TEGRA_DAS_DAC_INPUT_DATA_CLK_SEL_STRIDE			4
+#define TEGRA_DAS_DAC_INPUT_DATA_CLK_SEL_DAC_SDATA2_SEL_P	28
+#define TEGRA_DAS_DAC_INPUT_DATA_CLK_SEL_DAC_SDATA2_SEL_S	4
+#define TEGRA_DAS_DAC_INPUT_DATA_CLK_SEL_DAC_SDATA1_SEL_P	24
+#define TEGRA_DAS_DAC_INPUT_DATA_CLK_SEL_DAC_SDATA1_SEL_S	4
+#define TEGRA_DAS_DAC_INPUT_DATA_CLK_SEL_DAC_CLK_SEL_P		0
+#define TEGRA_DAS_DAC_INPUT_DATA_CLK_SEL_DAC_CLK_SEL_S		4
+
+/*
+ * Values for:
+ * TEGRA_DAS_DAC_INPUT_DATA_CLK_SEL_DAC_SDATA2_SEL
+ * TEGRA_DAS_DAC_INPUT_DATA_CLK_SEL_DAC_SDATA1_SEL
+ * TEGRA_DAS_DAC_INPUT_DATA_CLK_SEL_DAC_CLK_SEL
+ */
+#define TEGRA_DAS_DAC_SEL_DAP1	0
+#define TEGRA_DAS_DAC_SEL_DAP2	1
+#define TEGRA_DAS_DAC_SEL_DAP3	2
+#define TEGRA_DAS_DAC_SEL_DAP4	3
+#define TEGRA_DAS_DAC_SEL_DAP5	4
+
+/*
+ * Names/IDs of the DACs/DAPs.
+ */
+
+#define TEGRA_DAS_DAP_ID_1 0
+#define TEGRA_DAS_DAP_ID_2 1
+#define TEGRA_DAS_DAP_ID_3 2
+#define TEGRA_DAS_DAP_ID_4 3
+#define TEGRA_DAS_DAP_ID_5 4
+
+#define TEGRA_DAS_DAC_ID_1 0
+#define TEGRA_DAS_DAC_ID_2 1
+#define TEGRA_DAS_DAC_ID_3 2
+
+struct tegra_das {
+	struct device *dev;
+	void __iomem *regs;
+	struct dentry *debug;
+};
+
+/*
+ * Terminology:
+ * DAS: Digital audio switch (HW module controlled by this driver)
+ * DAP: Digital audio port (port/pins on Tegra device)
+ * DAC: Digital audio controller (e.g. I2S or AC97 controller elsewhere)
+ * 
+ * The Tegra DAS is a mux/cross-bar which can connect each DAP to a specific
+ * DAC, or another DAP. When DAPs are connected, one must be the master and
+ * one the slave. Each DAC allows selection of a specific DAP for input, to
+ * cater for the case where N DAPs are connected to 1 DAC for broadcast
+ * output.
+ *
+ * This driver is dumb; no attempt is made to ensure that a valid routing
+ * configuration is programmed.
+ */
+
+/*
+ * Connect a DAP to to a DAC
+ * dap_id: DAP to connect: TEGRA_DAS_DAP_ID_*
+ * dac_sel: DAC to connect to: TEGRA_DAS_DAP_SEL_DAC*
+ */
+extern int tegra_das_connect_dap_to_dac(int dap_id, int dac_sel);
+
+/*
+ * Connect a DAP to to another DAP
+ * dap_id: DAP to connect: TEGRA_DAS_DAP_ID_*
+ * other_dap_sel: DAP to connect to: TEGRA_DAS_DAP_SEL_DAP*
+ * master: Is this DAP the master (1) or slave (0)
+ * sdata1rx: Is this DAP's SDATA1 pin RX (1) or TX (0)
+ * sdata2rx: Is this DAP's SDATA2 pin RX (1) or TX (0)
+ */
+extern int tegra_das_connect_dap_to_dap(int dap_id, int other_dap_sel,
+					int master, int sdata1rx,
+					int sdata2rx);
+
+/*
+ * Connect a DAC's input to a DAP
+ * (DAC outputs are selected by the DAP)
+ * dac_id: DAC ID to connect: TEGRA_DAS_DAC_ID_*
+ * dap_sel: DAP to receive input from: TEGRA_DAS_DAC_SEL_DAP*
+ */
+extern int tegra_das_connect_dac_to_dap(int dac_id, int dap_sel);
+
+#endif
-- 
1.7.0.4
