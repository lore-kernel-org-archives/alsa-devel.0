From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/4] ASoC: soc-cache: Add support for flat
 register caching
Date: Thu, 4 Nov 2010 14:31:40 -0400
Message-ID: <20101104183140.GD6088@opensource.wolfsonmicro.com>
References: <1288880564-31957-1-git-send-email-dp@opensource.wolfsonmicro.com>
	<1288880564-31957-3-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 23CE524407
	for <alsa-devel@alsa-project.org>; Thu,  4 Nov 2010 19:31:32 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1288880564-31957-3-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 04, 2010 at 02:22:42PM +0000, Dimitris Papastamos wrote:

> This patch introduces the new caching API and migrates the
> old caching interface into the new one.  The flat register caching
> technique does not use compression at all and it is equivalent to

Looks good - probably the main thing I'm asking for with the single
patches is to do stuff like squashing the first patch into this.

> @@ -680,6 +722,8 @@ int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
>  		return -EINVAL;
>  	}
>  
> +	mutex_init(&cache_rw_mutex);
> +

I'd kind of expect this to be with the other cache setup?  I'd also
expect the lock to be a member variable next to the cache, rather than a
global.  Probably not a big deal but still nicer.

> +			switch (codec_drv->reg_word_size) {

...

> +			default:
> +				return -EINVAL;
> +			}

I'd kind of expect these to be BUG() so we don't silently fall back to
direct I/O if the cache support isn't implemented at all.

> +static int snd_soc_flat_cache_init(struct snd_soc_codec *codec)
> +{
> +	struct snd_soc_codec_driver *codec_drv;
> +	size_t reg_size;
> +
> +	codec_drv = codec->driver;
> +	reg_size = codec_drv->reg_cache_size * codec_drv->reg_word_size;
> +
> +	if (codec_drv->reg_cache_default)
> +		codec->reg_cache = kmemdup(codec_drv->reg_cache_default,
> +					   reg_size, GFP_KERNEL);
> +	else
> +		codec->reg_cache = kzalloc(reg_size, GFP_KERNEL);
> +	if (!codec->reg_cache)
> +		return -EINVAL;

-ENOMEM.

> +int snd_soc_cache_init(struct snd_soc_codec *codec)
> +{

> +EXPORT_SYMBOL_GPL(snd_soc_cache_init);

Does this need to be exported?  Right now the only caller is in the
core.

> @@ -3261,6 +3244,16 @@ int snd_soc_register_codec(struct device *dev,
>  	INIT_LIST_HEAD(&codec->dapm_widgets);
>  	INIT_LIST_HEAD(&codec->dapm_paths);
>  
> +	/* allocate CODEC register cache */
> +	if (codec_drv->reg_cache_size && codec_drv->reg_word_size) {
> +		ret = snd_soc_cache_init(codec);
> +		if (ret < 0) {
> +			dev_err(codec->dev, "Failed to set cache compression type: %d\n",
> +				ret);
> +			goto error_cache;
> +		}
> +	}

Are you sure that all the CODECs that rely on the existing shared
register cache are going to call this?
