From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 3/3] ALSA: hda: register selectively for SPT-LP
Date: Thu, 30 Apr 2015 20:22:36 +0530
Message-ID: <1430405556-19166-3-git-send-email-vinod.koul@intel.com>
References: <1430405556-19166-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 7B86A261A3B
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2015 16:52:07 +0200 (CEST)
In-Reply-To: <1430405556-19166-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

Sunrisepoint-LP HDA controller supports aDSP, so register selectively for
this controller

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/pci/hda/hda_intel.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 488dab208ddc..314a7beb2b29 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2023,9 +2023,6 @@ static const struct pci_device_id azx_ids[] = {
 	/* Sunrise Point */
 	{ PCI_DEVICE(0x8086, 0xa170),
 	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_SKYLAKE },
-	/* Sunrise Point-LP */
-	{ PCI_DEVICE(0x8086, 0x9d70),
-	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_SKYLAKE },
 	/* Haswell */
 	{ PCI_DEVICE(0x8086, 0x0a0c),
 	  .driver_data = AZX_DRIVER_HDMI | AZX_DCAPS_INTEL_HASWELL },
@@ -2205,6 +2202,14 @@ static const struct pci_device_id azx_ids[] = {
 };
 MODULE_DEVICE_TABLE(pci, azx_ids);
 
+static const struct pci_device_id azx_intel_adsp_ids[] = {
+	/* Sunrise Point-LP */
+	{ PCI_DEVICE(0x8086, 0x9d70),
+	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_SKYLAKE },
+	{ 0, }
+};
+MODULE_DEVICE_TABLE(pci, azx_intel_adsp_ids);
+
 /* pci_driver definition */
 static struct pci_driver azx_driver = {
 	.name = KBUILD_MODNAME,
@@ -2217,12 +2222,25 @@ static struct pci_driver azx_driver = {
 	},
 };
 
+static struct pci_driver azx_intel_adsp_driver = {
+	.name = KBUILD_MODNAME,
+	.id_table = azx_intel_adsp_ids,
+	.probe = azx_probe,
+	.remove = azx_remove,
+	.shutdown = azx_shutdown,
+	.driver = {
+		.pm = AZX_PM_OPS,
+	},
+};
+
 static int __init azx_module_init(void)
 {
 	int ret;
 
 	ret = pci_register_driver(&azx_driver);
 
+	if (!hdac_adsp_enable)
+		ret = pci_register_driver(&azx_intel_adsp_driver);
 	return ret;
 }
 module_init(azx_module_init);
@@ -2231,5 +2249,12 @@ static void __exit azx_module_exit(void)
 {
 	pci_unregister_driver(&azx_driver);
 
+	/* Some Intel HDA controllers support aDSP this is enabled thru the
+	 * ASoC HDA aDSP driver So we register for these devices only when
+	 * aDSP is disabled by the hdac_adsp_enable flag
+	 */
+	if (!hdac_adsp_enable)
+		pci_unregister_driver(&azx_intel_adsp_driver);
+
 }
 module_exit(azx_module_exit);
-- 
1.9.1
