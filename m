From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH 3/4] ASoC: Intel: Skylake: Add Geminlake IDs
Date: Thu,  9 Feb 2017 16:44:03 +0530
Message-ID: <1486638844-17975-4-git-send-email-subhransu.s.prusty@intel.com>
References: <1486638844-17975-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 138062671C5
 for <alsa-devel@alsa-project.org>; Thu,  9 Feb 2017 12:24:55 +0100 (CET)
In-Reply-To: <1486638844-17975-1-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: tiwai@suse.de, lgirdwood@gmail.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Vinod Koul <vinod.koul@intel.com>

Geminilake is next gen SoC, so add the IDs for Geminilake.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
---
 sound/soc/intel/skylake/skl-messages.c | 7 +++++++
 sound/soc/intel/skylake/skl.c          | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index e79cbcf6e462..e66870474f10 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -220,6 +220,13 @@ static struct skl_dsp_loader_ops bxt_get_loader_ops(void)
 		.init_fw = bxt_sst_init_fw,
 		.cleanup = bxt_sst_dsp_cleanup
 	},
+	{
+		.id = 0x3198,
+		.loader_ops = bxt_get_loader_ops,
+		.init = bxt_sst_dsp_init,
+		.init_fw = bxt_sst_init_fw,
+		.cleanup = bxt_sst_dsp_cleanup
+	},
 };
 
 const struct skl_dsp_ops *skl_get_dsp_ops(int pci_id)
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 1152e46daede..0c57d4eaae3a 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -883,6 +883,10 @@ static void skl_remove(struct pci_dev *pci)
 	{}
 };
 
+static struct sst_acpi_mach sst_glk_devdata[] = {
+	{ "INT343A", "glk_alc298s_i2s", "intel/dsp_fw_glk.bin", NULL, NULL, NULL },
+};
+
 /* PCI IDs */
 static const struct pci_device_id skl_ids[] = {
 	/* Sunrise Point-LP */
@@ -894,6 +898,9 @@ static void skl_remove(struct pci_dev *pci)
 	/* KBL */
 	{ PCI_DEVICE(0x8086, 0x9D71),
 		.driver_data = (unsigned long)&sst_kbl_devdata},
+	/* GLK */
+	{ PCI_DEVICE(0x8086, 0x3198),
+		.driver_data = (unsigned long)&sst_glk_devdata},
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, skl_ids);
-- 
1.9.1
