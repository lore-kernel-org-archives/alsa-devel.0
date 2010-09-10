From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/4] ASoC: tlv320aic3x: Add runtime
 regulator control to aic3x_set_bias_level
Date: Fri, 10 Sep 2010 12:47:17 +0100
Message-ID: <20100910114717.GI7259@rakim.wolfsonmicro.main>
References: <1284117812-8618-1-git-send-email-jhnikula@gmail.com>
	<1284117812-8618-2-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9494B1039B4
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Sep 2010 13:47:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1284117812-8618-2-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 10, 2010 at 02:23:30PM +0300, Jarkko Nikula wrote:

> This patch manages all the regulators and reset since it seems that register
> sync is needed even if only analog supplies AVDD and DRVDD are disabled.
> This was noted when the system was running with idle behavior changed and
> IOVDD and DVDD were on.

This is normal, chips normally require all the core supplies to be
enabled to take them out of reset.

> @@ -151,7 +153,8 @@ static int aic3x_write(struct snd_soc_codec *codec, unsigned int reg,
>  	data[1] = value & 0xff;
>  
>  	aic3x_write_reg_cache(codec, data[0], data[1]);
> -	if (codec->hw_write(codec->control_data, data, 2) == 2)
> +	if (!aic3x->power ||
> +	    codec->hw_write(codec->control_data, data, 2) == 2)
>  		return 0;
>  	else
>  		return -EIO;

If you were using the soc-core stuff you'd be able to use the cache_only
flag in the CODEC to do this.  It might make sense to still use the flag
so that when someone converts the driver to use soc-cache this doesn't
get missed.

>  static int aic3x_read(struct snd_soc_codec *codec, unsigned int reg,
>  		      u8 *value)
>  {
> +	struct aic3x_priv *aic3x = snd_soc_codec_get_drvdata(codec);
>  	*value = reg & 0xff;
>  
> -	value[0] = i2c_smbus_read_byte_data(codec->control_data, value[0]);
> +	if (aic3x->power) {
> +		value[0] = i2c_smbus_read_byte_data(codec->control_data,
> +						    value[0]);
> +		aic3x_write_reg_cache(codec, reg, *value);
> +	} else {
> +		value[0] = aic3x_read_reg_cache(codec, reg);
> +	}
>  
> -	aic3x_write_reg_cache(codec, reg, *value);
>  	return 0;
>  }

This seems fishy - surely the read should be being satisfied from cache
all the time if it can be, and if the register does need to be read from
the hardware due to being volatile then it's an error to read it while
powered off?
