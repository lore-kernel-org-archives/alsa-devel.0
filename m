From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 1/4] ASoC: Intel: add kablake device IDs
Date: Mon, 11 Jul 2016 22:02:08 +0530
Message-ID: <1468254731-15394-2-git-send-email-vinod.koul@intel.com>
References: <1468254731-15394-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B6A0265338
 for <alsa-devel@alsa-project.org>; Mon, 11 Jul 2016 18:25:09 +0200 (CEST)
In-Reply-To: <1468254731-15394-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

Kabylake is next generation Intel platform which has similar
audio controller to Skylake, so add the ID and driver data in
SKL driver.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-messages.c | 6 ++++++
 sound/soc/intel/skylake/skl.c          | 8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index 6902020df946..44ab595ce21a 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -206,6 +206,12 @@ static const struct skl_dsp_ops dsp_ops[] = {
 		.cleanup = skl_sst_dsp_cleanup
 	},
 	{
+		.id = 0x9d71,
+		.loader_ops = skl_get_loader_ops,
+		.init = skl_sst_dsp_init,
+		.cleanup = skl_sst_dsp_cleanup
+	},
+	{
 		.id = 0x5a98,
 		.loader_ops = bxt_get_loader_ops,
 		.init = bxt_sst_dsp_init,
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index d5d7c53e07bc..4e30effc5469 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -813,6 +813,11 @@ static struct sst_acpi_mach sst_bxtp_devdata[] = {
 	{ "DLGS7219", "bxt_da7219_max98357a_i2s", "intel/dsp_fw_bxtn.bin", NULL, NULL, NULL },
 };
 
+static struct sst_acpi_mach sst_kbl_devdata[] = {
+	{ "INT343A", "kbl_alc286s_i2s", "intel/dsp_fw_kbl.bin", NULL, NULL, NULL },
+	{}
+};
+
 /* PCI IDs */
 static const struct pci_device_id skl_ids[] = {
 	/* Sunrise Point-LP */
@@ -821,6 +826,9 @@ static const struct pci_device_id skl_ids[] = {
 	/* BXT-P */
 	{ PCI_DEVICE(0x8086, 0x5a98),
 		.driver_data = (unsigned long)&sst_bxtp_devdata},
+	/* KBL */
+	{ PCI_DEVICE(0x8086, 0x9D71),
+		.driver_data = (unsigned long)&sst_kbl_devdata},
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, skl_ids);
-- 
1.9.1
