From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/4] ASoC: soc-cache: Add support for flat
 register caching
Date: Fri, 05 Nov 2010 09:34:37 +0000
Message-ID: <1288949677.8256.14.camel@dplaptop>
References: <1288880564-31957-1-git-send-email-dp@opensource.wolfsonmicro.com>
	<1288880564-31957-3-git-send-email-dp@opensource.wolfsonmicro.com>
	<20101104183140.GD6088@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 03ECF24368
	for <alsa-devel@alsa-project.org>; Fri,  5 Nov 2010 10:34:40 +0100 (CET)
In-Reply-To: <20101104183140.GD6088@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-11-04 at 14:31 -0400, Mark Brown wrote:

> > @@ -680,6 +722,8 @@ int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
> >  		return -EINVAL;
> >  	}
> >  
> > +	mutex_init(&cache_rw_mutex);
> > +
> 
> I'd kind of expect this to be with the other cache setup?

Do you mean that the mutex should also be used with the other caching
techniques?  That is not needed because we currently lock at a higher
level, in the function that delegates the calls to the implementation
functions.

> > @@ -3261,6 +3244,16 @@ int snd_soc_register_codec(struct device *dev,
> >  	INIT_LIST_HEAD(&codec->dapm_widgets);
> >  	INIT_LIST_HEAD(&codec->dapm_paths);
> >  
> > +	/* allocate CODEC register cache */
> > +	if (codec_drv->reg_cache_size && codec_drv->reg_word_size) {
> > +		ret = snd_soc_cache_init(codec);
> > +		if (ret < 0) {
> > +			dev_err(codec->dev, "Failed to set cache compression type: %d\n",
> > +				ret);
> > +			goto error_cache;
> > +		}
> > +	}
> 
> Are you sure that all the CODECs that rely on the existing shared
> register cache are going to call this?

What do you mean by 'shared register cache'?  Each codec gets its own
copy of their register cache.

Any CODEC driver that calls snd_soc_register_codec() and has provided
reg_cache_size and reg_word_size will have soc-core setting up its cache
accordingly.  By default the provided snd_soc_codec_driver is zero-ed
out, so its compress_type will default to the flat compression type.

Thanks,
Dimitrios
