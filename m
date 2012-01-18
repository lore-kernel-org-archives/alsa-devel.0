From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: add driver for max9768 amplifier
Date: Wed, 18 Jan 2012 17:53:05 +0000
Message-ID: <20120118175305.GR8732@opensource.wolfsonmicro.com>
References: <1326901108-3435-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C556C244D5
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2012 18:53:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1326901108-3435-1-git-send-email-w.sang@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 18, 2012 at 04:38:28PM +0100, Wolfram Sang wrote:

> +static int max9768_write(struct snd_soc_codec *codec, unsigned int reg,
> +		unsigned int value)

Use regmap for register I/O please.

> +	data = (reg << 6) | value;
> +	ret = i2c_smbus_write_byte(codec->control_data, data);

You may need to add a new register format, but that shouldn't be too
much work.

> +	if (max9768->flags & MAX9768_FLAG_CLASSIC_PWM) {
> +		ret = snd_soc_write(codec, MAX9768_CTRL, MAX9768_CTRL_PWM);
> +		if (ret)
> +			return ret;
> +	}

Some documentation on what this does would be nice.  Is this something
that might usefully be changed at runtime?

> +	ret = snd_soc_add_controls(codec, max9768_volume,
> +			ARRAY_SIZE(max9768_volume));
> +	if (ret)
> +		return ret;

Use the controls field in the driver.  I'd also expect to see some sort
of DAPM support, even if it's just mapping out the pins.  Since you're
manually controlling the mute it'd be nice to make the unmute be (mute
&& power) to save on pops and clicks from the CODEC being amplified.

> +		err = gpio_request_one(pdata->mute_gpio, GPIOF_INIT_HIGH, "MAX9768 Mute");
> +		max9768->mute_gpio = err ?: pdata->mute_gpio;

I really don't like the ternery operator at the best of times...
