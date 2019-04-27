From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: Intel: Add Intel specific HDA DSP
	HW operations" to the asoc tree
Date: Sat, 27 Apr 2019 18:52:47 +0100 (BST)
Message-ID: <20190427175251.93C70441D3B@finisterre.ee.mobilebroadband>
References: <20190412160904.30418-7-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20190412160904.30418-7-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
Cc: Dragos Tarcatu <dragos_tarcatu@mentor.com>, Daniel Baluta <daniel.baluta@gmail.com>, sound-open-firmware@alsa-project.org, tiwai@suse.de, Keyon Jie <yang.jie@linux.intel.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, Mark Brown <broonie@kernel.org>, andriy.shevchenko@linux.intel.com, Alan Cox <alan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: SOF: Intel: Add Intel specific HDA DSP HW operations

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.2

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 747503b1813a3e6e4c52d9c0b4bd462b64940940 Mon Sep 17 00:00:00 2001
From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Date: Fri, 12 Apr 2019 11:08:49 -0500
Subject: [PATCH] ASoC: SOF: Intel: Add Intel specific HDA DSP HW operations

Add support for various PM and core reset/run state transitions.

Signed-off-by: Keyon Jie <yang.jie@linux.intel.com>
Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/intel/hda-dsp.c | 455 ++++++++++++++++++++++++++++++++++
 1 file changed, 455 insertions(+)
 create mode 100644 sound/soc/sof/intel/hda-dsp.c

