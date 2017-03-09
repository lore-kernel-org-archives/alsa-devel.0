From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH for-4.11] ASoC: don't dereference NULL pcm_{new,free}
Date: Wed, 8 Mar 2017 16:21:30 -0800
Message-ID: <20170309002129.GA99773@google.com>
References: <20170308231854.50167-1-briannorris@chromium.org>
 <87zigvz4q3.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87zigvz4q3.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Kuninori,

On Thu, Mar 09, 2017 at 12:17:41AM +0000, Kuninori Morimoto wrote:
> > Not all platform drivers have pcm_{new,free} callbacks. Seen with a
> > "snd-soc-dummy" codec from sound/soc/rockchip/rk3399_gru_sound.c.
> (snip)
> > Fixes: 99b04f4c4051 ("ASoC: add Component level pcm_new/pcm_free")
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > ---
> > I'm really not that familiar with this subsystem... but this does fix the
> > crash seen here.
> > 
> >  sound/soc/soc-core.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> > index 6dca408faae3..2722bb0c5573 100644
> > --- a/sound/soc/soc-core.c
> > +++ b/sound/soc/soc-core.c
> > @@ -3326,7 +3326,10 @@ static int snd_soc_platform_drv_pcm_new(struct snd_soc_pcm_runtime *rtd)
> >  {
> >  	struct snd_soc_platform *platform = rtd->platform;
> >  
> > -	return platform->driver->pcm_new(rtd);
> > +	if (platform->driver->pcm_new)
> > +		return platform->driver->pcm_new(rtd);
> > +	else
> > +		return 0;
> >  }
> >  
> >  static void snd_soc_platform_drv_pcm_free(struct snd_pcm *pcm)
> > @@ -3334,7 +3337,8 @@ static void snd_soc_platform_drv_pcm_free(struct snd_pcm *pcm)
> >  	struct snd_soc_pcm_runtime *rtd = pcm->private_data;
> >  	struct snd_soc_platform *platform = rtd->platform;
> >  
> > -	platform->driver->pcm_free(pcm);
> > +	if (platform->driver->pcm_free)
> > +		platform->driver->pcm_free(pcm);
> >  }
> 
> It is a littlle bit strange for me.

Yes, and honestly I'm a little confused by the inheritance in this
framework.

> commit 99b04f4c4051 has below code. This means, if platform doesn't have pcm_new/free callback,
> component doesn't have snd_soc_platform_drv_pcm_new/free.
> But your case, platform doesn't have pcm_new/free, but component had it ?

I have a feeling you're checking the wrong thing below for this case.
All I know is that I'm definitely hitting a NULL
platform->driver->pcm_new callback, and that either reverting your patch
or applying the patch I just sent fixes it.

Brian

> ...
> @@ -3181,6 +3198,10 @@ int snd_soc_add_platform(struct device *dev, struct snd_soc_platform *platform,
>  		platform->component.probe = snd_soc_platform_drv_probe;
>  	if (platform_drv->remove)
>  		platform->component.remove = snd_soc_platform_drv_remove;
> +	if (platform_drv->pcm_new)
> +		platform->component.pcm_new = snd_soc_platform_drv_pcm_new;
> +	if (platform_drv->pcm_free)
> +		platform->component.pcm_free = snd_soc_platform_drv_pcm_free;
>  
>  #ifdef CONFIG_DEBUG_FS
>  	platform->component.debugfs_prefix = "platform";
