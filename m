From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 10/17] ASoC: Intel: soc-acpi: byt-match: remove
	asoc_plat_name field
Date: Fri,  8 Feb 2019 17:45:50 -0600
Message-ID: <20190208234557.7816-11-pierre-louis.bossart@linux.intel.com>
References: <20190208234557.7816-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 44A08267A3F
 for <alsa-devel@alsa-project.org>; Sat,  9 Feb 2019 00:46:12 +0100 (CET)
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

This field was never used, let's remove it

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/common/soc-acpi-intel-byt-match.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/sound/soc/intel/common/soc-acpi-intel-byt-match.c b/sound/soc/intel/common/soc-acpi-intel-byt-match.c
index a46a3514a0f0..fe812a909db4 100644
--- a/sound/soc/intel/common/soc-acpi-intel-byt-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-byt-match.c
@@ -85,7 +85,6 @@ static struct snd_soc_acpi_mach byt_thinkpad_10 = {
 	.board = "cht-bsw",
 	.sof_fw_filename = "sof-byt.ri",
 	.sof_tplg_filename = "sof-byt-rt5670.tplg",
-	.asoc_plat_name = "sst-mfld-platform",
 };
 
 static struct snd_soc_acpi_mach byt_pov_p1006w = {
@@ -95,7 +94,6 @@ static struct snd_soc_acpi_mach byt_pov_p1006w = {
 	.board = "bytcr_rt5651",
 	.sof_fw_filename = "sof-byt.ri",
 	.sof_tplg_filename = "sof-byt-rt5651.tplg",
-	.asoc_plat_name = "sst-mfld-platform",
 };
 
 static struct snd_soc_acpi_mach *byt_quirk(void *arg)
@@ -138,7 +136,6 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_baytrail_machines[] = {
 		.machine_quirk = byt_quirk,
 		.sof_fw_filename = "sof-byt.ri",
 		.sof_tplg_filename = "sof-byt-rt5640.tplg",
-		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
 		.id = "10EC5642",
@@ -147,7 +144,6 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_baytrail_machines[] = {
 		.board = "bytcr_rt5640",
 		.sof_fw_filename = "sof-byt.ri",
 		.sof_tplg_filename = "sof-byt-rt5640.tplg",
-		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
 		.id = "INTCCFFD",
@@ -156,7 +152,6 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_baytrail_machines[] = {
 		.board = "bytcr_rt5640",
 		.sof_fw_filename = "sof-byt.ri",
 		.sof_tplg_filename = "sof-byt-rt5640.tplg",
-		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
 		.id = "10EC5651",
@@ -165,7 +160,6 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_baytrail_machines[] = {
 		.board = "bytcr_rt5651",
 		.sof_fw_filename = "sof-byt.ri",
 		.sof_tplg_filename = "sof-byt-rt5651.tplg",
-		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
 		.id = "DLGS7212",
@@ -174,7 +168,6 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_baytrail_machines[] = {
 		.board = "bytcht_da7213",
 		.sof_fw_filename = "sof-byt.ri",
 		.sof_tplg_filename = "sof-byt-da7213.tplg",
-		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
 		.id = "DLGS7213",
@@ -183,7 +176,6 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_baytrail_machines[] = {
 		.board = "bytcht_da7213",
 		.sof_fw_filename = "sof-byt.ri",
 		.sof_tplg_filename = "sof-byt-da7213.tplg",
-		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
 		.id = "ESSX8316",
@@ -192,7 +184,6 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_baytrail_machines[] = {
 		.board = "bytcht_es8316",
 		.sof_fw_filename = "sof-byt.ri",
 		.sof_tplg_filename = "sof-byt-es8316.tplg",
-		.asoc_plat_name = "sst-mfld-platform",
 	},
 	/* some Baytrail platforms rely on RT5645, use CHT machine driver */
 	{
@@ -202,7 +193,6 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_baytrail_machines[] = {
 		.board = "cht-bsw",
 		.sof_fw_filename = "sof-byt.ri",
 		.sof_tplg_filename = "sof-byt-rt5645.tplg",
-		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
 		.id = "10EC5648",
@@ -211,7 +201,6 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_baytrail_machines[] = {
 		.board = "cht-bsw",
 		.sof_fw_filename = "sof-byt.ri",
 		.sof_tplg_filename = "sof-byt-rt5645.tplg",
-		.asoc_plat_name = "sst-mfld-platform",
 	},
 	/* use CHT driver to Baytrail Chromebooks */
 	{
@@ -221,7 +210,6 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_baytrail_machines[] = {
 		.board = "cht-bsw",
 		.sof_fw_filename = "sof-byt.ri",
 		.sof_tplg_filename = "sof-byt-max98090.tplg",
-		.asoc_plat_name = "sst-mfld-platform",
 	},
 #if IS_ENABLED(CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH)
 	/*
-- 
2.17.1
