From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 5/7] ASoC: hda - add Skylake HD audio driver
Date: Fri, 17 Apr 2015 14:43:18 +0530
Message-ID: <1429262000-21517-6-git-send-email-vinod.koul@intel.com>
References: <1429262000-21517-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 744E326057F
 for <alsa-devel@alsa-project.org>; Fri, 17 Apr 2015 11:18:52 +0200 (CEST)
In-Reply-To: <1429262000-21517-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, lgirdwood@gmail.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

This patch adds ASoC Skylake HD audio controller driver

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/hdaudio.h |    1 +
 sound/soc/hda/hda_skl.c |  748 +++++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/hda/hda_skl.h |   44 +++
 3 files changed, 793 insertions(+)
 create mode 100644 sound/soc/hda/hda_skl.c
 create mode 100644 sound/soc/hda/hda_skl.h

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index 227e71956c35..a8feb761e00d 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -393,6 +393,7 @@ struct hdac_stream {
 	bool running:1;
 	bool no_period_wakeup:1;
 	bool locked:1;
+	bool prepared:1;
 
 	/* timestamp */
 	unsigned long start_wallclk;	/* start + minimum wallclk */
diff --git a/sound/soc/hda/hda_skl.c b/sound/soc/hda/hda_skl.c
new file mode 100644
index 000000000000..8a66ef5a4ed8
--- /dev/null
+++ b/sound/soc/hda/hda_skl.c
@@ -0,0 +1,748 @@
+/*
+ *  hda_skl.c - Implementation of primary ASoC Intel HD Audio driver
+ *
+ *  Copyright (C) 2015 Intel Corp
+ *  Author: Jeeja KP <jeeja.kp@intel.com>
+ *
+ *  Copyright (c) 2004 Takashi Iwai <tiwai@suse.de>
+ *                     PeiSen Hou <pshou@realtek.com.tw>
+ *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ */
+
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/pci.h>
+#include <linux/mutex.h>
+#include <linux/io.h>
+#include <linux/pm_runtime.h>
+
+#include <linux/platform_device.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/hda_register.h>
+#include <sound/hdaudio.h>
+#include "hda_skl.h"
+
+MODULE_LICENSE("GPL v2");
+MODULE_SUPPORTED_DEVICE("{Intel, PCH},");
+MODULE_DESCRIPTION("Intel aDSP HDA driver");
+
+/*
+ * initialize the PCI registers
+ */
+/* update bits in a PCI register byte */
+static void update_pci_byte(struct pci_dev *pci, unsigned int reg,
+			    unsigned char mask, unsigned char val)
+{
+	unsigned char data;
+
+	pci_read_config_byte(pci, reg, &data);
+	data &= ~mask;
+	data |= (val & mask);
+	pci_write_config_byte(pci, reg, data);
+}
+
+static void azx_init_pci(struct hdac_bus *chip)
+{
+	struct hda_soc_bus *hda = container_of(chip, struct hda_soc_bus, chip);
+
+	/* Clear bits 0-2 of PCI register TCSEL (at offset 0x44)
+	 * TCSEL == Traffic Class Select Register, which sets PCI express QOS
+	 * Ensuring these bits are 0 clears playback static on some HD Audio
+	 * codecs.
+	 * The PCI register TCSEL is defined in the Intel manuals.
+	 */
+	dev_dbg(chip->dev, "Clearing TCSEL\n");
+	update_pci_byte(hda->pci, AZX_PCIREG_TCSEL, 0x07, 0);
+}
+
+irqreturn_t azx_interrupt(int irq, void *dev_id)
+{
+	struct hdac_bus *chip = dev_id;
+	u32 status;
+
+#ifdef CONFIG_PM
+	if (!pm_runtime_active(chip->dev))
+		return IRQ_NONE;
+#endif
+
+	spin_lock(&chip->reg_lock);
+
+	status = snd_hdac_chip_readl(chip, INTSTS);
+	if (status == 0 || status == 0xffffffff) {
+		spin_unlock(&chip->reg_lock);
+		return IRQ_NONE;
+	}
+	spin_unlock(&chip->reg_lock);
+
+	return IRQ_WAKE_THREAD;
+}
+
+irqreturn_t azx_threaded_handler(int irq, void *dev_id)
+{
+	struct hdac_bus *chip = dev_id;
+	u32 status;
+	unsigned long cookie;
+
+	status = snd_hdac_chip_readl(chip, INTSTS);
+	spin_lock_irqsave(&chip->reg_lock, cookie);
+
+	snd_hdac_bus_handle_stream_irq(chip, status, &azx_position_check);
+
+	/* clear rirb int */
+	status = snd_hdac_chip_readb(chip, RIRBSTS);
+	if (status & RIRB_INT_MASK) {
+		if (status & RIRB_INT_RESPONSE)
+			snd_hdac_bus_update_rirb(chip);
+		snd_hdac_chip_writeb(chip, RIRBSTS, RIRB_INT_MASK);
+	}
+
+	spin_unlock_irqrestore(&chip->reg_lock, cookie);
+
+	return IRQ_HANDLED;
+}
+
+/* initialize SD streams, use seprate streeam tag for PB and CP */
+int azx_init_stream(struct hdac_bus *chip, int num_stream, int direction)
+{
+	int i, tag;
+	int stream_tag = 0;
+
+	/* initialize each stream (aka device)
+	 * assign the starting bdl address to each stream (device)
+	 * and initialize
+	 */
+	for (i = 0; i < num_stream; i++) {
+		struct hdac_stream *hdac_stream =
+			devm_kzalloc(chip->dev, sizeof(*hdac_stream), GFP_KERNEL);
+		 if (!hdac_stream) {
+			dev_err(chip->dev, "kzalloc block failed");
+			return -ENOMEM;
+		}
+		tag = ++stream_tag;
+		snd_hdac_stream_init(chip, hdac_stream, i, direction, tag);
+		list_add_tail(&hdac_stream->list, &chip->stream_list);
+	}
+	return 0;
+}
+
+/* calculate runtime delay from LPIB */
+int azx_get_delay_from_lpib(struct hdac_bus *chip,
+				struct hdac_stream *azx_dev,
+				unsigned int pos)
+{
+	struct snd_pcm_substream *substream = azx_dev->substream;
+	int stream = substream->stream;
+	unsigned int lpib_pos = snd_hdac_stream_get_pos_lpib(azx_dev);
+	int delay;
+
+	if (stream == SNDRV_PCM_STREAM_PLAYBACK)
+		delay = pos - lpib_pos;
+	else
+		delay = lpib_pos - pos;
+	if (delay < 0) {
+		if (delay >= azx_dev->delay_negative_threshold)
+			delay = 0;
+		else
+			delay += azx_dev->bufsize;
+	}
+
+	if (delay >= azx_dev->period_bytes) {
+		dev_info(chip->dev,
+			 "Unstable LPIB (%d >= %d); disabling LPIB delay counting\n",
+			 delay, azx_dev->period_bytes);
+		delay = 0;
+	}
+
+	return bytes_to_frames(substream->runtime, delay);
+}
+
+/*
+ * Check whether the current DMA position is acceptable for updating
+ * periods.  Returns non-zero if it's OK.
+ *
+ * Many HD-audio controllers appear pretty inaccurate about
+ * the update-IRQ timing.  The IRQ is issued before actually the
+ * data is processed.  So, we need to process it afterwords in a
+ * workqueue.
+ */
+static int azx_position_ok(struct hdac_bus *chip, struct hdac_stream *azx_dev)
+{
+	u32 wallclk;
+	unsigned int pos = 0;
+
+	wallclk = snd_hdac_chip_readl(chip, WALLCLK) - azx_dev->start_wallclk;
+	if (wallclk < (azx_dev->period_wallclk * 2) / 3)
+		return -1;	/* bogus (too early) interrupt */
+
+	if (chip->use_posbuf) {
+		/* use the position buffer as default */
+		pos = snd_hdac_stream_get_pos_posbuf(azx_dev);
+		if (!pos || pos == (u32)-1) {
+			dev_info(chip->dev,
+				 "Invalid pos buffer, using LPIB read method instead.\n");
+			pos = snd_hdac_stream_get_pos_lpib(azx_dev);
+		}
+	}
+
+	if (pos >= azx_dev->bufsize)
+		pos = 0;
+
+	if (WARN_ONCE(!azx_dev->period_bytes,
+		      "hda-skl: zero azx_dev->period_bytes"))
+		return -1; /* this shouldn't happen! */
+	if (wallclk < (azx_dev->period_wallclk * 5) / 4 &&
+	    pos % azx_dev->period_bytes > azx_dev->period_bytes / 2)
+		/* NG - it's below the first next period boundary */
+		return chip->bdl_pos_adj ? 0 : -1;
+	azx_dev->start_wallclk += wallclk;
+	return 1; /* OK, it's fine */
+}
+
+/* called from IRQ */
+void azx_position_check(struct hdac_bus *chip, struct hdac_stream *azx_dev)
+{
+	if (azx_position_ok(chip, azx_dev) > 0)
+		snd_pcm_period_elapsed(azx_dev->substream);
+}
+
+static int azx_acquire_irq(struct hdac_bus *chip, int do_disconnect)
+{
+	struct hda_soc_bus *hda = container_of(chip, struct hda_soc_bus, chip);
+
+	if (request_threaded_irq(hda->pci->irq, azx_interrupt,
+			azx_threaded_handler,
+			hda->msi ? 0 : IRQF_SHARED,
+			KBUILD_MODNAME, chip)) {
+		dev_err(chip->dev,
+			"unable to grab IRQ %d, disabling device\n",
+			hda->pci->irq);
+		return -1;
+	}
+	pci_intx(hda->pci, !hda->msi);
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+/*
+ * power management
+ */
+static int azx_suspend(struct device *dev)
+{
+	struct pci_dev *pci = to_pci_dev(dev);
+	struct hdac_bus *chip  = pci_get_drvdata(pci);
+	struct hda_soc_bus *hda = container_of(chip, struct hda_soc_bus, chip);
+
+	snd_hdac_bus_stop_chip(chip);
+	snd_hdac_bus_enter_link_reset(chip);
+	if (pci->irq >= 0)
+		free_irq(pci->irq, chip);
+	if (hda->msi)
+		pci_disable_msi(pci);
+	pci_disable_device(pci);
+	pci_save_state(pci);
+	pci_set_power_state(pci, PCI_D3hot);
+	return 0;
+}
+
+static int azx_resume(struct device *dev)
+{
+	struct pci_dev *pci = to_pci_dev(dev);
+	struct hdac_bus *chip = pci_get_drvdata(pci);
+	struct hda_soc_bus *hda = container_of(chip, struct hda_soc_bus, chip);
+
+	pci_set_power_state(pci, PCI_D0);
+	pci_restore_state(pci);
+
+	if (pci_enable_device(pci) < 0) {
+		dev_err(dev, "hda-intel: pci_enable_device failed, disabling device\n");
+		return -EIO;
+	}
+	pci_set_master(pci);
+	if (hda->msi)
+		if (pci_enable_msi(pci) < 0)
+			hda->msi = 0;
+	if (azx_acquire_irq(chip, 1) < 0)
+		return -EIO;
+	azx_init_pci(chip);
+
+	snd_hdac_bus_init_chip(chip, 1);
+	return 0;
+}
+#endif /* CONFIG_PM_SLEEP */
+
+#ifdef CONFIG_PM
+static int azx_runtime_suspend(struct device *dev)
+{
+	struct pci_dev *pci = to_pci_dev(dev);
+	struct hdac_bus *chip = pci_get_drvdata(pci);
+
+	dev_dbg(chip->dev, "in %s\n", __func__);
+
+	/* enable controller wake up event */
+	snd_hdac_chip_updatew(chip, WAKEEN, 0, STATESTS_INT_MASK);
+
+	snd_hdac_bus_stop_chip(chip);
+	snd_hdac_bus_enter_link_reset(chip);
+	return 0;
+}
+
+static int azx_runtime_resume(struct device *dev)
+{
+	struct pci_dev *pci = to_pci_dev(dev);
+	struct hdac_bus *chip = pci_get_drvdata(pci);
+	int status;
+
+	dev_dbg(chip->dev, "in %s\n", __func__);
+
+	/* Read STATESTS before controller reset */
+	status = snd_hdac_chip_readw(chip, STATESTS);
+
+	azx_init_pci(chip);
+	snd_hdac_bus_init_chip(chip, true);
+	/* disable controller Wake Up event */
+	snd_hdac_chip_updatew(chip, WAKEEN, STATESTS_INT_MASK, 0);
+	return 0;
+}
+
+static const struct dev_pm_ops azx_pm = {
+	SET_SYSTEM_SLEEP_PM_OPS(azx_suspend, azx_resume)
+	SET_RUNTIME_PM_OPS(azx_runtime_suspend, azx_runtime_resume, NULL)
+};
+#endif /* CONFIG_PM */
+
+/*
+ * destructor
+ */
+static int azx_free(struct hdac_bus *chip)
+{
+	struct hda_soc_bus *hda = container_of(chip, struct hda_soc_bus, chip);
+	struct pci_dev *pci = hda->pci;
+	struct hdac_stream *azx_dev;
+
+	hda->init_failed = 1; /* to be sure */
+
+	if (chip->chip_init) {
+		list_for_each_entry(azx_dev, &chip->stream_list, list)
+			snd_hdac_stream_stop(azx_dev);
+		snd_hdac_bus_stop_chip(chip);
+	}
+
+	if (pci->irq >= 0)
+		free_irq(pci->irq, (void *)chip);
+	if (hda->msi)
+		pci_disable_msi(hda->pci);
+	if (chip->remap_addr)
+		iounmap(chip->remap_addr);
+
+	snd_hdac_bus_free_stream_pages(chip);
+	pci_release_regions(hda->pci);
+	pci_disable_device(hda->pci);
+	kfree(chip);
+
+	return 0;
+}
+
+static void check_msi(struct hdac_bus *chip)
+{
+	struct hda_soc_bus *hda = container_of(chip, struct hda_soc_bus, chip);
+
+	if (enable_msi >= 0) {
+		hda->msi = !!enable_msi;
+		return;
+	}
+	hda->msi = 1;	/* enable MSI as default */
+}
+
+/* check the snoop mode availability */
+static void azx_check_snoop_available(struct hdac_bus *chip)
+{
+	bool snoop = chip->snoop;
+
+	if (snoop != chip->snoop) {
+		dev_info(chip->dev, "Force to %s mode\n",
+			 snoop ? "snoop" : "non-snoop");
+		chip->snoop = snoop;
+	}
+}
+
+/* load module */
+static int azx_load_generic_mach(struct device *dev)
+{
+	struct platform_device *pdev;
+	int ret;
+
+	pdev = platform_device_alloc("mach_hda_generic", -1);
+	if (!pdev) {
+		dev_dbg(dev, "failed to allocate hda device\n");
+		return -1;
+	}
+
+	ret = platform_device_add(pdev);
+	if (ret) {
+		dev_err(dev, "failed to add generic machine device\n");
+		platform_device_put(pdev);
+		return -1;
+	}
+
+	return 0;
+}
+
+static int azx_add_codec_device(int addr, struct hdac_bus *bus)
+{
+	struct hdac_device *hdev = NULL;
+	char name[10];
+	int ret;
+
+	hdev = devm_kzalloc(bus->dev, sizeof(*hdev), GFP_KERNEL);
+	if (!hdev)
+		return -ENOMEM;
+
+	snprintf(name, sizeof(name), "codec#%03x", addr);
+
+	ret  = snd_hdac_device_init(hdev, bus, name, addr);
+	if (ret < 0) {
+		dev_err(bus->dev, "device init failed for hdac device\n");
+		return ret;
+	}
+	hdev->type = HDA_DEV_ASOC;
+
+	ret = snd_hdac_device_register(hdev);
+	if (ret) {
+		dev_err(bus->dev, "failed to register hdac device\n");
+		snd_hdac_device_exit(hdev);
+		return ret;
+	}
+	return 0;
+}
+
+/*
+ * Probe the given codec address
+ */
+static int probe_codec(struct hdac_bus *chip, int addr)
+{
+	unsigned int cmd = (addr << 28) | (AC_NODE_ROOT << 20) |
+		(AC_VERB_PARAMETERS << 8) | AC_PAR_VENDOR_ID;
+	unsigned int res;
+
+	mutex_lock(&chip->cmd_mutex);
+	snd_hdac_bus_send_cmd(chip, cmd);
+	snd_hdac_bus_get_response(chip, addr, &res);
+	mutex_unlock(&chip->cmd_mutex);
+	if (res == -1)
+		return -EIO;
+	dev_dbg(chip->dev, "codec #%d probed OK\n", addr);
+	return azx_add_codec_device(addr, chip);
+}
+
+/* Codec initialization */
+int azx_codec_create(struct hdac_bus *chip, const char *model)
+{
+	int c, max_slots;
+
+	max_slots = HDA_MAX_CODECS;
+
+	/* First try to probe all given codec slots */
+	for (c = 0; c < max_slots; c++) {
+		if ((chip->codec_mask & (1 << c))) {
+			if (probe_codec(chip, c) < 0) {
+				/* Some BIOSen give you wrong codec addresses
+				 * that don't exist
+				 */
+				dev_warn(chip->dev,
+					 "Codec #%d probe error; disabling it...\n", c);
+				chip->codec_mask &= ~(1 << c);
+				/* More badly, accessing to a non-existing
+				 * codec often screws up the controller chip,
+				 * and disturbs the further communications.
+				 * Thus if an error occurs during probing,
+				 * better to reset the controller chip to
+				 * get back to the sanity state.
+				 */
+				snd_hdac_bus_stop_chip(chip);
+				snd_hdac_bus_init_chip(chip, true);
+			}
+		}
+	}
+	return 0;
+}
+
+static const struct hdac_bus_ops bus_core_ops = {
+	.command = snd_hdac_bus_send_cmd,
+	.get_response = snd_hdac_bus_get_response,
+};
+
+/*
+ * constructor
+ */
+static int azx_create(struct pci_dev *pci,
+		      const struct hdac_io_ops *io_ops,
+		      struct hda_soc_bus **rhda)
+{
+	struct hda_soc_bus *hda;
+	struct hdac_bus *chip;
+
+	int err;
+
+	*rhda = NULL;
+
+	err = pci_enable_device(pci);
+	if (err < 0)
+		return err;
+
+	hda = devm_kzalloc(&pci->dev, sizeof(*hda), GFP_KERNEL);
+	if (!hda) {
+		pci_disable_device(pci);
+		return -ENOMEM;
+	}
+	chip = &hda->chip;
+	snd_hdac_bus_init(chip, &pci->dev, &bus_core_ops, io_ops);
+	chip->use_posbuf = 1;
+	hda->pci = pci;
+	check_msi(chip);
+
+	azx_check_snoop_available(chip);
+
+	if (bdl_pos_adj < 0)
+		bdl_pos_adj = 0;
+	chip->bdl_pos_adj = bdl_pos_adj;
+
+	*rhda = hda;
+	return 0;
+}
+
+static int azx_first_init(struct hdac_bus *chip)
+{
+	struct hda_soc_bus *hda = container_of(chip, struct hda_soc_bus, chip);
+	struct pci_dev *pci = hda->pci;
+	int err;
+	unsigned short gcap;
+	int capture_streams, playback_streams;
+
+	err = pci_request_regions(pci, "ICH HD audio");
+	if (err < 0)
+		return err;
+
+	chip->addr = pci_resource_start(pci, 0);
+	chip->remap_addr = pci_ioremap_bar(pci, 0);
+	if (chip->remap_addr == NULL) {
+		dev_err(chip->dev, "ioremap error\n");
+		return -ENXIO;
+	}
+
+	if (hda->msi)
+		if (pci_enable_msi(pci) < 0)
+			hda->msi = 0;
+
+	if (azx_acquire_irq(chip, 0) < 0)
+		return -EBUSY;
+
+	pci_set_master(pci);
+	synchronize_irq(pci->irq);
+
+	gcap = snd_hdac_chip_readw(chip, GCAP);
+	dev_dbg(chip->dev, "chipset global capabilities = 0x%x\n", gcap);
+
+	/* allow 64bit DMA address if supported by H/W */
+	if (!pci_set_dma_mask(pci, DMA_BIT_MASK(64)))
+		pci_set_consistent_dma_mask(pci, DMA_BIT_MASK(64));
+	else {
+		pci_set_dma_mask(pci, DMA_BIT_MASK(32));
+		pci_set_consistent_dma_mask(pci, DMA_BIT_MASK(32));
+	}
+
+	/* read number of streams from GCAP register instead of using
+	 * hardcoded value
+	 */
+	capture_streams = (gcap >> 8) & 0x0f;
+	playback_streams = (gcap >> 12) & 0x0f;
+	if (!playback_streams && !capture_streams)
+		return -EIO;
+
+	/* initialize streams */
+	azx_init_stream(chip, capture_streams, SNDRV_PCM_STREAM_CAPTURE);
+	azx_init_stream(chip, playback_streams, SNDRV_PCM_STREAM_PLAYBACK);
+
+	err = snd_hdac_bus_alloc_stream_pages(chip);
+	if (err < 0)
+		return err;
+
+	/* initialize chip */
+	azx_init_pci(chip);
+
+	snd_hdac_bus_init_chip(chip, (probe_only & 2) == 0);
+
+	/* codec detection */
+	if (!chip->codec_mask) {
+		dev_err(chip->dev, "no codecs found!\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+/*
+ * HDA controller ops.
+ */
+
+/* PCI register access. */
+static void pci_azx_writel(u32 value, u32 __iomem *addr)
+{
+	writel(value, addr);
+}
+
+static u32 pci_azx_readl(u32 __iomem *addr)
+{
+	return readl(addr);
+}
+
+static void pci_azx_writew(u16 value, u16 __iomem *addr)
+{
+	writew(value, addr);
+}
+
+static u16 pci_azx_readw(u16 __iomem *addr)
+{
+	return readw(addr);
+}
+
+static void pci_azx_writeb(u8 value, u8 __iomem *addr)
+{
+	writeb(value, addr);
+}
+
+static u8 pci_azx_readb(u8 __iomem *addr)
+{
+	return readb(addr);
+}
+
+/* DMA page allocation helpers.  */
+static int dma_alloc_pages(struct hdac_bus *chip,
+			   int type,
+			   size_t size,
+			   struct snd_dma_buffer *buf)
+{
+	int err;
+
+	err = snd_dma_alloc_pages(type,
+				  chip->dev,
+				  size, buf);
+	if (err < 0)
+		return err;
+	return 0;
+}
+
+static void dma_free_pages(struct hdac_bus *chip, struct snd_dma_buffer *buf)
+{
+	snd_dma_free_pages(buf);
+}
+
+static const struct hdac_io_ops hda_io_ops = {
+	.reg_writel = pci_azx_writel,
+	.reg_readl = pci_azx_readl,
+	.reg_writew = pci_azx_writew,
+	.reg_readw = pci_azx_readw,
+	.reg_writeb = pci_azx_writeb,
+	.reg_readb = pci_azx_readb,
+	.dma_alloc_pages = dma_alloc_pages,
+	.dma_free_pages = dma_free_pages,
+};
+
+static int azx_probe(struct pci_dev *pci,
+		     const struct pci_device_id *pci_id)
+{
+	struct hda_soc_bus *hda;
+	struct hdac_bus *chip = NULL;
+	int err;
+
+	err = azx_create(pci, &hda_io_ops, &hda);
+	if (err < 0)
+		return err;
+
+	chip = &hda->chip;
+
+	err = azx_first_init(chip);
+	if (err < 0)
+		goto out_free;
+
+	/* register platfrom dai and controls */
+	err = soc_hda_platform_register(chip->dev);
+	if (err < 0)
+		goto out_free;
+	/* create codec instances */
+	err = azx_codec_create(chip, model);
+	if (err < 0)
+		goto out_unregister;
+
+	pci_set_drvdata(hda->pci, chip);
+
+	err = azx_load_generic_mach(chip->dev);
+	if (err < 0)
+		goto out_unregister;
+
+	/*configure PM */
+	pm_runtime_set_autosuspend_delay(chip->dev, HDA_SKL_SUSPEND_DELAY);
+	pm_runtime_use_autosuspend(chip->dev);
+	pm_runtime_put_noidle(chip->dev);
+	pm_runtime_allow(chip->dev);
+
+	pci_set_drvdata(hda->pci, chip);
+	return 0;
+
+out_unregister:
+	soc_hda_platform_unregister(chip->dev);
+out_free:
+	hda->init_failed = 1;
+	azx_free(chip);
+	snd_hdac_bus_exit(chip);
+	pci_set_drvdata(hda->pci, NULL);
+	return err;
+}
+
+static void azx_remove(struct pci_dev *pci)
+{
+	struct hdac_bus *chip = pci_get_drvdata(pci);
+
+	if (pci_dev_run_wake(pci))
+		pm_runtime_get_noresume(&pci->dev);
+	pci_dev_put(pci);
+	soc_hda_platform_unregister(&pci->dev);
+	azx_free(chip);
+	snd_hdac_bus_exit(chip);
+	dev_set_drvdata(&pci->dev, NULL);
+}
+
+/* PCI IDs */
+static const struct pci_device_id azx_ids[] = {
+	/* Sunrise Point-LP */
+	{ PCI_DEVICE(0x8086, 0x9d70), 0},
+	{ 0, }
+};
+MODULE_DEVICE_TABLE(pci, azx_ids);
+
+/* pci_driver definition */
+static struct pci_driver azx_driver = {
+	.name = KBUILD_MODNAME,
+	.id_table = azx_ids,
+	.probe = azx_probe,
+	.remove = azx_remove,
+	.driver = {
+		.pm = &azx_pm,
+	},
+};
+
+module_pci_driver(azx_driver);
diff --git a/sound/soc/hda/hda_skl.h b/sound/soc/hda/hda_skl.h
new file mode 100644
index 000000000000..0cc2ac69a9ab
--- /dev/null
+++ b/sound/soc/hda/hda_skl.h
@@ -0,0 +1,44 @@
+/*
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the Free
+ *  Software Foundation; either version 2 of the License, or (at your option)
+ *  any later version.
+ *
+ *  This program is distributed in the hope that it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ *  more details.
+ */
+
+#ifndef __SOUND_SOC_HDA_SKL_H
+#define __SOUND_SOC_HDA_SKL_H
+
+#include <sound/core.h>
+#include <sound/initval.h>
+#include <sound/hda_register.h>
+#include <sound/hdaudio.h>
+
+#define HDA_SKL_SUSPEND_DELAY 2000
+
+struct hda_soc_bus {
+	struct hdac_bus chip;
+	struct pci_dev *pci;
+
+	unsigned int init_failed:1; /* delayed init failed */
+	unsigned int msi:1;
+};
+
+/* to pass dai dma data */
+struct soc_hda_dma_params {
+	u32 format;
+	u8 stream_tag;
+};
+
+int azx_get_delay_from_lpib(struct hdac_bus *chip,
+				struct hdac_stream *azx_dev,
+				unsigned int pos);
+void  azx_position_check(struct hdac_bus *chip,	struct hdac_stream *azx_dev);
+
+int soc_hda_platform_unregister(struct device *dev);
+int soc_hda_platform_register(struct device *dev);
+#endif /* __SOUND_SOC_HDA_SKL_H */
-- 
1.7.9.5
