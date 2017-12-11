From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: Skylake: Re-order some code to silence a
 warning
Date: Mon, 11 Dec 2017 13:20:23 +0200
Message-ID: <1512991223.25007.590.camel@linux.intel.com>
References: <20171208115425.rqclgmhcph5gn47j@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20171208115425.rqclgmhcph5gn47j@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Liam Girdwood <lgirdwood@gmail.com>, Sriram Periyasamy <sriramx.periyasamy@intel.com>
Cc: Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Jani Nikula <jani.nikula@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>, Senthilnathan Veppur <senthilnathanx.veppur@intel.com>, Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2017-12-08 at 14:54 +0300, Dan Carpenter wrote:
> I get a Smatch warning here:
> 
>     sound/soc/intel/skylake/skl-nhlt.c:335 skl_get_ssp_clks()
>     error: testing array offset 'j' after use.
> 
> The code is harmless, but the checker is right that we should swap
> these
> two conditions so we verify that the offset is within bounds before we
> use it.

> -		for (j = 0; (sclk[id].rate_cfg[j].rate != 0) &&
> -				(j < SKL_MAX_CLK_RATES); j++) {
> +		for (j = 0; (j < SKL_MAX_CLK_RATES) &&
> +			    (sclk[id].rate_cfg[j].rate != 0); j++) {
>  			if (sclk[id].rate_cfg[j].rate == rate) {
>  				present = true;
>  				break;

I would rather remove also redundant parens and move the condition into
the loop.


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
