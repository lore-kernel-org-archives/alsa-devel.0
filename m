From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: pcm512x: Add PCM512x driver
Date: Thu, 06 Feb 2014 14:24:07 +0100
Message-ID: <52F38CF7.7060306@metafoo.de>
References: <1391689575-4039-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1391689575-4039-1-git-send-email-broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Florian Meier <florian.meier-oZ8rN/sblLk@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On 02/06/2014 01:26 PM, Mark Brown wrote:
[...]
> +static const char *pcm512x_dsp_program_texts[] = {

Nitpick: should be "static const char * const ...", a immutable array of 
pointers pointing to immutable strings. Same for all the enum texts in this 
driver.
[...]
> +static int __init pcm512x_modinit(void)
> +{
> +	int ret = 0;
> +
> +#if IS_ENABLED(CONFIG_I2C)
> +	ret = i2c_add_driver(&pcm512x_i2c_driver);
> +	if (ret) {
> +		printk(KERN_ERR "Failed to register pcm512x I2C driver: %d\n",
> +		       ret);
> +	}
> +#endif
> +#if defined(CONFIG_SPI_MASTER)
> +	ret = spi_register_driver(&pcm512x_spi_driver);
> +	if (ret != 0) {
> +		printk(KERN_ERR "Failed to register pcm512x SPI driver: %d\n",
> +		       ret);
> +	}
> +#endif

Another reason why I think it is better to separate the I2C and SPI bits 
into different modules. If the registration of the SPI driver fails you'll 
return an error and the module will not be loaded. At the same time the i2c 
driver is already registered. I know that this is rather theoretical, but if 
we don't care if our error handling is correct, because we assume that the 
error will never happen, we do not need error handling at all.

> +	return ret;
> +}
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
