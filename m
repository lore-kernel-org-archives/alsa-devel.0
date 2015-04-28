From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v3 5/7] ASoC: intel - add Skylake HDA audio
	driver
Date: Wed, 29 Apr 2015 01:24:28 +0530
Message-ID: <1430250870-3169-6-git-send-email-vinod.koul@intel.com>
References: <1430250870-3169-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 2DEA3265057
 for <alsa-devel@alsa-project.org>; Tue, 28 Apr 2015 21:57:39 +0200 (CEST)
In-Reply-To: <1430250870-3169-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

This patch follows up by adding the HDA controller operations. This code is
mostly derived from Intel HDA PCI driver without legacy bits

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/hda-skl.c |  721 +++++++++++++++++++++++++++++++++++++
 sound/soc/intel/skylake/hda-skl.h |   73 ++++
 2 files changed, 794 insertions(+)
 create mode 100644 sound/soc/intel/skylake/hda-skl.c
 create mode 100644 sound/soc/intel/skylake/hda-skl.h

diff --git a/sound/soc/intel/skylake/hda-skl.c b/sound/soc/intel/skylake/hda-skl.c
new file mode 100644
index 000000000000..24502f8e796d
--- /dev/null
+++ b/sound/soc/intel/skylake/hda-skl.c
@@ -0,0 +1,721 @@
+/*
+ *  hda-skl.c - Implementation of primary ASoC Intel HD Audio driver
+ *
+ *  Copyright (C) 2014-2015 Intel Corp
+ *  Author: Jeeja KP <jeeja.kp@intel.com>
+ *
+ *  Derived mostly from Intel HDA driver with following copyrights:
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
+#include "hda-skl.h"
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
+static void azx_init_pci(struct hda_skl *hda)
+{
+	struct soc_hdac_bus *sbus = &hda->sbus;
+
+	/*
+	 * Clear bits 0-2 of PCI register TCSEL (at offset 0x44)
+	 * TCSEL == Traffic Class Select Register, which sets PCI express QOS
+	 * Ensuring these bits are 0 clears playback static on some HD Audio
+	 * codecs.
+	 * The PCI register TCSEL is defined in the Intel manuals.
+	 */
+	dev_dbg(hdac_bus(sbus)->dev, "Clearing TCSEL\n");
+	update_pci_byte(hda->pci, AZX_PCIREG_TCSEL, 0x07, 0);
+}
+
+/*
+ * Check whether the current DMA position is acceptable for updating
+ * periods.  Returns non-zero if it's OK.
+ */
+static int azx_position_ok(struct hdac_bus *bus, struct hdac_stream *stream)
+{
+	u32 wallclk;
+	unsigned int pos = 0;
+
+	wallclk = snd_hdac_chip_readl(bus, WALLCLK) - stream->start_wallclk;
+	if (wallclk < (stream->period_wallclk * 2) / 3)
+		return -1;	/* bogus (too early) interrupt */
+
+	if (bus->use_posbuf) {
+		/* use the position buffer as default */
+		pos = snd_hdac_stream_get_pos_posbuf(stream);
+		if (!pos || pos == (u32)-1) {
+			dev_info(bus->dev,
+				 "Invalid pos buffer, using LPIB read method instead.\n");
+			pos = snd_hdac_stream_get_pos_lpib(stream);
+		}
+	}
+
+	if (pos >= stream->bufsize)
+		pos = 0;
+
+	if (WARN_ONCE(!stream->period_bytes,
+		      "hda-skl: zero stream->period_bytes"))
+		return -1; /* this shouldn't happen! */
+
+	if (wallclk < (stream->period_wallclk * 5) / 4 &&
+	    pos % stream->period_bytes > stream->period_bytes / 2)
+		/* NG - it's below the first next period boundary */
+		return bus->bdl_pos_adj ? 0 : -1;
+
+	stream->start_wallclk += wallclk;
+
+	return 1; /* OK, it's fine */
+}
+
+/* called from IRQ */
+static void stream_update(struct hdac_bus *bus, struct hdac_stream *hstr)
+{
+	if (azx_position_ok(bus, hstr) > 0)
+		snd_pcm_period_elapsed(hstr->substream);
+}
+
+static irqreturn_t azx_interrupt(int irq, void *dev_id)
+{
+	struct soc_hdac_bus *sbus = dev_id;
+	struct hdac_bus *bus = hdac_bus(sbus);
+	u32 status;
+
+#ifdef CONFIG_PM
+	if (!pm_runtime_active(bus->dev))
+		return IRQ_NONE;
+#endif
+
+	spin_lock(&bus->reg_lock);
+
+	status = snd_hdac_chip_readl(bus, INTSTS);
+	if (status == 0 || status == 0xffffffff) {
+		spin_unlock(&bus->reg_lock);
+		return IRQ_NONE;
+	}
+
+	/* clear rirb int */
+	status = snd_hdac_chip_readb(bus, RIRBSTS);
+	if (status & RIRB_INT_MASK) {
+		if (status & RIRB_INT_RESPONSE)
+			snd_hdac_bus_update_rirb(bus);
+		snd_hdac_chip_writeb(bus, RIRBSTS, RIRB_INT_MASK);
+		return IRQ_HANDLED;
+	}
+
+	spin_unlock(&bus->reg_lock);
+
+	return IRQ_WAKE_THREAD;
+}
+
+static irqreturn_t azx_threaded_handler(int irq, void *dev_id)
+{
+	struct soc_hdac_bus *sbus = dev_id;
+	struct hdac_bus *bus = hdac_bus(sbus);
+	u32 status;
+	unsigned long cookie;
+
+	status = snd_hdac_chip_readl(bus, INTSTS);
+	spin_lock_irqsave(&bus->reg_lock, cookie);
+
+	snd_hdac_bus_handle_stream_irq(bus, status, stream_update);
+
+	spin_unlock_irqrestore(&bus->reg_lock, cookie);
+
+	return IRQ_HANDLED;
+}
+
+/* initialize SD streams, use seprate streeam tag for PB and CP */
+static int azx_init_stream(struct soc_hdac_bus *sbus, int num_stream, int dir)
+{
+	int i, tag;
+	int stream_tag = 0;
+
+	for (i = 0; i < num_stream; i++) {
+		struct soc_hdac_stream *stream =
+				kzalloc(sizeof(*stream), GFP_KERNEL);
+		if (!stream)
+			return -ENOMEM;
+		tag = ++stream_tag;
+		snd_soc_hdac_stream_init(sbus, stream, i, dir, tag);
+	}
+	return 0;
+}
+
+static void azx_free_streams(struct soc_hdac_bus *sbus)
+{
+	struct hdac_stream *s;
+	struct soc_hdac_stream *stream;
+	struct hdac_bus *bus = hdac_bus(sbus);
+
+	while (!list_empty(&bus->stream_list)) {
+		s = list_first_entry(&bus->stream_list, struct hdac_stream, list);
+		stream = stream_to_soc_hdac_stream(s);
+		list_del(&s->list);
+		kfree(stream);
+	}
+}
+
+static int azx_acquire_irq(struct soc_hdac_bus *sbus, int do_disconnect)
+{
+	struct hda_skl *hda = to_hda_skl(sbus);
+	struct hdac_bus *bus = hdac_bus(sbus);
+	int ret = 0;
+
+	ret = request_threaded_irq(hda->pci->irq, azx_interrupt,
+			azx_threaded_handler,
+			hda->msi ? 0 : IRQF_SHARED,
+			KBUILD_MODNAME, sbus);
+	if (ret) {
+		dev_err(bus->dev,
+			"unable to grab IRQ %d, disabling device\n",
+			hda->pci->irq);
+		return ret;
+	}
+
+	bus->irq = hda->pci->irq;
+	pci_intx(hda->pci, !hda->msi);
+	return ret;
+}
+
+#ifdef CONFIG_PM_SLEEP
+/*
+ * power management
+ */
+static int azx_suspend(struct device *dev)
+{
+	struct pci_dev *pci = to_pci_dev(dev);
+	struct soc_hdac_bus *sbus = pci_get_drvdata(pci);
+	struct hdac_bus *bus = hdac_bus(sbus);
+	struct hda_skl *hda = to_hda_skl(sbus);
+
+	snd_hdac_bus_stop_chip(bus);
+	snd_hdac_bus_enter_link_reset(bus);
+	if (bus->irq >= 0) {
+		free_irq(bus->irq, bus);
+		bus->irq = -1;
+	}
+
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
+	struct soc_hdac_bus *sbus = pci_get_drvdata(pci);
+	struct hdac_bus *bus = hdac_bus(sbus);
+	struct hda_skl *hda = to_hda_skl(sbus);
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
+	if (azx_acquire_irq(sbus, 1) < 0)
+		return -EIO;
+	azx_init_pci(hda);
+
+	snd_hdac_bus_init_chip(bus, 1);
+	return 0;
+}
+#endif /* CONFIG_PM_SLEEP */
+
+#ifdef CONFIG_PM
+static int azx_runtime_suspend(struct device *dev)
+{
+	struct pci_dev *pci = to_pci_dev(dev);
+	struct soc_hdac_bus *sbus = pci_get_drvdata(pci);
+	struct hdac_bus *bus = hdac_bus(sbus);
+
+	dev_dbg(bus->dev, "in %s\n", __func__);
+
+	/* enable controller wake up event */
+	snd_hdac_chip_updatew(bus, WAKEEN, 0, STATESTS_INT_MASK);
+
+	snd_hdac_bus_stop_chip(bus);
+	snd_hdac_bus_enter_link_reset(bus);
+	return 0;
+}
+
+static int azx_runtime_resume(struct device *dev)
+{
+	struct pci_dev *pci = to_pci_dev(dev);
+	struct soc_hdac_bus *sbus = pci_get_drvdata(pci);
+	struct hdac_bus *bus = hdac_bus(sbus);
+	struct hda_skl *hda = to_hda_skl(sbus);
+	int status;
+
+	dev_dbg(bus->dev, "in %s\n", __func__);
+
+	/* Read STATESTS before controller reset */
+	status = snd_hdac_chip_readw(bus, STATESTS);
+
+	azx_init_pci(hda);
+	snd_hdac_bus_init_chip(bus, true);
+	/* disable controller Wake Up event */
+	snd_hdac_chip_updatew(bus, WAKEEN, STATESTS_INT_MASK, 0);
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
+static int azx_free(struct soc_hdac_bus *sbus)
+{
+	struct hda_skl *hda = to_hda_skl(sbus);
+	struct hdac_bus *bus = hdac_bus(sbus);
+
+	hda->init_failed = 1; /* to be sure */
+
+	snd_soc_hdac_stop_streams(sbus);
+
+	if (bus->irq >= 0)
+		free_irq(bus->irq, (void *)bus);
+	if (hda->msi)
+		pci_disable_msi(hda->pci);
+	if (bus->remap_addr)
+		iounmap(bus->remap_addr);
+
+	snd_hdac_bus_free_stream_pages(bus);
+	azx_free_streams(sbus);
+	pci_release_regions(hda->pci);
+	pci_disable_device(hda->pci);
+
+	snd_hdac_bus_exit(bus);
+	return 0;
+}
+
+static int hda_dmic_device_register(struct hda_skl *hda)
+{
+	struct hdac_bus *bus = hdac_bus(&hda->sbus);
+	struct platform_device *pdev;
+	int ret;
+
+	pdev = platform_device_alloc("dmic-codec", -1);
+	if (!pdev) {
+		dev_err(bus->dev, "failed to allocate dmic device\n");
+		return -1;
+	}
+
+	ret = platform_device_add(pdev);
+	if (ret) {
+		dev_err(bus->dev, "failed to add hda codec device\n");
+		platform_device_put(pdev);
+		return -1;
+	}
+	hda->dmic_dev = pdev;
+	return 0;
+}
+
+static void hda_dmic_device_unregister(struct hda_skl *hda)
+{
+
+	if (hda->dmic_dev)
+		platform_device_unregister(hda->dmic_dev);
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
+static int probe_codec(struct soc_hdac_bus *sbus, int addr)
+{
+	struct hdac_bus *bus = hdac_bus(sbus);
+	unsigned int cmd = (addr << 28) | (AC_NODE_ROOT << 20) |
+		(AC_VERB_PARAMETERS << 8) | AC_PAR_VENDOR_ID;
+	unsigned int res;
+
+	mutex_lock(&bus->cmd_mutex);
+	snd_hdac_bus_send_cmd(bus, cmd);
+	snd_hdac_bus_get_response(bus, addr, &res);
+	mutex_unlock(&bus->cmd_mutex);
+	if (res == -1)
+		return -EIO;
+	dev_dbg(bus->dev, "codec #%d probed OK\n", addr);
+	return azx_add_codec_device(addr, bus);
+}
+
+/* Codec initialization */
+static int azx_codec_create(struct soc_hdac_bus *sbus)
+{
+	struct hdac_bus *bus = hdac_bus(sbus);
+	int c, max_slots;
+
+	max_slots = HDA_MAX_CODECS;
+
+	/* First try to probe all given codec slots */
+	for (c = 0; c < max_slots; c++) {
+		if ((bus->codec_mask & (1 << c))) {
+			if (probe_codec(sbus, c) < 0) {
+				/* Some BIOSen give you wrong codec addresses
+				 * that don't exist
+				 */
+				dev_warn(bus->dev,
+					 "Codec #%d probe error; disabling it...\n", c);
+				bus->codec_mask &= ~(1 << c);
+				/* More badly, accessing to a non-existing
+				 * codec often screws up the controller bus,
+				 * and disturbs the further communications.
+				 * Thus if an error occurs during probing,
+				 * better to reset the controller bus to
+				 * get back to the sanity state.
+				 */
+				snd_hdac_bus_stop_chip(bus);
+				snd_hdac_bus_init_chip(bus, true);
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
+		      struct hda_skl **rhda)
+{
+	struct hda_skl *hda;
+	struct soc_hdac_bus *sbus;
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
+	sbus = &hda->sbus;
+	snd_hdac_bus_init(&sbus->bus, &pci->dev, &bus_core_ops, io_ops);
+	sbus->bus.use_posbuf = 1;
+	hda->pci = pci;
+	hda->msi = 1;
+
+	sbus->bus.bdl_pos_adj = 0;
+
+	*rhda = hda;
+	return 0;
+}
+
+static int azx_first_init(struct soc_hdac_bus *sbus)
+{
+	struct hda_skl *hda = to_hda_skl(sbus);
+	struct hdac_bus *bus = hdac_bus(sbus);
+	struct pci_dev *pci = hda->pci;
+	int err;
+	unsigned short gcap;
+	int capture_streams, playback_streams;
+
+	err = pci_request_regions(pci, "ICH HD audio");
+	if (err < 0)
+		return err;
+
+	bus->addr = pci_resource_start(pci, 0);
+	bus->remap_addr = pci_ioremap_bar(pci, 0);
+	if (bus->remap_addr == NULL) {
+		dev_err(bus->dev, "ioremap error\n");
+		return -ENXIO;
+	}
+
+	if (hda->msi)
+		if (pci_enable_msi(pci) < 0)
+			hda->msi = 0;
+
+	if (azx_acquire_irq(sbus, 0) < 0)
+		return -EBUSY;
+
+	pci_set_master(pci);
+	synchronize_irq(bus->irq);
+
+	gcap = snd_hdac_chip_readw(bus, GCAP);
+	dev_dbg(bus->dev, "chipset global capabilities = 0x%x\n", gcap);
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
+	sbus->num_streams = capture_streams + playback_streams;
+	/* initialize streams */
+	azx_init_stream(sbus, capture_streams, SNDRV_PCM_STREAM_CAPTURE);
+	azx_init_stream(sbus, playback_streams, SNDRV_PCM_STREAM_PLAYBACK);
+
+	err = snd_hdac_bus_alloc_stream_pages(bus);
+	if (err < 0)
+		return err;
+
+	/* initialize chip */
+	azx_init_pci(hda);
+
+	snd_hdac_bus_init_chip(bus, true);
+
+	/* codec detection */
+	if (!bus->codec_mask) {
+		dev_err(bus->dev, "no codecs found!\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
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
+static int dma_alloc_pages(struct hdac_bus *bus,
+			   int type,
+			   size_t size,
+			   struct snd_dma_buffer *buf)
+{
+	int err;
+
+	err = snd_dma_alloc_pages(type,
+				  bus->dev,
+				  size, buf);
+	if (err < 0)
+		return err;
+	return 0;
+}
+
+static void dma_free_pages(struct hdac_bus *bus, struct snd_dma_buffer *buf)
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
+	struct hda_skl *hda;
+	struct soc_hdac_bus *sbus = NULL;
+	struct hdac_bus *bus = NULL;
+	int err;
+
+	err = azx_create(pci, &hda_io_ops, &hda);
+	if (err < 0)
+		return err;
+
+	sbus = &hda->sbus;
+	bus = hdac_bus(sbus);
+
+	err = azx_first_init(sbus);
+	if (err < 0)
+		goto out_free;
+
+	/*create device for soc dmic*/
+	err = hda_dmic_device_register(hda);
+	if (err < 0)
+		goto out_free;
+
+	/* register platform dai and controls */
+	err = soc_hda_platform_register(bus->dev);
+	if (err < 0)
+		goto out_dmic_free;
+	/* create codec instances */
+	err = azx_codec_create(sbus);
+	if (err < 0)
+		goto out_unregister;
+
+	pci_set_drvdata(hda->pci, sbus);
+
+	/*configure PM */
+	pm_runtime_set_autosuspend_delay(bus->dev, HDA_SKL_SUSPEND_DELAY);
+	pm_runtime_use_autosuspend(bus->dev);
+	pm_runtime_put_noidle(bus->dev);
+	pm_runtime_allow(bus->dev);
+
+	pci_set_drvdata(hda->pci, sbus);
+	return 0;
+
+out_unregister:
+	soc_hda_platform_unregister(bus->dev);
+out_dmic_free:
+	hda_dmic_device_unregister(hda);
+out_free:
+	hda->init_failed = 1;
+	azx_free(sbus);
+	pci_set_drvdata(hda->pci, NULL);
+	return err;
+}
+
+static void azx_remove(struct pci_dev *pci)
+{
+	struct soc_hdac_bus *sbus = pci_get_drvdata(pci);
+	struct hda_skl *hda = to_hda_skl(sbus);
+
+	if (pci_dev_run_wake(pci))
+		pm_runtime_get_noresume(&pci->dev);
+	pci_dev_put(pci);
+	soc_hda_platform_unregister(&pci->dev);
+	hda_dmic_device_unregister(hda);
+	azx_free(sbus);
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
diff --git a/sound/soc/intel/skylake/hda-skl.h b/sound/soc/intel/skylake/hda-skl.h
new file mode 100644
index 000000000000..ed6ccd31b198
--- /dev/null
+++ b/sound/soc/intel/skylake/hda-skl.h
@@ -0,0 +1,73 @@
+/*
+ *  hda-skl.h - HD Audio skylake defintions.
+ *
+ *  Copyright (C) 2015 Intel Corp
+ *  Author: Jeeja KP <jeeja.kp@intel.com>
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
+ *
+ */
+
+#ifndef __SOUND_SOC_HDA_SKL_H
+#define __SOUND_SOC_HDA_SKL_H
+
+#include <sound/core.h>
+#include <sound/initval.h>
+#include <sound/hda_register.h>
+#include <sound/hdaudio.h>
+#include <sound/soc-hdaudio.h>
+
+#define HDA_SKL_SUSPEND_DELAY 2000
+
+/* Vendor Specific Registers */
+#define AZX_REG_VS_EM1			0x1000
+#define AZX_REG_VS_INRC			0x1004
+#define AZX_REG_VS_OUTRC		0x1008
+#define AZX_REG_VS_FIFOTRK		0x100C
+#define AZX_REG_VS_FIFOTRK2		0x1010
+#define AZX_REG_VS_EM2			0x1030
+#define AZX_REG_VS_EM3L			0x1038
+#define AZX_REG_VS_EM3U			0x103C
+#define AZX_REG_VS_EM4L			0x1040
+#define AZX_REG_VS_EM4U			0x1044
+#define AZX_REG_VS_LTRC			0x1048
+#define AZX_REG_VS_D0I3C		0x104A
+#define AZX_REG_VS_PCE			0x104B
+#define AZX_REG_VS_L2MAGC		0x1050
+#define AZX_REG_VS_L2LAHPT		0x1054
+#define AZX_REG_VS_SDXDPIB_XBASE	0x1084
+#define AZX_REG_VS_SDXDPIB_XINTERVAL	0x20
+#define AZX_REG_VS_SDXEFIFOS_XBASE	0x1094
+#define AZX_REG_VS_SDXEFIFOS_XINTERVAL	0x20
+struct hda_skl {
+	struct soc_hdac_bus sbus;
+	struct pci_dev *pci;
+
+	unsigned int init_failed:1; /* delayed init failed */
+	unsigned int msi:1;
+	struct platform_device *dmic_dev;
+};
+
+#define soc_hdac_bus(s)	(&(s)->sbus)
+#define to_hda_skl(sbus) \
+	container_of(sbus, struct hda_skl, sbus)
+
+/* to pass dai dma data */
+struct soc_hda_dma_params {
+	u32 format;
+	u8 stream_tag;
+};
+
+int soc_hda_platform_unregister(struct device *dev);
+int soc_hda_platform_register(struct device *dev);
+#endif /* __SOUND_SOC_HDA_SKL_H */
-- 
1.7.9.5
