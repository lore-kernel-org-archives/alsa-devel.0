From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: common: use c99 syntax for
	ACPI/machine tables" to the asoc tree
Date: Sat, 21 Oct 2017 11:30:43 +0100 (BST)
Message-ID: <20171021103043.3858A440057@finisterre.ee.mobilebroadband>
References: <20170908205702.1985-3-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 42F94266DCF
 for <alsa-devel@alsa-project.org>; Sat, 21 Oct 2017 12:30:47 +0200 (CEST)
In-Reply-To: <20170908205702.1985-3-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, vinod.koul@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: common: use c99 syntax for ACPI/machine tables

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 928c8a8f1188dd59065e22bcedae57cb6156d836 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Thu, 12 Oct 2017 18:49:39 -0500
Subject: [PATCH] ASoC: Intel: common: use c99 syntax for ACPI/machine tables

Before we add new fields for SOF support, move to C99 syntax
as done for atom/sst and legacy hsw/bdw code
No functional change

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.14.1
