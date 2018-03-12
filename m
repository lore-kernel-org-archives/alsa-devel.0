From: Shreyas NC <shreyas.nc@intel.com>
Subject: Re: [PATCH 2/3] ASoC: Add Multi CPU DAI support for
 PCM ops
Date: Mon, 12 Mar 2018 11:06:15 +0530
Message-ID: <20180312053614.GB2887@snc-desk>
References: <1520334030-8018-1-git-send-email-shreyas.nc@intel.com>
 <1520334030-8018-3-git-send-email-shreyas.nc@intel.com>
 <20180309155358.34d6xo2wip2zodcd@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id D9AD4266E57
 for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2018 06:38:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20180309155358.34d6xo2wip2zodcd@localhost.localdomain>
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

On Fri, Mar 09, 2018 at 09:23:58PM +0530, Charles Keepax wrote:
> On Tue, Mar 06, 2018 at 04:30:29PM +0530, Shreyas NC wrote:
> > This adds support for Multi CPU DAIs in PCM ops and stream
> > handling functions.
> > 
> > Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
> > ---
> > @@ -313,13 +333,17 @@ static int soc_pcm_params_symmetry(struct snd_pcm_substream *substream,
> >  static bool soc_pcm_has_symmetry(struct snd_pcm_substream *substream)
> >  {
> >  	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> > -	struct snd_soc_dai_driver *cpu_driver = rtd->cpu_dai->driver;
> >  	struct snd_soc_dai_link *link = rtd->dai_link;
> > -	unsigned int symmetry, i;
> > +	unsigned int symmetry = 0, i;
> >  
> > -	symmetry = cpu_driver->symmetric_rates || link->symmetric_rates ||
> > -		cpu_driver->symmetric_channels || link->symmetric_channels ||
> > -		cpu_driver->symmetric_samplebits || link->symmetric_samplebits;
> > +	/* Apply symmetery for multiple cpu dais */
> > +	for (i = 0; i < rtd->num_cpu_dai; i++)
> > +		symmetry = rtd->cpu_dais[i]->driver->symmetric_rates ||
> > +						link->symmetric_rates ||
> > +			rtd->cpu_dais[i]->driver->symmetric_channels ||
> > +						link->symmetric_channels ||
> > +			rtd->cpu_dais[i]->driver->symmetric_samplebits ||
> > +						link->symmetric_samplebits;
> 
> No need to bring the link-> stuff into the loop, it won't change
> on each iteration. Would also make the code look neater to leave
> it before the loop.
> 

Sure, makes sense.

> >  
> >  	for (i = 0; i < rtd->num_codecs; i++)
> >  		symmetry = symmetry ||
> > @@ -347,10 +371,10 @@ static void soc_pcm_set_msb(struct snd_pcm_substream *substream, int bits)
> >  static void soc_pcm_apply_msb(struct snd_pcm_substream *substream)
> >  {
> >  	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> > -	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
> > +	struct snd_soc_dai *cpu_dai;
> >  	struct snd_soc_dai *codec_dai;
> >  	int i;
> > -	unsigned int bits = 0, cpu_bits;
> > +	unsigned int bits = 0, cpu_bits = 0;
> >  
> >  	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> >  		for (i = 0; i < rtd->num_codecs; i++) {
> > @@ -361,7 +385,17 @@ static void soc_pcm_apply_msb(struct snd_pcm_substream *substream)
> >  			}
> >  			bits = max(codec_dai->driver->playback.sig_bits, bits);
> >  		}
> > -		cpu_bits = cpu_dai->driver->playback.sig_bits;
> > +
> > +		for (i = 0; i < rtd->num_cpu_dai; i++) {
> > +			cpu_dai = rtd->cpu_dais[i];
> > +			if (cpu_dai->driver->playback.sig_bits == 0) {
> > +				cpu_bits = 0;
> > +				break;
> > +			}
> > +
> > +			cpu_bits = max(
> > +				    cpu_dai->driver->playback.sig_bits,	bits);
> 
> Can help but feel this would look nicer if you only wrapped the
> second argument down a line. Although tbf its only 1 character so
> you could probably just run over the line length as well.
> 

Ok

> > @@ -427,30 +464,41 @@ static void soc_pcm_init_runtime_hw(struct snd_pcm_substream *substream)
> >  		rates = snd_pcm_rate_mask_intersect(codec_stream->rates, rates);
> >  	}
> >  
> > -	/*
> > -	 * chan min/max cannot be enforced if there are multiple CODEC DAIs
> > -	 * connected to a single CPU DAI, use CPU DAI's directly and let
> > -	 * channel allocation be fixed up later
> > -	 */
> > -	if (rtd->num_codecs > 1) {
> > -		chan_min = cpu_stream->channels_min;
> > -		chan_max = cpu_stream->channels_max;
> > -	}
> > +	for (i = 0; i < rtd->num_cpu_dai; i++) {
> > +		cpu_dai_drv = rtd->cpu_dais[i]->driver;
> >  
> > -	hw->channels_min = max(chan_min, cpu_stream->channels_min);
> > -	hw->channels_max = min(chan_max, cpu_stream->channels_max);
> > -	if (hw->formats)
> > -		hw->formats &= formats & cpu_stream->formats;
> > -	else
> > -		hw->formats = formats & cpu_stream->formats;
> > -	hw->rates = snd_pcm_rate_mask_intersect(rates, cpu_stream->rates);
> > +		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> > +			cpu_stream = &cpu_dai_drv->playback;
> > +		else
> > +			cpu_stream = &cpu_dai_drv->capture;
> >  
> > -	snd_pcm_limit_hw_rates(runtime);
> > +		/*
> > +		 * chan min/max cannot be enforced if there are multiple
> > +		 * CODEC DAIs connected to a single CPU DAI, use CPU DAI's
> > +		 * directly and let channel allocation be fixed up later
> > +		 */
> > +		if (rtd->num_codecs > 1) {
> > +			chan_min = cpu_stream->channels_min;
> > +			chan_max = cpu_stream->channels_max;
> > +		}
> > +
> > +		hw->channels_min = max(chan_min, cpu_stream->channels_min);
> > +		hw->channels_max = min(chan_max, cpu_stream->channels_max);
> > +		if (hw->formats)
> > +			hw->formats &= formats & cpu_stream->formats;
> > +		else
> > +			hw->formats = formats & cpu_stream->formats;
> >  
> 
> I don't think actually ends up with the correct values in
> hw->channels_min/max. Nothing compares one iteration of the
> loop to the previous one so you don't end up with the min/max for
> all the CPU DAIs you just end up with the values from the last
> CPU DAI.
> 

Yes, you are right. Thanks for pointing that out :)

> >  /*
> > @@ -465,12 +513,15 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
> >  	struct snd_soc_platform *platform = rtd->platform;
> >  	struct snd_soc_component *component;
> >  	struct snd_soc_rtdcom_list *rtdcom;
> > -	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
> > +	struct snd_soc_dai *cpu_dai;
> >  	struct snd_soc_dai *codec_dai;
> >  	const char *codec_dai_name = "multicodec";
> > -	int i, ret = 0, __ret;
> > +	const char *cpu_dai_name = "multicpu";
> > +	int i, ret = 0, __ret, j;
> > +
> > +	for (i = 0; i < rtd->num_cpu_dai; i++)
> > +		pinctrl_pm_select_default_state(rtd->cpu_dais[i]->dev);
> >  
> > -	pinctrl_pm_select_default_state(cpu_dai->dev);
> >  	for (i = 0; i < rtd->num_codecs; i++)
> >  		pinctrl_pm_select_default_state(rtd->codec_dais[i]->dev);
> >  
> > @@ -483,12 +534,15 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
> >  	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
> >  
> >  	/* startup the audio subsystem */
> > -	if (cpu_dai->driver->ops->startup) {
> > -		ret = cpu_dai->driver->ops->startup(substream, cpu_dai);
> > -		if (ret < 0) {
> > -			dev_err(cpu_dai->dev, "ASoC: can't open interface"
> > -				" %s: %d\n", cpu_dai->name, ret);
> > -			goto out;
> > +	for (i = 0; i < rtd->num_cpu_dai; i++) {
> > +		cpu_dai = rtd->cpu_dais[i];
> > +		if (cpu_dai->driver->ops->startup) {
> > +			ret = cpu_dai->driver->ops->startup(substream, cpu_dai);
> > +			if (ret < 0) {
> > +				dev_err(cpu_dai->dev, "ASoC: can't open interface %s: %d\n",
> > +							cpu_dai->name, ret);
> > +				goto out;
> 
> I don't believe this jumps to the right place anymore since you
> need to shutdown any CPU DAIs you have already started up.
> 

Ok, I will re-visit this and correct it in v2.

> > @@ -1276,8 +1388,12 @@ static snd_pcm_uframes_t soc_pcm_pointer(struct snd_pcm_substream *substream)
> >  		break;
> >  	}
> >  
> > -	if (cpu_dai->driver->ops->delay)
> > -		delay += cpu_dai->driver->ops->delay(substream, cpu_dai);
> > +	for (i = 0; i < rtd->num_cpu_dai; i++) {
> > +		cpu_dai = rtd->cpu_dais[i];
> > +		if (cpu_dai->driver->ops->delay)
> > +			delay += cpu_dai->driver->ops->delay(substream,
> > +								cpu_dai);
> > +	}
> 
> I am not clear we should be adding the delays here can't they all
> run in parallel? In which case shouldn't we be taking the max?
> 

Yes, you are right that we shouldn't be adding the delays and max() would be
a right check.

> > @@ -2998,8 +3139,13 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
> >  				capture = 1;
> >  		}
> >  
> > -		capture = capture && cpu_dai->driver->capture.channels_min;
> > -		playback = playback && cpu_dai->driver->playback.channels_min;
> > +		for (i = 0; i < rtd->num_cpu_dai; i++) {
> > +			cpu_dai = rtd->cpu_dais[i];
> > +			capture = capture &&
> > +					cpu_dai->driver->capture.channels_min;
> > +			playback = playback &&
> > +					cpu_dai->driver->playback.channels_min;
> > +		}
> 
> This doesn't look right either since you will end up with the
> values for the last CPU DAI surely you want some sort of combined
> value.
> 

Yeah, in hindsight it does not make sense. So, I think it would be better to
keep the logic same as above (multiple codec DAI)

> I am also a little nervous about the mapping between widgets and
> DAIs in dpcm_prune_paths. But I don't think I really understand
> that bit of the code well enough to provide good comments.
> Hopefully someone with more understanding than me can have a look
> :-)
> 

Even I am not too sure about this and I followed what is done for codec DAI
which as you suspect may not be the right thing.
Let us wait for others to review :)

--Shreyas
-- 
