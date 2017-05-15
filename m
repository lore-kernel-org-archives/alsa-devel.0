From: Naveen M <naveen.m@intel.com>
Subject: [PATCH v3 2/7] ASoC: Intel: Convert skl machine data
	to C99 style
Date: Mon, 15 May 2017 13:42:12 +0530
Message-ID: <1494835937-22068-3-git-send-email-naveen.m@intel.com>
References: <1494835937-22068-1-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B1F526728A
 for <alsa-devel@alsa-project.org>; Mon, 15 May 2017 10:12:20 +0200 (CEST)
In-Reply-To: <1494835937-22068-1-git-send-email-naveen.m@intel.com>
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
Cc: vinod.koul@intel.com, liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, naveen.m@intel.com, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

C99 style struct initialization helps in readability as well as
initialization of variables not specified as NULL.
Patch modifies all skl machine data.

Suggested-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Naveen M <naveen.m@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl.c | 60 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 49 insertions(+), 11 deletions(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 6df3b31..22a7e39 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -863,28 +863,66 @@ static void skl_remove(struct pci_dev *pci)
 }
 
 static struct sst_acpi_mach sst_skl_devdata[] = {
-	{ "INT343A", "skl_alc286s_i2s", "intel/dsp_fw_release.bin", NULL, NULL, NULL },
-	{ "INT343B", "skl_n88l25_s4567", "intel/dsp_fw_release.bin",
-				NULL, NULL, &skl_dmic_data },
-	{ "MX98357A", "skl_n88l25_m98357a", "intel/dsp_fw_release.bin",
-				NULL, NULL, &skl_dmic_data },
+	{
+		.id = "INT343A",
+		.drv_name = "skl_alc286s_i2s",
+		.fw_filename = "intel/dsp_fw_release.bin",
+	},
+	{
+		.id = "INT343B",
+		.drv_name = "skl_n88l25_s4567",
+		.fw_filename = "intel/dsp_fw_release.bin",
+		.pdata = &skl_dmic_data
+	},
+	{
+		.id = "MX98357A",
+		.drv_name = "skl_n88l25_m98357a",
+		.fw_filename = "intel/dsp_fw_release.bin",
+		.pdata = &skl_dmic_data
+	},
 	{}
 };
 
 static struct sst_acpi_mach sst_bxtp_devdata[] = {
-	{ "INT343A", "bxt_alc298s_i2s", "intel/dsp_fw_bxtn.bin", NULL, NULL, NULL },
-	{ "DLGS7219", "bxt_da7219_max98357a_i2s", "intel/dsp_fw_bxtn.bin", NULL, NULL, NULL },
+	{
+		.id = "INT343A",
+		.drv_name = "bxt_alc298s_i2s",
+		.fw_filename = "intel/dsp_fw_bxtn.bin",
+	},
+	{
+		.id = "DLGS7219",
+		.drv_name = "bxt_da7219_max98357a_i2s",
+		.fw_filename = "intel/dsp_fw_bxtn.bin",
+	},
 };
 
 static struct sst_acpi_mach sst_kbl_devdata[] = {
-	{ "INT343A", "kbl_alc286s_i2s", "intel/dsp_fw_kbl.bin", NULL, NULL, NULL },
-	{ "INT343B", "kbl_n88l25_s4567", "intel/dsp_fw_kbl.bin", NULL, NULL, &skl_dmic_data },
-	{ "MX98357A", "kbl_n88l25_m98357a", "intel/dsp_fw_kbl.bin", NULL, NULL, &skl_dmic_data },
+	{
+		.id = "INT343A",
+		.drv_name = "kbl_alc286s_i2s",
+		.fw_filename = "intel/dsp_fw_kbl.bin",
+	},
+	{
+		.id = "INT343B",
+		.drv_name = "kbl_n88l25_s4567",
+		.fw_filename = "intel/dsp_fw_kbl.bin",
+		.pdata = &skl_dmic_data
+	},
+	{
+		.id = "MX98357A",
+		.drv_name = "kbl_n88l25_m98357a",
+		.fw_filename = "intel/dsp_fw_kbl.bin",
+		.pdata = &skl_dmic_data
+	},
 	{}
 };
 
 static struct sst_acpi_mach sst_glk_devdata[] = {
-	{ "INT343A", "glk_alc298s_i2s", "intel/dsp_fw_glk.bin", NULL, NULL, NULL },
+	{
+		.id = "INT343A",
+		.drv_name = "glk_alc298s_i2s",
+		.fw_filename = "intel/dsp_fw_glk.bin",
+	},
 };
 
 /* PCI IDs */
-- 
1.9.1
