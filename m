From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH 28/35] ASoC: Intel: Skylake: Update skl_ids
	table
Date: Thu, 22 Aug 2019 21:04:18 +0200
Message-ID: <20190822190425.23001-29-cezary.rojewski@intel.com>
References: <20190822190425.23001-1-cezary.rojewski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 65366F80671
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2019 21:05:27 +0200 (CEST)
In-Reply-To: <20190822190425.23001-1-cezary.rojewski@intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: lgirdwood@gmail.com, Cezary Rojewski <cezary.rojewski@intel.com>, broonie@kernel.org, tiwai@suse.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

With platform descriptors defined, update PCI ID table together with
skl_probe to retrieve supported boards from saved sst_pdata objects
instead.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/intel/skylake/skl.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index d6d099aba834..53a6befd5d68 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -985,6 +985,7 @@ static int skl_probe(struct pci_dev *pci,
 {
 	struct skl_dev *skl;
 	struct hdac_bus *bus = NULL;
+	struct sst_pdata *desc;
 	int err;
 
 	switch (skl_pci_binding) {
@@ -1064,7 +1065,8 @@ static int skl_probe(struct pci_dev *pci,
 
 	pci_set_drvdata(skl->pci, bus);
 
-	err = skl_find_machine(skl, (void *)pci_id->driver_data);
+	desc = (struct sst_pdata *)pci_id->driver_data;
+	err = skl_find_machine(skl, desc->boards);
 	if (err < 0) {
 		dev_err(bus->dev, "skl_find_machine failed with err: %d\n", err);
 		goto out_nhlt_free;
@@ -1194,42 +1196,42 @@ static const struct pci_device_id skl_ids[] = {
 #if IS_ENABLED(CONFIG_SND_SOC_INTEL_SKL)
 	/* Sunrise Point-LP */
 	{ PCI_DEVICE(0x8086, 0x9d70),
-		.driver_data = (unsigned long)&snd_soc_acpi_intel_skl_machines},
+		.driver_data = (unsigned long)&skl_desc },
 #endif
 #if IS_ENABLED(CONFIG_SND_SOC_INTEL_APL)
 	/* BXT-P */
 	{ PCI_DEVICE(0x8086, 0x5a98),
-		.driver_data = (unsigned long)&snd_soc_acpi_intel_bxt_machines},
+		.driver_data = (unsigned long)&apl_desc },
 #endif
 #if IS_ENABLED(CONFIG_SND_SOC_INTEL_KBL)
 	/* KBL */
 	{ PCI_DEVICE(0x8086, 0x9D71),
-		.driver_data = (unsigned long)&snd_soc_acpi_intel_kbl_machines},
+		.driver_data = (unsigned long)&kbl_desc },
 #endif
 #if IS_ENABLED(CONFIG_SND_SOC_INTEL_GLK)
 	/* GLK */
 	{ PCI_DEVICE(0x8086, 0x3198),
-		.driver_data = (unsigned long)&snd_soc_acpi_intel_glk_machines},
+		.driver_data = (unsigned long)&glk_desc },
 #endif
 #if IS_ENABLED(CONFIG_SND_SOC_INTEL_CNL)
 	/* CNL */
 	{ PCI_DEVICE(0x8086, 0x9dc8),
-		.driver_data = (unsigned long)&snd_soc_acpi_intel_cnl_machines},
+		.driver_data = (unsigned long)&cnl_desc },
 #endif
 #if IS_ENABLED(CONFIG_SND_SOC_INTEL_CFL)
 	/* CFL */
 	{ PCI_DEVICE(0x8086, 0xa348),
-		.driver_data = (unsigned long)&snd_soc_acpi_intel_cnl_machines},
+		.driver_data = (unsigned long)&cnl_desc },
 #endif
 #if IS_ENABLED(CONFIG_SND_SOC_INTEL_CML_LP)
 	/* CML-LP */
 	{ PCI_DEVICE(0x8086, 0x02c8),
-		.driver_data = (unsigned long)&snd_soc_acpi_intel_cnl_machines},
+		.driver_data = (unsigned long)&cnl_desc },
 #endif
 #if IS_ENABLED(CONFIG_SND_SOC_INTEL_CML_H)
 	/* CML-H */
 	{ PCI_DEVICE(0x8086, 0x06c8),
-		.driver_data = (unsigned long)&snd_soc_acpi_intel_cnl_machines},
+		.driver_data = (unsigned long)&cnl_desc },
 #endif
 	{ 0, }
 };
-- 
2.17.1
