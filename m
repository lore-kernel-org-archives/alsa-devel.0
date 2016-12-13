From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH] ASoC: Intel: bytcr_rt5640: fallback mechanism
	if MCLK is not enabled
Date: Tue, 13 Dec 2016 12:41:30 -0600
Message-ID: <1481654490-31846-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id AE235266E2D
 for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2016 19:41:51 +0100 (CET)
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

This patch should be applied to -stable as well as ASoC 4.10 fixes

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 507a86a..4a8b509 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -828,7 +828,9 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev,
 				"Failed to get MCLK from pmc_plt_clk_3: %ld\n",
 				PTR_ERR(priv->mclk));
-			return PTR_ERR(priv->mclk);
+
+			/* Fall back to bitclock only */
+			byt_rt5640_quirk &= ~BYT_RT5640_MCLK_EN;
 		}
 	}
 
-- 
2.9.3
