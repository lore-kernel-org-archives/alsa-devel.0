From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 4/6] ASoC: Intel: Skylake: Fix skl machine
	driver creation
Date: Thu,  5 Nov 2015 21:34:13 +0530
Message-ID: <1446739455-22332-5-git-send-email-vinod.koul@intel.com>
References: <1446739455-22332-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B9DE2664B6
 for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2015 17:01:13 +0100 (CET)
In-Reply-To: <1446739455-22332-1-git-send-email-vinod.koul@intel.com>
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
Cc: patches.audio@intel.com, Omair M Abdullah <omair.m.abdullah@intel.com>, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

Now that we have common match code in place, update the SKL
driver to use the common match routines for driver entry creation
for UEFI BIOS systems

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Omair M Abdullah <omair.m.abdullah@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl.c | 55 +++++++++++++++++++++++++++++++++++++++++--
 sound/soc/intel/skylake/skl.h |  1 +
 2 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 9b94a8cdf9bd..59336cbc10dd 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -26,6 +26,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/platform_device.h>
 #include <sound/pcm.h>
+#include "../common/sst-acpi.h"
 #include "skl.h"
 
 /*
@@ -251,6 +252,42 @@ static int skl_free(struct hdac_ext_bus *ebus)
 	return 0;
 }
 
+static int skl_machine_device_register(struct skl *skl, void *driver_data)
+{
+	struct hdac_bus *bus = ebus_to_hbus(&skl->ebus);
+	struct platform_device *pdev;
+	struct sst_acpi_mach *mach = driver_data;
+	int ret;
+
+	mach = sst_acpi_find_machine(mach);
+	if (mach == NULL) {
+		dev_err(bus->dev, "No matching machine driver found\n");
+		return -ENODEV;
+	}
+
+	pdev = platform_device_alloc(mach->drv_name, -1);
+	if (pdev == NULL) {
+		dev_err(bus->dev, "platform device alloc failed\n");
+		return -EIO;
+	}
+
+	ret = platform_device_add(pdev);
+	if (ret) {
+		dev_err(bus->dev, "failed to add machine device\n");
+		platform_device_put(pdev);
+		return -EIO;
+	}
+	skl->i2s_dev = pdev;
+
+	return 0;
+}
+
+static void skl_machine_device_unregister(struct skl *skl)
+{
+	if (skl->i2s_dev)
+		platform_device_unregister(skl->i2s_dev);
+}
+
 static int skl_dmic_device_register(struct skl *skl)
 {
 	struct hdac_bus *bus = ebus_to_hbus(&skl->ebus);
@@ -479,10 +516,15 @@ static int skl_probe(struct pci_dev *pci,
 
 	/* check if dsp is there */
 	if (ebus->ppcap) {
+		err = skl_machine_device_register(skl,
+				  (void *)pci_id->driver_data);
+		if (err < 0)
+			goto out_free;
+
 		err = skl_init_dsp(skl);
 		if (err < 0) {
 			dev_dbg(bus->dev, "error failed to register dsp\n");
-			goto out_free;
+			goto out_mach_free;
 		}
 	}
 	if (ebus->mlcap)
@@ -517,6 +559,8 @@ out_dmic_free:
 	skl_dmic_device_unregister(skl);
 out_dsp_free:
 	skl_free_dsp(skl);
+out_mach_free:
+	skl_machine_device_unregister(skl);
 out_free:
 	skl->init_failed = 1;
 	skl_free(ebus);
@@ -534,15 +578,22 @@ static void skl_remove(struct pci_dev *pci)
 	pci_dev_put(pci);
 	skl_platform_unregister(&pci->dev);
 	skl_free_dsp(skl);
+	skl_machine_device_unregister(skl);
 	skl_dmic_device_unregister(skl);
 	skl_free(ebus);
 	dev_set_drvdata(&pci->dev, NULL);
 }
 
+static struct sst_acpi_mach sst_skl_devdata[] = {
+	{ "INT343A", "skl_alc286s_i2s", "intel/dsp_fw_release.bin", NULL, NULL, NULL },
+	{}
+};
+
 /* PCI IDs */
 static const struct pci_device_id skl_ids[] = {
 	/* Sunrise Point-LP */
-	{ PCI_DEVICE(0x8086, 0x9d70), 0},
+	{ PCI_DEVICE(0x8086, 0x9d70),
+		.driver_data = (unsigned long)&sst_skl_devdata},
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, skl_ids);
diff --git a/sound/soc/intel/skylake/skl.h b/sound/soc/intel/skylake/skl.h
index f803ebb10605..9b1beed26f0f 100644
--- a/sound/soc/intel/skylake/skl.h
+++ b/sound/soc/intel/skylake/skl.h
@@ -61,6 +61,7 @@ struct skl {
 
 	unsigned int init_failed:1; /* delayed init failed */
 	struct platform_device *dmic_dev;
+	struct platform_device *i2s_dev;
 
 	void *nhlt; /* nhlt ptr */
 	struct skl_sst *skl_sst; /* sst skl ctx */
-- 
1.9.1
