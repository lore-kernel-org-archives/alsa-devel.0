From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH V2 1/3] ASoC: tegra: add tegra30-ahub driver
Date: Tue, 10 Apr 2012 16:31:59 -0600
Message-ID: <1334097121-18897-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 9C54A103FD9
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Apr 2012 00:32:13 +0200 (CEST)
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

The AHUB (Audio Hub) is a mux/crossbar which links all audio-related
devices except the HDA controller on Tegra30. The devices include the
DMA FIFOs, DAM (Digital Audio Mixers), I2S controllers, and SPDIF
controller. Audio data may be routed between these devices in various
combinations as required by board design/application.

Includes a squashed bugfix from Nikesh Oswal <noswal@nvidia.com>
Includes squashed bugfixes from Sumit Bhattacharya <sumitb@nvidia.com>

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
This depends on:
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git topic/stride

This addresses all the concerns previously raised, except:
* The AHUB driver is still not a CODEC; unless I'm missing something, I
  don't believe the core ASoC infra-structure is in place to do that yet.
* The AHUB device is not explicitly mentioned in the nvidia,tegra-audio-wm8903
  device tree node. You'd argued it would be a good idea to represent the AHUB
  there to avoid future churn to the machine drivers. However, I think there
  will be churn for other reasons in the machine driver and possibly a
  different top-level dt binding required to start representing things
  generically, so adding the AHUB now wouldn't avoid any future churn.

v2:
* s/EXPORT_SYMBOL/EXPORT_SYMBOL_GPL/. Fix comment that stated direct
  I2S<->I2S connections were unlikely.
* Explicitly treat the AHUB as a bus. Invoke of_platform_populate() to
  create child devices.
* Remove tegra30_ahub_is_probed() function and related logic.
* Correct APBIF reg size in DT binding example
* Added runtime PM support
* Document CIF IDs for use in child device bindings

 .../bindings/sound/nvidia,tegra30-ahub.txt         |   32 +
 sound/soc/tegra/tegra30_ahub.c                     |  631 ++++++++++++++++++++
 sound/soc/tegra/tegra30_ahub.h                     |  483 +++++++++++++++
 3 files changed, 1146 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra30-ahub.txt
 create mode 100644 sound/soc/tegra/tegra30_ahub.c
 create mode 100644 sound/soc/tegra/tegra30_ahub.h

diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra30-ahub.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra30-ahub.txt
new file mode 100644
index 0000000..1ac7b16
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra30-ahub.txt
@@ -0,0 +1,32 @@
+NVIDIA Tegra30 AHUB (Audio Hub)
+
+Required properties:
+- compatible : "nvidia,tegra30-ahub"
+- reg : Should contain the register physical address and length for each of
+  the AHUB's APBIF registers and the AHUB's own registers.
+- interrupts : Should contain AHUB interrupt
+- nvidia,dma-request-selector : The Tegra DMA controller's phandle and
+  request selector for the first APBIF channel.
+- ranges : The bus address mapping for the configlink register bus.
+  Can be empty since the mapping is 1:1.
+- #address-cells : For the configlink bus. Should be <1>;
+- #size-cells : For the configlink bus. Should be <1>.
+
+AHUB client modules need to specify the IDs of their CIFs (Client InterFaces).
+For RX CIFs, the numbers indicate the register number within AHUB routing
+register space (APBIF 0..3 RX, I2S 0..5 RX, DAM 0..2 RX 0..1, SPDIF RX 0..1).
+For TX CIFs, the numbers indicate the bit position within the AHUB routing
+registers (APBIF 0..3 TX, I2S 0..5 TX, DAM 0..2 TX, SPDIF TX 0..1).
+
+Example:
+
+ahub@70080000 {
+	compatible = "nvidia,tegra30-ahub";
+	reg = <0x70080000 0x200 0x70080200 0x100>;
+	interrupts = < 0 103 0x04 >;
+	nvidia,dma-request-selector = <&apbdma 1>;
+
+	ranges;
+	#address-cells = <1>;
+	#size-cells = <1>;
+};
diff --git a/sound/soc/tegra/tegra30_ahub.c b/sound/soc/tegra/tegra30_ahub.c
new file mode 100644
index 0000000..57cd419
--- /dev/null
+++ b/sound/soc/tegra/tegra30_ahub.c
@@ -0,0 +1,631 @@
+/*
+ * tegra30_ahub.c - Tegra30 AHUB driver
+ *
+ * Copyright (c) 2011,2012, NVIDIA CORPORATION.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <mach/clk.h>
+#include <mach/dma.h>
+#include <sound/soc.h>
+#include "tegra30_ahub.h"
+
+#define DRV_NAME "tegra30-ahub"
+
+static struct tegra30_ahub *ahub;
+
+static inline void tegra30_apbif_write(u32 reg, u32 val)
+{
+	regmap_write(ahub->regmap_apbif, reg, val);
+}
+
+static inline u32 tegra30_apbif_read(u32 reg)
+{
+	u32 val;
+	regmap_read(ahub->regmap_apbif, reg, &val);
+	return val;
+}
+
+static inline void tegra30_audio_write(u32 reg, u32 val)
+{
+	regmap_write(ahub->regmap_ahub, reg, val);
+}
+
+static int tegra30_ahub_runtime_suspend(struct device *dev)
+{
+	regcache_cache_only(ahub->regmap_apbif, true);
+	regcache_cache_only(ahub->regmap_ahub, true);
+
+	clk_disable(ahub->clk_apbif);
+	clk_disable(ahub->clk_d_audio);
+
+	return 0;
+}
+
+/*
+ * clk_apbif isn't required for an I2S<->I2S configuration where no PCM data
+ * is read from or sent to memory. However, that's not something the rest of
+ * the driver supports right now, so we'll just treat the two clocks as one
+ * for now.
+ *
+ * These functions should not be a plain ref-count. Instead, each active stream
+ * contributes some requirement to the minimum clock rate, so starting or
+ * stopping streams should dynamically adjust the clock as required.  However,
+ * this is not yet implemented.
+ */
+static int tegra30_ahub_runtime_resume(struct device *dev)
+{
+	int ret;
+
+	ret = clk_enable(ahub->clk_d_audio);
+	if (ret) {
+		dev_err(dev, "clk_enable d_audio failed: %d\n", ret);
+		return ret;
+	}
+	ret = clk_enable(ahub->clk_apbif);
+	if (ret) {
+		dev_err(dev, "clk_enable apbif failed: %d\n", ret);
+		clk_disable(ahub->clk_d_audio);
+		return ret;
+	}
+
+	regcache_cache_only(ahub->regmap_apbif, false);
+	regcache_cache_only(ahub->regmap_ahub, false);
+
+	return 0;
+}
+
+int tegra30_ahub_allocate_rx_fifo(enum tegra30_ahub_rxcif *rxcif,
+				  unsigned long *fiforeg,
+				  unsigned long *reqsel)
+{
+	int channel;
+	u32 reg, val;
+
+	channel = find_first_zero_bit(ahub->rx_usage,
+				      TEGRA30_AHUB_CHANNEL_CTRL_COUNT);
+	if (channel >= TEGRA30_AHUB_CHANNEL_CTRL_COUNT)
+		return -EBUSY;
+
+	__set_bit(channel, ahub->rx_usage);
+
+	*rxcif = TEGRA30_AHUB_RXCIF_APBIF_RX0 + channel;
+	*fiforeg = ahub->apbif_addr + TEGRA30_AHUB_CHANNEL_RXFIFO +
+		   (channel * TEGRA30_AHUB_CHANNEL_RXFIFO_STRIDE);
+	*reqsel = ahub->dma_sel + channel;
+
+	reg = TEGRA30_AHUB_CHANNEL_CTRL +
+	      (channel * TEGRA30_AHUB_CHANNEL_CTRL_STRIDE);
+	val = tegra30_apbif_read(reg);
+	val &= ~(TEGRA30_AHUB_CHANNEL_CTRL_RX_THRESHOLD_MASK |
+		 TEGRA30_AHUB_CHANNEL_CTRL_RX_PACK_MASK);
+	val |= (7 << TEGRA30_AHUB_CHANNEL_CTRL_RX_THRESHOLD_SHIFT) |
+	       TEGRA30_AHUB_CHANNEL_CTRL_RX_PACK_EN |
+	       TEGRA30_AHUB_CHANNEL_CTRL_RX_PACK_16;
+	tegra30_apbif_write(reg, val);
+
+	reg = TEGRA30_AHUB_CIF_RX_CTRL +
+	      (channel * TEGRA30_AHUB_CIF_RX_CTRL_STRIDE);
+	val = (0 << TEGRA30_AUDIOCIF_CTRL_FIFO_THRESHOLD_SHIFT) |
+	      (1 << TEGRA30_AUDIOCIF_CTRL_AUDIO_CHANNELS_SHIFT) |
+	      (1 << TEGRA30_AUDIOCIF_CTRL_CLIENT_CHANNELS_SHIFT) |
+	      TEGRA30_AUDIOCIF_CTRL_AUDIO_BITS_16 |
+	      TEGRA30_AUDIOCIF_CTRL_CLIENT_BITS_16 |
+	      TEGRA30_AUDIOCIF_CTRL_DIRECTION_RX;
+	tegra30_apbif_write(reg, val);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tegra30_ahub_allocate_rx_fifo);
+
+int tegra30_ahub_enable_rx_fifo(enum tegra30_ahub_rxcif rxcif)
+{
+	int channel = rxcif - TEGRA30_AHUB_RXCIF_APBIF_RX0;
+	int reg, val;
+
+	reg = TEGRA30_AHUB_CHANNEL_CTRL +
+	      (channel * TEGRA30_AHUB_CHANNEL_CTRL_STRIDE);
+	val = tegra30_apbif_read(reg);
+	val |= TEGRA30_AHUB_CHANNEL_CTRL_RX_EN;
+	tegra30_apbif_write(reg, val);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tegra30_ahub_enable_rx_fifo);
+
+int tegra30_ahub_disable_rx_fifo(enum tegra30_ahub_rxcif rxcif)
+{
+	int channel = rxcif - TEGRA30_AHUB_RXCIF_APBIF_RX0;
+	int reg, val;
+
+	reg = TEGRA30_AHUB_CHANNEL_CTRL +
+	      (channel * TEGRA30_AHUB_CHANNEL_CTRL_STRIDE);
+	val = tegra30_apbif_read(reg);
+	val &= ~TEGRA30_AHUB_CHANNEL_CTRL_RX_EN;
+	tegra30_apbif_write(reg, val);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tegra30_ahub_disable_rx_fifo);
+
+int tegra30_ahub_free_rx_fifo(enum tegra30_ahub_rxcif rxcif)
+{
+	int channel = rxcif - TEGRA30_AHUB_RXCIF_APBIF_RX0;
+
+	__clear_bit(channel, ahub->rx_usage);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tegra30_ahub_free_rx_fifo);
+
+int tegra30_ahub_allocate_tx_fifo(enum tegra30_ahub_txcif *txcif,
+				  unsigned long *fiforeg,
+				  unsigned long *reqsel)
+{
+	int channel;
+	u32 reg, val;
+
+	channel = find_first_zero_bit(ahub->tx_usage,
+				      TEGRA30_AHUB_CHANNEL_CTRL_COUNT);
+	if (channel >= TEGRA30_AHUB_CHANNEL_CTRL_COUNT)
+		return -EBUSY;
+
+	__set_bit(channel, ahub->tx_usage);
+
+	*txcif = TEGRA30_AHUB_TXCIF_APBIF_TX0 + channel;
+	*fiforeg = ahub->apbif_addr + TEGRA30_AHUB_CHANNEL_TXFIFO +
+		   (channel * TEGRA30_AHUB_CHANNEL_TXFIFO_STRIDE);
+	*reqsel = ahub->dma_sel + channel;
+
+	reg = TEGRA30_AHUB_CHANNEL_CTRL +
+	      (channel * TEGRA30_AHUB_CHANNEL_CTRL_STRIDE);
+	val = tegra30_apbif_read(reg);
+	val &= ~(TEGRA30_AHUB_CHANNEL_CTRL_TX_THRESHOLD_MASK |
+		 TEGRA30_AHUB_CHANNEL_CTRL_TX_PACK_MASK);
+	val |= (7 << TEGRA30_AHUB_CHANNEL_CTRL_TX_THRESHOLD_SHIFT) |
+	       TEGRA30_AHUB_CHANNEL_CTRL_TX_PACK_EN |
+	       TEGRA30_AHUB_CHANNEL_CTRL_TX_PACK_16;
+	tegra30_apbif_write(reg, val);
+
+	reg = TEGRA30_AHUB_CIF_TX_CTRL +
+	      (channel * TEGRA30_AHUB_CIF_TX_CTRL_STRIDE);
+	val = (0 << TEGRA30_AUDIOCIF_CTRL_FIFO_THRESHOLD_SHIFT) |
+	      (1 << TEGRA30_AUDIOCIF_CTRL_AUDIO_CHANNELS_SHIFT) |
+	      (1 << TEGRA30_AUDIOCIF_CTRL_CLIENT_CHANNELS_SHIFT) |
+	      TEGRA30_AUDIOCIF_CTRL_AUDIO_BITS_16 |
+	      TEGRA30_AUDIOCIF_CTRL_CLIENT_BITS_16 |
+	      TEGRA30_AUDIOCIF_CTRL_DIRECTION_TX;
+	tegra30_apbif_write(reg, val);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tegra30_ahub_allocate_tx_fifo);
+
+int tegra30_ahub_enable_tx_fifo(enum tegra30_ahub_txcif txcif)
+{
+	int channel = txcif - TEGRA30_AHUB_TXCIF_APBIF_TX0;
+	int reg, val;
+
+	reg = TEGRA30_AHUB_CHANNEL_CTRL +
+	      (channel * TEGRA30_AHUB_CHANNEL_CTRL_STRIDE);
+	val = tegra30_apbif_read(reg);
+	val |= TEGRA30_AHUB_CHANNEL_CTRL_TX_EN;
+	tegra30_apbif_write(reg, val);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tegra30_ahub_enable_tx_fifo);
+
+int tegra30_ahub_disable_tx_fifo(enum tegra30_ahub_txcif txcif)
+{
+	int channel = txcif - TEGRA30_AHUB_TXCIF_APBIF_TX0;
+	int reg, val;
+
+	reg = TEGRA30_AHUB_CHANNEL_CTRL +
+	      (channel * TEGRA30_AHUB_CHANNEL_CTRL_STRIDE);
+	val = tegra30_apbif_read(reg);
+	val &= ~TEGRA30_AHUB_CHANNEL_CTRL_TX_EN;
+	tegra30_apbif_write(reg, val);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tegra30_ahub_disable_tx_fifo);
+
+int tegra30_ahub_free_tx_fifo(enum tegra30_ahub_txcif txcif)
+{
+	int channel = txcif - TEGRA30_AHUB_TXCIF_APBIF_TX0;
+
+	__clear_bit(channel, ahub->tx_usage);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tegra30_ahub_free_tx_fifo);
+
+int tegra30_ahub_set_rx_cif_source(enum tegra30_ahub_rxcif rxcif,
+				   enum tegra30_ahub_txcif txcif)
+{
+	int channel = rxcif - TEGRA30_AHUB_RXCIF_APBIF_RX0;
+	int reg;
+
+	reg = TEGRA30_AHUB_AUDIO_RX +
+	      (channel * TEGRA30_AHUB_AUDIO_RX_STRIDE);
+	tegra30_audio_write(reg, 1 << txcif);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tegra30_ahub_set_rx_cif_source);
+
+int tegra30_ahub_unset_rx_cif_source(enum tegra30_ahub_rxcif rxcif)
+{
+	int channel = rxcif - TEGRA30_AHUB_RXCIF_APBIF_RX0;
+	int reg;
+
+	reg = TEGRA30_AHUB_AUDIO_RX +
+	      (channel * TEGRA30_AHUB_AUDIO_RX_STRIDE);
+	tegra30_audio_write(reg, 0);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tegra30_ahub_unset_rx_cif_source);
+
+static const char * const configlink_clocks[] __devinitconst = {
+	"i2s0",
+	"i2s1",
+	"i2s2",
+	"i2s3",
+	"i2s4",
+	"dam0",
+	"dam1",
+	"dam2",
+	"spdif_in",
+};
+
+struct of_dev_auxdata ahub_auxdata[] __devinitdata = {
+	OF_DEV_AUXDATA("nvidia,tegra30-i2s", 0x70080300, "tegra30-i2s.0", NULL),
+	OF_DEV_AUXDATA("nvidia,tegra30-i2s", 0x70080400, "tegra30-i2s.1", NULL),
+	OF_DEV_AUXDATA("nvidia,tegra30-i2s", 0x70080500, "tegra30-i2s.2", NULL),
+	OF_DEV_AUXDATA("nvidia,tegra30-i2s", 0x70080600, "tegra30-i2s.3", NULL),
+	OF_DEV_AUXDATA("nvidia,tegra30-i2s", 0x70080700, "tegra30-i2s.4", NULL),
+	{}
+};
+
+#define LAST_REG(name) \
+	(TEGRA30_AHUB_##name + \
+	 (TEGRA30_AHUB_##name##_STRIDE * TEGRA30_AHUB_##name##_COUNT) - 4)
+
+#define REG_IN_ARRAY(reg, name) \
+	((reg >= TEGRA30_AHUB_##name) && \
+	 (reg <= LAST_REG(name) && \
+	 (!((reg - TEGRA30_AHUB_##name) % TEGRA30_AHUB_##name##_STRIDE))))
+
+static bool tegra30_ahub_apbif_wr_rd_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case TEGRA30_AHUB_CONFIG_LINK_CTRL:
+	case TEGRA30_AHUB_MISC_CTRL:
+	case TEGRA30_AHUB_APBDMA_LIVE_STATUS:
+	case TEGRA30_AHUB_I2S_LIVE_STATUS:
+	case TEGRA30_AHUB_SPDIF_LIVE_STATUS:
+	case TEGRA30_AHUB_I2S_INT_MASK:
+	case TEGRA30_AHUB_DAM_INT_MASK:
+	case TEGRA30_AHUB_SPDIF_INT_MASK:
+	case TEGRA30_AHUB_APBIF_INT_MASK:
+	case TEGRA30_AHUB_I2S_INT_STATUS:
+	case TEGRA30_AHUB_DAM_INT_STATUS:
+	case TEGRA30_AHUB_SPDIF_INT_STATUS:
+	case TEGRA30_AHUB_APBIF_INT_STATUS:
+	case TEGRA30_AHUB_I2S_INT_SOURCE:
+	case TEGRA30_AHUB_DAM_INT_SOURCE:
+	case TEGRA30_AHUB_SPDIF_INT_SOURCE:
+	case TEGRA30_AHUB_APBIF_INT_SOURCE:
+	case TEGRA30_AHUB_I2S_INT_SET:
+	case TEGRA30_AHUB_DAM_INT_SET:
+	case TEGRA30_AHUB_SPDIF_INT_SET:
+	case TEGRA30_AHUB_APBIF_INT_SET:
+		return true;
+	default:
+		break;
+	};
+
+	if (REG_IN_ARRAY(reg, CHANNEL_CTRL) ||
+	    REG_IN_ARRAY(reg, CHANNEL_CLEAR) ||
+	    REG_IN_ARRAY(reg, CHANNEL_STATUS) ||
+	    REG_IN_ARRAY(reg, CHANNEL_TXFIFO) ||
+	    REG_IN_ARRAY(reg, CHANNEL_RXFIFO) ||
+	    REG_IN_ARRAY(reg, CIF_TX_CTRL) ||
+	    REG_IN_ARRAY(reg, CIF_RX_CTRL) ||
+	    REG_IN_ARRAY(reg, DAM_LIVE_STATUS))
+		return true;
+
+	return false;
+}
+
+static bool tegra30_ahub_apbif_volatile_reg(struct device *dev,
+					    unsigned int reg)
+{
+	switch (reg) {
+	case TEGRA30_AHUB_CONFIG_LINK_CTRL:
+	case TEGRA30_AHUB_MISC_CTRL:
+	case TEGRA30_AHUB_APBDMA_LIVE_STATUS:
+	case TEGRA30_AHUB_I2S_LIVE_STATUS:
+	case TEGRA30_AHUB_SPDIF_LIVE_STATUS:
+	case TEGRA30_AHUB_I2S_INT_STATUS:
+	case TEGRA30_AHUB_DAM_INT_STATUS:
+	case TEGRA30_AHUB_SPDIF_INT_STATUS:
+	case TEGRA30_AHUB_APBIF_INT_STATUS:
+	case TEGRA30_AHUB_I2S_INT_SET:
+	case TEGRA30_AHUB_DAM_INT_SET:
+	case TEGRA30_AHUB_SPDIF_INT_SET:
+	case TEGRA30_AHUB_APBIF_INT_SET:
+		return true;
+	default:
+		break;
+	};
+
+	if (REG_IN_ARRAY(reg, CHANNEL_CLEAR) ||
+	    REG_IN_ARRAY(reg, CHANNEL_STATUS) ||
+	    REG_IN_ARRAY(reg, CHANNEL_TXFIFO) ||
+	    REG_IN_ARRAY(reg, CHANNEL_RXFIFO) ||
+	    REG_IN_ARRAY(reg, DAM_LIVE_STATUS))
+		return true;
+
+	return false;
+}
+
+static bool tegra30_ahub_apbif_precious_reg(struct device *dev,
+					    unsigned int reg)
+{
+	if (REG_IN_ARRAY(reg, CHANNEL_TXFIFO) ||
+	    REG_IN_ARRAY(reg, CHANNEL_RXFIFO))
+		return true;
+
+	return false;
+}
+
+static const struct regmap_config tegra30_ahub_apbif_regmap_config = {
+	.name = "apbif",
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.max_register = TEGRA30_AHUB_APBIF_INT_SET,
+	.writeable_reg = tegra30_ahub_apbif_wr_rd_reg,
+	.readable_reg = tegra30_ahub_apbif_wr_rd_reg,
+	.volatile_reg = tegra30_ahub_apbif_volatile_reg,
+	.precious_reg = tegra30_ahub_apbif_precious_reg,
+	.cache_type = REGCACHE_RBTREE,
+};
+
+static bool tegra30_ahub_ahub_wr_rd_reg(struct device *dev, unsigned int reg)
+{
+	if (REG_IN_ARRAY(reg, AUDIO_RX))
+		return true;
+
+	return false;
+}
+
+static const struct regmap_config tegra30_ahub_ahub_regmap_config = {
+	.name = "ahub",
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.max_register = LAST_REG(AUDIO_RX),
+	.writeable_reg = tegra30_ahub_ahub_wr_rd_reg,
+	.readable_reg = tegra30_ahub_ahub_wr_rd_reg,
+	.cache_type = REGCACHE_RBTREE,
+};
+
+static int __devinit tegra30_ahub_probe(struct platform_device *pdev)
+{
+	struct clk *clk;
+	int i;
+	struct resource *res0, *res1, *region;
+	u32 of_dma[2];
+	void __iomem *regs_apbif, *regs_ahub;
+	int ret = 0;
+
+	if (ahub)
+		return -ENODEV;
+
+	/*
+	 * The AHUB hosts a register bus: the "configlink". For this to
+	 * operate correctly, all devices on this bus must be out of reset.
+	 * Ensure that here.
+	 */
+	for (i = 0; i < ARRAY_SIZE(configlink_clocks); i++) {
+		clk = clk_get_sys(NULL, configlink_clocks[i]);
+		if (IS_ERR(clk)) {
+			dev_err(&pdev->dev, "Can't get clock %s\n",
+				configlink_clocks[i]);
+			ret = PTR_ERR(clk);
+			goto err;
+		}
+		tegra_periph_reset_deassert(clk);
+		clk_put(clk);
+	}
+
+	ahub = devm_kzalloc(&pdev->dev, sizeof(struct tegra30_ahub),
+			    GFP_KERNEL);
+	if (!ahub) {
+		dev_err(&pdev->dev, "Can't allocate tegra30_ahub\n");
+		ret = -ENOMEM;
+		goto err;
+	}
+	dev_set_drvdata(&pdev->dev, ahub);
+
+	ahub->dev = &pdev->dev;
+
+	ahub->clk_d_audio = clk_get(&pdev->dev, "d_audio");
+	if (IS_ERR(ahub->clk_d_audio)) {
+		dev_err(&pdev->dev, "Can't retrieve ahub d_audio clock\n");
+		ret = PTR_ERR(ahub->clk_d_audio);
+		goto err;
+	}
+
+	ahub->clk_apbif = clk_get(&pdev->dev, "apbif");
+	if (IS_ERR(ahub->clk_apbif)) {
+		dev_err(&pdev->dev, "Can't retrieve ahub apbif clock\n");
+		ret = PTR_ERR(ahub->clk_apbif);
+		goto err_clk_put_d_audio;
+	}
+
+	if (of_property_read_u32_array(pdev->dev.of_node,
+				"nvidia,dma-request-selector",
+				of_dma, 2) < 0) {
+		dev_err(&pdev->dev,
+			"Missing property nvidia,dma-request-selector\n");
+		ret = -ENODEV;
+		goto err_clk_put_d_audio;
+	}
+	ahub->dma_sel = of_dma[1];
+
+	res0 = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res0) {
+		dev_err(&pdev->dev, "No apbif memory resource\n");
+		ret = -ENODEV;
+		goto err_clk_put_apbif;
+	}
+
+	region = devm_request_mem_region(&pdev->dev, res0->start,
+					 resource_size(res0), DRV_NAME);
+	if (!region) {
+		dev_err(&pdev->dev, "request region apbif failed\n");
+		ret = -EBUSY;
+		goto err_clk_put_apbif;
+	}
+	ahub->apbif_addr = res0->start;
+
+	regs_apbif = devm_ioremap(&pdev->dev, res0->start,
+				  resource_size(res0));
+	if (!regs_apbif) {
+		dev_err(&pdev->dev, "ioremap apbif failed\n");
+		ret = -ENOMEM;
+		goto err_clk_put_apbif;
+	}
+
+	ahub->regmap_apbif = devm_regmap_init_mmio(&pdev->dev, regs_apbif,
+					&tegra30_ahub_apbif_regmap_config);
+	if (IS_ERR(ahub->regmap_apbif)) {
+		dev_err(&pdev->dev, "apbif regmap init failed\n");
+		ret = PTR_ERR(ahub->regmap_apbif);
+		goto err_clk_put_apbif;
+	}
+	regcache_cache_only(ahub->regmap_apbif, true);
+
+	res1 = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (!res1) {
+		dev_err(&pdev->dev, "No ahub memory resource\n");
+		ret = -ENODEV;
+		goto err_clk_put_apbif;
+	}
+
+	region = devm_request_mem_region(&pdev->dev, res1->start,
+					 resource_size(res1), DRV_NAME);
+	if (!region) {
+		dev_err(&pdev->dev, "request region ahub failed\n");
+		ret = -EBUSY;
+		goto err_clk_put_apbif;
+	}
+
+	regs_ahub = devm_ioremap(&pdev->dev, res1->start,
+				 resource_size(res1));
+	if (!regs_ahub) {
+		dev_err(&pdev->dev, "ioremap ahub failed\n");
+		ret = -ENOMEM;
+		goto err_clk_put_apbif;
+	}
+
+	ahub->regmap_ahub = devm_regmap_init_mmio(&pdev->dev, regs_ahub,
+					&tegra30_ahub_ahub_regmap_config);
+	if (IS_ERR(ahub->regmap_ahub)) {
+		dev_err(&pdev->dev, "ahub regmap init failed\n");
+		ret = PTR_ERR(ahub->regmap_ahub);
+		goto err_clk_put_apbif;
+	}
+	regcache_cache_only(ahub->regmap_ahub, true);
+
+	pm_runtime_enable(&pdev->dev);
+	if (!pm_runtime_enabled(&pdev->dev)) {
+		ret = tegra30_ahub_runtime_resume(&pdev->dev);
+		if (ret)
+			goto err_pm_disable;
+	}
+
+	of_platform_populate(pdev->dev.of_node, NULL, ahub_auxdata,
+			     &pdev->dev);
+
+	return 0;
+
+err_pm_disable:
+	pm_runtime_disable(&pdev->dev);
+err_clk_put_apbif:
+	clk_put(ahub->clk_apbif);
+err_clk_put_d_audio:
+	clk_put(ahub->clk_d_audio);
+	ahub = 0;
+err:
+	return ret;
+}
+
+static int __devexit tegra30_ahub_remove(struct platform_device *pdev)
+{
+	if (!ahub)
+		return -ENODEV;
+
+	pm_runtime_disable(&pdev->dev);
+	if (!pm_runtime_status_suspended(&pdev->dev))
+		tegra30_ahub_runtime_suspend(&pdev->dev);
+
+	clk_put(ahub->clk_apbif);
+	clk_put(ahub->clk_d_audio);
+
+	ahub = 0;
+
+	return 0;
+}
+
+static const struct of_device_id tegra30_ahub_of_match[] __devinitconst = {
+	{ .compatible = "nvidia,tegra30-ahub", },
+	{},
+};
+
+static const struct dev_pm_ops tegra30_ahub_pm_ops __devinitconst = {
+	SET_RUNTIME_PM_OPS(tegra30_ahub_runtime_suspend,
+			   tegra30_ahub_runtime_resume, NULL)
+};
+
+static struct platform_driver tegra30_ahub_driver = {
+	.probe = tegra30_ahub_probe,
+	.remove = __devexit_p(tegra30_ahub_remove),
+	.driver = {
+		.name = DRV_NAME,
+		.owner = THIS_MODULE,
+		.of_match_table = tegra30_ahub_of_match,
+		.pm = &tegra30_ahub_pm_ops,
+	},
+};
+module_platform_driver(tegra30_ahub_driver);
+
+MODULE_AUTHOR("Stephen Warren <swarren@nvidia.com>");
+MODULE_DESCRIPTION("Tegra30 AHUB driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" DRV_NAME);
diff --git a/sound/soc/tegra/tegra30_ahub.h b/sound/soc/tegra/tegra30_ahub.h
new file mode 100644
index 0000000..e690e2e
--- /dev/null
+++ b/sound/soc/tegra/tegra30_ahub.h
@@ -0,0 +1,483 @@
+/*
+ * tegra30_ahub.h - Definitions for Tegra30 AHUB driver
+ *
+ * Copyright (c) 2011,2012, NVIDIA CORPORATION.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef __TEGRA30_AHUB_H__
+#define __TEGRA30_AHUB_H__
+
+/* Fields in *_CIF_RX/TX_CTRL; used by AHUB FIFOs, and all other audio modules */
+
+#define TEGRA30_AUDIOCIF_CTRL_FIFO_THRESHOLD_SHIFT	28
+#define TEGRA30_AUDIOCIF_CTRL_FIFO_THRESHOLD_MASK_US	0xf
+#define TEGRA30_AUDIOCIF_CTRL_FIFO_THRESHOLD_MASK	(TEGRA30_AUDIOCIF_CTRL_FIFO_THRESHOLD_MASK_US << TEGRA30_AUDIOCIF_CTRL_FIFO_THRESHOLD_SHIFT)
+
+/* Channel count minus 1 */
+#define TEGRA30_AUDIOCIF_CTRL_AUDIO_CHANNELS_SHIFT	24
+#define TEGRA30_AUDIOCIF_CTRL_AUDIO_CHANNELS_MASK_US	7
+#define TEGRA30_AUDIOCIF_CTRL_AUDIO_CHANNELS_MASK	(TEGRA30_AUDIOCIF_CTRL_AUDIO_CHANNELS_MASK_US << TEGRA30_AUDIOCIF_CTRL_AUDIO_CHANNELS_SHIFT)
+
+/* Channel count minus 1 */
+#define TEGRA30_AUDIOCIF_CTRL_CLIENT_CHANNELS_SHIFT	16
+#define TEGRA30_AUDIOCIF_CTRL_CLIENT_CHANNELS_MASK_US	7
+#define TEGRA30_AUDIOCIF_CTRL_CLIENT_CHANNELS_MASK	(TEGRA30_AUDIOCIF_CTRL_CLIENT_CHANNELS_MASK_US << TEGRA30_AUDIOCIF_CTRL_CLIENT_CHANNELS_SHIFT)
+
+#define TEGRA30_AUDIOCIF_BITS_4				0
+#define TEGRA30_AUDIOCIF_BITS_8				1
+#define TEGRA30_AUDIOCIF_BITS_12			2
+#define TEGRA30_AUDIOCIF_BITS_16			3
+#define TEGRA30_AUDIOCIF_BITS_20			4
+#define TEGRA30_AUDIOCIF_BITS_24			5
+#define TEGRA30_AUDIOCIF_BITS_28			6
+#define TEGRA30_AUDIOCIF_BITS_32			7
+
+#define TEGRA30_AUDIOCIF_CTRL_AUDIO_BITS_SHIFT		12
+#define TEGRA30_AUDIOCIF_CTRL_AUDIO_BITS_MASK		(7                        << TEGRA30_AUDIOCIF_CTRL_AUDIO_BITS_SHIFT)
+#define TEGRA30_AUDIOCIF_CTRL_AUDIO_BITS_4		(TEGRA30_AUDIOCIF_BITS_4  << TEGRA30_AUDIOCIF_CTRL_AUDIO_BITS_SHIFT)
+#define TEGRA30_AUDIOCIF_CTRL_AUDIO_BITS_8		(TEGRA30_AUDIOCIF_BITS_8  << TEGRA30_AUDIOCIF_CTRL_AUDIO_BITS_SHIFT)
+#define TEGRA30_AUDIOCIF_CTRL_AUDIO_BITS_12		(TEGRA30_AUDIOCIF_BITS_12 << TEGRA30_AUDIOCIF_CTRL_AUDIO_BITS_SHIFT)
+#define TEGRA30_AUDIOCIF_CTRL_AUDIO_BITS_16		(TEGRA30_AUDIOCIF_BITS_16 << TEGRA30_AUDIOCIF_CTRL_AUDIO_BITS_SHIFT)
+#define TEGRA30_AUDIOCIF_CTRL_AUDIO_BITS_20		(TEGRA30_AUDIOCIF_BITS_20 << TEGRA30_AUDIOCIF_CTRL_AUDIO_BITS_SHIFT)
+#define TEGRA30_AUDIOCIF_CTRL_AUDIO_BITS_24		(TEGRA30_AUDIOCIF_BITS_24 << TEGRA30_AUDIOCIF_CTRL_AUDIO_BITS_SHIFT)
+#define TEGRA30_AUDIOCIF_CTRL_AUDIO_BITS_28		(TEGRA30_AUDIOCIF_BITS_28 << TEGRA30_AUDIOCIF_CTRL_AUDIO_BITS_SHIFT)
+#define TEGRA30_AUDIOCIF_CTRL_AUDIO_BITS_32		(TEGRA30_AUDIOCIF_BITS_32 << TEGRA30_AUDIOCIF_CTRL_AUDIO_BITS_SHIFT)
+
+#define TEGRA30_AUDIOCIF_CTRL_CLIENT_BITS_SHIFT		8
+#define TEGRA30_AUDIOCIF_CTRL_CLIENT_BITS_MASK		(7                        << TEGRA30_AUDIOCIF_CTRL_CLIENT_BITS_SHIFT)
+#define TEGRA30_AUDIOCIF_CTRL_CLIENT_BITS_4		(TEGRA30_AUDIOCIF_BITS_4  << TEGRA30_AUDIOCIF_CTRL_CLIENT_BITS_SHIFT)
+#define TEGRA30_AUDIOCIF_CTRL_CLIENT_BITS_8		(TEGRA30_AUDIOCIF_BITS_8  << TEGRA30_AUDIOCIF_CTRL_CLIENT_BITS_SHIFT)
+#define TEGRA30_AUDIOCIF_CTRL_CLIENT_BITS_12		(TEGRA30_AUDIOCIF_BITS_12 << TEGRA30_AUDIOCIF_CTRL_CLIENT_BITS_SHIFT)
+#define TEGRA30_AUDIOCIF_CTRL_CLIENT_BITS_16		(TEGRA30_AUDIOCIF_BITS_16 << TEGRA30_AUDIOCIF_CTRL_CLIENT_BITS_SHIFT)
+#define TEGRA30_AUDIOCIF_CTRL_CLIENT_BITS_20		(TEGRA30_AUDIOCIF_BITS_20 << TEGRA30_AUDIOCIF_CTRL_CLIENT_BITS_SHIFT)
+#define TEGRA30_AUDIOCIF_CTRL_CLIENT_BITS_24		(TEGRA30_AUDIOCIF_BITS_24 << TEGRA30_AUDIOCIF_CTRL_CLIENT_BITS_SHIFT)
+#define TEGRA30_AUDIOCIF_CTRL_CLIENT_BITS_28		(TEGRA30_AUDIOCIF_BITS_28 << TEGRA30_AUDIOCIF_CTRL_CLIENT_BITS_SHIFT)
+#define TEGRA30_AUDIOCIF_CTRL_CLIENT_BITS_32		(TEGRA30_AUDIOCIF_BITS_32 << TEGRA30_AUDIOCIF_CTRL_CLIENT_BITS_SHIFT)
+
+#define TEGRA30_AUDIOCIF_EXPAND_ZERO			0
+#define TEGRA30_AUDIOCIF_EXPAND_ONE			1
+#define TEGRA30_AUDIOCIF_EXPAND_LFSR			2
+
+#define TEGRA30_AUDIOCIF_CTRL_EXPAND_SHIFT		6
+#define TEGRA30_AUDIOCIF_CTRL_EXPAND_MASK		(3                            << TEGRA30_AUDIOCIF_CTRL_EXPAND_SHIFT)
+#define TEGRA30_AUDIOCIF_CTRL_EXPAND_ZERO		(TEGRA30_AUDIOCIF_EXPAND_ZERO << TEGRA30_AUDIOCIF_CTRL_EXPAND_SHIFT)
+#define TEGRA30_AUDIOCIF_CTRL_EXPAND_ONE		(TEGRA30_AUDIOCIF_EXPAND_ONE  << TEGRA30_AUDIOCIF_CTRL_EXPAND_SHIFT)
+#define TEGRA30_AUDIOCIF_CTRL_EXPAND_LFSR		(TEGRA30_AUDIOCIF_EXPAND_LFSR << TEGRA30_AUDIOCIF_CTRL_EXPAND_SHIFT)
+
+#define TEGRA30_AUDIOCIF_STEREO_CONV_CH0		0
+#define TEGRA30_AUDIOCIF_STEREO_CONV_CH1		1
+#define TEGRA30_AUDIOCIF_STEREO_CONV_AVG		2
+
+#define TEGRA30_AUDIOCIF_CTRL_STEREO_CONV_SHIFT		4
+#define TEGRA30_AUDIOCIF_CTRL_STEREO_CONV_MASK		(3                                << TEGRA30_AUDIOCIF_CTRL_STEREO_CONV_SHIFT)
+#define TEGRA30_AUDIOCIF_CTRL_STEREO_CONV_CH0		(TEGRA30_AUDIOCIF_STEREO_CONV_CH0 << TEGRA30_AUDIOCIF_CTRL_STEREO_CONV_SHIFT)
+#define TEGRA30_AUDIOCIF_CTRL_STEREO_CONV_CH1		(TEGRA30_AUDIOCIF_STEREO_CONV_CH1 << TEGRA30_AUDIOCIF_CTRL_STEREO_CONV_SHIFT)
+#define TEGRA30_AUDIOCIF_CTRL_STEREO_CONV_AVG		(TEGRA30_AUDIOCIF_STEREO_CONV_AVG << TEGRA30_AUDIOCIF_CTRL_STEREO_CONV_SHIFT)
+
+#define TEGRA30_AUDIOCIF_CTRL_REPLICATE			3
+
+#define TEGRA30_AUDIOCIF_DIRECTION_TX			0
+#define TEGRA30_AUDIOCIF_DIRECTION_RX			1
+
+#define TEGRA30_AUDIOCIF_CTRL_DIRECTION_SHIFT		2
+#define TEGRA30_AUDIOCIF_CTRL_DIRECTION_MASK		(1                             << TEGRA30_AUDIOCIF_CTRL_DIRECTION_SHIFT)
+#define TEGRA30_AUDIOCIF_CTRL_DIRECTION_TX		(TEGRA30_AUDIOCIF_DIRECTION_TX << TEGRA30_AUDIOCIF_CTRL_DIRECTION_SHIFT)
+#define TEGRA30_AUDIOCIF_CTRL_DIRECTION_RX		(TEGRA30_AUDIOCIF_DIRECTION_RX << TEGRA30_AUDIOCIF_CTRL_DIRECTION_SHIFT)
+
+#define TEGRA30_AUDIOCIF_TRUNCATE_ROUND			0
+#define TEGRA30_AUDIOCIF_TRUNCATE_CHOP			1
+
+#define TEGRA30_AUDIOCIF_CTRL_TRUNCATE_SHIFT		1
+#define TEGRA30_AUDIOCIF_CTRL_TRUNCATE_MASK		(1                               << TEGRA30_AUDIOCIF_CTRL_TRUNCATE_SHIFT)
+#define TEGRA30_AUDIOCIF_CTRL_TRUNCATE_ROUND		(TEGRA30_AUDIOCIF_TRUNCATE_ROUND << TEGRA30_AUDIOCIF_CTRL_TRUNCATE_SHIFT)
+#define TEGRA30_AUDIOCIF_CTRL_TRUNCATE_CHOP		(TEGRA30_AUDIOCIF_TRUNCATE_CHOP  << TEGRA30_AUDIOCIF_CTRL_TRUNCATE_SHIFT)
+
+#define TEGRA30_AUDIOCIF_MONO_CONV_ZERO			0
+#define TEGRA30_AUDIOCIF_MONO_CONV_COPY			1
+
+#define TEGRA30_AUDIOCIF_CTRL_MONO_CONV_SHIFT		0
+#define TEGRA30_AUDIOCIF_CTRL_MONO_CONV_MASK		(1                               << TEGRA30_AUDIOCIF_CTRL_MONO_CONV_SHIFT)
+#define TEGRA30_AUDIOCIF_CTRL_MONO_CONV_ZERO		(TEGRA30_AUDIOCIF_MONO_CONV_ZERO << TEGRA30_AUDIOCIF_CTRL_MONO_CONV_SHIFT)
+#define TEGRA30_AUDIOCIF_CTRL_MONO_CONV_COPY		(TEGRA30_AUDIOCIF_MONO_CONV_COPY << TEGRA30_AUDIOCIF_CTRL_MONO_CONV_SHIFT)
+
+/* Registers within TEGRA30_AUDIO_CLUSTER_BASE */
+
+/* TEGRA30_AHUB_CHANNEL_CTRL */
+
+#define TEGRA30_AHUB_CHANNEL_CTRL			0x0
+#define TEGRA30_AHUB_CHANNEL_CTRL_STRIDE		0x20
+#define TEGRA30_AHUB_CHANNEL_CTRL_COUNT			4
+#define TEGRA30_AHUB_CHANNEL_CTRL_TX_EN			(1 << 31)
+#define TEGRA30_AHUB_CHANNEL_CTRL_RX_EN			(1 << 30)
+#define TEGRA30_AHUB_CHANNEL_CTRL_LOOPBACK		(1 << 29)
+
+#define TEGRA30_AHUB_CHANNEL_CTRL_TX_THRESHOLD_SHIFT	16
+#define TEGRA30_AHUB_CHANNEL_CTRL_TX_THRESHOLD_MASK_US	0xff
+#define TEGRA30_AHUB_CHANNEL_CTRL_TX_THRESHOLD_MASK	(TEGRA30_AHUB_CHANNEL_CTRL_TX_THRESHOLD_MASK_US << TEGRA30_AHUB_CHANNEL_CTRL_TX_THRESHOLD_SHIFT)
+
+#define TEGRA30_AHUB_CHANNEL_CTRL_RX_THRESHOLD_SHIFT	8
+#define TEGRA30_AHUB_CHANNEL_CTRL_RX_THRESHOLD_MASK_US	0xff
+#define TEGRA30_AHUB_CHANNEL_CTRL_RX_THRESHOLD_MASK	(TEGRA30_AHUB_CHANNEL_CTRL_RX_THRESHOLD_MASK_US << TEGRA30_AHUB_CHANNEL_CTRL_RX_THRESHOLD_SHIFT)
+
+#define TEGRA30_AHUB_CHANNEL_CTRL_TX_PACK_EN		(1 << 6)
+
+#define TEGRA30_PACK_8_4				2
+#define TEGRA30_PACK_16					3
+
+#define TEGRA30_AHUB_CHANNEL_CTRL_TX_PACK_SHIFT		4
+#define TEGRA30_AHUB_CHANNEL_CTRL_TX_PACK_MASK_US	3
+#define TEGRA30_AHUB_CHANNEL_CTRL_TX_PACK_MASK		(TEGRA30_AHUB_CHANNEL_CTRL_TX_PACK_MASK_US << TEGRA30_AHUB_CHANNEL_CTRL_TX_PACK_SHIFT)
+#define TEGRA30_AHUB_CHANNEL_CTRL_TX_PACK_8_4		(TEGRA30_PACK_8_4                          << TEGRA30_AHUB_CHANNEL_CTRL_TX_PACK_SHIFT)
+#define TEGRA30_AHUB_CHANNEL_CTRL_TX_PACK_16		(TEGRA30_PACK_16                           << TEGRA30_AHUB_CHANNEL_CTRL_TX_PACK_SHIFT)
+
+#define TEGRA30_AHUB_CHANNEL_CTRL_RX_PACK_EN		(1 << 2)
+
+#define TEGRA30_AHUB_CHANNEL_CTRL_RX_PACK_SHIFT		0
+#define TEGRA30_AHUB_CHANNEL_CTRL_RX_PACK_MASK_US	3
+#define TEGRA30_AHUB_CHANNEL_CTRL_RX_PACK_MASK		(TEGRA30_AHUB_CHANNEL_CTRL_RX_PACK_MASK_US << TEGRA30_AHUB_CHANNEL_CTRL_RX_PACK_SHIFT)
+#define TEGRA30_AHUB_CHANNEL_CTRL_RX_PACK_8_4		(TEGRA30_PACK_8_4                          << TEGRA30_AHUB_CHANNEL_CTRL_RX_PACK_SHIFT)
+#define TEGRA30_AHUB_CHANNEL_CTRL_RX_PACK_16		(TEGRA30_PACK_16                           << TEGRA30_AHUB_CHANNEL_CTRL_RX_PACK_SHIFT)
+
+/* TEGRA30_AHUB_CHANNEL_CLEAR */
+
+#define TEGRA30_AHUB_CHANNEL_CLEAR			0x4
+#define TEGRA30_AHUB_CHANNEL_CLEAR_STRIDE		0x20
+#define TEGRA30_AHUB_CHANNEL_CLEAR_COUNT		4
+#define TEGRA30_AHUB_CHANNEL_CLEAR_TX_SOFT_RESET	(1 << 31)
+#define TEGRA30_AHUB_CHANNEL_CLEAR_RX_SOFT_RESET	(1 << 30)
+
+/* TEGRA30_AHUB_CHANNEL_STATUS */
+
+#define TEGRA30_AHUB_CHANNEL_STATUS			0x8
+#define TEGRA30_AHUB_CHANNEL_STATUS_STRIDE		0x20
+#define TEGRA30_AHUB_CHANNEL_STATUS_COUNT		4
+#define TEGRA30_AHUB_CHANNEL_STATUS_TX_FREE_SHIFT	24
+#define TEGRA30_AHUB_CHANNEL_STATUS_TX_FREE_MASK_US	0xff
+#define TEGRA30_AHUB_CHANNEL_STATUS_TX_FREE_MASK	(TEGRA30_AHUB_CHANNEL_STATUS_TX_FREE_MASK_US << TEGRA30_AHUB_CHANNEL_STATUS_TX_FREE_SHIFT)
+#define TEGRA30_AHUB_CHANNEL_STATUS_RX_FREE_SHIFT	16
+#define TEGRA30_AHUB_CHANNEL_STATUS_RX_FREE_MASK_US	0xff
+#define TEGRA30_AHUB_CHANNEL_STATUS_RX_FREE_MASK	(TEGRA30_AHUB_CHANNEL_STATUS_RX_FREE_MASK_US << TEGRA30_AHUB_CHANNEL_STATUS_RX_FREE_SHIFT)
+#define TEGRA30_AHUB_CHANNEL_STATUS_TX_TRIG		(1 << 1)
+#define TEGRA30_AHUB_CHANNEL_STATUS_RX_TRIG		(1 << 0)
+
+/* TEGRA30_AHUB_CHANNEL_TXFIFO */
+
+#define TEGRA30_AHUB_CHANNEL_TXFIFO			0xc
+#define TEGRA30_AHUB_CHANNEL_TXFIFO_STRIDE		0x20
+#define TEGRA30_AHUB_CHANNEL_TXFIFO_COUNT		4
+
+/* TEGRA30_AHUB_CHANNEL_RXFIFO */
+
+#define TEGRA30_AHUB_CHANNEL_RXFIFO			0x10
+#define TEGRA30_AHUB_CHANNEL_RXFIFO_STRIDE		0x20
+#define TEGRA30_AHUB_CHANNEL_RXFIFO_COUNT		4
+
+/* TEGRA30_AHUB_CIF_TX_CTRL */
+
+#define TEGRA30_AHUB_CIF_TX_CTRL			0x14
+#define TEGRA30_AHUB_CIF_TX_CTRL_STRIDE			0x20
+#define TEGRA30_AHUB_CIF_TX_CTRL_COUNT			4
+/* Uses field from TEGRA30_AUDIOCIF_CTRL_* */
+
+/* TEGRA30_AHUB_CIF_RX_CTRL */
+
+#define TEGRA30_AHUB_CIF_RX_CTRL			0x18
+#define TEGRA30_AHUB_CIF_RX_CTRL_STRIDE			0x20
+#define TEGRA30_AHUB_CIF_RX_CTRL_COUNT			4
+/* Uses field from TEGRA30_AUDIOCIF_CTRL_* */
+
+/* TEGRA30_AHUB_CONFIG_LINK_CTRL */
+
+#define TEGRA30_AHUB_CONFIG_LINK_CTRL					0x80
+#define TEGRA30_AHUB_CONFIG_LINK_CTRL_MASTER_FIFO_FULL_CNT_SHIFT	28
+#define TEGRA30_AHUB_CONFIG_LINK_CTRL_MASTER_FIFO_FULL_CNT_MASK_US	0xf
+#define TEGRA30_AHUB_CONFIG_LINK_CTRL_MASTER_FIFO_FULL_CNT_MASK		(TEGRA30_AHUB_CONFIG_LINK_CTRL_MASTER_FIFO_FULL_CNT_MASK_US << TEGRA30_AHUB_CONFIG_LINK_CTRL_MASTER_FIFO_FULL_CNT_SHIFT)
+#define TEGRA30_AHUB_CONFIG_LINK_CTRL_TIMEOUT_CNT_SHIFT			16
+#define TEGRA30_AHUB_CONFIG_LINK_CTRL_TIMEOUT_CNT_MASK_US		0xfff
+#define TEGRA30_AHUB_CONFIG_LINK_CTRL_TIMEOUT_CNT_MASK			(TEGRA30_AHUB_CONFIG_LINK_CTRL_TIMEOUT_CNT_MASK_US << TEGRA30_AHUB_CONFIG_LINK_CTRL_TIMEOUT_CNT_SHIFT)
+#define TEGRA30_AHUB_CONFIG_LINK_CTRL_IDLE_CNT_SHIFT			4
+#define TEGRA30_AHUB_CONFIG_LINK_CTRL_IDLE_CNT_MASK_US			0xfff
+#define TEGRA30_AHUB_CONFIG_LINK_CTRL_IDLE_CNT_MASK			(TEGRA30_AHUB_CONFIG_LINK_CTRL_IDLE_CNT_MASK_US << TEGRA30_AHUB_CONFIG_LINK_CTRL_IDLE_CNT_SHIFT)
+#define TEGRA30_AHUB_CONFIG_LINK_CTRL_CG_EN				(1 << 2)
+#define TEGRA30_AHUB_CONFIG_LINK_CTRL_CLEAR_TIMEOUT_CNTR		(1 << 1)
+#define TEGRA30_AHUB_CONFIG_LINK_CTRL_SOFT_RESET			(1 << 0)
+
+/* TEGRA30_AHUB_MISC_CTRL */
+
+#define TEGRA30_AHUB_MISC_CTRL				0x84
+#define TEGRA30_AHUB_MISC_CTRL_AUDIO_ACTIVE		(1 << 31)
+#define TEGRA30_AHUB_MISC_CTRL_AUDIO_CG_EN		(1 << 8)
+#define TEGRA30_AHUB_MISC_CTRL_AUDIO_OBS_SEL_SHIFT	0
+#define TEGRA30_AHUB_MISC_CTRL_AUDIO_OBS_SEL_MASK	(0x1f << TEGRA30_AHUB_MISC_CTRL_AUDIO_OBS_SEL_SHIFT)
+
+/* TEGRA30_AHUB_APBDMA_LIVE_STATUS */
+
+#define TEGRA30_AHUB_APBDMA_LIVE_STATUS				0x88
+#define TEGRA30_AHUB_APBDMA_LIVE_STATUS_CH3_RX_CIF_FIFO_FULL	(1 << 31)
+#define TEGRA30_AHUB_APBDMA_LIVE_STATUS_CH3_TX_CIF_FIFO_FULL	(1 << 30)
+#define TEGRA30_AHUB_APBDMA_LIVE_STATUS_CH2_RX_CIF_FIFO_FULL	(1 << 29)
+#define TEGRA30_AHUB_APBDMA_LIVE_STATUS_CH2_TX_CIF_FIFO_FULL	(1 << 28)
+#define TEGRA30_AHUB_APBDMA_LIVE_STATUS_CH1_RX_CIF_FIFO_FULL	(1 << 27)
+#define TEGRA30_AHUB_APBDMA_LIVE_STATUS_CH1_TX_CIF_FIFO_FULL	(1 << 26)
+#define TEGRA30_AHUB_APBDMA_LIVE_STATUS_CH0_RX_CIF_FIFO_FULL	(1 << 25)
+#define TEGRA30_AHUB_APBDMA_LIVE_STATUS_CH0_TX_CIF_FIFO_FULL	(1 << 24)
+#define TEGRA30_AHUB_APBDMA_LIVE_STATUS_CH3_RX_CIF_FIFO_EMPTY	(1 << 23)
+#define TEGRA30_AHUB_APBDMA_LIVE_STATUS_CH3_TX_CIF_FIFO_EMPTY	(1 << 22)
+#define TEGRA30_AHUB_APBDMA_LIVE_STATUS_CH2_RX_CIF_FIFO_EMPTY	(1 << 21)
+#define TEGRA30_AHUB_APBDMA_LIVE_STATUS_CH2_TX_CIF_FIFO_EMPTY	(1 << 20)
+#define TEGRA30_AHUB_APBDMA_LIVE_STATUS_CH1_RX_CIF_FIFO_EMPTY	(1 << 19)
+#define TEGRA30_AHUB_APBDMA_LIVE_STATUS_CH1_TX_CIF_FIFO_EMPTY	(1 << 18)
+#define TEGRA30_AHUB_APBDMA_LIVE_STATUS_CH0_RX_CIF_FIFO_EMPTY	(1 << 17)
+#define TEGRA30_AHUB_APBDMA_LIVE_STATUS_CH0_TX_CIF_FIFO_EMPTY	(1 << 16)
+#define TEGRA30_AHUB_APBDMA_LIVE_STATUS_CH3_RX_DMA_FIFO_FULL	(1 << 15)
+#define TEGRA30_AHUB_APBDMA_LIVE_STATUS_CH3_TX_DMA_FIFO_FULL	(1 << 14)
+#define TEGRA30_AHUB_APBDMA_LIVE_STATUS_CH2_RX_DMA_FIFO_FULL	(1 << 13)
+#define TEGRA30_AHUB_APBDMA_LIVE_STATUS_CH2_TX_DMA_FIFO_FULL	(1 << 12)
+#define TEGRA30_AHUB_APBDMA_LIVE_STATUS_CH1_RX_DMA_FIFO_FULL	(1 << 11)
+#define TEGRA30_AHUB_APBDMA_LIVE_STATUS_CH1_TX_DMA_FIFO_FULL	(1 << 10)
+#define TEGRA30_AHUB_APBDMA_LIVE_STATUS_CH0_RX_DMA_FIFO_FULL	(1 << 9)
+#define TEGRA30_AHUB_APBDMA_LIVE_STATUS_CH0_TX_DMA_FIFO_FULL	(1 << 8)
+#define TEGRA30_AHUB_APBDMA_LIVE_STATUS_CH3_RX_DMA_FIFO_EMPTY	(1 << 7)
+#define TEGRA30_AHUB_APBDMA_LIVE_STATUS_CH3_TX_DMA_FIFO_EMPTY	(1 << 6)
+#define TEGRA30_AHUB_APBDMA_LIVE_STATUS_CH2_RX_DMA_FIFO_EMPTY	(1 << 5)
+#define TEGRA30_AHUB_APBDMA_LIVE_STATUS_CH2_TX_DMA_FIFO_EMPTY	(1 << 4)
+#define TEGRA30_AHUB_APBDMA_LIVE_STATUS_CH1_RX_DMA_FIFO_EMPTY	(1 << 3)
+#define TEGRA30_AHUB_APBDMA_LIVE_STATUS_CH1_TX_DMA_FIFO_EMPTY	(1 << 2)
+#define TEGRA30_AHUB_APBDMA_LIVE_STATUS_CH0_RX_DMA_FIFO_EMPTY	(1 << 1)
+#define TEGRA30_AHUB_APBDMA_LIVE_STATUS_CH0_TX_DMA_FIFO_EMPTY	(1 << 0)
+
+/* TEGRA30_AHUB_I2S_LIVE_STATUS */
+
+#define TEGRA30_AHUB_I2S_LIVE_STATUS				0x8c
+#define TEGRA30_AHUB_I2S_LIVE_STATUS_I2S4_RX_FIFO_FULL		(1 << 29)
+#define TEGRA30_AHUB_I2S_LIVE_STATUS_I2S4_TX_FIFO_FULL		(1 << 28)
+#define TEGRA30_AHUB_I2S_LIVE_STATUS_I2S3_RX_FIFO_FULL		(1 << 27)
+#define TEGRA30_AHUB_I2S_LIVE_STATUS_I2S3_TX_FIFO_FULL		(1 << 26)
+#define TEGRA30_AHUB_I2S_LIVE_STATUS_I2S2_RX_FIFO_FULL		(1 << 25)
+#define TEGRA30_AHUB_I2S_LIVE_STATUS_I2S2_TX_FIFO_FULL		(1 << 24)
+#define TEGRA30_AHUB_I2S_LIVE_STATUS_I2S1_RX_FIFO_FULL		(1 << 23)
+#define TEGRA30_AHUB_I2S_LIVE_STATUS_I2S1_TX_FIFO_FULL		(1 << 22)
+#define TEGRA30_AHUB_I2S_LIVE_STATUS_I2S0_RX_FIFO_FULL		(1 << 21)
+#define TEGRA30_AHUB_I2S_LIVE_STATUS_I2S0_TX_FIFO_FULL		(1 << 20)
+#define TEGRA30_AHUB_I2S_LIVE_STATUS_I2S4_RX_FIFO_ENABLED	(1 << 19)
+#define TEGRA30_AHUB_I2S_LIVE_STATUS_I2S4_TX_FIFO_ENABLED	(1 << 18)
+#define TEGRA30_AHUB_I2S_LIVE_STATUS_I2S3_RX_FIFO_ENABLED	(1 << 17)
+#define TEGRA30_AHUB_I2S_LIVE_STATUS_I2S3_TX_FIFO_ENABLED	(1 << 16)
+#define TEGRA30_AHUB_I2S_LIVE_STATUS_I2S2_RX_FIFO_ENABLED	(1 << 15)
+#define TEGRA30_AHUB_I2S_LIVE_STATUS_I2S2_TX_FIFO_ENABLED	(1 << 14)
+#define TEGRA30_AHUB_I2S_LIVE_STATUS_I2S1_RX_FIFO_ENABLED	(1 << 13)
+#define TEGRA30_AHUB_I2S_LIVE_STATUS_I2S1_TX_FIFO_ENABLED	(1 << 12)
+#define TEGRA30_AHUB_I2S_LIVE_STATUS_I2S0_RX_FIFO_ENABLED	(1 << 11)
+#define TEGRA30_AHUB_I2S_LIVE_STATUS_I2S0_TX_FIFO_ENABLED	(1 << 10)
+#define TEGRA30_AHUB_I2S_LIVE_STATUS_I2S4_RX_FIFO_EMPTY		(1 << 9)
+#define TEGRA30_AHUB_I2S_LIVE_STATUS_I2S4_TX_FIFO_EMPTY		(1 << 8)
+#define TEGRA30_AHUB_I2S_LIVE_STATUS_I2S3_RX_FIFO_EMPTY		(1 << 7)
+#define TEGRA30_AHUB_I2S_LIVE_STATUS_I2S3_TX_FIFO_EMPTY		(1 << 6)
+#define TEGRA30_AHUB_I2S_LIVE_STATUS_I2S2_RX_FIFO_EMPTY		(1 << 5)
+#define TEGRA30_AHUB_I2S_LIVE_STATUS_I2S2_TX_FIFO_EMPTY		(1 << 4)
+#define TEGRA30_AHUB_I2S_LIVE_STATUS_I2S1_RX_FIFO_EMPTY		(1 << 3)
+#define TEGRA30_AHUB_I2S_LIVE_STATUS_I2S1_TX_FIFO_EMPTY		(1 << 2)
+#define TEGRA30_AHUB_I2S_LIVE_STATUS_I2S0_RX_FIFO_EMPTY		(1 << 1)
+#define TEGRA30_AHUB_I2S_LIVE_STATUS_I2S0_TX_FIFO_EMPTY		(1 << 0)
+
+/* TEGRA30_AHUB_DAM0_LIVE_STATUS */
+
+#define TEGRA30_AHUB_DAM_LIVE_STATUS				0x90
+#define TEGRA30_AHUB_DAM_LIVE_STATUS_STRIDE			0x8
+#define TEGRA30_AHUB_DAM_LIVE_STATUS_COUNT			3
+#define TEGRA30_AHUB_DAM_LIVE_STATUS_TX_ENABLED			(1 << 26)
+#define TEGRA30_AHUB_DAM_LIVE_STATUS_RX1_ENABLED		(1 << 25)
+#define TEGRA30_AHUB_DAM_LIVE_STATUS_RX0_ENABLED		(1 << 24)
+#define TEGRA30_AHUB_DAM_LIVE_STATUS_TXFIFO_FULL		(1 << 15)
+#define TEGRA30_AHUB_DAM_LIVE_STATUS_RX1FIFO_FULL		(1 << 9)
+#define TEGRA30_AHUB_DAM_LIVE_STATUS_RX0FIFO_FULL		(1 << 8)
+#define TEGRA30_AHUB_DAM_LIVE_STATUS_TXFIFO_EMPTY		(1 << 7)
+#define TEGRA30_AHUB_DAM_LIVE_STATUS_RX1FIFO_EMPTY		(1 << 1)
+#define TEGRA30_AHUB_DAM_LIVE_STATUS_RX0FIFO_EMPTY		(1 << 0)
+
+/* TEGRA30_AHUB_SPDIF_LIVE_STATUS */
+
+#define TEGRA30_AHUB_SPDIF_LIVE_STATUS				0xa8
+#define TEGRA30_AHUB_SPDIF_LIVE_STATUS_USER_TX_ENABLED		(1 << 11)
+#define TEGRA30_AHUB_SPDIF_LIVE_STATUS_USER_RX_ENABLED		(1 << 10)
+#define TEGRA30_AHUB_SPDIF_LIVE_STATUS_DATA_TX_ENABLED		(1 << 9)
+#define TEGRA30_AHUB_SPDIF_LIVE_STATUS_DATA_RX_ENABLED		(1 << 8)
+#define TEGRA30_AHUB_SPDIF_LIVE_STATUS_USER_TXFIFO_FULL		(1 << 7)
+#define TEGRA30_AHUB_SPDIF_LIVE_STATUS_USER_RXFIFO_FULL		(1 << 6)
+#define TEGRA30_AHUB_SPDIF_LIVE_STATUS_DATA_TXFIFO_FULL		(1 << 5)
+#define TEGRA30_AHUB_SPDIF_LIVE_STATUS_DATA_RXFIFO_FULL		(1 << 4)
+#define TEGRA30_AHUB_SPDIF_LIVE_STATUS_USER_TXFIFO_EMPTY	(1 << 3)
+#define TEGRA30_AHUB_SPDIF_LIVE_STATUS_USER_RXFIFO_EMPTY	(1 << 2)
+#define TEGRA30_AHUB_SPDIF_LIVE_STATUS_DATA_TXFIFO_EMPTY	(1 << 1)
+#define TEGRA30_AHUB_SPDIF_LIVE_STATUS_DATA_RXFIFO_EMPTY	(1 << 0)
+
+/* TEGRA30_AHUB_I2S_INT_MASK */
+
+#define TEGRA30_AHUB_I2S_INT_MASK				0xb0
+
+/* TEGRA30_AHUB_DAM_INT_MASK */
+
+#define TEGRA30_AHUB_DAM_INT_MASK				0xb4
+
+/* TEGRA30_AHUB_SPDIF_INT_MASK */
+
+#define TEGRA30_AHUB_SPDIF_INT_MASK				0xbc
+
+/* TEGRA30_AHUB_APBIF_INT_MASK */
+
+#define TEGRA30_AHUB_APBIF_INT_MASK				0xc0
+
+/* TEGRA30_AHUB_I2S_INT_STATUS */
+
+#define TEGRA30_AHUB_I2S_INT_STATUS				0xc8
+
+/* TEGRA30_AHUB_DAM_INT_STATUS */
+
+#define TEGRA30_AHUB_DAM_INT_STATUS				0xcc
+
+/* TEGRA30_AHUB_SPDIF_INT_STATUS */
+
+#define TEGRA30_AHUB_SPDIF_INT_STATUS				0xd4
+
+/* TEGRA30_AHUB_APBIF_INT_STATUS */
+
+#define TEGRA30_AHUB_APBIF_INT_STATUS				0xd8
+
+/* TEGRA30_AHUB_I2S_INT_SOURCE */
+
+#define TEGRA30_AHUB_I2S_INT_SOURCE				0xe0
+
+/* TEGRA30_AHUB_DAM_INT_SOURCE */
+
+#define TEGRA30_AHUB_DAM_INT_SOURCE				0xe4
+
+/* TEGRA30_AHUB_SPDIF_INT_SOURCE */
+
+#define TEGRA30_AHUB_SPDIF_INT_SOURCE				0xec
+
+/* TEGRA30_AHUB_APBIF_INT_SOURCE */
+
+#define TEGRA30_AHUB_APBIF_INT_SOURCE				0xf0
+
+/* TEGRA30_AHUB_I2S_INT_SET */
+
+#define TEGRA30_AHUB_I2S_INT_SET				0xf8
+
+/* TEGRA30_AHUB_DAM_INT_SET */
+
+#define TEGRA30_AHUB_DAM_INT_SET				0xfc
+
+/* TEGRA30_AHUB_SPDIF_INT_SET */
+
+#define TEGRA30_AHUB_SPDIF_INT_SET				0x100
+
+/* TEGRA30_AHUB_APBIF_INT_SET */
+
+#define TEGRA30_AHUB_APBIF_INT_SET				0x104
+
+/* Registers within TEGRA30_AHUB_BASE */
+
+#define TEGRA30_AHUB_AUDIO_RX					0x0
+#define TEGRA30_AHUB_AUDIO_RX_STRIDE				0x4
+#define TEGRA30_AHUB_AUDIO_RX_COUNT				17
+/* This register repeats once for each entry in enum tegra30_ahub_rxcif */
+/* The fields in this register are 1 bit per entry in tegra30_ahub_txcif */
+
+/*
+ * Terminology:
+ * AHUB: Audio Hub; a cross-bar switch between the audio devices: DMA FIFOs,
+ *       I2S controllers, SPDIF controllers, and DAMs.
+ * XBAR: The core cross-bar component of the AHUB.
+ * CIF:  Client Interface; the HW module connecting an audio device to the
+ *       XBAR.
+ * DAM:  Digital Audio Mixer: A HW module that mixes multiple audio streams,
+ *       possibly including sample-rate conversion.
+ *
+ * Each TX CIF transmits data into the XBAR. Each RX CIF can receive audio
+ * transmitted by a particular TX CIF.
+ *
+ * This driver is currently very simplistic; many HW features are not
+ * exposed; DAMs are not supported, only 16-bit stereo audio is supported,
+ * etc.
+ */
+
+enum tegra30_ahub_txcif {
+	TEGRA30_AHUB_TXCIF_APBIF_TX0,
+	TEGRA30_AHUB_TXCIF_APBIF_TX1,
+	TEGRA30_AHUB_TXCIF_APBIF_TX2,
+	TEGRA30_AHUB_TXCIF_APBIF_TX3,
+	TEGRA30_AHUB_TXCIF_I2S0_TX0,
+	TEGRA30_AHUB_TXCIF_I2S1_TX0,
+	TEGRA30_AHUB_TXCIF_I2S2_TX0,
+	TEGRA30_AHUB_TXCIF_I2S3_TX0,
+	TEGRA30_AHUB_TXCIF_I2S4_TX0,
+	TEGRA30_AHUB_TXCIF_DAM0_TX0,
+	TEGRA30_AHUB_TXCIF_DAM1_TX0,
+	TEGRA30_AHUB_TXCIF_DAM2_TX0,
+	TEGRA30_AHUB_TXCIF_SPDIF_TX0,
+	TEGRA30_AHUB_TXCIF_SPDIF_TX1,
+};
+
+enum tegra30_ahub_rxcif {
+	TEGRA30_AHUB_RXCIF_APBIF_RX0,
+	TEGRA30_AHUB_RXCIF_APBIF_RX1,
+	TEGRA30_AHUB_RXcIF_APBIF_RX2,
+	TEGRA30_AHUB_RXCIF_APBIF_RX3,
+	TEGRA30_AHUB_RXCIF_I2S0_RX0,
+	TEGRA30_AHUB_RXCIF_I2S1_RX0,
+	TEGRA30_AHUB_RXCIF_I2S2_RX0,
+	TEGRA30_AHUB_RXCIF_I2S3_RX0,
+	TEGRA30_AHUB_RXCIF_I2S4_RX0,
+	TEGRA30_AHUB_RXCIF_DAM0_RX0,
+	TEGRA30_AHUB_RXCIF_DAM0_RX1,
+	TEGRA30_AHUB_RXCIF_DAM1_RX0,
+	TEGRA30_AHUB_RXCIF_DAM2_RX1,
+	TEGRA30_AHUB_RXCIF_DAM3_RX0,
+	TEGRA30_AHUB_RXCIF_DAM3_RX1,
+	TEGRA30_AHUB_RXCIF_SPDIF_RX0,
+	TEGRA30_AHUB_RXCIF_SPDIF_RX1,
+};
+
+extern int tegra30_ahub_allocate_rx_fifo(enum tegra30_ahub_rxcif *rxcif,
+					 unsigned long *fiforeg,
+					 unsigned long *reqsel);
+extern int tegra30_ahub_enable_rx_fifo(enum tegra30_ahub_rxcif rxcif);
+extern int tegra30_ahub_disable_rx_fifo(enum tegra30_ahub_rxcif rxcif);
+extern int tegra30_ahub_free_rx_fifo(enum tegra30_ahub_rxcif rxcif);
+
+extern int tegra30_ahub_allocate_tx_fifo(enum tegra30_ahub_txcif *txcif,
+					 unsigned long *fiforeg,
+					 unsigned long *reqsel);
+extern int tegra30_ahub_enable_tx_fifo(enum tegra30_ahub_txcif txcif);
+extern int tegra30_ahub_disable_tx_fifo(enum tegra30_ahub_txcif txcif);
+extern int tegra30_ahub_free_tx_fifo(enum tegra30_ahub_txcif txcif);
+
+extern int tegra30_ahub_set_rx_cif_source(enum tegra30_ahub_rxcif rxcif,
+					  enum tegra30_ahub_txcif txcif);
+extern int tegra30_ahub_unset_rx_cif_source(enum tegra30_ahub_rxcif rxcif);
+
+struct tegra30_ahub {
+	struct device *dev;
+	struct clk *clk_d_audio;
+	struct clk *clk_apbif;
+	int dma_sel;
+	resource_size_t apbif_addr;
+	struct regmap *regmap_apbif;
+	struct regmap *regmap_ahub;
+	DECLARE_BITMAP(rx_usage, TEGRA30_AHUB_CHANNEL_CTRL_COUNT);
+	DECLARE_BITMAP(tx_usage, TEGRA30_AHUB_CHANNEL_CTRL_COUNT);
+};
+
+#endif
-- 
1.7.0.4
