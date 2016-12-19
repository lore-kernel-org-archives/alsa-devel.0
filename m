From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bytcr_rt5640: fallback mechanism
	if MCLK is not enabled" to the asoc tree
Date: Mon, 19 Dec 2016 13:31:13 +0000
Message-ID: <E1cIy25-00052T-H5@debutante>
References: <1481907349-16529-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 04FD2265A82
 for <alsa-devel@alsa-project.org>; Mon, 19 Dec 2016 14:31:21 +0100 (CET)
In-Reply-To: <1481907349-16529-1-git-send-email-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: bytcr_rt5640: fallback mechanism if MCLK is not enabled

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

>From 4a8b3a682be9addff7dbd16371fa8c34103b5c31 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 16 Dec 2016 10:55:49 -0600
Subject: [PATCH] ASoC: Intel: bytcr_rt5640: fallback mechanism if MCLK is not
 enabled

Commit df1a2776a795 ("ASoC: Intel: bytcr_rt5640: add MCLK support")
was merged but the corresponding clock framework patches have not,
after being bumped from audio to clock to x86 domains. The missing
clock-related patches result in a regression starting with 4.9 with
the audio card not being created.

Rather than reverting this commit and all following updates already
queued up for 4.10, handle run-time dependency on MCLK and fall back
to the previous bit-clock mode. This provides the same functionality
as in 4.8 for Baytrail devices. On Baytrail-CR most devices remain
silent with this fallback but additional patches are needed anyway.
As suggested by Mark Brown, the fallback is only allowed with -ENOENT,
all other run-time errors, including -EPROBE_DEFER, will stop the probe
with no sound card registered.

This patch should be applied to -stable as well as ASoC 4.10 fixes

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 507a86a5eafe..e33e4777a65c 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -825,10 +825,20 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 	if ((byt_rt5640_quirk & BYT_RT5640_MCLK_EN) && (is_valleyview())) {
 		priv->mclk = devm_clk_get(&pdev->dev, "pmc_plt_clk_3");
 		if (IS_ERR(priv->mclk)) {
+			ret_val = PTR_ERR(priv->mclk);
+
 			dev_err(&pdev->dev,
-				"Failed to get MCLK from pmc_plt_clk_3: %ld\n",
-				PTR_ERR(priv->mclk));
-			return PTR_ERR(priv->mclk);
+				"Failed to get MCLK from pmc_plt_clk_3: %d\n",
+				ret_val);
+
+			/*
+			 * Fall back to bit clock usage for -ENOENT (clock not
+			 * available likely due to missing dependencies), bail
+			 * for all other errors, including -EPROBE_DEFER
+			 */
+			if (ret_val != -ENOENT)
+				return ret_val;
+			byt_rt5640_quirk &= ~BYT_RT5640_MCLK_EN;
 		}
 	}
 
-- 
2.11.0
