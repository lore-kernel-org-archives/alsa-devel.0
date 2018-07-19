From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH 01/11] ASoC: SOF: Add Sound Open Firmware
	driver core
Date: Thu, 19 Jul 2018 19:53:25 +0100
Message-ID: <20180719185335.30912-1-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id EC12F26733D
 for <alsa-devel@alsa-project.org>; Thu, 19 Jul 2018 20:53:53 +0200 (CEST)
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The Sound Open Firmware driver core is a generic architecture
independent layer that allows SOF to be used on many different different
architectures and platforms. It abstracts DSP operations and IO methods
so that the target DSP can be an internal memory mapped or external SPI
or I2C based device. This abstraction also allows SOF to be run on
many different VMs on the same physical HW.

SOF also requires some data in ASoC PCM runtime data for looking up
SOF data during ASoC PCM operations.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 include/sound/soc.h      |   1 +
 include/sound/sof.h      |  92 +++++++
 sound/soc/sof/core.c     | 373 +++++++++++++++++++++++++++++
 sound/soc/sof/sof-priv.h | 504 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 970 insertions(+)
 create mode 100644 include/sound/sof.h
 create mode 100644 sound/soc/sof/core.c
 create mode 100644 sound/soc/sof/sof-priv.h

diff --git a/include/sound/soc.h b/include/sound/soc.h
index a4915148f739..df8e9084876b 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1133,6 +1133,7 @@ struct snd_soc_pcm_runtime {
 	/* runtime devices */
 	struct snd_pcm *pcm;
 	struct snd_compr *compr;
+	struct snd_sof_pcm *sof;
 	struct snd_soc_dai *codec_dai;
 	struct snd_soc_dai *cpu_dai;
 
diff --git a/include/sound/sof.h b/include/sound/sof.h
new file mode 100644
index 000000000000..835d0ae4770c
--- /dev/null
+++ b/include/sound/sof.h
@@ -0,0 +1,92 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
+/*
+ * This file is provided under a dual BSD/GPLv2 license.  When using or
+ * redistributing this file, you may do so under either license.
+ *
+ * Copyright(c) 2017 Intel Corporation. All rights reserved.
+ *
+ * Author: Liam Girdwood <liam.r.girdwood@linux.intel.com>
+ */
+
+#ifndef __INCLUDE_SOUND_SOF_H
+#define __INCLUDE_SOUND_SOF_H
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/interrupt.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/pci.h>
+#include <sound/soc.h>
+#include <sound/soc-acpi.h>
+#include <uapi/sound/sof-ipc.h>
+
+struct snd_sof_dsp_ops;
+
+/* SOF probe type */
+enum sof_device_type {
+	SOF_DEVICE_PCI = 0,
+	SOF_DEVICE_APCI,
+	SOF_DEVICE_SPI
+};
+
+/*
+ * SOF Platform data.
+ */
+struct snd_sof_pdata {
+	u32 id;		/* PCI/ACPI ID */
+	const struct firmware *fw;
+	const char *drv_name;
+	const char *name;
+
+	/* parent device */
+	struct device *dev;
+	enum sof_device_type type;
+
+	/* descriptor */
+	const struct sof_dev_desc *desc;
+
+	/* machine */
+	struct platform_device *pdev_mach;
+	const struct snd_soc_acpi_mach *machine;
+};
+
+/*
+ * Descriptor used for setting up SOF platform data. This is used when
+ * ACPI/PCI data is missing or mapped differently.
+ */
+struct sof_dev_desc {
+	/* list of machines using this configuration */
+	struct snd_soc_acpi_mach *machines;
+
+	/* Platform resource indexes in BAR / ACPI resources. */
+	/* Must set to -1 if not used - add new items to end */
+	int resindex_lpe_base;
+	int resindex_pcicfg_base;
+	int resindex_imr_base;
+	int irqindex_host_ipc;
+	int resindex_dma_base;
+
+	/* DMA only valid when resindex_dma_base != -1*/
+	int dma_engine;
+	int dma_size;
+
+	/* IPC timeouts in ms */
+	int ipc_timeout;
+	int boot_timeout;
+
+	/* defaults for no codec mode */
+	const char *nocodec_fw_filename;
+	const char *nocodec_tplg_filename;
+};
+
+int sof_nocodec_setup(struct device *dev,
+		      struct snd_sof_pdata *sof_pdata,
+		      struct snd_soc_acpi_mach *mach,
+		      const struct sof_dev_desc *desc,
+		      struct snd_sof_dsp_ops *ops);
+
+int sof_bes_setup(struct device *dev, struct snd_sof_dsp_ops *ops,
+		  struct snd_soc_dai_link *links, int link_num,
+		  struct snd_soc_card *card);
+#endif
diff --git a/sound/soc/sof/core.c b/sound/soc/sof/core.c
new file mode 100644
index 000000000000..29458909182a
--- /dev/null
+++ b/sound/soc/sof/core.c
@@ -0,0 +1,373 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+/*
+ * This file is provided under a dual BSD/GPLv2 license.  When using or
+ * redistributing this file, you may do so under either license.
+ *
+ * Copyright(c) 2017 Intel Corporation. All rights reserved.
+ *
+ * Author: Liam Girdwood <liam.r.girdwood@linux.intel.com>
+ */
+
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+#include <sound/core.h>
+#include <sound/soc.h>
+#include <sound/sof.h>
+#include "sof-priv.h"
+#include "ops.h"
+
+/* SOF defaults if not provided by the platform in ms */
+#define TIMEOUT_DEFAULT_IPC	5
+#define TIMEOUT_DEFAULT_BOOT	100
+
+/*
+ * Generic object lookup APIs.
+ */
+
+struct snd_sof_pcm *snd_sof_find_spcm_dai(struct snd_sof_dev *sdev,
+					  struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_sof_pcm *spcm = NULL;
+
+	list_for_each_entry(spcm, &sdev->pcm_list, list) {
+		if (le32_to_cpu(spcm->pcm.dai_id) == rtd->dai_link->id)
+			return spcm;
+	}
+
+	return NULL;
+}
+
+struct snd_sof_pcm *snd_sof_find_spcm_name(struct snd_sof_dev *sdev,
+					   char *name)
+{
+	struct snd_sof_pcm *spcm = NULL;
+
+	list_for_each_entry(spcm, &sdev->pcm_list, list) {
+		if (strcmp(spcm->pcm.dai_name, name) == 0)
+			return spcm;
+
+		if (strcmp(spcm->pcm.caps[0].name, name) == 0)
+			return spcm;
+
+		if (strcmp(spcm->pcm.caps[1].name, name) == 0)
+			return spcm;
+	}
+
+	return NULL;
+}
+
+struct snd_sof_pcm *snd_sof_find_spcm_comp(struct snd_sof_dev *sdev,
+					   unsigned int comp_id,
+					   int *direction)
+{
+	struct snd_sof_pcm *spcm = NULL;
+
+	list_for_each_entry(spcm, &sdev->pcm_list, list) {
+		if (spcm->stream[SNDRV_PCM_STREAM_PLAYBACK].comp_id ==
+			comp_id) {
+			*direction = SNDRV_PCM_STREAM_PLAYBACK;
+			return spcm;
+		}
+		if (spcm->stream[SNDRV_PCM_STREAM_CAPTURE].comp_id == comp_id) {
+			*direction = SNDRV_PCM_STREAM_CAPTURE;
+			return spcm;
+		}
+	}
+
+	return NULL;
+}
+
+struct snd_sof_pcm *snd_sof_find_spcm_pcm_id(struct snd_sof_dev *sdev,
+					     unsigned int pcm_id)
+{
+	struct snd_sof_pcm *spcm = NULL;
+
+	list_for_each_entry(spcm, &sdev->pcm_list, list) {
+		if (le32_to_cpu(spcm->pcm.pcm_id) == pcm_id)
+			return spcm;
+	}
+
+	return NULL;
+}
+
+struct snd_sof_widget *snd_sof_find_swidget(struct snd_sof_dev *sdev,
+					    char *name)
+{
+	struct snd_sof_widget *swidget = NULL;
+
+	list_for_each_entry(swidget, &sdev->widget_list, list) {
+		if (strcmp(name, swidget->widget->name) == 0)
+			return swidget;
+	}
+
+	return NULL;
+}
+
+struct snd_sof_dai *snd_sof_find_dai(struct snd_sof_dev *sdev,
+				     char *name)
+{
+	struct snd_sof_dai *dai = NULL;
+
+	list_for_each_entry(dai, &sdev->dai_list, list) {
+		if (!dai->name)
+			continue;
+
+		if (strcmp(name, dai->name) == 0)
+			return dai;
+	}
+
+	return NULL;
+}
+
+static inline unsigned int sof_get_pages(size_t size)
+{
+	return (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
+}
+
+/*
+ * FW Panic/fault handling.
+ */
+
+struct sof_panic_msg {
+	u32 id;
+	const char *msg;
+};
+
+/* standard FW panic types */
+static const struct sof_panic_msg panic_msg[] = {
+	{SOF_IPC_PANIC_MEM, "out of memory"},
+	{SOF_IPC_PANIC_WORK, "work subsystem init failed"},
+	{SOF_IPC_PANIC_IPC, "IPC subsystem init failed"},
+	{SOF_IPC_PANIC_ARCH, "arch init failed"},
+	{SOF_IPC_PANIC_PLATFORM, "platform init failed"},
+	{SOF_IPC_PANIC_TASK, "scheduler init failed"},
+	{SOF_IPC_PANIC_EXCEPTION, "runtime exception"},
+	{SOF_IPC_PANIC_DEADLOCK, "deadlock"},
+	{SOF_IPC_PANIC_STACK, "stack overflow"},
+	{SOF_IPC_PANIC_IDLE, "can't enter idle"},
+};
+
+int snd_sof_get_status(struct snd_sof_dev *sdev, u32 panic_code,
+		       u32 tracep_code, void *oops, void *stack,
+		       size_t stack_words)
+{
+	u32 code;
+	int i;
+
+	/* is firmware dead ? */
+	if ((panic_code & SOF_IPC_PANIC_MAGIC_MASK) != SOF_IPC_PANIC_MAGIC) {
+		dev_err(sdev->dev, "error: unexpected fault 0x%8.8x trace 0x%8.8x\n",
+			panic_code, tracep_code);
+		return 0; /* no fault ? */
+	}
+
+	code = panic_code &
+		(SOF_IPC_PANIC_MAGIC_MASK | SOF_IPC_PANIC_CODE_MASK);
+
+	for (i = 0; i < ARRAY_SIZE(panic_msg); i++) {
+		if (panic_msg[i].id == code) {
+			dev_err(sdev->dev, "error: %s\n", panic_msg[i].msg);
+			dev_err(sdev->dev, "error: trace point %8.8x\n",
+				tracep_code);
+			goto out;
+		}
+	}
+
+	/* unknown error */
+	dev_err(sdev->dev, "error: unknown reason %8.8x\n", panic_code);
+	dev_err(sdev->dev, "error: trace point %8.8x\n", tracep_code);
+
+out:
+	sof_oops(sdev, oops);
+	sof_stack(sdev, oops, stack, stack_words);
+	return -EFAULT;
+}
+EXPORT_SYMBOL(snd_sof_get_status);
+
+/*
+ * Generic buffer page table creation.
+ */
+
+int snd_sof_create_page_table(struct snd_sof_dev *sdev,
+			      struct snd_dma_buffer *dmab,
+			      unsigned char *page_table, size_t size)
+{
+	int i, pages;
+
+	pages = snd_sgbuf_aligned_pages(size);
+
+	dev_dbg(sdev->dev, "generating page table for %p size 0x%zx pages %d\n",
+		dmab->area, size, pages);
+
+	for (i = 0; i < pages; i++) {
+		u32 idx = (((i << 2) + i)) >> 1;
+		u32 pfn = snd_sgbuf_get_addr(dmab, i * PAGE_SIZE) >> PAGE_SHIFT;
+		u32 *pg_table;
+
+		dev_dbg(sdev->dev, "pfn i %i idx %d pfn %x\n", i, idx, pfn);
+
+		pg_table = (u32 *)(page_table + idx);
+
+		if (i & 1)
+			*pg_table |= (pfn << 4);
+		else
+			*pg_table |= pfn;
+	}
+
+	return pages;
+}
+
+/*
+ * SOF Driver enumeration.
+ */
+
+static int sof_probe(struct platform_device *pdev)
+{
+	struct snd_sof_pdata *plat_data = dev_get_platdata(&pdev->dev);
+	struct snd_sof_dev *sdev;
+	int ret;
+
+	sdev = devm_kzalloc(&pdev->dev, sizeof(*sdev), GFP_KERNEL);
+	if (!sdev)
+		return -ENOMEM;
+
+	dev_dbg(&pdev->dev, "probing SOF DSP device....\n");
+
+	/* initialize sof device */
+	sdev->dev = &pdev->dev;
+	sdev->parent = plat_data->dev;
+	if (plat_data->type == SOF_DEVICE_PCI)
+		sdev->pci = container_of(plat_data->dev, struct pci_dev, dev);
+	sdev->ops = plat_data->machine->pdata;
+
+	sdev->pdata = plat_data;
+	INIT_LIST_HEAD(&sdev->pcm_list);
+	INIT_LIST_HEAD(&sdev->kcontrol_list);
+	INIT_LIST_HEAD(&sdev->widget_list);
+	INIT_LIST_HEAD(&sdev->dai_list);
+	dev_set_drvdata(&pdev->dev, sdev);
+	spin_lock_init(&sdev->ipc_lock);
+	spin_lock_init(&sdev->hw_lock);
+
+	/* set up platform component driver */
+	snd_sof_new_platform_drv(sdev);
+
+	/* set default timeouts if none provided */
+	if (plat_data->desc->ipc_timeout == 0)
+		sdev->ipc_timeout = TIMEOUT_DEFAULT_IPC;
+	else
+		sdev->ipc_timeout = plat_data->desc->ipc_timeout;
+	if (plat_data->desc->boot_timeout == 0)
+		sdev->boot_timeout = TIMEOUT_DEFAULT_BOOT;
+	else
+		sdev->boot_timeout = plat_data->desc->boot_timeout;
+
+	/* probe the DSP hardware */
+	ret = snd_sof_probe(sdev);
+	if (ret < 0) {
+		dev_err(sdev->dev, "error: failed to probe DSP %d\n", ret);
+		return ret;
+	}
+
+	/* register any debug/trace capabilities */
+	ret = snd_sof_dbg_init(sdev);
+	if (ret < 0) {
+		dev_err(sdev->dev, "error: failed to init DSP trace/debug %d\n",
+			ret);
+		goto dbg_err;
+	}
+
+	/* init the IPC */
+	sdev->ipc = snd_sof_ipc_init(sdev);
+	if (!sdev->ipc) {
+		dev_err(sdev->dev, "error: failed to init DSP IPC %d\n", ret);
+		goto ipc_err;
+	}
+
+	/* load the firmware */
+	ret = snd_sof_load_firmware(sdev, plat_data->fw);
+	if (ret < 0) {
+		dev_err(sdev->dev, "error: failed to load DSP firmware %d\n",
+			ret);
+		goto fw_load_err;
+	}
+
+	/* boot the firmware */
+	ret = snd_sof_run_firmware(sdev);
+	if (ret < 0) {
+		dev_err(sdev->dev, "error: failed to boot DSP firmware %d\n",
+			ret);
+		goto fw_run_err;
+	}
+
+	/* now register audio DSP platform driver and dai */
+	ret = snd_soc_register_component(&pdev->dev,  &sdev->plat_drv,
+					 sdev->ops->drv,
+					 sdev->ops->num_drv);
+	if (ret < 0) {
+		dev_err(sdev->dev,
+			"error: failed to register DSP DAI driver %d\n", ret);
+		goto comp_err;
+	}
+
+	/* init DMA trace */
+	ret = snd_sof_init_trace(sdev);
+	if (ret < 0) {
+		/* non fatal */
+		dev_warn(sdev->dev,
+			 "warning: failed to initialize trace %d\n", ret);
+	}
+
+	return 0;
+
+comp_err:
+	snd_soc_unregister_component(&pdev->dev);
+	snd_sof_free_topology(sdev);
+fw_run_err:
+	snd_sof_fw_unload(sdev);
+fw_load_err:
+	snd_sof_ipc_free(sdev);
+ipc_err:
+	snd_sof_free_debug(sdev);
+dbg_err:
+	snd_sof_remove(sdev);
+
+	return ret;
+}
+
+static int sof_remove(struct platform_device *pdev)
+{
+	struct snd_sof_dev *sdev = dev_get_drvdata(&pdev->dev);
+
+	snd_soc_unregister_component(&pdev->dev);
+	snd_sof_fw_unload(sdev);
+	snd_sof_ipc_free(sdev);
+	snd_sof_free_debug(sdev);
+	snd_sof_release_trace(sdev);
+	snd_sof_remove(sdev);
+	return 0;
+}
+
+void snd_sof_shutdown(struct device *dev)
+{
+}
+EXPORT_SYMBOL(snd_sof_shutdown);
+
+static struct platform_driver sof_driver = {
+	.driver = {
+		.name = "sof-audio",
+	},
+
+	.probe = sof_probe,
+	.remove = sof_remove,
+};
+module_platform_driver(sof_driver);
+
+MODULE_AUTHOR("Liam Girdwood");
+MODULE_DESCRIPTION("Sound Open Firmware (SOF) Core");
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_ALIAS("platform:sof-audio");
diff --git a/sound/soc/sof/sof-priv.h b/sound/soc/sof/sof-priv.h
new file mode 100644
index 000000000000..adce6c4dff87
--- /dev/null
+++ b/sound/soc/sof/sof-priv.h
@@ -0,0 +1,504 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
+/*
+ * This file is provided under a dual BSD/GPLv2 license.  When using or
+ * redistributing this file, you may do so under either license.
+ *
+ * Copyright(c) 2017 Intel Corporation. All rights reserved.
+ *
+ * Author: Liam Girdwood <liam.r.girdwood@linux.intel.com>
+ */
+
+#ifndef __SOUND_SOC_SOF_PRIV_H
+#define __SOUND_SOC_SOF_PRIV_H
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/interrupt.h>
+#include <linux/device.h>
+#include <linux/pci.h>
+#include <linux/firmware.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <uapi/sound/sof-ipc.h>
+#include <uapi/sound/sof-fw.h>
+#include <uapi/sound/asoc.h>
+#include <sound/hdaudio.h>
+#include <sound/compress_driver.h>
+
+/* debug flags */
+#define SOF_DBG_REGS	BIT(1)
+#define SOF_DBG_MBOX	BIT(2)
+#define SOF_DBG_TEXT	BIT(3)
+#define SOF_DBG_PCI	BIT(4)
+
+/* max BARs mmaped devices can use */
+#define SND_SOF_BARS	8
+
+/* time in ms for runtime suspend delay */
+#define SND_SOF_SUSPEND_DELAY	2000
+
+/* DMA buffer size for trace */
+#define DMA_BUF_SIZE_FOR_TRACE (PAGE_SIZE * 16)
+
+/* max number of FE PCMs before BEs */
+#define SOF_BE_PCM_BASE		16
+
+#define SOF_IPC_DSP_REPLY		0
+#define SOF_IPC_HOST_REPLY		1
+
+/* convenience constructor for DAI driver streams */
+#define SOF_DAI_STREAM(sname, scmin, scmax, srates, sfmt) \
+	{.stream_name = sname, .channels_min = scmin, .channels_max = scmax, \
+	 .rates = srates, .formats = sfmt}
+
+#define SOF_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE | \
+	SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_FLOAT)
+
+struct snd_sof_dev;
+struct snd_sof_ipc_msg;
+struct snd_sof_ipc;
+struct snd_sof_debugfs_map;
+struct snd_soc_tplg_ops;
+struct snd_soc_component;
+struct sof_intel_hda_dev;
+struct snd_sof_pdata;
+
+/*
+ * SOF DSP HW abstraction operations.
+ * Used to abstract DSP HW architecture and any IO busses between host CPU
+ * and DSP device(s).
+ */
+struct snd_sof_dsp_ops {
+	/* probe and remove */
+	int (*remove)(struct snd_sof_dev *sof_dev);
+	int (*probe)(struct snd_sof_dev *sof_dev);
+
+	/* DSP core boot / reset */
+	int (*run)(struct snd_sof_dev *sof_dev);
+	int (*stall)(struct snd_sof_dev *sof_dev);
+	int (*reset)(struct snd_sof_dev *sof_dev);
+
+	/* DSP PM */
+	int (*suspend)(struct snd_sof_dev *sof_dev, int state);
+	int (*resume)(struct snd_sof_dev *sof_dev);
+
+	/* DSP clocking */
+	int (*set_clk)(struct snd_sof_dev *sof_dev, u32 freq);
+
+	/* Register IO */
+	void (*write)(struct snd_sof_dev *sof_dev, void __iomem *addr,
+		      u32 value);
+	u32 (*read)(struct snd_sof_dev *sof_dev, void __iomem *addr);
+	void (*write64)(struct snd_sof_dev *sof_dev, void __iomem *addr,
+			u64 value);
+	u64 (*read64)(struct snd_sof_dev *sof_dev, void __iomem *addr);
+
+	/* memcpy IO */
+	void (*block_read)(struct snd_sof_dev *sof_dev,
+			   u32 offset, void *dest, size_t size);
+	void (*block_write)(struct snd_sof_dev *sof_dev,
+			    u32 offset, void *src, size_t size);
+
+	/* doorbell */
+	irqreturn_t (*irq_handler)(int irq, void *context);
+	irqreturn_t (*irq_thread)(int irq, void *context);
+
+	/* mailbox */
+	void (*mailbox_read)(struct snd_sof_dev *sof_dev, u32 offset,
+			     void *addr, size_t bytes);
+	void (*mailbox_write)(struct snd_sof_dev *sof_dev, u32 offset,
+			      void *addr, size_t bytes);
+
+	/* ipc */
+	int (*send_msg)(struct snd_sof_dev *sof_dev,
+			struct snd_sof_ipc_msg *msg);
+	int (*get_reply)(struct snd_sof_dev *sof_dev,
+			 struct snd_sof_ipc_msg *msg);
+	int (*is_ready)(struct snd_sof_dev *sof_dev);
+	int (*cmd_done)(struct snd_sof_dev *sof_dev, int dir);
+
+	/* debug */
+	const struct snd_sof_debugfs_map *debug_map;
+	int debug_map_count;
+	void (*dbg_dump)(struct snd_sof_dev *sof_dev, u32 flags);
+
+	/* connect pcm substream to a host stream */
+	int (*pcm_open)(struct snd_sof_dev *sdev,
+			struct snd_pcm_substream *substream);
+	/* disconnect pcm substream to a host stream */
+	int (*pcm_close)(struct snd_sof_dev *sdev,
+			 struct snd_pcm_substream *substream);
+
+	/* host stream hw params */
+	int (*pcm_hw_params)(struct snd_sof_dev *sdev,
+			     struct snd_pcm_substream *substream,
+			     struct snd_pcm_hw_params *params);
+
+	/* host stream trigger */
+	int (*pcm_trigger)(struct snd_sof_dev *sdev,
+			   struct snd_pcm_substream *substream, int cmd);
+
+	/* FW loading */
+	int (*load_firmware)(struct snd_sof_dev *sof_dev,
+			     const struct firmware *fw);
+	int (*load_module)(struct snd_sof_dev *sof_dev,
+			   struct snd_sof_mod_hdr *hdr);
+	int (*fw_ready)(struct snd_sof_dev *sdev, u32 msg_id);
+
+	/* host DMA trace initialization */
+	int (*trace_init)(struct snd_sof_dev *sdev, u32 *stream_tag);
+	int (*trace_release)(struct snd_sof_dev *sdev);
+	int (*trace_trigger)(struct snd_sof_dev *sdev, int cmd);
+
+	/* DAI ops */
+	struct snd_soc_dai_driver *drv;
+	int num_drv;
+};
+
+/* DSP architecture specific callbacks for oops and stack dumps */
+struct sof_arch_ops {
+	void (*dsp_oops)(struct snd_sof_dev *sdev, void *oops);
+	void (*dsp_stack)(struct snd_sof_dev *sdev, void *oops,
+			  u32 *stack, u32 stack_words);
+};
+
+/* DSP device HW descriptor mapping between bus ID and ops */
+struct sof_ops_table {
+	const struct sof_dev_desc *desc;
+	struct snd_sof_dsp_ops *ops;
+	struct platform_device *(*new_data)(struct snd_sof_pdata *pdata);
+};
+
+/* FS entry for debug files that can expose DSP memories, registers */
+struct snd_sof_dfsentry_io {
+	struct dentry *dfsentry;
+	size_t size;
+	void __iomem *buf;
+	struct snd_sof_dev *sdev;
+};
+
+struct snd_sof_dfsentry_buf {
+	struct dentry *dfsentry;
+	size_t size;
+	void *buf;
+	struct snd_sof_dev *sdev;
+};
+
+/* Debug mapping for any DSP memory or registers that can used for debug */
+struct snd_sof_debugfs_map {
+	const char *name;
+	u32 bar;
+	u32 offset;
+	u32 size;
+};
+
+/* mailbox descriptor, used for host <-> DSP IPC */
+struct snd_sof_mailbox {
+	u32 offset;
+	size_t size;
+};
+
+/* IPC message descriptor for host <-> DSP IO */
+struct snd_sof_ipc_msg {
+	struct list_head list;
+
+	/* message data */
+	u32 header;
+	void *msg_data;
+	void *reply_data;
+	size_t msg_size;
+	size_t reply_size;
+
+	wait_queue_head_t waitq;
+	bool complete;
+};
+
+/* PCM stream, mapped to FW component  */
+struct snd_sof_pcm_stream {
+	u32 comp_id;
+	struct snd_dma_buffer page_table;
+	struct sof_ipc_stream_posn posn;
+	struct snd_pcm_substream *substream;
+};
+
+/* ASLA SOF PCM device */
+struct snd_sof_pcm {
+	struct snd_sof_dev *sdev;
+	struct snd_soc_tplg_pcm pcm;
+	struct snd_sof_pcm_stream stream[2];
+	u32 posn_offset[2];
+	struct mutex mutex;	/* access mutex */
+	struct list_head list;	/* list in sdev pcm list */
+};
+
+/* ALSA SOF Kcontrol device */
+struct snd_sof_control {
+	struct snd_sof_dev *sdev;
+	int comp_id;
+	int num_channels;
+	u32 readback_offset; /* offset to mmaped data if used */
+	struct sof_ipc_ctrl_data *control_data;
+	u32 size;	/* cdata size */
+	enum sof_ipc_ctrl_cmd cmd;
+	u32 *volume_table; /* volume table computed from tlv data*/
+
+	struct mutex mutex;	/* access mutex */
+	struct list_head list;	/* list in sdev control list */
+};
+
+/* ASoC SOF DAPM widget */
+struct snd_sof_widget {
+	struct snd_sof_dev *sdev;
+	int comp_id;
+	int pipeline_id;
+	int complete;
+	int id;
+
+	struct snd_soc_dapm_widget *widget;
+	struct mutex mutex;	/* access mutex */
+	struct list_head list;	/* list in sdev widget list */
+
+	void *private;		/* core does not touch this */
+};
+
+/* ASoC DAI device */
+struct snd_sof_dai {
+	struct snd_sof_dev *sdev;
+	const char *name;
+
+	struct sof_ipc_comp_dai comp_dai;
+	struct sof_ipc_dai_config dai_config;
+	struct list_head list;	/* list in sdev dai list */
+};
+
+/*
+ * SOF Device Level.
+ */
+struct snd_sof_dev {
+	struct device *dev;
+	struct device *parent;
+	spinlock_t ipc_lock;	/* lock for IPC users */
+	spinlock_t hw_lock;	/* lock for HW IO access */
+	struct pci_dev *pci;
+
+	/* ASoC components */
+	struct snd_soc_component_driver plat_drv;
+
+	/* DSP firmware boot */
+	wait_queue_head_t boot_wait;
+	bool boot_complete;
+
+	/* DSP HW differentiation */
+	struct snd_sof_pdata *pdata;
+	const struct snd_sof_dsp_ops *ops;
+	struct sof_intel_hda_dev *hda;	/* for HDA based DSP HW */
+	const struct sof_arch_ops *arch_ops;
+
+	/* IPC */
+	struct snd_sof_ipc *ipc;
+	struct snd_sof_mailbox dsp_box;		/* DSP initiated IPC */
+	struct snd_sof_mailbox host_box;	/* Host initiated IPC */
+	struct snd_sof_mailbox stream_box;	/* Stream position update */
+	u64 irq_status;
+	int ipc_irq;
+	u32 next_comp_id; /* monotonic - reset during S3 */
+
+	/* memory bases for mmaped DSPs - set by dsp_init() */
+	void __iomem *bar[SND_SOF_BARS];	/* DSP base address */
+	int mmio_bar;
+	int mailbox_bar;
+	size_t dsp_oops_offset;
+
+	/* debug */
+	struct dentry *debugfs_root;
+
+	/* firmware loader */
+	int cl_bar;
+	struct snd_dma_buffer dmab;
+	struct sof_ipc_fw_ready fw_ready;
+
+	/* topology */
+	struct snd_soc_tplg_ops *tplg_ops;
+	struct list_head pcm_list;
+	struct list_head kcontrol_list;
+	struct list_head widget_list;
+	struct list_head dai_list;
+	struct snd_soc_component *component;
+
+	/* FW configuration */
+	struct sof_ipc_dma_buffer_data *info_buffer;
+	struct sof_ipc_window *info_window;
+
+	/* IPC timeouts in ms */
+	int ipc_timeout;
+	int boot_timeout;
+
+	/* Wait queue for code loading */
+	wait_queue_head_t waitq;
+	int code_loading;
+
+	/* DMA for Trace */
+	struct snd_dma_buffer dmatb;
+	struct snd_dma_buffer dmatp;
+	int dma_trace_pages;
+	wait_queue_head_t trace_sleep;
+	u32 host_offset;
+	bool dtrace_is_enabled;
+	bool dtrace_error;
+
+	void *private;			/* core does not touch this */
+};
+
+/*
+ * SOF platform private struct used as drvdata of
+ * platform dev (e.g. pci/acpi/spi...) drvdata.
+ */
+struct sof_platform_priv {
+	struct snd_sof_pdata *sof_pdata;
+	struct platform_device *pdev_pcm;
+};
+
+/*
+ * Device Level.
+ */
+void snd_sof_shutdown(struct device *dev);
+int snd_sof_runtime_suspend(struct device *dev);
+int snd_sof_runtime_resume(struct device *dev);
+int snd_sof_resume(struct device *dev);
+int snd_sof_suspend(struct device *dev);
+int snd_sof_suspend_late(struct device *dev);
+
+void snd_sof_new_platform_drv(struct snd_sof_dev *sdev);
+void snd_sof_new_dai_drv(struct snd_sof_dev *sdev);
+
+int snd_sof_create_page_table(struct snd_sof_dev *sdev,
+			      struct snd_dma_buffer *dmab,
+			      unsigned char *page_table, size_t size);
+
+/*
+ * Firmware loading.
+ */
+int snd_sof_load_firmware(struct snd_sof_dev *sdev,
+			  const struct firmware *fw);
+int snd_sof_load_firmware_memcpy(struct snd_sof_dev *sdev,
+				 const struct firmware *fw);
+int snd_sof_run_firmware(struct snd_sof_dev *sdev);
+int snd_sof_parse_module_memcpy(struct snd_sof_dev *sdev,
+				struct snd_sof_mod_hdr *module);
+void snd_sof_fw_unload(struct snd_sof_dev *sdev);
+int snd_sof_fw_parse_ext_data(struct snd_sof_dev *sdev, u32 offset);
+
+/*
+ * IPC low level APIs.
+ */
+struct snd_sof_ipc *snd_sof_ipc_init(struct snd_sof_dev *sdev);
+void snd_sof_ipc_free(struct snd_sof_dev *sdev);
+int snd_sof_ipc_reply(struct snd_sof_dev *sdev, u32 msg_id);
+void snd_sof_ipc_msgs_rx(struct snd_sof_dev *sdev);
+void snd_sof_ipc_msgs_tx(struct snd_sof_dev *sdev);
+int snd_sof_ipc_stream_pcm_params(struct snd_sof_dev *sdev,
+				  struct sof_ipc_pcm_params *params);
+int snd_sof_dsp_mailbox_init(struct snd_sof_dev *sdev, u32 dspbox,
+			     size_t dspbox_size, u32 hostbox,
+			     size_t hostbox_size);
+int sof_ipc_tx_message(struct snd_sof_ipc *ipc, u32 header, void *tx_data,
+		       size_t tx_bytes, void *rx_data, size_t rx_bytes);
+struct snd_sof_widget *snd_sof_find_swidget(struct snd_sof_dev *sdev,
+					    char *name);
+struct snd_sof_dai *snd_sof_find_dai(struct snd_sof_dev *sdev,
+				     char *name);
+struct snd_sof_pcm *snd_sof_find_spcm_dai(struct snd_sof_dev *sdev,
+					  struct snd_soc_pcm_runtime *rtd);
+struct snd_sof_pcm *snd_sof_find_spcm_name(struct snd_sof_dev *sdev,
+					   char *name);
+struct snd_sof_pcm *snd_sof_find_spcm_comp(struct snd_sof_dev *sdev,
+					   unsigned int comp_id,
+					   int *direction);
+struct snd_sof_pcm *snd_sof_find_spcm_pcm_id(struct snd_sof_dev *sdev,
+					     unsigned int pcm_id);
+void sof_ipc_drop_all(struct snd_sof_ipc *ipc);
+
+/*
+ * Stream IPC
+ */
+int snd_sof_ipc_stream_posn(struct snd_sof_dev *sdev,
+			    struct snd_sof_pcm *spcm, int direction,
+			    struct sof_ipc_stream_posn *posn);
+
+/*
+ * Mixer IPC
+ */
+int snd_sof_ipc_set_comp_data(struct snd_sof_ipc *ipc,
+			      struct snd_sof_control *scontrol, u32 ipc_cmd,
+			      enum sof_ipc_ctrl_type ctrl_type,
+			      enum sof_ipc_ctrl_cmd ctrl_cmd);
+int snd_sof_ipc_get_comp_data(struct snd_sof_ipc *ipc,
+			      struct snd_sof_control *scontrol, u32 ipc_cmd,
+			      enum sof_ipc_ctrl_type ctrl_type,
+			      enum sof_ipc_ctrl_cmd ctrl_cmd);
+
+/*
+ * Topology.
+ */
+int snd_sof_init_topology(struct snd_sof_dev *sdev,
+			  struct snd_soc_tplg_ops *ops);
+int snd_sof_load_topology(struct snd_sof_dev *sdev, const char *file);
+void snd_sof_free_topology(struct snd_sof_dev *sdev);
+
+/*
+ * Trace/debug
+ */
+int snd_sof_init_trace(struct snd_sof_dev *sdev);
+void snd_sof_release_trace(struct snd_sof_dev *sdev);
+int snd_sof_dbg_init(struct snd_sof_dev *sdev);
+void snd_sof_free_debug(struct snd_sof_dev *sdev);
+int snd_sof_debugfs_create_item(struct snd_sof_dev *sdev,
+				void __iomem *base, size_t size,
+				const char *name);
+int snd_sof_trace_update_pos(struct snd_sof_dev *sdev,
+			     struct sof_ipc_dma_trace_posn *posn);
+void snd_sof_trace_notify_for_error(struct snd_sof_dev *sdev);
+int snd_sof_get_status(struct snd_sof_dev *sdev, u32 panic_code,
+		       u32 tracep_code, void *oops, void *stack,
+		       size_t stack_size);
+
+/*
+ * Platform specific ops.
+ */
+extern struct snd_compr_ops sof_compressed_ops;
+
+/*
+ * Kcontrols.
+ */
+
+int snd_sof_volume_get(struct snd_kcontrol *kcontrol,
+		       struct snd_ctl_elem_value *ucontrol);
+int snd_sof_volume_put(struct snd_kcontrol *kcontrol,
+		       struct snd_ctl_elem_value *ucontrol);
+int snd_sof_enum_get(struct snd_kcontrol *kcontrol,
+		     struct snd_ctl_elem_value *ucontrol);
+int snd_sof_enum_put(struct snd_kcontrol *kcontrol,
+		     struct snd_ctl_elem_value *ucontrol);
+int snd_sof_bytes_get(struct snd_kcontrol *kcontrol,
+		      struct snd_ctl_elem_value *ucontrol);
+int snd_sof_bytes_put(struct snd_kcontrol *kcontrol,
+		      struct snd_ctl_elem_value *ucontrol);
+
+/*
+ * DSP Architectures.
+ */
+static inline void sof_stack(struct snd_sof_dev *sdev, void *oops, u32 *stack,
+			     u32 stack_words)
+{
+	if (sdev->arch_ops->dsp_stack)
+		sdev->arch_ops->dsp_stack(sdev, oops, stack, stack_words);
+}
+
+static inline void sof_oops(struct snd_sof_dev *sdev, void *oops)
+{
+	if (sdev->arch_ops->dsp_oops)
+		sdev->arch_ops->dsp_oops(sdev, oops);
+}
+
+extern const struct sof_arch_ops sof_xtensa_arch_ops;
+#endif
-- 
2.17.1
