From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 17/20] ASoC: SOF: Add ACPI device support
Date: Wed, 13 Feb 2019 16:08:44 -0600
Message-ID: <20190213220847.10567-18-pierre-louis.bossart@linux.intel.com>
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

Add support ACPI based SOF DSP devices.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/sof-acpi-dev.c | 310 +++++++++++++++++++++++++++++++++++
 1 file changed, 310 insertions(+)
 create mode 100644 sound/soc/sof/sof-acpi-dev.c

diff --git a/sound/soc/sof/sof-acpi-dev.c b/sound/soc/sof/sof-acpi-dev.c
new file mode 100644
index 000000000000..53d2ade525b5
--- /dev/null
+++ b/sound/soc/sof/sof-acpi-dev.c
@@ -0,0 +1,310 @@
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
+#include <linux/acpi.h>
+#include <linux/firmware.h>
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
+#include <sound/soc-acpi.h>
+#include <sound/soc-acpi-intel-match.h>
+#include <sound/sof.h>
+#ifdef CONFIG_X86
+#include <asm/iosf_mbi.h>
+#endif
+
+#include "ops.h"
+
+/* platform specific devices */
+#include "intel/shim.h"
+
+static char *fw_path;
+module_param(fw_path, charp, 0444);
+MODULE_PARM_DESC(fw_path, "alternate path for SOF firmware.");
+
+static char *tplg_path;
+module_param(tplg_path, charp, 0444);
+MODULE_PARM_DESC(tplg_path, "alternate path for SOF topology.");
+
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_HASWELL)
+static const struct sof_dev_desc sof_acpi_haswell_desc = {
+	.machines = snd_soc_acpi_intel_haswell_machines,
+	.resindex_lpe_base = 0,
+	.resindex_pcicfg_base = 1,
+	.resindex_imr_base = -1,
+	.irqindex_host_ipc = 0,
+	.chip_info = &hsw_chip_info,
+	.default_fw_path = "intel/sof",
+	.default_tplg_path = "intel/sof-tplg",
+	.nocodec_fw_filename = "sof-hsw.ri",
+	.nocodec_tplg_filename = "sof-hsw-nocodec.tplg",
+	.ops = &sof_hsw_ops,
+	.arch_ops = &sof_xtensa_arch_ops
+};
+#endif
+
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_BROADWELL)
+static const struct sof_dev_desc sof_acpi_broadwell_desc = {
+	.machines = snd_soc_acpi_intel_broadwell_machines,
+	.resindex_lpe_base = 0,
+	.resindex_pcicfg_base = 1,
+	.resindex_imr_base = -1,
+	.irqindex_host_ipc = 0,
+	.chip_info = &bdw_chip_info,
+	.default_fw_path = "intel/sof",
+	.default_tplg_path = "intel/sof-tplg",
+	.nocodec_fw_filename = "sof-bdw.ri",
+	.nocodec_tplg_filename = "sof-bdw-nocodec.tplg",
+	.ops = &sof_bdw_ops,
+	.arch_ops = &sof_xtensa_arch_ops
+};
+#endif
+
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_BAYTRAIL)
+
+/* BYTCR uses different IRQ index */
+static const struct sof_dev_desc sof_acpi_baytrailcr_desc = {
+	.machines = snd_soc_acpi_intel_baytrail_machines,
+	.resindex_lpe_base = 0,
+	.resindex_pcicfg_base = 1,
+	.resindex_imr_base = 2,
+	.irqindex_host_ipc = 0,
+	.chip_info = &byt_chip_info,
+	.default_fw_path = "intel/sof",
+	.default_tplg_path = "intel/sof-tplg",
+	.nocodec_fw_filename = "sof-byt.ri",
+	.nocodec_tplg_filename = "sof-byt-nocodec.tplg",
+	.ops = &sof_byt_ops,
+	.arch_ops = &sof_xtensa_arch_ops
+};
+
+static const struct sof_dev_desc sof_acpi_baytrail_desc = {
+	.machines = snd_soc_acpi_intel_baytrail_machines,
+	.resindex_lpe_base = 0,
+	.resindex_pcicfg_base = 1,
+	.resindex_imr_base = 2,
+	.irqindex_host_ipc = 5,
+	.chip_info = &byt_chip_info,
+	.default_fw_path = "intel/sof",
+	.default_tplg_path = "intel/sof-tplg",
+	.nocodec_fw_filename = "sof-byt.ri",
+	.nocodec_tplg_filename = "sof-byt-nocodec.tplg",
+	.ops = &sof_byt_ops,
+	.arch_ops = &sof_xtensa_arch_ops
+};
+
+#ifdef CONFIG_X86 /* TODO: move this to common helper */
+
+static bool is_byt_cr(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	int status = 0;
+
+	if (iosf_mbi_available()) {
+		u32 bios_status;
+		status = iosf_mbi_read(BT_MBI_UNIT_PMC, /* 0x04 PUNIT */
+				       MBI_REG_READ, /* 0x10 */
+				       0x006, /* BIOS_CONFIG */
+				       &bios_status);
+
+		if (status) {
+			dev_err(dev, "could not read PUNIT BIOS_CONFIG\n");
+		} else {
+			/* bits 26:27 mirror PMIC options */
+			bios_status = (bios_status >> 26) & 3;
+
+			if (bios_status == 1 || bios_status == 3) {
+				dev_info(dev, "Detected Baytrail-CR platform\n");
+				return true;
+			}
+
+			dev_info(dev, "BYT-CR not detected\n");
+		}
+	} else {
+		dev_info(dev, "IOSF_MBI not available, no BYT-CR detection\n");
+	}
+
+	if (platform_get_resource(pdev, IORESOURCE_IRQ, 5) == NULL) {
+		/*
+		 * Some devices detected as BYT-T have only a single IRQ listed,
+		 * causing platform_get_irq with index 5 to return -ENXIO.
+		 * The correct IRQ in this case is at index 0, as on BYT-CR.
+		 */
+		dev_info(dev, "Falling back to Baytrail-CR platform\n");
+		return true;
+	}
+
+	return false;
+}
+#else
+static int is_byt_cr(struct platform_device *pdev)
+{
+	return 0;
+}
+#endif
+
+static const struct sof_dev_desc sof_acpi_cherrytrail_desc = {
+	.machines = snd_soc_acpi_intel_cherrytrail_machines,
+	.resindex_lpe_base = 0,
+	.resindex_pcicfg_base = 1,
+	.resindex_imr_base = 2,
+	.irqindex_host_ipc = 5,
+	.chip_info = &cht_chip_info,
+	.default_fw_path = "intel/sof",
+	.default_tplg_path = "intel/sof-tplg",
+	.nocodec_fw_filename = "sof-cht.ri",
+	.nocodec_tplg_filename = "sof-cht-nocodec.tplg",
+	.ops = &sof_cht_ops,
+	.arch_ops = &sof_xtensa_arch_ops
+};
+
+#endif
+
+static const struct dev_pm_ops sof_acpi_pm = {
+	SET_SYSTEM_SLEEP_PM_OPS(snd_sof_suspend, snd_sof_resume)
+	SET_RUNTIME_PM_OPS(snd_sof_runtime_suspend, snd_sof_runtime_resume,
+			   NULL)
+};
+
+static void sof_acpi_probe_complete(struct device *dev)
+{
+	/* allow runtime_pm */
+	pm_runtime_set_autosuspend_delay(dev, SND_SOF_SUSPEND_DELAY_MS);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_enable(dev);
+}
+
+static int sof_acpi_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	const struct sof_dev_desc *desc;
+	struct snd_soc_acpi_mach *mach;
+	struct snd_sof_pdata *sof_pdata;
+	const struct snd_sof_dsp_ops *ops;
+	int ret = 0;
+
+	dev_dbg(&pdev->dev, "ACPI DSP detected");
+
+	sof_pdata = devm_kzalloc(dev, sizeof(*sof_pdata), GFP_KERNEL);
+	if (!sof_pdata)
+		return -ENOMEM;
+
+	desc = (const struct sof_dev_desc *)device_get_match_data(dev);
+	if (!desc)
+		return -ENODEV;
+
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_BAYTRAIL)
+	if (desc == &sof_acpi_baytrail_desc && is_byt_cr(pdev))
+		desc = &sof_acpi_baytrailcr_desc;
+#endif
+
+	/* get ops for platform */
+	ops = desc->ops;
+	if (!ops) {
+		dev_err(dev, "error: no matching ACPI descriptor ops\n");
+		return -ENODEV;
+	}
+
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_FORCE_NOCODEC_MODE)
+	/* force nocodec mode */
+	dev_warn(dev, "Force to use nocodec mode\n");
+	mach = devm_kzalloc(dev, sizeof(*mach), GFP_KERNEL);
+	if (!mach)
+		return -ENOMEM;
+	ret = sof_nocodec_setup(dev, sof_pdata, mach, desc, ops);
+	if (ret < 0)
+		return ret;
+#else
+	/* find machine */
+	mach = snd_soc_acpi_find_machine(desc->machines);
+	if (!mach) {
+		dev_warn(dev, "warning: No matching ASoC machine driver found\n");
+	} else {
+		sof_pdata->fw_filename = mach->sof_fw_filename;
+		sof_pdata->tplg_filename = mach->sof_tplg_filename;
+	}
+#endif
+
+	mach->mach_params.platform = dev_name(dev);
+	mach->mach_params.acpi_ipc_irq_index = desc->irqindex_host_ipc;
+
+	sof_pdata->machine = mach;
+	sof_pdata->desc = desc;
+	sof_pdata->dev = &pdev->dev;
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
+	sof_pdata->sof_probe_complete = sof_acpi_probe_complete;
+#endif
+	/* call sof helper for DSP hardware probe */
+	ret = snd_sof_device_probe(dev, sof_pdata);
+	if (ret) {
+		dev_err(dev, "error: failed to probe DSP hardware!\n");
+		return ret;
+	}
+
+#if !IS_ENABLED(CONFIG_SND_SOC_SOF_PROBE_WORK_QUEUE)
+	sof_acpi_probe_complete(dev);
+#endif
+
+	return ret;
+}
+
+static int sof_acpi_remove(struct platform_device *pdev)
+{
+	pm_runtime_disable(&pdev->dev);
+
+	/* call sof helper for DSP hardware remove */
+	snd_sof_device_remove(&pdev->dev);
+
+	return 0;
+}
+
+static const struct acpi_device_id sof_acpi_match[] = {
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_HASWELL)
+	{ "INT33C8", (unsigned long)&sof_acpi_haswell_desc },
+#endif
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_BROADWELL)
+	{ "INT3438", (unsigned long)&sof_acpi_broadwell_desc },
+#endif
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_BAYTRAIL)
+	{ "80860F28", (unsigned long)&sof_acpi_baytrail_desc },
+	{ "808622A8", (unsigned long)&sof_acpi_cherrytrail_desc },
+#endif
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, sof_acpi_match);
+
+/* acpi_driver definition */
+static struct platform_driver snd_sof_acpi_driver = {
+	.probe = sof_acpi_probe,
+	.remove = sof_acpi_remove,
+	.driver = {
+		.name = "sof-audio-acpi",
+		.pm = &sof_acpi_pm,
+		.acpi_match_table = ACPI_PTR(sof_acpi_match),
+	},
+};
+module_platform_driver(snd_sof_acpi_driver);
+
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.17.1
