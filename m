From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 2/8] ASoC: Intel: common: use c99 syntax for
	ACPI/machine tables
Date: Thu, 12 Oct 2017 18:49:39 -0500
Message-ID: <20171012234945.30318-3-pierre-louis.bossart@linux.intel.com>
References: <20171012234945.30318-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id E4AD0266EEB
 for <alsa-devel@alsa-project.org>; Fri, 13 Oct 2017 01:49:58 +0200 (CEST)
In-Reply-To: <20171012234945.30318-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, andriy.shevchenko@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Before we add new fields for SOF support, move to C99 syntax
as done for atom/sst and legacy hsw/bdw code
No functional change

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/common/sst-acpi.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/common/sst-acpi.c b/sound/soc/intel/common/sst-acpi.c
index 9866998de8be..32d74ba70e4a 100644
--- a/sound/soc/intel/common/sst-acpi.c
+++ b/sound/soc/intel/common/sst-acpi.c
@@ -180,7 +180,11 @@ static int sst_acpi_remove(struct platform_device *pdev)
 }
 
 static struct snd_soc_acpi_mach haswell_machines[] = {
-	{ "INT33CA", "haswell-audio", "intel/IntcSST1.bin", NULL, NULL, NULL },
+	{
+		.id = "INT33CA",
+		.drv_name = "haswell-audio",
+		.fw_filename = "intel/IntcSST1.bin",
+	},
 	{}
 };
 
@@ -198,8 +202,16 @@ static struct sst_acpi_desc sst_acpi_haswell_desc = {
 };
 
 static struct snd_soc_acpi_mach broadwell_machines[] = {
-	{ "INT343A", "broadwell-audio", "intel/IntcSST2.bin", NULL, NULL, NULL },
-	{ "RT5677CE", "bdw-rt5677", "intel/IntcSST2.bin", NULL, NULL, NULL },
+	{
+		.id = "INT343A",
+		.drv_name = "broadwell-audio",
+		.fw_filename =  "intel/IntcSST2.bin",
+	},
+	{
+		.id = "RT5677CE",
+		.drv_name = "bdw-rt5677",
+		.fw_filename =  "intel/IntcSST2.bin",
+	},
 	{}
 };
 
@@ -218,8 +230,16 @@ static struct sst_acpi_desc sst_acpi_broadwell_desc = {
 
 #if !IS_ENABLED(CONFIG_SND_SST_IPC_ACPI)
 static struct snd_soc_acpi_mach baytrail_machines[] = {
-	{ "10EC5640", "byt-rt5640", "intel/fw_sst_0f28.bin-48kHz_i2s_master", NULL, NULL, NULL },
-	{ "193C9890", "byt-max98090", "intel/fw_sst_0f28.bin-48kHz_i2s_master", NULL, NULL, NULL },
+	{
+		.id = "10EC5640",
+		.drv_name = "byt-rt5640",
+		.fw_filename = "intel/fw_sst_0f28.bin-48kHz_i2s_master",
+	},
+	{
+		.id = "193C9890",
+		.drv_name = "byt-max98090",
+		.fw_filename = "intel/fw_sst_0f28.bin-48kHz_i2s_master",
+	},
 	{}
 };
 
-- 
2.11.0
