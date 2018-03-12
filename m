From: Shreyas NC <shreyas.nc@intel.com>
Subject: Re: [PATCH 1/3] ASoC: Add initial support for multiple
 CPU DAIs
Date: Mon, 12 Mar 2018 10:32:57 +0530
Message-ID: <20180312050256.GA2887@snc-desk>
References: <1520334030-8018-1-git-send-email-shreyas.nc@intel.com>
 <1520334030-8018-2-git-send-email-shreyas.nc@intel.com>
 <20180309145043.lmdw5r3x7rhplk6x@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 18085266E77
 for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2018 06:05:12 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20180309145043.lmdw5r3x7rhplk6x@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>, Patches Audio <patches.audio@intel.com>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "broonie@kernel.org" <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Thanks for the review,

On Fri, Mar 09, 2018 at 08:20:43PM +0530, Charles Keepax wrote:
> > @@ -679,13 +687,17 @@ int snd_soc_suspend(struct device *dev)
> >  		card->suspend_pre(card);
> >  
> >  	list_for_each_entry(rtd, &card->rtd_list, list) {
> > -		struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
> > +		struct snd_soc_dai *cpu_dai;
> >  
> >  		if (rtd->dai_link->ignore_suspend)
> >  			continue;
> >  
> > -		if (cpu_dai->driver->suspend && !cpu_dai->driver->bus_control)
> > -			cpu_dai->driver->suspend(cpu_dai);
> > +		for (i = 0; i < rtd->num_cpu_dai; i++) {
> > +			cpu_dai = rtd->cpu_dais[i];
> > +			if (cpu_dai->driver->suspend &&
> > +					!cpu_dai->driver->bus_control)
> > +				cpu_dai->driver->suspend(cpu_dai);
> > +		}
> >  	}
> >  
> >  	/* close any waiting streams */
> > @@ -793,13 +805,18 @@ static void soc_resume_deferred(struct work_struct *work)
> 
> Is there not another call to cpu_dai->driver->suspend at the
> bottom of snd_soc_suspend you need to handle?
> 

Yes. Thanks for pointing out :)

> > @@ -1680,9 +1760,11 @@ static int soc_probe_link_dais(struct snd_soc_card *card,
> >  	/* set default power off timeout */
> >  	rtd->pmdown_time = pmdown_time;
> >  
> > -	ret = soc_probe_dai(cpu_dai, order);
> > -	if (ret)
> > -		return ret;
> > +	for (i = 0; i < rtd->num_cpu_dai; i++) {
> > +		ret = soc_probe_dai(rtd->cpu_dais[i], order);
> > +		if (ret)
> > +			return ret;
> > +	}
> >  
> >  	/* probe the CODEC DAI */
> >  	for (i = 0; i < rtd->num_codecs; i++) {
> > @@ -1718,9 +1800,9 @@ static int soc_probe_link_dais(struct snd_soc_card *card,
> >  		soc_dpcm_debugfs_add(rtd);
> >  #endif
> >  
> > -	if (cpu_dai->driver->compress_new) {
> > +	if (rtd->cpu_dais[0]->driver->compress_new) {
> >  		/*create compress_device"*/
> > -		ret = cpu_dai->driver->compress_new(rtd, rtd->num);
> > +		ret = rtd->cpu_dais[0]->driver->compress_new(rtd, rtd->num);
> >  		if (ret < 0) {
> >  			dev_err(card->dev, "ASoC: can't create compress %s\n",
> >  					 dai_link->stream_name);
> 
> Is it worth throwing an error or printing a warning to say that
> we don't support multiple DAIs on the compressed framework? Not
> sure if here is were we should do that though.
> 

Sure, makes sense. Let me check the right place to add that.

> > @@ -1736,7 +1818,8 @@ static int soc_probe_link_dais(struct snd_soc_card *card,
> >  				       dai_link->stream_name, ret);
> >  				return ret;
> >  			}
> > -			ret = soc_link_dai_pcm_new(&cpu_dai, 1, rtd);
> > +			ret = soc_link_dai_pcm_new(rtd->cpu_dais,
> > +					rtd->num_cpu_dai, rtd);
> >  			if (ret < 0)
> >  				return ret;
> >  			ret = soc_link_dai_pcm_new(rtd->codec_dais,
> > @@ -2361,10 +2444,11 @@ int snd_soc_poweroff(struct device *dev)
> 
> Do we need to update the handling in snd_soc_runtime_set_dai_fmt?
> Seems like we skipped over that.
> 

Yes, that is a miss as well :(
Thanks for pointing out, I'll fix and send v2.

--Shreyas

-- 
