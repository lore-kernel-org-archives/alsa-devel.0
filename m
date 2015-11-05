From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Fix skl machine driver
	creation" to the asoc tree
Date: Thu, 05 Nov 2015 16:29:39 +0000
Message-ID: <E1ZuNPv-0001K4-GF@finisterre>
References: <1446739455-22332-5-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B5B9D266485
 for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2015 17:29:56 +0100 (CET)
In-Reply-To: <1446739455-22332-5-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>, Omair M Abdullah <omair.m.abdullah@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Fix skl machine driver creation

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From d8d2cde2c0060744551b56319fd1c0c9355efaeb Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Thu, 5 Nov 2015 21:34:13 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Fix skl machine driver creation

Now that we have common match code in place, update the SKL
driver to use the common match routines for driver entry creation
for UEFI BIOS systems

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Omair M Abdullah <omair.m.abdullah@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl.c | 55 +++++++++++++++++++++++++++++++++++++++++--
 sound/soc/intel/skylake/skl.h |  1 +
 2 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 9b94a8c..59336cb 100644
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
index f803ebb..9b1beed 100644
--- a/sound/soc/intel/skylake/skl.h
+++ b/sound/soc/intel/skylake/skl.h
@@ -61,6 +61,7 @@ struct skl {
 
 	unsigned int init_failed:1; /* delayed init failed */
 	struct platform_device *dmic_dev;
+	struct platform_device *i2s_dev;
 
 	void *nhlt; /* nhlt ptr */
 	struct skl_sst *skl_sst; /* sst skl ctx */
-- 
2.6.1
