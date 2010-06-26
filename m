From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH RFC 3/3] uda1380: make driver more
	powersave-friendly
Date: Sat, 26 Jun 2010 21:45:12 +0100
Message-ID: <0FF1255A-5069-426F-9521-A8E0787081D8@opensource.wolfsonmicro.com>
References: <1277565285-11563-1-git-send-email-anarsoul@gmail.com>
	<1277565285-11563-4-git-send-email-anarsoul@gmail.com>
	(sfid-20100626_161536_132759_73FF1EF7)
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D5471244C7
	for <alsa-devel@alsa-project.org>;
	Sat, 26 Jun 2010 22:45:13 +0200 (CEST)
In-Reply-To: <1277565285-11563-4-git-send-email-anarsoul@gmail.com>
	(sfid-20100626_161536_132759_73FF1EF7)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Philipp Zabel <philipp.zabel@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 26 Jun 2010, at 16:14, Vasily Khoruzhick wrote:

> Disable some codec modules in standby mode, completely disable
> codec in off mode to save some power.
> Fix suspend/resume: mark mixer regs as dirty on resume to
> restore mixer values, otherwise driver produces no sound
> (master is muted by default).

Please remember to CC Liam on ASoC patches.

> +	for (reg = UDA1380_MVOL; reg < UDA1380_CACHEREGNUM; reg++)
> +		set_bit(reg - 0x10, &uda1380_cache_dirty);

This seems odd, I'd expect the cache to be being marked as clean immediately
after sync?

> @@ -561,17 +595,38 @@ static int uda1380_set_bias_level(struct snd_soc_codec *codec,
> 	enum snd_soc_bias_level level)
> {
> 	int pm = uda1380_read_reg_cache(codec, UDA1380_PM);
> +	struct uda1380_platform_data *pdata = codec->dev->platform_data;
> +
> +	if (codec->bias_level == level)
> +		return 0;
> 
> 	switch (level) {
> 	case SND_SOC_BIAS_ON:
> 	case SND_SOC_BIAS_PREPARE:
> +		/* ADC, DAC on */
> 		uda1380_write(codec, UDA1380_PM, R02_PON_BIAS | pm);

Like I said previously you really should look at using DAPM here, this should
make the code simpler and will let you 

You might also want to consider snd_soc_update_bits().

> 		break;
> 	case SND_SOC_BIAS_STANDBY:
> -		uda1380_write(codec, UDA1380_PM, R02_PON_BIAS);
> +		if (codec->bias_level == SND_SOC_BIAS_OFF) {
> +			pdata->set_power(1);
> +			uda1380_reset(codec);

The reset here seems unneeded and possibly wasteful if there is no power
control on the system. It'd seem better to do something like just power up,
flagging the cache as dirty if there was a callback. I'd strongly expect that
if you are actually controlling power the device will be in the default state
anyway.

> +			switch (pdata->dac_clk) {
> +			case UDA1380_DAC_CLK_SYSCLK:
> +				uda1380_write_reg_cache(codec, UDA1380_CLK, 0);
> +				break;
> +			case UDA1380_DAC_CLK_WSPLL:
> +				uda1380_write_reg_cache(codec, UDA1380_CLK,
> +					R00_DAC_CLK);
> +				break;
> +			}

Why is this being managed every time the device is enabled? Surely the
setting can be done once at startup.

> -	ret = uda1380_reset(codec);
> -	if (ret < 0) {
> -		dev_err(codec->dev, "Failed to issue reset\n");
> -		goto err_reset;
> -	}
> -

The reason for the reset at startup is that we don't know what state the device
is in when Linux gets control.
