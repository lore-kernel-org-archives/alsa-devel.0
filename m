From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v2] clk: x86: add "mclk" alias for
 Baytrail/Cherrytrail
Date: Sun, 19 Mar 2017 20:47:24 -0500
Message-ID: <2dbe7397-2c7a-fe94-270c-f02e7e1a6bbb@linux.intel.com>
References: <1487622236-16901-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1487622236-16901-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Sender: linux-clk-owner@vger.kernel.org
To: linux-clk@vger.kernel.org, x86@kernel.org, platform-driver-x86@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, Michael Turquette <mturquette@baylibre.com>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On 2/20/17 2:23 PM, Pierre-Louis Bossart wrote:
> Due to timing requirements, TI and Conexant manage the audio
> reference clock from their ASoC codec drivers using the "mclk"
> string. This patch adds another lookup for the "pmc_plt_clk_3"
> clock to avoid Intel-specific tests in those codec drivers and
> use code as-is.
>
> To avoid a leak, clk_add_alias() is not used in this patch.
> Instead the lookup is created manually as part of the .probe()
> step and dropped in the .remove() step.
>
> "pmc_plt_clk_3" is used exclusively for audio on all known
> Baytrail/CherryTrail designs and is e.g. routed on the MCLK
> (pin 26) of the MinnowBoardMAX Turbot LSE connector.
>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Was there any objection or feedback on this patch?
The functionality is needed for a couple of audio drivers from Conexant 
and Dialog initially written for ARM platforms.
Thanks
-Pierre


> ---
>  drivers/clk/x86/clk-pmc-atom.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/clk/x86/clk-pmc-atom.c b/drivers/clk/x86/clk-pmc-atom.c
> index 2b60577..fafc991 100644
> --- a/drivers/clk/x86/clk-pmc-atom.c
> +++ b/drivers/clk/x86/clk-pmc-atom.c
> @@ -54,6 +54,7 @@ struct clk_plt_data {
>  	struct clk_plt_fixed **parents;
>  	u8 nparents;
>  	struct clk_plt *clks[PMC_CLK_NUM];
> +	struct clk_lookup *mclk_lookup;
>  };
>
>  /* Return an index in parent table */
> @@ -337,6 +338,11 @@ static int plt_clk_probe(struct platform_device *pdev)
>  			goto err_unreg_clk_plt;
>  		}
>  	}
> +	data->mclk_lookup = clkdev_hw_create(&data->clks[3]->hw, "mclk", NULL);
> +	if (IS_ERR(data->mclk_lookup)) {
> +		err = PTR_ERR(data->mclk_lookup);
> +		goto err_unreg_clk_plt;
> +	}
>
>  	plt_clk_free_parent_names_loop(parent_names, data->nparents);
>
> @@ -356,6 +362,7 @@ static int plt_clk_remove(struct platform_device *pdev)
>
>  	data = platform_get_drvdata(pdev);
>
> +	clkdev_drop(data->mclk_lookup);
>  	plt_clk_unregister_loop(data, PMC_CLK_NUM);
>  	plt_clk_unregister_parents(data);
>  	return 0;
>

