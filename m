From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH] ASoC: tegra: convert to regmap
Date: Tue, 10 Apr 2012 13:16:05 -0600
Message-ID: <1334085365-11189-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id BABBF247B3
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Apr 2012 21:16:17 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

From: Stephen Warren <swarren@nvidia.com>

For the Tegra I2S, SPDIF, and DAS drivers

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
Mark, this depends on the regmap->ASoC git pull request that I just sent.

 sound/soc/tegra/Kconfig         |    1 +
 sound/soc/tegra/tegra20_das.c   |   99 ++++++++--------------
 sound/soc/tegra/tegra20_das.h   |    3 +-
 sound/soc/tegra/tegra20_i2s.c   |  149 ++++++++++++++++-----------------
 sound/soc/tegra/tegra20_i2s.h   |    3 +-
 sound/soc/tegra/tegra20_spdif.c |  177 ++++++++++++++++++++-------------------
 sound/soc/tegra/tegra20_spdif.h |    3 +-
 7 files changed, 203 insertions(+), 232 deletions(-)

diff --git a/sound/soc/tegra/Kconfig b/sound/soc/tegra/Kconfig
index 556cac2..d70fe94 100644
--- a/sound/soc/tegra/Kconfig
+++ b/sound/soc/tegra/Kconfig
@@ -1,6 +1,7 @@
 config SND_SOC_TEGRA
 	tristate "SoC Audio for the Tegra System-on-Chip"
 	depends on ARCH_TEGRA && TEGRA_SYSTEM_DMA
+	select REGMAP_MMIO
 	help
 	  Say Y or M here if you want support for SoC audio on Tegra.
 
diff --git a/sound/soc/tegra/tegra20_das.c b/sound/soc/tegra/tegra20_das.c
index 812696d..dacd5cf 100644
--- a/sound/soc/tegra/tegra20_das.c
+++ b/sound/soc/tegra/tegra20_das.c
@@ -20,12 +20,11 @@
  *
  */
 
-#include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
-#include <linux/seq_file.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 #include <sound/soc.h>
 #include "tegra20_das.h"
@@ -36,12 +35,14 @@ static struct tegra20_das *das;
 
 static inline void tegra20_das_write(u32 reg, u32 val)
 {
-	__raw_writel(val, das->regs + reg);
+	regmap_write(das->regmap, reg, val);
 }
 
 static inline u32 tegra20_das_read(u32 reg)
 {
-	return __raw_readl(das->regs + reg);
+	u32 val;
+	regmap_read(das->regmap, reg, &val);
+	return val;
 }
 
 int tegra20_das_connect_dap_to_dac(int dap, int dac)
@@ -104,68 +105,38 @@ int tegra20_das_connect_dac_to_dap(int dac, int dap)
 }
 EXPORT_SYMBOL_GPL(tegra20_das_connect_dac_to_dap);
 
