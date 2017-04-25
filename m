From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: bytcr_rt5640: Fix a typo and quirk
	parameter type" to the asoc tree
Date: Tue, 25 Apr 2017 16:45:46 +0100
Message-ID: <E1d32ew-0001iN-7g@debutante>
References: <20170424213430.24835-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F0597266F9D
 for <alsa-devel@alsa-project.org>; Tue, 25 Apr 2017 17:46:04 +0200 (CEST)
In-Reply-To: <20170424213430.24835-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: bytcr_rt5640: Fix a typo and quirk parameter type

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

>From 0b2c9f88b94cd40f6a27641f0bac02a7ba185e39 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Mon, 24 Apr 2017 23:34:30 +0200
Subject: [PATCH] ASoC: bytcr_rt5640: Fix a typo and quirk parameter type

The previous patch for adding the quirk module option had a typo in
its info print, which results in a weird output.  Also, the parameter
type should be rather unsigned int instead of signed int.

Fixes: 9f2cf73ed65b ("ASoC: bytcr_rt5640: Allow quirk set via module option")
Reported-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 0ac32788f216..5ca09cadf39f 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -60,7 +60,7 @@ struct byt_rt5640_private {
 
 static unsigned long byt_rt5640_quirk = BYT_RT5640_MCLK_EN;
 static unsigned int quirk_override;
-module_param_named(quirk, quirk_override, int, 0444);
+module_param_named(quirk, quirk_override, uint, 0444);
 MODULE_PARM_DESC(quirk, "Board-specific quirk override");
 
 static void log_quirks(struct device *dev)
@@ -811,7 +811,7 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 	/* check quirks before creating card */
 	dmi_check_system(byt_rt5640_quirk_table);
 	if (quirk_override) {
-		dev_info(&pdev->dev, "Overriding quirk %0x => 0x%x\n",
+		dev_info(&pdev->dev, "Overriding quirk 0x%x => 0x%x\n",
 			 (unsigned int)byt_rt5640_quirk, quirk_override);
 		byt_rt5640_quirk = quirk_override;
 	}
-- 
2.11.0
