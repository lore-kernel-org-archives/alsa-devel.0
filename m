From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 03/17] ASoC: Intel: cht-match: remove prefix
	for SOF files
Date: Fri,  8 Feb 2019 17:45:43 -0600
Message-ID: <20190208234557.7816-4-pierre-louis.bossart@linux.intel.com>
References: <20190208234557.7816-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id CA50D2674C9
 for <alsa-devel@alsa-project.org>; Sat,  9 Feb 2019 00:46:07 +0100 (CET)
In-Reply-To: <20190208234557.7816-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Prefix is now handled in the code. This allows for default and
alternate paths, and more flexibility for OEMs and distros

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 .../intel/common/soc-acpi-intel-cht-match.c   | 56 +++++++++----------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/sound/soc/intel/common/soc-acpi-intel-cht-match.c b/sound/soc/intel/common/soc-acpi-intel-cht-match.c
index 91bb99b69601..21ce4bcbf25b 100644
--- a/sound/soc/intel/common/soc-acpi-intel-cht-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-cht-match.c
@@ -44,8 +44,8 @@ static struct snd_soc_acpi_mach cht_surface_mach = {
 	.drv_name = "cht-bsw-rt5645",
 	.fw_filename = "intel/fw_sst_22a8.bin",
 	.board = "cht-bsw",
-	.sof_fw_filename = "intel/sof-cht.ri",
-	.sof_tplg_filename = "intel/sof-cht-rt5645.tplg",
+	.sof_fw_filename = "sof-cht.ri",
+	.sof_tplg_filename = "sof-cht-rt5645.tplg",
 	.asoc_plat_name = "sst-mfld-platform",
 };
 
@@ -68,8 +68,8 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.drv_name = "cht-bsw-rt5672",
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "cht-bsw",
-		.sof_fw_filename = "intel/sof-cht.ri",
-		.sof_tplg_filename = "intel/sof-cht-rt5670.tplg",
+		.sof_fw_filename = "sof-cht.ri",
+		.sof_tplg_filename = "sof-cht-rt5670.tplg",
 		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
@@ -77,8 +77,8 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.drv_name = "cht-bsw-rt5672",
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "cht-bsw",
-		.sof_fw_filename = "intel/sof-cht.ri",
-		.sof_tplg_filename = "intel/sof-cht-rt5670.tplg",
+		.sof_fw_filename = "sof-cht.ri",
+		.sof_tplg_filename = "sof-cht-rt5670.tplg",
 		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
@@ -86,8 +86,8 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.drv_name = "cht-bsw-rt5645",
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "cht-bsw",
-		.sof_fw_filename = "intel/sof-cht.ri",
-		.sof_tplg_filename = "intel/sof-cht-rt5645.tplg",
+		.sof_fw_filename = "sof-cht.ri",
+		.sof_tplg_filename = "sof-cht-rt5645.tplg",
 		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
@@ -95,8 +95,8 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.drv_name = "cht-bsw-rt5645",
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "cht-bsw",
-		.sof_fw_filename = "intel/sof-cht.ri",
-		.sof_tplg_filename = "intel/sof-cht-rt5645.tplg",
+		.sof_fw_filename = "sof-cht.ri",
+		.sof_tplg_filename = "sof-cht-rt5645.tplg",
 		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
@@ -104,8 +104,8 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.drv_name = "cht-bsw-rt5645",
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "cht-bsw",
-		.sof_fw_filename = "intel/sof-cht.ri",
-		.sof_tplg_filename = "intel/sof-cht-rt5645.tplg",
+		.sof_fw_filename = "sof-cht.ri",
+		.sof_tplg_filename = "sof-cht-rt5645.tplg",
 		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
@@ -113,8 +113,8 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.drv_name = "cht-bsw-max98090",
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "cht-bsw",
-		.sof_fw_filename = "intel/sof-cht.ri",
-		.sof_tplg_filename = "intel/sof-cht-max98090.tplg",
+		.sof_fw_filename = "sof-cht.ri",
+		.sof_tplg_filename = "sof-cht-max98090.tplg",
 		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
@@ -122,8 +122,8 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.drv_name = "cht-bsw-nau8824",
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "cht-bsw",
-		.sof_fw_filename = "intel/sof-cht.ri",
-		.sof_tplg_filename = "intel/sof-cht-nau8824.tplg",
+		.sof_fw_filename = "sof-cht.ri",
+		.sof_tplg_filename = "sof-cht-nau8824.tplg",
 		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
@@ -131,8 +131,8 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.drv_name = "bytcht_da7213",
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "bytcht_da7213",
-		.sof_fw_filename = "intel/sof-cht.ri",
-		.sof_tplg_filename = "intel/sof-cht-da7213.tplg",
+		.sof_fw_filename = "sof-cht.ri",
+		.sof_tplg_filename = "sof-cht-da7213.tplg",
 		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
@@ -140,8 +140,8 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.drv_name = "bytcht_da7213",
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "bytcht_da7213",
-		.sof_fw_filename = "intel/sof-cht.ri",
-		.sof_tplg_filename = "intel/sof-cht-da7213.tplg",
+		.sof_fw_filename = "sof-cht.ri",
+		.sof_tplg_filename = "sof-cht-da7213.tplg",
 		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
@@ -149,8 +149,8 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.drv_name = "bytcht_es8316",
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "bytcht_es8316",
-		.sof_fw_filename = "intel/sof-cht.ri",
-		.sof_tplg_filename = "intel/sof-cht-es8316.tplg",
+		.sof_fw_filename = "sof-cht.ri",
+		.sof_tplg_filename = "sof-cht-es8316.tplg",
 		.asoc_plat_name = "sst-mfld-platform",
 	},
 	/* some CHT-T platforms rely on RT5640, use Baytrail machine driver */
@@ -160,8 +160,8 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "bytcr_rt5640",
 		.machine_quirk = cht_quirk,
-		.sof_fw_filename = "intel/sof-cht.ri",
-		.sof_tplg_filename = "intel/sof-cht-rt5640.tplg",
+		.sof_fw_filename = "sof-cht.ri",
+		.sof_tplg_filename = "sof-cht-rt5640.tplg",
 		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
@@ -169,8 +169,8 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.drv_name = "bytcr_rt5640",
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "bytcr_rt5640",
-		.sof_fw_filename = "intel/sof-cht.ri",
-		.sof_tplg_filename = "intel/sof-cht-rt5640.tplg",
+		.sof_fw_filename = "sof-cht.ri",
+		.sof_tplg_filename = "sof-cht-rt5640.tplg",
 		.asoc_plat_name = "sst-mfld-platform",
 	},
 	/* some CHT-T platforms rely on RT5651, use Baytrail machine driver */
@@ -179,8 +179,8 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.drv_name = "bytcr_rt5651",
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "bytcr_rt5651",
-		.sof_fw_filename = "intel/sof-cht.ri",
-		.sof_tplg_filename = "intel/sof-cht-rt5651.tplg",
+		.sof_fw_filename = "sof-cht.ri",
+		.sof_tplg_filename = "sof-cht-rt5651.tplg",
 		.asoc_plat_name = "sst-mfld-platform",
 	},
 #if IS_ENABLED(CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH)
-- 
2.17.1
