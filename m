From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Re-order some code to silence a warning" to the asoc tree
Date: Mon, 11 Dec 2017 12:13:47 +0000
Message-ID: <E1eOMxv-0004cf-Qa@debutante>
References: <20171208115425.rqclgmhcph5gn47j@mwanda>
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20171208115425.rqclgmhcph5gn47j@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Sriram Periyasamy <sriramx.periyasamy@intel.com>, alsa-devel@alsa-project.org, Jani Nikula <jani.nikula@intel.com>, Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Takashi Iwai <tiwai@suse.com>, Vinod Koul <vinod.koul@intel.com>, kernel-janitors@vger.kernel.orgMark Brown <broonie@kernel.org>, Senthilnathan Veppur <senthilnathanx.veppur@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Re-order some code to silence a warning

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 87684d338a22d15e47b16ee68f569d74ad1d076e Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 8 Dec 2017 14:54:25 +0300
Subject: [PATCH] ASoC: Intel: Skylake: Re-order some code to silence a warning

I get a Smatch warning here:

    sound/soc/intel/skylake/skl-nhlt.c:335 skl_get_ssp_clks()
    error: testing array offset 'j' after use.

The code is harmless, but the checker is right that we should swap these
two conditions so we verify that the offset is within bounds before we
use it.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Sriram Periyasamy <sriramx.periyasamy@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-nhlt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-nhlt.c b/sound/soc/intel/skylake/skl-nhlt.c
index ca5dc2be7b68..bde7f40f29f5 100644
--- a/sound/soc/intel/skylake/skl-nhlt.c
+++ b/sound/soc/intel/skylake/skl-nhlt.c
@@ -322,8 +322,8 @@ static void skl_get_ssp_clks(struct skl *skl, struct skl_ssp_clk *ssp_clks,
 		rate = channels * bps * fs;
 
 		/* check if the rate is added already to the given SSP's sclk */
-		for (j = 0; (sclk[id].rate_cfg[j].rate != 0) &&
-				(j < SKL_MAX_CLK_RATES); j++) {
+		for (j = 0; (j < SKL_MAX_CLK_RATES) &&
+			    (sclk[id].rate_cfg[j].rate != 0); j++) {
 			if (sclk[id].rate_cfg[j].rate == rate) {
 				present = true;
 				break;
-- 
2.15.1