diff --git a/sound/soc/sof/intel/hda-dsp.c b/sound/soc/sof/intel/hda-dsp.c
new file mode 100644
index 000000000000..311fed502e09
--- /dev/null
+++ b/sound/soc/sof/intel/hda-dsp.c
@@ -0,0 +1,455 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+//
+// This file is provided under a dual BSD/GPLv2 license.  When using or
+// redistributing this file, you may do so under either license.
+//
+// Copyright(c) 2018 Intel Corporation. All rights reserved.
+//
+// Authors: Liam Girdwood <liam.r.girdwood@linux.intel.com>
+//	    Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
+//	    Rander Wang <rander.wang@intel.com>
+//          Keyon Jie <yang.jie@linux.intel.com>
+//
+
+/*
+ * Hardware interface for generic Intel audio DSP HDA IP
+ */
+
+#include <sound/hdaudio_ext.h>
+#include <sound/hda_register.h>
+#include "../ops.h"
+#include "hda.h"
+
+/*
+ * DSP Core control.
+ */
+
+int hda_dsp_core_reset_enter(struct snd_sof_dev *sdev, unsigned int core_mask)
+{
+	u32 adspcs;
+	u32 reset;
+	int ret;
+
+	/* set reset bits for cores */
+	reset = HDA_DSP_ADSPCS_CRST_MASK(core_mask);
+	snd_sof_dsp_update_bits_unlocked(sdev, HDA_DSP_BAR,
+					 HDA_DSP_REG_ADSPCS,
+					 reset, reset),
+
+	/* poll with timeout to check if operation successful */
+	ret = snd_sof_dsp_read_poll_timeout(sdev, HDA_DSP_BAR,
+					HDA_DSP_REG_ADSPCS, adspcs,
+					((adspcs & reset) == reset),
+					HDA_DSP_REG_POLL_INTERVAL_US,
+					HDA_DSP_RESET_TIMEOUT_US);
+
+	/* has core entered reset ? */
+	adspcs = snd_sof_dsp_read(sdev, HDA_DSP_BAR,
+				  HDA_DSP_REG_ADSPCS);
+	if ((adspcs & HDA_DSP_ADSPCS_CRST_MASK(core_mask)) !=
+		HDA_DSP_ADSPCS_CRST_MASK(core_mask)) {
+		dev_err(sdev->dev,
+			"error: reset enter failed: core_mask %x adspcs 0x%x\n",
+			core_mask, adspcs);
+		ret = -EIO;
+	}
+
+	return ret;
+}
+
+int hda_dsp_core_reset_leave(struct snd_sof_dev *sdev, unsigned int core_mask)
+{
+	unsigned int crst;
+	u32 adspcs;
+	int ret;
+
+	/* clear reset bits for cores */
+	snd_sof_dsp_update_bits_unlocked(sdev, HDA_DSP_BAR,
+					 HDA_DSP_REG_ADSPCS,
+					 HDA_DSP_ADSPCS_CRST_MASK(core_mask),
+					 0);
+
+	/* poll with timeout to check if operation successful */
+	crst = HDA_DSP_ADSPCS_CRST_MASK(core_mask);
+	ret = snd_sof_dsp_read_poll_timeout(sdev, HDA_DSP_BAR,
+					    HDA_DSP_REG_ADSPCS, adspcs,
+					    !(adspcs & crst),
+					    HDA_DSP_REG_POLL_INTERVAL_US,
+					    HDA_DSP_RESET_TIMEOUT_US);
+
+	/* has core left reset ? */
+	adspcs = snd_sof_dsp_read(sdev, HDA_DSP_BAR,
+				  HDA_DSP_REG_ADSPCS);
+	if ((adspcs & HDA_DSP_ADSPCS_CRST_MASK(core_mask)) != 0) {
+		dev_err(sdev->dev,
+			"error: reset leave failed: core_mask %x adspcs 0x%x\n",
+			core_mask, adspcs);
+		ret = -EIO;
+	}
+
+	return ret;
+}
+
+int hda_dsp_core_stall_reset(struct snd_sof_dev *sdev, unsigned int core_mask)
+{
+	/* stall core */
+	snd_sof_dsp_update_bits_unlocked(sdev, HDA_DSP_BAR,
+					 HDA_DSP_REG_ADSPCS,
+					 HDA_DSP_ADSPCS_CSTALL_MASK(core_mask),
+					 HDA_DSP_ADSPCS_CSTALL_MASK(core_mask));
+
+	/* set reset state */
+	return hda_dsp_core_reset_enter(sdev, core_mask);
+}
+
+int hda_dsp_core_run(struct snd_sof_dev *sdev, unsigned int core_mask)
+{
+	int ret;
+
+	/* leave reset state */
+	ret = hda_dsp_core_reset_leave(sdev, core_mask);
+	if (ret < 0)
+		return ret;
+
+	/* run core */
+	dev_dbg(sdev->dev, "unstall/run core: core_mask = %x\n", core_mask);
+	snd_sof_dsp_update_bits_unlocked(sdev, HDA_DSP_BAR,
+					 HDA_DSP_REG_ADSPCS,
+					 HDA_DSP_ADSPCS_CSTALL_MASK(core_mask),
+					 0);
+
+	/* is core now running ? */
+	if (!hda_dsp_core_is_enabled(sdev, core_mask)) {
+		hda_dsp_core_stall_reset(sdev, core_mask);
+		dev_err(sdev->dev, "error: DSP start core failed: core_mask %x\n",
+			core_mask);
+		ret = -EIO;
+	}
+
+	return ret;
+}
+
+/*
+ * Power Management.
+ */
+
+int hda_dsp_core_power_up(struct snd_sof_dev *sdev, unsigned int core_mask)
+{
+	unsigned int cpa;
+	u32 adspcs;
+	int ret;
+
+	/* update bits */
+	snd_sof_dsp_update_bits(sdev, HDA_DSP_BAR, HDA_DSP_REG_ADSPCS,
+				HDA_DSP_ADSPCS_SPA_MASK(core_mask),
+				HDA_DSP_ADSPCS_SPA_MASK(core_mask));
+
+	/* poll with timeout to check if operation successful */
+	cpa = HDA_DSP_ADSPCS_CPA_MASK(core_mask);
+	ret = snd_sof_dsp_read_poll_timeout(sdev, HDA_DSP_BAR,
+					    HDA_DSP_REG_ADSPCS, adspcs,
+					    (adspcs & cpa) == cpa,
+					    HDA_DSP_REG_POLL_INTERVAL_US,
+					    HDA_DSP_RESET_TIMEOUT_US);
+	if (ret < 0)
+		dev_err(sdev->dev, "error: timeout on core powerup\n");
+
+	/* did core power up ? */
+	adspcs = snd_sof_dsp_read(sdev, HDA_DSP_BAR,
+				  HDA_DSP_REG_ADSPCS);
+	if ((adspcs & HDA_DSP_ADSPCS_CPA_MASK(core_mask)) !=
+		HDA_DSP_ADSPCS_CPA_MASK(core_mask)) {
+		dev_err(sdev->dev,
+			"error: power up core failed core_mask %xadspcs 0x%x\n",
+			core_mask, adspcs);
+		ret = -EIO;
+	}
+
+	return ret;
+}
+
+int hda_dsp_core_power_down(struct snd_sof_dev *sdev, unsigned int core_mask)
+{
+	u32 adspcs;
+
+	/* update bits */
+	snd_sof_dsp_update_bits_unlocked(sdev, HDA_DSP_BAR,
+					 HDA_DSP_REG_ADSPCS,
+					 HDA_DSP_ADSPCS_SPA_MASK(core_mask), 0);
+
+	return snd_sof_dsp_read_poll_timeout(sdev, HDA_DSP_BAR,
+				HDA_DSP_REG_ADSPCS, adspcs,
+				!(adspcs & HDA_DSP_ADSPCS_SPA_MASK(core_mask)),
+				HDA_DSP_REG_POLL_INTERVAL_US,
+				HDA_DSP_PD_TIMEOUT * USEC_PER_MSEC);
+}
+
+bool hda_dsp_core_is_enabled(struct snd_sof_dev *sdev,
+			     unsigned int core_mask)
+{
+	int val;
+	bool is_enable;
+
+	val = snd_sof_dsp_read(sdev, HDA_DSP_BAR, HDA_DSP_REG_ADSPCS);
+
+	is_enable = ((val & HDA_DSP_ADSPCS_CPA_MASK(core_mask)) &&
+			(val & HDA_DSP_ADSPCS_SPA_MASK(core_mask)) &&
+			!(val & HDA_DSP_ADSPCS_CRST_MASK(core_mask)) &&
+			!(val & HDA_DSP_ADSPCS_CSTALL_MASK(core_mask)));
+
+	dev_dbg(sdev->dev, "DSP core(s) enabled? %d : core_mask %x\n",
+		is_enable, core_mask);
+
+	return is_enable;
+}
+
+int hda_dsp_enable_core(struct snd_sof_dev *sdev, unsigned int core_mask)
+{
+	int ret;
+
+	/* return if core is already enabled */
+	if (hda_dsp_core_is_enabled(sdev, core_mask))
+		return 0;
+
+	/* power up */
+	ret = hda_dsp_core_power_up(sdev, core_mask);
+	if (ret < 0) {
+		dev_err(sdev->dev, "error: dsp core power up failed: core_mask %x\n",
+			core_mask);
+		return ret;
+	}
+
+	return hda_dsp_core_run(sdev, core_mask);
+}
+
+int hda_dsp_core_reset_power_down(struct snd_sof_dev *sdev,
+				  unsigned int core_mask)
+{
+	int ret;
+
+	/* place core in reset prior to power down */
+	ret = hda_dsp_core_stall_reset(sdev, core_mask);
+	if (ret < 0) {
+		dev_err(sdev->dev, "error: dsp core reset failed: core_mask %x\n",
+			core_mask);
+		return ret;
+	}
+
+	/* power down core */
+	ret = hda_dsp_core_power_down(sdev, core_mask);
+	if (ret < 0) {
+		dev_err(sdev->dev, "error: dsp core power down fail mask %x: %d\n",
+			core_mask, ret);
+		return ret;
+	}
+
+	/* make sure we are in OFF state */
+	if (hda_dsp_core_is_enabled(sdev, core_mask)) {
+		dev_err(sdev->dev, "error: dsp core disable fail mask %x: %d\n",
+			core_mask, ret);
+		ret = -EIO;
+	}
+
+	return ret;
+}
+
+void hda_dsp_ipc_int_enable(struct snd_sof_dev *sdev)
+{
+	struct sof_intel_hda_dev *hda = sdev->pdata->hw_pdata;
+	const struct sof_intel_dsp_desc *chip = hda->desc;
+
+	/* enable IPC DONE and BUSY interrupts */
+	snd_sof_dsp_update_bits(sdev, HDA_DSP_BAR, chip->ipc_ctl,
+			HDA_DSP_REG_HIPCCTL_DONE | HDA_DSP_REG_HIPCCTL_BUSY,
+			HDA_DSP_REG_HIPCCTL_DONE | HDA_DSP_REG_HIPCCTL_BUSY);
+
+	/* enable IPC interrupt */
+	snd_sof_dsp_update_bits(sdev, HDA_DSP_BAR, HDA_DSP_REG_ADSPIC,
+				HDA_DSP_ADSPIC_IPC, HDA_DSP_ADSPIC_IPC);
+}
+
+void hda_dsp_ipc_int_disable(struct snd_sof_dev *sdev)
+{
+	struct sof_intel_hda_dev *hda = sdev->pdata->hw_pdata;
+	const struct sof_intel_dsp_desc *chip = hda->desc;
+
+	/* disable IPC interrupt */
+	snd_sof_dsp_update_bits(sdev, HDA_DSP_BAR, HDA_DSP_REG_ADSPIC,
+				HDA_DSP_ADSPIC_IPC, 0);
+
+	/* disable IPC BUSY and DONE interrupt */
+	snd_sof_dsp_update_bits(sdev, HDA_DSP_BAR, chip->ipc_ctl,
+			HDA_DSP_REG_HIPCCTL_BUSY | HDA_DSP_REG_HIPCCTL_DONE, 0);
+}
+
+static int hda_suspend(struct snd_sof_dev *sdev, int state)
+{
+	struct sof_intel_hda_dev *hda = sdev->pdata->hw_pdata;
+	const struct sof_intel_dsp_desc *chip = hda->desc;
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
+	struct hdac_bus *bus = sof_to_bus(sdev);
+#endif
+	int ret;
+
+	/* disable IPC interrupts */
+	hda_dsp_ipc_int_disable(sdev);
+
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
+	/* power down all hda link */
+	snd_hdac_ext_bus_link_power_down_all(bus);
+#endif
+
+	/* power down DSP */
+	ret = hda_dsp_core_reset_power_down(sdev, chip->cores_mask);
+	if (ret < 0) {
+		dev_err(sdev->dev,
+			"error: failed to power down core during suspend\n");
+		return ret;
+	}
+
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
+	/* disable ppcap interrupt */
+	snd_hdac_ext_bus_ppcap_int_enable(bus, false);
+	snd_hdac_ext_bus_ppcap_enable(bus, false);
+
+	/* disable hda bus irq and i/o */
+	snd_hdac_bus_stop_chip(bus);
+#else
+	/* disable ppcap interrupt */
+	hda_dsp_ctrl_ppcap_enable(sdev, false);
+	hda_dsp_ctrl_ppcap_int_enable(sdev, false);
+
+	/* disable hda bus irq */
+	snd_sof_dsp_update_bits(sdev, HDA_DSP_HDA_BAR, SOF_HDA_INTCTL,
+				SOF_HDA_INT_CTRL_EN | SOF_HDA_INT_GLOBAL_EN,
+				0);
+#endif
+
+	/* disable LP retention mode */
+	snd_sof_pci_update_bits(sdev, PCI_PGCTL,
+				PCI_PGCTL_LSRMD_MASK, PCI_PGCTL_LSRMD_MASK);
+
+	/* reset controller */
+	ret = hda_dsp_ctrl_link_reset(sdev, true);
+	if (ret < 0) {
+		dev_err(sdev->dev,
+			"error: failed to reset controller during suspend\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int hda_resume(struct snd_sof_dev *sdev)
+{
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
+	struct hdac_bus *bus = sof_to_bus(sdev);
+	struct hdac_ext_link *hlink = NULL;
+#endif
+	int ret;
+
+	/*
+	 * clear TCSEL to clear playback on some HD Audio
+	 * codecs. PCI TCSEL is defined in the Intel manuals.
+	 */
+	snd_sof_pci_update_bits(sdev, PCI_TCSEL, 0x07, 0);
+
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
+	/* reset and start hda controller */
+	ret = hda_dsp_ctrl_init_chip(sdev, true);
+	if (ret < 0) {
+		dev_err(sdev->dev,
+			"error: failed to start controller after resume\n");
+		return ret;
+	}
+
+	hda_dsp_ctrl_misc_clock_gating(sdev, false);
+
+	/* Reset stream-to-link mapping */
+	list_for_each_entry(hlink, &bus->hlink_list, list)
+		bus->io_ops->reg_writel(0, hlink->ml_addr + AZX_REG_ML_LOSIDV);
+
+	hda_dsp_ctrl_misc_clock_gating(sdev, true);
+
+	/* enable ppcap interrupt */
+	snd_hdac_ext_bus_ppcap_enable(bus, true);
+	snd_hdac_ext_bus_ppcap_int_enable(bus, true);
+#else
+
+	hda_dsp_ctrl_misc_clock_gating(sdev, false);
+
+	/* reset controller */
+	ret = hda_dsp_ctrl_link_reset(sdev, true);
+	if (ret < 0) {
+		dev_err(sdev->dev,
+			"error: failed to reset controller during resume\n");
+		return ret;
+	}
+
+	/* take controller out of reset */
+	ret = hda_dsp_ctrl_link_reset(sdev, false);
+	if (ret < 0) {
+		dev_err(sdev->dev,
+			"error: failed to ready controller during resume\n");
+		return ret;
+	}
+
+	/* enable hda bus irq */
+	snd_sof_dsp_update_bits(sdev, HDA_DSP_HDA_BAR, SOF_HDA_INTCTL,
+				SOF_HDA_INT_CTRL_EN | SOF_HDA_INT_GLOBAL_EN,
+				SOF_HDA_INT_CTRL_EN | SOF_HDA_INT_GLOBAL_EN);
+
+	hda_dsp_ctrl_misc_clock_gating(sdev, true);
+
+	/* enable ppcap interrupt */
+	hda_dsp_ctrl_ppcap_enable(sdev, true);
+	hda_dsp_ctrl_ppcap_int_enable(sdev, true);
+#endif
+
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
+	/* turn off the links that were off before suspend */
+	list_for_each_entry(hlink, &bus->hlink_list, list) {
+		if (!hlink->ref_count)
+			snd_hdac_ext_bus_link_power_down(hlink);
+	}
+
+	/* check dma status and clean up CORB/RIRB buffers */
+	if (!bus->cmd_dma_state)
+		snd_hdac_bus_stop_cmd_io(bus);
+#endif
+
+	return 0;
+}
+
+int hda_dsp_resume(struct snd_sof_dev *sdev)
+{
+	/* init hda controller. DSP cores will be powered up during fw boot */
+	return hda_resume(sdev);
+}
+
+int hda_dsp_runtime_resume(struct snd_sof_dev *sdev)
+{
+	/* init hda controller. DSP cores will be powered up during fw boot */
+	return hda_resume(sdev);
+}
+
+int hda_dsp_runtime_suspend(struct snd_sof_dev *sdev, int state)
+{
+	/* stop hda controller and power dsp off */
+	return hda_suspend(sdev, state);
+}
+
+int hda_dsp_suspend(struct snd_sof_dev *sdev, int state)
+{
+	struct hdac_bus *bus = sof_to_bus(sdev);
+	int ret;
+
+	/* stop hda controller and power dsp off */
+	ret = hda_suspend(sdev, state);
+	if (ret < 0) {
+		dev_err(bus->dev, "error: suspending dsp\n");
+		return ret;
+	}
+
+	return 0;
+}
-- 
2.20.1
