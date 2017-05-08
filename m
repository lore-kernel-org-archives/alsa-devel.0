From: Naveen M <naveen.m@intel.com>
Subject: [PATCH 3/6] ASoC: Add quirk data to support multiple
	codecs
Date: Mon,  8 May 2017 14:48:57 +0530
Message-ID: <1494235140-29369-4-git-send-email-naveen.m@intel.com>
References: <1494235140-29369-1-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id A8413266C0A
 for <alsa-devel@alsa-project.org>; Mon,  8 May 2017 11:19:33 +0200 (CEST)
In-Reply-To: <1494235140-29369-1-git-send-email-naveen.m@intel.com>
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
Cc: vinod.koul@intel.com, liam.r.girdwood@linux.intel.com, naveen.m@intel.com, broonie@kernel.org, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

Add quirk data in sst_acpi_mach() which will hold number of codecs
and codec names to search for a best possible matching machine.
Set NULL for existing drivers not using this.

Signed-off-by: Naveen M <naveen.m@intel.com>
---
 sound/soc/intel/atom/sst/sst_acpi.c | 46 ++++++++++++++++++-------------------
 sound/soc/intel/common/sst-acpi.h   |  1 +
 sound/soc/intel/skylake/skl.c       | 25 ++++++++++++--------
 3 files changed, 40 insertions(+), 32 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
index 3e6650e..aab85ad 100644
--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -452,11 +452,11 @@ static int byt_thinkpad10_quirk_cb(const struct dmi_system_id *id)
 
 static struct sst_acpi_mach cht_surface_mach = {
 	"10EC5640", "cht-bsw-rt5645", "intel/fw_sst_22a8.bin", "cht-bsw", NULL,
-								&chv_platform_data };
+						NULL, &chv_platform_data };
 
 static struct sst_acpi_mach byt_thinkpad_10 = {
 	"10EC5640", "cht-bsw-rt5672", "intel/fw_sst_0f28.bin", "cht-bsw", NULL,
-	                                                        &byt_rvp_platform_data };
+						NULL, &byt_rvp_platform_data };
 
 static struct sst_acpi_mach *cht_quirk(void *arg)
 {
@@ -485,29 +485,29 @@ static struct sst_acpi_mach *byt_quirk(void *arg)
 
 static struct sst_acpi_mach sst_acpi_bytcr[] = {
 	{"10EC5640", "bytcr_rt5640", "intel/fw_sst_0f28.bin", "bytcr_rt5640", byt_quirk,
-						&byt_rvp_platform_data },
+						NULL, &byt_rvp_platform_data },
 	{"10EC5642", "bytcr_rt5640", "intel/fw_sst_0f28.bin", "bytcr_rt5640", NULL,
-						&byt_rvp_platform_data },
+						NULL, &byt_rvp_platform_data },
 	{"INTCCFFD", "bytcr_rt5640", "intel/fw_sst_0f28.bin", "bytcr_rt5640", NULL,
-						&byt_rvp_platform_data },
+						NULL, &byt_rvp_platform_data },
 	{"10EC5651", "bytcr_rt5651", "intel/fw_sst_0f28.bin", "bytcr_rt5651", NULL,
-						&byt_rvp_platform_data },
+						NULL, &byt_rvp_platform_data },
 	{"DLGS7212", "bytcht_da7213", "intel/fw_sst_0f28.bin", "bytcht_da7213", NULL,
-						&byt_rvp_platform_data },
+						NULL, &byt_rvp_platform_data },
 	{"DLGS7213", "bytcht_da7213", "intel/fw_sst_0f28.bin", "bytcht_da7213", NULL,
-						&byt_rvp_platform_data },
+						NULL, &byt_rvp_platform_data },
 	/* some Baytrail platforms rely on RT5645, use CHT machine driver */
 	{"10EC5645", "cht-bsw-rt5645", "intel/fw_sst_0f28.bin", "cht-bsw", NULL,
-						&byt_rvp_platform_data },
+						NULL, &byt_rvp_platform_data },
 	{"10EC5648", "cht-bsw-rt5645", "intel/fw_sst_0f28.bin", "cht-bsw", NULL,
-						&byt_rvp_platform_data },
+						NULL, &byt_rvp_platform_data },
 #if IS_ENABLED(CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH)
 	/*
 	 * This is always last in the table so that it is selected only when
 	 * enabled explicitly and there is no codec-related information in SSDT
 	 */
 	{"80860F28", "bytcht_nocodec", "intel/fw_sst_0f28.bin", "bytcht_nocodec", NULL,
-						&byt_rvp_platform_data },
+						NULL, &byt_rvp_platform_data },
 #endif
 	{},
 };
