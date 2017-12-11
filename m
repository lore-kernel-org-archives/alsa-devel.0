From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: Intel: Skylake: Re-order some code to silence a
 warning
Date: Mon, 11 Dec 2017 16:09:44 +0530
Message-ID: <20171211103944.GQ18649@localhost>
References: <20171208115425.rqclgmhcph5gn47j@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171208115425.rqclgmhcph5gn47j@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Sriram Periyasamy <sriramx.periyasamy@intel.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Jani Nikula <jani.nikula@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Senthilnathan Veppur <senthilnathanx.veppur@intel.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 08, 2017 at 02:54:25PM +0300, Dan Carpenter wrote:
> I get a Smatch warning here:
> 
>     sound/soc/intel/skylake/skl-nhlt.c:335 skl_get_ssp_clks()
>     error: testing array offset 'j' after use.
> 
> The code is harmless, but the checker is right that we should swap these
> two conditions so we verify that the offset is within bounds before we
> use it.

Acked-By: Vinod Koul <vinod.koul@intel.com>

> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/sound/soc/intel/skylake/skl-nhlt.c b/sound/soc/intel/skylake/skl-nhlt.c
> index afa557a1c031..54f9bd630f4f 100644
> --- a/sound/soc/intel/skylake/skl-nhlt.c
> +++ b/sound/soc/intel/skylake/skl-nhlt.c
> @@ -331,8 +331,8 @@ static void skl_get_ssp_clks(struct skl *skl, struct skl_ssp_clk *ssp_clks,
>  		rate = channels * bps * fs;
>  
>  		/* check if the rate is added already to the given SSP's sclk */
> -		for (j = 0; (sclk[id].rate_cfg[j].rate != 0) &&
> -				(j < SKL_MAX_CLK_RATES); j++) {
> +		for (j = 0; (j < SKL_MAX_CLK_RATES) &&
> +			    (sclk[id].rate_cfg[j].rate != 0); j++) {
>  			if (sclk[id].rate_cfg[j].rate == rate) {
>  				present = true;
>  				break;

-- 
~Vinod
