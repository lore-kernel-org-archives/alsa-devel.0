From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH,
	RFC 2/3] ASoC: UDA1380: register from	board files,
	configure via pdata
Date: Sun, 14 Jun 2009 15:51:28 +0100
Message-ID: <20090614145128.GB4482@sirena.org.uk>
References: <1244976692-5189-1-git-send-email-philipp.zabel@gmail.com>
	<1244976692-5189-2-git-send-email-philipp.zabel@gmail.com>
	<1244976692-5189-3-git-send-email-philipp.zabel@gmail.com>
	<1244976692-5189-4-git-send-email-philipp.zabel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id ED00F243B4
	for <alsa-devel@alsa-project.org>;
	Sun, 14 Jun 2009 16:51:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1244976692-5189-4-git-send-email-philipp.zabel@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Philipp Zabel <philipp.zabel@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Jun 14, 2009 at 12:51:31PM +0200, Philipp Zabel wrote:
> This patch removes the I2C board info registration from the codec driver.
> Instead, device instantiation will be done via global i2c_board_info from
> board files. At the same time, platform specific configuration is moved
> to platform data and common power/reset GPIO handling moves into the
> codec driver.

Thanks for doing this.  This should probably either be squashed in with
the arch patch that follows.

> +struct uda1380_platform_data {
> +	int gpio_power;
> +	int gpio_reset;
> +	int dac_clk;
> +#define UDA1380_DAC_CLK_SYSCLK 0
> +#define UDA1380_DAC_CLK_WSPLL  1

Is it worth changing this to make both options non-zero so that there's
no possibility that it could be left zero by default?

> +static int uda1380_add_i2c_device(struct platform_device *pdev)
>  {

...

>  	ret = i2c_add_driver(&uda1380_i2c_driver);

If you're doing this conversion the ideal thing is to convert the driver
completely so that the driver is registered when the module loads and
does the DAI registration once the I2C device probes.  The I2C device
probe should also do any other initialisation that can be done without
the rest of the ASoC subsystem such as registering the GPIOs.

This implies a bit more rearrangment of the registration functions -
most of the initialisation can stay in the I2C function but anything
that uses the entire ASoC device and the final instantiation of the card
should be moved into the ASoC probe function which will be called once
the entire card has started.  WM8731 is a good template to look at here.

> --- a/sound/soc/codecs/uda1380.h
> +++ b/sound/soc/codecs/uda1380.h
> @@ -8,9 +8,6 @@
>   * Copyright (c) 2005 Giorgio Padrin <giorgio@mandarinlogiq.org>
>   */
>  
> -#ifndef _UDA1380_H
> -#define _UDA1380_H
> -

Best practice would be to keep these with a different name.
