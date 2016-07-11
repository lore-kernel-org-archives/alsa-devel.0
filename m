From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: board: add kabylake machine id"
	to the asoc tree
Date: Mon, 11 Jul 2016 22:21:02 +0100
Message-ID: <E1bMidS-0003sP-PQ@debutante>
References: <1468254731-15394-5-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B66CE26524F
 for <alsa-devel@alsa-project.org>; Mon, 11 Jul 2016 23:21:12 +0200 (CEST)
In-Reply-To: <1468254731-15394-5-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, Shreyas NC <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: board: add kabylake machine id

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

>From 894a16db293c5383f1d9c819909a27bd6738efde Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Mon, 11 Jul 2016 22:02:11 +0530
Subject: [PATCH] ASoC: Intel: board: add kabylake machine id

Kabylake platform is similar to Skylake. So, add machine id.
Since same machine driver supports both, add these in id table.

Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/skl_rt286.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/intel/boards/skl_rt286.c b/sound/soc/intel/boards/skl_rt286.c
index 426b48233fdb..88c61e8cb87f 100644
--- a/sound/soc/intel/boards/skl_rt286.c
+++ b/sound/soc/intel/boards/skl_rt286.c
@@ -505,12 +505,20 @@ static int skylake_audio_probe(struct platform_device *pdev)
 	return devm_snd_soc_register_card(&pdev->dev, &skylake_rt286);
 }
 
+static const struct platform_device_id skl_board_ids[] = {
+	{ .name = "skl_alc286s_i2s" },
+	{ .name = "kbl_alc286s_i2s" },
+	{ }
+};
+
 static struct platform_driver skylake_audio = {
 	.probe = skylake_audio_probe,
 	.driver = {
 		.name = "skl_alc286s_i2s",
 		.pm = &snd_soc_pm_ops,
 	},
+	.id_table = skl_board_ids,
+
 };
 
 module_platform_driver(skylake_audio)
@@ -520,3 +528,4 @@ MODULE_AUTHOR("Omair Mohammed Abdullah <omair.m.abdullah@intel.com>");
 MODULE_DESCRIPTION("Intel SST Audio for Skylake");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:skl_alc286s_i2s");
+MODULE_ALIAS("platform:kbl_alc286s_i2s");
-- 
2.8.1
