From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: bytcr_rt5640: Allow quirk set via
	module option" to the asoc tree
Date: Mon, 24 Apr 2017 19:20:48 +0100
Message-ID: <E1d2ibQ-0000hK-Uq@debutante>
References: <20170423072256.26750-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AD1442674C0
 for <alsa-devel@alsa-project.org>; Mon, 24 Apr 2017 20:20:58 +0200 (CEST)
In-Reply-To: <20170423072256.26750-1-tiwai@suse.de>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: bytcr_rt5640: Allow quirk set via module option

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

>From 9f2cf73ed65b598514e4858ca3d602710718ab93 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Sun, 23 Apr 2017 09:22:56 +0200
Subject: [PATCH] ASoC: bytcr_rt5640: Allow quirk set via module option

The bytcr-rt5640 driver has a few quirk setups depending on the board,
where the quirk value is set by DMI matching.  When you have a new
device to add the support, you often experience to try the different
quirk by trial-and-error.  Or, you may have a development model that
still has no proper DMI string.  In either case, you'd need to compile
the driver at each time.

This patch introduces a module option to override the quirk value on
the fly.  User can boot like snd-soc-sst-bytcr-rt5640.quirk=0x4004 to
override the default value without recompilation.  It's a raw value,
so user needs to check the source code for the meaning of each bit.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 5c7219fb3aa8..0ac32788f216 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -19,6 +19,7 @@
 
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/platform_device.h>
 #include <linux/acpi.h>
 #include <linux/device.h>
@@ -58,6 +59,9 @@ struct byt_rt5640_private {
 };
 
 static unsigned long byt_rt5640_quirk = BYT_RT5640_MCLK_EN;
+static unsigned int quirk_override;
+module_param_named(quirk, quirk_override, int, 0444);
+MODULE_PARM_DESC(quirk, "Board-specific quirk override");
 
 static void log_quirks(struct device *dev)
 {
@@ -806,6 +810,11 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 
 	/* check quirks before creating card */
 	dmi_check_system(byt_rt5640_quirk_table);
+	if (quirk_override) {
+		dev_info(&pdev->dev, "Overriding quirk %0x => 0x%x\n",
+			 (unsigned int)byt_rt5640_quirk, quirk_override);
+		byt_rt5640_quirk = quirk_override;
+	}
 	log_quirks(&pdev->dev);
 
 	if ((byt_rt5640_quirk & BYT_RT5640_SSP2_AIF2) ||
-- 
2.11.0