@@ -515,37 +515,37 @@ static struct sst_acpi_mach *byt_quirk(void *arg)
 /* Cherryview-based platforms: CherryTrail and Braswell */
 static struct sst_acpi_mach sst_acpi_chv[] = {
 	{"10EC5670", "cht-bsw-rt5672", "intel/fw_sst_22a8.bin", "cht-bsw", NULL,
-						&chv_platform_data },
+						NULL, &chv_platform_data },
 	{"10EC5672", "cht-bsw-rt5672", "intel/fw_sst_22a8.bin", "cht-bsw", NULL,
-						&chv_platform_data },
+						NULL, &chv_platform_data },
 	{"10EC5645", "cht-bsw-rt5645", "intel/fw_sst_22a8.bin", "cht-bsw", NULL,
-						&chv_platform_data },
+						NULL, &chv_platform_data },
 	{"10EC5650", "cht-bsw-rt5645", "intel/fw_sst_22a8.bin", "cht-bsw", NULL,
-						&chv_platform_data },
+						NULL, &chv_platform_data },
 	{"10EC3270", "cht-bsw-rt5645", "intel/fw_sst_22a8.bin", "cht-bsw", NULL,
-						&chv_platform_data },
+						NULL, &chv_platform_data },
 
 	{"193C9890", "cht-bsw-max98090", "intel/fw_sst_22a8.bin", "cht-bsw", NULL,
-						&chv_platform_data },
+						NULL, &chv_platform_data },
 	{"DLGS7212", "bytcht_da7213", "intel/fw_sst_22a8.bin", "bytcht_da7213", NULL,
-						&chv_platform_data },
+						NULL, &chv_platform_data },
 	{"DLGS7213", "bytcht_da7213", "intel/fw_sst_22a8.bin", "bytcht_da7213", NULL,
-						&chv_platform_data },
+						NULL, &chv_platform_data },
 	/* some CHT-T platforms rely on RT5640, use Baytrail machine driver */
 	{"10EC5640", "bytcr_rt5640", "intel/fw_sst_22a8.bin", "bytcr_rt5640", cht_quirk,
-						&chv_platform_data },
+						NULL, &chv_platform_data },
 	{"10EC3276", "bytcr_rt5640", "intel/fw_sst_22a8.bin", "bytcr_rt5640", NULL,
-						&chv_platform_data },
+						NULL, &chv_platform_data },
 	/* some CHT-T platforms rely on RT5651, use Baytrail machine driver */
 	{"10EC5651", "bytcr_rt5651", "intel/fw_sst_22a8.bin", "bytcr_rt5651", NULL,
-						&chv_platform_data },
+						NULL, &chv_platform_data },
 #if IS_ENABLED(CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH)
 	/*
 	 * This is always last in the table so that it is selected only when
 	 * enabled explicitly and there is no codec-related information in SSDT
 	 */
 	{"808622A8", "bytcht_nocodec", "intel/fw_sst_22a8.bin", "bytcht_nocodec", NULL,
-						&chv_platform_data },
+						NULL, &chv_platform_data },
 #endif
 	{},
 };
diff --git a/sound/soc/intel/common/sst-acpi.h b/sound/soc/intel/common/sst-acpi.h
index 3649d3b..fbf010e 100644
--- a/sound/soc/intel/common/sst-acpi.h
+++ b/sound/soc/intel/common/sst-acpi.h
@@ -58,5 +58,6 @@ struct sst_acpi_mach {
 	/* board name */
 	const char *board;
 	struct sst_acpi_mach * (*machine_quirk)(void *arg);
+	const void *quirk_data;
 	void *pdata;
 };
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 6df3b31..1df4040 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -863,28 +863,35 @@ static void skl_remove(struct pci_dev *pci)
 }
 
 static struct sst_acpi_mach sst_skl_devdata[] = {
-	{ "INT343A", "skl_alc286s_i2s", "intel/dsp_fw_release.bin", NULL, NULL, NULL },
-	{ "INT343B", "skl_n88l25_s4567", "intel/dsp_fw_release.bin",
+	{ "INT343A", "skl_alc286s_i2s", "intel/dsp_fw_release.bin", NULL,
+				NULL, NULL, NULL },
+	{ "INT343B", "skl_n88l25_s4567", "intel/dsp_fw_release.bin", NULL,
 				NULL, NULL, &skl_dmic_data },
-	{ "MX98357A", "skl_n88l25_m98357a", "intel/dsp_fw_release.bin",
+	{ "MX98357A", "skl_n88l25_m98357a", "intel/dsp_fw_release.bin", NULL,
 				NULL, NULL, &skl_dmic_data },
 	{}
 };
 
 static struct sst_acpi_mach sst_bxtp_devdata[] = {
-	{ "INT343A", "bxt_alc298s_i2s", "intel/dsp_fw_bxtn.bin", NULL, NULL, NULL },
-	{ "DLGS7219", "bxt_da7219_max98357a_i2s", "intel/dsp_fw_bxtn.bin", NULL, NULL, NULL },
+	{ "INT343A", "bxt_alc298s_i2s", "intel/dsp_fw_bxtn.bin", NULL, NULL,
+				NULL, NULL },
+	{ "DLGS7219", "bxt_da7219_max98357a_i2s", "intel/dsp_fw_bxtn.bin", NULL,
+				NULL, NULL, NULL },
 };
 
 static struct sst_acpi_mach sst_kbl_devdata[] = {
-	{ "INT343A", "kbl_alc286s_i2s", "intel/dsp_fw_kbl.bin", NULL, NULL, NULL },
-	{ "INT343B", "kbl_n88l25_s4567", "intel/dsp_fw_kbl.bin", NULL, NULL, &skl_dmic_data },
-	{ "MX98357A", "kbl_n88l25_m98357a", "intel/dsp_fw_kbl.bin", NULL, NULL, &skl_dmic_data },
+	{ "INT343A", "kbl_alc286s_i2s", "intel/dsp_fw_kbl.bin", NULL, NULL,
+				NULL, NULL },
+	{ "INT343B", "kbl_n88l25_s4567", "intel/dsp_fw_kbl.bin", NULL, NULL,
+				NULL, &skl_dmic_data },
+	{ "MX98357A", "kbl_n88l25_m98357a", "intel/dsp_fw_kbl.bin", NULL, NULL,
+				NULL, &skl_dmic_data },
 	{}
 };
 
 static struct sst_acpi_mach sst_glk_devdata[] = {
-	{ "INT343A", "glk_alc298s_i2s", "intel/dsp_fw_glk.bin", NULL, NULL, NULL },
+	{ "INT343A", "glk_alc298s_i2s", "intel/dsp_fw_glk.bin", NULL, NULL,
+				NULL, NULL },
 };
 
 /* PCI IDs */
-- 
1.9.1
