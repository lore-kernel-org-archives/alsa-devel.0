From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: boards: remove .pm_ops in all
	Atom/DPCM machine drivers" to the asoc tree
Date: Tue, 31 Jan 2017 20:02:20 +0000
Message-ID: <E1cYedA-0005Y2-Fd@debutante>
References: <1485461385-14544-3-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B8E45267395
 for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2017 21:02:30 +0100 (CET)
In-Reply-To: <1485461385-14544-3-git-send-email-pierre-louis.bossart@linux.intel.com>
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
Cc: Shrirang Bagul <shrirang.bagul@canonical.com>, tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: boards: remove .pm_ops in all Atom/DPCM machine drivers

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

>From 3639ac1cd5177685a5c8abb7230096b680e1d497 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Thu, 26 Jan 2017 14:09:30 -0600
Subject: [PATCH] ASoC: Intel: boards: remove .pm_ops in all Atom/DPCM machine
 drivers

This patch corrects an omission in bytcr_rt5640 and bytcr_rt5651.
All existing machine drivers shall not use .pm_ops to avoid a double
suspend, as initially implemented by 3f2dcbeaeb2b
("ASoC: Intel: Remove soc pm handling to allow platform driver handle it").

Reported-by: Shrirang Bagul <shrirang.bagul@canonical.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 1 -
 sound/soc/intel/boards/bytcr_rt5651.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 507a86a5eafe..9222fdb7af27 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -846,7 +846,6 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 static struct platform_driver snd_byt_rt5640_mc_driver = {
 	.driver = {
 		.name = "bytcr_rt5640",
-		.pm = &snd_soc_pm_ops,
 	},
 	.probe = snd_byt_rt5640_mc_probe,
 };
diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 2d24dc04b597..71d801323ff4 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -319,7 +319,6 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 static struct platform_driver snd_byt_rt5651_mc_driver = {
 	.driver = {
 		.name = "bytcr_rt5651",
-		.pm = &snd_soc_pm_ops,
 	},
 	.probe = snd_byt_rt5651_mc_probe,
 };
-- 
2.11.0
