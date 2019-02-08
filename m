From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 11/17] ASoC: Intel: soc-acpi: cht-match: remove
	asoc_plat_name field
Date: Fri,  8 Feb 2019 17:45:51 -0600
Message-ID: <20190208234557.7816-12-pierre-louis.bossart@linux.intel.com>
References: <20190208234557.7816-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 09B1F267A56
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
 sound/soc/intel/common/soc-acpi-intel-cht-match.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/sound/soc/intel/common/soc-acpi-intel-cht-match.c b/sound/soc/intel/common/soc-acpi-intel-cht-match.c
index 21ce4bcbf25b..deafd87cc764 100644
--- a/sound/soc/intel/common/soc-acpi-intel-cht-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-cht-match.c
@@ -46,7 +46,6 @@ static struct snd_soc_acpi_mach cht_surface_mach = {
 	.board = "cht-bsw",
 	.sof_fw_filename = "sof-cht.ri",
 	.sof_tplg_filename = "sof-cht-rt5645.tplg",
-	.asoc_plat_name = "sst-mfld-platform",
 };
 
 static struct snd_soc_acpi_mach *cht_quirk(void *arg)
@@ -70,7 +69,6 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.board = "cht-bsw",
 		.sof_fw_filename = "sof-cht.ri",
 		.sof_tplg_filename = "sof-cht-rt5670.tplg",
-		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
 		.id = "10EC5672",
@@ -79,7 +77,6 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.board = "cht-bsw",
 		.sof_fw_filename = "sof-cht.ri",
 		.sof_tplg_filename = "sof-cht-rt5670.tplg",
-		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
 		.id = "10EC5645",
@@ -88,7 +85,6 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.board = "cht-bsw",
 		.sof_fw_filename = "sof-cht.ri",
 		.sof_tplg_filename = "sof-cht-rt5645.tplg",
-		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
 		.id = "10EC5650",
@@ -97,7 +93,6 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.board = "cht-bsw",
 		.sof_fw_filename = "sof-cht.ri",
 		.sof_tplg_filename = "sof-cht-rt5645.tplg",
-		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
 		.id = "10EC3270",
@@ -106,7 +101,6 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.board = "cht-bsw",
 		.sof_fw_filename = "sof-cht.ri",
 		.sof_tplg_filename = "sof-cht-rt5645.tplg",
-		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
 		.id = "193C9890",
@@ -115,7 +109,6 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.board = "cht-bsw",
 		.sof_fw_filename = "sof-cht.ri",
 		.sof_tplg_filename = "sof-cht-max98090.tplg",
-		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
 		.id = "10508824",
@@ -124,7 +117,6 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.board = "cht-bsw",
 		.sof_fw_filename = "sof-cht.ri",
 		.sof_tplg_filename = "sof-cht-nau8824.tplg",
-		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
 		.id = "DLGS7212",
@@ -133,7 +125,6 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.board = "bytcht_da7213",
 		.sof_fw_filename = "sof-cht.ri",
 		.sof_tplg_filename = "sof-cht-da7213.tplg",
-		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
 		.id = "DLGS7213",
@@ -142,7 +133,6 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.board = "bytcht_da7213",
 		.sof_fw_filename = "sof-cht.ri",
 		.sof_tplg_filename = "sof-cht-da7213.tplg",
-		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
 		.id = "ESSX8316",
@@ -151,7 +141,6 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.board = "bytcht_es8316",
 		.sof_fw_filename = "sof-cht.ri",
 		.sof_tplg_filename = "sof-cht-es8316.tplg",
-		.asoc_plat_name = "sst-mfld-platform",
 	},
 	/* some CHT-T platforms rely on RT5640, use Baytrail machine driver */
 	{
@@ -162,7 +151,6 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.machine_quirk = cht_quirk,
 		.sof_fw_filename = "sof-cht.ri",
 		.sof_tplg_filename = "sof-cht-rt5640.tplg",
-		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
 		.id = "10EC3276",
@@ -171,7 +159,6 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.board = "bytcr_rt5640",
 		.sof_fw_filename = "sof-cht.ri",
 		.sof_tplg_filename = "sof-cht-rt5640.tplg",
-		.asoc_plat_name = "sst-mfld-platform",
 	},
 	/* some CHT-T platforms rely on RT5651, use Baytrail machine driver */
 	{
@@ -181,7 +168,6 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.board = "bytcr_rt5651",
 		.sof_fw_filename = "sof-cht.ri",
 		.sof_tplg_filename = "sof-cht-rt5651.tplg",
-		.asoc_plat_name = "sst-mfld-platform",
 	},
 #if IS_ENABLED(CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH)
 	/*
-- 
2.17.1
