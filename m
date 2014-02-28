From: Dylan Reid <dgreid@chromium.org>
Subject: [RFC 19/19] WIP: ALSA: hda - Add driver for Tegra SoC
	HDA
Date: Thu, 27 Feb 2014 22:36:02 -0800
Message-ID: <1393569362-27285-20-git-send-email-dgreid@chromium.org>
References: <1393569362-27285-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f73.google.com (mail-pb0-f73.google.com
 [209.85.160.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 239CE2650D5
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2014 07:37:13 +0100 (CET)
Received: by mail-pb0-f73.google.com with SMTP id rp16so34281pbb.2
 for <alsa-devel@alsa-project.org>; Thu, 27 Feb 2014 22:37:13 -0800 (PST)
In-Reply-To: <1393569362-27285-1-git-send-email-dgreid@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Dylan Reid <dgreid@chromium.org>, swarren@wwwdotorg.org
List-Id: alsa-devel@alsa-project.org

This adds a driver for the HDA block in Tegra SoCs.  The HDA bus is
used to communicate with the HDMI codec on Tegra124.

Working:
  Audio comes out of HDMI (need downstream HDMI driver bring up display)
  Jack detection works when plugging unplugging the cable

Needs fixing:
  Needs DT binding
  Clocks need to be in DT
  Need to fix codec initialization so the HDMI patch is ready at DT init
  Audio plays slowed down significantly
---
 sound/pci/hda/Kconfig     |  14 +
 sound/pci/hda/Makefile    |   2 +
 sound/pci/hda/hda_tegra.c | 850 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 866 insertions(+)
 create mode 100644 sound/pci/hda/hda_tegra.c

diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index ac17c3f..4f6ee6b 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -20,6 +20,20 @@ config SND_HDA_INTEL
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-hda-intel.
 
+config SND_HDA_TEGRA
+	tristate "Tegra HD Audio"
+	select SND_HDA
+	help
+	  Say Y here to support the HDA controller present in Nvidia
+	  Tegra SoCs
+
+	  This options enables support for the HD Audio controller
+	  present in some Nvidia Tegra SoCs, used to communicate audio
+	  to the HDMI output.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called snd-hda-tegra.
+
 if SND_HDA
 
 config SND_HDA_DSP_LOADER
diff --git a/sound/pci/hda/Makefile b/sound/pci/hda/Makefile
index 582b21c..a47d4a6 100644
--- a/sound/pci/hda/Makefile
+++ b/sound/pci/hda/Makefile
@@ -1,5 +1,6 @@
 snd-hda-intel-objs := hda_intel.o
 snd-hda-shared-objs := hda_shared.o
+snd-hda-tegra-objs := hda_tegra.o
 # for haswell power well
 snd-hda-intel-$(CONFIG_SND_HDA_I915) +=	hda_i915.o
 
@@ -47,3 +48,4 @@ obj-$(CONFIG_SND_HDA_CODEC_HDMI) += snd-hda-codec-hdmi.o
 # otherwise the codec patches won't be hooked before the PCI probe
 # when built in kernel
 obj-$(CONFIG_SND_HDA_INTEL) += snd-hda-intel.o
+obj-$(CONFIG_SND_HDA_TEGRA) += snd-hda-tegra.o
diff --git a/sound/pci/hda/hda_tegra.c b/sound/pci/hda/hda_tegra.c
new file mode 100644
index 0000000..1523d3c3
--- /dev/null
+++ b/sound/pci/hda/hda_tegra.c
@@ -0,0 +1,850 @@
+/*
+ *
+ *  Implementation of primary alsa driver code base for Tegra HDA.
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the Free
+ *  Software Foundation; either version 2 of the License, or (at your option)
+ *  any later version.
+ *
+ *  This program is distributed in the hope that it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ *  more details.
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/clocksource.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/dma-mapping.h>
+#include <linux/moduleparam.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/mutex.h>
+#include <linux/reboot.h>
+#include <linux/io.h>
+#include <linux/pm_runtime.h>
+#include <linux/of_device.h>
+#include <linux/time.h>
+#include <linux/completion.h>
+
+#include <sound/core.h>
+#include <sound/initval.h>
+#include <linux/firmware.h>
+#include "hda_codec.h"
+#include "hda_shared.h"
+#include "hda_priv.h"
+
+#define DRV_NAME "tegra-hda"
+
+/* Defines for Nvidia Tegra HDA support */
+#define NVIDIA_TEGRA_HDA_BAR0_OFFSET           0x8000
+
+#define NVIDIA_TEGRA_HDA_CFG_CMD_OFFSET        0x1004
+#define NVIDIA_TEGRA_HDA_CFG_BAR0_OFFSET       0x1010
+
+#define NVIDIA_TEGRA_HDA_ENABLE_IO_SPACE       (1 << 0)
+#define NVIDIA_TEGRA_HDA_ENABLE_MEM_SPACE      (1 << 1)
+#define NVIDIA_TEGRA_HDA_ENABLE_BUS_MASTER     (1 << 2)
+#define NVIDIA_TEGRA_HDA_ENABLE_SERR           (1 << 8)
+#define NVIDIA_TEGRA_HDA_DISABLE_INTR          (1 << 10)
+#define NVIDIA_TEGRA_HDA_BAR0_INIT_PROGRAM     0xFFFFFFFF
+#define NVIDIA_TEGRA_HDA_BAR0_FINAL_PROGRAM    (1 << 14)
+
+/* IPFS */
+#define NVIDIA_TEGRA_HDA_IPFS_CONFIG           0x180
+#define NVIDIA_TEGRA_HDA_IPFS_EN_FPCI          0x1
+
+#define NVIDIA_TEGRA_HDA_IPFS_FPCI_BAR0        0x80
+#define NVIDIA_TEGRA_HDA_FPCI_BAR0_START       0x40
+
+#define NVIDIA_TEGRA_HDA_IPFS_INTR_MASK        0x188
+#define NVIDIA_TEGRA_HDA_IPFS_EN_INTR          (1 << 16)
+
+struct hda_tegra_data {
+	struct azx chip;
+	struct platform_device *pdev;
+	struct clk **platform_clks;
+	int platform_clk_count;
+	void __iomem *remap_config_addr;
+};
+
+static int bdl_pos_adj[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS-1)] = 32};
+static int probe_mask[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS-1)] = -1};
+
+module_param_array(bdl_pos_adj, int, NULL, 0644);
+MODULE_PARM_DESC(bdl_pos_adj, "BDL position adjustment offset.");
+module_param_array(probe_mask, int, NULL, 0444);
+MODULE_PARM_DESC(probe_mask, "Bitmask to probe codecs (default = -1).");
+
+#ifdef CONFIG_PM
+static int param_set_xint(const char *val, const struct kernel_param *kp);
+static struct kernel_param_ops param_ops_xint = {
+	.set = param_set_xint,
+	.get = param_get_int,
+};
+#define param_check_xint param_check_int
+
+static int power_save = CONFIG_SND_HDA_POWER_SAVE_DEFAULT;
+static int *power_save_addr = &power_save;
+module_param(power_save, xint, 0644);
+MODULE_PARM_DESC(power_save, "Automatic power-saving timeout "
+		 "(in seconds, 0 = disable).");
+
+/* reset the HD-audio controller in power save mode.
+ * this may give more power-saving, but will take longer time to
+ * wake up.
+ */
+static bool power_save_controller = 1;
+module_param(power_save_controller, bool, 0644);
+MODULE_PARM_DESC(power_save_controller, "Reset controller in power save mode.");
+#else
+static int *power_save_addr;
+#endif /* CONFIG_PM */
+
+static int align_buffer_size = -1;
+module_param(align_buffer_size, bint, 0644);
+MODULE_PARM_DESC(align_buffer_size,
+		 "Force buffer and period sizes to be multiple of 128 bytes.");
+
+/* Tegra HDA register access is DWORD only. */
+#define MASK_LONG_ALIGN		0x3UL
+#define SHIFT_BYTE		3
+#define SHIFT_BITS(addr)	\
+	(((phys_addr_t)(addr) & MASK_LONG_ALIGN) << SHIFT_BYTE)
+#define ADDR_ALIGN_L(addr)	\
+	(void *)((phys_addr_t)(addr) & ~MASK_LONG_ALIGN)
+#define MASK(bits)		(BIT(bits) - 1)
+#define MASK_REG(addr, bits)	(MASK(bits) << SHIFT_BITS(addr))
+
+#define tegra_write(addr, val, bits) \
+	writel((readl(ADDR_ALIGN_L(addr)) & ~MASK_REG(addr, bits)) | \
+			       ((val) << SHIFT_BITS(addr)), ADDR_ALIGN_L(addr))
+
+#define tegra_read(addr, bits) \
+	((readl(ADDR_ALIGN_L(addr)) >> SHIFT_BITS(addr)) & MASK(bits))
+
+static void tegra_hda_writel(u32 value, u32 *addr)
+{
+	writel(value, addr);
+}
+
+static u32 tegra_hda_readl(u32 *addr)
+{
+	return readl(addr);
+}
+
+static void tegra_hda_writew(u16 value, u16 *addr)
+{
+	tegra_write(addr, value, 16);
+}
+
+static u16 tegra_hda_readw(u16 *addr)
+{
+	return tegra_read(addr, 16);
+}
+
+static void tegra_hda_writeb(u8 value, u8 *addr)
+{
+	tegra_write(addr, value, 8);
+}
+
+static u8 tegra_hda_readb(u8 *addr)
+{
+	return tegra_read(addr, 8);
+}
+
+static const struct azx_reg_ops tegra_hda_reg_ops = {
+	.writel = tegra_hda_writel,
+	.readl = tegra_hda_readl,
+	.writew = tegra_hda_writew,
+	.readw = tegra_hda_readw,
+	.writeb = tegra_hda_writeb,
+	.readb = tegra_hda_readb,
+};
+
+static int azx_acquire_irq(struct azx *chip, int do_disconnect)
+{
+	struct hda_tegra_data *tdata =
+		container_of(chip, struct hda_tegra_data, chip);
+	int irq_id = platform_get_irq(tdata->pdev, 0);
+
+	if (request_irq(irq_id,
+			azx_interrupt,
+			IRQF_SHARED,
+			KBUILD_MODNAME, chip)) {
+		dev_err(chip->card->dev,
+			"unable to grab IRQ %d, disabling device\n",
+			irq_id);
+		if (do_disconnect)
+			snd_card_disconnect(chip->card);
+		return -1;
+	}
+	chip->irq = irq_id;
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static DEFINE_MUTEX(card_list_lock);
+static LIST_HEAD(card_list);
+
+static void azx_add_card_list(struct azx *chip)
+{
+	mutex_lock(&card_list_lock);
+	list_add(&chip->list, &card_list);
+	mutex_unlock(&card_list_lock);
+}
+
+static void azx_del_card_list(struct azx *chip)
+{
+	mutex_lock(&card_list_lock);
+	list_del_init(&chip->list);
+	mutex_unlock(&card_list_lock);
+}
+
+/* trigger power-save check at writing parameter */
+static int param_set_xint(const char *val, const struct kernel_param *kp)
+{
+	struct azx *chip;
+	struct hda_codec *c;
+	int prev = power_save;
+	int ret = param_set_int(val, kp);
+
+	if (ret || prev == power_save)
+		return ret;
+
+	mutex_lock(&card_list_lock);
+	list_for_each_entry(chip, &card_list, list) {
+		if (!chip->bus)
+			continue;
+		list_for_each_entry(c, &chip->bus->codec_list, list)
+			snd_hda_power_sync(c);
+	}
+	mutex_unlock(&card_list_lock);
+	return 0;
+}
+#else
+#define azx_add_card_list(chip) /* NOP */
+#define azx_del_card_list(chip) /* NOP */
+#endif /* CONFIG_PM */
+
+static void reg_update_bits(void __iomem *base, unsigned int reg,
+		unsigned int mask, unsigned int val)
+{
+	unsigned int data;
+
+	data = readl(base + reg);
+	data &= ~mask;
+	data |= (val & mask);
+	writel(data, base + reg);
+}
+
+static void hda_tegra_init(struct hda_tegra_data *tdata)
+{
+	/*Enable the PCI access */
+	reg_update_bits(tdata->remap_config_addr,
+			NVIDIA_TEGRA_HDA_IPFS_CONFIG,
+			NVIDIA_TEGRA_HDA_IPFS_EN_FPCI,
+			NVIDIA_TEGRA_HDA_IPFS_EN_FPCI);
+	/* Enable MEM/IO space and bus master */
+	reg_update_bits(tdata->remap_config_addr,
+			NVIDIA_TEGRA_HDA_CFG_CMD_OFFSET, 0x507,
+			NVIDIA_TEGRA_HDA_ENABLE_MEM_SPACE |
+			NVIDIA_TEGRA_HDA_ENABLE_IO_SPACE |
+			NVIDIA_TEGRA_HDA_ENABLE_BUS_MASTER |
+			NVIDIA_TEGRA_HDA_ENABLE_SERR);
+	reg_update_bits(tdata->remap_config_addr,
+			NVIDIA_TEGRA_HDA_CFG_BAR0_OFFSET, 0xFFFFFFFF,
+			NVIDIA_TEGRA_HDA_BAR0_INIT_PROGRAM);
+	reg_update_bits(tdata->remap_config_addr,
+			NVIDIA_TEGRA_HDA_CFG_BAR0_OFFSET, 0xFFFFFFFF,
+			NVIDIA_TEGRA_HDA_BAR0_FINAL_PROGRAM);
+	reg_update_bits(tdata->remap_config_addr,
+			NVIDIA_TEGRA_HDA_IPFS_FPCI_BAR0, 0xFFFFFFFF,
+			NVIDIA_TEGRA_HDA_FPCI_BAR0_START);
+	reg_update_bits(tdata->remap_config_addr,
+			NVIDIA_TEGRA_HDA_IPFS_INTR_MASK,
+			NVIDIA_TEGRA_HDA_IPFS_EN_INTR,
+			NVIDIA_TEGRA_HDA_IPFS_EN_INTR);
+
+	return;
+}
+
+static void __hda_tegra_enable_clocks(struct hda_tegra_data *data)
+{
+	int i;
+
+	for (i = 0; i < data->platform_clk_count; i++)
+		clk_prepare_enable(data->platform_clks[i]);
+}
+
+static void hda_tegra_enable_clocks(struct hda_tegra_data *data)
+{
+	pm_runtime_get_sync(&data->pdev->dev);
+	__hda_tegra_enable_clocks(data);
+}
+
+static void __hda_tegra_disable_clocks(struct hda_tegra_data *data)
+{
+	int i;
+
+	for (i = 0; i < data->platform_clk_count; i++)
+		clk_disable_unprepare(data->platform_clks[i]);
+}
+
+static void hda_tegra_disable_clocks(struct hda_tegra_data *data)
+{
+	__hda_tegra_disable_clocks(data);
+	pm_runtime_put(&data->pdev->dev);
+}
+
+static void hda_tegra_put_clocks(struct hda_tegra_data *data)
+{
+	int i;
+	for (i = 0; i < data->platform_clk_count; i++)
+		devm_clk_put(&data->pdev->dev, data->platform_clks[i]);
+}
+
+#if defined(CONFIG_PM_SLEEP)
+/*
+ * power management
+ */
+static int azx_suspend(struct device *dev)
+{
+	struct snd_card *card = dev_get_drvdata(dev);
+	struct azx *chip = card->private_data;
+	struct azx_pcm *p;
+	struct hda_tegra_data *tdata =
+		container_of(chip, struct hda_tegra_data, chip);
+
+	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
+	azx_clear_irq_pending(chip);
+	list_for_each_entry(p, &chip->pcm_list, list)
+		snd_pcm_suspend_all(p->pcm);
+	if (chip->initialized)
+		snd_hda_suspend(chip->bus);
+	azx_stop_chip(chip);
+	azx_enter_link_reset(chip);
+	if (chip->irq >= 0) {
+		free_irq(chip->irq, chip);
+		chip->irq = -1;
+	}
+
+	hda_tegra_disable_clocks(tdata);
+	return 0;
+}
+
+static int azx_resume(struct device *dev)
+{
+	struct snd_card *card = dev_get_drvdata(dev);
+	struct azx *chip = card->private_data;
+	struct hda_tegra_data *tdata =
+		container_of(chip, struct hda_tegra_data, chip);
+
+	hda_tegra_enable_clocks(tdata);
+
+	if (azx_acquire_irq(chip, 1) < 0)
+		return -EIO;
+
+	hda_tegra_init(tdata);
+
+	azx_init_chip(chip, 1);
+
+	snd_hda_resume(chip->bus);
+	snd_power_change_state(card, SNDRV_CTL_POWER_D0);
+	return 0;
+}
+#endif /* CONFIG_PM_SLEEP */
+
+#ifdef CONFIG_PM_RUNTIME
+static int azx_runtime_suspend(struct device *dev)
+{
+	struct snd_card *card = dev_get_drvdata(dev);
+	struct azx *chip = card->private_data;
+
+	if (!(chip->driver_caps & AZX_DCAPS_PM_RUNTIME))
+		return 0;
+
+	/* enable controller wake up event */
+	azx_writew(chip, WAKEEN, azx_readw(chip, WAKEEN) |
+		  STATESTS_INT_MASK);
+
+	azx_stop_chip(chip);
+	azx_enter_link_reset(chip);
+	azx_clear_irq_pending(chip);
+	return 0;
+}
+
+static int azx_runtime_resume(struct device *dev)
+{
+	struct snd_card *card = dev_get_drvdata(dev);
+	struct azx *chip = card->private_data;
+	struct hda_bus *bus;
+	struct hda_codec *codec;
+	int status;
+
+	if (!(chip->driver_caps & AZX_DCAPS_PM_RUNTIME))
+		return 0;
+
+	/* Read STATESTS before controller reset */
+	status = azx_readw(chip, STATESTS);
+
+	azx_init_chip(chip, 1);
+
+	bus = chip->bus;
+	if (status && bus) {
+		list_for_each_entry(codec, &bus->codec_list, list)
+			if (status & (1 << codec->addr))
+				queue_delayed_work(codec->bus->workq,
+						   &codec->jackpoll_work,
+						   codec->jackpoll_interval);
+	}
+
+	/* disable controller Wake Up event*/
+	azx_writew(chip, WAKEEN, azx_readw(chip, WAKEEN) & ~STATESTS_INT_MASK);
+
+	return 0;
+}
+
+static int azx_runtime_idle(struct device *dev)
+{
+	struct snd_card *card = dev_get_drvdata(dev);
+	struct azx *chip = card->private_data;
+
+	if (chip->disabled)
+		return 0;
+
+	if (!power_save_controller ||
+	    !(chip->driver_caps & AZX_DCAPS_PM_RUNTIME))
+		return -EBUSY;
+
+	return 0;
+}
+
+#endif /* CONFIG_PM_RUNTIME */
+
+#ifdef CONFIG_PM
+static const struct dev_pm_ops azx_pm = {
+	SET_SYSTEM_SLEEP_PM_OPS(azx_suspend, azx_resume)
+	SET_RUNTIME_PM_OPS(azx_runtime_suspend,
+			   azx_runtime_resume,
+			   azx_runtime_idle)
+};
+
+#define AZX_PM_OPS	(&azx_pm)
+#else
+#define AZX_PM_OPS	NULL
+#endif /* CONFIG_PM */
+
+
+/*
+ * reboot notifier for hang-up problem at power-down
+ */
+static int azx_halt(struct notifier_block *nb, unsigned long event, void *buf)
+{
+	struct azx *chip = container_of(nb, struct azx, reboot_notifier);
+	snd_hda_bus_reboot_notify(chip->bus);
+	azx_stop_chip(chip);
+	return NOTIFY_OK;
+}
+
+static void azx_notifier_register(struct azx *chip)
+{
+	chip->reboot_notifier.notifier_call = azx_halt;
+	register_reboot_notifier(&chip->reboot_notifier);
+}
+
+static void azx_notifier_unregister(struct azx *chip)
+{
+	if (chip->reboot_notifier.notifier_call)
+		unregister_reboot_notifier(&chip->reboot_notifier);
+}
+
+/*
+ * destructor
+ */
+static int azx_free(struct azx *chip)
+{
+	struct hda_tegra_data *tdata =
+		container_of(chip, struct hda_tegra_data, chip);
+	int i;
+
+	if ((chip->driver_caps & AZX_DCAPS_PM_RUNTIME) && chip->running)
+		pm_runtime_get_noresume(chip->card->dev);
+
+	azx_del_card_list(chip);
+
+	azx_notifier_unregister(chip);
+
+	complete_all(&chip->probe_wait);
+
+	if (chip->initialized) {
+		azx_clear_irq_pending(chip);
+		for (i = 0; i < chip->num_streams; i++)
+			azx_stream_stop(chip, &chip->azx_dev[i]);
+		azx_stop_chip(chip);
+	}
+
+	hda_tegra_disable_clocks(tdata);
+	hda_tegra_put_clocks(tdata);
+
+	if (chip->irq >= 0)
+		free_irq(chip->irq, chip);
+	if (chip->remap_addr)
+		iounmap(chip->remap_addr);
+
+	azx_free_stream_pages(chip);
+
+	kfree(chip->azx_dev);
+	kfree(tdata);
+
+	return 0;
+}
+
+static int azx_dev_free(struct snd_device *device)
+{
+	return azx_free(device->device_data);
+}
+
+static const char * const tegra_clk_names[] = {
+	"hda",
+	"hda2codec_2x",
+	"hda2hdmi",
+};
+static struct clk *tegra_clks[ARRAY_SIZE(tegra_clk_names)];
+
+static int hda_tegra_init_chip(struct azx *chip)
+{
+	struct hda_tegra_data *tdata =
+		container_of(chip, struct hda_tegra_data, chip);
+	struct device *dev = &tdata->pdev->dev;
+	struct resource *res, *region;
+	int i;
+
+	tdata->platform_clk_count = ARRAY_SIZE(tegra_clk_names);
+	for (i = 0; i < tdata->platform_clk_count; i++) {
+		tegra_clks[i] = devm_clk_get(dev, tegra_clk_names[i]);
+		if (IS_ERR(tegra_clks[i]))
+			return PTR_ERR(tegra_clks[i]);
+	}
+	tdata->platform_clks = tegra_clks;
+
+	res = platform_get_resource(tdata->pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -EINVAL;
+
+	region = devm_request_mem_region(dev, res->start,
+					 resource_size(res),
+					 tdata->pdev->name);
+	if (!region)
+		return -ENOMEM;
+
+	chip->addr = res->start;
+	chip->remap_addr = devm_ioremap(dev, res->start, resource_size(res));
+	if (!chip->remap_addr)
+		return -ENXIO;
+
+	tdata->remap_config_addr = chip->remap_addr;
+	chip->remap_addr += NVIDIA_TEGRA_HDA_BAR0_OFFSET;
+	chip->addr += NVIDIA_TEGRA_HDA_BAR0_OFFSET;
+
+	__hda_tegra_enable_clocks(tdata);
+
+	hda_tegra_init(tdata);
+
+	return 0;
+}
+
+static void power_down_all_codecs(struct azx *chip)
+{
+#ifdef CONFIG_PM
+	/* The codecs were powered up in snd_hda_codec_new().
+	 * Now all initialization done, so turn them down if possible
+	 */
+	struct hda_codec *codec;
+	list_for_each_entry(codec, &chip->bus->codec_list, list) {
+		snd_hda_power_down(codec);
+	}
+#endif
+}
+
+static int azx_first_init(struct azx *chip)
+{
+	struct snd_card *card = chip->card;
+	int err;
+	unsigned short gcap;
+
+	err = hda_tegra_init_chip(chip);
+	if (err)
+		return err;
+
+	if (azx_acquire_irq(chip, 0) < 0)
+		return -EBUSY;
+
+	synchronize_irq(chip->irq);
+
+	gcap = azx_readw(chip, GCAP);
+	dev_dbg(card->dev, "chipset global capabilities = 0x%x\n", gcap);
+
+	/* disable 64bit DMA address on some devices */
+	if (chip->driver_caps & AZX_DCAPS_NO_64BIT) {
+		dev_dbg(card->dev, "Disabling 64bit DMA\n");
+		gcap &= ~ICH6_GCAP_64OK;
+	}
+
+	/* disable buffer size rounding to 128-byte multiples if supported */
+	if (align_buffer_size >= 0) {
+		chip->align_buffer_size = !!align_buffer_size;
+	} else {
+		if (chip->driver_caps & AZX_DCAPS_BUFSIZE)
+			chip->align_buffer_size = 0;
+		else if (chip->driver_caps & AZX_DCAPS_ALIGN_BUFSIZE)
+			chip->align_buffer_size = 1;
+		else
+			chip->align_buffer_size = 1;
+	}
+
+	/* read number of streams from GCAP register instead of using
+	 * hardcoded value
+	 */
+	chip->capture_streams = (gcap >> 8) & 0x0f;
+	chip->playback_streams = (gcap >> 12) & 0x0f;
+	if (!chip->playback_streams && !chip->capture_streams) {
+		/* gcap didn't give any info, switching to old method */
+		chip->playback_streams = ICH6_NUM_PLAYBACK;
+		chip->capture_streams = ICH6_NUM_CAPTURE;
+	}
+	chip->capture_index_offset = 0;
+	chip->playback_index_offset = chip->capture_streams;
+	chip->num_streams = chip->playback_streams + chip->capture_streams;
+	chip->azx_dev = kcalloc(chip->num_streams, sizeof(*chip->azx_dev),
+				GFP_KERNEL);
+	if (!chip->azx_dev)
+		return -ENOMEM;
+
+	err = azx_alloc_stream_pages(chip);
+	if (err < 0)
+		return err;
+
+	/* initialize streams */
+	azx_init_stream(chip);
+
+	/* initialize chip */
+	azx_init_chip(chip, 1);
+
+	/* codec detection */
+	if (!chip->codec_mask) {
+		dev_err(card->dev, "no codecs found!\n");
+		return -ENODEV;
+	}
+
+	strcpy(card->driver, "HDA-Tegra");
+	strcpy(card->shortname, "HDA-Tegra");
+	snprintf(card->longname, sizeof(card->longname),
+		 "%s at 0x%lx irq %i",
+		 card->shortname, chip->addr, chip->irq);
+
+	return 0;
+}
+
+static int azx_probe_continue(struct azx *chip)
+{
+	int err;
+
+	err = azx_first_init(chip);
+	if (err < 0)
+		goto out_free;
+
+	/* create codec instances */
+	err = azx_codec_create(chip, NULL,
+			       0,
+			       power_save_addr);
+	if (err < 0)
+		goto out_free;
+
+	err = azx_codec_configure(chip);
+	if (err < 0)
+		goto out_free;
+
+	/* create PCM streams */
+	err = snd_hda_build_pcms(chip->bus);
+	if (err < 0)
+		goto out_free;
+
+	/* create mixer controls */
+	err = azx_mixer_create(chip);
+	if (err < 0)
+		goto out_free;
+
+	err = snd_card_register(chip->card);
+	if (err < 0)
+		goto out_free;
+
+	chip->running = 1;
+	power_down_all_codecs(chip);
+	azx_notifier_register(chip);
+	azx_add_card_list(chip);
+	if (chip->driver_caps & AZX_DCAPS_PM_RUNTIME)
+		pm_runtime_put_noidle(chip->card->dev);
+
+out_free:
+	complete_all(&chip->probe_wait);
+	return err;
+}
+
+static void azx_probe_work(struct work_struct *work)
+{
+	azx_probe_continue(container_of(work, struct azx, probe_work));
+}
+
+static int disable_msi_reset_irq(struct azx *chip)
+{
+	return 0;
+}
+
+/*
+ * constructor
+ */
+static int azx_create(struct snd_card *card,
+		      int dev,
+		      struct platform_device *pdev,
+		      unsigned int driver_caps,
+		      const struct azx_reg_ops *reg_ops,
+		      struct azx **rchip)
+{
+	static struct snd_device_ops ops = {
+		.dev_free = azx_dev_free,
+	};
+	struct hda_tegra_data *tdata;
+	struct azx *chip;
+	int err;
+
+	*rchip = NULL;
+
+	pm_runtime_get_noresume(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
+	tdata = kzalloc(sizeof(*tdata), GFP_KERNEL);
+	if (!tdata)
+		return -ENOMEM;
+	chip = &tdata->chip;
+
+	spin_lock_init(&chip->reg_lock);
+	mutex_init(&chip->open_mutex);
+	chip->card = card;
+	chip->reg_ops = reg_ops;
+	chip->irq = -1;
+	chip->driver_caps = driver_caps;
+	chip->driver_type = driver_caps & 0xff;
+	chip->dev_index = dev;
+	chip->disable_msi_reset_irq = disable_msi_reset_irq;
+	INIT_WORK(&chip->irq_pending_work, azx_irq_pending_work);
+	INIT_LIST_HEAD(&chip->pcm_list);
+	INIT_LIST_HEAD(&chip->list);
+	init_completion(&chip->probe_wait);
+
+	chip->position_fix[0] = POS_FIX_AUTO;
+	chip->position_fix[1] = POS_FIX_AUTO;
+	chip->codec_probe_mask = probe_mask[dev];
+
+	chip->single_cmd = false;
+	chip->snoop = true;
+
+	chip->bdl_pos_adj = bdl_pos_adj;
+
+	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
+	if (err < 0) {
+		dev_err(card->dev, "Error creating device [card]!\n");
+		azx_free(chip);
+		return err;
+	}
+
+	/* continue probing in work context as may trigger request module */
+	INIT_WORK(&chip->probe_work, azx_probe_work);
+
+	*rchip = chip;
+
+	return 0;
+}
+
+static unsigned int tegra_driver_flags = AZX_DCAPS_RIRB_DELAY |
+					 AZX_DCAPS_PM_RUNTIME;
+
+static const struct of_device_id tegra_platform_hda_match[] = {
+	{ .compatible = "nvidia,tegra-hda", .data = &tegra_driver_flags },
+	{},
+};
+
+static int hda_tegra_probe(struct platform_device *pdev)
+{
+	static int dev;
+	struct snd_card *card;
+	struct azx *chip;
+	struct hda_tegra_data *tdata;
+	const struct of_device_id *of_id;
+	const unsigned int *driver_data;
+	int err;
+
+	if (dev >= SNDRV_CARDS)
+		return -ENODEV;
+
+	of_id = of_match_device(tegra_platform_hda_match, &pdev->dev);
+	if (!of_id)
+		return -EINVAL;
+
+	tdata = devm_kzalloc(&pdev->dev, sizeof(*tdata), GFP_KERNEL);
+	if (!tdata)
+		return -ENOMEM;
+
+	err = snd_card_new(&pdev->dev, SNDRV_DEFAULT_IDX1,
+			   SNDRV_DEFAULT_STR1, THIS_MODULE,
+			   0, &card);
+	if (err < 0) {
+		dev_err(&pdev->dev, "Error creating card!\n");
+		return err;
+	}
+
+	driver_data = of_id->data;
+	err = azx_create(card, dev, pdev, *driver_data,
+			 &tegra_hda_reg_ops, &chip);
+	if (err < 0)
+		goto out_free;
+	card->private_data = chip;
+
+	dev_set_drvdata(&pdev->dev, card);
+
+	schedule_work(&chip->probe_work);
+
+	dev++;
+	complete_all(&chip->probe_wait);
+	return 0;
+
+out_free:
+	snd_card_free(card);
+	return err;
+}
+
+static int hda_tegra_remove(struct platform_device *pdev)
+{
+	return snd_card_free(dev_get_drvdata(&pdev->dev));
+}
+
+static struct platform_driver tegra_platform_hda = {
+	.driver = {
+		.name = DRV_NAME,
+		.owner = THIS_MODULE,
+		.pm = AZX_PM_OPS,
+		.of_match_table = tegra_platform_hda_match,
+	},
+	.probe = hda_tegra_probe,
+	.remove = hda_tegra_remove,
+};
+module_platform_driver(tegra_platform_hda);
+
+MODULE_DESCRIPTION("Tegra HDA bus driver");
+MODULE_LICENSE("GPL v2");
+MODULE_DEVICE_TABLE(of, tegra_platform_hda_match);
-- 
1.8.1.3.605.g02339dd
