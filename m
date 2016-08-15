From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bytcr_rt5640: log quirks" to the
	asoc tree
Date: Mon, 15 Aug 2016 15:15:33 +0100
Message-ID: <E1bZIft-0007Fp-9k@debutante>
References: <1471037280-17433-18-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D55F6267858
 for <alsa-devel@alsa-project.org>; Mon, 15 Aug 2016 16:15:39 +0200 (CEST)
In-Reply-To: <1471037280-17433-18-git-send-email-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, irina.tirdea@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: bytcr_rt5640: log quirks

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

>From d7e60d52ac8cbc6eb9baa2c8d1e6d0478b8dadd4 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 12 Aug 2016 16:28:00 -0500
Subject: [PATCH] ASoC: Intel: bytcr_rt5640: log quirks

use dev_info to provide better support for autodetection
and DMI-based quirks, no functional changes

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 032abfee89e6..09ec3d718357 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -61,6 +61,35 @@ static unsigned long byt_rt5640_quirk = BYT_RT5640_DMIC1_MAP |
 					BYT_RT5640_DMIC_EN |
 					BYT_RT5640_MCLK_EN;
 
+static void log_quirks(struct device *dev)
+{
+	if (BYT_RT5640_MAP(byt_rt5640_quirk) == BYT_RT5640_DMIC1_MAP)
+		dev_info(dev, "quirk DMIC1_MAP enabled");
+	if (BYT_RT5640_MAP(byt_rt5640_quirk) == BYT_RT5640_DMIC2_MAP)
+		dev_info(dev, "quirk DMIC2_MAP enabled");
+	if (BYT_RT5640_MAP(byt_rt5640_quirk) == BYT_RT5640_IN1_MAP)
+		dev_info(dev, "quirk IN1_MAP enabled");
+	if (BYT_RT5640_MAP(byt_rt5640_quirk) == BYT_RT5640_IN3_MAP)
+		dev_info(dev, "quirk IN3_MAP enabled");
+	if (byt_rt5640_quirk & BYT_RT5640_DMIC_EN)
+		dev_info(dev, "quirk DMIC enabled");
+	if (byt_rt5640_quirk & BYT_RT5640_MONO_SPEAKER)
+		dev_info(dev, "quirk MONO_SPEAKER enabled");
+	if (byt_rt5640_quirk & BYT_RT5640_DIFF_MIC)
+		dev_info(dev, "quirk DIFF_MIC enabled");
+	if (byt_rt5640_quirk & BYT_RT5640_SSP2_AIF2)
+		dev_info(dev, "quirk SSP2_AIF2 enabled");
+	if (byt_rt5640_quirk & BYT_RT5640_SSP0_AIF1)
+		dev_info(dev, "quirk SSP0_AIF1 enabled");
+	if (byt_rt5640_quirk & BYT_RT5640_SSP0_AIF2)
+		dev_info(dev, "quirk SSP0_AIF2 enabled");
+	if (byt_rt5640_quirk & BYT_RT5640_MCLK_EN)
+		dev_info(dev, "quirk MCLK_EN enabled");
+	if (byt_rt5640_quirk & BYT_RT5640_MCLK_25MHZ)
+		dev_info(dev, "quirk MCLK_25MHZ enabled");
+}
+
+
 #define BYT_CODEC_DAI1	"rt5640-aif1"
 #define BYT_CODEC_DAI2	"rt5640-aif2"
 
@@ -702,6 +731,7 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 
 	/* check quirks before creating card */
 	dmi_check_system(byt_rt5640_quirk_table);
+	log_quirks(&pdev->dev);
 
 	if ((byt_rt5640_quirk & BYT_RT5640_SSP2_AIF2) ||
 	    (byt_rt5640_quirk & BYT_RT5640_SSP0_AIF2)) {
-- 
2.8.1
