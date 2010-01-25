From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/5] DaVinci: DM365: Voice codec
	support	for the DM365 SoC
Date: Mon, 25 Jan 2010 11:17:56 +0000
Message-ID: <20100125111756.GD22909@sirena.org.uk>
References: <1264095711-1385-1-git-send-email-miguel.aguilar@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id BE989103870
	for <alsa-devel@alsa-project.org>; Mon, 25 Jan 2010 12:17:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1264095711-1385-1-git-send-email-miguel.aguilar@ridgerun.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: miguel.aguilar@ridgerun.com
Cc: davinci-linux-open-source@linux.davincidsp.com, clark.becker@ridgerun.com, Kevin Hilman <khilman@deeprootsystems.com>, nsekhar@ti.com, diego.dompe@ridgerun.com, alsa-devel@alsa-project.org, nsnehaprabha@ti.com, todd.fischer@ridgerun.com
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 21, 2010 at 11:41:51AM -0600, miguel.aguilar@ridgerun.com wrote:
> From: Miguel Aguilar <miguel.aguilar@ridgerun.com>
> 
> This patch adds the generic Voice Codec support for the DM365 based
> platforms.
> 
> Signed-off-by: Miguel Aguilar <miguel.aguilar@ridgerun.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

It doesn't look like there should be any cross tree issues so probably
easiest to merge this via the DaVinci tree.

> ---
>  arch/arm/mach-davinci/dm365.c              |   37 +++++++++++++++++++++++++++-
>  arch/arm/mach-davinci/include/mach/dm365.h |    5 ++++
>  arch/arm/mach-davinci/include/mach/mux.h   |    2 +
>  3 files changed, 43 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
> index c63afc0..b5345d5 100644
> --- a/arch/arm/mach-davinci/dm365.c
> +++ b/arch/arm/mach-davinci/dm365.c
> @@ -455,7 +455,7 @@ static struct clk_lookup dm365_clks[] = {
>  	CLK(NULL, "timer3", &timer3_clk),
>  	CLK(NULL, "usb", &usb_clk),
>  	CLK("davinci_emac.1", NULL, &emac_clk),
> -	CLK("voice_codec", NULL, &voicecodec_clk),
> +	CLK("davinci_voicecodec", NULL, &voicecodec_clk),
>  	CLK("davinci-asp.0", NULL, &asp0_clk),
>  	CLK(NULL, "rto", &rto_clk),
>  	CLK(NULL, "mjcp", &mjcp_clk),
> @@ -606,6 +606,8 @@ INT_CFG(DM365,  INT_NSF_DISABLE,     25,    1,    0,     false)
>  
>  EVT_CFG(DM365,	EVT2_ASP_TX,         0,     1,    0,     false)
>  EVT_CFG(DM365,	EVT3_ASP_RX,         1,     1,    0,     false)
> +EVT_CFG(DM365,	EVT2_VC_TX,          0,     1,    1,     false)
> +EVT_CFG(DM365,	EVT3_VC_RX,          1,     1,    1,     false)
>  #endif
>  };
>  
> @@ -835,6 +837,31 @@ static struct platform_device dm365_asp_device = {
>  	.resource	= dm365_asp_resources,
>  };
>  
> +static struct resource dm365_vc_resources[] = {
> +	{
> +		.start	= DAVINCI_DM365_VC_BASE,
> +		.end	= DAVINCI_DM365_VC_BASE + SZ_1K - 1,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +	{
> +		.start	= DAVINCI_DMA_VC_TX,
> +		.end	= DAVINCI_DMA_VC_TX,
> +		.flags	= IORESOURCE_DMA,
> +	},
> +	{
> +		.start	= DAVINCI_DMA_VC_RX,
> +		.end	= DAVINCI_DMA_VC_RX,
> +		.flags	= IORESOURCE_DMA,
> +	},
> +};
> +
> +static struct platform_device dm365_vc_device = {
> +	.name		= "davinci_voicecodec",
> +	.id		= -1,
> +	.num_resources	= ARRAY_SIZE(dm365_vc_resources),
> +	.resource	= dm365_vc_resources,
> +};
> +
>  static struct resource dm365_rtc_resources[] = {
>  	{
>  		.start = DM365_RTC_BASE,
> @@ -991,6 +1018,14 @@ void __init dm365_init_asp(struct snd_platform_data *pdata)
>  	platform_device_register(&dm365_asp_device);
>  }
>  
> +void __init dm365_init_vc(struct snd_platform_data *pdata)
> +{
> +	davinci_cfg_reg(DM365_EVT2_VC_TX);
> +	davinci_cfg_reg(DM365_EVT3_VC_RX);
> +	dm365_vc_device.dev.platform_data = pdata;
> +	platform_device_register(&dm365_vc_device);
> +}
> +
>  void __init dm365_init_ks(struct davinci_ks_platform_data *pdata)
>  {
>  	dm365_ks_device.dev.platform_data = pdata;
> diff --git a/arch/arm/mach-davinci/include/mach/dm365.h b/arch/arm/mach-davinci/include/mach/dm365.h
> index 3c07a88..57e51eb 100644
> --- a/arch/arm/mach-davinci/include/mach/dm365.h
> +++ b/arch/arm/mach-davinci/include/mach/dm365.h
> @@ -31,8 +31,13 @@
>  
>  #define DM365_RTC_BASE			(0x01C69000)
>  
> +#define DAVINCI_DM365_VC_BASE		(0x01D0C000)
> +#define DAVINCI_DMA_VC_TX		2
> +#define DAVINCI_DMA_VC_RX		3
> +
>  void __init dm365_init(void);
>  void __init dm365_init_asp(struct snd_platform_data *pdata);
> +void __init dm365_init_vc(struct snd_platform_data *pdata);
>  void __init dm365_init_ks(struct davinci_ks_platform_data *pdata);
>  void __init dm365_init_rtc(void);
>  
> diff --git a/arch/arm/mach-davinci/include/mach/mux.h b/arch/arm/mach-davinci/include/mach/mux.h
> index 137bfba..2a68c1d 100644
> --- a/arch/arm/mach-davinci/include/mach/mux.h
> +++ b/arch/arm/mach-davinci/include/mach/mux.h
> @@ -327,6 +327,8 @@ enum davinci_dm365_index {
>  	/* EDMA event muxing */
>  	DM365_EVT2_ASP_TX,
>  	DM365_EVT3_ASP_RX,
> +	DM365_EVT2_VC_TX,
> +	DM365_EVT3_VC_RX,
>  	DM365_EVT26_MMC0_RX,
>  };
>  
> -- 
> 1.6.0.4
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 

-- 
"You grabbed my hand and we fell into it, like a daydream - or a fever."
