From: "Tirdea, Irina" <irina.tirdea@intel.com>
Subject: RE: [PATCH v3] clk: x86: Add Atom PMC platform clocks
Date: Thu, 15 Sep 2016 15:44:38 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F2F33FD2D@irsmsx105.ger.corp.intel.com>
References: <1473427417-9166-1-git-send-email-irina.tirdea@intel.com>
 <20160914213324.GF7243@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20160914213324.GF7243@codeaurora.org>
Content-Language: en-US
Sender: linux-clk-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, Michael Turquette <mturquette@baylibre.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, "Bossart, Pierre-louis" <pierre-louis.bossart@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org



> -----Original Message-----
> From: Stephen Boyd [mailto:sboyd@codeaurora.org]
> Sent: 15 September, 2016 0:33
> To: Tirdea, Irina
> Cc: linux-clk@vger.kernel.org; Michael Turquette; alsa-devel@alsa-project.org; Mark Brown; Takashi Iwai; Bossart, Pierre-louis; Pierre-
> Louis Bossart
> Subject: Re: [PATCH v3] clk: x86: Add Atom PMC platform clocks
> 
> On 09/09, Irina Tirdea wrote:
> > +
> > +static const char **plt_clk_register_parents(struct platform_device *pdev,
> > +					     struct clk_plt_data *data,
> > +					     const struct pmc_clk *clks)
> > +{
> > +	const char **parent_names;
> > +	int i, err;
> > +
> > +	data->nparents = 0;
> > +	while (clks[data->nparents].name)
> > +		data->nparents++;
> > +
> > +	data->parents = devm_kzalloc(&pdev->dev,
> > +				     sizeof(*data->parents) * data->nparents,
> > +				     GFP_KERNEL);
> 
> This could be devm_kcalloc()
> 

OK, will send v4 with this change.

> ---8<----
> diff --git a/drivers/clk/x86/clk-byt-plt.c b/drivers/clk/x86/clk-byt-plt.c
> index 9dbf4b04ae47..7bd6c0dded00 100644
> --- a/drivers/clk/x86/clk-byt-plt.c
> +++ b/drivers/clk/x86/clk-byt-plt.c
> @@ -259,9 +259,8 @@ static const char **plt_clk_register_parents(struct platform_device *pdev,
>  	while (clks[data->nparents].name)
>  		data->nparents++;
> 
> -	data->parents = devm_kzalloc(&pdev->dev,
> -				     sizeof(*data->parents) * data->nparents,
> -				     GFP_KERNEL);
> +	data->parents = devm_kcalloc(&pdev->dev, data->nparents,
> +				     sizeof(*data->parents), GFP_KERNEL);
>  	if (!data->parents) {
>  		err = -ENOMEM;
>  		goto err_out;
> 
> --
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
