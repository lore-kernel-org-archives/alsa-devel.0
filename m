From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 3/4] ASoC: codecs: adau1701: switch to
 direct regmap API usage
Date: Sun, 09 Jun 2013 19:39:32 +0200
Message-ID: <51B4BDD4.4070302@metafoo.de>
References: <1370605987-19290-1-git-send-email-zonque@gmail.com>
 <1370605987-19290-4-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
 (mailhost.informatik.uni-hamburg.de [134.100.9.70])
 by alsa0.perex.cz (Postfix) with ESMTP id 9640E26030F
 for <alsa-devel@alsa-project.org>; Sun,  9 Jun 2013 19:36:11 +0200 (CEST)
In-Reply-To: <1370605987-19290-4-git-send-email-zonque@gmail.com>
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
Cc: alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

[...]
> +
> +static int adau1701_reg_write(void *context, unsigned int reg,
> +			      unsigned int value)
> +{
> +	struct i2c_client *client = context;
>  	unsigned int i;
>  	unsigned int size;
>  	uint8_t buf[4];
>  	int ret;
>  
> -	size = adau1701_register_size(codec, reg);
> +	size = adau1701_register_size(&client->dev, reg);
>  	if (size == 0)
>  		return -EINVAL;
>  
> -	snd_soc_cache_write(codec, reg, value);
> -
>  	buf[0] = 0x08;

This was actually a hack to let the register range start at 0x00. All the
configuration register start at 0x0800. Since we are using regmap now we
shouldn't need this anymore.

>  	buf[1] = reg;
>  
> @@ -166,7 +177,7 @@ static int adau1701_write(struct snd_soc_codec *codec, unsigned int reg,
>  		value >>= 8;
>  	}
>  
> -	ret = i2c_master_send(to_i2c_client(codec->dev), buf, size + 2);
> +	ret = i2c_master_send(client, buf, size + 2);
>  	if (ret == size + 2)
>  		return 0;
>  	else if (ret < 0)
> @@ -175,16 +186,47 @@ static int adau1701_write(struct snd_soc_codec *codec, unsigned int reg,
>  		return -EIO;
>  }
>  
> -static unsigned int adau1701_read(struct snd_soc_codec *codec, unsigned int reg)
> +static int adau1701_reg_read(void *context, unsigned int reg,
> +			     unsigned int *value)
>  {
> -	unsigned int value;
> -	unsigned int ret;
> +	int ret;
> +	unsigned int i;
> +	unsigned int size;
> +	uint8_t send_buf[2], recv_buf[3];
> +	struct i2c_client *client = context;
> +	struct i2c_msg msgs[2] = {
> +		{
> +			.addr	= client->addr,
> +			.len	= sizeof(send_buf),
> +			.buf	= send_buf,
> +		},
> +		{
> +			.addr	= client->addr,
> +			.len	= sizeof(recv_buf),

The length depends on the register size

> +			.buf	= recv_buf,
> +			.flags	= I2C_M_RD | I2C_M_STOP,
> +		},
> +	};
> +
> +	size = adau1701_register_size(&client->dev, reg);
> +	if (size == 0)
> +		return -EINVAL;
>  
> -	ret = snd_soc_cache_read(codec, reg, &value);
> -	if (ret)
> +	send_buf[0] = 0x08;
> +	send_buf[1] = reg;
> +
> +	ret = i2c_transfer(client->adapter, msgs, 2);

ARRAY_SIZE(msgs)

> +	if (ret < 0)
>  		return ret;
> +	else if (ret != 2)

same here

> +		return -EIO;
> +
> +	*value = 0;
> +
> +	for (i = 0; i < size; i++)
> +		*value |= recv_buf[i] << (i * 8);

hm, how about:

	*value <<= 8
	*value |= recv_buf[i];

>  
> -	return value;
> +	return 0;
>  }
[...]
