From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: boards: use devm_clk_get()
	unconditionally" to the asoc tree
Date: Tue, 19 Sep 2017 14:46:13 +0100
Message-ID: <E1duIqr-0008B3-0G@debutante>
References: <20170908174356.23788-2-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E797326737E
 for <alsa-devel@alsa-project.org>; Tue, 19 Sep 2017 15:46:15 +0200 (CEST)
In-Reply-To: <20170908174356.23788-2-pierre-louis.bossart@linux.intel.com>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, andriy.shevchenko@linux.intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: boards: use devm_clk_get() unconditionally

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

>From 7735bce05a9c0bb0eb0f08c9002d65843a7c5798 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 8 Sep 2017 12:43:52 -0500
Subject: [PATCH] ASoC: Intel: boards: use devm_clk_get() unconditionally

The clock framework was only used in Baytrail, on Cherrytrail
the firmware takes care of the MCLK/plt_clk_3.

With the fix in 'commit d31fd43c0f9a
("clk: x86: Do not gate clocks enabled by the firmware")'

the firmware-managed clocks are not impacted by enable/disable
requests make at the driver level, and the rates are identical.

Remove all checks for Baytrail and use devm_clk_get()
unconditionally. Tested on Asus T100HA (CHT) and Asus T100TAF (BYT)

Note that the RT5640 and RT5645 machine drivers need to keep some
checks for Valleyview to check for Baytrail-CR.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5640.c   |  2 +-
 sound/soc/intel/boards/cht_bsw_rt5645.c | 14 ++++++--------
 sound/soc/intel/boards/cht_bsw_rt5672.c | 27 ++++++---------------------
 3 files changed, 13 insertions(+), 30 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 4a76b099a508..15b1e292b0c3 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -891,7 +891,7 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 			byt_rt5640_cpu_dai_name;
 	}
 
-	if ((byt_rt5640_quirk & BYT_RT5640_MCLK_EN) && (is_valleyview())) {
+	if (byt_rt5640_quirk & BYT_RT5640_MCLK_EN) {
 		priv->mclk = devm_clk_get(&pdev->dev, "pmc_plt_clk_3");
 		if (IS_ERR(priv->mclk)) {
 			ret_val = PTR_ERR(priv->mclk);
diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
index 5bcde01d15e6..d553e2b67c92 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -682,14 +682,12 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 			cht_rt5645_cpu_dai_name;
 	}
 
-	if (is_valleyview()) {
-		drv->mclk = devm_clk_get(&pdev->dev, "pmc_plt_clk_3");
-		if (IS_ERR(drv->mclk)) {
-			dev_err(&pdev->dev,
-				"Failed to get MCLK from pmc_plt_clk_3: %ld\n",
-				PTR_ERR(drv->mclk));
-			return PTR_ERR(drv->mclk);
-		}
+	drv->mclk = devm_clk_get(&pdev->dev, "pmc_plt_clk_3");
+	if (IS_ERR(drv->mclk)) {
+		dev_err(&pdev->dev,
+			"Failed to get MCLK from pmc_plt_clk_3: %ld\n",
+			PTR_ERR(drv->mclk));
+		return PTR_ERR(drv->mclk);
 	}
 
 	snd_soc_card_set_drvdata(card, drv);
diff --git a/sound/soc/intel/boards/cht_bsw_rt5672.c b/sound/soc/intel/boards/cht_bsw_rt5672.c
index f597d5582223..a0e60bc1f84f 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5672.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5672.c
@@ -20,7 +20,6 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/clk.h>
-#include <asm/cpu_device_id.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
@@ -394,18 +393,6 @@ static struct snd_soc_card snd_soc_card_cht = {
 	.resume_post = cht_resume_post,
 };
 
-static bool is_valleyview(void)
-{
-	static const struct x86_cpu_id cpu_ids[] = {
-		{ X86_VENDOR_INTEL, 6, 55 }, /* Valleyview, Bay Trail */
-		{}
-	};
-
-	if (!x86_match_cpu(cpu_ids))
-		return false;
-	return true;
-}
-
 #define RT5672_I2C_DEFAULT	"i2c-10EC5670:00"
 
 static int snd_cht_mc_probe(struct platform_device *pdev)
@@ -439,14 +426,12 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 		}
 	}
 
-	if (is_valleyview()) {
-		drv->mclk = devm_clk_get(&pdev->dev, "pmc_plt_clk_3");
-		if (IS_ERR(drv->mclk)) {
-			dev_err(&pdev->dev,
-				"Failed to get MCLK from pmc_plt_clk_3: %ld\n",
-				PTR_ERR(drv->mclk));
-			return PTR_ERR(drv->mclk);
-		}
+	drv->mclk = devm_clk_get(&pdev->dev, "pmc_plt_clk_3");
+	if (IS_ERR(drv->mclk)) {
+		dev_err(&pdev->dev,
+			"Failed to get MCLK from pmc_plt_clk_3: %ld\n",
+			PTR_ERR(drv->mclk));
+		return PTR_ERR(drv->mclk);
 	}
 	snd_soc_card_set_drvdata(&snd_soc_card_cht, drv);
 
-- 
2.14.1
