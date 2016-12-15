From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2] ASoC: Intel: bytcr_rt5640: fallback
	mechanism if MCLK is not enabled
Date: Thu, 15 Dec 2016 14:19:14 -0600
Message-ID: <1481833154-4688-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id F21A0267392
 for <alsa-devel@alsa-project.org>; Thu, 15 Dec 2016 21:19:19 +0100 (CET)
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
Cc: tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

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
---
 sound/soc/intel/boards/bytcr_rt5640.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 507a86a..7d66127 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -825,10 +825,20 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 	if ((byt_rt5640_quirk & BYT_RT5640_MCLK_EN) && (is_valleyview())) {
 		priv->mclk = devm_clk_get(&pdev->dev, "pmc_plt_clk_3");
 		if (IS_ERR(priv->mclk)) {
+			ret_val = PTR_ERR(priv->mclk);
+
 			dev_err(&pdev->dev,
 				"Failed to get MCLK from pmc_plt_clk_3: %ld\n",
-				PTR_ERR(priv->mclk));
-			return PTR_ERR(priv->mclk);
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
2.7.4
