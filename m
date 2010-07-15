From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 7/12] wm8940: fix resource reclaim in
 wm8940_register error path
Date: Thu, 15 Jul 2010 09:04:51 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1007150855200.5310@axis700.grange>
References: <1279162147.29294.2.camel@mola> <1279162893.29294.20.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id B807A24598
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Jul 2010 09:04:42 +0200 (CEST)
In-Reply-To: <1279162893.29294.20.camel@mola>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hi Axel

On Thu, 15 Jul 2010, Axel Lin wrote:

> >>From 44c93254e5158e3086c4707148d24746067f6b14 Mon Sep 17 00:00:00 2001
> From: Axel Lin <axel.lin@gmail.com>
> Date: Thu, 15 Jul 2010 10:13:34 +0800
> Subject: [PATCH] wm8940: fix resource reclaim in wm8940_register error path
> 
> This patch fixes the error path in wm8940_register to properly free resources.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Ok, these bugs are real, but let's fix them properly, i.e., release 
resources at the same level, where they have been acquired:

static int register_codec(struct drv_priv *data)
{
	int ret = snd_soc_register_codec();
	if (ret < 0)
		return ret;

	ret = try();
	if (failed)
		goto err;

	...

err:
	snd_soc_unregister_codec();
}

static int probe()
{
	int ret;
	struct drv_priv *data = kzalloc(sizeof(*data), GFP_KERNEL);
	if (!data)
		return -ENOMEM;

	ret = register_codec(data);
	if (ret < 0)
		goto err;

	...

err:
	kfree(data);
	return ret;
}

That is, kfree() belongs to probe() and not to register_codec. This, of 
course, concerns all aour patches, at least those of them, that I have 
seen.

Thanks
Guennadi

> ---
>  sound/soc/codecs/wm8940.c |   22 ++++++++++++++--------
>  1 files changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8940.c b/sound/soc/codecs/wm8940.c
> index e3c4bbf..9673e6f 100644
> --- a/sound/soc/codecs/wm8940.c
> +++ b/sound/soc/codecs/wm8940.c
> @@ -766,7 +766,8 @@ static int wm8940_register(struct wm8940_priv *wm8940,
>  	u16 reg;
>  	if (wm8940_codec) {
>  		dev_err(codec->dev, "Another WM8940 is registered\n");
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto err;
>  	}
>  
>  	INIT_LIST_HEAD(&codec->dapm_widgets);
> @@ -785,7 +786,7 @@ static int wm8940_register(struct wm8940_priv *wm8940,
>  	ret = snd_soc_codec_set_cache_io(codec, 8, 16, control);
>  	if (ret < 0) {
>  		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
> -		return ret;
> +		goto err;
>  	}
>  
>  	memcpy(codec->reg_cache, wm8940_reg_defaults,
> @@ -794,7 +795,7 @@ static int wm8940_register(struct wm8940_priv *wm8940,
>  	ret = wm8940_reset(codec);
>  	if (ret < 0) {
>  		dev_err(codec->dev, "Failed to issue reset\n");
> -		return ret;
> +		goto err;
>  	}
>  
>  	wm8940_dai.dev = codec->dev;
> @@ -803,7 +804,7 @@ static int wm8940_register(struct wm8940_priv *wm8940,
>  
>  	ret = snd_soc_write(codec, WM8940_POWER1, 0x180);
>  	if (ret < 0)
> -		return ret;
> +		goto err;
>  
>  	if (!pdata)
>  		dev_warn(codec->dev, "No platform data supplied\n");
> @@ -811,7 +812,7 @@ static int wm8940_register(struct wm8940_priv *wm8940,
>  		reg = snd_soc_read(codec, WM8940_OUTPUTCTL);
>  		ret = snd_soc_write(codec, WM8940_OUTPUTCTL, reg | pdata->vroi);
>  		if (ret < 0)
> -			return ret;
> +			goto err;
>  	}
>  
>  
> @@ -820,17 +821,22 @@ static int wm8940_register(struct wm8940_priv *wm8940,
>  	ret = snd_soc_register_codec(codec);
>  	if (ret) {
>  		dev_err(codec->dev, "Failed to register codec: %d\n", ret);
> -		return ret;
> +		goto err;
>  	}
>  
>  	ret = snd_soc_register_dai(&wm8940_dai);
>  	if (ret) {
>  		dev_err(codec->dev, "Failed to register DAI: %d\n", ret);
> -		snd_soc_unregister_codec(codec);
> -		return ret;
> +		goto err_codec;
>  	}
>  
>  	return 0;
> +
> +err_codec:
> +	snd_soc_unregister_codec(codec);
> +err:
> +	kfree(wm8940);
> +	return ret;
>  }
>  
>  static void wm8940_unregister(struct wm8940_priv *wm8940)
> -- 
> 1.5.4.3
> 
> 
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