-#ifdef CONFIG_DEBUG_FS
-static int tegra20_das_show(struct seq_file *s, void *unused)
-{
-	int i;
-	u32 addr;
-	u32 reg;
-
-	for (i = 0; i < TEGRA20_DAS_DAP_CTRL_SEL_COUNT; i++) {
-		addr = TEGRA20_DAS_DAP_CTRL_SEL +
-			(i * TEGRA20_DAS_DAP_CTRL_SEL_STRIDE);
-		reg = tegra20_das_read(addr);
-		seq_printf(s, "TEGRA20_DAS_DAP_CTRL_SEL[%d] = %08x\n", i, reg);
-	}
-
-	for (i = 0; i < TEGRA20_DAS_DAC_INPUT_DATA_CLK_SEL_COUNT; i++) {
-		addr = TEGRA20_DAS_DAC_INPUT_DATA_CLK_SEL +
-			(i * TEGRA20_DAS_DAC_INPUT_DATA_CLK_SEL_STRIDE);
-		reg = tegra20_das_read(addr);
-		seq_printf(s, "TEGRA20_DAS_DAC_INPUT_DATA_CLK_SEL[%d] = %08x\n",
-			   i, reg);
-	}
-
-	return 0;
-}
-
-static int tegra20_das_debug_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, tegra20_das_show, inode->i_private);
-}
+#define LAST_REG(name) \
+	(TEGRA20_DAS_##name + \
+		(TEGRA20_DAS_##name##_STRIDE * TEGRA20_DAS_##name##_COUNT) - 4)
 
-static const struct file_operations tegra20_das_debug_fops = {
-	.open    = tegra20_das_debug_open,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = single_release,
-};
+#define REG_IN_ARRAY(reg, name) \
+	((reg >= TEGRA20_DAS_##name) && \
+	 (reg <= LAST_REG(name) && \
+	 (!((reg - TEGRA20_DAS_##name) % TEGRA20_DAS_##name##_STRIDE))))
 
-static void tegra20_das_debug_add(struct tegra20_das *das)
+static bool tegra20_das_wr_rd_reg(struct device *dev, unsigned int reg)
 {
-	das->debug = debugfs_create_file(DRV_NAME, S_IRUGO,
-					 snd_soc_debugfs_root, das,
-					 &tegra20_das_debug_fops);
-}
+	if (REG_IN_ARRAY(reg, DAP_CTRL_SEL) ||
+	    REG_IN_ARRAY(reg, DAC_INPUT_DATA_CLK_SEL))
+		return true;
 
-static void tegra20_das_debug_remove(struct tegra20_das *das)
-{
-	if (das->debug)
-		debugfs_remove(das->debug);
-}
-#else
-static inline void tegra20_das_debug_add(struct tegra20_das *das)
-{
+	return false;
 }
 
-static inline void tegra20_das_debug_remove(struct tegra20_das *das)
-{
-}
-#endif
+static const struct regmap_config tegra20_das_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = LAST_REG(DAC_INPUT_DATA_CLK_SEL),
+	.writeable_reg = tegra20_das_wr_rd_reg,
+	.readable_reg = tegra20_das_wr_rd_reg,
+	.cache_type = REGCACHE_RBTREE,
+};
 
 static int __devinit tegra20_das_probe(struct platform_device *pdev)
 {
 	struct resource *res, *region;
+	void __iomem *regs;
 	int ret = 0;
 
 	if (das)
@@ -194,13 +165,21 @@ static int __devinit tegra20_das_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	das->regs = devm_ioremap(&pdev->dev, res->start, resource_size(res));
-	if (!das->regs) {
+	regs = devm_ioremap(&pdev->dev, res->start, resource_size(res));
+	if (!regs) {
 		dev_err(&pdev->dev, "ioremap failed\n");
 		ret = -ENOMEM;
 		goto err;
 	}
 
+	das->regmap = devm_regmap_init_mmio(&pdev->dev, regs,
+					    &tegra20_das_regmap_config);
+	if (IS_ERR(das->regmap)) {
+		dev_err(&pdev->dev, "regmap init failed\n");
+		ret = PTR_ERR(das->regmap);
+		goto err;
+	}
+
 	ret = tegra20_das_connect_dap_to_dac(TEGRA20_DAS_DAP_ID_1,
 					     TEGRA20_DAS_DAP_SEL_DAC1);
 	if (ret) {
@@ -214,8 +193,6 @@ static int __devinit tegra20_das_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	tegra20_das_debug_add(das);
-
 	platform_set_drvdata(pdev, das);
 
 	return 0;
@@ -230,8 +207,6 @@ static int __devexit tegra20_das_remove(struct platform_device *pdev)
 	if (!das)
 		return -ENODEV;
 
-	tegra20_das_debug_remove(das);
-
 	das = NULL;
 
 	return 0;
diff --git a/sound/soc/tegra/tegra20_das.h b/sound/soc/tegra/tegra20_das.h
index ade4fe0..be217f3 100644
--- a/sound/soc/tegra/tegra20_das.h
+++ b/sound/soc/tegra/tegra20_das.h
@@ -85,8 +85,7 @@
 
 struct tegra20_das {
 	struct device *dev;
-	void __iomem *regs;
-	struct dentry *debug;
+	struct regmap *regmap;
 };
 
 /*
diff --git a/sound/soc/tegra/tegra20_i2s.c b/sound/soc/tegra/tegra20_i2s.c
index 6957658..0c7af63 100644
--- a/sound/soc/tegra/tegra20_i2s.c
+++ b/sound/soc/tegra/tegra20_i2s.c
@@ -29,14 +29,13 @@
  */
 
 #include <linux/clk.h>
-#include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
-#include <linux/seq_file.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -49,12 +48,14 @@
 
 static inline void tegra20_i2s_write(struct tegra20_i2s *i2s, u32 reg, u32 val)
 {
-	__raw_writel(val, i2s->regs + reg);
+	regmap_write(i2s->regmap, reg, val);
 }
 
 static inline u32 tegra20_i2s_read(struct tegra20_i2s *i2s, u32 reg)
 {
-	return __raw_readl(i2s->regs + reg);
+	u32 val;
+	regmap_read(i2s->regmap, reg, &val);
+	return val;
 }
 
 static int tegra20_i2s_runtime_suspend(struct device *dev)
@@ -80,74 +81,6 @@ static int tegra20_i2s_runtime_resume(struct device *dev)
 	return 0;
 }
 
-#ifdef CONFIG_DEBUG_FS
-static int tegra20_i2s_show(struct seq_file *s, void *unused)
-{
-#define REG(r) { r, #r }
-	static const struct {
-		int offset;
-		const char *name;
-	} regs[] = {
-		REG(TEGRA20_I2S_CTRL),
-		REG(TEGRA20_I2S_STATUS),
-		REG(TEGRA20_I2S_TIMING),
-		REG(TEGRA20_I2S_FIFO_SCR),
-		REG(TEGRA20_I2S_PCM_CTRL),
-		REG(TEGRA20_I2S_NW_CTRL),
-		REG(TEGRA20_I2S_TDM_CTRL),
-		REG(TEGRA20_I2S_TDM_TX_RX_CTRL),
-	};
-#undef REG
-
-	struct tegra20_i2s *i2s = s->private;
-	int i;
-
-	clk_enable(i2s->clk_i2s);
-
-	for (i = 0; i < ARRAY_SIZE(regs); i++) {
-		u32 val = tegra20_i2s_read(i2s, regs[i].offset);
-		seq_printf(s, "%s = %08x\n", regs[i].name, val);
-	}
-
-	clk_disable(i2s->clk_i2s);
-
-	return 0;
-}
-
-static int tegra20_i2s_debug_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, tegra20_i2s_show, inode->i_private);
-}
-
-static const struct file_operations tegra20_i2s_debug_fops = {
-	.open    = tegra20_i2s_debug_open,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = single_release,
-};
-
-static void tegra20_i2s_debug_add(struct tegra20_i2s *i2s)
-{
-	i2s->debug = debugfs_create_file(i2s->dai.name, S_IRUGO,
-					 snd_soc_debugfs_root, i2s,
-					 &tegra20_i2s_debug_fops);
-}
-
-static void tegra20_i2s_debug_remove(struct tegra20_i2s *i2s)
-{
-	if (i2s->debug)
-		debugfs_remove(i2s->debug);
-}
-#else
-static inline void tegra20_i2s_debug_add(struct tegra_i2s *i2s)
-{
-}
-
-static inline void tegra20_i2s_debug_remove(struct tegra20_i2s *i2s)
-{
-}
-#endif
-
 static int tegra20_i2s_set_fmt(struct snd_soc_dai *dai,
 				unsigned int fmt)
 {
@@ -343,12 +276,68 @@ static const struct snd_soc_dai_driver tegra20_i2s_dai_template = {
 	.symmetric_rates = 1,
 };
 
+static bool tegra20_i2s_wr_rd_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case TEGRA20_I2S_CTRL:
+	case TEGRA20_I2S_STATUS:
+	case TEGRA20_I2S_TIMING:
+	case TEGRA20_I2S_FIFO_SCR:
+	case TEGRA20_I2S_PCM_CTRL:
+	case TEGRA20_I2S_NW_CTRL:
+	case TEGRA20_I2S_TDM_CTRL:
+	case TEGRA20_I2S_TDM_TX_RX_CTRL:
+	case TEGRA20_I2S_FIFO1:
+	case TEGRA20_I2S_FIFO2:
+		return true;
+	default:
+		return false;
+	};
+}
+
+static bool tegra20_i2s_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case TEGRA20_I2S_STATUS:
+	case TEGRA20_I2S_FIFO_SCR:
+	case TEGRA20_I2S_FIFO1:
+	case TEGRA20_I2S_FIFO2:
+		return true;
+	default:
+		return false;
+	};
+}
+
+static bool tegra20_i2s_precious_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case TEGRA20_I2S_FIFO1:
+	case TEGRA20_I2S_FIFO2:
+		return true;
+	default:
+		return false;
+	};
+}
+
+static const struct regmap_config tegra20_i2s_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = TEGRA20_I2S_FIFO2,
+	.writeable_reg = tegra20_i2s_wr_rd_reg,
+	.readable_reg = tegra20_i2s_wr_rd_reg,
+	.volatile_reg = tegra20_i2s_volatile_reg,
+	.precious_reg = tegra20_i2s_precious_reg,
+	.cache_type = REGCACHE_RBTREE,
+};
+
 static __devinit int tegra20_i2s_platform_probe(struct platform_device *pdev)
 {
 	struct tegra20_i2s *i2s;
 	struct resource *mem, *memregion, *dmareq;
 	u32 of_dma[2];
 	u32 dma_ch;
+	void __iomem *regs;
 	int ret;
 
 	i2s = devm_kzalloc(&pdev->dev, sizeof(struct tegra20_i2s), GFP_KERNEL);
@@ -398,13 +387,21 @@ static __devinit int tegra20_i2s_platform_probe(struct platform_device *pdev)
 		goto err_clk_put;
 	}
 
-	i2s->regs = devm_ioremap(&pdev->dev, mem->start, resource_size(mem));
-	if (!i2s->regs) {
+	regs = devm_ioremap(&pdev->dev, mem->start, resource_size(mem));
+	if (!regs) {
 		dev_err(&pdev->dev, "ioremap failed\n");
 		ret = -ENOMEM;
 		goto err_clk_put;
 	}
 
+	i2s->regmap = devm_regmap_init_mmio(&pdev->dev, regs,
+					    &tegra20_i2s_regmap_config);
+	if (IS_ERR(i2s->regmap)) {
+		dev_err(&pdev->dev, "regmap init failed\n");
+		ret = PTR_ERR(i2s->regmap);
+		goto err_clk_put;
+	}
+
 	i2s->capture_dma_data.addr = mem->start + TEGRA20_I2S_FIFO2;
 	i2s->capture_dma_data.wrap = 4;
 	i2s->capture_dma_data.width = 32;
@@ -437,8 +434,6 @@ static __devinit int tegra20_i2s_platform_probe(struct platform_device *pdev)
 		goto err_unregister_dai;
 	}
 
-	tegra20_i2s_debug_add(i2s);
-
 	return 0;
 
 err_unregister_dai:
@@ -465,8 +460,6 @@ static int __devexit tegra20_i2s_platform_remove(struct platform_device *pdev)
 	tegra_pcm_platform_unregister(&pdev->dev);
 	snd_soc_unregister_dai(&pdev->dev);
 
-	tegra20_i2s_debug_remove(i2s);
-
 	clk_put(i2s->clk_i2s);
 
 	return 0;
diff --git a/sound/soc/tegra/tegra20_i2s.h b/sound/soc/tegra/tegra20_i2s.h
index 86ab327..a57efc6 100644
--- a/sound/soc/tegra/tegra20_i2s.h
+++ b/sound/soc/tegra/tegra20_i2s.h
@@ -157,8 +157,7 @@ struct tegra20_i2s {
 	struct clk *clk_i2s;
 	struct tegra_pcm_dma_params capture_dma_data;
 	struct tegra_pcm_dma_params playback_dma_data;
-	void __iomem *regs;
-	struct dentry *debug;
+	struct regmap *regmap;
 	u32 reg_ctrl;
 };
 
diff --git a/sound/soc/tegra/tegra20_spdif.c b/sound/soc/tegra/tegra20_spdif.c
index 94c5764..f9b5741 100644
--- a/sound/soc/tegra/tegra20_spdif.c
+++ b/sound/soc/tegra/tegra20_spdif.c
@@ -21,13 +21,12 @@
  */
 
 #include <linux/clk.h>
-#include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
-#include <linux/seq_file.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -41,12 +40,14 @@
 static inline void tegra20_spdif_write(struct tegra20_spdif *spdif, u32 reg,
 					u32 val)
 {
-	__raw_writel(val, spdif->regs + reg);
+	regmap_write(spdif->regmap, reg, val);
 }
 
 static inline u32 tegra20_spdif_read(struct tegra20_spdif *spdif, u32 reg)
 {
-	return __raw_readl(spdif->regs + reg);
+	u32 val;
+	regmap_read(spdif->regmap, reg, &val);
+	return val;
 }
 
 static int tegra20_spdif_runtime_suspend(struct device *dev)
@@ -72,82 +73,6 @@ static int tegra20_spdif_runtime_resume(struct device *dev)
 	return 0;
 }
 
