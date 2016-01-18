From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: pcm179x: Split into core and SPI parts
Date: Mon, 18 Jan 2016 20:59:30 +0100
Message-ID: <20160118195930.GA26804@localhost>
References: <1453132657-18678-1-git-send-email-jacob@teenage.engineering>
 <1453132657-18678-2-git-send-email-jacob@teenage.engineering>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1453132657-18678-2-git-send-email-jacob@teenage.engineering>
Sender: linux-kernel-owner@vger.kernel.org
To: Jacob Siverskog <jacob@teenage.engineering>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Michael Trimarchi <michael@amarulasolutions.com>, Johan Hovold <johan@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 18, 2016 at 04:57:35PM +0100, Jacob Siverskog wrote:
> The pcm179x family supports both SPI and I2C for configuration. This
> patch splits the driver into core and SPI parts, in preparation for
> I2C support.
> 
> Reviewed-by: Johan Hovold <johan@kernel.org>
> Signed-off-by: Jacob Siverskog <jacob@teenage.engineering>
> ---

> +const struct of_device_id pcm179x_of_match[] = {

Missing static keyword.

> +	{ .compatible = "ti,pcm1792a", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, pcm179x_of_match);
 
> -static int pcm179x_spi_probe(struct spi_device *spi)
> +int pcm179x_common_init(struct pcm179x_private *priv)
>  {
> -	struct pcm179x_private *pcm179x;
> -	int ret;
> -
> -	pcm179x = devm_kzalloc(&spi->dev, sizeof(struct pcm179x_private),
> -				GFP_KERNEL);
> -	if (!pcm179x)
> -		return -ENOMEM;
> -
> -	spi_set_drvdata(spi, pcm179x);
> -
> -	pcm179x->regmap = devm_regmap_init_spi(spi, &pcm179x_regmap);
> -	if (IS_ERR(pcm179x->regmap)) {
> -		ret = PTR_ERR(pcm179x->regmap);
> -		dev_err(&spi->dev, "Failed to register regmap: %d\n", ret);
> -		return ret;
> -	}
> -
> -	return snd_soc_register_codec(&spi->dev,
> +	return snd_soc_register_codec(priv->dev,
>  			&soc_codec_dev_pcm179x, &pcm179x_dai, 1);
>  }
>  
> -static int pcm179x_spi_remove(struct spi_device *spi)
> +int pcm179x_common_exit(struct pcm179x_private *priv)
>  {
> -	snd_soc_unregister_codec(&spi->dev);
> +	snd_soc_unregister_codec(priv->dev);
>  	return 0;
>  }

And missing EXPORT_SYMBOL_GPL for these two.

That should take care of the 0-day build-test errors.

Thanks,
Johan
