From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: board: add kabylake
	nau88l25_ssm4567 machine id" to the asoc tree
Date: Thu, 14 Jul 2016 17:32:13 +0100
Message-ID: <E1bNjYb-0001UZ-3n@debutante>
References: <1468428227-8239-6-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C628B265873
 for <alsa-devel@alsa-project.org>; Thu, 14 Jul 2016 18:32:18 +0200 (CEST)
In-Reply-To: <1468428227-8239-6-git-send-email-vinod.koul@intel.com>
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

   ASoC: Intel: board: add kabylake nau88l25_ssm4567 machine id

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

>From 9dc201cf75e04fd2d753a1d01ed9d03f4253e32f Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Wed, 13 Jul 2016 22:13:47 +0530
Subject: [PATCH] ASoC: Intel: board: add kabylake nau88l25_ssm4567 machine id

Like SKL we have skl_nau88l25_ssm4567 machine for KBL,
so add the ID for this machine too.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
index 3e67d7b31e28..69c5d5da4e86 100644
--- a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
+++ b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
@@ -708,12 +708,19 @@ static int skylake_audio_probe(struct platform_device *pdev)
 	return devm_snd_soc_register_card(&pdev->dev, &skylake_audio_card);
 }
 
+static const struct platform_device_id skl_board_ids[] = {
+	{ .name = "skl_n88l25_s4567" },
+	{ .name = "kbl_n88l25_s4567" },
+	{ }
+};
+
 static struct platform_driver skylake_audio = {
 	.probe = skylake_audio_probe,
 	.driver = {
 		.name = "skl_n88l25_s4567",
 		.pm = &snd_soc_pm_ops,
 	},
+	.id_table = skl_board_ids,
 };
 
 module_platform_driver(skylake_audio)
@@ -727,3 +734,4 @@ MODULE_AUTHOR("Yong Zhi <yong.zhi@intel.com>");
 MODULE_DESCRIPTION("Intel Audio Machine driver for SKL with NAU88L25 and SSM4567 in I2S Mode");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:skl_n88l25_s4567");
+MODULE_ALIAS("platform:kbl_n88l25_s4567");
-- 
2.8.1
