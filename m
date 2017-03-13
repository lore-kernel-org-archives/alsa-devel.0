From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Atom: enable BYT/CHT+DA7213
	machine driver" to the asoc tree
Date: Mon, 13 Mar 2017 16:58:06 +0000
Message-ID: <E1cnTIM-00055z-JU@debutante>
References: <1489105142-25878-4-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DED2B266CF6
 for <alsa-devel@alsa-project.org>; Mon, 13 Mar 2017 17:58:17 +0100 (CET)
In-Reply-To: <1489105142-25878-4-git-send-email-pierre-louis.bossart@linux.intel.com>
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
Cc: vinod.koul@intel.com, tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, Adam.Thomson.Opensource@diasemi.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Atom: enable BYT/CHT+DA7213 machine driver

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

>From a63b8a117d39ba1b979daa71c6ab350a043694f5 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Thu, 9 Mar 2017 18:19:00 -0600
Subject: [PATCH] ASoC: Intel: Atom: enable BYT/CHT+DA7213 machine driver

Add entries in HID table and reference to bytcht_da7213 driver

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/atom/sst/sst_acpi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
index 747c0f393d2d..b24bf08606ae 100644
--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -480,6 +480,10 @@ static struct sst_acpi_mach sst_acpi_bytcr[] = {
 						&byt_rvp_platform_data },
 	{"10EC5651", "bytcr_rt5651", "intel/fw_sst_0f28.bin", "bytcr_rt5651", NULL,
 						&byt_rvp_platform_data },
+	{"DLGS7212", "bytcht_da7213", "intel/fw_sst_0f28.bin", "bytcht_da7213", NULL,
+						&byt_rvp_platform_data },
+	{"DLGS7213", "bytcht_da7213", "intel/fw_sst_0f28.bin", "bytcht_da7213", NULL,
+						&byt_rvp_platform_data },
 	/* some Baytrail platforms rely on RT5645, use CHT machine driver */
 	{"10EC5645", "cht-bsw-rt5645", "intel/fw_sst_0f28.bin", "cht-bsw", NULL,
 						&byt_rvp_platform_data },
@@ -504,6 +508,10 @@ static struct sst_acpi_mach sst_acpi_chv[] = {
 
 	{"193C9890", "cht-bsw-max98090", "intel/fw_sst_22a8.bin", "cht-bsw", NULL,
 						&chv_platform_data },
+	{"DLGS7212", "bytcht_da7213", "intel/fw_sst_22a8.bin", "bytcht_da7213", NULL,
+						&chv_platform_data },
+	{"DLGS7213", "bytcht_da7213", "intel/fw_sst_22a8.bin", "bytcht_da7213", NULL,
+						&chv_platform_data },
 	/* some CHT-T platforms rely on RT5640, use Baytrail machine driver */
 	{"10EC5640", "bytcr_rt5640", "intel/fw_sst_22a8.bin", "bytcr_rt5640", cht_quirk,
 						&chv_platform_data },
-- 
2.11.0
