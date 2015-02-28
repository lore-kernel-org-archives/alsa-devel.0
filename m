From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: wm8804: Merge CODEC probe and
	bus probe
Date: Sat, 28 Feb 2015 17:38:01 +0000
Message-ID: <20150228173801.GA6626@opensource.wolfsonmicro.com>
References: <1424623402-473-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1424623402-473-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8112F260413
 for <alsa-devel@alsa-project.org>; Sat, 28 Feb 2015 18:38:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1424623402-473-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Sun, Feb 22, 2015 at 04:43:22PM +0000, Charles Keepax wrote:
> From: Charles Keepax <ckeepax@gmail.com>
> 
> All of the things in the CODEC probe, such as getting the regulators and
> verifying the chip ID, are better done in bus probe. It is better to
> fail during bus probe if this is the wrong chip and all resource
> allocation should be done in the bus probe anyway. This patch merges
> the CODEC probe into bus probe.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm8804.c |  180 ++++++++++++++++++++------------------------
>  1 files changed, 82 insertions(+), 98 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8804.c b/sound/soc/codecs/wm8804.c
> index b5a04fc..1bd4ace 100644
> --- a/sound/soc/codecs/wm8804.c
> +++ b/sound/soc/codecs/wm8804.c
> @@ -182,9 +182,9 @@ static bool wm8804_volatile(struct device *dev, unsigned int reg)
>  	}
>  }
>  
> -static int wm8804_reset(struct snd_soc_codec *codec)
> +static int wm8804_reset(struct wm8804_priv *wm8804)
>  {
> -	return snd_soc_write(codec, WM8804_RST_DEVID1, 0x0);
> +	return regmap_write(wm8804->regmap, WM8804_RST_DEVID1, 0x0);
>  }
>  

<snip>

> +	if (id2 != 0x8805) {
> +		dev_err(dev, "Invalid device ID: %#x\n", id2);
> +		ret = -EINVAL;
> +		goto err_reg_enable;
> +	}
> +
> +	ret = regmap_read(regmap, WM8804_DEVREV, &id1);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to read device revision: %d\n",
> +			ret);
> +		goto err_reg_enable;
> +	}
> +	dev_info(dev, "revision %c\n", id1 + 'A');
> +
> +	ret = wm8804_reset(wm8804);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to issue reset: %d\n", ret);
> +		goto err_reg_enable;
> +	}
> +
>  	return snd_soc_register_codec(dev, &soc_codec_dev_wm8804,
>  				      &wm8804_dai, 1);

Oops... we should goto err_reg_enable if this fails. I will send
a new version on Monday.

> +
> +err_reg_enable:
> +	regulator_bulk_disable(ARRAY_SIZE(wm8804->supplies), wm8804->supplies);
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(wm8804_probe);
>  

Thanks,
Charles
