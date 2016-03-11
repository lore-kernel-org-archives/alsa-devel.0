From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 6/8] ASoC: Intel: Bxtn: Add Broxton PCI ID
Date: Fri, 11 Mar 2016 10:12:54 +0530
Message-ID: <1457671376-18667-7-git-send-email-vinod.koul@intel.com>
References: <1457671376-18667-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id E7F3526644E
 for <alsa-devel@alsa-project.org>; Fri, 11 Mar 2016 05:39:06 +0100 (CET)
In-Reply-To: <1457671376-18667-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Senthilnathan Veppur <senthilnathanx.veppur@intel.com>

Broxton is an Intel SoC which sports a DSP and system is quite
like Skylake. So add this ID in Skylake driver

Signed-off-by: Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 0d38bdb8321b..ab5e25aaeee3 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -742,11 +742,18 @@ static struct sst_acpi_mach sst_skl_devdata[] = {
 	{}
 };
 
+static struct sst_acpi_mach sst_bxtp_devdata[] = {
+	{ "INT343A", "bxt_alc298s_i2s", "intel/dsp_fw_bxtn.bin", NULL, NULL, NULL },
+};
+
 /* PCI IDs */
 static const struct pci_device_id skl_ids[] = {
 	/* Sunrise Point-LP */
 	{ PCI_DEVICE(0x8086, 0x9d70),
 		.driver_data = (unsigned long)&sst_skl_devdata},
+	/* BXT-P */
+	{ PCI_DEVICE(0x8086, 0x5a98),
+		.driver_data = (unsigned long)&sst_bxtp_devdata},
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, skl_ids);
-- 
1.9.1
