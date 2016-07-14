From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: reduce machine name for
	skl_nau88l25_max98357a" to the asoc tree
Date: Thu, 14 Jul 2016 17:32:21 +0100
Message-ID: <E1bNjYj-0001Xn-QA@debutante>
References: <1468428227-8239-3-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9816E2658D4
 for <alsa-devel@alsa-project.org>; Thu, 14 Jul 2016 18:32:32 +0200 (CEST)
In-Reply-To: <1468428227-8239-3-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: reduce machine name for skl_nau88l25_max98357a

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

>From a2f5b8db2e983e44cb0cd7e8e95135fc7c9b1394 Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Wed, 13 Jul 2016 22:13:44 +0530
Subject: [PATCH] ASoC: Intel: Skylake: reduce machine name for
 skl_nau88l25_max98357a

The platform device id table expects names to be less that
20chars, so truncate the name in skl id table and
skl_nau88l25_max98357a machine.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/skl_nau88l25_max98357a.c | 4 ++--
 sound/soc/intel/skylake/skl.c                   | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/skl_nau88l25_max98357a.c b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
index afc6f744dff1..80efe5e32291 100644
--- a/sound/soc/intel/boards/skl_nau88l25_max98357a.c
+++ b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
@@ -659,7 +659,7 @@ static int skylake_audio_probe(struct platform_device *pdev)
 static struct platform_driver skylake_audio = {
 	.probe = skylake_audio_probe,
 	.driver = {
-		.name = "skl_nau88l25_max98357a_i2s",
+		.name = "skl_n88l25_m98357a",
 		.pm = &snd_soc_pm_ops,
 	},
 };
@@ -670,4 +670,4 @@ module_platform_driver(skylake_audio)
 MODULE_DESCRIPTION("Audio Machine driver-NAU88L25 & MAX98357A in I2S mode");
 MODULE_AUTHOR("Rohit Ainapure <rohit.m.ainapure@intel.com");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:skl_nau88l25_max98357a_i2s");
+MODULE_ALIAS("platform:skl_n88l25_m98357a");
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 0c46ee5f31db..9f6733d72bde 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -803,7 +803,7 @@ static struct sst_acpi_mach sst_skl_devdata[] = {
 	{ "INT343A", "skl_alc286s_i2s", "intel/dsp_fw_release.bin", NULL, NULL, NULL },
 	{ "INT343B", "skl_n88l25_s4567", "intel/dsp_fw_release.bin",
 				NULL, NULL, &skl_dmic_data },
-	{ "MX98357A", "skl_nau88l25_max98357a_i2s", "intel/dsp_fw_release.bin",
+	{ "MX98357A", "skl_n88l25_m98357a", "intel/dsp_fw_release.bin",
 				NULL, NULL, &skl_dmic_data },
 	{}
 };
-- 
2.8.1
