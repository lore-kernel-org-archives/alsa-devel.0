From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 2/2] Davinci: DM365: Enable DaVinci Voice
	Codec support for DM365 EVM
Date: Mon, 11 Jan 2010 08:04:20 -0800
Message-ID: <87vdf8ocfv.fsf@deeprootsystems.com>
References: <1262902641-14821-1-git-send-email-miguel.aguilar@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f202.google.com (mail-iw0-f202.google.com
	[209.85.223.202])
	by alsa0.perex.cz (Postfix) with ESMTP id E0DE5103822
	for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2010 17:04:24 +0100 (CET)
Received: by iwn40 with SMTP id 40so4677623iwn.24
	for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2010 08:04:23 -0800 (PST)
In-Reply-To: <1262902641-14821-1-git-send-email-miguel.aguilar@ridgerun.com>
	(miguel aguilar's message of "Thu\, 7 Jan 2010 16\:17\:21 -0600")
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
Cc: davinci-linux-open-source@linux.davincidsp.com, clark.becker@ridgerun.com, santiago.nunez@ridgerun.com, diego.dompe@ridgerun.com, alsa-devel@alsa-project.org, nsnehaprabha@ti.com, todd.fischer@ridgerun.com
List-Id: alsa-devel@alsa-project.org

miguel.aguilar@ridgerun.com writes:

> From: Miguel Aguilar <miguel.aguilar@ridgerun.com>
>
> It sets up one single card for the DM365 EVM with two subdevices:
> the AIC3x and the Voice Codec.
>
> The general structures are defined at DM365 SoC file and the specific
> platform data structure for the EVM is defined at board file.

You don't describe how you changed the muxing to be dynamic etc.

Could also use a bit more description about how/when the new callback
is intended to be used.

> Signed-off-by: Miguel Aguilar <miguel.aguilar@ridgerun.com>
> ---
>  arch/arm/mach-davinci/board-dm365-evm.c    |   39 +++++++++++++++++++++++++++-
>  arch/arm/mach-davinci/dm365.c              |   37 ++++++++++++++++++++++++--
>  arch/arm/mach-davinci/include/mach/asp.h   |    1 +
>  arch/arm/mach-davinci/include/mach/dm365.h |    5 +++
>  arch/arm/mach-davinci/include/mach/mux.h   |    2 +
>  5 files changed, 80 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
> index 8d23972..74f3519 100644
> --- a/arch/arm/mach-davinci/board-dm365-evm.c
> +++ b/arch/arm/mach-davinci/board-dm365-evm.c
> @@ -175,7 +175,43 @@ static struct at24_platform_data eeprom_info = {
>  	.context	= (void *)0x7f00,
>  };
>  
> -static struct snd_platform_data dm365_evm_snd_data;
> +static int dm365_snd_dma_event_mux(int device, int enable, int playback)

I think enable and playback should be bool, no?

> +{
> +	static int tx_dma_mux = 0;
> +	static int rx_dma_mux = 0;

these should be bool also.

also, scripts/checkpatch.pl should tell you you don't need to assign
these statics to zero

> +	if (!enable) {
> +		if (playback)
> +			tx_dma_mux = 0;
> +		else
> +			rx_dma_mux = 0;
> +		return 0;
> +	}
> +
> +	if (playback) {
> +		if (tx_dma_mux == 1)
> +			return -EBUSY;
> +		if (device == 0)

As Mark pointed out, for readability, rather than zero you should have
some symbolic name, either a #define or enum of the options would
greatly improve readability.

Kevin

> +			davinci_cfg_reg(DM365_EVT2_ASP_TX);
> +		else
> +			davinci_cfg_reg(DM365_EVT2_VC_TX);
> +		tx_dma_mux = 1;
> +	} else {
> +		if (rx_dma_mux == 1)
> +			return -EBUSY;
> +		if (device == 0)
> +			davinci_cfg_reg(DM365_EVT3_ASP_RX);
> +		else
> +			davinci_cfg_reg(DM365_EVT3_VC_RX);
> +		rx_dma_mux = 1;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct snd_platform_data dm365_evm_snd_data = {
> +	.dma_event_mux = &dm365_snd_dma_event_mux,
> +};
>  
>  static struct i2c_board_info i2c_info[] = {
>  	{
> @@ -513,6 +549,7 @@ static __init void dm365_evm_init(void)
>  	evm_init_cpld();
>  
>  	dm365_init_asp(&dm365_evm_snd_data);
> +	dm365_init_vc(&dm365_evm_snd_data);
>  	dm365_init_rtc();
>  
>  #ifdef CONFIG_KEYBOARD_DAVINCI
> diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
> index cc3bae4..024cbab 100644
> --- a/arch/arm/mach-davinci/dm365.c
> +++ b/arch/arm/mach-davinci/dm365.c
> @@ -455,7 +455,7 @@ static struct davinci_clk dm365_clks[] = {
>  	CLK(NULL, "timer3", &timer3_clk),
>  	CLK(NULL, "usb", &usb_clk),
>  	CLK("davinci_emac.1", NULL, &emac_clk),
> -	CLK("voice_codec", NULL, &voicecodec_clk),
> +	CLK("davinci_voicecodec", NULL, &voicecodec_clk),
>  	CLK("davinci-asp.0", NULL, &asp0_clk),
>  	CLK(NULL, "rto", &rto_clk),
>  	CLK(NULL, "mjcp", &mjcp_clk),
> @@ -604,6 +604,8 @@ INT_CFG(DM365,  INT_IMX1_DISABLE,    24,    1,    0,     false)
>  INT_CFG(DM365,  INT_NSF_ENABLE,      25,    1,    1,     false)
>  INT_CFG(DM365,  INT_NSF_DISABLE,     25,    1,    0,     false)
>  
> +EVT_CFG(DM365, EVT2_VC_TX,           0,     1,    1,     false)
> +EVT_CFG(DM365, EVT3_VC_RX,           1,     1,    1,     false)
>  EVT_CFG(DM365,	EVT2_ASP_TX,         0,     1,    0,     false)
>  EVT_CFG(DM365,	EVT3_ASP_RX,         1,     1,    0,     false)
>  #endif
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
> @@ -985,12 +1012,16 @@ void __init dm365_init_asp(struct snd_platform_data *pdata)
>  	davinci_cfg_reg(DM365_MCBSP0_BDR);
>  	davinci_cfg_reg(DM365_MCBSP0_R);
>  	davinci_cfg_reg(DM365_MCBSP0_BFSR);
> -	davinci_cfg_reg(DM365_EVT2_ASP_TX);
> -	davinci_cfg_reg(DM365_EVT3_ASP_RX);
>  	dm365_asp_device.dev.platform_data = pdata;
>  	platform_device_register(&dm365_asp_device);
>  }
>  
> +void __init dm365_init_vc(struct snd_platform_data *pdata)
> +{
> +	dm365_vc_device.dev.platform_data = pdata;
> +	platform_device_register(&dm365_vc_device);
> +}
> +
>  void __init dm365_init_ks(struct davinci_ks_platform_data *pdata)
>  {
>  	davinci_cfg_reg(DM365_KEYSCAN);
> diff --git a/arch/arm/mach-davinci/include/mach/asp.h b/arch/arm/mach-davinci/include/mach/asp.h
> index 834725f..6a175eb 100644
> --- a/arch/arm/mach-davinci/include/mach/asp.h
> +++ b/arch/arm/mach-davinci/include/mach/asp.h
> @@ -50,6 +50,7 @@
>  #define DAVINCI_ASP1_TX_INT	IRQ_MBXINT
>  
>  struct snd_platform_data {
> +	int (*dma_event_mux)(int, int, int);
>  	u32 tx_dma_offset;
>  	u32 rx_dma_offset;
>  	enum dma_event_q eventq_no;	/* event queue number */
> diff --git a/arch/arm/mach-davinci/include/mach/dm365.h b/arch/arm/mach-davinci/include/mach/dm365.h
> index 3c07a88..50aeaec 100644
> --- a/arch/arm/mach-davinci/include/mach/dm365.h
> +++ b/arch/arm/mach-davinci/include/mach/dm365.h
> @@ -31,8 +31,13 @@
>  
>  #define DM365_RTC_BASE			(0x01C69000)
>  
> +#define DAVINCI_DM365_VC_BASE          (0x01D0C000)
> +#define DAVINCI_DMA_VC_TX              2
> +#define DAVINCI_DMA_VC_RX              3
> +
>  void __init dm365_init(void);
>  void __init dm365_init_asp(struct snd_platform_data *pdata);
> +void __init dm365_init_vc(struct snd_platform_data *pdata);
>  void __init dm365_init_ks(struct davinci_ks_platform_data *pdata);
>  void __init dm365_init_rtc(void);
>  
> diff --git a/arch/arm/mach-davinci/include/mach/mux.h b/arch/arm/mach-davinci/include/mach/mux.h
> index b60c693..2937c51 100644
> --- a/arch/arm/mach-davinci/include/mach/mux.h
> +++ b/arch/arm/mach-davinci/include/mach/mux.h
> @@ -325,6 +325,8 @@ enum davinci_dm365_index {
>  	DM365_INT_NSF_DISABLE,
>  
>  	/* EDMA event muxing */
> +	DM365_EVT2_VC_TX,
> +	DM365_EVT3_VC_RX,
>  	DM365_EVT2_ASP_TX,
>  	DM365_EVT3_ASP_RX,
>  	DM365_EVT26_MMC0_RX,
> -- 
> 1.6.0.4
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
