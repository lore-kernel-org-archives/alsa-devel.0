From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: Intel: bytcr_rt565: fix missing
 assignment to ret_val
Date: Wed, 2 May 2018 10:20:26 -0500
Message-ID: <81881453-1353-ecd8-c981-d1828738a996@linux.intel.com>
References: <20180502142945.31637-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180502142945.31637-1-colin.king@canonical.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 5/2/18 9:29 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently, the check that ret_val is not -ENOENT is always true and
> the quirk bit BYT_RY5651_MCLK_EN is never being cleared because ret_val
> is always zero at this point from a previous assignment earlier on.
> I believe that ret_val should actually be assigned to the return from
> devm_clk_get() as this can return -ENOENT (from a deeper call to
> clk_get_sys) and that was the original intention to check this.
> 
> Detected by CoverityScan, CID#1460228 ("Logically dead code")

nice catch, the fix is consistent with what is done for rt5640.

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> 
> Fixes: 02c0a3b3047f ("ASoC: Intel: bytcr_rt5651: add MCLK, quirks and cleanups")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   sound/soc/intel/boards/bytcr_rt5651.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
> index 3c7d93520c52..469e2695d121 100644
> --- a/sound/soc/intel/boards/bytcr_rt5651.c
> +++ b/sound/soc/intel/boards/bytcr_rt5651.c
> @@ -856,9 +856,10 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
>   	if (byt_rt5651_quirk & BYT_RT5651_MCLK_EN) {
>   		priv->mclk = devm_clk_get(&pdev->dev, "pmc_plt_clk_3");
>   		if (IS_ERR(priv->mclk)) {
> +			ret_val = PTR_ERR(priv->mclk);
>   			dev_err(&pdev->dev,
> -				"Failed to get MCLK from pmc_plt_clk_3: %ld\n",
> -				PTR_ERR(priv->mclk));
> +				"Failed to get MCLK from pmc_plt_clk_3: %d\n",
> +				ret_val);
>   			/*
>   			 * Fall back to bit clock usage for -ENOENT (clock not
>   			 * available likely due to missing dependencies), bail
> 