-#ifdef CONFIG_DEBUG_FS
-static int tegra20_spdif_show(struct seq_file *s, void *unused)
-{
-#define REG(r) { r, #r }
-	static const struct {
-		int offset;
-		const char *name;
-	} regs[] = {
-		REG(TEGRA20_SPDIF_CTRL),
-		REG(TEGRA20_SPDIF_STATUS),
-		REG(TEGRA20_SPDIF_STROBE_CTRL),
-		REG(TEGRA20_SPDIF_DATA_FIFO_CSR),
-		REG(TEGRA20_SPDIF_CH_STA_RX_A),
-		REG(TEGRA20_SPDIF_CH_STA_RX_B),
-		REG(TEGRA20_SPDIF_CH_STA_RX_C),
-		REG(TEGRA20_SPDIF_CH_STA_RX_D),
-		REG(TEGRA20_SPDIF_CH_STA_RX_E),
-		REG(TEGRA20_SPDIF_CH_STA_RX_F),
-		REG(TEGRA20_SPDIF_CH_STA_TX_A),
-		REG(TEGRA20_SPDIF_CH_STA_TX_B),
-		REG(TEGRA20_SPDIF_CH_STA_TX_C),
-		REG(TEGRA20_SPDIF_CH_STA_TX_D),
-		REG(TEGRA20_SPDIF_CH_STA_TX_E),
-		REG(TEGRA20_SPDIF_CH_STA_TX_F),
-	};
-#undef REG
-
-	struct tegra20_spdif *spdif = s->private;
-	int i;
-
-	clk_enable(spdif->clk_spdif_out);
-
-	for (i = 0; i < ARRAY_SIZE(regs); i++) {
-		u32 val = tegra20_spdif_read(spdif, regs[i].offset);
-		seq_printf(s, "%s = %08x\n", regs[i].name, val);
-	}
-
-	clk_disable(spdif->clk_spdif_out);
-
-	return 0;
-}
-
-static int tegra20_spdif_debug_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, tegra20_spdif_show, inode->i_private);
-}
-
-static const struct file_operations tegra20_spdif_debug_fops = {
-	.open    = tegra20_spdif_debug_open,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = single_release,
-};
-
-static void tegra20_spdif_debug_add(struct tegra20_spdif *spdif)
-{
-	spdif->debug = debugfs_create_file(DRV_NAME, S_IRUGO,
-						snd_soc_debugfs_root, spdif,
-						&tegra20_spdif_debug_fops);
-}
-
-static void tegra20_spdif_debug_remove(struct tegra20_spdif *spdif)
-{
-	if (spdif->debug)
-		debugfs_remove(spdif->debug);
-}
-#else
-static inline void tegra20_spdif_debug_add(struct tegra20_spdif *spdif)
-{
-}
-
-static inline void tegra20_spdif_debug_remove(struct tegra20_spdif *spdif)
-{
-}
-#endif
-
 static int tegra20_spdif_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params,
 				struct snd_soc_dai *dai)
