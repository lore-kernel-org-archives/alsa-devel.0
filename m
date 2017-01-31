From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: qcom: lpass-cpu: Remove unnecessary
	clock checks" to the asoc tree
Date: Tue, 31 Jan 2017 21:17:21 +0000
Message-ID: <E1cYfnl-0000pu-1R@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id ABFBF2673DC
 for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2017 22:17:28 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: qcom: lpass-cpu: Remove unnecessary clock checks

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

>From 46dccc3573bc69e13fb5ea3d14dea2e940b3a1a9 Mon Sep 17 00:00:00 2001
From: Bjorn Andersson <bjorn.andersson@linaro.org>
Date: Mon, 30 Jan 2017 13:03:36 -0800
Subject: [PATCH] ASoC: qcom: lpass-cpu: Remove unnecessary clock checks

Clean up the clock calling code by removing numerous IS_ERR() checks by
just assigning the clock NULL; as this turn all used functions in the
clk API to nops.

Also include the word "optional" in the error message when failing to acquire
the optional osr clocks.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/lpass-cpu.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
index eff3f9a8b685..1b912a9bb791 100644
--- a/sound/soc/qcom/lpass-cpu.c
+++ b/sound/soc/qcom/lpass-cpu.c
@@ -33,9 +33,6 @@ static int lpass_cpu_daiops_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 	struct lpass_data *drvdata = snd_soc_dai_get_drvdata(dai);
 	int ret;
 
-	if (IS_ERR(drvdata->mi2s_osr_clk[dai->driver->id]))
-		return 0;
-
 	ret = clk_set_rate(drvdata->mi2s_osr_clk[dai->driver->id], freq);
 	if (ret)
 		dev_err(dai->dev, "%s() error setting mi2s osrclk to %u: %d\n",
@@ -50,23 +47,18 @@ static int lpass_cpu_daiops_startup(struct snd_pcm_substream *substream,
 	struct lpass_data *drvdata = snd_soc_dai_get_drvdata(dai);
 	int ret;
 
-	if (!IS_ERR(drvdata->mi2s_osr_clk[dai->driver->id])) {
-		ret = clk_prepare_enable(
-				drvdata->mi2s_osr_clk[dai->driver->id]);
-		if (ret) {
-			dev_err(dai->dev, "%s() error in enabling mi2s osr clk: %d\n",
-					__func__, ret);
-			return ret;
-		}
+	ret = clk_prepare_enable(drvdata->mi2s_osr_clk[dai->driver->id]);
+	if (ret) {
+		dev_err(dai->dev, "%s() error in enabling mi2s osr clk: %d\n",
+				__func__, ret);
+		return ret;
 	}
 
 	ret = clk_prepare_enable(drvdata->mi2s_bit_clk[dai->driver->id]);
 	if (ret) {
 		dev_err(dai->dev, "%s() error in enabling mi2s bit clk: %d\n",
 				__func__, ret);
-		if (!IS_ERR(drvdata->mi2s_osr_clk[dai->driver->id]))
-			clk_disable_unprepare(
-				drvdata->mi2s_osr_clk[dai->driver->id]);
+		clk_disable_unprepare(drvdata->mi2s_osr_clk[dai->driver->id]);
 		return ret;
 	}
 
@@ -80,8 +72,7 @@ static void lpass_cpu_daiops_shutdown(struct snd_pcm_substream *substream,
 
 	clk_disable_unprepare(drvdata->mi2s_bit_clk[dai->driver->id]);
 
-	if (!IS_ERR(drvdata->mi2s_osr_clk[dai->driver->id]))
-		clk_disable_unprepare(drvdata->mi2s_osr_clk[dai->driver->id]);
+	clk_disable_unprepare(drvdata->mi2s_osr_clk[dai->driver->id]);
 }
 
 static int lpass_cpu_daiops_hw_params(struct snd_pcm_substream *substream,
@@ -505,9 +496,11 @@ int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev)
 								clk_name);
 		if (IS_ERR(drvdata->mi2s_osr_clk[dai_id])) {
 			dev_warn(&pdev->dev,
-				"%s() error getting mi2s-osr-clk: %ld\n",
+				"%s() error getting optional mi2s-osr-clk: %ld\n",
 				__func__,
 				PTR_ERR(drvdata->mi2s_osr_clk[dai_id]));
+
+			drvdata->mi2s_osr_clk[dai_id] = NULL;
 		}
 
 		if (variant->num_dai > 1)
-- 
2.11.0
