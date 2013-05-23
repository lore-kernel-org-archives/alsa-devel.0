From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 2/2] ASoC: codecs: adau1701: add DT bindings
Date: Thu, 23 May 2013 15:20:50 +0200
Message-ID: <519E17B2.7020304@metafoo.de>
References: <1369310281-4323-1-git-send-email-zonque@gmail.com>
 <1369310281-4323-2-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-099.synserver.de (smtp-out-100.synserver.de
 [212.40.185.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 5923F261A20
 for <alsa-devel@alsa-project.org>; Thu, 23 May 2013 15:21:04 +0200 (CEST)
In-Reply-To: <1369310281-4323-2-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On 05/23/2013 01:58 PM, Daniel Mack wrote:
[...]
> +#ifdef CONFIG_OF
> +static const struct of_device_id adau1701_dt_ids[] = {
> +	{ .compatible = "adi,adau1701", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, adau1701_dt_ids);
> +#endif
> +
>  static int adau1701_probe(struct snd_soc_codec *codec)
>  {
>  	int ret;
> +	struct device *dev = codec->dev;
>  	struct i2c_client *client = to_i2c_client(codec->dev);
> +	int gpio_nreset = -EINVAL;
>  
>  	codec->control_data = client;
>  
> +	if (of_match_device(of_match_ptr(adau1701_dt_ids), dev))

I think just checking for dev->of_node should be simpler.

> +		gpio_nreset = of_get_named_gpio(dev->of_node,
> +						"reset-gpio", 0);

This should check for errors. E.g. we definitely want to handle
-EPROBE_DEFER, but it makes sense to also return an error if the property is
present but something is wrong.

E.g something like
	if (gpio_nreset < 0 && gpio_nreset != -ENOENT)
		return gpio_nreset;

> +
> +	if (gpio_is_valid(gpio_nreset)) {
> +		if (devm_gpio_request_one(codec->dev, gpio_nreset,
> +					  GPIOF_OUT_INIT_LOW,
> +					  "ADAU1701 Reset") < 0)
> +			return -EINVAL;
> +
> +		/* minimum reset time is 20ns */
> +		udelay(1);
> +		gpio_set_value(gpio_nreset, 1);
> +		/* power-up time may be as long as 85ms */
> +		mdelay(85);
> +	}

I think it is better to request the gpio and reset the device in the i2c
probe function.

> +
>  	ret = adau1701_load_firmware(client);
>  	if (ret)
>  		dev_warn(codec->dev, "Failed to load firmware\n");
> @@ -522,6 +552,7 @@ static struct i2c_driver adau1701_i2c_driver = {
>  	.driver = {
>  		.name	= "adau1701",
>  		.owner	= THIS_MODULE,
> +		.of_match_table	= of_match_ptr(adau1701_dt_ids),
>  	},
>  	.probe		= adau1701_i2c_probe,
>  	.remove		= adau1701_i2c_remove,
