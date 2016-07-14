From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: reduce machine name for
	skl_nau88l25_ssm4567" to the asoc tree
Date: Thu, 14 Jul 2016 17:32:24 +0100
Message-ID: <E1bNjYm-0001Yh-Nu@debutante>
References: <1468428227-8239-2-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 49D5E2666FE
 for <alsa-devel@alsa-project.org>; Thu, 14 Jul 2016 18:32:29 +0200 (CEST)
In-Reply-To: <1468428227-8239-2-git-send-email-vinod.koul@intel.com>
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

   ASoC: Intel: Skylake: reduce machine name for skl_nau88l25_ssm4567

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

>From 400ada0c766b86b60313a68a3ad419558f1cbc5b Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Wed, 13 Jul 2016 22:13:43 +0530
Subject: [PATCH] ASoC: Intel: Skylake: reduce machine name for
 skl_nau88l25_ssm4567

The platform device id table expects names to be less that
20chars, so truncate the name in skl id table and
skl_nau88l25_ssm4567 machine.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c | 4 ++--
 sound/soc/intel/skylake/skl.c                 | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
index 22f2e9d84e72..3e67d7b31e28 100644
--- a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
+++ b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
@@ -711,7 +711,7 @@ static int skylake_audio_probe(struct platform_device *pdev)
 static struct platform_driver skylake_audio = {
 	.probe = skylake_audio_probe,
 	.driver = {
-		.name = "skl_nau88l25_ssm4567_i2s",
+		.name = "skl_n88l25_s4567",
 		.pm = &snd_soc_pm_ops,
 	},
 };
@@ -726,4 +726,4 @@ MODULE_AUTHOR("Sathya Prakash M R <sathya.prakash.m.r@intel.com>");
 MODULE_AUTHOR("Yong Zhi <yong.zhi@intel.com>");
 MODULE_DESCRIPTION("Intel Audio Machine driver for SKL with NAU88L25 and SSM4567 in I2S Mode");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:skl_nau88l25_ssm4567_i2s");
+MODULE_ALIAS("platform:skl_n88l25_s4567");
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 4e30effc5469..0c46ee5f31db 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -801,7 +801,7 @@ static void skl_remove(struct pci_dev *pci)
 
 static struct sst_acpi_mach sst_skl_devdata[] = {
 	{ "INT343A", "skl_alc286s_i2s", "intel/dsp_fw_release.bin", NULL, NULL, NULL },
-	{ "INT343B", "skl_nau88l25_ssm4567_i2s", "intel/dsp_fw_release.bin",
+	{ "INT343B", "skl_n88l25_s4567", "intel/dsp_fw_release.bin",
 				NULL, NULL, &skl_dmic_data },
 	{ "MX98357A", "skl_nau88l25_max98357a_i2s", "intel/dsp_fw_release.bin",
 				NULL, NULL, &skl_dmic_data },
-- 
2.8.1
