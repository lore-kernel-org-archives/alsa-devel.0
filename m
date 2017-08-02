From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Subject: [PATCH 9/9] ASoC: Intel: cnl: add pci id for cnl
Date: Wed,  2 Aug 2017 21:51:20 +0530
Message-ID: <20170802162120.8935-10-guneshwor.o.singh@intel.com>
References: <20170802162120.8935-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id D8F95267356
 for <alsa-devel@alsa-project.org>; Wed,  2 Aug 2017 18:25:53 +0200 (CEST)
In-Reply-To: <20170802162120.8935-1-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Patches Audio <patches.audio@intel.com>
List-Id: alsa-devel@alsa-project.org

Enable cnl by adding its pci id in skl_ids[].

Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
---
 sound/soc/intel/skylake/skl.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index ab651517e8b8..e612a4097275 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -996,6 +996,14 @@ static struct sst_acpi_mach sst_glk_devdata[] = {
 	},
 };
 
+static const struct sst_acpi_mach sst_cnl_devdata[] = {
+	{
+		.id = "INT34C2",
+		.drv_name = "cnl_rt274",
+		.fw_filename = "intel/dsp_fw_cnl.bin",
+	},
+};
+
 /* PCI IDs */
 static const struct pci_device_id skl_ids[] = {
 	/* Sunrise Point-LP */
@@ -1010,6 +1018,9 @@ static const struct pci_device_id skl_ids[] = {
 	/* GLK */
 	{ PCI_DEVICE(0x8086, 0x3198),
 		.driver_data = (unsigned long)&sst_glk_devdata},
+	/* CNL */
+	{ PCI_DEVICE(0x8086, 0x9dc8),
+		.driver_data = (unsigned long)&sst_cnl_devdata},
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, skl_ids);
-- 
2.13.0