@@ -265,10 +190,86 @@ static struct snd_soc_dai_driver tegra20_spdif_dai = {
 	.ops = &tegra20_spdif_dai_ops,
 };
 
+static bool tegra20_spdif_wr_rd_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case TEGRA20_SPDIF_CTRL:
+	case TEGRA20_SPDIF_STATUS:
+	case TEGRA20_SPDIF_STROBE_CTRL:
+	case TEGRA20_SPDIF_DATA_FIFO_CSR:
+	case TEGRA20_SPDIF_DATA_OUT:
+	case TEGRA20_SPDIF_DATA_IN:
+	case TEGRA20_SPDIF_CH_STA_RX_A:
+	case TEGRA20_SPDIF_CH_STA_RX_B:
+	case TEGRA20_SPDIF_CH_STA_RX_C:
+	case TEGRA20_SPDIF_CH_STA_RX_D:
+	case TEGRA20_SPDIF_CH_STA_RX_E:
+	case TEGRA20_SPDIF_CH_STA_RX_F:
+	case TEGRA20_SPDIF_CH_STA_TX_A:
+	case TEGRA20_SPDIF_CH_STA_TX_B:
+	case TEGRA20_SPDIF_CH_STA_TX_C:
+	case TEGRA20_SPDIF_CH_STA_TX_D:
+	case TEGRA20_SPDIF_CH_STA_TX_E:
+	case TEGRA20_SPDIF_CH_STA_TX_F:
+	case TEGRA20_SPDIF_USR_STA_RX_A:
+	case TEGRA20_SPDIF_USR_DAT_TX_A:
+		return true;
+	default:
+		return false;
+	};
+}
+
+static bool tegra20_spdif_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case TEGRA20_SPDIF_STATUS:
+	case TEGRA20_SPDIF_DATA_FIFO_CSR:
+	case TEGRA20_SPDIF_DATA_OUT:
+	case TEGRA20_SPDIF_DATA_IN:
+	case TEGRA20_SPDIF_CH_STA_RX_A:
+	case TEGRA20_SPDIF_CH_STA_RX_B:
+	case TEGRA20_SPDIF_CH_STA_RX_C:
+	case TEGRA20_SPDIF_CH_STA_RX_D:
+	case TEGRA20_SPDIF_CH_STA_RX_E:
+	case TEGRA20_SPDIF_CH_STA_RX_F:
+	case TEGRA20_SPDIF_USR_STA_RX_A:
+	case TEGRA20_SPDIF_USR_DAT_TX_A:
+		return true;
+	default:
+		return false;
+	};
+}
+
+static bool tegra20_spdif_precious_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case TEGRA20_SPDIF_DATA_OUT:
+	case TEGRA20_SPDIF_DATA_IN:
+	case TEGRA20_SPDIF_USR_STA_RX_A:
+	case TEGRA20_SPDIF_USR_DAT_TX_A:
+		return true;
+	default:
+		return false;
+	};
+}
+
+static const struct regmap_config tegra20_spdif_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = TEGRA20_SPDIF_USR_DAT_TX_A,
+	.writeable_reg = tegra20_spdif_wr_rd_reg,
+	.readable_reg = tegra20_spdif_wr_rd_reg,
+	.volatile_reg = tegra20_spdif_volatile_reg,
+	.precious_reg = tegra20_spdif_precious_reg,
+	.cache_type = REGCACHE_RBTREE,
+};
+
 static __devinit int tegra20_spdif_platform_probe(struct platform_device *pdev)
 {
 	struct tegra20_spdif *spdif;
 	struct resource *mem, *memregion, *dmareq;
+	void __iomem *regs;
 	int ret;
 
 	spdif = devm_kzalloc(&pdev->dev, sizeof(struct tegra20_spdif),
@@ -309,13 +310,21 @@ static __devinit int tegra20_spdif_platform_probe(struct platform_device *pdev)
 		goto err_clk_put;
 	}
 
-	spdif->regs = devm_ioremap(&pdev->dev, mem->start, resource_size(mem));
-	if (!spdif->regs) {
+	regs = devm_ioremap(&pdev->dev, mem->start, resource_size(mem));
+	if (!regs) {
 		dev_err(&pdev->dev, "ioremap failed\n");
 		ret = -ENOMEM;
 		goto err_clk_put;
 	}
 
+	spdif->regmap = devm_regmap_init_mmio(&pdev->dev, regs,
+					    &tegra20_spdif_regmap_config);
+	if (IS_ERR(spdif->regmap)) {
+		dev_err(&pdev->dev, "regmap init failed\n");
+		ret = PTR_ERR(spdif->regmap);
+		goto err_clk_put;
+	}
+
 	spdif->playback_dma_data.addr = mem->start + TEGRA20_SPDIF_DATA_OUT;
 	spdif->playback_dma_data.wrap = 4;
 	spdif->playback_dma_data.width = 32;
@@ -341,8 +350,6 @@ static __devinit int tegra20_spdif_platform_probe(struct platform_device *pdev)
 		goto err_unregister_dai;
 	}
 
-	tegra20_spdif_debug_add(spdif);
-
 	return 0;
 
 err_unregister_dai:
@@ -369,8 +376,6 @@ static int __devexit tegra20_spdif_platform_remove(struct platform_device *pdev)
 	tegra_pcm_platform_unregister(&pdev->dev);
 	snd_soc_unregister_dai(&pdev->dev);
 
-	tegra20_spdif_debug_remove(spdif);
-
 	clk_put(spdif->clk_spdif_out);
 
 	return 0;
diff --git a/sound/soc/tegra/tegra20_spdif.h b/sound/soc/tegra/tegra20_spdif.h
index 823af4c..ed75652 100644
--- a/sound/soc/tegra/tegra20_spdif.h
+++ b/sound/soc/tegra/tegra20_spdif.h
@@ -464,8 +464,7 @@ struct tegra20_spdif {
 	struct clk *clk_spdif_out;
 	struct tegra_pcm_dma_params capture_dma_data;
 	struct tegra_pcm_dma_params playback_dma_data;
-	void __iomem *regs;
-	struct dentry *debug;
+	struct regmap *regmap;
 	u32 reg_ctrl;
 };
 
-- 
1.7.0.4
