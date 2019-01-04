From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [RFC PATCH 01/10] dma-engine: sun4i: Add a quirk to support
 different chips
Date: Fri, 4 Jan 2019 21:08:15 +0530
Message-ID: <20190104153815.GN13372@vkoul-mobl.Dlink>
References: <cover.1543782328.git.mesihkilinc@gmail.com>
 <864e28404a31ba24094f74fd060d11c16562e965.1543782328.git.mesihkilinc@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <864e28404a31ba24094f74fd060d11c16562e965.1543782328.git.mesihkilinc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mesih Kilinc <mesihkilinc@gmail.com>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

On 03-12-18, 00:23, Mesih Kilinc wrote:
> Allwinner suniv F1C100s has similar DMA engine to sun4i. Several
> registers has different addresses. Total dma channels, endpoint counts
> and max burst counts are also different.

So if register layout is the only diff, have you thought about using
regmap_field so that you dont care about the layout

> +struct sun4i_dma_config {
> +	u32 ndma_nr_max_channels;
> +	u32 ndma_nr_max_vchans;
> +
> +	u32 ddma_nr_max_channels;
> +	u32 ddma_nr_max_vchans;
> +
> +	u32 dma_nr_max_channels;
> +
> +        void (*set_dst_data_width)(u32 *p_cfg, s8 data_width);
> +        void (*set_src_data_width)(u32 *p_cfg, s8 data_width);

aligned please, checkpatch should warn about this stuff

>  struct sun4i_dma_dev {
> -	DECLARE_BITMAP(pchans_used, SUN4I_DMA_NR_MAX_CHANNELS);
> +	unsigned long *pchans_used;

why not bitmap?

> +static struct sun4i_dma_config sun4i_a10_dma_cfg = {
> +	.ndma_nr_max_channels	= SUN4I_NDMA_NR_MAX_CHANNELS,
> +	.ndma_nr_max_vchans	= SUN4I_NDMA_NR_MAX_VCHANS,
> +
> +	.ddma_nr_max_channels	= SUN4I_DDMA_NR_MAX_CHANNELS,
> +	.ddma_nr_max_vchans	= SUN4I_DDMA_NR_MAX_VCHANS,
> +
> +	.dma_nr_max_channels	= SUN4I_NDMA_NR_MAX_CHANNELS + 
> +		SUN4I_DDMA_NR_MAX_CHANNELS,
> +
> +	.set_dst_data_width	= set_dst_data_width_a10,
> +	.set_src_data_width	= set_src_data_width_a10,
> +	.convert_burst		= convert_burst_a10,
> +
> +	.ndma_drq_sdram		= SUN4I_NDMA_DRQ_TYPE_SDRAM,
> +	.ddma_drq_sdram		= SUN4I_DDMA_DRQ_TYPE_SDRAM,
> +
> +	.max_burst		= SUN4I_MAX_BURST,
> +};
> +
>  static const struct of_device_id sun4i_dma_match[] = {
> -	{ .compatible = "allwinner,sun4i-a10-dma" },
> +	{ .compatible = "allwinner,sun4i-a10-dma", .data = &sun4i_a10_dma_cfg },

I would prefer this to be split into two patches, first one does the
refactoring of driver (better if we split things logically) and then
addition of new one..

-- 
~Vinod
