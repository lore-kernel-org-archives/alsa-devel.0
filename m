From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [RFC_i/iv 1/3] ASoC: Decouple DAPM from CODECs.
 Part core (will be squashed)
Date: Sat, 30 Oct 2010 19:01:54 +0100
Message-ID: <1288461714.3286.143.camel@odin>
References: <1288353618-21753-1-git-send-email-jhnikula@gmail.com>
	<1288353618-21753-2-git-send-email-jhnikula@gmail.com>
	<20101029200428.GD3921@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 394892448B
	for <alsa-devel@alsa-project.org>;
	Sat, 30 Oct 2010 20:02:03 +0200 (CEST)
Received: by wye20 with SMTP id 20so4276522wye.38
	for <alsa-devel@alsa-project.org>; Sat, 30 Oct 2010 11:02:02 -0700 (PDT)
In-Reply-To: <20101029200428.GD3921@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-10-29 at 13:04 -0700, Mark Brown wrote:
> On Fri, Oct 29, 2010 at 03:00:16PM +0300, Jarkko Nikula wrote:
> 
> >  	codec->debugfs_pop_time = debugfs_create_u32("dapm_pop_time", 0644,
> >  						     codec->debugfs_codec_root,
> > -						     &codec->pop_time);
> > +						     &codec->dapm->pop_time);
> 
> The pop time feels like it should have an effect over the full card
> rather than over individual CODECs - the power sequencing is obviously
> going to be done over the entire card rather than individual devices so
> it's a little unclear how competing values for different devices would
> be applied.  This is a simple code motion patch and this is only debugfs
> but perhaps it's worth first doing this as a split which moves the pop
> time onto the card.
> 
> >  	for (i = 0; i < card->num_rtd; i++) {
> >  		run_delayed_work(&card->rtd[i].delayed_work);
> > -		card->rtd[i].codec->suspend_bias_level = card->rtd[i].codec->bias_level;
> > +		card->rtd[i].codec->dapm->suspend_bias_level = card->rtd[i].codec->dapm->bias_level;
> 
> Hrm, this is going to miss out devices that don't have a DAI (and run
> multiple times on devices that do have a DAI, which is unfortunate).

Ah, I think we may be missing a later patch here that did add a DAPM
context to card and platform.

Btw, not sure what you mean by this 1 line change being run multiple
times being different to the old line.

> 
> > @@ -2957,6 +2957,21 @@ static inline char *fmt_multiple_name(struct device *dev,
> >  	return kstrdup(dai_drv->name, GFP_KERNEL);
> >  }
> >  
> > +static struct snd_soc_dapm_context *soc_new_dapm_context(struct device *dev)
> > +{
> > +	struct snd_soc_dapm_context *dapm;
> > +
> > +	dapm = kzalloc(sizeof(struct snd_soc_dapm_context), GFP_KERNEL);
> > +	if (dapm) {
> > +		INIT_LIST_HEAD(&dapm->widgets);
> > +		INIT_LIST_HEAD(&dapm->paths);
> > +		dapm->bias_level = SND_SOC_BIAS_OFF;
> > +		dapm->dev = dev;
> > +	}
> > +	return dapm;
> 
> I'd be more inclined to just embed the struct in the objects that need
> it rather than individually allocating them - it saves error checking
> and deallocation, and I can't see any cases where we'd want to
> optionally have a DAPM object.

Yeah, the reason for this is because it was unclear at the time whether
we will need to share a context between DAI backend and frontends. So
this can be embedded now.

> 
> >  	if (ret == 0) {
> > -		if (codec->driver->set_bias_level)
> > -			ret = codec->driver->set_bias_level(codec, level);
> > +		if (dapm->codec && dapm->codec->driver->set_bias_level)
> > +			ret = dapm->codec->driver->set_bias_level(dapm->codec, level);
> >  		else
> > -			codec->bias_level = level;
> > +			dapm->bias_level = level;
> 
> This is all feeling like the DAPM object needs a vtable to do this
> indirection to the operation on the individual object types.
> 
> >  	/* If we're changing to all on or all off then prepare */
> > -	if ((sys_power && codec->bias_level == SND_SOC_BIAS_STANDBY) ||
> > -	    (!sys_power && codec->bias_level == SND_SOC_BIAS_ON)) {
> > -		ret = snd_soc_dapm_set_bias_level(card, codec, SND_SOC_BIAS_PREPARE);
> > +	if ((sys_power && dapm->bias_level == SND_SOC_BIAS_STANDBY) ||
> > +	    (!sys_power && dapm->bias_level == SND_SOC_BIAS_ON)) {
> > +		ret = snd_soc_dapm_set_bias_level(card, dapm, SND_SOC_BIAS_PREPARE);
> 
> So, this is all going to be run per DAPM object from the looks of
> things.  That's really not what we want - we want to be doing the
> sequencing over all DAPM objects in the card, rather than per DAPM
> object.  It'll need to be fixed at some point later in the series...

I should just add that Jarkko picked this up as work in progress, with
some of the details requiring completion or cleanup. 

Liam

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
