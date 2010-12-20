From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] ASoC: clean up cache read/write
	functions
Date: Mon, 20 Dec 2010 17:24:05 +0000
Message-ID: <20101220172405.GA2531@rakim.wolfsonmicro.main>
References: <s5hei9czeep.wl%tiwai@suse.de>
	<20101220152709.GJ26706@rakim.wolfsonmicro.main>
	<s5h4oa8zbe4.wl%tiwai@suse.de> <s5h1v5czb5m.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 26B18244B8
	for <alsa-devel@alsa-project.org>; Mon, 20 Dec 2010 18:24:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h1v5czb5m.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 20, 2010 at 05:01:09PM +0100, Takashi Iwai wrote:

> +static int do_hw_write(struct snd_soc_codec *codec, unsigned int reg,
> +                      unsigned int value, void *data, unsigned int size)
> +{
> +       int ret;
> +
> +       if (!snd_soc_codec_volatile_register(codec, reg) &&
> +           reg < codec->driver->reg_cache_size) {
> +               ret = snd_soc_cache_write(codec, reg, value);
> +               if (ret < 0)
> +                       return -1;
> +       }

This isn't actually doing a hardware write, though - it's the entire
write path which may or may not end up at the hardware.  The whole
passing of both the mangled and unmangled versions also feels a bit odd
here.

I think it'd be clearer to do this by making this a plain function and
adding a mangle operation set by the cache types which gets called out
to at the appropriate moment, that'd probably make the code flow more
naturally.

> +static unsigned int snd_soc_4_12_read(struct snd_soc_codec *codec,
> +				      unsigned int reg)
> +{
> +	return do_hw_read(codec, reg);
> +}
> +

>  static unsigned int snd_soc_7_9_read(struct snd_soc_codec *codec,
>  				     unsigned int reg)
>  {
> -	int ret;
> -	unsigned int val;
> -
> -	if (reg >= codec->driver->reg_cache_size ||
> -		snd_soc_codec_volatile_register(codec, reg)) {
> -			if (codec->cache_only)
> -				return -1;
> -
> -			BUG_ON(!codec->hw_read);
> -			return codec->hw_read(codec, reg);
> -	}
> -
> -	ret = snd_soc_cache_read(codec, reg, &val);
> -	if (ret < 0)
> -		return -1;
> -	return val;
> +	return do_hw_read(codec, reg);

If this is OK to do we should just be making do_hw_read() the operation
directly.
