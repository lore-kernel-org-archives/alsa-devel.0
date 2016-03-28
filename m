From: Jose Abreu <Jose.Abreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 2/3 v2] ASoC: dwc: Add I2S HDMI audio support
Date: Mon, 28 Mar 2016 17:07:28 +0100
Message-ID: <56F956C0.80705@synopsys.com>
References: <cover.1459174494.git.joabreu@synopsys.com>
 <538be366488bf0d7633d702f2d0bab16707b7a47.1459174494.git.joabreu@synopsys.com>
 <1459179345.4785.127.camel@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1459179345.4785.127.camel-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexey Brodkin <Alexey.Brodkin-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Cc: "lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org" <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, "laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "pawel.moll-5wv7dgnIgG8@public.gmane.org" <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Carlos Palminha <CARLOS.PALMINHA-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, "nariman-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org" <nariman-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "alexander.deucher-5C7GfCeVMHo@public.gmane.org" <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, "tixy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <tixy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "yitian.bu-sf4bEIuTEZ8/jFmSBShxMA@public.gmane.org" <yitian.bu-sf4bEIuTEZ8/jFmSBShxMA@public.gmane.org>, "linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <galak@codea>
List-Id: alsa-devel@alsa-project.org

Hi Alexey,

On 28-03-2016 16:35, Alexey Brodkin wrote:
> Hi Jose,
>
> On Mon, 2016-03-28 at 15:36 +0100, Jose Abreu wrote:
>> HDMI audio support was added to the AXS board using an
>> I2S cpu driver and a custom platform driver.
>>
>> The platform driver supports two channels @ 16 bits with
>> rates 32k, 44.1k and 48k. ALSA Simple audio card is used to
>> glue the cpu, platform and codec driver (adv7511).
>>
>> Signed-off-by: Jose Abreu <joabreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
>> ---
>>
>> No changes v1 -> v2.
>>
>>  sound/soc/dwc/Kconfig          |   1 +
>>  sound/soc/dwc/designware_i2s.c | 385 +++++++++++++++++++++++++++++++++++++++--
>>  2 files changed, 373 insertions(+), 13 deletions(-)
>>
>> diff --git a/sound/soc/dwc/Kconfig b/sound/soc/dwc/Kconfig
>> index d50e085..bc3fae7 100644
>> --- a/sound/soc/dwc/Kconfig
>> +++ b/sound/soc/dwc/Kconfig
>> @@ -2,6 +2,7 @@ config SND_DESIGNWARE_I2S
>>  	tristate "Synopsys I2S Device Driver"
>>  	depends on CLKDEV_LOOKUP
>>  	select SND_SOC_GENERIC_DMAENGINE_PCM
>> +	select SND_SIMPLE_CARD
>>  	help
>>  	 Say Y or M if you want to add support for I2S driver for
>>  	 Synopsys desigwnware I2S device. The device supports upto
>> diff --git a/sound/soc/dwc/designware_i2s.c b/sound/soc/dwc/designware_i2s.c
>> index bff258d..0f2f588 100644
>> --- a/sound/soc/dwc/designware_i2s.c
>> +++ b/sound/soc/dwc/designware_i2s.c
>> @@ -84,11 +84,37 @@
>>  #define MAX_CHANNEL_NUM		8
>>  #define MIN_CHANNEL_NUM		2
>>  
>> +/* FPGA Version Info */
>> +#define FPGA_VER_INFO	0xE0011230
>> +#define FPGA_VER_27M	0x000FBED9
>> +
>> +/* PLL registers addresses */
>> +#define PLL_IDIV_ADDR	0xE00100A0
>> +#define PLL_FBDIV_ADDR	0xE00100A4
>> +#define PLL_ODIV0_ADDR	0xE00100A8
>> +#define PLL_ODIV1_ADDR	0xE00100AC
> Well I think all is not acceptable.
> See all these FPGA_VER_xxx as well as PLL_xxx
> are strictly ARC SDP specific things and have nothing to do with generic driver.
>
> That's so pity we don't have a driver for all clocks/PLLs on ARC SDP yet.
> So as of now I may only propose to use hard-coded fixed clocks as I did with
> ARC PGU, see "pguclk" here:
> http://lists.infradead.org/pipermail/linux-snps-arc/2016-March/000790.html
>
> Again I'll try to implement missing clock driver sometime soon because
> more and more stuff requires it but for now let's use a work-around.
Yes, this is a workaround that we are using so that the driver works in ARC SDP
platforms. The driver still has the functionality to operate using a clock
driver (it must be declared in device tree) but if the clock handle is not
declared the driver will assume that must use the internal PLL config options.
This is currently the only option to make it work in ARC SDP.

I will send a v3 soon without this workaround and when the missing clock drivers
are implemented I will re-test this.
>> +struct dw_i2s_pll {
>> +	unsigned int rate;
>> +	unsigned int data_width;
>> +	unsigned int idiv;
>> +	unsigned int fbdiv;
>> +	unsigned int odiv0;
>> +	unsigned int odiv1;
>> +};
>> +
>> +static const struct dw_i2s_pll dw_i2s_pll_cfg_27m[] = {
>> +	/* 27Mhz */
>> +	{ 32000, 16, 0x104, 0x451, 0x10E38, 0x2000 },
>> +	{ 44100, 16, 0x104, 0x596, 0x10D35, 0x2000 },
>> +	{ 48000, 16, 0x208, 0xA28, 0x10B2C, 0x2000 },
>> +	{ 0, 0, 0, 0, 0, 0 },
>>  };
>>  
>> +static const struct dw_i2s_pll dw_i2s_pll_cfg_28m[] = {
>> +	/* 28.224Mhz */
>> +	{ 32000, 16, 0x82, 0x105, 0x107DF, 0x2000 },
>> +	{ 44100, 16, 0x28A, 0x1, 0x10001, 0x2000 },
>> +	{ 48000, 16, 0xA28, 0x187, 0x10042, 0x2000 },
>> +	{ 0, 0, 0, 0, 0, 0 },
>> +};
> These 2 hunks as well should go in ARC SDP clocks.
>
>> +static int i2s_pll_cfg(struct i2s_clk_config_data *config)
>> +{
>> +	const struct dw_i2s_pll *pll_cfg;
>> +	u32 rate = config->sample_rate;
>> +	u32 data_width = config->data_width;
>> +	int i;
>> +
>> +	if (readl((void *)FPGA_VER_INFO) <= FPGA_VER_27M)
>> +		pll_cfg = dw_i2s_pll_cfg_27m;
>> +	else
>> +		pll_cfg = dw_i2s_pll_cfg_28m;
>> +
>> +	for (i = 0; pll_cfg[i].rate != 0; i++) {
>> +		if ((pll_cfg[i].rate == rate) &&
>> +				(pll_cfg[i].data_width == data_width)) {
>> +			writel(pll_cfg[i].idiv, (void *)PLL_IDIV_ADDR);
>> +			writel(pll_cfg[i].fbdiv, (void *)PLL_FBDIV_ADDR);
>> +			writel(pll_cfg[i].odiv0, (void *)PLL_ODIV0_ADDR);
>> +			writel(pll_cfg[i].odiv1, (void *)PLL_ODIV1_ADDR);
>> +			return 0;
>> +		}
>> +	}
>> +
>> +	return -EINVAL;
>> +}
> Ditto.
>
> -Alexey

Best regards,
Jose Miguel Abreu

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
