From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: board: add kabylake
	nau88l25_max98357a machine id" to the asoc tree
Date: Thu, 14 Jul 2016 17:32:16 +0100
Message-ID: <E1bNjYe-0001Vb-10@debutante>
References: <1468428227-8239-5-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 77DBE2658D4
 for <alsa-devel@alsa-project.org>; Thu, 14 Jul 2016 18:32:21 +0200 (CEST)
In-Reply-To: <1468428227-8239-5-git-send-email-vinod.koul@intel.com>
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

   ASoC: Intel: board: add kabylake nau88l25_max98357a machine id

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

>From 2ca972da5ac8ac03dce005f4b71d9198a408b068 Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Wed, 13 Jul 2016 22:13:46 +0530
Subject: [PATCH] ASoC: Intel: board: add kabylake nau88l25_max98357a machine
 id

Like SKL we have skl_nau88l25_max98357a machine for KBL,
so add the ID for this machine too.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/skl_nau88l25_max98357a.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/intel/boards/skl_nau88l25_max98357a.c b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
index 80efe5e32291..25db5be7fdfa 100644
--- a/sound/soc/intel/boards/skl_nau88l25_max98357a.c
+++ b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
@@ -656,12 +656,19 @@ static int skylake_audio_probe(struct platform_device *pdev)
 	return devm_snd_soc_register_card(&pdev->dev, &skylake_audio_card);
 }
 
+static const struct platform_device_id skl_board_ids[] = {
+	{ .name = "skl_n88l25_m98357a" },
+	{ .name = "kbl_n88l25_m98357a" },
+	{ }
+};
+
 static struct platform_driver skylake_audio = {
 	.probe = skylake_audio_probe,
 	.driver = {
 		.name = "skl_n88l25_m98357a",
 		.pm = &snd_soc_pm_ops,
 	},
+	.id_table = skl_board_ids,
 };
 
 module_platform_driver(skylake_audio)
@@ -671,3 +678,4 @@ MODULE_DESCRIPTION("Audio Machine driver-NAU88L25 & MAX98357A in I2S mode");
 MODULE_AUTHOR("Rohit Ainapure <rohit.m.ainapure@intel.com");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:skl_n88l25_m98357a");
+MODULE_ALIAS("platform:kbl_n88l25_m98357a");
-- 
2.8.1
