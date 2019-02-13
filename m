From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 18/20] ASoC: SOF: Add PCI device support
Date: Wed, 13 Feb 2019 16:08:45 -0600
Message-ID: <20190213220847.10567-19-pierre-louis.bossart@linux.intel.com>
References: <20190213220847.10567-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20190213220847.10567-1-pierre-louis.bossart@linux.intel.com>
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
Cc: Daniel Baluta <daniel.baluta@gmail.com>, andriy.shevchenko@intel.com, tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Alan Cox <alan@linux.intel.com>, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Liam Girdwood <liam.r.girdwood@linux.intel.com>

Add support for PCI based DSP devices.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/sof-pci-dev.c | 351 ++++++++++++++++++++++++++++++++++++
 1 file changed, 351 insertions(+)
 create mode 100644 sound/soc/sof/sof-pci-dev.c

diff --git a/sound/soc/sof/sof-pci-dev.c b/sound/soc/sof/sof-pci-dev.c
new file mode 100644
index 000000000000..27d43bcca8de
--- /dev/null
+++ b/sound/soc/sof/sof-pci-dev.c
@@ -0,0 +1,351 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+//
+// This file is provided under a dual BSD/GPLv2 license.  When using or
+// redistributing this file, you may do so under either license.
+//
+// Copyright(c) 2018 Intel Corporation. All rights reserved.
+//
+// Author: Liam Girdwood <liam.r.girdwood@linux.intel.com>
+//
+
+#include <linux/firmware.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/pm_runtime.h>
+#include <sound/soc-acpi.h>
+#include <sound/soc-acpi-intel-match.h>
+#include <sound/sof.h>
+#include "ops.h"
+
+/* platform specific devices */
+#include "intel/shim.h"
+#include "intel/hda.h"
+
+static char *fw_path;
+module_param(fw_path, charp, 0444);
+MODULE_PARM_DESC(fw_path, "alternate path for SOF firmware.");
+
+static char *tplg_path;
+module_param(tplg_path, charp, 0444);
+MODULE_PARM_DESC(tplg_path, "alternate path for SOF topology.");
+
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_APOLLOLAKE)
+static const struct sof_dev_desc bxt_desc = {
+	.machines		= snd_soc_acpi_intel_bxt_machines,
+	.resindex_lpe_base	= 0,
+	.resindex_pcicfg_base	= -1,
+	.resindex_imr_base	= -1,
+	.irqindex_host_ipc	= -1,
+	.resindex_dma_base	= -1,
+	.chip_info = &apl_chip_info,
+	.default_fw_path = "intel/sof",
+	.default_tplg_path = "intel/sof-tplg",
+	.nocodec_fw_filename = "sof-apl.ri",
+	.nocodec_tplg_filename = "sof-apl-nocodec.tplg",
+	.ops = &sof_apl_ops,
+	.arch_ops = &sof_xtensa_arch_ops
+};
+#endif
+
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_GEMINILAKE)
+static const struct sof_dev_desc glk_desc = {
+	.machines		= snd_soc_acpi_intel_glk_machines,
+	.resindex_lpe_base	= 0,
+	.resindex_pcicfg_base	= -1,
+	.resindex_imr_base	= -1,
+	.irqindex_host_ipc	= -1,
+	.resindex_dma_base	= -1,
+	.chip_info = &apl_chip_info,
+	.default_fw_path = "intel/sof",
+	.default_tplg_path = "intel/sof-tplg",
+	.nocodec_fw_filename = "sof-glk.ri",
+	.nocodec_tplg_filename = "sof-glk-nocodec.tplg",
+	.ops = &sof_apl_ops,
+	.arch_ops = &sof_xtensa_arch_ops
+};
+#endif
+
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_EDISON)
+static struct snd_soc_acpi_mach sof_tng_machines[] = {
+	{
+		.id = "INT343A",
+		.drv_name = "edison",
+		.sof_fw_filename = "sof-byt.ri",
+		.sof_tplg_filename = "sof-byt.tplg",
+	},
+	{}
+};
+
+static const struct sof_dev_desc tng_desc = {
+	.machines		= sof_tng_machines,
+	.resindex_lpe_base	= 3,	/* IRAM, but subtract IRAM offset */
+	.resindex_pcicfg_base	= -1,
+	.resindex_imr_base	= 0,
+	.irqindex_host_ipc	= -1,
+	.resindex_dma_base	= -1,
+	.chip_info = &tng_chip_info,
+	.default_fw_path = "intel/sof",
+	.default_tplg_path = "intel/sof-tplg",
+	.nocodec_fw_filename = "sof-byt.ri",
+	.nocodec_tplg_filename = "sof-byt.tplg",
+	.ops = &sof_tng_ops,
+	.arch_ops = &sof_xtensa_arch_ops
+};
+#endif
+
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_CANNONLAKE)
+static const struct sof_dev_desc cnl_desc = {
+	.machines		= snd_soc_acpi_intel_cnl_machines,
+	.resindex_lpe_base	= 0,
+	.resindex_pcicfg_base	= -1,
+	.resindex_imr_base	= -1,
+	.irqindex_host_ipc	= -1,
+	.resindex_dma_base	= -1,
+	.chip_info = &cnl_chip_info,
+	.default_fw_path = "intel/sof",
+	.default_tplg_path = "intel/sof-tplg",
+	.nocodec_fw_filename = "sof-cnl.ri",
+	.nocodec_tplg_filename = "sof-cnl-nocodec.tplg",
+	.ops = &sof_cnl_ops,
+	.arch_ops = &sof_xtensa_arch_ops
+};
+#endif
+
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_ICELAKE)
+static const struct sof_dev_desc icl_desc = {
+	.machines               = snd_soc_acpi_intel_icl_machines,
+	.resindex_lpe_base      = 0,
+	.resindex_pcicfg_base   = -1,
+	.resindex_imr_base      = -1,
+	.irqindex_host_ipc      = -1,
+	.resindex_dma_base      = -1,
+	.chip_info = &cnl_chip_info,
+	.default_fw_path = "intel/sof",
+	.default_tplg_path = "intel/sof-tplg",
+	.nocodec_fw_filename = "sof-icl.ri",
+	.nocodec_tplg_filename = "sof-icl-nocodec.tplg",
+	.ops = &sof_cnl_ops,
+	.arch_ops = &sof_xtensa_arch_ops
+};
+#endif
+
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_SKYLAKE)
+static const struct sof_dev_desc skl_desc = {
+	.machines		= snd_soc_acpi_intel_skl_machines,
+	.resindex_lpe_base	= 0,
+	.resindex_pcicfg_base	= -1,
+	.resindex_imr_base	= -1,
+	.irqindex_host_ipc	= -1,
+	.resindex_dma_base	= -1,
+	.chip_info = &skl_chip_info,
+	.default_fw_path = "intel/sof",
+	.default_tplg_path = "intel/sof-tplg",
+	.nocodec_fw_filename = "sof-skl.ri",
+	.nocodec_tplg_filename = "sof-skl-nocodec.tplg",
+	.ops = &sof_skl_ops,
+	.arch_ops = &sof_xtensa_arch_ops
+};
+#endif
+
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_KABYLAKE)
+static const struct sof_dev_desc kbl_desc = {
+	.machines		= snd_soc_acpi_intel_kbl_machines,
+	.resindex_lpe_base	= 0,
+	.resindex_pcicfg_base	= -1,
+	.resindex_imr_base	= -1,
+	.irqindex_host_ipc	= -1,
+	.resindex_dma_base	= -1,
+	.chip_info = &skl_chip_info,
+	.default_fw_path = "intel/sof",
+	.default_tplg_path = "intel/sof-tplg",
+	.nocodec_fw_filename = "sof-kbl.ri",
+	.nocodec_tplg_filename = "sof-kbl-nocodec.tplg",
+	.ops = &sof_skl_ops,
+	.arch_ops = &sof_xtensa_arch_ops
+};
+#endif
+
+static const struct dev_pm_ops sof_pci_pm = {
+	SET_SYSTEM_SLEEP_PM_OPS(snd_sof_suspend, snd_sof_resume)
+	SET_RUNTIME_PM_OPS(snd_sof_runtime_suspend, snd_sof_runtime_resume,
+			   NULL)
+};
+
+static void sof_pci_probe_complete(struct device *dev)
+{
+	dev_dbg(dev, "Completing SOF PCI probe");
+
+	/* allow runtime_pm */
+	pm_runtime_set_autosuspend_delay(dev, SND_SOF_SUSPEND_DELAY_MS);
+	pm_runtime_use_autosuspend(dev);
+
+	/*
+	 * runtime pm for pci device is "forbidden" by default.
+	 * so call pm_runtime_allow() to enable it.
+	 */
+	pm_runtime_allow(dev);
+
+	/* follow recommendation in pci-driver.c to decrement usage counter */
+	pm_runtime_put_noidle(dev);
+}
+
+static int sof_pci_probe(struct pci_dev *pci,
+			 const struct pci_device_id *pci_id)
+{
+	struct device *dev = &pci->dev;
+	const struct sof_dev_desc *desc =
+		(const struct sof_dev_desc *)pci_id->driver_data;
+	struct snd_soc_acpi_mach *mach;
+	struct snd_sof_pdata *sof_pdata;
+	const struct snd_sof_dsp_ops *ops;
+	int ret = 0;
+
+	dev_dbg(&pci->dev, "PCI DSP detected");
+
+	/* get ops for platform */
+	ops = desc->ops;
+	if (!ops) {
+		dev_err(dev, "error: no matching PCI descriptor ops\n");
+		return -ENODEV;
+	}
+
+	sof_pdata = devm_kzalloc(dev, sizeof(*sof_pdata), GFP_KERNEL);
+	if (!sof_pdata)
+		return -ENOMEM;
+
+	ret = pcim_enable_device(pci);
+	if (ret < 0)
+		return ret;
+
+	ret = pci_request_regions(pci, "Audio DSP");
+	if (ret < 0)
+		return ret;
+
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_FORCE_NOCODEC_MODE)
+	/* force nocodec mode */
+	dev_warn(dev, "Force to use nocodec mode\n");
+	mach = devm_kzalloc(dev, sizeof(*mach), GFP_KERNEL);
+	if (!mach) {
+		ret = -ENOMEM;
+		goto release_regions;
+	}
+	ret = sof_nocodec_setup(dev, sof_pdata, mach, desc, ops);
+	if (ret < 0)
+		goto release_regions;
+
+#else
+	/* find machine */
+	mach = snd_soc_acpi_find_machine(desc->machines);
+	if (!mach) {
+		dev_warn(dev, "warning: No matching ASoC machine driver found\n");
+	} else {
+		mach->mach_params.platform = dev_name(dev);
+		sof_pdata->fw_filename = mach->sof_fw_filename;
+		sof_pdata->tplg_filename = mach->sof_tplg_filename;
+	}
+#endif /* CONFIG_SND_SOC_SOF_FORCE_NOCODEC_MODE */
+
+	sof_pdata->name = pci_name(pci);
+	sof_pdata->machine = mach;
+	sof_pdata->desc = (struct sof_dev_desc *)pci_id->driver_data;
+	sof_pdata->dev = dev;
+	sof_pdata->platform = dev_name(dev);
+
+	/* alternate fw and tplg filenames ? */
+	if (fw_path)
+		sof_pdata->fw_filename_prefix = fw_path;
+	else
+		sof_pdata->fw_filename_prefix =
+			sof_pdata->desc->default_fw_path;
+
+	if (tplg_path)
+		sof_pdata->tplg_filename_prefix = tplg_path;
+	else
+		sof_pdata->tplg_filename_prefix =
+			sof_pdata->desc->default_tplg_path;
+
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_PROBE_WORK_QUEUE)
+	/* set callback to enable runtime_pm */
+	sof_pdata->sof_probe_complete = sof_pci_probe_complete;
+#endif
+	/* call sof helper for DSP hardware probe */
+	ret = snd_sof_device_probe(dev, sof_pdata);
+	if (ret) {
+		dev_err(dev, "error: failed to probe DSP hardware!\n");
+		goto release_regions;
+	}
+
+#if !IS_ENABLED(CONFIG_SND_SOC_SOF_PROBE_WORK_QUEUE)
+	sof_pci_probe_complete(dev);
+#endif
+
+	return ret;
+
+release_regions:
+	pci_release_regions(pci);
+
+	return ret;
+}
+
+static void sof_pci_remove(struct pci_dev *pci)
+{
+	/* call sof helper for DSP hardware remove */
+	snd_sof_device_remove(&pci->dev);
+
+	/* follow recommendation in pci-driver.c to increment usage counter */
+	pm_runtime_get_noresume(&pci->dev);
+
+	/* release pci regions and disable device */
+	pci_release_regions(pci);
+}
+
+/* PCI IDs */
+static const struct pci_device_id sof_pci_ids[] = {
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_EDISON)
+	{ PCI_DEVICE(0x8086, 0x119a),
+		.driver_data = (unsigned long)&tng_desc},
+#endif
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_APOLLOLAKE)
+	/* BXT-P & Apollolake */
+	{ PCI_DEVICE(0x8086, 0x5a98),
+		.driver_data = (unsigned long)&bxt_desc},
+	{ PCI_DEVICE(0x8086, 0x1a98),
+		.driver_data = (unsigned long)&bxt_desc},
+#endif
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_GEMINILAKE)
+	{ PCI_DEVICE(0x8086, 0x3198),
+		.driver_data = (unsigned long)&glk_desc},
+#endif
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_CANNONLAKE)
+	{ PCI_DEVICE(0x8086, 0x9dc8),
+		.driver_data = (unsigned long)&cnl_desc},
+#endif
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_KABYLAKE)
+	{ PCI_DEVICE(0x8086, 0x9d71),
+		.driver_data = (unsigned long)&kbl_desc},
+#endif
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_SKYLAKE)
+	{ PCI_DEVICE(0x8086, 0x9d70),
+		.driver_data = (unsigned long)&skl_desc},
+#endif
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_ICELAKE)
+	{ PCI_DEVICE(0x8086, 0x34C8),
+		.driver_data = (unsigned long)&icl_desc},
+#endif
+	{ 0, }
+};
+MODULE_DEVICE_TABLE(pci, sof_pci_ids);
+
+/* pci_driver definition */
+static struct pci_driver snd_sof_pci_driver = {
+	.name = "sof-audio-pci",
+	.id_table = sof_pci_ids,
+	.probe = sof_pci_probe,
+	.remove = sof_pci_remove,
+	.driver = {
+		.pm = &sof_pci_pm,
+	},
+};
+module_pci_driver(snd_sof_pci_driver);
+
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.17.1
