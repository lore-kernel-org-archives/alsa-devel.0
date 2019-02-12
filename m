From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: soc-acpi: hsw-bdw-match: remove
	asoc_plat_name field" to the asoc tree
Date: Tue, 12 Feb 2019 16:58:21 +0000 (GMT)
Message-ID: <20190212165821.677BC1128113@debutante.sirena.org.uk>
References: <20190208234557.7816-14-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B06D267849
 for <alsa-devel@alsa-project.org>; Tue, 12 Feb 2019 17:58:22 +0100 (CET)
In-Reply-To: <20190208234557.7816-14-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, vkoul@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: soc-acpi: hsw-bdw-match: remove asoc_plat_name field

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 2eddca128be282f600347ea07ef0b516dbc4e7ce Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 8 Feb 2019 17:45:53 -0600
Subject: [PATCH] ASoC: Intel: soc-acpi: hsw-bdw-match: remove asoc_plat_name
 field

This field was never used, let's remove it

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/common/soc-acpi-intel-hsw-bdw-match.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/intel/common/soc-acpi-intel-hsw-bdw-match.c b/sound/soc/intel/common/soc-acpi-intel-hsw-bdw-match.c
index ddfe4250c2bc..690b305a255b 100644
--- a/sound/soc/intel/common/soc-acpi-intel-hsw-bdw-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-hsw-bdw-match.c
@@ -25,7 +25,6 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_haswell_machines[] = {
 		.fw_filename = "intel/IntcSST1.bin",
 		.sof_fw_filename = "sof-hsw.ri",
 		.sof_tplg_filename = "sof-hsw.tplg",
-		.asoc_plat_name = "haswell-pcm-audio",
 	},
 	{}
 };
@@ -38,7 +37,6 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_broadwell_machines[] = {
 		.fw_filename =  "intel/IntcSST2.bin",
 		.sof_fw_filename = "sof-bdw.ri",
 		.sof_tplg_filename = "sof-bdw-rt286.tplg",
-		.asoc_plat_name = "haswell-pcm-audio",
 	},
 	{
 		.id = "RT5677CE",
@@ -46,7 +44,6 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_broadwell_machines[] = {
 		.fw_filename =  "intel/IntcSST2.bin",
 		.sof_fw_filename = "sof-bdw.ri",
 		.sof_tplg_filename = "sof-bdw-rt5677.tplg",
-		.asoc_plat_name = "haswell-pcm-audio",
 	},
 	{
 		.id = "INT33CA",
@@ -54,7 +51,6 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_broadwell_machines[] = {
 		.fw_filename = "intel/IntcSST2.bin",
 		.sof_fw_filename = "sof-bdw.ri",
 		.sof_tplg_filename = "sof-bdw-rt5640.tplg",
-		.asoc_plat_name = "haswell-pcm-audio",
 	},
 	{}
 };
-- 
2.20.1
