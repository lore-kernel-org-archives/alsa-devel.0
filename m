From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v5 2/4] ASoC: Intel - add Skylake HDA audio
	driver
Date: Thu, 11 Jun 2015 22:03:56 +0530
Message-ID: <1434040438-14535-3-git-send-email-vinod.koul@intel.com>
References: <1434040438-14535-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 16E5E26657D
 for <alsa-devel@alsa-project.org>; Thu, 11 Jun 2015 18:32:52 +0200 (CEST)
In-Reply-To: <1434040438-14535-1-git-send-email-vinod.koul@intel.com>
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

This patch follows up by adding the HDA controller operations. This
code is mostly derived from Intel HDA PCI driver without legacy bits

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl.c | 635 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 635 insertions(+)
 create mode 100644 sound/soc/intel/skylake/skl.c

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
new file mode 100644
index 000000000000..c6f4902af9d0
--- /dev/null
+++ b/sound/soc/intel/skylake/skl.c
@@ -0,0 +1,635 @@
+/*
+ *  skl.c - Implementation of ASoC Intel SKL HD Audio driver
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
+#include "skl.h"
+
+/*
+ * initialize the PCI registers
+ */
+static void skl_update_pci_byte(struct pci_dev *pci, unsigned int reg,
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
+static void skl_init_pci(struct skl *skl)
+{
+	struct hdac_ext_bus *ebus = &skl->ebus;
+
+	/*
+	 * Clear bits 0-2 of PCI register TCSEL (at offset 0x44)
+	 * TCSEL == Traffic Class Select Register, which sets PCI express QOS
+	 * Ensuring these bits are 0 clears playback static on some HD Audio
+	 * codecs.
+	 * The PCI register TCSEL is defined in the Intel manuals.
+	 */
+	dev_dbg(ebus_to_hbus(ebus)->dev, "Clearing TCSEL\n");
+	skl_update_pci_byte(skl->pci, AZX_PCIREG_TCSEL, 0x07, 0);
+}
+
+/* called from IRQ */
+static void skl_stream_update(struct hdac_bus *bus, struct hdac_stream *hstr)
+{
+	snd_pcm_period_elapsed(hstr->substream);
+}
+
+static irqreturn_t skl_interrupt(int irq, void *dev_id)
+{
+	struct hdac_ext_bus *ebus = dev_id;
+	struct hdac_bus *bus = ebus_to_hbus(ebus);
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
+	}
+
+	spin_unlock(&bus->reg_lock);
+
+	return snd_hdac_chip_readl(bus, INTSTS) ? IRQ_WAKE_THREAD : IRQ_HANDLED;
+}
+
+static irqreturn_t skl_threaded_handler(int irq, void *dev_id)
+{
+	struct hdac_ext_bus *ebus = dev_id;
+	struct hdac_bus *bus = ebus_to_hbus(ebus);
+	u32 status;
+
+	status = snd_hdac_chip_readl(bus, INTSTS);
+
+	snd_hdac_bus_handle_stream_irq(bus, status, skl_stream_update);
+
+	return IRQ_HANDLED;
+}
+
+/* initialize SD streams, use seprate streeam tag for PB and CP */
+static int skl_init_stream(struct hdac_ext_bus *ebus, int start_idx,
+				int num_stream, int dir)
+{
+	int stream_tag = 0;
+	int i, tag, idx = start_idx;
+
+	for (i = 0; i < num_stream; i++) {
+		struct hdac_ext_stream *stream =
+				kzalloc(sizeof(*stream), GFP_KERNEL);
+		if (!stream)
+			return -ENOMEM;
+		tag = ++stream_tag;
+		snd_hdac_ext_stream_init(ebus, stream, idx, dir, tag);
+		idx++;
+	}
+
+	return 0;
+}
+
+static void skl_free_streams(struct hdac_ext_bus *ebus)
+{
+	struct hdac_stream *s;
+	struct hdac_ext_stream *stream;
+	struct hdac_bus *bus = ebus_to_hbus(ebus);
+
+	while (!list_empty(&bus->stream_list)) {
+		s = list_first_entry(&bus->stream_list, struct hdac_stream, list);
+		stream = stream_to_hdac_ext_stream(s);
+		list_del(&s->list);
+		kfree(stream);
+	}
+}
+
+static void skl_free_hda_links(struct hdac_ext_bus *ebus)
+{
+	struct hdac_ext_link *l;
+
+	while (!list_empty(&ebus->hlink_list)) {
+		l = list_first_entry(&ebus->hlink_list, struct hdac_ext_link, list);
+		list_del(&l->list);
+		kfree(l);
+	}
+}
+
+static int skl_acquire_irq(struct hdac_ext_bus *ebus, int do_disconnect)
+{
+	struct skl *skl = ebus_to_skl(ebus);
+	struct hdac_bus *bus = ebus_to_hbus(ebus);
+	int ret = 0;
+
+	ret = request_threaded_irq(skl->pci->irq, skl_interrupt,
+			skl_threaded_handler,
+			IRQF_SHARED,
+			KBUILD_MODNAME, ebus);
+	if (ret) {
+		dev_err(bus->dev,
+			"unable to grab IRQ %d, disabling device\n",
+			skl->pci->irq);
+		return ret;
+	}
+
+	bus->irq = skl->pci->irq;
+	pci_intx(skl->pci, 1);
+	return ret;
+}
+
+#ifdef CONFIG_PM_SLEEP
+/*
+ * power management
+ */
+static int skl_suspend(struct device *dev)
+{
+	struct pci_dev *pci = to_pci_dev(dev);
+	struct hdac_ext_bus *ebus = pci_get_drvdata(pci);
+	struct hdac_bus *bus = ebus_to_hbus(ebus);
+
+	snd_hdac_bus_stop_chip(bus);
+	snd_hdac_bus_enter_link_reset(bus);
+	if (bus->irq >= 0) {
+		free_irq(bus->irq, bus);
+		bus->irq = -1;
+	}
+
+	return 0;
+}
+
+static int skl_resume(struct device *dev)
+{
+	struct pci_dev *pci = to_pci_dev(dev);
+	struct hdac_ext_bus *ebus = pci_get_drvdata(pci);
+	struct hdac_bus *bus = ebus_to_hbus(ebus);
+	struct skl *hda = ebus_to_skl(ebus);
+
+	if (skl_acquire_irq(ebus, 1) < 0)
+		return -EIO;
+	skl_init_pci(hda);
+
+	snd_hdac_bus_init_chip(bus, 1);
+	return 0;
+}
+#endif /* CONFIG_PM_SLEEP */
+
+#ifdef CONFIG_PM
+static int skl_runtime_suspend(struct device *dev)
+{
+	struct pci_dev *pci = to_pci_dev(dev);
+	struct hdac_ext_bus *ebus = pci_get_drvdata(pci);
+	struct hdac_bus *bus = ebus_to_hbus(ebus);
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
+static int skl_runtime_resume(struct device *dev)
+{
+	struct pci_dev *pci = to_pci_dev(dev);
+	struct hdac_ext_bus *ebus = pci_get_drvdata(pci);
+	struct hdac_bus *bus = ebus_to_hbus(ebus);
+	struct skl *hda = ebus_to_skl(ebus);
+	int status;
+
+	dev_dbg(bus->dev, "in %s\n", __func__);
+
+	/* Read STATESTS before controller reset */
+	status = snd_hdac_chip_readw(bus, STATESTS);
+
+	skl_init_pci(hda);
+	snd_hdac_bus_init_chip(bus, true);
+	/* disable controller Wake Up event */
+	snd_hdac_chip_updatew(bus, WAKEEN, STATESTS_INT_MASK, 0);
+	return 0;
+}
+#endif /* CONFIG_PM */
+
+static const struct dev_pm_ops skl_pm = {
+	SET_SYSTEM_SLEEP_PM_OPS(skl_suspend, skl_resume)
+	SET_RUNTIME_PM_OPS(skl_runtime_suspend, skl_runtime_resume, NULL)
+};
+
+/*
+ * destructor
+ */
+static int skl_free(struct hdac_ext_bus *ebus)
+{
+	struct skl *skl  = ebus_to_skl(ebus);
+	struct hdac_bus *bus = ebus_to_hbus(ebus);
+
+	skl->init_failed = 1; /* to be sure */
+
+	snd_hdac_ext_stop_streams(ebus);
+
+	if (bus->irq >= 0)
+		free_irq(bus->irq, (void *)bus);
+	if (bus->remap_addr)
+		iounmap(bus->remap_addr);
+
+	snd_hdac_bus_free_stream_pages(bus);
+	skl_free_streams(ebus);
+	skl_free_hda_links(ebus);
+	pci_release_regions(skl->pci);
+	pci_disable_device(skl->pci);
+
+	snd_hdac_ext_bus_exit(ebus);
+	return 0;
+}
+
+static int skl_dmic_device_register(struct skl *skl)
+{
+	struct hdac_bus *bus = ebus_to_hbus(&skl->ebus);
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
+	skl->dmic_dev = pdev;
+	return 0;
+}
+
+static void skl_dmic_device_unregister(struct skl *skl)
+{
+
+	if (skl->dmic_dev)
+		platform_device_unregister(skl->dmic_dev);
+}
+
+/*
+ * Probe the given codec address
+ */
+static int probe_codec(struct hdac_ext_bus *ebus, int addr)
+{
+	struct hdac_bus *bus = ebus_to_hbus(ebus);
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
+
+	return snd_hdac_ext_bus_device_init(ebus, addr);
+}
+
+/* Codec initialization */
+static int skl_codec_create(struct hdac_ext_bus *ebus)
+{
+	struct hdac_bus *bus = ebus_to_hbus(ebus);
+	int c, max_slots;
+
+	max_slots = HDA_MAX_CODECS;
+
+	/* First try to probe all given codec slots */
+	for (c = 0; c < max_slots; c++) {
+		if ((bus->codec_mask & (1 << c))) {
+			if (probe_codec(ebus, c) < 0) {
+				/*
+				 * Some BIOSen give you wrong codec addresses
+				 * that don't exist
+				 */
+				dev_warn(bus->dev,
+					 "Codec #%d probe error; disabling it...\n", c);
+				bus->codec_mask &= ~(1 << c);
+				/*
+				 * More badly, accessing to a non-existing
+				 * codec often screws up the controller bus,
+				 * and disturbs the further communications.
+				 * Thus if an error occurs during probing,
+				 * better to reset the controller bus to get
+				 * back to the sanity state.
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
+static int skl_create(struct pci_dev *pci,
+		      const struct hdac_io_ops *io_ops,
+		      struct skl **rskl)
+{
+	struct skl *skl;
+	struct hdac_ext_bus *ebus;
+
+	int err;
+
+	*rskl = NULL;
+
+	err = pci_enable_device(pci);
+	if (err < 0)
+		return err;
+
+	skl = devm_kzalloc(&pci->dev, sizeof(*skl), GFP_KERNEL);
+	if (!skl) {
+		pci_disable_device(pci);
+		return -ENOMEM;
+	}
+	ebus = &skl->ebus;
+	snd_hdac_ext_bus_init(ebus, &pci->dev, &bus_core_ops, io_ops);
+	ebus->bus.use_posbuf = 1;
+	skl->pci = pci;
+
+	ebus->bus.bdl_pos_adj = 0;
+
+	*rskl = skl;
+
+	return 0;
+}
+
+static int skl_first_init(struct hdac_ext_bus *ebus)
+{
+	struct skl *skl = ebus_to_skl(ebus);
+	struct hdac_bus *bus = ebus_to_hbus(ebus);
+	struct pci_dev *pci = skl->pci;
+	int err;
+	unsigned short gcap;
+	int cp_streams, pb_streams, start_idx;
+
+	err = pci_request_regions(pci, "Skylake HD audio");
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
+	if (skl_acquire_irq(ebus, 0) < 0)
+		return -EBUSY;
+
+	pci_set_master(pci);
+	synchronize_irq(bus->irq);
+
+	gcap = snd_hdac_chip_readw(bus, GCAP);
+	dev_dbg(bus->dev, "chipset global capabilities = 0x%x\n", gcap);
+
+	/* allow 64bit DMA address if supported by H/W */
+	if (!dma_set_mask(bus->dev, DMA_BIT_MASK(64)))
+		dma_set_coherent_mask(bus->dev, DMA_BIT_MASK(64));
+	else {
+		dma_set_mask(bus->dev, DMA_BIT_MASK(32));
+		dma_set_coherent_mask(bus->dev, DMA_BIT_MASK(32));
+	}
+
+	/* read number of streams from GCAP register */
+	cp_streams = (gcap >> 8) & 0x0f;
+	pb_streams = (gcap >> 12) & 0x0f;
+
+	if (!pb_streams && !cp_streams)
+		return -EIO;
+
+	ebus->num_streams = cp_streams + pb_streams;
+
+	/* initialize streams */
+	skl_init_stream(ebus, 0, cp_streams, SNDRV_PCM_STREAM_CAPTURE);
+	start_idx = cp_streams;
+	skl_init_stream(ebus, start_idx, pb_streams, SNDRV_PCM_STREAM_PLAYBACK);
+
+	err = snd_hdac_bus_alloc_stream_pages(bus);
+	if (err < 0)
+		return err;
+
+	/* initialize chip */
+	skl_init_pci(skl);
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
+static void skl_pci_writel(u32 value, u32 __iomem *addr)
+{
+	writel(value, addr);
+}
+
+static u32 skl_pci_readl(u32 __iomem *addr)
+{
+	return readl(addr);
+}
+
+static void skl_pci_writew(u16 value, u16 __iomem *addr)
+{
+	writew(value, addr);
+}
+
+static u16 skl_pci_readw(u16 __iomem *addr)
+{
+	return readw(addr);
+}
+
+static void skl_pci_writeb(u8 value, u8 __iomem *addr)
+{
+	writeb(value, addr);
+}
+
+static u8 skl_pci_readb(u8 __iomem *addr)
+{
+	return readb(addr);
+}
+
+/* DMA page allocation helpers.  */
+static int skl_dma_alloc_pages(struct hdac_bus *bus, int type,
+			   size_t size, struct snd_dma_buffer *buf)
+{
+	return snd_dma_alloc_pages(type, bus->dev, size, buf);
+}
+
+static void skl_dma_free_pages(struct hdac_bus *bus, struct snd_dma_buffer *buf)
+{
+	snd_dma_free_pages(buf);
+}
+
+static const struct hdac_io_ops skl_io_ops = {
+	.reg_writel = skl_pci_writel,
+	.reg_readl = skl_pci_readl,
+	.reg_writew = skl_pci_writew,
+	.reg_readw = skl_pci_readw,
+	.reg_writeb = skl_pci_writeb,
+	.reg_readb = skl_pci_readb,
+	.dma_alloc_pages = skl_dma_alloc_pages,
+	.dma_free_pages = skl_dma_free_pages,
+};
+
+static int skl_probe(struct pci_dev *pci,
+		     const struct pci_device_id *pci_id)
+{
+	struct skl *skl;
+	struct hdac_ext_bus *ebus = NULL;
+	struct hdac_bus *bus = NULL;
+	int err;
+
+	err = skl_create(pci, &skl_io_ops, &skl);
+	if (err < 0)
+		return err;
+
+	ebus = &skl->ebus;
+	bus = ebus_to_hbus(ebus);
+
+	err = skl_first_init(ebus);
+	if (err < 0)
+		goto out_free;
+
+	pci_set_drvdata(skl->pci, ebus);
+
+	/* create device for soc dmic */
+	err = skl_dmic_device_register(skl);
+	if (err < 0)
+		goto out_free;
+
+	/* register platform dai and controls */
+	err = skl_platform_register(bus->dev);
+	if (err < 0)
+		goto out_dmic_free;
+
+	/* create codec instances */
+	err = skl_codec_create(ebus);
+	if (err < 0)
+		goto out_unregister;
+
+	pci_set_drvdata(skl->pci, ebus);
+
+	/*configure PM */
+	pm_runtime_set_autosuspend_delay(bus->dev, SKL_SUSPEND_DELAY);
+	pm_runtime_use_autosuspend(bus->dev);
+	pm_runtime_put_noidle(bus->dev);
+	pm_runtime_allow(bus->dev);
+
+	pci_set_drvdata(skl->pci, ebus);
+	return 0;
+
+out_unregister:
+	skl_platform_unregister(bus->dev);
+out_dmic_free:
+	skl_dmic_device_unregister(skl);
+out_free:
+	skl->init_failed = 1;
+	skl_free(ebus);
+	pci_set_drvdata(skl->pci, NULL);
+	return err;
+}
+
+static void skl_remove(struct pci_dev *pci)
+{
+	struct hdac_ext_bus *ebus = pci_get_drvdata(pci);
+	struct skl *skl = ebus_to_skl(ebus);
+
+	if (pci_dev_run_wake(pci))
+		pm_runtime_get_noresume(&pci->dev);
+	pci_dev_put(pci);
+	skl_platform_unregister(&pci->dev);
+	skl_dmic_device_unregister(skl);
+	skl_free(ebus);
+	dev_set_drvdata(&pci->dev, NULL);
+}
+
+/* PCI IDs */
+static const struct pci_device_id skl_ids[] = {
+	/* Sunrise Point-LP */
+	{ PCI_DEVICE(0x8086, 0x9d70), 0},
+	{ 0, }
+};
+MODULE_DEVICE_TABLE(pci, skl_ids);
+
+/* pci_driver definition */
+static struct pci_driver skl_driver = {
+	.name = KBUILD_MODNAME,
+	.id_table = skl_ids,
+	.probe = skl_probe,
+	.remove = skl_remove,
+	.driver = {
+		.pm = &skl_pm,
+	},
+};
+module_pci_driver(skl_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Intel Skylake ASoC HDA driver");
-- 
1.9.1
