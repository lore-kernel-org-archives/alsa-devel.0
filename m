From: Naveen M <naveen.m@intel.com>
Subject: [PATCH v3 1/7] ASoC: Intel: Convert atom machine data
	to C99 style
Date: Mon, 15 May 2017 13:42:11 +0530
Message-ID: <1494835937-22068-2-git-send-email-naveen.m@intel.com>
References: <1494835937-22068-1-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id B916C26727B
 for <alsa-devel@alsa-project.org>; Mon, 15 May 2017 10:12:17 +0200 (CEST)
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
Patch modifies all atom machine data.

Suggested-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Naveen M <naveen.m@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/atom/sst/sst_acpi.c | 209 ++++++++++++++++++++++++++++--------
 1 file changed, 162 insertions(+), 47 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
index dd250b8..193c4d7 100644
--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -453,12 +453,20 @@ static int byt_thinkpad10_quirk_cb(const struct dmi_system_id *id)
 
 
 static struct sst_acpi_mach cht_surface_mach = {
-	"10EC5640", "cht-bsw-rt5645", "intel/fw_sst_22a8.bin", "cht-bsw", NULL,
-								&chv_platform_data };
+	.id = "10EC5640",
+	.drv_name = "cht-bsw-rt5645",
+	.fw_filename = "intel/fw_sst_22a8.bin",
+	.board = "cht-bsw",
+	.pdata = &chv_platform_data,
+};
 
 static struct sst_acpi_mach byt_thinkpad_10 = {
-	"10EC5640", "cht-bsw-rt5672", "intel/fw_sst_0f28.bin", "cht-bsw", NULL,
-	                                                        &byt_rvp_platform_data };
+	.id = "10EC5640",
+	.drv_name = "cht-bsw-rt5672",
+	.fw_filename = "intel/fw_sst_0f28.bin",
+	.board = "cht-bsw",
+	.pdata = &byt_rvp_platform_data,
+};
 
 static struct sst_acpi_mach *cht_quirk(void *arg)
 {
@@ -486,68 +494,175 @@ static struct sst_acpi_mach *byt_quirk(void *arg)
 
 
 static struct sst_acpi_mach sst_acpi_bytcr[] = {
-	{"10EC5640", "bytcr_rt5640", "intel/fw_sst_0f28.bin", "bytcr_rt5640", byt_quirk,
-						&byt_rvp_platform_data },
-	{"10EC5642", "bytcr_rt5640", "intel/fw_sst_0f28.bin", "bytcr_rt5640", NULL,
-						&byt_rvp_platform_data },
-	{"INTCCFFD", "bytcr_rt5640", "intel/fw_sst_0f28.bin", "bytcr_rt5640", NULL,
-						&byt_rvp_platform_data },
-	{"10EC5651", "bytcr_rt5651", "intel/fw_sst_0f28.bin", "bytcr_rt5651", NULL,
-						&byt_rvp_platform_data },
-	{"DLGS7212", "bytcht_da7213", "intel/fw_sst_0f28.bin", "bytcht_da7213", NULL,
-						&byt_rvp_platform_data },
-	{"DLGS7213", "bytcht_da7213", "intel/fw_sst_0f28.bin", "bytcht_da7213", NULL,
-						&byt_rvp_platform_data },
+	{
+		.id = "10EC5640",
+		.drv_name = "bytcr_rt5640",
+		.fw_filename = "intel/fw_sst_0f28.bin",
+		.board = "bytcr_rt5640",
+		.machine_quirk = byt_quirk,
+		.pdata = &byt_rvp_platform_data,
+	},
+	{
+		.id = "10EC5642",
+		.drv_name = "bytcr_rt5640",
+		.fw_filename = "intel/fw_sst_0f28.bin",
+		.board = "bytcr_rt5640",
+		.pdata = &byt_rvp_platform_data
+	},
+	{
+		.id = "INTCCFFD",
+		.drv_name = "bytcr_rt5640",
+		.fw_filename = "intel/fw_sst_0f28.bin",
+		.board = "bytcr_rt5640",
+		.pdata = &byt_rvp_platform_data
+	},
+	{
+		.id = "10EC5651",
+		.drv_name = "bytcr_rt5651",
+		.fw_filename = "intel/fw_sst_0f28.bin",
+		.board = "bytcr_rt5651",
+		.pdata = &byt_rvp_platform_data
+	},
+	{
+		.id = "DLGS7212",
+		.drv_name = "bytcht_da7213",
+		.fw_filename = "intel/fw_sst_0f28.bin",
+		.board = "bytcht_da7213",
+		.pdata = &byt_rvp_platform_data
+	},
+	{
+		.id = "DLGS7213",
+		.drv_name = "bytcht_da7213",
+		.fw_filename = "intel/fw_sst_0f28.bin",
+		.board = "bytcht_da7213",
+		.pdata = &byt_rvp_platform_data
+	},
 	/* some Baytrail platforms rely on RT5645, use CHT machine driver */
-	{"10EC5645", "cht-bsw-rt5645", "intel/fw_sst_0f28.bin", "cht-bsw", NULL,
-						&byt_rvp_platform_data },
-	{"10EC5648", "cht-bsw-rt5645", "intel/fw_sst_0f28.bin", "cht-bsw", NULL,
-						&byt_rvp_platform_data },
+	{
+		.id = "10EC5645",
+		.drv_name = "cht-bsw-rt5645",
+		.fw_filename = "intel/fw_sst_0f28.bin",
+		.board = "cht-bsw",
+		.pdata = &byt_rvp_platform_data
+	},
+	{
+		.id = "10EC5648",
+		.drv_name = "cht-bsw-rt5645",
+		.fw_filename = "intel/fw_sst_0f28.bin",
+		.board = "cht-bsw",
+		.pdata = &byt_rvp_platform_data
+	},
 #if IS_ENABLED(CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH)
 	/*
 	 * This is always last in the table so that it is selected only when
 	 * enabled explicitly and there is no codec-related information in SSDT
 	 */
-	{"80860F28", "bytcht_nocodec", "intel/fw_sst_0f28.bin", "bytcht_nocodec", NULL,
-						&byt_rvp_platform_data },
+	{
+		.id = "80860F28",
+		.drv_name = "bytcht_nocodec",
+		.fw_filename = "intel/fw_sst_0f28.bin",
+		.board = "bytcht_nocodec",
+		.pdata = &byt_rvp_platform_data
+	},
 #endif
 	{},
 };
 
 /* Cherryview-based platforms: CherryTrail and Braswell */
 static struct sst_acpi_mach sst_acpi_chv[] = {
-	{"10EC5670", "cht-bsw-rt5672", "intel/fw_sst_22a8.bin", "cht-bsw", NULL,
-						&chv_platform_data },
-	{"10EC5672", "cht-bsw-rt5672", "intel/fw_sst_22a8.bin", "cht-bsw", NULL,
-						&chv_platform_data },
-	{"10EC5645", "cht-bsw-rt5645", "intel/fw_sst_22a8.bin", "cht-bsw", NULL,
-						&chv_platform_data },
-	{"10EC5650", "cht-bsw-rt5645", "intel/fw_sst_22a8.bin", "cht-bsw", NULL,
-						&chv_platform_data },
-	{"10EC3270", "cht-bsw-rt5645", "intel/fw_sst_22a8.bin", "cht-bsw", NULL,
-						&chv_platform_data },
-
-	{"193C9890", "cht-bsw-max98090", "intel/fw_sst_22a8.bin", "cht-bsw", NULL,
-						&chv_platform_data },
-	{"DLGS7212", "bytcht_da7213", "intel/fw_sst_22a8.bin", "bytcht_da7213", NULL,
-						&chv_platform_data },
-	{"DLGS7213", "bytcht_da7213", "intel/fw_sst_22a8.bin", "bytcht_da7213", NULL,
-						&chv_platform_data },
+	{
+		.id = "10EC5670",
+		.drv_name = "cht-bsw-rt5672",
+		.fw_filename = "intel/fw_sst_22a8.bin",
+		.board = "cht-bsw",
+		.pdata = &chv_platform_data
+	},
+	{
+		.id = "10EC5672",
+		.drv_name = "cht-bsw-rt5672",
+		.fw_filename = "intel/fw_sst_22a8.bin",
+		.board = "cht-bsw",
+		.pdata = &chv_platform_data
+	},
+	{
+		.id = "10EC5645",
+		.drv_name = "cht-bsw-rt5645",
+		.fw_filename = "intel/fw_sst_22a8.bin",
+		.board = "cht-bsw",
+		.pdata = &chv_platform_data
+	},
+	{
+		.id = "10EC5650",
+		.drv_name = "cht-bsw-rt5645",
+		.fw_filename = "intel/fw_sst_22a8.bin",
+		.board = "cht-bsw",
+		.pdata = &chv_platform_data
+	},
+	{
+		.id = "10EC3270",
+		.drv_name = "cht-bsw-rt5645",
+		.fw_filename = "intel/fw_sst_22a8.bin",
+		.board = "cht-bsw",
+		.pdata = &chv_platform_data
+	},
+
+	{
+		.id = "193C9890",
+		.drv_name = "cht-bsw-max98090",
+		.fw_filename = "intel/fw_sst_22a8.bin",
+		.board = "cht-bsw",
+		.pdata = &chv_platform_data
+	},
+	{
+		.id = "DLGS7212",
+		.drv_name = "bytcht_da7213",
+		.fw_filename = "intel/fw_sst_22a8.bin",
+		.board = "bytcht_da7213",
+		.pdata = &chv_platform_data
+	},
+	{
+		.id = "DLGS7213",
+		.drv_name = "bytcht_da7213",
+		.fw_filename = "intel/fw_sst_22a8.bin",
+		.board = "bytcht_da7213",
+		.pdata = &chv_platform_data
+	},
 	/* some CHT-T platforms rely on RT5640, use Baytrail machine driver */
-	{"10EC5640", "bytcr_rt5640", "intel/fw_sst_22a8.bin", "bytcr_rt5640", cht_quirk,
-						&chv_platform_data },
-	{"10EC3276", "bytcr_rt5640", "intel/fw_sst_22a8.bin", "bytcr_rt5640", NULL,
-						&chv_platform_data },
+	{
+		.id = "10EC5640",
+		.drv_name = "bytcr_rt5640",
+		.fw_filename = "intel/fw_sst_22a8.bin",
+		.board = "bytcr_rt5640",
+		.machine_quirk = cht_quirk,
+		.pdata = &chv_platform_data
+	},
+	{
+		.id = "10EC3276",
+		.drv_name = "bytcr_rt5640",
+		.fw_filename = "intel/fw_sst_22a8.bin",
+		.board = "bytcr_rt5640",
+		.pdata = &chv_platform_data
+	},
 	/* some CHT-T platforms rely on RT5651, use Baytrail machine driver */
-	{"10EC5651", "bytcr_rt5651", "intel/fw_sst_22a8.bin", "bytcr_rt5651", NULL,
-						&chv_platform_data },
+	{
+		.id = "10EC5651",
+		.drv_name = "bytcr_rt5651",
+		.fw_filename = "intel/fw_sst_22a8.bin",
+		.board = "bytcr_rt5651",
+		.pdata = &chv_platform_data
+	},
 #if IS_ENABLED(CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH)
 	/*
 	 * This is always last in the table so that it is selected only when
 	 * enabled explicitly and there is no codec-related information in SSDT
 	 */
-	{"808622A8", "bytcht_nocodec", "intel/fw_sst_22a8.bin", "bytcht_nocodec", NULL,
-						&chv_platform_data },
+	{
+		.id = "808622A8",
+		.drv_name = "bytcht_nocodec",
+		.fw_filename = "intel/fw_sst_22a8.bin",
+		.board = "bytcht_nocodec",
+		.pdata = &chv_platform_data
+	},
 #endif
 	{},
 };
-- 
1.9.1
