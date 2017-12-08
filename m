From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] ASoC: Intel: Skylake: Re-order some code to
	silence a warning
Date: Fri, 8 Dec 2017 14:54:25 +0300
Message-ID: <20171208115425.rqclgmhcph5gn47j@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 1983726698E
 for <alsa-devel@alsa-project.org>; Fri,  8 Dec 2017 12:54:49 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Sriram Periyasamy <sriramx.periyasamy@intel.com>
Cc: alsa-devel@alsa-project.org, Jani Nikula <jani.nikula@intel.com>, Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Takashi Iwai <tiwai@suse.com>, Vinod Koul <vinod.koul@intel.com>, kernel-janitors@vger.kernel.org, Mark Brown <broonie@kernel.org>, Senthilnathan Veppur <senthilnathanx.veppur@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

I get a Smatch warning here:

    sound/soc/intel/skylake/skl-nhlt.c:335 skl_get_ssp_clks()
    error: testing array offset 'j' after use.

The code is harmless, but the checker is right that we should swap these
two conditions so we verify that the offset is within bounds before we
use it.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/soc/intel/skylake/skl-nhlt.c b/sound/soc/intel/skylake/skl-nhlt.c
index afa557a1c031..54f9bd630f4f 100644
--- a/sound/soc/intel/skylake/skl-nhlt.c
+++ b/sound/soc/intel/skylake/skl-nhlt.c
@@ -331,8 +331,8 @@ static void skl_get_ssp_clks(struct skl *skl, struct skl_ssp_clk *ssp_clks,
 		rate = channels * bps * fs;
 
 		/* check if the rate is added already to the given SSP's sclk */
-		for (j = 0; (sclk[id].rate_cfg[j].rate != 0) &&
-				(j < SKL_MAX_CLK_RATES); j++) {
+		for (j = 0; (j < SKL_MAX_CLK_RATES) &&
+			    (sclk[id].rate_cfg[j].rate != 0); j++) {
 			if (sclk[id].rate_cfg[j].rate == rate) {
 				present = true;
 				break;
