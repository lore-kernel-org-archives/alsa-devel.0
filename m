From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 01/14] ASoC: Intel: boards: use devm_clk_get()
	unconditionally
Date: Tue, 22 Aug 2017 15:32:26 -0500
Message-ID: <20170822203239.19891-2-pierre-louis.bossart@linux.intel.com>
References: <20170822203239.19891-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D1E9267035
 for <alsa-devel@alsa-project.org>; Tue, 22 Aug 2017 22:33:09 +0200 (CEST)
In-Reply-To: <20170822203239.19891-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The clock framework was only used in Baytrail, on Cherrytrail
the firmware takes care of the MCLK/plt_clk_3.

With the fix in 'commit d31fd43c0f9a
("clk: x86: Do not gate clocks enabled by the firmware")'

the firmware-managed clocks are not impacted by enable/disable
requests make at the driver level, and the rates are identical.

Remove all checks for Baytrail and use devm_clk_get()
unconditionally. Tested on Asus T100HA (CHT) and Asus T100TAF (BYT)

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/bytcr_rt5640.c   |  2 +-
 sound/soc/intel/boards/cht_bsw_rt5645.c | 14 ++++++--------
 sound/soc/intel/boards/cht_bsw_rt5672.c | 26 ++++++--------------------
 3 files changed, 13 insertions(+), 29 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 4a76b09..15b1e29 100644
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
index 5bcde01..d553e2b 100644
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
index f597d55..ad2f27e 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5672.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5672.c
@@ -394,18 +394,6 @@ static struct snd_soc_card snd_soc_card_cht = {
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
@@ -439,14 +427,12 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
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
2.9.3
