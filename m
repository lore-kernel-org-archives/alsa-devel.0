From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Enable bytcht_nocodec machine
	driver" to the asoc tree
Date: Mon, 13 Mar 2017 16:57:59 +0000
Message-ID: <E1cnTIF-000543-Sn@debutante>
References: <1489105142-25878-6-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A57F5266D12
 for <alsa-devel@alsa-project.org>; Mon, 13 Mar 2017 17:58:16 +0100 (CET)
In-Reply-To: <1489105142-25878-6-git-send-email-pierre-louis.bossart@linux.intel.com>
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

   ASoC: Intel: Enable bytcht_nocodec machine driver

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

>From a9b6567d03196dc73ace1c34925c7496fb194447 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Thu, 9 Mar 2017 18:19:02 -0600
Subject: [PATCH] ASoC: Intel: Enable bytcht_nocodec machine driver

Make sure this machine driver is only used if enabled explicitly
and if there is no information found in the SSDT.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/atom/sst/sst_acpi.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
index b24bf08606ae..18fe46ef6ac7 100644
--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -489,7 +489,14 @@ static struct sst_acpi_mach sst_acpi_bytcr[] = {
 						&byt_rvp_platform_data },
 	{"10EC5648", "cht-bsw-rt5645", "intel/fw_sst_0f28.bin", "cht-bsw", NULL,
 						&byt_rvp_platform_data },
-
+#if IS_ENABLED(CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH)
+	/*
+	 * This is always last in the table so that it is selected only when
+	 * enabled explicitly and there is no codec-related information in SSDT
+	 */
+	{"80860F28", "bytcht_nocodec", "intel/fw_sst_0f28.bin", "bytcht_nocodec", NULL,
+						&byt_rvp_platform_data },
+#endif
 	{},
 };
 
@@ -520,6 +527,14 @@ static struct sst_acpi_mach sst_acpi_chv[] = {
 	/* some CHT-T platforms rely on RT5651, use Baytrail machine driver */
 	{"10EC5651", "bytcr_rt5651", "intel/fw_sst_22a8.bin", "bytcr_rt5651", NULL,
 						&chv_platform_data },
+#if IS_ENABLED(CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH)
+	/*
+	 * This is always last in the table so that it is selected only when
+	 * enabled explicitly and there is no codec-related information in SSDT
+	 */
+	{"808622A8", "bytcht_nocodec", "intel/fw_sst_22a8.bin", "bytcht_nocodec", NULL,
+						&chv_platform_data },
+#endif
 	{},
 };
 
-- 
2.11.0
