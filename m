From: njaigane@codeaurora.org
Subject: [PATCH 4/4] qcom: ipq4019: Add ASoC driver modules
Date: Fri, 15 Jul 2016 12:37:06 +0530
Message-ID: <1468566426-19598-5-git-send-email-njaigane@codeaurora.org>
References: <1468566426-19598-1-git-send-email-njaigane@codeaurora.org>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1468566426-19598-1-git-send-email-njaigane@codeaurora.org>
Sender: linux-gpio-owner@vger.kernel.org
To: linux-arm-msm@vger.kernel.org
Cc: linux@qca.qualcomm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, twp@codeaurora.org, andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@armlinux.org.uk, mturquette@baylibre.com, sboyd@codeaurora.org, linus.walleij@linaro.org, plai@codeaurora.org, bgoswami@codeaurora.org, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, bjorn.andersson@linaro.org, varada@codeaurora.org, pradeepb@codeaurora.org, snlakshm@codeaurora.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, alsa-devel@alsa-project.org, bselvara@codeaurora.org, Jaiganesh Narayanan <njaigane@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

From: Jaiganesh Narayanan <njaigane@codeaurora.org>

This patch adds the alsa based audio driver for IPQ4019 ASoC.

Signed-off-by: Jaiganesh Narayanan <njaigane@codeaurora.org>
---
 sound/soc/qcom/Kconfig                     |  47 ++
 sound/soc/qcom/Makefile                    |   1 +
 sound/soc/qcom/ipq4019/Makefile            |  16 +
 sound/soc/qcom/ipq4019/ipq4019-adss.c      | 407 ++++++++++++++
 sound/soc/qcom/ipq4019/ipq4019-adss.h      | 432 +++++++++++++++
 sound/soc/qcom/ipq4019/ipq4019-codec.c     | 475 +++++++++++++++++
 sound/soc/qcom/ipq4019/ipq4019-codec.h     |  91 ++++
 sound/soc/qcom/ipq4019/ipq4019-cpu-dai.c   | 687 ++++++++++++++++++++++++
 sound/soc/qcom/ipq4019/ipq4019-mbox.c      | 825 +++++++++++++++++++++++++++++
 sound/soc/qcom/ipq4019/ipq4019-mbox.h      | 146 +++++
 sound/soc/qcom/ipq4019/ipq4019-pcm-i2s.c   | 609 +++++++++++++++++++++
 sound/soc/qcom/ipq4019/ipq4019-pcm-spdif.c | 664 +++++++++++++++++++++++
 sound/soc/qcom/ipq4019/ipq4019-pcm-tdm.c   | 609 +++++++++++++++++++++
 sound/soc/qcom/ipq4019/ipq4019-pcm.h       |  37 ++
 sound/soc/qcom/ipq4019/ipq4019-stereo.c    | 313 +++++++++++
 sound/soc/qcom/ipq4019/ipq4019.c           | 121 +++++
 16 files changed, 5480 insertions(+)
 create mode 100644 sound/soc/qcom/ipq4019/Makefile
 create mode 100644 sound/soc/qcom/ipq4019/ipq4019-adss.c
 create mode 100644 sound/soc/qcom/ipq4019/ipq4019-adss.h
 create mode 100644 sound/soc/qcom/ipq4019/ipq4019-codec.c
 create mode 100644 sound/soc/qcom/ipq4019/ipq4019-codec.h
 create mode 100644 sound/soc/qcom/ipq4019/ipq4019-cpu-dai.c
 create mode 100644 sound/soc/qcom/ipq4019/ipq4019-mbox.c
 create mode 100644 sound/soc/qcom/ipq4019/ipq4019-mbox.h
 create mode 100644 sound/soc/qcom/ipq4019/ipq4019-pcm-i2s.c
 create mode 100644 sound/soc/qcom/ipq4019/ipq4019-pcm-spdif.c
 create mode 100644 sound/soc/qcom/ipq4019/ipq4019-pcm-tdm.c
 create mode 100644 sound/soc/qcom/ipq4019/ipq4019-pcm.h
 create mode 100644 sound/soc/qcom/ipq4019/ipq4019-stereo.c
 create mode 100644 sound/soc/qcom/ipq4019/ipq4019.c

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 8ec9a07..de1f5b1 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -43,3 +43,50 @@ config SND_SOC_APQ8016_SBC
           Support for Qualcomm Technologies LPASS audio block in
           APQ8016 SOC-based systems.
           Say Y if you want to use audio devices on MI2S.
+
+config SND_SOC_IPQ4019
+	tristate "Soc Audio support for IPQ4019 platforms"
+	depends on SND_SOC_QCOM
+	select SND_SOC_IPQ4019_ADSS
+	select SND_SOC_IPQ4019_CPU_DAI
+	select SND_SOC_IPQ4019_STEREO
+	select SND_SOC_IPQ4019_MBOX
+	select SND_SOC_IPQ4019_PCM_I2S
+	select SND_SOC_IPQ4019_CODEC
+	select SND_SOC_IPQ4019_PCM_TDM
+	select SND_SOC_IPQ4019_PCM_SPDIF
+	help
+	Say Y or M to if you want to add support for SoC audio on
+	Qualcomm Atheros IPQ4019 based board.
+
+config SND_SOC_IPQ4019_ADSS
+	tristate
+	depends on SND_SOC_IPQ4019
+
+config SND_SOC_IPQ4019_CPU_DAI
+	tristate
+	depends on SND_SOC_IPQ4019
+
+config SND_SOC_IPQ4019_STEREO
+	tristate
+	depends on SND_SOC_IPQ4019
+
+config SND_SOC_IPQ4019_MBOX
+	tristate
+	depends on SND_SOC_IPQ4019
+
+config SND_SOC_IPQ4019_PCM_I2S
+	tristate
+	depends on SND_SOC_IPQ4019
+
+config SND_SOC_IPQ4019_CODEC
+	tristate
+	depends on SND_SOC_IPQ4019
+
+config SND_SOC_IPQ4019_PCM_TDM
+	tristate
+	depends on SND_SOC_IPQ4019
+
+config SND_SOC_IPQ4019_PCM_SPDIF
+	tristate
+	depends on SND_SOC_IPQ4019
diff --git a/sound/soc/qcom/Makefile b/sound/soc/qcom/Makefile
index 79e5c50..f326b6a 100644
--- a/sound/soc/qcom/Makefile
+++ b/sound/soc/qcom/Makefile
@@ -15,3 +15,4 @@ snd-soc-apq8016-sbc-objs := apq8016_sbc.o
 
 obj-$(CONFIG_SND_SOC_STORM) += snd-soc-storm.o
 obj-$(CONFIG_SND_SOC_APQ8016_SBC) += snd-soc-apq8016-sbc.o
