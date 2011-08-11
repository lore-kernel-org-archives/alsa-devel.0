From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3.1]ASoC: ad193x: add spi_hw_read,
 fix sysclk and register definition
Date: Thu, 11 Aug 2011 18:23:22 +0900
Message-ID: <1313054602.16663.10.camel@finisterre.wolfsonmicro.main>
References: <CAHG8p1AJ66K8yjiEz3HXv64JB0C4OrCPbCFV+Gu5jQkvB5cibA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4FF5C24397
	for <alsa-devel@alsa-project.org>;
	Thu, 11 Aug 2011 11:23:31 +0200 (CEST)
In-Reply-To: <CAHG8p1AJ66K8yjiEz3HXv64JB0C4OrCPbCFV+Gu5jQkvB5cibA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Scott Jiang <scott.jiang.linux@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-08-11 at 17:04 +0800, Scott Jiang wrote:

> @@ -56,7 +56,7 @@ static int bf5xx_ad193x_hw_params(struct
> snd_pcm_substream *substream,
> 
>  	switch (params_rate(params)) {
>  	case 48000:
> -		clk = 12288000;
> +		clk = 24576000;
>  		break;
>  	}

Whatever this is for it should be a separate change.

> -	reg = (reg & (~AD193X_DAC_WORD_LEN_MASK)) | word_len;
> +	reg = (reg & (~AD193X_DAC_WORD_LEN_MASK))
> +		| (word_len << AD193X_DAC_WORD_LEN_SHFT);
>  	snd_soc_write(codec, AD193X_DAC_CTRL2, reg);
> 
>  	reg = snd_soc_read(codec, AD193X_ADC_CTRL1);

This needs some documentation as it's not clear what it's supposed to
do.

> +#if defined(CONFIG_SPI_MASTER)
> +	/* asoc cache layer can't support this kind of spi registers now */
> +	codec->cache_bypass = 1;
> +#endif

That's not what cache_bypass is for. Just mark the registers as
volatile, or remove the cache entirely.

>  #ifdef CONFIG_SPI_MASTER
>                 codec->hw_write = do_spi_write;
>  #endif
> +               if (io_types[i].spi_read)
> +                       codec->hw_read = io_types[i].spi_read;

So, if we've got an ifdef on the write...
