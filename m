From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] clk: x86: add "mclk" alias for Baytrail/Cherrytrail
Date: Tue, 14 Feb 2017 11:04:56 -0800
Message-ID: <20170214190456.GV25384@codeaurora.org>
References: <1486937212-10093-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1486937212-10093-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Sender: linux-clk-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: linux-clk@vger.kernel.org, x86@kernel.org, platform-driver-x86@vger.kernel.org, alsa-devel@alsa-project.org, Michael Turquette <mturquette@baylibre.com>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

On 02/12, Pierre-Louis Bossart wrote:
> Due to timing requirements, TI and Conexant manage the audio
> reference clock from their ASoC codec drivers using the "mclk"
> string. This patch adds a default alias to "pmc_plt_clk_3" to
> avoid Intel-specific tests in those codec drivers and use code
> as-is.
> "pmc_plt_clk_3" is used exclusively for audio on all known
> Baytrail/CherryTrail designs and is e.g. routed on the MCLK
> (pin 26) of the MinnowBoardMAX Turbot LSE connector.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
> 
> Notes:
>     This patch only applies on top of linux-next or clk-next, the
>     previous clk-related patches are not yet merged in the audio
>     trees
> 
>  drivers/clk/x86/clk-pmc-atom.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/clk/x86/clk-pmc-atom.c b/drivers/clk/x86/clk-pmc-atom.c
> index 2b60577..ba00d27 100644
> --- a/drivers/clk/x86/clk-pmc-atom.c
> +++ b/drivers/clk/x86/clk-pmc-atom.c
> @@ -340,6 +340,8 @@ static int plt_clk_probe(struct platform_device *pdev)
>  
>  	plt_clk_free_parent_names_loop(parent_names, data->nparents);
>  
> +	clk_add_alias("mclk", dev_name(&pdev->dev), "pmc_plt_clk_3", NULL);
> +

This leaks an alias when the driver is removed. Honestly,
clk_add_alias() doesn't work well because of that problem. Can
you just add another lookup with the pointer you already have
instead of passing a NULL device to do a global lookup?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