+obj-$(CONFIG_SND_SOC_IPQ4019) += ipq4019/
diff --git a/sound/soc/qcom/ipq4019/Makefile b/sound/soc/qcom/ipq4019/Makefile
new file mode 100644
index 0000000..ee46f51
--- /dev/null
+++ b/sound/soc/qcom/ipq4019/Makefile
@@ -0,0 +1,16 @@
+# QCA IPQ4019 Sound Card Support
+snd-soc-ipq4019-objs := ipq4019.o
+snd-soc-ipq4019-cpu-dai-objs := ipq4019-cpu-dai.o
+snd-soc-ipq4019-pcm-i2s-objs := ipq4019-pcm-i2s.o
+snd-soc-ipq4019-pcm-tdm-objs := ipq4019-pcm-tdm.o
+snd-soc-ipq4019-pcm-spdif-objs := ipq4019-pcm-spdif.o
+
+obj-$(CONFIG_SND_SOC_IPQ4019) += ipq4019.o
+obj-$(CONFIG_SND_SOC_IPQ4019_ADSS) += ipq4019-adss.o
+obj-$(CONFIG_SND_SOC_IPQ4019_CPU_DAI) += snd-soc-ipq4019-cpu-dai.o
+obj-$(CONFIG_SND_SOC_IPQ4019_STEREO) += ipq4019-stereo.o
+obj-$(CONFIG_SND_SOC_IPQ4019_MBOX) += ipq4019-mbox.o
+obj-$(CONFIG_SND_SOC_IPQ4019_PCM_I2S) += snd-soc-ipq4019-pcm-i2s.o
+obj-$(CONFIG_SND_SOC_IPQ4019_CODEC) += ipq4019-codec.o
+obj-$(CONFIG_SND_SOC_IPQ4019_PCM_SPDIF) += snd-soc-ipq4019-pcm-spdif.o
+obj-$(CONFIG_SND_SOC_IPQ4019_PCM_TDM) += snd-soc-ipq4019-pcm-tdm.o
diff --git a/sound/soc/qcom/ipq4019/ipq4019-adss.c b/sound/soc/qcom/ipq4019/ipq4019-adss.c
new file mode 100644
index 0000000..a3d21a193
--- /dev/null
+++ b/sound/soc/qcom/ipq4019/ipq4019-adss.c
@@ -0,0 +1,407 @@
+/*
+ * Copyright (c) 2015-2016, The Linux Foundation. All rights reserved.
+ *
+ * Permission to use, copy, modify, and/or distribute this software for any
+ * purpose with or without fee is hereby granted, provided that the above
+ * copyright notice and this permission notice appear in all copies.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
+ * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
+ * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
+ * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+ * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+ * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/bitops.h>
+#include <sound/pcm.h>
+#include <linux/io.h>
+#include <linux/delay.h>
+#include <linux/reset.h>
+#include <linux/spinlock.h>
+
+#include "ipq4019-adss.h"
+
+static void __iomem *adss_audio_local_base;
+void __iomem *adss_audio_spdifin_base;
+static struct reset_control *audio_blk_rst;
+static spinlock_t i2s_ctrl_lock;
+static spinlock_t tdm_ctrl_lock;
+static spinlock_t glb_mode_lock;
+
+/* Channel Number Per Frame for Transmitter/Receiver
+ * Real value = val + 1
+ */
+void ipq4019_glb_tdm_ctrl_ch_num(uint32_t val, uint32_t dir)
+{
+	uint32_t cfg;
+	unsigned long flags;
+
+	spin_lock_irqsave(&tdm_ctrl_lock, flags);
+	cfg = readl(adss_audio_local_base + ADSS_GLB_TDM_CTRL_REG);
+
+	if (dir == PLAYBACK) {
+		cfg &= ~(GLB_TDM_CTRL_TX_CHAN_NUM_MASK);
+		cfg |= GLB_TDM_CTRL_TX_CHAN_NUM(val);
+	} else if (dir == CAPTURE) {
+		cfg &= ~(GLB_TDM_CTRL_RX_CHAN_NUM_MASK);
+		cfg |= GLB_TDM_CTRL_RX_CHAN_NUM(val);
+	}
+	writel(cfg, adss_audio_local_base + ADSS_GLB_TDM_CTRL_REG);
+	spin_unlock_irqrestore(&tdm_ctrl_lock, flags);
+}
+EXPORT_SYMBOL(ipq4019_glb_tdm_ctrl_ch_num);
+
+/* FSYNC Hi Duration for Transmitter/Receiver */
+void ipq4019_glb_tdm_ctrl_sync_num(uint32_t val, uint32_t dir)
+{
+	uint32_t cfg;
+	unsigned long flags;
+
+	spin_lock_irqsave(&tdm_ctrl_lock, flags);
+	cfg = readl(adss_audio_local_base + ADSS_GLB_TDM_CTRL_REG);
+
+	if (dir == PLAYBACK) {
+		cfg &= ~(GLB_TDM_CTRL_TX_SYNC_NUM_MASK);
+		cfg |= GLB_TDM_CTRL_TX_SYNC_NUM(val);
+	} else if (dir == CAPTURE) {
+		cfg &= ~(GLB_TDM_CTRL_RX_SYNC_NUM_MASK);
+		cfg |= GLB_TDM_CTRL_RX_SYNC_NUM(val);
+	}
+	writel(cfg, adss_audio_local_base + ADSS_GLB_TDM_CTRL_REG);
+	spin_unlock_irqrestore(&tdm_ctrl_lock, flags);
+}
+EXPORT_SYMBOL(ipq4019_glb_tdm_ctrl_sync_num);
+
+/* Serial Data Delay for transmitter/receiver */
+void ipq4019_glb_tdm_ctrl_delay(uint32_t delay, uint32_t dir)
+{
+	uint32_t cfg;
+	unsigned long flags;
+
+	spin_lock_irqsave(&tdm_ctrl_lock, flags);
+	cfg = readl(adss_audio_local_base + ADSS_GLB_TDM_CTRL_REG);
+
+	if (dir == PLAYBACK) {
+		cfg &= ~(GLB_TDM_CTRL_TX_DELAY);
+		if (delay)
+			cfg |= GLB_TDM_CTRL_TX_DELAY;
+	} else if (dir == CAPTURE) {
+		cfg &= ~(GLB_TDM_CTRL_RX_DELAY);
+		if (delay)
+			cfg |= GLB_TDM_CTRL_RX_DELAY;
+	}
+	writel(cfg, adss_audio_local_base + ADSS_GLB_TDM_CTRL_REG);
+	spin_unlock_irqrestore(&tdm_ctrl_lock, flags);
+}
+EXPORT_SYMBOL(ipq4019_glb_tdm_ctrl_delay);
+
+/* I2S Interface Enable */
+static void ipq4019_glb_i2s_interface_en(int enable)
+{
+	u32 cfg;
+	unsigned long flags;
+
+	spin_lock_irqsave(&i2s_ctrl_lock, flags);
+	cfg = readl(adss_audio_local_base + ADSS_GLB_CHIP_CTRL_I2S_REG);
+	cfg &= ~GLB_CHIP_CTRL_I2S_INTERFACE_EN;
+	if (enable)
+		cfg |= GLB_CHIP_CTRL_I2S_INTERFACE_EN;
+	writel(cfg, adss_audio_local_base + ADSS_GLB_CHIP_CTRL_I2S_REG);
+	spin_unlock_irqrestore(&i2s_ctrl_lock, flags);
+	/*
+	 * As per the audio controller susbsytem after writing to
+	 * the register wait 5ms for the i2s settle down.
+	 */
+	mdelay(5);
+}
+EXPORT_SYMBOL(ipq4019_glb_i2s_interface_en);
+
+/* Enable Stereo0/Stereo1/Stereo2 channel */
+void ipq4019_glb_stereo_ch_en(int enable, int stereo_ch)
+{
+	uint32_t cfg;
+	unsigned long flags;
+
+	spin_lock_irqsave(&i2s_ctrl_lock, flags);
+	cfg = readl(adss_audio_local_base + ADSS_GLB_CHIP_CTRL_I2S_REG);
+	if (stereo_ch == STEREO0) {
+		cfg &= ~(GLB_CHIP_CTRL_I2S_STEREO0_GLB_EN);
+		cfg |= GLB_CHIP_CTRL_I2S_STEREO0_GLB_EN;
+	} else if (stereo_ch == STEREO1) {
+		cfg &= ~(GLB_CHIP_CTRL_I2S_STEREO1_GLB_EN);
+		cfg |= GLB_CHIP_CTRL_I2S_STEREO1_GLB_EN;
+	} else if (stereo_ch == STEREO2) {
+		cfg &= ~(GLB_CHIP_CTRL_I2S_STEREO2_GLB_EN);
+		cfg |= GLB_CHIP_CTRL_I2S_STEREO2_GLB_EN;
+	}
+	writel(cfg, adss_audio_local_base + ADSS_GLB_CHIP_CTRL_I2S_REG);
+	spin_unlock_irqrestore(&i2s_ctrl_lock, flags);
+}
+EXPORT_SYMBOL(ipq4019_glb_stereo_ch_en);
+
+/*
+ * I2S Module Reset
+ */
+static void ipq4019_glb_i2s_reset(void)
+{
+	writel(GLB_I2S_RESET_VAL, adss_audio_local_base + ADSS_GLB_I2S_RST_REG);
+	mdelay(5);
+	writel(0x0, adss_audio_local_base + ADSS_GLB_I2S_RST_REG);
+}
+
+/*
+ * Enable I2S/TDM and Playback/Capture Audio Mode
+ */
+void ipq4019_glb_audio_mode(int mode, int dir)
+{
+	u32 cfg;
+	unsigned long flags;
+
+	spin_lock_irqsave(&glb_mode_lock, flags);
+	cfg = readl(adss_audio_local_base + ADSS_GLB_AUDIO_MODE_REG);
+	if (mode == I2S && dir == PLAYBACK) {
+		cfg &= ~GLB_AUDIO_MODE_XMIT_MASK;
+		cfg |= GLB_AUDIO_MODE_XMIT_I2S;
+	} else if (mode == I2S && dir == CAPTURE) {
+		cfg &= ~GLB_AUDIO_MODE_RECV_MASK;
+		cfg |= GLB_AUDIO_MODE_RECV_I2S;
+	} else if (mode == TDM && dir == PLAYBACK) {
+		cfg &= ~GLB_AUDIO_MODE_XMIT_MASK;
+		cfg |= GLB_AUDIO_MODE_XMIT_TDM;
+	} else if (mode == TDM && dir == CAPTURE) {
+		cfg &= ~GLB_AUDIO_MODE_RECV_MASK;
+		cfg |= GLB_AUDIO_MODE_RECV_TDM;
+	}
+	writel(cfg, adss_audio_local_base + ADSS_GLB_AUDIO_MODE_REG);
+	spin_unlock_irqrestore(&glb_mode_lock, flags);
+}
+EXPORT_SYMBOL(ipq4019_glb_audio_mode);
+
+/*
+ * I2S0 TX Data Port Enable
+ *
+ * Todo :
+ * Check if bits 6:4 configures only
+ * I2S0 or other channels as well
+ */
+void ipq4019_glb_tx_data_port_en(u32 enable)
+{
+	u32 cfg;
+	unsigned long flags;
+
+	spin_lock_irqsave(&glb_mode_lock, flags);
+	cfg = readl(adss_audio_local_base + ADSS_GLB_AUDIO_MODE_REG);
+	cfg &= ~GLB_AUDIO_MODE_I2S0_TXD_OE;
+	if (enable)
+		cfg |= GLB_AUDIO_MODE_I2S0_TXD_OE;
+	writel(cfg, adss_audio_local_base + ADSS_GLB_AUDIO_MODE_REG);
+	spin_unlock_irqrestore(&glb_mode_lock, flags);
+}
+EXPORT_SYMBOL(ipq4019_glb_tx_data_port_en);
+
+/*
+ * I2S3 RX Data Port Enable
+ */
+void ipq4019_glb_rx_data_port_en(u32 enable)
+{
+	u32 cfg;
+	unsigned long flags;
+
+	spin_lock_irqsave(&glb_mode_lock, flags);
+	cfg = readl(adss_audio_local_base + ADSS_GLB_AUDIO_MODE_REG);
+	cfg &= ~GLB_AUDIO_MODE_I2S3_RXD_OE;
+	if (enable)
+		cfg |= GLB_AUDIO_MODE_I2S3_RXD_OE;
+	writel(cfg, adss_audio_local_base + ADSS_GLB_AUDIO_MODE_REG);
+	spin_unlock_irqrestore(&glb_mode_lock, flags);
+}
+EXPORT_SYMBOL(ipq4019_glb_rx_data_port_en);
+
+/*
+ * Cross 1K Boundary
+ */
+void ipq4019_glb_audio_mode_B1K(void)
+{
+	u32 cfg;
+	unsigned long flags;
+
+	spin_lock_irqsave(&glb_mode_lock, flags);
+	cfg =  readl(adss_audio_local_base + ADSS_GLB_AUDIO_MODE_REG);
+	cfg &= ~GLB_AUDIO_MODE_B1K;
+	cfg |= GLB_AUDIO_MODE_B1K;
+	writel(cfg, adss_audio_local_base + ADSS_GLB_AUDIO_MODE_REG);
+	spin_unlock_irqrestore(&glb_mode_lock, flags);
+}
+EXPORT_SYMBOL(ipq4019_glb_audio_mode_B1K);
+
+/*
+ * Frame Sync Port Enable for I2S0 TX
+ */
+void ipq4019_glb_tx_framesync_port_en(u32 enable)
+{
+	u32 cfg;
+	unsigned long flags;
+
+	spin_lock_irqsave(&glb_mode_lock, flags);
+	cfg =  readl(adss_audio_local_base + ADSS_GLB_AUDIO_MODE_REG);
+	cfg &= ~GLB_AUDIO_MODE_I2S0_FS_OE;
+	if (enable)
+		cfg |= GLB_AUDIO_MODE_I2S0_FS_OE;
+	writel(cfg, adss_audio_local_base + ADSS_GLB_AUDIO_MODE_REG);
+	spin_unlock_irqrestore(&glb_mode_lock, flags);
+}
+EXPORT_SYMBOL(ipq4019_glb_tx_framesync_port_en);
+
+/*
+ * Frame Sync Port Enable for I2S3 RX
+ */
+void ipq4019_glb_rx_framesync_port_en(u32 enable)
+{
+	u32 cfg;
+	unsigned long flags;
+
+	spin_lock_irqsave(&glb_mode_lock, flags);
+	cfg =  readl(adss_audio_local_base + ADSS_GLB_AUDIO_MODE_REG);
+	cfg &= ~GLB_AUDIO_MODE_I2S3_FS_OE;
+	if (enable)
+		cfg |= GLB_AUDIO_MODE_I2S3_FS_OE;
+	writel(cfg, adss_audio_local_base + ADSS_GLB_AUDIO_MODE_REG);
+	spin_unlock_irqrestore(&glb_mode_lock, flags);
+}
+EXPORT_SYMBOL(ipq4019_glb_rx_framesync_port_en);
+
+void ipq4019_glb_clk_enable_oe(u32 dir)
+{
+	u32 cfg;
+	unsigned long flags;
+
+	spin_lock_irqsave(&i2s_ctrl_lock, flags);
+	cfg = readl(adss_audio_local_base + ADSS_GLB_CLK_I2S_CTRL_REG);
+
+	if (dir == PLAYBACK) {
+		cfg |= (GLB_CLK_I2S_CTRL_TX_BCLK_OE |
+			GLB_CLK_I2S_CTRL_TX_MCLK_OE);
+	} else {
+		cfg |= (GLB_CLK_I2S_CTRL_RX_BCLK_OE |
+			GLB_CLK_I2S_CTRL_RX_MCLK_OE);
+	}
+	writel(cfg, adss_audio_local_base + ADSS_GLB_CLK_I2S_CTRL_REG);
+	spin_unlock_irqrestore(&i2s_ctrl_lock, flags);
+}
+EXPORT_SYMBOL(ipq4019_glb_clk_enable_oe);
+
+void ipq4019_spdifin_ctrl_spdif_en(uint32_t enable)
+{
+	uint32_t reg_val;
+
+	reg_val = readl(adss_audio_spdifin_base + ADSS_SPDIFIN_SPDIF_CTRL_REG);
+
+	if (enable)
+		reg_val |= SPDIF_CTRL_SPDIF_ENABLE;
+	else
+		reg_val &= ~SPDIF_CTRL_SPDIF_ENABLE;
+
+	writel(reg_val, adss_audio_spdifin_base + ADSS_SPDIFIN_SPDIF_CTRL_REG);
+
+}
+EXPORT_SYMBOL(ipq4019_spdifin_ctrl_spdif_en);
+
+void ipq4019_spdifin_cfg(void)
+{
+	uint32_t reg_val;
+
+	reg_val = readl(adss_audio_spdifin_base + ADSS_SPDIFIN_SPDIF_CTRL_REG);
+	reg_val &= ~(SPDIF_CTRL_CHANNEL_MODE
+			| SPDIF_CTRL_VALIDITYCHECK
+			| SPDIF_CTRL_PARITYCHECK);
+	reg_val |= (SPDIF_CTRL_USE_FIFO_IF
+			| SPDIF_CTRL_SFR_ENABLE
+			| SPDIF_CTRL_FIFO_ENABLE);
+	writel(reg_val, adss_audio_spdifin_base + ADSS_SPDIFIN_SPDIF_CTRL_REG);
+}
+EXPORT_SYMBOL(ipq4019_spdifin_cfg);
+
+void ipq4019_glb_spdif_out_en(uint32_t enable)
+{
+	int32_t cfg;
+
+	cfg = readl(adss_audio_local_base + ADSS_GLB_AUDIO_MODE_REG);
+	cfg &= ~(GLB_AUDIO_MODE_SPDIF_OUT_OE);
+	if (enable)
+		cfg |= GLB_AUDIO_MODE_SPDIF_OUT_OE;
+	writel(cfg, adss_audio_local_base + ADSS_GLB_AUDIO_MODE_REG);
+}
+EXPORT_SYMBOL(ipq4019_glb_spdif_out_en);
+
+static const struct of_device_id ipq4019_audio_adss_id_table[] = {
+	{ .compatible = "qca,ipq4019-audio-adss" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ipq4019_audio_adss_id_table);
+
+static int ipq4019_audio_adss_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	adss_audio_local_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(adss_audio_local_base))
+		return PTR_ERR(adss_audio_local_base);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	adss_audio_spdifin_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(adss_audio_spdifin_base))
+		return PTR_ERR(adss_audio_spdifin_base);
+
+	audio_blk_rst = devm_reset_control_get(&pdev->dev, "blk_rst");
+	if (IS_ERR(audio_blk_rst))
+		return PTR_ERR(audio_blk_rst);
+
+	spin_lock_init(&i2s_ctrl_lock);
+	spin_lock_init(&glb_mode_lock);
+	spin_lock_init(&tdm_ctrl_lock);
+
+	/*
+	 * Reset order is critical here.
+	 * First audio block should be out of reset,
+	 * followed by I2S block.
+	 * Since the audio block is brought out of
+	 * reset by hardware by default, it is not
+	 * required to be done in software explicitly.
+	 */
+	ipq4019_glb_i2s_reset();
+
+	ipq4019_glb_i2s_interface_en(ENABLE);
+
+	ipq4019_glb_audio_mode_B1K();
+
+	return 0;
+}
+
+static int ipq4019_audio_adss_remove(struct platform_device *pdev)
+{
+	ipq4019_glb_i2s_interface_en(DISABLE);
+	return 0;
+}
+
+static struct platform_driver ipq4019_audio_adss_driver = {
+	.probe = ipq4019_audio_adss_probe,
+	.remove = ipq4019_audio_adss_remove,
+	.driver = {
+		.name = "ipq4019-adss",
+		.of_match_table = ipq4019_audio_adss_id_table,
+	},
+};
+
+module_platform_driver(ipq4019_audio_adss_driver);
+
+MODULE_ALIAS("platform:ipq4019-adss");
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_DESCRIPTION("IPQ4019 Audio subsytem driver");
diff --git a/sound/soc/qcom/ipq4019/ipq4019-adss.h b/sound/soc/qcom/ipq4019/ipq4019-adss.h
new file mode 100644
index 0000000..87f3e0f
--- /dev/null
+++ b/sound/soc/qcom/ipq4019/ipq4019-adss.h
@@ -0,0 +1,432 @@
+/* 
+ * Copyright (c) 2015-2016, The Linux Foundation. All rights reserved.
+ *
+ * Permission to use, copy, modify, and/or distribute this software for any
+ * purpose with or without fee is hereby granted, provided that the above
+ * copyright notice and this permission notice appear in all copies.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
+ * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
+ * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
+ * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+ * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+ * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+ *
+ */
+
+#ifndef IPQ4019_ADSS_H
+#define IPQ4019_ADSS_H
+
+/* ADSS AUDIO Registers */
+
+#define ADSS_BASE	0x7700000
+#define ADSS_RANGE	0x20000
+
+/* ADSS_AUDIO_LOCAL_REG Registers */
+
+#define ADSS_GLB_PCM_MBOX_CTRL_REG		0x0C
+
+#define ADSS_GLB_CHIP_CTRL_I2S_REG		0x10
+#define GLB_CHIP_CTRL_I2S_INTERFACE_EN		BIT(0)
+#define GLB_CHIP_CTRL_I2S_STEREO0_GLB_EN	BIT(1)
+#define GLB_CHIP_CTRL_I2S_STEREO1_GLB_EN	BIT(2)
+#define GLB_CHIP_CTRL_I2S_STEREO2_GLB_EN	BIT(3)
+
+#define ADSS_GLB_I2S_RST_REG		0x14
+#define GLB_I2S_RST_CTRL_MBOX0		BIT(0)
+#define GLB_I2S_RST_CTRL_I2S0		BIT(1)
+#define GLB_I2S_RST_CTRL_MBOX3		BIT(2)
+#define GLB_I2S_RESET_VAL		0xF
+
+#define ADSS_GLB_CLK_I2S_CTRL_REG	0x18
+#define GLB_CLK_I2S_CTRL_TX_BCLK_OE	BIT(28)
+#define GLB_CLK_I2S_CTRL_RX_BCLK_OE	BIT(27)
+#define GLB_CLK_I2S_CTRL_RX_MCLK_OE	BIT(16)
+#define GLB_CLK_I2S_CTRL_TX_MCLK_OE	BIT(17)
+
+#define ADSS_GLB_TDM_CTRL_REG			0x1C
+#define GLB_TDM_CTRL_TX_CHAN_NUM(x)	(x << 0)
+#define GLB_TDM_CTRL_TX_CHAN_NUM_MASK	0xF
+#define GLB_TDM_CTRL_TX_SYNC_NUM(x)	(x << 4)
+#define GLB_TDM_CTRL_TX_SYNC_NUM_MASK	(0x1F << 4)
+#define GLB_TDM_CTRL_RX_CHAN_NUM(x)	(x << 16)
+#define GLB_TDM_CTRL_RX_CHAN_NUM_MASK	(0xF << 16)
+#define GLB_TDM_CTRL_RX_SYNC_NUM(x)	(x << 20)
+#define GLB_TDM_CTRL_RX_SYNC_NUM_MASK	(0x1F << 20)
+#define GLB_TDM_CTRL_TX_DELAY			BIT(25)
+#define GLB_TDM_CTRL_RX_DELAY			BIT(26)
+
+#define ADSS_GLB_AUDIO_MODE_REG		0x30
+#define GLB_AUDIO_MODE_RECV_MASK	BIT(2)
+#define GLB_AUDIO_MODE_XMIT_MASK	BIT(0)
+#define GLB_AUDIO_MODE_RECV_I2S		(0 << 2)
+#define GLB_AUDIO_MODE_RECV_TDM		BIT(2)
+#define GLB_AUDIO_MODE_XMIT_I2S		(0 << 0)
+#define GLB_AUDIO_MODE_XMIT_TDM		BIT(0)
+#define GLB_AUDIO_MODE_I2S0_TXD_OE	(7 << 4)
+#define GLB_AUDIO_MODE_I2S0_FS_OE	BIT(7)
+#define GLB_AUDIO_MODE_I2S3_FS_OE	BIT(8)
+#define GLB_AUDIO_MODE_I2S3_RXD_OE	BIT(9)
+#define GLB_AUDIO_MODE_SPDIF_OUT_OE	BIT(10)
+#define GLB_AUDIO_MODE_B1K			BIT(28)
+
+#define ADSS_MBOX_STEREO_AUDIO_BASE		(ADSS_BASE + 0x8000)
+
+/* ADSS_MBOX_STEREO_AUDIO_BASE + 0x0 */
+#define ADSS_MBOX0_AUDIO_BASE				0x0
+#define ADSS_MBOX1_AUDIO_BASE				0x2000
+#define ADSS_MBOX2_AUDIO_BASE				0x4000
+#define ADSS_MBOX3_AUDIO_BASE				0x6000
+
+#define ADSS_MBOXn_MBOX_FIFO0_REG			0x0
+#define MBOX_FIFO_RESET_TX_INIT				BIT(0)
+#define MBOX_FIFO_RESET_RX_INIT				BIT(2)
+
+#define ADSS_MBOXn_MBOX_FIFO_STATUS0_REG		0x08
+
+#define ADSS_MBOXn_MBOX_DMA_POLICY_REG			0x10
+#define MBOX_DMA_POLICY_SW_RESET			BIT(31)
+#define MBOX_DMA_POLICY_TX_INT_TYPE			BIT(17)
+#define MBOX_DMA_POLICY_RX_INT_TYPE			BIT(16)
+#define MBOX_DMA_POLICY_RXD_16BIT_SWAP			BIT(10)
+#define MBOX_DMA_POLICY_RXD_END_SWAP			BIT(8)
+#define ADSS_MBOX_DMA_POLICY_SRAM_AC(x)		((((x) >> 28) & 0xf) << 12)
+#define ADSS_MBOX_DMA_POLICY_TX_FIFO_THRESHOLD(x)	((((x) & 0xf) << 4))
+
+#define ADSS_MBOXn_MBOXn_DMA_RX_DESCRIPTOR_BASE_REG	0x18
+
+#define ADSS_MBOXn_MBOXn_DMA_RX_CONTROL_REG		0x1C
+#define ADSS_MBOXn_DMA_RX_CONTROL_STOP			BIT(0)
+#define ADSS_MBOXn_DMA_RX_CONTROL_START			BIT(1)
+#define ADSS_MBOXn_DMA_RX_CONTROL_RESUME		BIT(2)
+
+#define ADSS_MBOXn_MBOXn_DMA_TX_DESCRIPTOR_BASE_REG	0x20
+
+#define ADSS_MBOXn_MBOXn_DMA_TX_CONTROL_REG		0x24
+#define ADSS_MBOXn_DMA_TX_CONTROL_STOP			BIT(0)
+#define ADSS_MBOXn_DMA_TX_CONTROL_START			BIT(1)
+#define ADSS_MBOXn_DMA_TX_CONTROL_RESUME		BIT(2)
+
+#define ADSS_MBOXn_MBOX_FRAME_REG			0x38
+#define ADSS_MBOXn_FIFO_TIMEOUT_REG			0x40
+
+#define ADSS_MBOXn_MBOX_INT_STATUS_REG			0x44
+#define MBOX_INT_STATUS_TX_DMA_COMPLETE			BIT(6)
+#define MBOX_INT_STATUS_RX_DMA_COMPLETE			BIT(10)
+
+#define ADSS_MBOXn_MBOX_INT_ENABLE_REG			0x4C
+#define MBOX_INT_ENABLE_RX_DMA_COMPLETE			BIT(10)
+#define MBOX_INT_STATUS_RX_UNDERFLOW			BIT(4)
+#define MBOX_INT_STATUS_RX_FIFO_UNDERFLOW		BIT(12)
+#define MBOX_INT_ENABLE_TX_DMA_COMPLETE			BIT(6)
+#define MBOX_INT_STATUS_TX_OVERFLOW			BIT(5)
+#define MBOX_INT_STATUS_TX_FIFO_OVERFLOW		BIT(13)
+
+#define ADSS_MBOXn_MBOX_FIFO_RESET_REG			0x58
+#define MBOX_FIFO_RESET_TX_INIT				BIT(0)
+#define MBOX_FIFO_RESET_RX_INIT				BIT(2)
+
+#define ADSS_MBOXn_MBOX_DEBUG_CHAIN0_REG		0x60
+#define ADSS_MBOXn_MBOX_DEBUG_CHAIN1_REG		0x64
+#define ADSS_MBOXn_MBOX_DEBUG_CHAIN0_SIGNALS_REG	0x68
+#define ADSS_MBOXn_MBOX_DEBUG_CHAIN1_SIGNALS_REG	0x6C
+
+/* ADSS_STEREO0_AUDIO_STEREO_REG Registers */
+
+#define ADSS_STEREO0_AUDIO_BASE		0x9000
+#define ADSS_STEREO1_AUDIO_BASE		0xB000
+#define ADSS_STEREO2_AUDIO_BASE		0xD000
+#define ADSS_STEREO3_AUDIO_BASE		0xF000
+
+#define STEREO0_OFFSET			0x0
+#define STEREO1_OFFSET			0x2000
+#define STEREO2_OFFSET			0x4000
+#define STEREO3_OFFSET			0x6000
+
+#define ADSS_STEREOn_STEREO0_CONFIG_REG			0x0
+#define STEREOn_CONFIG_MIC_SWAP				BIT(24)
+#define STEREOn_CONFIG_SPDIF_ENABLE			BIT(23)
+#define STEREOn_CONFIG_ENABLE				BIT(21)
+#define STEREOn_CONFIG_MIC_RESET			BIT(20)
+#define STEREOn_CONFIG_RESET				BIT(19)
+#define STEREOn_CONFIG_I2S_DELAY			(0 << 18)
+#define STEREOn_CONFIG_PCM_SWAP				BIT(17)
+#define STEREOn_CONFIG_MIC_WORD_SIZE_32			BIT(16)
+#define STEREOn_CONFIG_MIC_WORD_SIZE_16			(0 << 16)
+#define STEREOn_CONFIG_STEREO_MODE			(0 << 14)
+#define STEREOn_CONFIG_MONO_MODE			BIT(14)
+#define STEREOn_CONFIG_STEREO_MONO_MASK			(3 << 14)
+#define STEREOn_CONFIG_DATA_WORD_SIZE(x)		((x) << 12)
+#define STEREOn_CONFIG_DATA_WORD_SIZE_MASK		(3 << 12)
+#define STEREOn_CONFIG_I2S_WORD_SIZE_32			BIT(11)
+#define STEREOn_CONFIG_I2S_WORD_SIZE_16			(0 << 11)
+#define STEREOn_CONFIG_MCK_SEL				BIT(10)
+#define STEREOn_CONFIG_SAMPLE_CNT_CLEAR_TYPE		BIT(9)
+#define STEREOn_CONFIG_MASTER				BIT(8)
+
+#define MAX_STEREO_ENTRIES	4
+#define TDM_SYNC_NUM		2
+#define TDM_DELAY		0
+#define MCLK_MULTI		4
+
+/* ADSS_AUDIO_PCM_REG Registers */
+
+#define ADSS_AUDIO_PCM_REG_BASE		ADSS_BASE + 0x4000
+
+#define AADSS_PCM_BITMAP_REG		0x0
+
+#define AADSS_PCM_CTRL_REG		0x04
+#define PCM_CTRL_TX2RX_LP_EN(x)		(x << 31)
+#define PCM_CTRL_RX2TX_LP_EN(x)		(x << 30)
+#define PCM_CTRL_CPU_MODE(x)		(x << 29)
+#define PCM_CTRL_PCM_GCLK_EN(x)		(x << 28)
+#define PCM_CTRL_FRAME_SYNC_LEN(x)	(x << 26)
+#define PCM_CTRL_PCM_CLK_MODE(x)	(x << 25)
+#define PCM_CTRL_PCM_SLOT_MODE(x)	(x << 24)
+#define PCM_CTRL_PCM_DCLK_MODE(x)	(x << 4)
+#define PCM_CTRL_PCM_TX_PHASE(x)	(x << 2)
+#define PCM_CTRL_PCM_RX_PHASE(x)	(x << 0)
+
+#define AADSS_PCM_OFFSET_REG		0x08
+#define AADSS_PCM_START_REG		0x0C
+#define AADSS_PCM_INT_STATUS_REG	0x10
+#define AADSS_PCM_INT_ENABLE_REG	0x14
+#define AADSS_PCM_RX_DATA_8BIT_REG	0x18
+#define AADSS_PCM_TX_DATA_8BIT_REG	0x1C
+#define AADSS_PCM_DIVIDER_REG		0x20
+#define AADSS_PCM_TH_REG		0x24
+#define AADSS_PCM_FIFO_CNT_REG		0x28
+#define AADSS_PCM_FIFO_ERR_SLOT_REG	0x2C
+#define AADSS_PCM_RX_DATA_16BIT_REG	0x30
+#define AADSS_PCM_TX_DATA_16BIT_REG	0x34
+
+/* I2S Parameters */
+#define IPQ4019_I2S_NO_OF_PERIODS	(130)
+#define IPQ4019_I2S_PERIOD_BYTES_MIN	ALIGN(4032, L1_CACHE_BYTES)
+#define IPQ4019_I2S_BUFF_SIZE		(IPQ4019_I2S_PERIOD_BYTES_MIN * \
+						IPQ4019_I2S_NO_OF_PERIODS)
+#define IPQ4019_I2S_CAPTURE_BUFF_SIZE	(IPQ4019_I2S_PERIOD_BYTES_MIN * \
+						IPQ4019_I2S_NO_OF_PERIODS)
+
+/* TDM Parameters */
+#define IPQ4019_TDM_NO_OF_PERIODS	(260)
+#define IPQ4019_TDM_PERIOD_BYTES_MIN	ALIGN(4032, L1_CACHE_BYTES)
+#define IPQ4019_TDM_BUFF_SIZE		(IPQ4019_TDM_PERIOD_BYTES_MIN * \
+						IPQ4019_TDM_NO_OF_PERIODS)
+#define IPQ4019_TDM_CAPTURE_BUFF_SIZE	(IPQ4019_TDM_PERIOD_BYTES_MIN * \
+						IPQ4019_TDM_NO_OF_PERIODS)
+
+/* SPDIF area */
+
+
+/* ADSS_MBOXSPDIFIN_AUDIO_MBOX_REG Registers */
+
+#define ADSS_MBOXSPDIFIN_AUDIO_MBOX_REG_BASE	ADSS_BASE + 0x6000
+
+#define AADSS_MBOXSPDIFIN_MBOX_FIFO0_REG \\
+	((ADSS_MBOXSPDIFIN_AUDIO_MBOX_REG_BASE) + 0x0)
+
+#define AADSS_MBOXSPDIFIN_MBOX_FIFO_STATUS0_REG \\
+	((ADSS_MBOXSPDIFIN_AUDIO_MBOX_REG_BASE) + 0x08)
+
+#define AADSS_MBOXSPDIFIN_MBOX_DMA_POLICY_REG \\
+	((ADSS_MBOXSPDIFIN_AUDIO_MBOX_REG_BASE) + 0x10)
+
+#define AADSS_MBOXSPDIFIN_MBOX0_DMA_RX_DESCRIPTOR_BASE_REG \\
+	((ADSS_MBOXSPDIFIN_AUDIO_MBOX_REG_BASE) + 0x18)
+
+#define AADSS_MBOXSPDIFIN_MBOX0_DMA_RX_CONTROL_REG \\
+	((ADSS_MBOXSPDIFIN_AUDIO_MBOX_REG_BASE) + 0x1C)
+
+#define AADSS_MBOXSPDIFIN_MBOX0_DMA_TX_DESCRIPTOR_BASE_REG \\
+	((ADSS_MBOXSPDIFIN_AUDIO_MBOX_REG_BASE) + 0x20)
+
+#define AADSS_MBOXSPDIFIN_MBOX0_DMA_TX_CONTROL_REG \\
+	((ADSS_MBOXSPDIFIN_AUDIO_MBOX_REG_BASE) + 0x24)
+
+#define AADSS_MBOXSPDIFIN_MBOX_FRAME_REG \\
+	((ADSS_MBOXSPDIFIN_AUDIO_MBOX_REG_BASE) + 0x38)
+
+#define AADSS_MBOXSPDIFIN_FIFO_TIMEOUT_REG \\
+	((ADSS_MBOXSPDIFIN_AUDIO_MBOX_REG_BASE) + 0x40)
+
+#define AADSS_MBOXSPDIFIN_MBOX_INT_STATUS_REG \\
+	((ADSS_MBOXSPDIFIN_AUDIO_MBOX_REG_BASE) + 0x44)
+
+#define AADSS_MBOXSPDIFIN_MBOX_INT_ENABLE_REG \\
+	((ADSS_MBOXSPDIFIN_AUDIO_MBOX_REG_BASE) + 0x4C)
+
+#define AADSS_MBOXSPDIFIN_MBOX_FIFO_RESET_REG \\
+	((ADSS_MBOXSPDIFIN_AUDIO_MBOX_REG_BASE) + 0x58)
+
+#define AADSS_MBOXSPDIFIN_MBOX_DEBUG_CHAIN0_REG \\
+	((ADSS_MBOXSPDIFIN_AUDIO_MBOX_REG_BASE) + 0x60)
+
+#define AADSS_MBOXSPDIFIN_MBOX_DEBUG_CHAIN1_REG \\
+	((ADSS_MBOXSPDIFIN_AUDIO_MBOX_REG_BASE) + 0x64)
+
+#define AADSS_MBOXSPDIFIN_MBOX_DEBUG_CHAIN0_SIGNALS_REG \\
+	((ADSS_MBOXSPDIFIN_AUDIO_MBOX_REG_BASE) + 0x68)
+
+#define AADSS_MBOXSPDIFIN_MBOX_DEBUG_CHAIN1_SIGNALS_REG \\
+	((ADSS_MBOXSPDIFIN_AUDIO_MBOX_REG_BASE) + 0x6C)
+
+/* ADSS_SPDIFIN_AUDIO_SPDIF_BASE Registers */
+
+#define ADSS_SPDIFIN_SPDIF_CTRL_REG		(0x00)
+#define SPDIF_CTRL_INTREQ_MASK			BIT(31)
+#define SPDIF_CTRL_BEGIN_MASK			BIT(30)
+#define SPDIF_CTRL_LOCK_MASK			BIT(29)
+#define SPDIF_CTRL_SYNCERR_MASK			BIT(28)
+#define SPDIF_CTRL_AFULL_MASK			BIT(27)
+#define SPDIF_CTRL_FULL_MASK			BIT(26)
+#define SPDIF_CTRL_AEMPTY_MASK			BIT(25)
+#define SPDIF_CTRL_EMPTY_MASK			BIT(24)
+#define SPDIF_CTRL_OVRERR_MASK			BIT(23)
+#define SPDIF_CTRL_UNDERR_MASK			BIT(22)
+#define SPDIF_CTRL_PARITY_MASK			BIT(21)
+#define SPDIF_CTRL_USE_FIFO_IF			BIT(19)
+#define SPDIF_CTRL_SETPREAMBB			BIT(18)
+#define SPDIF_CTRL_DUPLICATE			BIT(17)
+#define SPDIF_CTRL_CHANNEL_MODE			BIT(16)
+#define SPDIF_CTRL_VALIDITYCHECK		BIT(15)
+#define SPDIF_CTRL_PARITYGEN			BIT(14)
+#define SPDIF_CTRL_PARITYCHECK			BIT(13)
+#define SPDIF_CTRL_TR_MODE			BIT(12)
+#define SPDIF_CTRL_CLK_ENABLE			BIT(11)
+#define SPDIF_CTRL_FIFO_ENABLE			BIT(10)
+#define SPDIF_CTRL_SPDIF_ENABLE			BIT(9)
+#define SPDIF_CTRL_SFR_ENABLE			BIT(8)
+#define SPDIF_CTRL_TSAMPLERATE			BIT(7)
+
+#define ADSS_SPDIFIN_STEREO0_VOLUME		(0x04)
+#define ADSS_SPDIFIN_FIFO_CTRL_REG		(0x08)
+#define ADSS_SPDIFIN_START_REG_REG		(0x0C)
+#define ADSS_SPDIFIN_SELFIFO_REG		(0x10)
+
+
+#define ADSS_AUDIO_SPDIF_MISC_REG		0x150
+#define AUDIO_SPDIF_MISC_AUTO_SCALE_DIV_MASK	(0xF << 1)
+#define AUDIO_SPDIF_MISC_AUTO_SCALE_DIV(x)	(x << 1)
+
+#define ADSS_AUDIO_SPDIF_CBCR_REG		0x154
+
+#define ADSS_AUDIO_SPDIFDIV2_MISC_REG		0x158
+#define AUDIO_SPDIFDIV2_MISC_AUTO_SCALE_DIV_MASK	(0xF << 1)
+#define AUDIO_SPDIFDIV2_MISC_AUTO_SCALE_DIV(x)	(x << 1)
+
+#define ADSS_AUDIO_SPDIFDIV2_CBCR_REG		0x15C
+#define ADSS_AUDIO_SPDIFINFAST_CMD_RCGR_REG	0x1E0
+#define AUDIO_SPDIFINFAST_CMD_RCGR_ROOT_EN	(1 << 1)
+#define AUDIO_SPDIFINFAST_CMD_RCGR_UPDATE	(1 << 0)
+
+#define ADSS_AUDIO_SPDIFINFAST_CFG_RCGR_REG	0x1E4
+#define AUDIO_SPDIFINFAST_CFG_RCGR_SRC_SEL(x)	(x << 8)
+#define AUDIO_SPDIFINFAST_CFG_RCGR_SRC_DIV(x)	(x << 0)
+
+#define ADSS_AUDIO_SPDIFINFAST_CBCR_REG		0x1EC
+#define AUDIO_SPDIFINFAST			49152000
+
+#define SNDRV_PCM_FMTBIT_S24_3			SNDRV_PCM_FMTBIT_S24_3LE
+
+/* Enumerations */
+
+enum intf {
+	I2S,
+	TDM,
+	SPDIF,
+	I2S1,
+	I2S2,
+	MAX_INTF
+};
+
+enum dir {
+	PLAYBACK,
+	CAPTURE
+};
+
+enum cfg {
+	DISABLE,
+	ENABLE
+};
+
+/* Supported Channels */
+enum channels {
+	CH_STEREO = 2,
+	CH_3_1 = 4,
+	CH_5_1 = 6,
+	CH_7_1 = 8
+};
+
+enum ipq4019_samp_freq {
+	FREQ_8000 = 8000,
+	FREQ_11025 = 11025,
+	FREQ_16000 = 16000,
+	FREQ_22050 = 22050,
+	FREQ_32000 = 32000,
+	FREQ_44100 = 44100,
+	FREQ_48000 = 48000,
+	FREQ_64000 = 64000,
+	FREQ_88200 = 88200,
+	FREQ_96000 = 96000,
+	FREQ_176400 = 176400,
+	FREQ_192000 = 192000,
+};
+
+#define RATE_16000_96000 \
+		(SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 |\
+		SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |\
+		SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_64000 |\
+		SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000)
+
+enum stereo_ch {
+	STEREO0,
+	STEREO1,
+	STEREO2,
+	STEREO3
+};
+
+enum bit_width {
+	__BIT_8 = 8,
+	__BIT_16 = 16,
+	__BIT_24 = 24,
+	__BIT_32 = 32,
+	__BIT_INVAL = -1
+};
+
+/* ADSS APIs */
+extern void ipq4019_glb_audio_mode(int mode, int dir);
+extern void ipq4019_glb_tx_data_port_en(uint32_t enable);
+extern void ipq4019_glb_rx_data_port_en(uint32_t enable);
+extern void ipq4019_glb_tx_framesync_port_en(uint32_t enable);
+extern void ipq4019_glb_rx_framesync_port_en(uint32_t enable);
+extern void ipq4019_glb_clk_enable_oe(uint32_t dir);
+/* Stereo APIs */
+extern void ipq4019_stereo_config_reset(uint32_t reset, uint32_t stereo_offset);
+extern void ipq4019_stereo_config_mic_reset(uint32_t reset,
+					uint32_t stereo_offset);
+extern void ipq4019_stereo_config_enable(uint32_t enable,
+					uint32_t stereo_offset);
+extern int ipq4019_cfg_bit_width(uint32_t bit_width, uint32_t stereo_offset);
+extern void ipq4019_config_stereo_mode(uint32_t mode, uint32_t stereo_offset);
+extern void ipq4019_config_master(uint32_t enable, uint32_t stereo_offset);
+extern void ipq4019_config_mclk_sel(uint32_t stereo_offset, uint32_t val);
+extern void ipq4019_config_sample_cnt_clear_type(uint32_t stereo_offset);
+
+/* APIs in DAI driver */
+extern int ipq4019_get_mbox_id(struct snd_pcm_substream *substream, int intf);
+extern int ipq4019_get_stereo_id(struct snd_pcm_substream *substream, int intf);
+extern u32 ipq4019_get_act_bit_width(u32 bit_width);
+extern void ipq4019_stereo_spdif_enable(uint32_t enable, uint32_t stereo_id);
+extern void ipq4019_stereo_spdif_pcmswap(uint32_t enable, uint32_t stereo_id);
+extern void ipq4019_spdifin_ctrl_spdif_en(uint32_t enable);
+extern void ipq4019_glb_spdif_out_en(uint32_t enable);
+extern void ipq4019_spdifin_cfg(void);
+extern void ipq4019_glb_tdm_ctrl_ch_num(uint32_t val, uint32_t dir);
+extern void ipq4019_glb_tdm_ctrl_sync_num(uint32_t val, uint32_t dir);
+extern void ipq4019_glb_tdm_ctrl_delay(uint32_t delay, uint32_t dir);
+
+void ipq4019_glb_audio_mode_B1K(void);
+
+#endif
diff --git a/sound/soc/qcom/ipq4019/ipq4019-codec.c b/sound/soc/qcom/ipq4019/ipq4019-codec.c
new file mode 100644
index 0000000..61421d9
--- /dev/null
+++ b/sound/soc/qcom/ipq4019/ipq4019-codec.c
@@ -0,0 +1,475 @@
+/*
+ * Copyright (c) 2015-2016, The Linux Foundation. All rights reserved.
+ *
+ * Permission to use, copy, modify, and/or distribute this software for any
+ * purpose with or without fee is hereby granted, provided that the above
+ * copyright notice and this permission notice appear in all copies.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
+ * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
+ * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
+ * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+ * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+ * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <sound/soc.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/soc-dai.h>
+#include <sound/control.h>
+#include <linux/platform_device.h>
+#include <linux/spi/spi.h>
+#include <linux/i2c.h>
+#include <linux/gpio.h>
+#include <linux/delay.h>
+#include <sound/initval.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+
+#include "ipq4019-adss.h"
+#include "ipq4019-codec.h"
+
+struct audio_hw_params audio_params;
+
+static const u8 akd4613_reg[AK4613_MAX_REG] = {
+	0x0F, 0x07, 0x3F, 0x20, 0x20, 0x55, 0x05, 0x07,
+	0x0F, 0x07, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+};
+
+uint8_t ipq4019_compare_hw_params(struct audio_hw_params *curr_params)
+{
+	if ((curr_params->bit_width == audio_params.bit_width) &&
+		(curr_params->freq == audio_params.freq) &&
+		(curr_params->channels == audio_params.channels))
+		return 0;
+	else
+		return -EINVAL;
+}
+
+/* DFS : Sampling Speed
+ *
+ * DFS1	DFS0		Sampling Speed Mode (fs)
+ * 0	0	Normal Speed Mode	32kHz~48kHz (default)
+ * 0	1	Double Speed Mode	64kHz~96kHz
+ * 1	0	Quad Speed Mode	128kHz~192kHz
+ * 1	1	N/A			-
+ */
+
+static int ipq4019_codec_i2c_set_dfs(struct snd_soc_codec *codec, int mode)
+{
+	uint32_t reg;
+
+	if (mode > QUAD_SPEED) {
+		pr_err("%s: %d: Invalid DFS mode", __func__, __LINE__);
+		return -EINVAL;
+	}
+
+	reg = snd_soc_read(codec, AKD4613_04_CTRL2);
+
+	reg &= ~(AKD4613_DFS_MASK);
+	reg |= AKD4613_DFS(mode);
+
+	snd_soc_write(codec, AKD4613_04_CTRL2, reg);
+
+	return 0;
+}
+
+/* CKS : Master Clock Input Frequency Select
+ *
+ * CKS1	CKS0	Normal Speed	Double Speed	Quad Speed
+ * 0	0	256fs		256fs		128fs
+ * 0	1	384fs		256fs		128fs
+ * 1	0	512fs		256fs		128fs (default)
+ * 1	1	512fs		256fs		128fs
+ */
+
+static int ipq4019_codec_i2c_set_cks(struct snd_soc_codec *codec,
+					int config, int mode)
+{
+	uint32_t cks_val;
+	uint32_t reg;
+
+	if (mode == NORMAL_SPEED) {
+		if (config == FS_256)
+			cks_val = 0;
+		else if (config == FS_384)
+			cks_val = 1;
+		else if (config == FS_512)
+			cks_val = 2;
+		else
+			cks_val = -EINVAL;
+	} else if (mode == DOUBLE_SPEED) {
+		if (config == FS_256)
+			cks_val = 2;
+		else
+			cks_val = -EINVAL;
+	} else if (mode == QUAD_SPEED) {
+		if (config == FS_128)
+			cks_val = 2;
+		else
+			cks_val = -EINVAL;
+	} else {
+		pr_err("%s: %d: Invalid DFS mode", __func__, __LINE__);
+		return -EINVAL;
+	}
+
+	if (cks_val < 0) {
+		pr_err("%s: %d: Invalid CKS config", __func__, __LINE__);
+		return cks_val;
+	}
+
+	reg = snd_soc_read(codec, AKD4613_04_CTRL2);
+
+	reg &= ~(AKD4613_CKS_MASK);
+	reg |= AKD4613_CKS(cks_val);
+
+	snd_soc_write(codec, AKD4613_04_CTRL2, reg);
+
+	return 0;
+}
+
+static int ipq4019_codec_i2c_set_tdm_mode(struct snd_soc_codec *codec,
+						int tdm_mode)
+{
+	uint32_t reg;
+
+	if (tdm_mode >= TDM_MAX) {
+		pr_err("%s: %d: Invalid DFS mode", __func__, __LINE__);
+		return -EINVAL;
+	}
+
+	reg = snd_soc_read(codec, AKD4613_03_CTRL1);
+
+	reg &= ~(AKD4613_TDM_MODE_MASK);
+	reg |= AKD4613_TDM_MODE(tdm_mode);
+
+	snd_soc_write(codec, AKD4613_03_CTRL1, reg);
+
+	return 0;
+}
+
+static int ipq4019_codec_i2c_set_dif(struct snd_soc_codec *codec,
+						int dif_val)
+{
+	uint32_t reg;
+
+	reg = snd_soc_read(codec, AKD4613_03_CTRL1);
+
+	reg &= ~(AKD4613_DIF_MASK);
+	reg |= AKD4613_DIF(dif_val);
+
+	snd_soc_write(codec, AKD4613_03_CTRL1, reg);
+
+	return 0;
+}
+
+static void ipq4019_codec_i2c_write_defaults(struct snd_soc_codec *codec)
+{
+	int i;
+
+	for (i = 0; i < AK4613_MAX_REG; i++)
+		snd_soc_write(codec, i, akd4613_reg[i]);
+	udelay(10);
+}
+
+static int ipq4019_codec_audio_startup(struct snd_pcm_substream *substream,
+					struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec;
+
+	codec = dai->codec;
+
+	/* I2S and TDM cannot co-exist. CPU DAI startup would
+	 * have already checked this case, by this time.
+	 */
+	if (!dai->active)
+		ipq4019_codec_i2c_write_defaults(codec);
+
+	return 0;
+}
+
+static int ipq4019_codec_audio_hw_params(struct snd_pcm_substream *substream,
+					struct snd_pcm_hw_params *params,
+					struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec;
+	int samp_rate = params_rate(params);
+	u32 bit_width = params_format(params);
+	int channels = params_channels(params);
+	int bit_act;
+	int dfs, cks, tdm_mode, dif;
+	uint32_t intf = dai->driver->id;
+	struct audio_hw_params curr_params;
+
+	bit_act = ipq4019_get_act_bit_width(bit_width);
+	if (bit_act == __BIT_INVAL)
+		return -EINVAL;
+
+	curr_params.freq = samp_rate;
+	curr_params.channels = channels;
+	curr_params.bit_width = bit_act;
+
+	codec = dai->codec;
+
+	/*
+	 * Since CLKS in the codec are shared by I2S TX and RX channels,
+	 * Rx and Tx when used simulatneoulsy will have to use the same channel,
+	 * sampling frequency and bit widths. So compare the settings and then
+	 * update the codec settings.
+	 */
+
+	if (dai->active > 1) {
+		if (ipq4019_compare_hw_params(&curr_params)) {
+			/* Playback and capture settings do not match */
+			pr_err("\nPlayback and capture settings do not match\n");
+			return -EINVAL;
+		}
+		/* Settings match, codec settings are already done*/
+		return 0;
+	}
+
+	audio_params.freq = samp_rate;
+	audio_params.channels = channels;
+	audio_params.bit_width = bit_act;
+
+	if (intf == I2S) {
+		/* default values */
+		dfs = NORMAL_SPEED;
+		cks = FS_512;
+		tdm_mode = STEREO;
+		dif = DIF_I2S_MODE;
+
+	} else if (intf == TDM) {
+		/* Codec settings for 8 channels */
+		dfs = DOUBLE_SPEED;
+		cks = FS_256;
+		tdm_mode = TDM_256;
+		dif = DIF_LR_MODE3;
+	} else {
+		pr_err("\n%s Invalid interface\n", __func__);
+		return -EINVAL;
+	}
+
+	ipq4019_codec_i2c_set_dfs(codec, dfs);
+	ipq4019_codec_i2c_set_cks(codec, cks, dfs);
+	ipq4019_codec_i2c_set_tdm_mode(codec, tdm_mode);
+	ipq4019_codec_i2c_set_dif(codec, dif);
+	udelay(10);
+
+	return 0;
+}
+
+static int ipq4019_codec_audio_prepare(struct snd_pcm_substream *substream,
+					struct snd_soc_dai *dai)
+{
+	dev_dbg(dai->dev, "%s:%d\n", __func__, __LINE__);
+	return 0;
+}
+
+static void ipq4019_codec_audio_shutdown(struct snd_pcm_substream *substream,
+					struct snd_soc_dai *dai)
+{
+	dev_dbg(dai->dev, "%s:%d\n", __func__, __LINE__);
+}
+
+static struct snd_soc_dai_ops ipq4019_codec_audio_ops = {
+	.startup	= ipq4019_codec_audio_startup,
+	.hw_params	= ipq4019_codec_audio_hw_params,
+	.prepare	= ipq4019_codec_audio_prepare,
+	.shutdown	= ipq4019_codec_audio_shutdown,
+};
+
+static struct snd_soc_dai_driver ipq4019_codec_dais[] = {
+	{
+		.name = "qca-i2s-codec-dai",
+		.playback = {
+			.stream_name = "qca-i2s-playback",
+			.channels_min = CH_STEREO,
+			.channels_max = CH_STEREO,
+			.rates = RATE_16000_96000,
+			.formats = SNDRV_PCM_FMTBIT_S16 |
+				SNDRV_PCM_FMTBIT_S32,
+		},
+		.capture = {
+			.stream_name = "qca-i2s-capture",
+			.channels_min = CH_STEREO,
+			.channels_max = CH_STEREO,
+			.rates = RATE_16000_96000,
+			.formats = SNDRV_PCM_FMTBIT_S16 |
+				SNDRV_PCM_FMTBIT_S32,
+		},
+		.ops = &ipq4019_codec_audio_ops,
+		.id = I2S,
+	},
+	{
+		.name = "qca-tdm-codec-dai",
+		.playback = {
+			.stream_name = "qca-tdm-playback",
+			.channels_min = CH_STEREO,
+			.channels_max = CH_7_1,
+			.rates = RATE_16000_96000,
+			.formats = SNDRV_PCM_FMTBIT_S16 |
+				SNDRV_PCM_FMTBIT_S32,
+		},
+		.capture = {
+			.stream_name = "qca-tdm-capture",
+			.channels_min = CH_STEREO,
+			.channels_max = CH_7_1,
+			.rates = RATE_16000_96000,
+			.formats = SNDRV_PCM_FMTBIT_S16 |
+				SNDRV_PCM_FMTBIT_S32,
+		},
+		.ops = &ipq4019_codec_audio_ops,
+		.id = TDM,
+	},
+	{
+		.name = "qca-i2s1-codec-dai",
+		.playback = {
+			.stream_name = "qca-i2s1-playback",
+			.channels_min = CH_STEREO,
+			.channels_max = CH_STEREO,
+			.rates = RATE_16000_96000,
+			.formats = SNDRV_PCM_FMTBIT_S16 |
+				SNDRV_PCM_FMTBIT_S32,
+		},
+	},
+	{
+		.name = "qca-i2s2-codec-dai",
+		.playback = {
+			.stream_name = "qca-i2s2-playback",
+			.channels_min = CH_STEREO,
+			.channels_max = CH_STEREO,
+			.rates = RATE_16000_96000,
+			.formats = SNDRV_PCM_FMTBIT_S16 |
+				SNDRV_PCM_FMTBIT_S32,
+		},
+	},
+	{
+		.name = "qca-spdif-codec-dai",
+		.playback = {
+			.stream_name = "qca-spdif-playback",
+			.channels_min = CH_STEREO,
+			.channels_max = CH_STEREO,
+			.rates = RATE_16000_96000,
+			.formats = SNDRV_PCM_FMTBIT_S16 |
+				SNDRV_PCM_FMTBIT_S24_3,
+		},
+		.capture = {
+			.stream_name = "qca-spdif-capture",
+			.channels_min = CH_STEREO,
+			.channels_max = CH_STEREO,
+			.rates = RATE_16000_96000,
+			.formats = SNDRV_PCM_FMTBIT_S16 |
+				SNDRV_PCM_FMTBIT_S24_3,
+		},
+	},
+};
+
+static int ipq4019_info(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_info *uinfo)
+{
+	return -ENOTSUPP;
+}
+
+static const struct snd_kcontrol_new vol_ctrl  = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "playback volume",
+	.access = (SNDRV_CTL_ELEM_ACCESS_TLV_READ |
+		SNDRV_CTL_ELEM_ACCESS_READWRITE),
+	.info = ipq4019_info,
+};
+
+unsigned int ipq4019_codec_i2c_read(struct snd_soc_codec *codec,
+					unsigned int reg)
+{
+	int ret;
+
+	ret = i2c_smbus_read_byte_data(codec->control_data, (u8)(reg & 0xFF));
+	if (ret < 0)
+		pr_err("\ti2c read error %s(%d)\n", __func__, ret);
+
+	return ret;
+}
+
+static const struct snd_soc_codec_driver ipq4019_codec = {
+	.num_controls = 0,
+	.reg_cache_size = ARRAY_SIZE(akd4613_reg),
+	.reg_word_size = sizeof(u8),
+	.reg_cache_default = akd4613_reg,
+};
+
+static const struct of_device_id ipq4019_codec_id_table[] = {
+	{ .compatible = "qca,ipq4019-codec" },
+	{ /* Sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, ipq4019_codec_id_table);
+
+static int ipq4019_codec_i2c_probe(struct i2c_client *i2c,
+					const struct i2c_device_id *id)
+{
+	int ret;
+
+	ret = snd_soc_register_codec(&i2c->dev,
+			&ipq4019_codec, ipq4019_codec_dais,
+			ARRAY_SIZE(ipq4019_codec_dais));
+	if (ret < 0)
+		pr_err("\nsnd_soc_register_codec failed (%d)\n", ret);
+
+	return ret;
+}
+
+static int ipq4019_codec_i2c_remove(struct i2c_client *client)
+{
+	snd_soc_unregister_codec(&client->dev);
+	return 0;
+}
+
+static const struct of_device_id ipq4019_codec_of_match[] = {
+	{ .compatible = "qca,ipq4019-codec" },
+	{},
+};
+
+static const struct i2c_device_id ipq4019_codec_i2c_id[] = {
+	{ "qca_codec", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, ipq4019_codec_i2c_id);
+
+static struct i2c_driver ipq4019_codec_i2c_driver = {
+	.driver = {
+		.name = "qca_codec",
+		.owner = THIS_MODULE,
+		.of_match_table = ipq4019_codec_of_match,
+	},
+	.probe = ipq4019_codec_i2c_probe,
+	.remove = ipq4019_codec_i2c_remove,
+	.id_table = ipq4019_codec_i2c_id,
+};
+
+static int ipq4019_codec_init(void)
+{
+	int ret;
+
+	ret = i2c_add_driver(&ipq4019_codec_i2c_driver);
+	if (ret < 0)
+		pr_err("%s: %d: Failed to add I2C driver", __func__, __LINE__);
+
+	return ret;
+}
+module_init(ipq4019_codec_init);
+
+static void ipq4019_codec_exit(void)
+{
+	i2c_del_driver(&ipq4019_codec_i2c_driver);
+}
+module_exit(ipq4019_codec_exit);
+
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_DESCRIPTION("IPQ4019 Codec Driver");
diff --git a/sound/soc/qcom/ipq4019/ipq4019-codec.h b/sound/soc/qcom/ipq4019/ipq4019-codec.h
new file mode 100644
index 0000000..bf91c0f
--- /dev/null
+++ b/sound/soc/qcom/ipq4019/ipq4019-codec.h
@@ -0,0 +1,91 @@
+/*
+ * Copyright (c) 2015-2016, The Linux Foundation. All rights reserved.
+ *
+ * Permission to use, copy, modify, and/or distribute this software for any
+ * purpose with or without fee is hereby granted, provided that the above
+ * copyright notice and this permission notice appear in all copies.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
+ * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
+ * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
+ * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+ * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+ * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+ *
+ */
+
+#define AKD4613_00_PM1		0x00
+#define AKD4613_01_PM2		0x01
+#define AKD4613_02_PM3		0x02
+#define AKD4613_03_CTRL1	0x03
+#define AKD4613_04_CTRL2	0x04
+#define AKD4613_05_DE_EMP1	0x05
+#define AKD4613_06_DE_EMP2	0x06
+#define AKD4613_07_OVRFLW_DT	0x07
+#define AKD4613_08_ZERO_DT	0x08
+#define AKD4613_09_IP_CTRL	0x09
+#define AKD4613_0A_OP_CTRL	0x0A
+#define AKD4613_0B_LOUT1_CTRL	0x0B
+#define AKD4613_0C_ROUT1_CTRL	0x0C
+#define AKD4613_0D_LOUT2_CTRL	0x0D
+#define AKD4613_0E_ROUT2_CTRL	0x0E
+#define AKD4613_0F_LOUT3_CTRL	0x0F
+#define AKD4613_10_ROUT3_CTRL	0x10
+#define AKD4613_11_LOUT4_CTRL	0x11
+#define AKD4613_12_ROUT4_CTRL	0x12
+#define AKD4613_13_LOUT5_CTRL	0x13
+#define AKD4613_14_ROUT5_CTRL	0x14
+#define AKD4613_15_LOUT6_CTRL	0x15
+#define AKD4613_16_ROUT6_CTRL	0x16
+
+#define AK4613_MAX_REG		(AKD4613_16_ROUT6_CTRL + 1)
+
+/* AKD4613_03_CTRL1 */
+#define AKD4613_DIF_MASK		(7 << 3)
+#define AKD4613_DIF(x)			(x << 3)
+#define AKD4613_DIF_I2S_MODE		(4 << 3)
+#define AKD4613_TDM_MODE_MASK		(3 << 6)
+#define AKD4613_TDM_MODE(x)		(x << 6)
+
+/* AKD4613_04_CTRL2 */
+#define AKD4613_CKS_MASK		(0x3 << 4)
+#define AKD4613_CKS(x)			(x << 4)
+#define AKD4613_DFS_MASK		(0x3 << 2)
+#define AKD4613_DFS(x)			(x << 2)
+
+struct audio_hw_params {
+	uint8_t channels;
+	uint32_t freq;
+	uint8_t bit_width;
+};
+
+enum dfs {
+	NORMAL_SPEED,
+	DOUBLE_SPEED,
+	QUAD_SPEED,
+	NA
+};
+
+enum cks {
+	FS_128,
+	FS_256,
+	FS_384,
+	FS_512
+};
+
+enum tdm_mode {
+	STEREO,
+	TDM_512,
+	TDM_256,
+	TDM_128,
+	TDM_MAX
+};
+
+enum dif {
+	DIF_LR_MODE0,
+	DIF_LR_MODE1,
+	DIF_LR_MODE2,
+	DIF_LR_MODE3,
+	DIF_I2S_MODE
+};
diff --git a/sound/soc/qcom/ipq4019/ipq4019-cpu-dai.c b/sound/soc/qcom/ipq4019/ipq4019-cpu-dai.c
new file mode 100644
index 0000000..8f33e91
--- /dev/null
+++ b/sound/soc/qcom/ipq4019/ipq4019-cpu-dai.c
@@ -0,0 +1,687 @@
+/*
+ * Copyright (c) 2015-2016, The Linux Foundation. All rights reserved.
+ *
+ * Permission to use, copy, modify, and/or distribute this software for any
+ * purpose with or without fee is hereby granted, provided that the above
+ * copyright notice and this permission notice appear in all copies.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
+ * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
+ * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
+ * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+ * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+ * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/pcm_params.h>
+#include <linux/io.h>
+#include <linux/delay.h>
+#include <linux/of_device.h>
+#include <linux/clk-provider.h>
+#include <linux/clk.h>
+
+#include "ipq4019-mbox.h"
+#include "ipq4019-adss.h"
+
+struct dai_priv_st {
+	int stereo_tx;
+	int stereo_rx;
+	int mbox_tx;
+	int mbox_rx;
+	int tx_enabled;
+	int rx_enabled;
+	struct platform_device *pdev;
+};
+static struct dai_priv_st dai_priv[MAX_INTF];
+
+static struct clk *audio_tx_bclk;
+static struct clk *audio_tx_mclk;
+static struct clk *audio_rx_bclk;
+static struct clk *audio_rx_mclk;
+static struct clk *audio_spdif_src;
+static struct clk *audio_spdif_div2;
+static struct clk *audio_spdifinfast_src;
+
+/* Get Stereo channel ID based on I2S intf and direction */
+int ipq4019_get_stereo_id(struct snd_pcm_substream *substream, int intf)
+{
+	switch (substream->stream) {
+	case SNDRV_PCM_STREAM_PLAYBACK:
+		return dai_priv[intf].stereo_tx;
+	case SNDRV_PCM_STREAM_CAPTURE:
+		return dai_priv[intf].stereo_rx;
+	}
+	return -EINVAL;
+}
+EXPORT_SYMBOL(ipq4019_get_stereo_id);
+
+/* Get MBOX channel ID based on I2S/TDM/SPDIF intf and direction */
+int ipq4019_get_mbox_id(struct snd_pcm_substream *substream, int intf)
+{
+	switch (substream->stream) {
+	case SNDRV_PCM_STREAM_PLAYBACK:
+		return dai_priv[intf].mbox_tx;
+	case SNDRV_PCM_STREAM_CAPTURE:
+		return dai_priv[intf].mbox_rx;
+	}
+	return -EINVAL;
+}
+EXPORT_SYMBOL(ipq4019_get_mbox_id);
+
+u32 ipq4019_get_act_bit_width(u32 bit_width)
+{
+	switch (bit_width) {
+	case SNDRV_PCM_FORMAT_S8:
+	case SNDRV_PCM_FORMAT_U8:
+		return __BIT_8;
+	case SNDRV_PCM_FORMAT_S16_LE:
+	case SNDRV_PCM_FORMAT_S16_BE:
+	case SNDRV_PCM_FORMAT_U16_LE:
+	case SNDRV_PCM_FORMAT_U16_BE:
+		return __BIT_16;
+	case SNDRV_PCM_FORMAT_S24_3LE:
+	case SNDRV_PCM_FORMAT_S24_3BE:
+	case SNDRV_PCM_FORMAT_U24_3LE:
+	case SNDRV_PCM_FORMAT_U24_3BE:
+		return __BIT_32;
+	case SNDRV_PCM_FORMAT_S24_LE:
+	case SNDRV_PCM_FORMAT_S24_BE:
+	case SNDRV_PCM_FORMAT_U24_LE:
+	case SNDRV_PCM_FORMAT_U24_BE:
+		return __BIT_24;
+	case SNDRV_PCM_FORMAT_S32_LE:
+	case SNDRV_PCM_FORMAT_S32_BE:
+	case SNDRV_PCM_FORMAT_U32_LE:
+	case SNDRV_PCM_FORMAT_U32_BE:
+		return __BIT_32;
+	}
+	return __BIT_INVAL;
+}
+EXPORT_SYMBOL(ipq4019_get_act_bit_width);
+
+static int ipq4019_audio_clk_get(struct clk **clk, struct device *dev,
+					const char *id)
+{
+	*clk = devm_clk_get(dev, id);
+	if (IS_ERR(*clk)) {
+		dev_err(dev, "%s: Error in %s\n", __func__, id);
+		return PTR_ERR(*clk);
+	}
+
+	return 0;
+}
+
+static int ipq4019_audio_clk_set(struct clk *clk, struct device *dev,
+					u32 val)
+{
+	int ret;
+
+	ret = clk_set_rate(clk, val);
+	if (ret != 0) {
+		dev_err_ratelimited(dev, "Error in setting %s\n",
+						__clk_get_name(clk));
+		return ret;
+	}
+
+	ret = clk_prepare_enable(clk);
+	if (ret != 0) {
+		dev_err_ratelimited(dev, "Error in enable %s\n",
+					__clk_get_name(clk));
+		return ret;
+	}
+
+	return 0;
+}
+
+static void ipq4019_audio_clk_disable(struct clk **clk, struct device *dev)
+{
+	if (__clk_is_enabled(*clk))
+		clk_disable_unprepare(*clk);
+}
+
+static int ipq4019_audio_startup(struct snd_pcm_substream *substream,
+				struct snd_soc_dai *dai)
+{
+	u32 intf = dai->driver->id;
+
+	switch (substream->stream) {
+	case SNDRV_PCM_STREAM_PLAYBACK:
+		/* Check if the direction is enabled */
+		if (dai_priv[intf].tx_enabled != ENABLE)
+			return -EFAULT;
+
+		ipq4019_glb_tx_data_port_en(ENABLE);
+		ipq4019_glb_tx_framesync_port_en(ENABLE);
+		break;
+	case SNDRV_PCM_STREAM_CAPTURE:
+		/* Check if the direction is enabled */
+		if (dai_priv[intf].rx_enabled != ENABLE)
+			return -EFAULT;
+
+		ipq4019_glb_rx_data_port_en(ENABLE);
+		ipq4019_glb_rx_framesync_port_en(ENABLE);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (intf == I2S || intf == I2S1 || intf == I2S2) {
+		/* Select I2S mode */
+		ipq4019_glb_audio_mode(I2S, substream->stream);
+	} else if (intf == TDM) {
+		/* Select TDM mode */
+		ipq4019_glb_audio_mode(TDM, substream->stream);
+
+		/* Set TDM Ctrl register */
+		ipq4019_glb_tdm_ctrl_sync_num(TDM_SYNC_NUM, substream->stream);
+		ipq4019_glb_tdm_ctrl_delay(TDM_DELAY, substream->stream);
+	}
+
+	return 0;
+}
+
+static int ipq4019_audio_hw_params(struct snd_pcm_substream *substream,
+					struct snd_pcm_hw_params *params,
+					struct snd_soc_dai *dai)
+{
+	u32 bit_width, channels, rate;
+	u32 intf = dai->driver->id;
+	u32 stereo_id = ipq4019_get_stereo_id(substream, intf);
+	u32 mbox_id = ipq4019_get_mbox_id(substream, intf);
+	u32 bit_act;
+	int ret;
+	u32 mclk, bclk;
+	struct device *dev = &(dai_priv[intf].pdev->dev);
+
+	bit_width = params_format(params);
+	channels = params_channels(params);
+	rate = params_rate(params);
+
+	bit_act = ipq4019_get_act_bit_width(bit_width);
+
+	if (intf == TDM) {
+		/* Set TDM number of channels */
+		ipq4019_glb_tdm_ctrl_ch_num((channels-1), substream->stream);
+		mclk = bclk = rate * bit_act * channels;
+	} else {
+		bclk = rate * bit_act * channels;
+		mclk = bclk * MCLK_MULTI;
+	}
+
+	ipq4019_glb_clk_enable_oe(substream->stream);
+
+	ipq4019_config_master(ENABLE, stereo_id);
+
+	ret = ipq4019_cfg_bit_width(bit_width, stereo_id);
+	if (ret) {
+		pr_err("BitWidth %d not supported ret: %d\n", bit_width, ret);
+		return ret;
+	}
+
+	ipq4019_stereo_config_enable(DISABLE, stereo_id);
+
+	ipq4019_stereo_config_reset(ENABLE, stereo_id);
+	ipq4019_stereo_config_mic_reset(ENABLE, stereo_id);
+
+	mdelay(5);
+
+	ret = ipq4019_mbox_fifo_reset(mbox_id);
+	if (ret) {
+		pr_err("%s: ret: %d Error in dma fifo reset\n",
+					__func__, ret);
+		return ret;
+	}
+
+	ipq4019_stereo_config_reset(DISABLE, stereo_id);
+	ipq4019_stereo_config_mic_reset(DISABLE, stereo_id);
+	ipq4019_stereo_config_enable(ENABLE, stereo_id);
+
+	switch (substream->stream) {
+	case SNDRV_PCM_STREAM_PLAYBACK:
+		ret = ipq4019_audio_clk_set(audio_tx_mclk, dev, mclk);
+		if (ret)
+			return ret;
+
+		ret = ipq4019_audio_clk_set(audio_tx_bclk, dev, bclk);
+		if (ret)
+			return ret;
+		break;
+
+	case SNDRV_PCM_STREAM_CAPTURE:
+		ret = ipq4019_audio_clk_set(audio_rx_mclk, dev, mclk);
+		if (ret)
+			return ret;
+
+		ret = ipq4019_audio_clk_set(audio_rx_bclk, dev, bclk);
+		if (ret)
+			return ret;
+		break;
+	}
+
+	return 0;
+}
+
+static void ipq4019_audio_shutdown(struct snd_pcm_substream *substream,
+					struct snd_soc_dai *dai)
+{
+	u32 intf = dai->driver->id;
+	struct device *dev = &(dai_priv[intf].pdev->dev);
+
+	switch (substream->stream) {
+	case SNDRV_PCM_STREAM_PLAYBACK:
+		ipq4019_glb_tx_data_port_en(DISABLE);
+		ipq4019_glb_tx_framesync_port_en(DISABLE);
+
+		/* Disable the clocks */
+		ipq4019_audio_clk_disable(&audio_tx_bclk, dev);
+		ipq4019_audio_clk_disable(&audio_tx_mclk, dev);
+		break;
+	case SNDRV_PCM_STREAM_CAPTURE:
+		ipq4019_glb_rx_data_port_en(DISABLE);
+		ipq4019_glb_rx_framesync_port_en(DISABLE);
+
+		/* Disable the clocks */
+		ipq4019_audio_clk_disable(&audio_rx_bclk, dev);
+		ipq4019_audio_clk_disable(&audio_rx_mclk, dev);
+		break;
+	}
+
+	/* Disable the I2S Stereo block */
+	ipq4019_stereo_config_enable(DISABLE,
+			ipq4019_get_stereo_id(substream, intf));
+}
+
+static struct snd_soc_dai_ops ipq4019_audio_ops = {
+	.startup	= ipq4019_audio_startup,
+	.hw_params	= ipq4019_audio_hw_params,
+	.shutdown	= ipq4019_audio_shutdown,
+};
+
+static int ipq4019_spdif_hw_params(struct snd_pcm_substream *substream,
+					struct snd_pcm_hw_params *params,
+					struct snd_soc_dai *dai)
+{
+	uint32_t bit_width, channels, rate, bit_act;
+	int ret;
+	uint32_t stereo_id = ipq4019_get_stereo_id(substream, SPDIF);
+	uint32_t mclk, bclk;
+	struct device *dev = &(dai_priv[SPDIF].pdev->dev);
+	uint32_t spdif_bclk;
+	uint32_t spdif_mclk;
+
+	bit_width = params_format(params);
+	channels = params_channels(params);
+	rate = params_rate(params);
+	bit_act = ipq4019_get_act_bit_width(bit_width);
+
+	bclk = rate * bit_act * channels;
+	mclk = bclk * MCLK_MULTI;
+
+	/* SPDIF subframe is always 32 bit and 2 channels */
+	spdif_bclk = rate * 32 * 2;
+	spdif_mclk = spdif_bclk * 2;
+
+	if (substream->stream == PLAYBACK) {
+		/* Set the clocks */
+		ret = ipq4019_audio_clk_set(audio_tx_mclk, dev, mclk);
+		if (ret)
+			return ret;
+
+		ret = ipq4019_audio_clk_set(audio_tx_bclk, dev, bclk);
+		if (ret)
+			return ret;
+
+		ret = ipq4019_audio_clk_set(audio_spdif_src, dev,
+						spdif_mclk);
+		if (ret)
+			return ret;
+
+		ret = ipq4019_audio_clk_set(audio_spdif_div2, dev,
+						spdif_bclk);
+		if (ret)
+			return ret;
+
+		ipq4019_glb_clk_enable_oe(substream->stream);
+
+		/* Set MASTER mode */
+		ipq4019_config_master(ENABLE, stereo_id);
+
+		/* Configure bit width */
+		ret = ipq4019_cfg_bit_width(bit_width, stereo_id);
+		if (ret) {
+			pr_err("%s: BitWidth %d not supported\n",
+				__func__, bit_width);
+			return ret;
+		}
+
+	} else if (substream->stream == CAPTURE) {
+		/* Set the clocks */
+		ret = ipq4019_audio_clk_set(audio_spdifinfast_src, dev,
+						AUDIO_SPDIFINFAST);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int ipq4019_spdif_prepare(struct snd_pcm_substream *substream,
+					struct snd_soc_dai *dai)
+{
+	dev_dbg(dai->dev, "%s:%d\n", __func__, __LINE__);
+	return 0;
+}
+
+static int ipq4019_spdif_startup(struct snd_pcm_substream *substream,
+					struct snd_soc_dai *dai)
+{
+	int ret = 0;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		/* Check if the direction is enabled */
+		if (dai_priv[SPDIF].tx_enabled != ENABLE)
+			goto error;
+
+		ipq4019_glb_tx_data_port_en(ENABLE);
+		ipq4019_glb_tx_framesync_port_en(ENABLE);
+		ipq4019_glb_spdif_out_en(ENABLE);
+		/* Select I2S/TDM */
+		ipq4019_glb_audio_mode(I2S, substream->stream);
+	} else if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
+		/* Check if the direction is enabled */
+		if (dai_priv[SPDIF].rx_enabled != ENABLE)
+			goto error;
+		ipq4019_spdifin_ctrl_spdif_en(DISABLE);
+
+		ipq4019_glb_rx_data_port_en(ENABLE);
+		ipq4019_glb_rx_framesync_port_en(ENABLE);
+		ipq4019_glb_audio_mode(I2S, substream->stream);
+		ipq4019_spdifin_cfg();
+	}
+
+	return ret;
+error:
+	pr_err("%s: Direction not enabled\n", __func__);
+	return -EFAULT;
+}
+
+static void ipq4019_spdif_shutdown(struct snd_pcm_substream *substream,
+					struct snd_soc_dai *dai)
+{
+	struct device *dev = &(dai_priv[SPDIF].pdev->dev);
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		ipq4019_glb_tx_data_port_en(DISABLE);
+		ipq4019_glb_tx_framesync_port_en(DISABLE);
+
+		/* Disable the clocks */
+		ipq4019_audio_clk_disable(&audio_tx_bclk, dev);
+		ipq4019_audio_clk_disable(&audio_tx_mclk, dev);
+		ipq4019_audio_clk_disable(&audio_spdif_src, dev);
+		ipq4019_audio_clk_disable(&audio_spdif_div2, dev);
+
+	} else if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
+		ipq4019_glb_rx_data_port_en(DISABLE);
+		ipq4019_glb_rx_framesync_port_en(DISABLE);
+
+		/* Disable the clocks */
+		ipq4019_audio_clk_disable(&audio_spdifinfast_src, dev);
+	}
+}
+
+static int ipq4019_spdif_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
+{
+	dev_dbg(dai->dev, "%s:%d\n", __func__, __LINE__);
+	return 0;
+}
+
+static struct snd_soc_dai_ops ipq4019_spdif_ops = {
+	.startup	= ipq4019_spdif_startup,
+	.prepare	= ipq4019_spdif_prepare,
+	.hw_params	= ipq4019_spdif_hw_params,
+	.shutdown	= ipq4019_spdif_shutdown,
+	.set_fmt	= ipq4019_spdif_set_fmt,
+};
+
+static struct snd_soc_dai_driver ipq4019_cpu_dais[] = {
+	{
+		.playback = {
+			.rates		= RATE_16000_96000,
+			.formats	= SNDRV_PCM_FMTBIT_S16 |
+					SNDRV_PCM_FMTBIT_S32,
+			.channels_min	= CH_STEREO,
+			.channels_max	= CH_STEREO,
+			.rate_min	= FREQ_16000,
+			.rate_max	= FREQ_96000,
+		},
+		.capture = {
+			.rates		= RATE_16000_96000,
+			.formats	= SNDRV_PCM_FMTBIT_S16 |
+					SNDRV_PCM_FMTBIT_S32,
+			.channels_min	= CH_STEREO,
+			.channels_max	= CH_STEREO,
+			.rate_min	= FREQ_16000,
+			.rate_max	= FREQ_96000,
+		},
+		.ops = &ipq4019_audio_ops,
+		.id = I2S,
+		.name = "qca-i2s-dai"
+	},
+	{
+		.playback = {
+			.rates		= RATE_16000_96000,
+			.formats	= SNDRV_PCM_FMTBIT_S16 |
+					SNDRV_PCM_FMTBIT_S32,
+			.channels_min	= CH_STEREO,
+			.channels_max	= CH_7_1,
+			.rate_min	= FREQ_16000,
+			.rate_max	= FREQ_96000,
+		},
+		.capture = {
+			.rates		= RATE_16000_96000,
+			.formats	= SNDRV_PCM_FMTBIT_S16 |
+					SNDRV_PCM_FMTBIT_S32,
+			.channels_min	= CH_STEREO,
+			.channels_max	= CH_7_1,
+			.rate_min	= FREQ_16000,
+			.rate_max	= FREQ_96000,
+		},
+		.ops = &ipq4019_audio_ops,
+		.id = TDM,
+		.name = "qca-tdm-dai"
+	},
+	{
+		.playback = {
+			.rates		= RATE_16000_96000,
+			.formats	= SNDRV_PCM_FMTBIT_S16 |
+					SNDRV_PCM_FMTBIT_S32,
+			.channels_min	= 2,
+			.channels_max	= 2,
+			.rate_min	= FREQ_16000,
+			.rate_max	= FREQ_96000,
+		},
+		.ops = &ipq4019_audio_ops,
+		.id = I2S1,
+		.name = "qca-i2s1-dai"
+	},
+	{
+		.playback = {
+			.rates		= RATE_16000_96000,
+			.formats	= SNDRV_PCM_FMTBIT_S16 |
+					SNDRV_PCM_FMTBIT_S32,
+			.channels_min	= 2,
+			.channels_max	= 2,
+			.rate_min	= FREQ_16000,
+			.rate_max	= FREQ_96000,
+		},
+		.ops = &ipq4019_audio_ops,
+		.id = I2S2,
+		.name = "qca-i2s2-dai"
+	},
+	{
+		.playback = {
+			.rates		= RATE_16000_96000,
+			.formats        = SNDRV_PCM_FMTBIT_S16 |
+					SNDRV_PCM_FMTBIT_S24_3,
+			.channels_min   = CH_STEREO,
+			.channels_max   = CH_STEREO,
+			.rate_min       = FREQ_16000,
+			.rate_max       = FREQ_96000,
+		},
+		.capture = {
+			.rates		= RATE_16000_96000,
+			.formats        = SNDRV_PCM_FMTBIT_S16 |
+					SNDRV_PCM_FMTBIT_S24_3,
+			.channels_min   = CH_STEREO,
+			.channels_max   = CH_STEREO,
+			.rate_min       = FREQ_16000,
+			.rate_max       = FREQ_96000,
+		},
+		.ops = &ipq4019_spdif_ops,
+		.id = SPDIF,
+		.name = "qca-spdif-dai"
+	},
+};
+
+static const struct snd_soc_component_driver ipq4019_i2s_component = {
+	.name           = "qca-cpu-dai",
+};
+
+static const struct of_device_id ipq4019_cpu_dai_id_table[] = {
+	{ .compatible = "qca,ipq4019-i2s", .data = (void *)I2S },
+	{ .compatible = "qca,ipq4019-tdm", .data = (void *)TDM},
+	{ .compatible = "qca,ipq4019-spdif", .data = (void *)SPDIF},
+	{ .compatible = "qca,ipq4019-i2s1", .data = (void *)I2S1},
+	{ .compatible = "qca,ipq4019-i2s2", .data = (void *)I2S2},
+	{},
+};
+MODULE_DEVICE_TABLE(of, ipq4019_cpu_dai_id_table);
+
+static int ipq4019_dai_probe(struct platform_device *pdev)
+{
+	const struct of_device_id *match;
+	struct device_node *np = pdev->dev.of_node;
+	int ret;
+	int intf;
+
+	match = of_match_device(ipq4019_cpu_dai_id_table, &pdev->dev);
+	if (!match)
+		return -ENODEV;
+
+	intf = (u32)match->data;
+
+	/* TX is enabled only when both DMA and Stereo TX channel
+	 * is specified in the DTSi
+	 */
+	if (!(of_property_read_u32(np, "dma-tx-channel",
+					&dai_priv[intf].mbox_tx)
+		|| of_property_read_u32(np, "stereo-tx-port",
+					&dai_priv[intf].stereo_tx))) {
+		dai_priv[intf].tx_enabled = ENABLE;
+	}
+
+	/* RX is enabled only when both DMA and Stereo RX channel
+	 * is specified in the DTSi.
+	 */
+	if (!(of_property_read_u32(np, "dma-rx-channel",
+					&dai_priv[intf].mbox_rx))) {
+		if (intf == SPDIF) {
+			dai_priv[intf].rx_enabled = ENABLE;
+			dai_priv[intf].stereo_rx = MAX_STEREO_ENTRIES;
+		} else if (!(of_property_read_u32(np, "stereo-rx-port",
+					&dai_priv[intf].stereo_rx))) {
+			dai_priv[intf].rx_enabled = ENABLE;
+		}
+	}
+
+	/* Either TX or Rx should have been enabled for a DMA/Stereo Channel */
+	if (!(dai_priv[intf].tx_enabled || dai_priv[intf].rx_enabled)) {
+		dev_err(&pdev->dev, "%s: error reading node properties\n",
+								np->name);
+		return -EFAULT;
+	}
+
+	/* Get Clks */
+	audio_tx_mclk = devm_clk_get(&pdev->dev, "audio_tx_mclk");
+
+	if (IS_ERR(audio_tx_mclk)) {
+		dev_err(&pdev->dev, "Could not get tx_mclk\n");
+		return PTR_ERR(audio_tx_mclk);
+	}
+
+	audio_tx_bclk = devm_clk_get(&pdev->dev, "audio_tx_bclk");
+
+	if (IS_ERR(audio_tx_bclk)) {
+		dev_err(&pdev->dev, "Could not get tx_bclk\n");
+		return PTR_ERR(audio_tx_bclk);
+	}
+
+	if (intf == SPDIF) {
+		ret = ipq4019_audio_clk_get(&audio_spdif_src, &pdev->dev,
+						"audio_spdif_src");
+		if (ret)
+			return ret;
+
+		ret = ipq4019_audio_clk_get(&audio_spdif_div2, &pdev->dev,
+						"audio_spdif_div2");
+		if (ret)
+			return ret;
+
+		ret = ipq4019_audio_clk_get(&audio_spdifinfast_src, &pdev->dev,
+						"audio_spdifinfast_src");
+		if (ret)
+			return ret;
+	} else {
+		audio_rx_mclk = devm_clk_get(&pdev->dev, "audio_rx_mclk");
+		if (IS_ERR(audio_rx_mclk)) {
+			dev_err(&pdev->dev, "Could not get rx_mclk\n");
+			return PTR_ERR(audio_rx_mclk);
+		}
+
+		audio_rx_bclk = devm_clk_get(&pdev->dev, "audio_rx_bclk");
+		if (IS_ERR(audio_rx_bclk)) {
+			dev_err(&pdev->dev, "Could not get rx_bclk\n");
+			return PTR_ERR(audio_rx_bclk);
+		}
+	}
+
+	dai_priv[intf].pdev = pdev;
+	ret = snd_soc_register_component(&pdev->dev, &ipq4019_i2s_component,
+			 ipq4019_cpu_dais, ARRAY_SIZE(ipq4019_cpu_dais));
+	if (ret)
+		dev_err(&pdev->dev,
+			"ret: %d error registering soc dais\n", ret);
+
+	return ret;
+}
+
+static int ipq4019_dai_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_component(&pdev->dev);
+	return 0;
+}
+
+static struct platform_driver ipq4019_dai_driver = {
+	.probe = ipq4019_dai_probe,
+	.remove = ipq4019_dai_remove,
+	.driver = {
+		.name = "qca-cpu-dai",
+		.of_match_table = ipq4019_cpu_dai_id_table,
+	},
+};
+
+module_platform_driver(ipq4019_dai_driver);
+
+MODULE_ALIAS("platform:qca-cpu-dai");
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_DESCRIPTION("IPQ4019 CPU DAI DRIVER");
diff --git a/sound/soc/qcom/ipq4019/ipq4019-mbox.c b/sound/soc/qcom/ipq4019/ipq4019-mbox.c
new file mode 100644
index 0000000..2a3bee9
--- /dev/null
+++ b/sound/soc/qcom/ipq4019/ipq4019-mbox.c
@@ -0,0 +1,825 @@
+/*
+ * Copyright (c) 2015-2016 The Linux Foundation. All rights reserved.
+ *
+ * Permission to use, copy, modify, and/or distribute this software for any
+ * purpose with or without fee is hereby granted, provided that the above
+ * copyright notice and this permission notice appear in all copies.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
+ * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
+ * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
+ * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+ * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+ * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+ */
+
+#include <linux/dma-mapping.h>
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/mm.h>
+#include <linux/delay.h>
+#include <sound/soc.h>
+
+#include "ipq4019-mbox.h"
+
+/* When the mailbox operation is started, the mailbox would get one descriptor
+ * for the current data transfer and prefetch one more descriptor. When less
+ * than 3 descriptors are configured, then it is possible that before the CPU
+ * handles the interrupt, the mailbox could check the pre fetched descriptor
+ * and stop the DMA transfer.
+ * To handle this, the design is use multiple descriptors, but they would
+ * point to the same buffer address. This way  more number of descriptors
+ * would satisfy the mbox requirement, and reusing the buffer address would
+ * satisfy the upper layer's buffer requirement
+ *
+ * The value of 5 of repetition times was derived from trial and error testing
+ * for minimum number of repetitions that would result in MBOX operations
+ * without stopping.
+ */
+#define MBOX_MIN_DESC_NUM       3
+#define MBOX_DESC_REPEAT_NUM    5
+
+enum {
+	CHN_DISABLED = 0x00,
+	CHN_ENABLED = 0x01, /* from dtsi */
+	CHN_STARTED = 0x02, /* dma inited */
+	CHN_STATUS_DISABLE = 0xFF,
+};
+
+static struct ipq4019_mbox_rt_priv *mbox_rtime[ADSS_MBOX_NR_CHANNELS];
+
+struct ipq4019_mbox_desc
+	*ipq4019_mbox_get_last_played(unsigned int channel_id)
+{
+	struct ipq4019_mbox_desc *desc, *prev;
+	unsigned int ndescs, i;
+	uint32_t index;
+	uint32_t dir;
+
+	index = ipq4019_convert_id_to_channel(channel_id);
+	dir = ipq4019_convert_id_to_dir(channel_id);
+
+	if (!mbox_rtime[index])
+		return NULL;
+
+	ndescs = mbox_rtime[index]->dir_priv[dir].ndescs;
+	/* Point to the last desc */
+	prev = &mbox_rtime[index]->dir_priv[dir].dma_virt_head[ndescs - 1];
+
+	/* Point to the first desc */
+	desc = &mbox_rtime[index]->dir_priv[dir].dma_virt_head[0];
+
+	for (i = 0; i < ndescs; i++) {
+		if (desc->OWN == 1 && prev->OWN == 0)
+			return desc;
+		prev = desc;
+		desc += 1;
+	}
+
+	/* If we didn't find the last played buffer, return NULL */
+	return NULL;
+}
+EXPORT_SYMBOL(ipq4019_mbox_get_last_played);
+
+uint32_t ipq4019_mbox_get_elapsed_size(uint32_t channel_id)
+{
+	struct ipq4019_mbox_desc *desc;
+	unsigned int i, size_played = 0;
+	uint32_t index;
+	uint32_t dir;
+
+	index = ipq4019_convert_id_to_channel(channel_id);
+	dir = ipq4019_convert_id_to_dir(channel_id);
+
+	if (!mbox_rtime[index])
+		return size_played;
+
+	desc = mbox_rtime[index]->dir_priv[dir].dma_virt_head;
+
+	for (i = 0; i < mbox_rtime[index]->dir_priv[dir].ndescs; i++) {
+		if (desc->OWN == 0) {
+			desc->OWN = 1;
+			desc->ei = 1;
+			size_played += desc->size;
+		}
+		desc += 1;
+	}
+
+	return size_played;
+}
+EXPORT_SYMBOL(ipq4019_mbox_get_elapsed_size);
+
+static struct ipq4019_mbox_desc *get_next(
+					struct ipq4019_mbox_rt_dir_priv *rtdir,
+					struct ipq4019_mbox_desc *desc)
+{
+	struct ipq4019_mbox_desc *end;
+
+	end = rtdir->dma_virt_head + rtdir->ndescs;
+
+	desc++;
+
+	if (desc >= end)
+		desc = rtdir->dma_virt_head;
+
+	return desc;
+}
+
+void ipq4019_mbox_desc_own(u32 channel_id, int desc_no, int own)
+{
+	struct ipq4019_mbox_desc *desc;
+	struct ipq4019_mbox_rt_dir_priv *rtdir;
+	u32 chan;
+	u32 dir;
+
+	chan = ipq4019_convert_id_to_channel(channel_id);
+	dir = ipq4019_convert_id_to_dir(channel_id);
+
+	rtdir = &mbox_rtime[chan]->dir_priv[dir];
+
+	desc = rtdir->dma_virt_head;
+	desc += desc_no;
+
+	rtdir->write = desc_no;
+
+	desc->OWN = own;
+	desc->ei = 1;
+}
+EXPORT_SYMBOL(ipq4019_mbox_desc_own);
+
+u32 ipq4019_mbox_get_played_offset(u32 channel_id)
+{
+	struct ipq4019_mbox_desc *desc, *write;
+	struct ipq4019_mbox_rt_dir_priv *rtdir;
+	unsigned int i, size_played = 0;
+	u32 chan;
+	u32 dir;
+
+	chan = ipq4019_convert_id_to_channel(channel_id);
+	dir = ipq4019_convert_id_to_dir(channel_id);
+
+	rtdir = &mbox_rtime[chan]->dir_priv[dir];
+
+	desc = rtdir->dma_virt_head;
+	write = &rtdir->dma_virt_head[rtdir->write];
+
+	desc += rtdir->read;
+
+	for (i = 0; i < rtdir->ndescs; i++) {
+		if (desc->OWN == 0) {
+			size_played = desc->size;
+			rtdir->read = (rtdir->read + 1) % rtdir->ndescs;
+		} else {
+			break;
+		}
+
+		if (desc != write)
+			break;
+
+		desc = get_next(rtdir, desc);
+	}
+
+	return size_played * rtdir->read;
+}
+EXPORT_SYMBOL(ipq4019_mbox_get_played_offset);
+
+uint32_t ipq4019_mbox_get_played_offset_set_own(u32 channel_id)
+{
+	struct ipq4019_mbox_desc *desc, *last_played, *prev;
+	struct ipq4019_mbox_rt_dir_priv *rtdir;
+	unsigned int i, desc_own, size_played = 0;
+	u32 chan, dir;
+
+	chan = ipq4019_convert_id_to_channel(channel_id);
+	dir = ipq4019_convert_id_to_dir(channel_id);
+
+	rtdir = &mbox_rtime[chan]->dir_priv[dir];
+	last_played = NULL;
+
+	/* Point to the last desc */
+	prev = &rtdir->dma_virt_head[rtdir->ndescs - 1];
+	desc_own = prev->OWN;
+
+	/* point to first desc */
+	desc = &rtdir->dma_virt_head[0];
+
+	for (i = 0; i < rtdir->ndescs; i++) {
+		if (prev->OWN == 0) {
+			if (i == (rtdir->ndescs - 1)) {
+				if (desc_own == 1)
+					last_played = desc;
+			} else if (desc->OWN == 1) {
+				last_played = desc;
+			}
+			prev->OWN = 1;
+			prev->ei = 1;
+		}
+		prev = desc;
+		desc += 1;
+	}
+	if (last_played) {
+		desc = &rtdir->dma_virt_head[0];
+		size_played = last_played->BufPtr - desc->BufPtr;
+	} else {
+		pr_debug("%s last played buf not found\n", __func__);
+		rtdir->last_played_is_null++;
+	}
+
+	return size_played;
+}
+EXPORT_SYMBOL(ipq4019_mbox_get_played_offset_set_own);
+
+int ipq4019_mbox_fifo_reset(int channel_id)
+{
+	void __iomem *mbox_reg;
+	u32 chan, dir;
+
+	chan = ipq4019_convert_id_to_channel(channel_id);
+	dir = ipq4019_convert_id_to_dir(channel_id);
+
+	if (!mbox_rtime[chan])
+		return -EINVAL;
+
+	mbox_reg = mbox_rtime[chan]->mbox_reg_base;
+
+	switch (dir) {
+	case PLAYBACK:
+		writel(MBOX_FIFO_RESET_TX_INIT,
+			 mbox_reg + ADSS_MBOXn_MBOX_FIFO_RESET_REG);
+		break;
+	case CAPTURE:
+		writel(MBOX_FIFO_RESET_RX_INIT,
+			 mbox_reg + ADSS_MBOXn_MBOX_FIFO_RESET_REG);
+		break;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(ipq4019_mbox_fifo_reset);
+
+int ipq4019_mbox_dma_start(int channel_id)
+{
+	void __iomem *mbox_reg;
+	u32 chan, dir;
+
+	chan = ipq4019_convert_id_to_channel(channel_id);
+	dir = ipq4019_convert_id_to_dir(channel_id);
+
+	if (!mbox_rtime[chan])
+		return -EINVAL;
+
+	mbox_reg = mbox_rtime[chan]->mbox_reg_base;
+	mbox_rtime[index]->mbox_started = 1;
+
+	switch (dir) {
+	case PLAYBACK:
+		writel(ADSS_MBOXn_DMA_RX_CONTROL_START,
+			mbox_reg + ADSS_MBOXn_MBOXn_DMA_RX_CONTROL_REG);
+		break;
+
+	case CAPTURE:
+		writel(ADSS_MBOXn_DMA_TX_CONTROL_START,
+			mbox_reg + ADSS_MBOXn_MBOXn_DMA_TX_CONTROL_REG);
+		break;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(ipq4019_mbox_dma_start);
+
+int ipq4019_mbox_dma_resume(int channel_id)
+{
+	void __iomem *mbox_reg;
+	u32 chan, dir;
+
+	chan = ipq4019_convert_id_to_channel(channel_id);
+	dir = ipq4019_convert_id_to_dir(channel_id);
+
+	if (!mbox_rtime[chan])
+		return -EINVAL;
+
+	if (!mbox_rtime[index]->mbox_started)
+		return 0;
+
+	mbox_reg = mbox_rtime[chan]->mbox_reg_base;
+
+	switch (dir) {
+	case PLAYBACK:
+		writel(ADSS_MBOXn_DMA_RX_CONTROL_RESUME,
+			mbox_reg + ADSS_MBOXn_MBOXn_DMA_RX_CONTROL_REG);
+		break;
+
+	case CAPTURE:
+		writel(ADSS_MBOXn_DMA_TX_CONTROL_RESUME,
+			mbox_reg + ADSS_MBOXn_MBOXn_DMA_TX_CONTROL_REG);
+		break;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(ipq4019_mbox_dma_resume);
+
+int ipq4019_mbox_dma_stop(int channel_id, u32 delay_in_ms)
+{
+	void __iomem *mbox_reg;
+	struct ipq4019_mbox_rt_dir_priv *mbox_cb;
+	u32 chan, dir;
+
+	chan = ipq4019_convert_id_to_channel(channel_id);
+	dir = ipq4019_convert_id_to_dir(channel_id);
+
+	if (!mbox_rtime[chan])
+		return -EINVAL;
+
+	mbox_reg = mbox_rtime[chan]->mbox_reg_base;
+	mbox_rtime[index]->mbox_started = 0;
+
+	switch (dir) {
+	case PLAYBACK:
+		writel(ADSS_MBOXn_DMA_RX_CONTROL_STOP,
+			mbox_reg + ADSS_MBOXn_MBOXn_DMA_RX_CONTROL_REG);
+		break;
+
+	case CAPTURE:
+		writel(ADSS_MBOXn_DMA_TX_CONTROL_STOP,
+			mbox_reg + ADSS_MBOXn_MBOXn_DMA_TX_CONTROL_REG);
+		break;
+	}
+
+	/*
+	 * Per the documentation:
+	 *	______________________________________________________
+	 *	Programming a one to this bit causes the DMA engine to
+	 *	stop transferring any more data from this descriptor
+	 *	chain.  If a transfer is already in progress DMA enters
+	 *	a stop state after completing the current descriptor
+	 *	______________________________________________________
+	 */
+	mdelay(delay_in_ms);
+
+	mbox_cb = &mbox_rtime[chan]->dir_priv[dir];
+	mbox_cb->read = 0;
+	mbox_cb->write = 0;
+
+	return 0;
+}
+EXPORT_SYMBOL(ipq4019_mbox_dma_stop);
+
+static bool ipq4019_is_other_chn_active(u32 chan, u32 dir)
+{
+	if (dir == PLAYBACK)
+		return (test_bit(CHN_STARTED,
+			&mbox_rtime[chan]->dir_priv[CAPTURE].status));
+	else
+		return (test_bit(CHN_STARTED,
+			&mbox_rtime[chan]->dir_priv[PLAYBACK].status));
+}
+
+int ipq4019_mbox_dma_reset_swap(int channel_id)
+{
+	unsigned int val;
+	void __iomem *mbox_reg;
+	u32 chan;
+
+	chan = ipq4019_convert_id_to_channel(channel_id);
+
+	if (!mbox_rtime[chan])
+		return -EINVAL;
+
+	mbox_reg = mbox_rtime[chan]->mbox_reg_base;
+
+	val = readl(mbox_reg + ADSS_MBOXn_MBOX_DMA_POLICY_REG);
+	val &= ~(MBOX_DMA_POLICY_RXD_END_SWAP | MBOX_DMA_POLICY_RXD_16BIT_SWAP);
+
+	writel(val, mbox_reg + ADSS_MBOXn_MBOX_DMA_POLICY_REG);
+
+	return 0;
+}
+EXPORT_SYMBOL(ipq4019_mbox_dma_reset_swap);
+
+int ipq4019_mbox_dma_swap(int channel_id, snd_pcm_format_t format)
+{
+	unsigned int val;
+	void __iomem *mbox_reg;
+	u32 chan;
+
+	chan = ipq4019_convert_id_to_channel(channel_id);
+
+	if (!mbox_rtime[chan])
+		return -EINVAL;
+
+	mbox_reg = mbox_rtime[chan]->mbox_reg_base;
+
+	val = readl(mbox_reg + ADSS_MBOXn_MBOX_DMA_POLICY_REG);
+	switch (format) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+	case SNDRV_PCM_FORMAT_S16_BE:
+		val |= MBOX_DMA_POLICY_RXD_16BIT_SWAP;
+		break;
+	case SNDRV_PCM_FORMAT_S24_3LE:
+	case SNDRV_PCM_FORMAT_S24_3BE:
+		val |= MBOX_DMA_POLICY_RXD_END_SWAP;
+		break;
+	default:
+		/* Nothing to do */
+		break;
+	}
+	writel(val, mbox_reg + ADSS_MBOXn_MBOX_DMA_POLICY_REG);
+
+	return 0;
+}
+EXPORT_SYMBOL(ipq4019_mbox_dma_swap);
+
+static void ipq4019_mbox_intr_en(void __iomem *mbox_reg, unsigned int mask)
+{
+	unsigned int val;
+
+	val = readl(mbox_reg + ADSS_MBOXn_MBOX_INT_ENABLE_REG);
+	val |= mask;
+	writel(val, mbox_reg + ADSS_MBOXn_MBOX_INT_ENABLE_REG);
+}
+
+static void ipq4019_mbox_intr_disable(void __iomem *mbox_reg, unsigned int mask)
+{
+	unsigned int val;
+
+	val = readl(mbox_reg + ADSS_MBOXn_MBOX_INT_ENABLE_REG);
+	val &= ~mask;
+	writel(val, mbox_reg + ADSS_MBOXn_MBOX_INT_ENABLE_REG);
+}
+
+int ipq4019_mbox_dma_prepare(int channel_id)
+{
+	struct ipq4019_mbox_desc *desc;
+	unsigned int val;
+	void __iomem *mbox_reg;
+	dma_addr_t phys_addr;
+	u32 chan, dir;
+	struct ipq4019_mbox_rt_dir_priv *mbox_cb;
+
+	chan = ipq4019_convert_id_to_channel(channel_id);
+	dir = ipq4019_convert_id_to_dir(channel_id);
+
+	if (!mbox_rtime[chan])
+		return -EINVAL;
+
+	mbox_reg = mbox_rtime[chan]->mbox_reg_base;
+	mbox_cb = &mbox_rtime[chan]->dir_priv[dir];
+
+	/* do not reset DMA registers if the other direction is active */
+	if (!ipq4019_is_other_chn_active(chan, dir)) {
+
+		val = readl(mbox_reg + ADSS_MBOXn_MBOX_DMA_POLICY_REG);
+		val |= MBOX_DMA_POLICY_SW_RESET;
+		writel(val, mbox_reg + ADSS_MBOXn_MBOX_DMA_POLICY_REG);
+		val &= ~MBOX_DMA_POLICY_SW_RESET;
+		writel(val, mbox_reg + ADSS_MBOXn_MBOX_DMA_POLICY_REG);
+	}
+
+	desc = mbox_cb->dma_virt_head;
+	phys_addr = mbox_cb->dma_phys_head;
+	val = readl(mbox_reg + ADSS_MBOXn_MBOX_DMA_POLICY_REG);
+
+	if (dir == PLAYBACK) {
+		/* Request the DMA channel to the controller */
+		val |= MBOX_DMA_POLICY_RX_INT_TYPE;
+
+		/* The direction is indicated from the DMA engine perspective
+		 * i.e. we'll be using the RX registers for Playback and
+		 * the TX registers for capture
+		 */
+
+		val |= ADSS_MBOX_DMA_POLICY_SRAM_AC(phys_addr);
+		writel(val, mbox_reg + ADSS_MBOXn_MBOX_DMA_POLICY_REG);
+		writel(phys_addr & MBOX_DMA_MASK,
+			mbox_reg + ADSS_MBOXn_MBOXn_DMA_RX_DESCRIPTOR_BASE_REG);
+		ipq4019_mbox_intr_en(mbox_reg, MBOX_INT_ENABLE_RX_DMA_COMPLETE);
+	} else {
+
+		val |= MBOX_DMA_POLICY_TX_INT_TYPE |
+			ADSS_MBOX_DMA_POLICY_TX_FIFO_THRESHOLD(6);
+		val |= ADSS_MBOX_DMA_POLICY_SRAM_AC(phys_addr);
+		writel(val, mbox_reg + ADSS_MBOXn_MBOX_DMA_POLICY_REG);
+		writel(phys_addr & MBOX_DMA_MASK,
+			mbox_reg + ADSS_MBOXn_MBOXn_DMA_TX_DESCRIPTOR_BASE_REG);
+		ipq4019_mbox_intr_en(mbox_reg, MBOX_INT_ENABLE_TX_DMA_COMPLETE);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(ipq4019_mbox_dma_prepare);
+
+void ipq4019_mbox_vuc_setup(int channel_id)
+{
+	uint32_t index, dir;
+	struct ipq4019_mbox_desc *desc;
+	int ndescs;
+	int i;
+
+	index = ipq4019_convert_id_to_channel(channel_id);
+	dir = ipq4019_convert_id_to_dir(channel_id);
+	ndescs = mbox_rtime[index]->dir_priv[dir].ndescs;
+	desc = mbox_rtime[index]->dir_priv[dir].dma_virt_head;
+
+	/* Copy VUC from previous descriptors */
+	for (i = 0; i < ndescs; i++) {
+		/* Setup V bits as 1, Acc to IEC 60958-3 Standard
+		 *    for non PCM data, we need to set invalid for
+		 *     both channels
+		 * There are 6 DWORDS (192 bits) for Channel A
+		 * and 6 DWORDS (192 bits) for channel B
+		 */
+		desc[i].vuc_dword[CHANNEL_A_VDWORD_1] = ADSS_MBOX_INVALID_PCM;
+		desc[i].vuc_dword[CHANNEL_A_VDWORD_2] = ADSS_MBOX_INVALID_PCM;
+		desc[i].vuc_dword[CHANNEL_A_VDWORD_3] = ADSS_MBOX_INVALID_PCM;
+		desc[i].vuc_dword[CHANNEL_A_VDWORD_4] = ADSS_MBOX_INVALID_PCM;
+		desc[i].vuc_dword[CHANNEL_A_VDWORD_5] = ADSS_MBOX_INVALID_PCM;
+		desc[i].vuc_dword[CHANNEL_A_VDWORD_6] = ADSS_MBOX_INVALID_PCM;
+		desc[i].vuc_dword[CHANNEL_B_VDWORD_1] = ADSS_MBOX_INVALID_PCM;
+		desc[i].vuc_dword[CHANNEL_B_VDWORD_2] = ADSS_MBOX_INVALID_PCM;
+		desc[i].vuc_dword[CHANNEL_B_VDWORD_3] = ADSS_MBOX_INVALID_PCM;
+		desc[i].vuc_dword[CHANNEL_B_VDWORD_4] = ADSS_MBOX_INVALID_PCM;
+		desc[i].vuc_dword[CHANNEL_B_VDWORD_5] = ADSS_MBOX_INVALID_PCM;
+		desc[i].vuc_dword[CHANNEL_B_VDWORD_6] = ADSS_MBOX_INVALID_PCM;
+
+		/* Now setup C bits, acc to IEC-60958-3 */
+		desc[i].vuc_dword[CHANNEL_A_CDWORD_1] = SPDIF_CONSUMER_COMPRESD;
+		desc[i].vuc_dword[CHANNEL_B_CDWORD_2] = SPDIF_CONSUMER_COMPRESD;
+	}
+}
+EXPORT_SYMBOL(ipq4019_mbox_vuc_setup);
+
+int ipq4019_mbox_form_ring(int channel_id, dma_addr_t baseaddr, u8 *area,
+			   int period_bytes, int bufsize, int own_bit)
+{
+	struct ipq4019_mbox_desc *desc, *_desc_p;
+	dma_addr_t desc_p, baseaddr_const;
+	unsigned int i, ndescs;
+	u32 chan, dir;
+	struct ipq4019_mbox_rt_dir_priv *mbox_cb;
+
+	chan = ipq4019_convert_id_to_channel(channel_id);
+	dir = ipq4019_convert_id_to_dir(channel_id);
+
+	if (!mbox_rtime[chan])
+		return -EINVAL;
+
+	mbox_cb = &mbox_rtime[chan]->dir_priv[dir];
+	ndescs = DIV_ROUND_UP(bufsize, period_bytes);
+
+	if (ndescs < MBOX_MIN_DESC_NUM)
+		ndescs *= MBOX_DESC_REPEAT_NUM;
+
+	desc = (struct ipq4019_mbox_desc *)(area + (ndescs * period_bytes));
+	desc_p = baseaddr + (ndescs * period_bytes);
+
+	memset(desc, 0, ndescs * sizeof(struct ipq4019_mbox_desc));
+
+	mbox_cb->read = 0;
+	mbox_cb->write = 0;
+	mbox_cb->ndescs = ndescs;
+	mbox_cb->dma_virt_head = desc;
+	mbox_cb->dma_phys_head = desc_p;
+	_desc_p = (struct ipq4019_mbox_desc *)desc_p;
+
+	baseaddr_const = baseaddr;
+
+	for (i = 0; i < ndescs; i++, desc++) {
+		desc->OWN = own_bit;
+		desc->ei = 1;
+		desc->BufPtr = baseaddr & MBOX_DMA_MASK;
+		desc->NextPtr = (unsigned long)&_desc_p[(i + 1) % ndescs];
+		desc->size = period_bytes;
+		desc->length = desc->size;
+		baseaddr += ALIGN(period_bytes, L1_CACHE_BYTES);
+		if (baseaddr >= (baseaddr_const + bufsize)) {
+			if (bufsize % period_bytes)
+				desc->size = bufsize % period_bytes;
+			else
+				desc->size = period_bytes;
+
+			baseaddr = baseaddr_const;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(ipq4019_mbox_form_ring);
+
+int ipq4019_mbox_dma_release(int channel_id)
+{
+	u32 chan, dir;
+	struct ipq4019_mbox_rt_dir_priv *mbox_cb;
+
+	chan = ipq4019_convert_id_to_channel(channel_id);
+	dir = ipq4019_convert_id_to_dir(channel_id);
+	mbox_cb = &mbox_rtime[chan]->dir_priv[dir];
+
+	if (test_bit(CHN_STARTED, &mbox_cb->status)) {
+		ipq4019_mbox_intr_disable(mbox_rtime[chan]->mbox_reg_base,
+				(MBOX_INT_ENABLE_TX_DMA_COMPLETE |
+					MBOX_INT_ENABLE_RX_DMA_COMPLETE));
+		/*
+		 * ALSA framework calls ipq4019_mbox_dma_stop() before
+		 * calling close API.
+		 */
+		mbox_cb->dma_virt_head = NULL;
+
+		clear_bit(CHN_STARTED, &mbox_cb->status);
+		return 0;
+	}
+
+	return -ENXIO;
+}
+EXPORT_SYMBOL(ipq4019_mbox_dma_release);
+
+static void irq_proc_status(struct ipq4019_mbox_rt_dir_priv *priv, int irq,
+			    u32 status, int cb, int stats, u32 *mask, u32 bit)
+{
+	if (status & bit) {
+		*mask |= bit;
+		if (cb && priv->callback)
+			priv->callback(irq, priv->dai_priv);
+
+		if (stats)
+			priv->err_stats++;
+	}
+}
+
+static irqreturn_t ipq4019_mbox_dma_irq(int irq, void *dev_id)
+{
+	unsigned int status, mask = 0;
+	struct ipq4019_mbox_rt_priv *curr_rtime = dev_id;
+	void __iomem *mbox_reg = curr_rtime->mbox_reg_base;
+	struct ipq4019_mbox_rt_dir_priv *p = &curr_rtime->dir_priv[PLAYBACK];
+	struct ipq4019_mbox_rt_dir_priv *c = &curr_rtime->dir_priv[CAPTURE];
+
+	status = readl(mbox_reg + ADSS_MBOXn_MBOX_INT_STATUS_REG);
+
+	irq_proc_status(p, irq, status, 1, 0, &mask,
+					MBOX_INT_STATUS_RX_DMA_COMPLETE);
+	irq_proc_status(c, irq, status, 1, 0, &mask,
+					MBOX_INT_STATUS_TX_DMA_COMPLETE);
+	irq_proc_status(p, irq, status, 0, 1, &mask,
+					MBOX_INT_STATUS_RX_UNDERFLOW);
+	irq_proc_status(p, irq, status, 0, 1, &mask,
+					MBOX_INT_STATUS_RX_FIFO_UNDERFLOW);
+	irq_proc_status(c, irq, status, 0, 1, &mask,
+					MBOX_INT_STATUS_TX_OVERFLOW);
+	irq_proc_status(c, irq, status, 0, 1, &mask,
+					MBOX_INT_STATUS_TX_FIFO_OVERFLOW);
+
+	if (mask) {
+		writel(status & ~mask,
+				mbox_reg + ADSS_MBOXn_MBOX_INT_STATUS_REG);
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
+int ipq4019_mbox_dma_deinit(u32 channel_id)
+{
+	u32 chan, dir;
+	struct ipq4019_mbox_rt_dir_priv *mbox_cb;
+
+	chan = ipq4019_convert_id_to_channel(channel_id);
+	dir = ipq4019_convert_id_to_dir(channel_id);
+
+	mbox_cb = &mbox_rtime[chan]->dir_priv[dir];
+	if (test_bit(CHN_STARTED, &mbox_cb->status))
+		clear_bit(CHN_STARTED, &mbox_cb->status);
+
+	mbox_cb->dai_priv = NULL;
+	mbox_cb->callback = NULL;
+	mbox_cb->dev = NULL;
+
+	return 0;
+}
+EXPORT_SYMBOL(ipq4019_mbox_dma_deinit);
+
+int ipq4019_mbox_dma_init(struct device *dev, int channel_id,
+			irq_handler_t callback, void *private_data)
+{
+	u32 chan;
+	u32 dir;
+	struct ipq4019_mbox_rt_dir_priv *mbox_cb;
+
+	chan = ipq4019_convert_id_to_channel(channel_id);
+	dir = ipq4019_convert_id_to_dir(channel_id);
+
+	if (chan  >= ADSS_MBOX_NR_CHANNELS)
+		return -EINVAL;
+
+	if (!mbox_rtime[chan])
+		return -EINVAL;
+
+	mbox_cb = &mbox_rtime[chan]->dir_priv[dir];
+
+	if (!(mbox_cb->status & CHN_ENABLED))
+		return -EINVAL;
+
+	if (test_and_set_bit(CHN_STARTED, &mbox_cb->status))
+		return -EBUSY;
+
+	mbox_cb->dai_priv = private_data;
+	mbox_cb->callback = callback;
+	mbox_cb->dev = dev;
+
+	return 0;
+}
+EXPORT_SYMBOL(ipq4019_mbox_dma_init);
+
+static int ipq4019_mbox_probe(struct platform_device *pdev)
+{
+	struct device_node *np;
+	int irq;
+	u32 tx_channel;
+	u32 rx_channel;
+	u32 id;
+	void __iomem *reg_base;
+	struct resource *res;
+	int rc;
+
+	np = pdev->dev.of_node;
+
+	if (of_property_read_u32(np, "dma-index", &id)) {
+		dev_err(&pdev->dev,
+			"unable to read (dma-index) from device node %s\n",
+			np->name);
+		return -EINVAL;
+	}
+
+	if (id >= ADSS_MBOX_NR_CHANNELS)
+		return -EINVAL;
+
+	if (of_property_read_u32(np, "tx-channel", &tx_channel))
+		tx_channel = CHN_STATUS_DISABLE;
+
+	if (of_property_read_u32(np, "rx-channel", &rx_channel))
+		rx_channel = CHN_STATUS_DISABLE;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "%s: %d: Error getting mbox resource\n",
+						__func__, __LINE__);
+		return -EINVAL;
+	}
+
+	/*
+	 * Read interrupt and store
+	 */
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "%s: MBOX %d IRQ %d is not provided\n",
+						__func__, id, irq);
+		return irq;
+	}
+
+	reg_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(reg_base))
+		return PTR_ERR(reg_base);
+
+	mbox_rtime[id] = devm_kzalloc(&pdev->dev,
+			sizeof(struct ipq4019_mbox_rt_priv), GFP_KERNEL);
+	if (!mbox_rtime[id])
+		return -ENOMEM;
+
+	rc = devm_request_irq(&pdev->dev, irq, ipq4019_mbox_dma_irq, 0,
+				"ipq4019-mbox", mbox_rtime[id]);
+	if (rc) {
+		dev_err(&pdev->dev, "request_irq() failed with ret: %d\n", rc);
+		return rc;
+	}
+
+	mbox_rtime[id]->mbox_reg_base = reg_base;
+	mbox_rtime[id]->dir_priv[PLAYBACK].channel_id = tx_channel;
+	mbox_rtime[id]->dir_priv[CAPTURE].channel_id = rx_channel;
+	mbox_rtime[id]->dir_priv[PLAYBACK].status =
+		(tx_channel == CHN_STATUS_DISABLE) ? CHN_DISABLED : CHN_ENABLED;
+	mbox_rtime[id]->dir_priv[CAPTURE].status =
+		(rx_channel == CHN_STATUS_DISABLE) ? CHN_DISABLED : CHN_ENABLED;
+	mbox_rtime[id]->irq_no = irq;
+
+	return 0;
+}
+
+static const struct of_device_id ipq4019_mbox_table[] = {
+	{ .compatible = "qca,ipq4019-mbox" },
+	{},
+};
+
+static struct platform_driver ipq4019_mbox_driver = {
+	.probe = ipq4019_mbox_probe,
+	.driver = {
+		.name = "ipq4019-mbox",
+		.of_match_table = ipq4019_mbox_table,
+	},
+};
+
+module_platform_driver(ipq4019_mbox_driver);
+
+MODULE_ALIAS("platform:ipq4019-mbox");
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_DESCRIPTION("IPQ4019 MBOX DRIVER");
diff --git a/sound/soc/qcom/ipq4019/ipq4019-mbox.h b/sound/soc/qcom/ipq4019/ipq4019-mbox.h
new file mode 100644
index 0000000..f2e5ede
--- /dev/null
+++ b/sound/soc/qcom/ipq4019/ipq4019-mbox.h
@@ -0,0 +1,146 @@
+/*
+ * Copyright (c) 2015-2016 The Linux Foundation. All rights reserved.
+ *
+ * Permission to use, copy, modify, and/or distribute this software for any
+ * purpose with or without fee is hereby granted, provided that the above
+ * copyright notice and this permission notice appear in all copies.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
+ * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
+ * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
+ * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+ * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+ * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+ */
+
+#ifndef _IPQ4019_MBOX_H_
+#define _IPQ4019_MBOX_H_
+
+#include "ipq4019-adss.h"
+
+#define ADSS_MBOX_INVALID_PCM			(0xFFFFFFFF)
+#define ADSS_MBOX_REG_BASE			(0x7700000 + 0x6000)
+#define ADSS_MBOX_RANGE				(0xFA000)
+#define ADSS_MBOX_SPDIF_IRQ			(163 + 32)
+#define ADSS_MBOX0_IRQ				(156 + 32)
+#define ADSS_MBOX1_IRQ				(157 + 32)
+#define ADSS_MBOX2_IRQ				(158 + 32)
+#define ADSS_MBOX3_IRQ				(159 + 32)
+
+#define CHANNEL_A_VDWORD_START 0
+#define CHANNEL_B_VDWORD_START 18
+
+#define CHANNEL_A_VDWORD_1 (CHANNEL_A_VDWORD_START + 0)
+#define CHANNEL_A_VDWORD_2 (CHANNEL_A_VDWORD_START + 1)
+#define CHANNEL_A_VDWORD_3 (CHANNEL_A_VDWORD_START + 2)
+#define CHANNEL_A_VDWORD_4 (CHANNEL_A_VDWORD_START + 3)
+#define CHANNEL_A_VDWORD_5 (CHANNEL_A_VDWORD_START + 4)
+#define CHANNEL_A_VDWORD_6 (CHANNEL_A_VDWORD_START + 5)
+
+#define CHANNEL_B_VDWORD_1 (CHANNEL_B_VDWORD_START + 0)
+#define CHANNEL_B_VDWORD_2 (CHANNEL_B_VDWORD_START + 1)
+#define CHANNEL_B_VDWORD_3 (CHANNEL_B_VDWORD_START + 2)
+#define CHANNEL_B_VDWORD_4 (CHANNEL_B_VDWORD_START + 3)
+#define CHANNEL_B_VDWORD_5 (CHANNEL_B_VDWORD_START + 4)
+#define CHANNEL_B_VDWORD_6 (CHANNEL_B_VDWORD_START + 5)
+
+#define CHANNEL_A_CDWORD_START 12
+#define CHANNEL_B_CDWORD_START 30
+
+#define CHANNEL_A_CDWORD_1 (CHANNEL_A_CDWORD_START + 0)
+#define CHANNEL_B_CDWORD_2 (CHANNEL_B_CDWORD_START + 0)
+
+/* Acc to IEC 60958-3, bit 0.0 = 0 is consumer
+ *		       bit 0.1 = 1is compressed playback
+ *		       bit 3.0 = 1 is sampling freq No specified
+ */
+#define SPDIF_CONSUMER_COMPRESD 0x01000006
+#define MBOX_MIN_DESC_NUM	3
+#define MBOX_DESC_REPEAT_NUM	5
+
+enum {
+	ADSS_MBOX_NR_CHANNELS = 5,
+};
+
+struct ipq4019_mbox_desc {
+	unsigned int	length	: 12,	/* bit 11-00 */
+			size	: 12,	/* bit 23-12 */
+			vuc	: 1,	/* bit 24 */
+			ei	: 1,	/* bit 25 */
+			rsvd1	: 4,	/* bit 29-26 */
+			EOM	: 1,	/* bit 30 */
+			OWN	: 1,	/* bit 31 */
+			BufPtr	: 28,   /* bit 27-00 */
+			rsvd2	:  4,   /* bit 31-28 */
+			NextPtr	: 28,   /* bit 27-00 */
+			rsvd3	:  4;   /* bit 31-28 */
+
+	unsigned int vuc_dword[36];
+};
+
+#define MBOX_DMA_MASK		DMA_BIT_MASK(28)
+
+struct ipq4019_mbox_rt_dir_priv {
+	/* Desc array in virtual space */
+	struct ipq4019_mbox_desc *dma_virt_head;
+
+	/* Desc array for DMA */
+	dma_addr_t dma_phys_head;
+	struct device *dev;
+	unsigned int ndescs;
+	irq_handler_t callback;
+	void *dai_priv;
+	unsigned long status;
+	u32 channel_id;
+	u32 err_stats;
+	u32 last_played_is_null;
+	u32 write;
+	u32 read;
+};
+
+struct ipq4019_mbox_rt_priv {
+	int irq_no;
+	void __iomem *mbox_reg_base;
+	struct ipq4019_mbox_rt_dir_priv dir_priv[2];
+	int mbox_started;
+};
+
+/* Replaces struct ath_i2s_softc */
+struct ipq4019_pcm_pltfm_priv {
+	struct snd_pcm_substream *playback;
+	struct snd_pcm_substream *capture;
+};
+
+int ipq4019_mbox_fifo_reset(int channel_id);
+int ipq4019_mbox_dma_start(int channel_id);
+int ipq4019_mbox_dma_stop(int channel_id, u32 delay_in_ms);
+int ipq4019_mbox_dma_reset_swap(int channel_id);
+int ipq4019_mbox_dma_swap(int channel_id, snd_pcm_format_t format);
+int ipq4019_mbox_dma_prepare(int channel_id);
+int ipq4019_mbox_dma_resume(int channel_id);
+int ipq4019_mbox_form_ring(int channel_id, dma_addr_t baseaddr, u8 *base,
+				int period_bytes, int bufsize, int own_bit);
+int ipq4019_mbox_dma_release(int channel);
+int ipq4019_mbox_dma_init(struct device *dev, int channel_id,
+	irq_handler_t callback, void *private_data);
+void ipq4019_mbox_vuc_setup(int channel_id);
+u32 ipq4019_mbox_get_played_offset(u32 channel_id);
+int ipq4019_mbox_dma_deinit(u32 channel_id);
+void ipq4019_mbox_desc_own(u32 channel_id, int desc_no, int own);
+struct ipq4019_mbox_desc *ipq4019_mbox_get_last_played(unsigned int channel_id);
+uint32_t ipq4019_mbox_get_elapsed_size(uint32_t channel_id);
+void ipq4019_mbox_vuc_setup(int channel_id);
+uint32_t ipq4019_mbox_get_played_offset_set_own(u32 channel_id);
+
+static inline u32 ipq4019_convert_id_to_channel(u32 id)
+{
+	return (id / 2);
+}
+
+static inline u32 ipq4019_convert_id_to_dir(u32 id)
+{
+	return (id % 2);
+}
+
+#endif /* _IPQ40XX_MBOX_H_ */
diff --git a/sound/soc/qcom/ipq4019/ipq4019-pcm-i2s.c b/sound/soc/qcom/ipq4019/ipq4019-pcm-i2s.c
new file mode 100644
index 0000000..e93d999
--- /dev/null
+++ b/sound/soc/qcom/ipq4019/ipq4019-pcm-i2s.c
@@ -0,0 +1,609 @@
+/*
+ * Copyright (c) 2015-2016 The Linux Foundation. All rights reserved.
+ *
+ * Permission to use, copy, modify, and/or distribute this software for any
+ * purpose with or without fee is hereby granted, provided that the above
+ * copyright notice and this permission notice appear in all copies.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
+ * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
+ * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
+ * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+ * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+ * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/time.h>
+#include <linux/wait.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/dma-mapping.h>
+#include <asm/dma.h>
+#include <sound/core.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/pcm.h>
+#include <sound/initval.h>
+#include <sound/control.h>
+#include <sound/pcm_params.h>
+
+#include "ipq4019-adss.h"
+#include "ipq4019-pcm.h"
+
+static struct snd_pcm_hardware ipq4019_pcm_hardware_playback = {
+	.info			=	SNDRV_PCM_INFO_MMAP |
+					SNDRV_PCM_INFO_BLOCK_TRANSFER |
+					SNDRV_PCM_INFO_MMAP_VALID |
+					SNDRV_PCM_INFO_INTERLEAVED |
+					SNDRV_PCM_INFO_PAUSE |
+					SNDRV_PCM_INFO_RESUME,
+	.formats		=	SNDRV_PCM_FMTBIT_S16 |
+					SNDRV_PCM_FMTBIT_S32,
+	.rates			=	RATE_16000_96000,
+	.rate_min		=	FREQ_16000,
+	.rate_max		=	FREQ_96000,
+	.channels_min		=	CH_STEREO,
+	.channels_max		=	CH_STEREO,
+	.buffer_bytes_max	=	IPQ4019_I2S_BUFF_SIZE,
+	.period_bytes_max	=	IPQ4019_I2S_BUFF_SIZE / 2,
+	.period_bytes_min	=	IPQ4019_I2S_PERIOD_BYTES_MIN,
+	.periods_min		=	IPQ4019_I2S_NO_OF_PERIODS,
+	.periods_max		=	IPQ4019_I2S_NO_OF_PERIODS,
+	.fifo_size		=	0,
+};
+
+static struct snd_pcm_hardware ipq4019_pcm_hardware_capture = {
+	.info			=	SNDRV_PCM_INFO_MMAP |
+					SNDRV_PCM_INFO_BLOCK_TRANSFER |
+					SNDRV_PCM_INFO_MMAP_VALID |
+					SNDRV_PCM_INFO_INTERLEAVED,
+	.formats		=	SNDRV_PCM_FMTBIT_S16 |
+					SNDRV_PCM_FMTBIT_S32,
+	.rates			=	RATE_16000_96000,
+	.rate_min		=	FREQ_16000,
+	.rate_max		=	FREQ_96000,
+	.channels_min		=	CH_STEREO,
+	.channels_max		=	CH_STEREO,
+	.buffer_bytes_max	=	IPQ4019_I2S_BUFF_SIZE,
+	.period_bytes_max	=	IPQ4019_I2S_BUFF_SIZE / 2,
+	.period_bytes_min	=	IPQ4019_I2S_PERIOD_BYTES_MIN,
+	.periods_min		=	IPQ4019_I2S_NO_OF_PERIODS,
+	.periods_max		=	IPQ4019_I2S_NO_OF_PERIODS,
+	.fifo_size		=	0,
+};
+
+static size_t ip4019_dma_buffer_size(struct snd_pcm_hardware *pcm_hw)
+{
+	return (pcm_hw->buffer_bytes_max +
+		(pcm_hw->periods_min * sizeof(struct ipq4019_mbox_desc)));
+}
+
+static struct device *ss2dev(struct snd_pcm_substream *substream)
+{
+	return substream->pcm->card->dev;
+}
+
+/*
+ * The MBOX descriptors and buffers should lie within the same 256MB
+ * region. Because, the buffer address pointer (in the descriptor structure)
+ * and descriptor base address pointer register share the same MSB 4 bits
+ * which is configured in MBOX DMA Policy register.
+ *
+ * Hence ensure that the entire allocated region falls in a 256MB region.
+ */
+static int ipq4019_mbox_buf_is_aligned(void *c_ptr, ssize_t size)
+{
+	u32 ptr = (u32)c_ptr;
+
+	return (ptr & 0xF0000000) == ((ptr + size - 1) & 0xF0000000);
+}
+
+static int ipq4019_pcm_preallocate_dma_buffer(struct snd_pcm *pcm,
+						int stream)
+{
+	struct snd_pcm_substream *substream = pcm->streams[stream].substream;
+	struct snd_pcm_hardware *pcm_hw = NULL;
+	struct snd_dma_buffer *buf = &substream->dma_buffer;
+	size_t size;
+	u8 *area;
+	dma_addr_t addr;
+
+	switch (substream->stream) {
+	case SNDRV_PCM_STREAM_PLAYBACK:
+		pcm_hw = &ipq4019_pcm_hardware_playback;
+		break;
+	case SNDRV_PCM_STREAM_CAPTURE:
+		pcm_hw = &ipq4019_pcm_hardware_capture;
+		break;
+	default:
+		dev_err(ss2dev(substream), "Invalid stream: %d\n",
+							substream->stream);
+		return -EINVAL;
+	}
+
+	size = ip4019_dma_buffer_size(pcm_hw);
+	buf->dev.type = SNDRV_DMA_TYPE_DEV;
+	buf->dev.dev = pcm->card->dev;
+	buf->private_data = NULL;
+
+	/*
+	 * |<--   buffers             -->|<-- desc  -->|
+	 * +----+----+----+----+----+----+-+-+-+-+-+-+-+
+	 * |    |    |    |    |    |    | | | | | | | |
+	 * |    |    |    |    |    |    | | | | | | | |
+	 * |    |    |    |    |    |    | | | | | | | |
+	 * |    |    |    |    |    |    | | | | | | | |
+	 * |    |    |    |    |    |    | | | | | | | |
+	 * +----+----+----+----+----+----+-+-+-+-+-+-+-+
+	 * ^    ^                        | |  . . .
+	 * |    |                        | |
+	 * +----|------------------------+ |
+	 *	+--------------------------+
+	 */
+
+	/*
+	 * Currently payload uses uncached memory.
+	 * TODO: Eventually we will move to cached memory for payload
+	 * and dma_map_single() will be used for Invalidating/Flushing
+	 * the buffers.
+	 */
+
+	area = dma_alloc_coherent(pcm->card->dev, size, &addr, GFP_KERNEL);
+
+	if (!area) {
+		dev_info(ss2dev(substream), "Alloc coherent memory failed\n");
+		return -ENOMEM;
+	}
+
+	if (!ipq4019_mbox_buf_is_aligned(area, size)) {
+		dev_info(ss2dev(substream),
+			 "First allocation %p not within 256M region\n", area);
+
+		buf->area = dma_alloc_coherent(pcm->card->dev, size,
+						&buf->addr, GFP_KERNEL);
+		/*
+		 * If we are here, the previously allocated buffer is not
+		 * usable for the driver. Have to free it anyway regardless
+		 * of the success/failure of the second allocation.
+		 */
+		dma_free_coherent(pcm->card->dev, size, area, addr);
+		if (!buf->area) {
+			dev_info(ss2dev(substream),
+				 "Second Alloc coherent memory failed\n");
+			return -ENOMEM;
+		}
+	} else {
+		buf->area = area;
+		buf->addr = addr;
+	}
+
+	buf->bytes = pcm_hw->buffer_bytes_max;
+
+	return 0;
+}
+
+static void ipq4019_pcm_free_dma_buffer(struct snd_pcm *pcm, int stream)
+{
+	struct snd_pcm_substream *substream;
+	struct snd_pcm_hardware *pcm_hw = NULL;
+	struct snd_dma_buffer *buf;
+	size_t size;
+
+	substream = pcm->streams[stream].substream;
+	buf = &substream->dma_buffer;
+
+	switch (stream) {
+	case SNDRV_PCM_STREAM_PLAYBACK:
+		pcm_hw = &ipq4019_pcm_hardware_playback;
+		break;
+	case SNDRV_PCM_STREAM_CAPTURE:
+		pcm_hw = &ipq4019_pcm_hardware_capture;
+		break;
+	default:
+		dev_err(ss2dev(substream), "Invalid stream: %d\n",
+							substream->stream);
+		return;
+	}
+
+	size = ip4019_dma_buffer_size(pcm_hw);
+
+	dma_free_coherent(pcm->card->dev, size, buf->area, buf->addr);
+
+	buf->addr = 0;
+	buf->area = NULL;
+
+}
+
+static irqreturn_t ipq4019_pcm_irq(int intrsrc, void *data)
+{
+	struct snd_pcm_substream *substream = data;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct ipq4019_pcm_rt_priv *pcm_rtpriv = runtime->private_data;
+
+	if (pcm_rtpriv->mmap_flag)
+		pcm_rtpriv->curr_pos =
+			ipq4019_mbox_get_played_offset_set_own(
+						pcm_rtpriv->channel);
+	else
+		pcm_rtpriv->curr_pos =
+			ipq4019_mbox_get_played_offset(pcm_rtpriv->channel);
+
+	snd_pcm_period_elapsed(substream);
+
+	return IRQ_HANDLED;
+}
+
+static snd_pcm_uframes_t ipq4019_pcm_i2s_pointer(
+				struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct ipq4019_pcm_rt_priv *pcm_rtpriv = runtime->private_data;
+
+	return bytes_to_frames(runtime, pcm_rtpriv->curr_pos);
+}
+
+static int ipq4019_pcm_i2s_copy(struct snd_pcm_substream *substream, int chan,
+				snd_pcm_uframes_t hwoff, void __user *ubuf,
+				snd_pcm_uframes_t frames)
+{
+	struct snd_dma_buffer *buf = &substream->dma_buffer;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct ipq4019_pcm_rt_priv *pcm_rtpriv = runtime->private_data;
+	char *hwbuf;
+	u32 offset, size;
+
+	offset = frames_to_bytes(runtime, hwoff);
+	size = frames_to_bytes(runtime, frames);
+
+	hwbuf = buf->area + offset;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		if (copy_from_user(hwbuf, ubuf, size))
+			return -EFAULT;
+	} else if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
+		if (copy_to_user(ubuf, hwbuf, size))
+			return -EFAULT;
+	}
+
+	ipq4019_mbox_desc_own(pcm_rtpriv->channel, offset / size, 1);
+
+	ipq4019_mbox_dma_resume(pcm_rtpriv->channel);
+
+	return 0;
+}
+
+static int ipq4019_pcm_i2s_mmap(struct snd_pcm_substream *substream,
+				struct vm_area_struct *vma)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct ipq4019_pcm_rt_priv *pcm_rtpriv = runtime->private_data;
+
+	pcm_rtpriv->mmap_flag = 1;
+
+	return dma_mmap_coherent(substream->pcm->card->dev, vma,
+		runtime->dma_area, runtime->dma_addr, runtime->dma_bytes);
+}
+
+static int ipq4019_pcm_hw_free(struct snd_pcm_substream *substream)
+{
+	snd_pcm_set_runtime_buffer(substream, NULL);
+	return 0;
+}
+
+
+static int ipq4019_pcm_i2s_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct ipq4019_pcm_rt_priv *pcm_rtpriv = runtime->private_data;
+	u32 ret;
+
+	ret = ipq4019_mbox_dma_prepare(pcm_rtpriv->channel);
+	if (ret) {
+		dev_err(ss2dev(substream),
+			"Error in dma prepare: channel: %d ret: %d\n",
+			pcm_rtpriv->channel, ret);
+		return ret;
+	}
+
+	pcm_rtpriv->last_played = NULL;
+
+	return 0;
+}
+
+static int ipq4019_pcm_i2s_close(struct snd_pcm_substream *substream)
+{
+	struct ipq4019_pcm_rt_priv *pcm_rtpriv =
+				substream->runtime->private_data;
+	u32 ret;
+
+	pcm_rtpriv->mmap_flag = 0;
+
+	ret = ipq4019_mbox_dma_release(pcm_rtpriv->channel);
+	if (ret)
+		dev_err(ss2dev(substream),
+			"Error in dma release. ret: %d\n", ret);
+
+	kfree(pcm_rtpriv);
+
+	return 0;
+}
+
+static int ipq4019_pcm_i2s_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	int ret;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct ipq4019_pcm_rt_priv *pcm_rtpriv = runtime->private_data;
+	u32 desc_duration;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+		ret = ipq4019_mbox_dma_start(pcm_rtpriv->channel);
+		if (ret) {
+			dev_err(ss2dev(substream),
+				"Error in dma start. ret: %d\n", ret);
+		}
+		break;
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		ret = ipq4019_mbox_dma_resume(pcm_rtpriv->channel);
+		if (ret) {
+			dev_err(ss2dev(substream),
+				"Error in dma resume. ret: %d\n", ret);
+		}
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		/*
+		 * For e.g. the number of bytes needed to represent 1 second
+		 * worth of audio data for sampling frequency, bit width, stereo
+		 * combination of 16KHz, 32-bits and stereo, the calculation is
+		 * as follows
+		 *
+		 * For 1 second,
+		 *	16KHz * 32 bits * 2 (left & right channel of stereo)
+		 *	= 16000 * 4 bytes * 2
+		 *	= 128000 bytes
+		 *
+		 * Hence the duration will be
+		 *	desc_buffer_size_in_bytes / 128000 * 1 sec
+		 */
+		desc_duration =
+			frames_to_bytes(runtime, runtime->period_size) * 1000 /
+				(runtime->rate *
+				 DIV_ROUND_UP(runtime->sample_bits, 8) *
+				 runtime->channels);
+
+		dev_dbg(ss2dev(substream),
+			"period_size:%u rate:%u sample_bits:%u channels:%u desc_delay:%u\n",
+			frames_to_bytes(runtime, runtime->period_size),
+			runtime->rate, runtime->sample_bits, runtime->channels,
+			desc_duration);
+
+		ret = ipq4019_mbox_dma_stop(pcm_rtpriv->channel, desc_duration);
+		if (ret) {
+			dev_err(ss2dev(substream),
+				"Error in dma stop. ret: %d\n", ret);
+		}
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	return ret;
+}
+
+static int ipq4019_pcm_i2s_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *hw_params)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct ipq4019_pcm_rt_priv *pcm_rtpriv = runtime->private_data;
+	int ret;
+	unsigned int period_size, sample_size, sample_rate, frames, channels;
+
+	ret = ipq4019_mbox_form_ring(pcm_rtpriv->channel,
+			substream->dma_buffer.addr,
+			substream->dma_buffer.area,
+			params_period_bytes(hw_params),
+			params_buffer_bytes(hw_params),
+			(substream->stream == SNDRV_PCM_STREAM_CAPTURE));
+	if (ret) {
+		dev_dbg(ss2dev(substream),
+			"Error dma form ring ret: %d\n", ret);
+		return ret;
+	}
+
+	period_size = params_period_bytes(hw_params);
+	sample_size = snd_pcm_format_size(params_format(hw_params), 1);
+	sample_rate = params_rate(hw_params);
+	channels = params_channels(hw_params);
+	frames = period_size / (sample_size * channels);
+
+	pcm_rtpriv->period_size = params_period_bytes(hw_params);
+
+	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
+
+	runtime->dma_bytes = params_buffer_bytes(hw_params);
+	return 0;
+}
+
+static int ipq4019_pcm_i2s_open(struct snd_pcm_substream *substream)
+{
+	int ret;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct ipq4019_pcm_rt_priv *pcm_rtpriv;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *dai = rtd->cpu_dai;
+	u32 intf = dai->driver->id;
+
+	pcm_rtpriv = kmalloc(sizeof(struct ipq4019_pcm_rt_priv), GFP_KERNEL);
+	if (!pcm_rtpriv)
+		return -ENOMEM;
+
+	dev_dbg(ss2dev(substream), "%s: 0x%xB allocated at 0x%08x\n",
+			__func__, sizeof(*pcm_rtpriv), (u32) pcm_rtpriv);
+	pcm_rtpriv->last_played = NULL;
+	pcm_rtpriv->dev = substream->pcm->card->dev;
+	pcm_rtpriv->channel = ipq4019_get_mbox_id(substream, intf);
+	pcm_rtpriv->curr_pos = 0;
+	pcm_rtpriv->mmap_flag = 0;
+	substream->runtime->private_data = pcm_rtpriv;
+
+	switch (substream->stream) {
+	case SNDRV_PCM_STREAM_PLAYBACK:
+		runtime->dma_bytes =
+			ipq4019_pcm_hardware_playback.buffer_bytes_max;
+		snd_soc_set_runtime_hwparams(substream,
+				&ipq4019_pcm_hardware_playback);
+		break;
+	case SNDRV_PCM_STREAM_CAPTURE:
+		runtime->dma_bytes =
+				ipq4019_pcm_hardware_capture.buffer_bytes_max;
+		snd_soc_set_runtime_hwparams(substream,
+					&ipq4019_pcm_hardware_capture);
+		break;
+	default:
+		dev_err(ss2dev(substream), "Invalid stream: %d\n",
+			substream->stream);
+		ret = -EINVAL;
+		goto error;
+	}
+
+	ret = ipq4019_mbox_dma_init(pcm_rtpriv->dev,
+		pcm_rtpriv->channel, ipq4019_pcm_irq, substream);
+	if (ret) {
+		dev_err(ss2dev(substream),
+			"Error initializing dma. ret: %d\n", ret);
+		goto error;
+	}
+
+	ret = snd_pcm_hw_constraint_integer(runtime,
+			SNDRV_PCM_HW_PARAM_PERIODS);
+	if (ret < 0) {
+		dev_err(ss2dev(substream),
+			"snd_pcm_hw_constraint_integer failed ret: %d\n",
+			ret);
+		goto error_hw_const;
+	}
+
+	return 0;
+error_hw_const:
+	ipq4019_mbox_dma_deinit(pcm_rtpriv->channel);
+error:
+	kfree(pcm_rtpriv);
+	return ret;
+}
+
+static struct snd_pcm_ops ipq4019_asoc_pcm_i2s_ops = {
+	.open		= ipq4019_pcm_i2s_open,
+	.hw_params	= ipq4019_pcm_i2s_hw_params,
+	.hw_free	= ipq4019_pcm_hw_free,
+	.trigger	= ipq4019_pcm_i2s_trigger,
+	.ioctl		= snd_pcm_lib_ioctl,
+	.close		= ipq4019_pcm_i2s_close,
+	.prepare	= ipq4019_pcm_i2s_prepare,
+	.mmap		= ipq4019_pcm_i2s_mmap,
+	.pointer	= ipq4019_pcm_i2s_pointer,
+	.copy		= ipq4019_pcm_i2s_copy,
+};
+
+static void ipq4019_asoc_pcm_i2s_free(struct snd_pcm *pcm)
+{
+	ipq4019_pcm_free_dma_buffer(pcm, SNDRV_PCM_STREAM_PLAYBACK);
+	ipq4019_pcm_free_dma_buffer(pcm, SNDRV_PCM_STREAM_CAPTURE);
+}
+
+static int ipq4019_asoc_pcm_i2s_new(struct snd_soc_pcm_runtime *prtd)
+{
+	struct snd_card *card = prtd->card->snd_card;
+	struct snd_pcm *pcm = prtd->pcm;
+	int ret = 0, pback = 0;
+
+	if (!card->dev->coherent_dma_mask)
+		card->dev->coherent_dma_mask = DMA_BIT_MASK(32);
+
+	if (!card->dev->dma_mask)
+		card->dev->dma_mask = &card->dev->coherent_dma_mask;
+
+	if (pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream) {
+		ret = ipq4019_pcm_preallocate_dma_buffer(pcm,
+				SNDRV_PCM_STREAM_PLAYBACK);
+		if (ret) {
+			dev_err(card->dev,
+				"Error allocating playback dma. ret: %d\n",
+									ret);
+			return -ENOMEM;
+		}
+		pback = 1;
+	}
+
+	if (pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream) {
+		ret = ipq4019_pcm_preallocate_dma_buffer(pcm,
+				SNDRV_PCM_STREAM_CAPTURE);
+		if (ret) {
+			dev_err(card->dev,
+				"Error allocating capture dma buf. ret: %d\n",
+									ret);
+			if (pback)
+				ipq4019_pcm_free_dma_buffer(pcm,
+						SNDRV_PCM_STREAM_PLAYBACK);
+			return -ENOMEM;
+		}
+	}
+
+	return ret;
+}
+
+static struct snd_soc_platform_driver ipq4019_asoc_pcm_i2s_platform = {
+	.ops		= &ipq4019_asoc_pcm_i2s_ops,
+	.pcm_new	= ipq4019_asoc_pcm_i2s_new,
+	.pcm_free	= ipq4019_asoc_pcm_i2s_free,
+};
+
+static const struct of_device_id ipq4019_pcm_i2s_id_table[] = {
+	{ .compatible = "qca,ipq4019-pcm-i2s" },
+	{ .compatible = "qca,ipq4019-pcm-i2s1" },
+	{ .compatible = "qca,ipq4019-pcm-i2s2" },
+	{ /* Sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, ipq4019_pcm_i2s_id_table);
+
+static int ipq4019_pcm_i2s_driver_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	ret = snd_soc_register_platform(&pdev->dev,
+			&ipq4019_asoc_pcm_i2s_platform);
+	if (ret)
+		dev_err(&pdev->dev,
+			"Failed to register i2s pcm device ret: %d\n", ret);
+	return ret;
+}
+
+static int ipq4019_pcm_i2s_driver_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_platform(&pdev->dev);
+	return 0;
+}
+
+static struct platform_driver ipq4019_pcm_i2s_driver = {
+	.probe = ipq4019_pcm_i2s_driver_probe,
+	.remove = ipq4019_pcm_i2s_driver_remove,
+	.driver = {
+		.name = "qca-pcm-i2s",
+		.owner = THIS_MODULE,
+		.of_match_table = ipq4019_pcm_i2s_id_table,
+	},
+};
+
+module_platform_driver(ipq4019_pcm_i2s_driver);
+
+MODULE_ALIAS("platform:qca-pcm-i2s");
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_DESCRIPTION("IPQ4019 PCM I2S Platform Driver");
diff --git a/sound/soc/qcom/ipq4019/ipq4019-pcm-spdif.c b/sound/soc/qcom/ipq4019/ipq4019-pcm-spdif.c
new file mode 100644
index 0000000..08dac4a
--- /dev/null
+++ b/sound/soc/qcom/ipq4019/ipq4019-pcm-spdif.c
@@ -0,0 +1,664 @@
+/*
+ * Copyright (c) 2015-2016 The Linux Foundation. All rights reserved.
+ *
+ * Permission to use, copy, modify, and/or distribute this software for any
+ * purpose with or without fee is hereby granted, provided that the above
+ * copyright notice and this permission notice appear in all copies.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
+ * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
+ * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
+ * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+ * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+ * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/time.h>
+#include <linux/wait.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/dma-mapping.h>
+#include <asm/dma.h>
+#include <sound/core.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/pcm.h>
+#include <sound/initval.h>
+#include <sound/control.h>
+#include <sound/pcm_params.h>
+
+#include "ipq4019-pcm.h"
+#include "ipq4019-adss.h"
+
+static struct snd_pcm_hardware ipq4019_pcm_hardware_playback = {
+	.info			=	SNDRV_PCM_INFO_MMAP |
+					SNDRV_PCM_INFO_BLOCK_TRANSFER |
+					SNDRV_PCM_INFO_MMAP_VALID |
+					SNDRV_PCM_INFO_INTERLEAVED |
+					SNDRV_PCM_INFO_PAUSE |
+					SNDRV_PCM_INFO_RESUME,
+	.formats		=	SNDRV_PCM_FMTBIT_S16 |
+					SNDRV_PCM_FMTBIT_S24_3,
+	.rates			=	RATE_16000_96000,
+	.rate_min		=	FREQ_16000,
+	.rate_max		=	FREQ_96000,
+	.channels_min		=	CH_STEREO,
+	.channels_max		=	CH_STEREO,
+	.buffer_bytes_max	=	IPQ4019_I2S_BUFF_SIZE,
+	.period_bytes_max	=	IPQ4019_I2S_BUFF_SIZE / 2,
+	.period_bytes_min	=	IPQ4019_I2S_PERIOD_BYTES_MIN,
+	.periods_min		=	IPQ4019_I2S_NO_OF_PERIODS,
+	.periods_max		=	IPQ4019_I2S_NO_OF_PERIODS,
+	.fifo_size		=	0,
+};
+
+static struct snd_pcm_hardware ipq4019_pcm_hardware_capture = {
+	.info			=	SNDRV_PCM_INFO_MMAP |
+					SNDRV_PCM_INFO_BLOCK_TRANSFER |
+					SNDRV_PCM_INFO_MMAP_VALID |
+					SNDRV_PCM_INFO_INTERLEAVED,
+	.formats		=	SNDRV_PCM_FMTBIT_S16 |
+					SNDRV_PCM_FMTBIT_S24_3,
+	.rates			=	RATE_16000_96000,
+	.rate_min		=	FREQ_16000,
+	.rate_max		=	FREQ_96000,
+	.channels_min		=	CH_STEREO,
+	.channels_max		=	CH_STEREO,
+	.buffer_bytes_max	=	IPQ4019_I2S_BUFF_SIZE,
+	.period_bytes_max	=	IPQ4019_I2S_BUFF_SIZE / 2,
+	.period_bytes_min	=	IPQ4019_I2S_PERIOD_BYTES_MIN,
+	.periods_min		=	IPQ4019_I2S_NO_OF_PERIODS,
+	.periods_max		=	IPQ4019_I2S_NO_OF_PERIODS,
+	.fifo_size		=	0,
+};
+
+static size_t ip4019_dma_buffer_size(struct snd_pcm_hardware *pcm_hw)
+{
+	return pcm_hw->buffer_bytes_max +
+		(pcm_hw->periods_min * sizeof(struct ipq4019_mbox_desc));
+}
+
+/*
+ * The MBOX descriptors and buffers should lie within the same 256MB
+ * region. Because, the buffer address pointer (in the descriptor structure)
+ * and descriptor base address pointer register share the same MSB 4 bits
+ * which is configured in MBOX DMA Policy register.
+ *
+ * Hence ensure that the entire allocated region falls in a 256MB region.
+ */
+static int ipq4019_mbox_buf_is_aligned(void *c_ptr, ssize_t size)
+{
+	u32 ptr = (u32)c_ptr;
+
+	return (ptr & 0xF0000000) == ((ptr + size - 1) & 0xF0000000);
+}
+
+static struct device *ss2dev(struct snd_pcm_substream *substream)
+{
+	return substream->pcm->card->dev;
+}
+
+static int ipq4019_pcm_preallocate_dma_buffer(struct snd_pcm *pcm,
+						int stream)
+{
+	struct snd_pcm_substream *substream = pcm->streams[stream].substream;
+	struct snd_dma_buffer *buf = &substream->dma_buffer;
+	struct snd_pcm_hardware *pcm_hw = NULL;
+	size_t size;
+	u8 *area;
+	dma_addr_t addr;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		pcm_hw = &ipq4019_pcm_hardware_playback;
+	else if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
+		pcm_hw = &ipq4019_pcm_hardware_capture;
+	else
+		return -EINVAL;
+
+	size = ip4019_dma_buffer_size(pcm_hw);
+	buf->dev.type = SNDRV_DMA_TYPE_DEV;
+	buf->dev.dev = pcm->card->dev;
+	buf->private_data = NULL;
+
+	area = dma_alloc_coherent(pcm->card->dev, size, &addr, GFP_KERNEL);
+	if (!area) {
+		dev_info(ss2dev(substream), "Alloc coherent memory failed\n");
+		return -ENOMEM;
+	}
+
+	if (!ipq4019_mbox_buf_is_aligned(area, size)) {
+		dev_info(ss2dev(substream),
+			 "First allocation %p not within 256M region\n", area);
+
+		buf->area = dma_alloc_coherent(pcm->card->dev, size,
+						&buf->addr, GFP_KERNEL);
+		/*
+		 * If we are here, the previously allocated buffer is not
+		 * usable for the driver. Have to free it anyway regardless
+		 * of the success/failure of the second allocation.
+		 */
+		dma_free_coherent(pcm->card->dev, size, area, addr);
+		if (!buf->area) {
+			dev_info(ss2dev(substream),
+				 "Second Alloc coherent memory failed\n");
+			return -ENOMEM;
+		}
+	} else {
+		buf->area = area;
+		buf->addr = addr;
+	}
+
+	buf->bytes = pcm_hw->buffer_bytes_max;
+
+	return 0;
+}
+
+static void ipq4019_pcm_free_dma_buffer(struct snd_pcm *pcm, int stream)
+{
+	struct snd_pcm_substream *substream;
+	struct snd_pcm_hardware *pcm_hw = NULL;
+	struct snd_dma_buffer *buf;
+	size_t size;
+
+	substream = pcm->streams[stream].substream;
+	buf = &substream->dma_buffer;
+
+	switch (stream) {
+	case SNDRV_PCM_STREAM_PLAYBACK:
+		pcm_hw = &ipq4019_pcm_hardware_playback;
+		break;
+	case SNDRV_PCM_STREAM_CAPTURE:
+		pcm_hw = &ipq4019_pcm_hardware_capture;
+		break;
+	}
+
+	size = ip4019_dma_buffer_size(pcm_hw);
+
+	dma_free_coherent(pcm->card->dev, size, buf->area, buf->addr);
+
+	buf->area = NULL;
+}
+
+static irqreturn_t ipq4019_pcm_irq(int intrsrc, void *data)
+{
+	uint32_t processed_size;
+	int offset;
+	uint32_t *ptr;
+
+	struct snd_pcm_substream *substream = data;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct ipq4019_pcm_rt_priv *pcm_rtpriv =
+		(struct ipq4019_pcm_rt_priv *)runtime->private_data;
+
+	/* Store the last played buffer in the runtime priv struct */
+	pcm_rtpriv->last_played =
+		ipq4019_mbox_get_last_played(pcm_rtpriv->channel);
+
+	/* Set the OWN bits */
+	processed_size = ipq4019_mbox_get_elapsed_size(pcm_rtpriv->channel);
+	pcm_rtpriv->processed_size = processed_size;
+
+	if (processed_size > pcm_rtpriv->period_size)
+		snd_printd("Processed more than one period bytes : %d\n",
+						processed_size);
+
+	/* Need to extract the data part alone in case of Rx */
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
+		if (pcm_rtpriv->last_played == NULL)
+			offset = 0;
+		else
+			offset = (pcm_rtpriv->last_played->BufPtr -
+					(runtime->dma_addr & 0xFFFFFFF));
+
+		if (offset > 0) {
+			ptr = (uint32_t *)((char *)runtime->dma_area + offset -
+						processed_size);
+
+			if (ptr < (uint32_t *)runtime->dma_area)
+				goto ack;
+		}
+	}
+
+	snd_pcm_period_elapsed(substream);
+
+	if (pcm_rtpriv->last_played == NULL) {
+		snd_printd("BUG: ISR called but no played buf found\n");
+		goto ack;
+	}
+
+ack:
+	return IRQ_HANDLED;
+}
+
+static snd_pcm_uframes_t ipq4019_pcm_spdif_pointer(
+				struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct ipq4019_pcm_rt_priv *pcm_rtpriv;
+	snd_pcm_uframes_t ret;
+
+	pcm_rtpriv = runtime->private_data;
+
+	if (pcm_rtpriv->last_played == NULL)
+		ret = 0;
+	else
+		ret = (pcm_rtpriv->last_played->BufPtr -
+				(runtime->dma_addr & 0xFFFFFFF));
+	ret = bytes_to_frames(runtime, ret);
+	return ret;
+}
+
+static int ipq4019_pcm_spdif_copy(struct snd_pcm_substream *substream, int chan,
+				snd_pcm_uframes_t hwoff, void __user *ubuf,
+				snd_pcm_uframes_t frames)
+{
+	struct snd_dma_buffer *buf = &substream->dma_buffer;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct ipq4019_pcm_rt_priv *pcm_rtpriv = runtime->private_data;
+	char *hwbuf;
+	u32 offset, size;
+
+	offset = frames_to_bytes(runtime, hwoff);
+	size = frames_to_bytes(runtime, frames);
+
+	hwbuf = buf->area + offset;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		if (copy_from_user(hwbuf, ubuf, size))
+			return -EFAULT;
+	} else if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
+		if (copy_to_user(ubuf, hwbuf, size))
+			return -EFAULT;
+	}
+
+	ipq4019_mbox_desc_own(pcm_rtpriv->channel, offset / size, 1);
+
+	ipq4019_mbox_dma_resume(pcm_rtpriv->channel);
+
+	return 0;
+}
+
+static int ipq4019_pcm_spdif_mmap(struct snd_pcm_substream *substream,
+				struct vm_area_struct *vma)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	return dma_mmap_coherent(substream->pcm->card->dev, vma,
+		runtime->dma_area, runtime->dma_addr, runtime->dma_bytes);
+}
+
+static int ipq4019_pcm_hw_free(struct snd_pcm_substream *substream)
+{
+	snd_pcm_set_runtime_buffer(substream, NULL);
+	return 0;
+}
+
+
+static int ipq4019_pcm_spdif_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct ipq4019_pcm_rt_priv *pcm_rtpriv;
+
+	uint32_t ret;
+
+	pcm_rtpriv = runtime->private_data;
+
+	ret = ipq4019_mbox_dma_prepare(pcm_rtpriv->channel);
+	if (ret) {
+		pr_err("%s: %d: Error in dma prepare : channel : %d\n",
+				__func__, __LINE__, pcm_rtpriv->channel);
+		ipq4019_mbox_dma_release(pcm_rtpriv->channel);
+		return ret;
+	}
+
+	/* Set to swap the words */
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		ret = ipq4019_mbox_dma_swap(pcm_rtpriv->channel,
+			runtime->format);
+		if (ret) {
+			pr_err("%s: %d: Error in dma swap : channel : %d\n",
+				__func__, __LINE__, pcm_rtpriv->channel);
+			ipq4019_mbox_dma_release(pcm_rtpriv->channel);
+			return ret;
+		}
+
+		/* SWAP at PCM level for 24 bit samples */
+		if ((substream->runtime->format == SNDRV_PCM_FORMAT_S24_3LE) ||
+		    (substream->runtime->format == SNDRV_PCM_FORMAT_S24_3BE))
+			ipq4019_stereo_spdif_pcmswap(ENABLE,
+				ipq4019_get_stereo_id(substream, SPDIF));
+	}
+
+	/* Set the ownership bits */
+	ipq4019_mbox_get_elapsed_size(pcm_rtpriv->channel);
+
+	pcm_rtpriv->last_played = NULL;
+
+	return ret;
+}
+
+static int ipq4019_pcm_spdif_close(struct snd_pcm_substream *substream)
+{
+	struct ipq4019_pcm_rt_priv *pcm_rtpriv;
+	uint32_t ret;
+
+	pcm_rtpriv = substream->runtime->private_data;
+	ret = ipq4019_mbox_dma_release(pcm_rtpriv->channel);
+	if (ret) {
+		pr_err("%s: %d: Error in dma release\n",
+					__func__, __LINE__);
+	}
+
+	/* Reset the swap */
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		ret = ipq4019_mbox_dma_reset_swap(pcm_rtpriv->channel);
+		if (ret) {
+			pr_err("%s: %d: Error in dma release\n",
+				__func__, __LINE__);
+		}
+
+		if ((substream->runtime->format == SNDRV_PCM_FORMAT_S24_3LE) ||
+		    (substream->runtime->format == SNDRV_PCM_FORMAT_S24_3BE))
+			ipq4019_stereo_spdif_pcmswap(DISABLE,
+				ipq4019_get_stereo_id(substream, SPDIF));
+	}
+
+	kfree(pcm_rtpriv);
+
+	return ret;
+}
+
+static int ipq4019_pcm_spdif_trigger(struct snd_pcm_substream *substream,
+					int cmd)
+{
+	int ret;
+	u32 desc_duration;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct ipq4019_pcm_rt_priv *pcm_rtpriv =
+				substream->runtime->private_data;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+		/* Enable the SPDIF Stereo block for operation */
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			ipq4019_stereo_spdif_enable(ENABLE,
+					ipq4019_get_stereo_id(substream,
+								SPDIF));
+		else
+			ipq4019_spdifin_ctrl_spdif_en(ENABLE);
+
+		ret = ipq4019_mbox_dma_start(pcm_rtpriv->channel);
+		if (ret) {
+			pr_err("%s: %d: Error in dma start\n",
+				__func__, __LINE__);
+			ipq4019_mbox_dma_release(pcm_rtpriv->channel);
+		}
+		break;
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		ret = ipq4019_mbox_dma_resume(pcm_rtpriv->channel);
+		if (ret) {
+			pr_err("%s: %d: Error in dma resume\n",
+				__func__, __LINE__);
+			ipq4019_mbox_dma_release(pcm_rtpriv->channel);
+		}
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+		/* Disable the SPDIF Stereo block */
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			ipq4019_stereo_spdif_enable(DISABLE,
+					ipq4019_get_stereo_id(substream,
+								SPDIF));
+		else
+			ipq4019_spdifin_ctrl_spdif_en(DISABLE);
+
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		/*
+		 * For e.g. the number of bytes needed to represent 1 second
+		 * worth of audio data for sampling frequency, bit width, stereo
+		 * combination of 16KHz, 32-bits and stereo, the calculation is
+		 * as follows
+		 *
+		 * For 1 second,
+		 *	16KHz * 32 bits * 2 (left & right channel of stereo)
+		 *	= 16000 * 4 bytes * 2
+		 *	= 128000 bytes
+		 *
+		 * Hence the duration will be
+		 *	desc_buffer_size_in_bytes / 128000 * 1 sec
+		 */
+		desc_duration =
+			frames_to_bytes(runtime, runtime->period_size) * 1000 /
+				(runtime->rate *
+				 DIV_ROUND_UP(runtime->sample_bits, 8) *
+				 runtime->channels);
+
+		ret = ipq4019_mbox_dma_stop(pcm_rtpriv->channel, desc_duration);
+		if (ret) {
+			pr_err("%s: %d: Error in dma stop\n",
+				__func__, __LINE__);
+			ipq4019_mbox_dma_release(pcm_rtpriv->channel);
+		}
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	return ret;
+}
+
+static int ipq4019_pcm_spdif_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *hw_params)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct ipq4019_pcm_rt_priv *pcm_rtpriv;
+	int ret;
+	unsigned int period_size, sample_size, sample_rate, frames, channels;
+
+	pr_debug("%s %d\n", __func__, __LINE__);
+
+	pcm_rtpriv = runtime->private_data;
+	ret = ipq4019_mbox_form_ring(pcm_rtpriv->channel,
+			substream->dma_buffer.addr,
+			substream->dma_buffer.area,
+			params_period_bytes(hw_params),
+			params_buffer_bytes(hw_params),
+			(substream->stream == SNDRV_PCM_STREAM_CAPTURE));
+	if (ret) {
+		pr_err("%s: %d: Error dma form ring\n",	__func__, __LINE__);
+		ipq4019_mbox_dma_release(pcm_rtpriv->channel);
+		return ret;
+	}
+
+	period_size = params_period_bytes(hw_params);
+	sample_size = snd_pcm_format_size(params_format(hw_params), 1);
+	sample_rate = params_rate(hw_params);
+	channels = params_channels(hw_params);
+	frames = period_size / (sample_size * channels);
+
+	pcm_rtpriv->period_size = params_period_bytes(hw_params);
+
+	/* Check whether this is a compressed play or not
+	 * if its a compressed play set VUC
+	 */
+	if (hw_params->reserved[0])
+		ipq4019_mbox_vuc_setup(pcm_rtpriv->channel);
+
+	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
+
+	runtime->dma_bytes = params_buffer_bytes(hw_params);
+	return ret;
+}
+
+static int ipq4019_pcm_spdif_open(struct snd_pcm_substream *substream)
+{
+	int ret;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct ipq4019_pcm_rt_priv *pcm_rtpriv;
+
+	pr_debug("%s %d\n", __func__, __LINE__);
+
+	pcm_rtpriv = kmalloc(sizeof(struct ipq4019_pcm_rt_priv), GFP_KERNEL);
+	if (!pcm_rtpriv)
+		return -ENOMEM;
+
+	snd_printd("%s: 0x%xB allocated at 0x%08x\n",
+			__func__, sizeof(*pcm_rtpriv), (u32) pcm_rtpriv);
+	pcm_rtpriv->last_played = NULL;
+	pcm_rtpriv->dev = substream->pcm->card->dev;
+	pcm_rtpriv->channel = ipq4019_get_mbox_id(substream, SPDIF);
+	pcm_rtpriv->curr_pos = 0;
+	pcm_rtpriv->mmap_flag = 0;
+	substream->runtime->private_data = pcm_rtpriv;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		runtime->dma_bytes =
+			ipq4019_pcm_hardware_playback.buffer_bytes_max;
+		snd_soc_set_runtime_hwparams(substream,
+				&ipq4019_pcm_hardware_playback);
+	} else if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
+		runtime->dma_bytes =
+				ipq4019_pcm_hardware_capture.buffer_bytes_max;
+		snd_soc_set_runtime_hwparams(substream,
+					&ipq4019_pcm_hardware_capture);
+
+	} else {
+		pr_err("%s: Invalid stream\n", __func__);
+		ret = -EINVAL;
+		goto error;
+	}
+	ret = ipq4019_mbox_dma_init(pcm_rtpriv->dev,
+		pcm_rtpriv->channel, ipq4019_pcm_irq, substream);
+	if (ret) {
+		pr_err("%s: %d: Error initializing dma\n",
+					__func__, __LINE__);
+		goto error;
+	}
+
+	ret = snd_pcm_hw_constraint_integer(runtime,
+			SNDRV_PCM_HW_PARAM_PERIODS);
+	if (ret < 0) {
+		pr_err("%s: snd_pcm_hw_constraint_integer failed\n", __func__);
+		ipq4019_mbox_dma_release(pcm_rtpriv->channel);
+		goto error;
+	}
+
+	return 0;
+error:
+	kfree(pcm_rtpriv);
+	return ret;
+}
+
+static struct snd_pcm_ops ipq4019_asoc_pcm_spdif_ops = {
+	.open		= ipq4019_pcm_spdif_open,
+	.hw_params	= ipq4019_pcm_spdif_hw_params,
+	.hw_free	= ipq4019_pcm_hw_free,
+	.trigger	= ipq4019_pcm_spdif_trigger,
+	.ioctl		= snd_pcm_lib_ioctl,
+	.close		= ipq4019_pcm_spdif_close,
+	.prepare	= ipq4019_pcm_spdif_prepare,
+	.mmap		= ipq4019_pcm_spdif_mmap,
+	.pointer	= ipq4019_pcm_spdif_pointer,
+	.copy		= ipq4019_pcm_spdif_copy,
+};
+
+static void ipq4019_asoc_pcm_spdif_free(struct snd_pcm *pcm)
+{
+	ipq4019_pcm_free_dma_buffer(pcm, SNDRV_PCM_STREAM_PLAYBACK);
+	ipq4019_pcm_free_dma_buffer(pcm, SNDRV_PCM_STREAM_CAPTURE);
+}
+
+static int ipq4019_asoc_pcm_spdif_new(struct snd_soc_pcm_runtime *prtd)
+{
+	struct snd_card *card = prtd->card->snd_card;
+	struct snd_pcm *pcm = prtd->pcm;
+
+	int ret = 0;
+
+	if (!card->dev->coherent_dma_mask)
+		card->dev->coherent_dma_mask = DMA_BIT_MASK(32);
+
+	if (!card->dev->dma_mask)
+		card->dev->dma_mask = &card->dev->coherent_dma_mask;
+
+	if (pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream) {
+		ret = ipq4019_pcm_preallocate_dma_buffer(pcm,
+				SNDRV_PCM_STREAM_PLAYBACK);
+
+		if (ret) {
+			pr_err("%s: %d: Error allocating dma buf\n",
+						__func__, __LINE__);
+			return -ENOMEM;
+		}
+	}
+
+	if (pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream) {
+		ret = ipq4019_pcm_preallocate_dma_buffer(pcm,
+				SNDRV_PCM_STREAM_CAPTURE);
+		if (ret) {
+			pr_err("%s: %d: Error allocating dma buf\n",
+						__func__, __LINE__);
+			ipq4019_pcm_free_dma_buffer(pcm,
+					SNDRV_PCM_STREAM_PLAYBACK);
+			return -ENOMEM;
+		}
+	}
+
+	return ret;
+}
+
+static struct snd_soc_platform_driver ipq4019_asoc_pcm_spdif_platform = {
+	.ops		= &ipq4019_asoc_pcm_spdif_ops,
+	.pcm_new	= ipq4019_asoc_pcm_spdif_new,
+	.pcm_free	= ipq4019_asoc_pcm_spdif_free,
+};
+
+static const struct of_device_id ipq4019_pcm_spdif_id_table[] = {
+	{ .compatible = "qca,ipq4019-pcm-spdif" },
+	{ /* Sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, ipq4019_pcm_spdif_id_table);
+
+static int ipq4019_pcm_spdif_driver_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	pr_debug("%s %d\n", __func__, __LINE__);
+	ret = snd_soc_register_platform(&pdev->dev,
+			&ipq4019_asoc_pcm_spdif_platform);
+	if (ret)
+		dev_err(&pdev->dev, "%s: Failed to register spdif pcm device\n",
+								__func__);
+	return ret;
+}
+
+static int ipq4019_pcm_spdif_driver_remove(struct platform_device *pdev)
+{
+	pr_debug("%s %d\n", __func__, __LINE__);
+	snd_soc_unregister_platform(&pdev->dev);
+
+	return 0;
+}
+
+static struct platform_driver ipq4019_pcm_spdif_driver = {
+	.probe = ipq4019_pcm_spdif_driver_probe,
+	.remove = ipq4019_pcm_spdif_driver_remove,
+	.driver = {
+		.name = "qca-pcm-spdif",
+		.owner = THIS_MODULE,
+		.of_match_table = ipq4019_pcm_spdif_id_table,
+	},
+};
+
+module_platform_driver(ipq4019_pcm_spdif_driver);
+
+MODULE_ALIAS("platform:qca-pcm-spdif");
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_DESCRIPTION("IPQ4019 PCM SPDIF Platform Driver");
diff --git a/sound/soc/qcom/ipq4019/ipq4019-pcm-tdm.c b/sound/soc/qcom/ipq4019/ipq4019-pcm-tdm.c
new file mode 100644
index 0000000..657a4a6
--- /dev/null
+++ b/sound/soc/qcom/ipq4019/ipq4019-pcm-tdm.c
@@ -0,0 +1,609 @@
+/*
+ * Copyright (c) 2015-2016, The Linux Foundation. All rights reserved.
+ *
+ * Permission to use, copy, modify, and/or distribute this software for any
+ * purpose with or without fee is hereby granted, provided that the above
+ * copyright notice and this permission notice appear in all copies.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
+ * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
+ * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
+ * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+ * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+ * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/time.h>
+#include <linux/wait.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/dma-mapping.h>
+#include <asm/dma.h>
+#include <sound/core.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/pcm.h>
+#include <sound/initval.h>
+#include <sound/control.h>
+#include <sound/pcm_params.h>
+
+#include "ipq4019-pcm.h"
+#include "ipq4019-adss.h"
+
+static struct snd_pcm_hardware ipq4019_pcm_hardware_playback = {
+	.info			=	SNDRV_PCM_INFO_MMAP |
+					SNDRV_PCM_INFO_BLOCK_TRANSFER |
+					SNDRV_PCM_INFO_MMAP_VALID |
+					SNDRV_PCM_INFO_INTERLEAVED |
+					SNDRV_PCM_INFO_PAUSE |
+					SNDRV_PCM_INFO_RESUME,
+	.formats		=	SNDRV_PCM_FMTBIT_S16 |
+					SNDRV_PCM_FMTBIT_S32,
+	.rates			=	RATE_16000_96000,
+	.rate_min		=	FREQ_16000,
+	.rate_max		=	FREQ_96000,
+	.channels_min		=	CH_STEREO,
+	.channels_max		=	CH_7_1,
+	.buffer_bytes_max	=	IPQ4019_TDM_BUFF_SIZE,
+	.period_bytes_max	=	IPQ4019_TDM_BUFF_SIZE / 2,
+	.period_bytes_min	=	IPQ4019_TDM_PERIOD_BYTES_MIN,
+	.periods_min		=	IPQ4019_TDM_NO_OF_PERIODS,
+	.periods_max		=	IPQ4019_TDM_NO_OF_PERIODS,
+	.fifo_size		=	0,
+};
+
+static struct snd_pcm_hardware ipq4019_pcm_hardware_capture = {
+	.info			=	SNDRV_PCM_INFO_MMAP |
+					SNDRV_PCM_INFO_BLOCK_TRANSFER |
+					SNDRV_PCM_INFO_MMAP_VALID |
+					SNDRV_PCM_INFO_INTERLEAVED,
+	.formats		=	SNDRV_PCM_FMTBIT_S16 |
+					SNDRV_PCM_FMTBIT_S32,
+	.rates			=	RATE_16000_96000,
+	.rate_min		=	FREQ_16000,
+	.rate_max		=	FREQ_96000,
+	.channels_min		=	CH_STEREO,
+	.channels_max		=	CH_7_1,
+	.buffer_bytes_max	=	IPQ4019_TDM_BUFF_SIZE,
+	.period_bytes_max	=	IPQ4019_TDM_BUFF_SIZE / 2,
+	.period_bytes_min	=	IPQ4019_TDM_PERIOD_BYTES_MIN,
+	.periods_min		=	IPQ4019_TDM_NO_OF_PERIODS,
+	.periods_max		=	IPQ4019_TDM_NO_OF_PERIODS,
+	.fifo_size		=	0,
+};
+
+static size_t ip4019_dma_buffer_size(struct snd_pcm_hardware *pcm_hw)
+{
+	return (pcm_hw->buffer_bytes_max +
+		(pcm_hw->periods_min * sizeof(struct ipq4019_mbox_desc)));
+}
+
+static struct device *ss2dev(struct snd_pcm_substream *substream)
+{
+	return substream->pcm->card->dev;
+}
+
+/*
+ * The MBOX descriptors and buffers should lie within the same 256MB
+ * region. Because, the buffer address pointer (in the descriptor structure)
+ * and descriptor base address pointer register share the same MSB 4 bits
+ * which is configured in MBOX DMA Policy register.
+ *
+ * Hence ensure that the entire allocated region falls in a 256MB region.
+ */
+static int ipq4019_mbox_buf_is_aligned(void *c_ptr, ssize_t size)
+{
+	u32 ptr = (u32)c_ptr;
+
+	return (ptr & 0xF0000000) == ((ptr + size - 1) & 0xF0000000);
+}
+
+static int ipq4019_pcm_preallocate_dma_buffer(struct snd_pcm *pcm,
+						int stream)
+{
+	struct snd_pcm_substream *substream = pcm->streams[stream].substream;
+	struct snd_pcm_hardware *pcm_hw = NULL;
+	struct snd_dma_buffer *buf = &substream->dma_buffer;
+	size_t size;
+	u8 *area;
+	dma_addr_t addr;
+
+	switch (substream->stream) {
+	case SNDRV_PCM_STREAM_PLAYBACK:
+		pcm_hw = &ipq4019_pcm_hardware_playback;
+		break;
+	case SNDRV_PCM_STREAM_CAPTURE:
+		pcm_hw = &ipq4019_pcm_hardware_capture;
+		break;
+	default:
+		dev_err(ss2dev(substream), "Invalid stream: %d\n",
+							substream->stream);
+		return -EINVAL;
+	}
+
+	size = ip4019_dma_buffer_size(pcm_hw);
+	buf->dev.type = SNDRV_DMA_TYPE_DEV;
+	buf->dev.dev = pcm->card->dev;
+	buf->private_data = NULL;
+
+	/*
+	 * |<--   buffers             -->|<-- desc  -->|
+	 * +----+----+----+----+----+----+-+-+-+-+-+-+-+
+	 * |    |    |    |    |    |    | | | | | | | |
+	 * |    |    |    |    |    |    | | | | | | | |
+	 * |    |    |    |    |    |    | | | | | | | |
+	 * |    |    |    |    |    |    | | | | | | | |
+	 * |    |    |    |    |    |    | | | | | | | |
+	 * +----+----+----+----+----+----+-+-+-+-+-+-+-+
+	 * ^    ^                        | |  . . .
+	 * |    |                        | |
+	 * +----|------------------------+ |
+	 *	+--------------------------+
+	 */
+
+	/*
+	 * Currently payload uses uncached memory.
+	 * TODO: Eventually we will move to cached memory for payload
+	 * and dma_map_single() will be used for Invalidating/Flushing
+	 * the buffers.
+	 */
+
+	area = dma_alloc_coherent(pcm->card->dev, size, &addr, GFP_KERNEL);
+
+	if (!area) {
+		dev_info(ss2dev(substream), "Alloc coherent memory failed\n");
+		return -ENOMEM;
+	}
+
+	if (!ipq4019_mbox_buf_is_aligned(area, size)) {
+		dev_info(ss2dev(substream),
+			 "First allocation %p not within 256M region\n", area);
+
+		buf->area = dma_alloc_coherent(pcm->card->dev, size,
+						&buf->addr, GFP_KERNEL);
+		/*
+		 * If we are here, the previously allocated buffer is not
+		 * usable for the driver. Have to free it anyway regardless
+		 * of the success/failure of the second allocation.
+		 */
+		dma_free_coherent(pcm->card->dev, size, area, addr);
+		if (!buf->area) {
+			dev_info(ss2dev(substream),
+				 "Second Alloc coherent memory failed\n");
+			return -ENOMEM;
+		}
+	} else {
+		buf->area = area;
+		buf->addr = addr;
+	}
+
+	buf->bytes = pcm_hw->buffer_bytes_max;
+
+	return 0;
+}
+
+static void ipq4019_pcm_free_dma_buffer(struct snd_pcm *pcm, int stream)
+{
+	struct snd_pcm_substream *substream;
+	struct snd_pcm_hardware *pcm_hw = NULL;
+	struct snd_dma_buffer *buf;
+	size_t size;
+
+	substream = pcm->streams[stream].substream;
+	buf = &substream->dma_buffer;
+
+	switch (stream) {
+	case SNDRV_PCM_STREAM_PLAYBACK:
+		pcm_hw = &ipq4019_pcm_hardware_playback;
+		break;
+	case SNDRV_PCM_STREAM_CAPTURE:
+		pcm_hw = &ipq4019_pcm_hardware_capture;
+		break;
+	}
+
+	size = ip4019_dma_buffer_size(pcm_hw);
+
+	dma_free_coherent(pcm->card->dev, size, buf->area, buf->addr);
+
+	buf->addr = 0;
+	buf->area = NULL;
+}
+
+static irqreturn_t ipq4019_pcm_irq(int intrsrc, void *data)
+{
+	struct snd_pcm_substream *substream = data;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct ipq4019_pcm_rt_priv *pcm_rtpriv =
+		(struct ipq4019_pcm_rt_priv *)runtime->private_data;
+
+	pcm_rtpriv->curr_pos =
+		ipq4019_mbox_get_played_offset(pcm_rtpriv->channel);
+
+	snd_pcm_period_elapsed(substream);
+
+	return IRQ_HANDLED;
+}
+
+static snd_pcm_uframes_t ipq4019_pcm_tdm_pointer(
+				struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct ipq4019_pcm_rt_priv *pcm_rtpriv;
+	snd_pcm_uframes_t ret;
+
+	pcm_rtpriv = runtime->private_data;
+
+	ret = bytes_to_frames(runtime, pcm_rtpriv->curr_pos);
+	return ret;
+}
+
+static int ipq4019_pcm_tdm_copy(struct snd_pcm_substream *substream, int chan,
+				snd_pcm_uframes_t hwoff, void __user *ubuf,
+				snd_pcm_uframes_t frames)
+{
+	struct snd_dma_buffer *buf = &substream->dma_buffer;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct ipq4019_pcm_rt_priv *pcm_rtpriv = runtime->private_data;
+	char *hwbuf;
+	u32 offset, size;
+
+	offset = frames_to_bytes(runtime, hwoff);
+	size = frames_to_bytes(runtime, frames);
+
+	hwbuf = buf->area + offset;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		if (copy_from_user(hwbuf, ubuf, size))
+			return -EFAULT;
+	} else if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
+		if (copy_to_user(ubuf, hwbuf, size))
+			return -EFAULT;
+	}
+
+	ipq4019_mbox_desc_own(pcm_rtpriv->channel, offset / size, 1);
+
+	ipq4019_mbox_dma_resume(pcm_rtpriv->channel);
+
+	return 0;
+}
+
+static int ipq4019_pcm_tdm_mmap(struct snd_pcm_substream *substream,
+				struct vm_area_struct *vma)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	return dma_mmap_coherent(substream->pcm->card->dev, vma,
+		runtime->dma_area, runtime->dma_addr, runtime->dma_bytes);
+}
+
+static int ipq4019_pcm_hw_free(struct snd_pcm_substream *substream)
+{
+	snd_pcm_set_runtime_buffer(substream, NULL);
+	return 0;
+}
+
+
+static int ipq4019_pcm_tdm_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct ipq4019_pcm_rt_priv *pcm_rtpriv;
+
+	uint32_t ret;
+
+	pcm_rtpriv = runtime->private_data;
+	ret = ipq4019_mbox_dma_prepare(pcm_rtpriv->channel);
+	if (ret) {
+		pr_err("%s: %d: Error in dma prepare : channel : %d\n",
+				__func__, __LINE__, pcm_rtpriv->channel);
+		ipq4019_mbox_dma_release(pcm_rtpriv->channel);
+		return ret;
+	}
+
+	/* Set the ownership bits */
+	ipq4019_mbox_get_elapsed_size(pcm_rtpriv->channel);
+
+	pcm_rtpriv->last_played = NULL;
+
+	return ret;
+}
+
+static int ipq4019_pcm_tdm_close(struct snd_pcm_substream *substream)
+{
+	struct ipq4019_pcm_rt_priv *pcm_rtpriv;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *dai = rtd->cpu_dai;
+	u32 intf = dai->driver->id;
+	uint32_t ret;
+
+	ipq4019_stereo_config_enable(DISABLE,
+				ipq4019_get_stereo_id(substream, intf));
+
+	pcm_rtpriv = substream->runtime->private_data;
+	if (!pcm_rtpriv)
+		return -EINVAL;
+
+	ret = ipq4019_mbox_dma_release(pcm_rtpriv->channel);
+	if (ret) {
+		pr_err("%s: %d: Error in dma release\n",
+					__func__, __LINE__);
+	}
+
+	kfree(pcm_rtpriv);
+
+	return 0;
+}
+
+static int ipq4019_pcm_tdm_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	int ret;
+	u32 desc_duration;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct ipq4019_pcm_rt_priv *pcm_rtpriv =
+				substream->runtime->private_data;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+
+		ret = ipq4019_mbox_dma_start(pcm_rtpriv->channel);
+		if (ret) {
+			pr_err("%s: %d: Error in dma start\n",
+				__func__, __LINE__);
+			ipq4019_mbox_dma_release(pcm_rtpriv->channel);
+		}
+		break;
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		ret = ipq4019_mbox_dma_resume(pcm_rtpriv->channel);
+		if (ret) {
+			pr_err("%s: %d: Error in dma resume\n",
+				__func__, __LINE__);
+			ipq4019_mbox_dma_release(pcm_rtpriv->channel);
+		}
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		/*
+		 * For e.g. the number of bytes needed to represent 1 second
+		 * worth of audio data for sampling frequency, bit width, stereo
+		 * combination of 16KHz, 32-bits and stereo, the calculation is
+		 * as follows
+		 *
+		 * For 1 second,
+		 *	16KHz * 32 bits * 2 (left & right channel of stereo)
+		 *	= 16000 * 4 bytes * 2
+		 *	= 128000 bytes
+		 *
+		 * Hence the duration will be
+		 *	desc_buffer_size_in_bytes / 128000 * 1 sec
+		 */
+		desc_duration =
+			frames_to_bytes(runtime, runtime->period_size) * 1000 /
+				(runtime->rate *
+				 DIV_ROUND_UP(runtime->sample_bits, 8) *
+				 runtime->channels);
+
+		ret = ipq4019_mbox_dma_stop(pcm_rtpriv->channel, desc_duration);
+		if (ret) {
+			pr_err("%s: %d: Error in dma stop\n",
+				__func__, __LINE__);
+			ipq4019_mbox_dma_release(pcm_rtpriv->channel);
+		}
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	return ret;
+}
+
+static int ipq4019_pcm_tdm_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *hw_params)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct ipq4019_pcm_rt_priv *pcm_rtpriv;
+	int ret;
+	unsigned int period_size, sample_size, sample_rate, frames, channels;
+
+	pr_debug("%s %d\n", __func__, __LINE__);
+
+	pcm_rtpriv = runtime->private_data;
+
+	ret = ipq4019_mbox_form_ring(pcm_rtpriv->channel,
+			substream->dma_buffer.addr,
+			substream->dma_buffer.area,
+			params_period_bytes(hw_params),
+			params_buffer_bytes(hw_params),
+			(substream->stream == SNDRV_PCM_STREAM_CAPTURE));
+	if (ret) {
+		pr_err("%s: %d: Error dma form ring\n", __func__, __LINE__);
+		ipq4019_mbox_dma_release(pcm_rtpriv->channel);
+		return ret;
+	}
+
+	period_size = params_period_bytes(hw_params);
+	sample_size = snd_pcm_format_size(params_format(hw_params), 1);
+	sample_rate = params_rate(hw_params);
+	channels = params_channels(hw_params);
+	frames = period_size / (sample_size * channels);
+
+	pcm_rtpriv->period_size = params_period_bytes(hw_params);
+
+	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
+
+	runtime->dma_bytes = params_buffer_bytes(hw_params);
+	return ret;
+}
+
+static int ipq4019_pcm_tdm_open(struct snd_pcm_substream *substream)
+{
+	int ret;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct ipq4019_pcm_rt_priv *pcm_rtpriv;
+
+	pr_debug("%s %d\n", __func__, __LINE__);
+
+	pcm_rtpriv = kmalloc(sizeof(struct ipq4019_pcm_rt_priv), GFP_KERNEL);
+
+	if (!pcm_rtpriv)
+		return -ENOMEM;
+
+	snd_printd("%s: 0x%xB allocated at 0x%08x\n",
+			__func__, sizeof(*pcm_rtpriv), (u32) pcm_rtpriv);
+	pcm_rtpriv->last_played = NULL;
+	pcm_rtpriv->dev = substream->pcm->card->dev;
+	pcm_rtpriv->channel = ipq4019_get_mbox_id(substream, TDM);
+	pcm_rtpriv->curr_pos = 0;
+	pcm_rtpriv->mmap_flag = 0;
+	substream->runtime->private_data = pcm_rtpriv;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		runtime->dma_bytes =
+			ipq4019_pcm_hardware_playback.buffer_bytes_max;
+		snd_soc_set_runtime_hwparams(substream,
+				&ipq4019_pcm_hardware_playback);
+	} else if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
+		runtime->dma_bytes =
+				ipq4019_pcm_hardware_capture.buffer_bytes_max;
+		snd_soc_set_runtime_hwparams(substream,
+					&ipq4019_pcm_hardware_capture);
+
+	} else {
+		pr_err("%s: Invalid stream\n", __func__);
+		ret = -EINVAL;
+		goto error;
+	}
+	ret = ipq4019_mbox_dma_init(pcm_rtpriv->dev,
+		pcm_rtpriv->channel, ipq4019_pcm_irq, substream);
+	if (ret) {
+		pr_err("%s: %d: Error initializing dma\n",
+					__func__, __LINE__);
+		goto error;
+	}
+
+	ret = snd_pcm_hw_constraint_integer(runtime,
+			SNDRV_PCM_HW_PARAM_PERIODS);
+	if (ret < 0) {
+		pr_err("%s: snd_pcm_hw_constraint_integer failed\n", __func__);
+		ipq4019_mbox_dma_release(pcm_rtpriv->channel);
+		goto error;
+	}
+
+	return 0;
+error:
+	kfree(pcm_rtpriv);
+	return ret;
+}
+
+static struct snd_pcm_ops ipq4019_asoc_pcm_tdm_ops = {
+	.open		= ipq4019_pcm_tdm_open,
+	.hw_params	= ipq4019_pcm_tdm_hw_params,
+	.hw_free	= ipq4019_pcm_hw_free,
+	.trigger	= ipq4019_pcm_tdm_trigger,
+	.ioctl		= snd_pcm_lib_ioctl,
+	.close		= ipq4019_pcm_tdm_close,
+	.prepare	= ipq4019_pcm_tdm_prepare,
+	.mmap		= ipq4019_pcm_tdm_mmap,
+	.pointer	= ipq4019_pcm_tdm_pointer,
+	.copy		= ipq4019_pcm_tdm_copy,
+};
+
+static void ipq4019_asoc_pcm_tdm_free(struct snd_pcm *pcm)
+{
+	ipq4019_pcm_free_dma_buffer(pcm, SNDRV_PCM_STREAM_PLAYBACK);
+	ipq4019_pcm_free_dma_buffer(pcm, SNDRV_PCM_STREAM_CAPTURE);
+}
+
+static int ipq4019_asoc_pcm_tdm_new(struct snd_soc_pcm_runtime *prtd)
+{
+	struct snd_card *card = prtd->card->snd_card;
+	struct snd_pcm *pcm = prtd->pcm;
+
+	int ret = 0;
+
+	if (!card->dev->coherent_dma_mask)
+		card->dev->coherent_dma_mask = DMA_BIT_MASK(32);
+
+	if (!card->dev->dma_mask)
+		card->dev->dma_mask = &card->dev->coherent_dma_mask;
+
+	if (pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream) {
+		ret = ipq4019_pcm_preallocate_dma_buffer(pcm,
+				SNDRV_PCM_STREAM_PLAYBACK);
+
+		if (ret) {
+			pr_err("%s: %d: Error allocating dma buf\n",
+						__func__, __LINE__);
+			return -ENOMEM;
+		}
+	}
+
+	if (pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream) {
+		ret = ipq4019_pcm_preallocate_dma_buffer(pcm,
+				SNDRV_PCM_STREAM_CAPTURE);
+		if (ret) {
+			pr_err("%s: %d: Error allocating dma buf\n",
+						__func__, __LINE__);
+			ipq4019_pcm_free_dma_buffer(pcm,
+					SNDRV_PCM_STREAM_PLAYBACK);
+			return -ENOMEM;
+		}
+	}
+
+	return ret;
+}
+
+static struct snd_soc_platform_driver ipq4019_asoc_pcm_tdm_platform = {
+	.ops		= &ipq4019_asoc_pcm_tdm_ops,
+	.pcm_new	= ipq4019_asoc_pcm_tdm_new,
+	.pcm_free	= ipq4019_asoc_pcm_tdm_free,
+};
+
+static const struct of_device_id ipq4019_pcm_tdm_id_table[] = {
+	{ .compatible = "qca,ipq4019-pcm-tdm" },
+	{ /* Sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, ipq4019_pcm_tdm_id_table);
+
+static int ipq4019_pcm_tdm_driver_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	pr_debug("%s %d\n", __func__, __LINE__);
+	ret = snd_soc_register_platform(&pdev->dev,
+			&ipq4019_asoc_pcm_tdm_platform);
+	if (ret)
+		dev_err(&pdev->dev, "%s: Failed to register tdm pcm device\n",
+								__func__);
+	return ret;
+}
+
+static int ipq4019_pcm_tdm_driver_remove(struct platform_device *pdev)
+{
+	pr_debug("%s %d\n", __func__, __LINE__);
+	snd_soc_unregister_platform(&pdev->dev);
+
+	return 0;
+}
+
+static struct platform_driver ipq4019_pcm_tdm_driver = {
+	.probe = ipq4019_pcm_tdm_driver_probe,
+	.remove = ipq4019_pcm_tdm_driver_remove,
+	.driver = {
+		.name = "qca-pcm-tdm",
+		.owner = THIS_MODULE,
+		.of_match_table = ipq4019_pcm_tdm_id_table,
+	},
+};
+
+module_platform_driver(ipq4019_pcm_tdm_driver);
+
+MODULE_ALIAS("platform:qca-pcm-tdm");
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_DESCRIPTION("IPQ4019 PCM TDM Platform Driver");
diff --git a/sound/soc/qcom/ipq4019/ipq4019-pcm.h b/sound/soc/qcom/ipq4019/ipq4019-pcm.h
new file mode 100644
index 0000000..0c467d6
--- /dev/null
+++ b/sound/soc/qcom/ipq4019/ipq4019-pcm.h
@@ -0,0 +1,37 @@
+/*
+ * Copyright (c) 2015, The Linux Foundation. All rights reserved.
+ *
+ * Permission to use, copy, modify, and/or distribute this software for any
+ * purpose with or without fee is hereby granted, provided that the above
+ * copyright notice and this permission notice appear in all copies.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
+ * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
+ * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
+ * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+ * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+ * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+ */
+
+#ifndef _IPQ40XX_PCM_H_
+#define _IPQ40XX_PCM_H_
+
+#include <linux/sound.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/interrupt.h>
+
+#include "ipq4019-mbox.h"
+
+struct ipq4019_pcm_rt_priv {
+	int channel;
+	struct device *dev;
+	struct ipq4019_mbox_desc *last_played;
+	unsigned int processed_size;
+	uint32_t period_size;
+	uint32_t curr_pos;
+	int mmap_flag;
+};
+
+#endif /* _IPQ40XX_PCM_H_ */
diff --git a/sound/soc/qcom/ipq4019/ipq4019-stereo.c b/sound/soc/qcom/ipq4019/ipq4019-stereo.c
new file mode 100644
index 0000000..52e0c29
--- /dev/null
+++ b/sound/soc/qcom/ipq4019/ipq4019-stereo.c
@@ -0,0 +1,313 @@
+/*
+ * Copyright (c) 2015-2016, The Linux Foundation. All rights reserved.
+ *
+ * Permission to use, copy, modify, and/or distribute this software for any
+ * purpose with or without fee is hereby granted, provided that the above
+ * copyright notice and this permission notice appear in all copies.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
+ * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
+ * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
+ * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+ * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+ * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/pcm_params.h>
+#include <linux/delay.h>
+#include <linux/spinlock.h>
+
+#include "ipq4019-adss.h"
+
+struct stereo_priv_data {
+	void __iomem *stereo_base;
+	spinlock_t stereo_lock;
+};
+
+static struct stereo_priv_data stereo_priv[MAX_STEREO_ENTRIES];
+
+/*
+ *
+ * Stereo buffers and I2S state reset
+ */
+void ipq4019_stereo_config_reset(u32 reset, u32 stereo_id)
+{
+	u32 cfg;
+	unsigned long flags;
+
+	spin_lock_irqsave(&stereo_priv[stereo_id].stereo_lock, flags);
+	cfg = readl(stereo_priv[stereo_id].stereo_base
+			+ ADSS_STEREOn_STEREO0_CONFIG_REG);
+	cfg &= ~STEREOn_CONFIG_RESET;
+	if (reset)
+		cfg |= STEREOn_CONFIG_RESET;
+	writel(cfg, stereo_priv[stereo_id].stereo_base
+			+ ADSS_STEREOn_STEREO0_CONFIG_REG);
+	spin_unlock_irqrestore(&stereo_priv[stereo_id].stereo_lock, flags);
+}
+EXPORT_SYMBOL(ipq4019_stereo_config_reset);
+
+/*
+ * MIC buffers reset
+ */
+void ipq4019_stereo_config_mic_reset(u32 reset, u32 stereo_id)
+{
+	u32 cfg;
+	unsigned long flags;
+
+	spin_lock_irqsave(&stereo_priv[stereo_id].stereo_lock, flags);
+	cfg = readl(stereo_priv[stereo_id].stereo_base
+			+ ADSS_STEREOn_STEREO0_CONFIG_REG);
+	cfg &= ~STEREOn_CONFIG_MIC_RESET;
+	if (reset)
+		cfg |= STEREOn_CONFIG_MIC_RESET;
+	writel(cfg, stereo_priv[stereo_id].stereo_base
+			+ ADSS_STEREOn_STEREO0_CONFIG_REG);
+	spin_unlock_irqrestore(&stereo_priv[stereo_id].stereo_lock, flags);
+}
+EXPORT_SYMBOL(ipq4019_stereo_config_mic_reset);
+
+/*
+ * Enable the I2S Stereo block for operation
+ */
+void ipq4019_stereo_config_enable(u32 enable, u32 stereo_id)
+{
+	u32 cfg;
+	unsigned long flags;
+
+	spin_lock_irqsave(&stereo_priv[stereo_id].stereo_lock, flags);
+	cfg = readl(stereo_priv[stereo_id].stereo_base
+			+ ADSS_STEREOn_STEREO0_CONFIG_REG);
+	cfg &= ~STEREOn_CONFIG_ENABLE;
+	if (enable)
+		cfg |= STEREOn_CONFIG_ENABLE;
+	writel(cfg, stereo_priv[stereo_id].stereo_base
+			+ ADSS_STEREOn_STEREO0_CONFIG_REG);
+	spin_unlock_irqrestore(&stereo_priv[stereo_id].stereo_lock, flags);
+}
+EXPORT_SYMBOL(ipq4019_stereo_config_enable);
+
+/*
+ * Enable the SPDIF Stereo block for operation
+ */
+void ipq4019_stereo_spdif_enable(uint32_t enable, uint32_t stereo_id)
+{
+	uint32_t cfg;
+
+	cfg = readl(stereo_priv[stereo_id].stereo_base
+			+ ADSS_STEREOn_STEREO0_CONFIG_REG);
+	cfg &= ~(STEREOn_CONFIG_SPDIF_ENABLE);
+	if (enable)
+		cfg |= STEREOn_CONFIG_SPDIF_ENABLE;
+	writel(cfg, stereo_priv[stereo_id].stereo_base
+			+ ADSS_STEREOn_STEREO0_CONFIG_REG);
+}
+EXPORT_SYMBOL(ipq4019_stereo_spdif_enable);
+
+/*
+ * Enable/disable the swap within PCM sample
+ */
+void ipq4019_stereo_spdif_pcmswap(uint32_t enable, uint32_t stereo_id)
+{
+	uint32_t cfg;
+
+	cfg = readl(stereo_priv[stereo_id].stereo_base
+		+ ADSS_STEREOn_STEREO0_CONFIG_REG);
+
+	cfg &= ~(STEREOn_CONFIG_PCM_SWAP);
+	if (enable)
+		cfg |= STEREOn_CONFIG_PCM_SWAP;
+
+	writel(cfg, stereo_priv[stereo_id].stereo_base
+		+ ADSS_STEREOn_STEREO0_CONFIG_REG);
+}
+EXPORT_SYMBOL(ipq4019_stereo_spdif_pcmswap);
+
+/* Configure
+ * Data word size : Word size loaded into the PCM
+ *			register from the MBOX FIFO.
+ * I2S word size : Word size sent to the external I2S DAC.
+ *			When set to 32 bit words the PCM data
+ *			will be left justified in the I2S word.
+ */
+int ipq4019_cfg_bit_width(u32 bit_width, u32 stereo_id)
+{
+	u32 cfg, mask = 0;
+	unsigned long flags;
+
+	switch (bit_width) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+	case SNDRV_PCM_FORMAT_S16_BE:
+		mask |= (STEREOn_CONFIG_DATA_WORD_SIZE(1) |
+			STEREOn_CONFIG_I2S_WORD_SIZE_16 |
+			STEREOn_CONFIG_MIC_WORD_SIZE_16);
+		break;
+	case SNDRV_PCM_FORMAT_S24_3LE:
+	case SNDRV_PCM_FORMAT_S24_3BE:
+		mask |= (STEREOn_CONFIG_DATA_WORD_SIZE(2) |
+			STEREOn_CONFIG_I2S_WORD_SIZE_32 |
+			STEREOn_CONFIG_MIC_WORD_SIZE_16);
+		break;
+	case SNDRV_PCM_FORMAT_S32_LE:
+	case SNDRV_PCM_FORMAT_S32_BE:
+		mask |= (STEREOn_CONFIG_DATA_WORD_SIZE(3) |
+			STEREOn_CONFIG_I2S_WORD_SIZE_32 |
+			STEREOn_CONFIG_MIC_WORD_SIZE_32);
+		break;
+	default:
+		return -ENOTSUPP;
+	}
+
+	spin_lock_irqsave(&stereo_priv[stereo_id].stereo_lock, flags);
+	cfg = readl(stereo_priv[stereo_id].stereo_base
+			+ ADSS_STEREOn_STEREO0_CONFIG_REG);
+	cfg &= ~STEREOn_CONFIG_DATA_WORD_SIZE_MASK;
+	cfg &= ~STEREOn_CONFIG_I2S_WORD_SIZE_32;
+	cfg &= ~STEREOn_CONFIG_MIC_WORD_SIZE_32;
+	cfg |= mask;
+	writel(cfg, stereo_priv[stereo_id].stereo_base
+			+ ADSS_STEREOn_STEREO0_CONFIG_REG);
+	spin_unlock_irqrestore(&stereo_priv[stereo_id].stereo_lock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL(ipq4019_cfg_bit_width);
+
+/*
+ * Configure stereo/mono mode
+ */
+void ipq4019_config_stereo_mode(u32 mode, u32 stereo_id)
+{
+	u32 cfg;
+	unsigned long flags;
+
+	spin_lock_irqsave(&stereo_priv[stereo_id].stereo_lock, flags);
+	cfg = readl(stereo_priv[stereo_id].stereo_base
+			+ ADSS_STEREOn_STEREO0_CONFIG_REG);
+	cfg &= ~STEREOn_CONFIG_STEREO_MONO_MASK;
+	if (mode == CH_STEREO)
+		cfg |= STEREOn_CONFIG_STEREO_MODE;
+	writel(cfg, stereo_priv[stereo_id].stereo_base
+			+ ADSS_STEREOn_STEREO0_CONFIG_REG);
+	spin_unlock_irqrestore(&stereo_priv[stereo_id].stereo_lock, flags);
+}
+EXPORT_SYMBOL(ipq4019_config_stereo_mode);
+
+/*
+ * Configure master mode
+ */
+void ipq4019_config_master(u32 enable, u32 stereo_id)
+{
+	u32 cfg;
+	unsigned long flags;
+
+	spin_lock_irqsave(&stereo_priv[stereo_id].stereo_lock, flags);
+	cfg = readl(stereo_priv[stereo_id].stereo_base
+			+ ADSS_STEREOn_STEREO0_CONFIG_REG);
+	cfg &= ~STEREOn_CONFIG_MASTER;
+	if (enable)
+		cfg |= STEREOn_CONFIG_MASTER;
+	writel(cfg, stereo_priv[stereo_id].stereo_base
+			+ ADSS_STEREOn_STEREO0_CONFIG_REG);
+	spin_unlock_irqrestore(&stereo_priv[stereo_id].stereo_lock, flags);
+}
+EXPORT_SYMBOL(ipq4019_config_master);
+
+/* Selects the raw clock source between
+ * divided audio clock and input master clock
+ * Val 0: Raw master clock is divided audio PLL clock
+ * Val 1: Raw master clock is MCLK IN
+ */
+void ipq4019_config_mclk_sel(u32 stereo_id, u32 val)
+{
+	u32 cfg;
+	unsigned long flags;
+
+	spin_lock_irqsave(&stereo_priv[stereo_id].stereo_lock, flags);
+	cfg = readl(stereo_priv[stereo_id].stereo_base
+			+ ADSS_STEREOn_STEREO0_CONFIG_REG);
+	cfg &= ~STEREOn_CONFIG_MCK_SEL;
+	cfg |= val;
+	writel(cfg, stereo_priv[stereo_id].stereo_base
+			+ ADSS_STEREOn_STEREO0_CONFIG_REG);
+	spin_unlock_irqrestore(&stereo_priv[stereo_id].stereo_lock, flags);
+
+}
+EXPORT_SYMBOL(ipq4019_config_mclk_sel);
+
+/*
+ * Strategy to clear the sample counter TX and RX registers
+ */
+void ipq4019_config_sample_cnt_clear_type(u32 stereo_id)
+{
+	u32 cfg;
+	unsigned long flags;
+
+	spin_lock_irqsave(&stereo_priv[stereo_id].stereo_lock, flags);
+	cfg = readl(stereo_priv[stereo_id].stereo_base
+			+ ADSS_STEREOn_STEREO0_CONFIG_REG);
+	/* 0 - write an explicit zero data through software
+	 *	to the TX and RX sample counter registers
+	 * 1 - software read of the TX and RX sample counter
+	 *	registers clears the counter registers
+	 */
+	cfg |= STEREOn_CONFIG_SAMPLE_CNT_CLEAR_TYPE; /* Write 1 */
+	writel(cfg, stereo_priv[stereo_id].stereo_base
+			+ ADSS_STEREOn_STEREO0_CONFIG_REG);
+	spin_unlock_irqrestore(&stereo_priv[stereo_id].stereo_lock, flags);
+}
+EXPORT_SYMBOL(ipq4019_config_sample_cnt_clear_type);
+
+static const struct of_device_id ipq4019_audio_stereo_id_table[] = {
+	{ .compatible = "qca,ipq4019-stereo" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ipq4019_audio_stereo_id_table);
+
+static int ipq4019_audio_stereo_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	struct stereo_priv_data *spd;
+	struct device_node *np = pdev->dev.of_node;
+	u32 stereo_port_id = 0;
+
+	if (of_property_read_u32(np, "stereo-index", &stereo_port_id)) {
+		dev_err(&pdev->dev, "Error reading stereo-index\n");
+		return -EINVAL;
+	}
+	if (stereo_port_id >= MAX_STEREO_ENTRIES)
+		return -ENODEV;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	spd = &stereo_priv[stereo_port_id];
+	spd->stereo_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(spd->stereo_base))
+		return PTR_ERR(spd->stereo_base);
+
+	spin_lock_init(&spd->stereo_lock);
+	return 0;
+}
+
+static struct platform_driver ipq4019_audio_stereo_driver = {
+	.probe = ipq4019_audio_stereo_probe,
+	.driver = {
+		.name = "ipq4019-stereo",
+		.of_match_table = ipq4019_audio_stereo_id_table,
+	},
+};
+
+module_platform_driver(ipq4019_audio_stereo_driver);
+
+MODULE_ALIAS("platform:ipq4019-stereo");
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_DESCRIPTION("IPQ4019 AUDIO Stereo driver");
diff --git a/sound/soc/qcom/ipq4019/ipq4019.c b/sound/soc/qcom/ipq4019/ipq4019.c
new file mode 100644
index 0000000..a08fa5e6
--- /dev/null
+++ b/sound/soc/qcom/ipq4019/ipq4019.c
@@ -0,0 +1,121 @@
+/*
+ * Copyright (c) 2015-2016, The Linux Foundation. All rights reserved.
+ *
+ * Permission to use, copy, modify, and/or distribute this software for any
+ * purpose with or without fee is hereby granted, provided that the above
+ * copyright notice and this permission notice appear in all copies.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
+ * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
+ * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
+ * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+ * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+ * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/gpio.h>
+#include <linux/platform_device.h>
+#include <linux/of_platform.h>
+#include <linux/gpio.h>
+#include <linux/slab.h>
+#include <sound/core.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/pcm.h>
+#include <sound/jack.h>
+#include <linux/io.h>
+
+static struct snd_soc_dai_link ipq4019_snd_dai[] = {
+	{
+		.name		= "IPQ4019 Media1",
+		.stream_name	= "I2S",
+		/* CPU DAI Name */
+		.cpu_dai_name	= "qca-i2s-dai",
+		/* Platform Driver Name */
+		.platform_name	= "7709000.qca-pcm-i2s",
+		/* Codec DAI Name */
+		.codec_dai_name	= "qca-i2s-codec-dai",
+		/*Codec Driver Name */
+		.codec_name	= "qca_codec.0-0012",
+		.dai_fmt = (SND_SOC_DAIFMT_I2S |
+				SND_SOC_DAIFMT_NB_NF |
+				SND_SOC_DAIFMT_CBS_CFS),
+	},
+	{
+		.name		= "IPQ4019 Media2",
+		.stream_name	= "TDM",
+		.cpu_dai_name	= "qca-tdm-dai",
+		.platform_name	= "7709000.qca-pcm-tdm",
+		.codec_dai_name	= "qca-tdm-codec-dai",
+		.codec_name	= "qca_codec.0-0012",
+	},
+	{
+		.name		= "IPQ4019 Media3",
+		.stream_name	= "I2S1",
+		.cpu_dai_name	= "qca-i2s1-dai",
+		.platform_name	= "770b000.qca-pcm-i2s1",
+		.codec_dai_name	= "qca-i2s1-codec-dai",
+		.codec_name	= "qca_codec.0-0012",
+	},
+	{
+		.name		= "IPQ4019 Media4",
+		.stream_name	= "I2S2",
+		.cpu_dai_name	= "qca-i2s2-dai",
+		.platform_name	= "770d000.qca-pcm-i2s2",
+		.codec_dai_name	= "qca-i2s2-codec-dai",
+		.codec_name	= "qca_codec.0-0012",
+	},
+	{
+		.name           = "IPQ4019 Media5",
+		.stream_name    = "SPDIF",
+		.cpu_dai_name	= "qca-spdif-dai",
+		.platform_name  = "7707000.qca-pcm-spdif",
+		.codec_dai_name = "qca-spdif-codec-dai",
+		.codec_name	= "qca_codec.0-0012",
+	},
+};
+
+static struct snd_soc_card snd_soc_card_qca = {
+	.name		= "ipq4019_snd_card",
+	.dai_link	= ipq4019_snd_dai,
+	.num_links	= ARRAY_SIZE(ipq4019_snd_dai),
+};
+
+static const struct of_device_id ipq4019_audio_id_table[] = {
+	{ .compatible = "qca,ipq4019-audio" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ipq4019_audio_id_table);
+
+static int ipq4019_audio_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct snd_soc_card *card = &snd_soc_card_qca;
+
+	card->dev = &pdev->dev;
+
+	ret = devm_snd_soc_register_card(&pdev->dev, card);
+	if (ret)
+		dev_err(&pdev->dev, "snd_soc_register_card() failed:%d\n", ret);
+
+	return ret;
+}
+
+static struct platform_driver ipq4019_audio_driver = {
+	.driver = {
+		.name = "ipq4019_audio",
+		.of_match_table = ipq4019_audio_id_table,
+	},
+	.probe = ipq4019_audio_probe,
+};
+
+module_platform_driver(ipq4019_audio_driver);
+
+MODULE_ALIAS("platform:ipq4019_audio");
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_DESCRIPTION("ALSA SoC IPQ4019 Machine Driver");
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

