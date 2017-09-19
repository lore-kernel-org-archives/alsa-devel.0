From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: atom: use cht_bsw_max98090 for
	Baytrail Chromebooks" to the asoc tree
Date: Tue, 19 Sep 2017 14:45:31 +0100
Message-ID: <E1duIqB-00082Q-Cd@debutante>
References: <20170822203239.19891-7-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id AE12A2671D2
 for <alsa-devel@alsa-project.org>; Tue, 19 Sep 2017 15:45:33 +0200 (CEST)
In-Reply-To: <20170822203239.19891-7-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: atom: use cht_bsw_max98090 for Baytrail Chromebooks

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

>From c809fb1e84d5f3f55c3b84710ae06bc3d5943d18 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 8 Sep 2017 00:13:06 -0500
Subject: [PATCH] ASoC: Intel: atom: use cht_bsw_max98090 for Baytrail
 Chromebooks

Baytrail Chromebooks used to be managed with legacy driver which
is not compatible with atom/sst drivers. Reuse CHT driver to
handle max98098 codec and allow distributions to support all
Atom platforms with the same build.

The legacy byt-max98090 can still be used but in a build for
Baytrail+max98090 only.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/atom/sst/sst_acpi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
index 0e928d54305d..ff4a5175a6cd 100644
--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -536,6 +536,14 @@ static struct sst_acpi_mach sst_acpi_bytcr[] = {
 		.board = "cht-bsw",
 		.pdata = &byt_rvp_platform_data
 	},
+	/* use CHT driver to Baytrail Chromebooks */
+	{
+		.id = "193C9890",
+		.drv_name = "cht-bsw-max98090",
+		.fw_filename = "intel/fw_sst_0f28.bin",
+		.board = "cht-bsw",
+		.pdata = &byt_rvp_platform_data
+	},
 #if IS_ENABLED(CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH)
 	/*
 	 * This is always last in the table so that it is selected only when
-- 
2.14.1
