From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 1/3] ASoC: Intel: Skylake: fix missing machine
	device creation
Date: Fri, 30 Oct 2015 20:34:18 +0530
Message-ID: <1446217461-2106-2-git-send-email-vinod.koul@intel.com>
References: <1446217461-2106-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 5614C260663
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2015 16:01:11 +0100 (CET)
In-Reply-To: <1446217461-2106-1-git-send-email-vinod.koul@intel.com>
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

From: Jeeja KP <jeeja.kp@intel.com>

The UEFI BIOS does not create a machine entry for Linux devices
so add a table style machine registration to fix this missing
entry

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Omair M Abdullah <omair.m.abdullah@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl.c | 79 +++++++++++++++++++++++++++++++++++++++++--
 sound/soc/intel/skylake/skl.h |  1 +
 2 files changed, 78 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 9b94a8cdf9bd..e399a6734cf9 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -28,6 +28,11 @@
 #include <sound/pcm.h>
 #include "skl.h"
 
+struct sst_machines {
+	char *codec_id;
+	char *machine;
+};
+
 /*
  * initialize the PCI registers
  */
@@ -251,6 +256,64 @@ static int skl_free(struct hdac_ext_bus *ebus)
 	return 0;
 }
 
+static acpi_status sst_acpi_mach_match(acpi_handle handle, u32 level,
+				       void *context, void **ret)
+{
+	*(bool *)context = true;
+	return AE_OK;
+}
+
+static struct sst_machines *sst_acpi_find_machine(
+	struct sst_machines *machines)
+{
+	struct sst_machines *mach;
+	bool found = false;
+
+	for (mach = machines; mach->codec_id; mach++)
+		if (ACPI_SUCCESS(acpi_get_devices(mach->codec_id,
+						  sst_acpi_mach_match,
+						  &found, NULL)) && found)
+			return mach;
+
+	return NULL;
+}
+
+static int skl_machine_device_register(struct skl *skl, void *driver_data)
+{
+	struct hdac_bus *bus = ebus_to_hbus(&skl->ebus);
+	struct platform_device *pdev;
+	struct sst_machines *mach = driver_data;
+	int ret;
+
+	mach = sst_acpi_find_machine(mach);
+	if (mach == NULL) {
+		dev_err(bus->dev, "No matching machine driver found\n");
+		return -ENODEV;
+	}
+
+	pdev = platform_device_alloc(mach->machine, -1);
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
@@ -484,6 +547,10 @@ static int skl_probe(struct pci_dev *pci,
 			dev_dbg(bus->dev, "error failed to register dsp\n");
 			goto out_free;
 		}
+		err = skl_machine_device_register(skl,
+						  (void *)pci_id->driver_data);
+		if (err < 0)
+			goto out_dsp_free;
 	}
 	if (ebus->mlcap)
 		snd_hdac_ext_bus_get_ml_capabilities(ebus);
@@ -491,7 +558,7 @@ static int skl_probe(struct pci_dev *pci,
 	/* create device for soc dmic */
 	err = skl_dmic_device_register(skl);
 	if (err < 0)
-		goto out_dsp_free;
+		goto out_mach_free;
 
 	/* register platform dai and controls */
 	err = skl_platform_register(bus->dev);
@@ -515,6 +582,8 @@ out_unregister:
 	skl_platform_unregister(bus->dev);
 out_dmic_free:
 	skl_dmic_device_unregister(skl);
+out_mach_free:
+	skl_machine_device_unregister(skl);
 out_dsp_free:
 	skl_free_dsp(skl);
 out_free:
@@ -534,15 +603,21 @@ static void skl_remove(struct pci_dev *pci)
 	pci_dev_put(pci);
 	skl_platform_unregister(&pci->dev);
 	skl_free_dsp(skl);
+	skl_machine_device_unregister(skl);
 	skl_dmic_device_unregister(skl);
 	skl_free(ebus);
 	dev_set_drvdata(&pci->dev, NULL);
 }
 
+static struct sst_machines sst_skl_devdata[] = {
+	{ "INT343A", "skl_alc286s_i2s" },
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
