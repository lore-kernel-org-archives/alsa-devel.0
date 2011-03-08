From: Christian Glindkamp <christian.glindkamp@taskit.de>
Subject: Re: [PATCH] ASoC: Add MAX9850 codec driver
Date: Tue, 8 Mar 2011 12:52:54 +0100
Message-ID: <20110308115254.GD7902@taskit.de>
References: <1299501913-3772-1-git-send-email-christian.glindkamp@taskit.de>
	<20110307134857.GA16691@opensource.wolfsonmicro.com>
	<20110307170420.GC7619@taskit.de>
	<20110308101450.GA11205@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.10])
	by alsa0.perex.cz (Postfix) with ESMTP id D5F0524582
	for <alsa-devel@alsa-project.org>; Tue,  8 Mar 2011 12:56:33 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20110308101450.GA11205@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 2011-03-08 10:14, Dimitris Papastamos wrote:
> On Mon, Mar 07, 2011 at 06:04:20PM +0100, Christian Glindkamp wrote:
> > > > +static const struct snd_soc_dapm_widget max9850_dapm_widgets[] = {
> > > > +SND_SOC_DAPM_DAC("DAC", "HiFi Playback", MAX9850_ENABLE, 0, 0),
> > > > +SND_SOC_DAPM_SUPPLY("MCLK", MAX9850_ENABLE, 6, 0, NULL, 0),
> > > > +SND_SOC_DAPM_OUTPUT("OUTL"),
> > > > +SND_SOC_DAPM_OUTPUT("OUTR"),
> > > > +SND_SOC_DAPM_OUTPUT("HPL"),
> > > > +SND_SOC_DAPM_OUTPUT("HPR"),
> > > > +SND_SOC_DAPM_INPUT("INL"),
> > > > +SND_SOC_DAPM_INPUT("INR"),
> > > > +SND_SOC_DAPM_PGA("Headphone Output", MAX9850_ENABLE, 3, 0, NULL, 0),
> > > > +SND_SOC_DAPM_MIXER("Line Input", SND_SOC_NOPM, 0, 0, NULL, 0),
> > > > +SND_SOC_DAPM_MIXER_NAMED_CTL("Output Mixer", MAX9850_ENABLE, 2, 0,
> > > > +		&max9850_mixer_controls[0],
> > > > +		ARRAY_SIZE(max9850_mixer_controls)),
> > > > +};
> > > 
> > > Consider grouping the input and output pins logically separately.
> > > 
> > 
> > Do you mean something like that?
> > 
> > SND_SOC_DAPM_SUPPLY("MCLK", MAX9850_ENABLE, 6, 0, NULL, 0),
> > SND_SOC_DAPM_MIXER_NAMED_CTL("Output Mixer", MAX9850_ENABLE, 2, 0,
> > 		&max9850_mixer_controls[0],
> > 		ARRAY_SIZE(max9850_mixer_controls)),
> > SND_SOC_DAPM_PGA("Headphone Output", MAX9850_ENABLE, 3, 0, NULL, 0),
> > SND_SOC_DAPM_DAC("DAC", "HiFi Playback", MAX9850_ENABLE, 0, 0),
> > SND_SOC_DAPM_OUTPUT("OUTL"),
> > SND_SOC_DAPM_OUTPUT("HPL"),
> > SND_SOC_DAPM_OUTPUT("OUTR"),
> > SND_SOC_DAPM_OUTPUT("HPR"),
> > SND_SOC_DAPM_MIXER("Line Input", SND_SOC_NOPM, 0, 0, NULL, 0),
> > SND_SOC_DAPM_INPUT("INL"),
> > SND_SOC_DAPM_INPUT("INR"),
> 
> Yea, that's fine.  Although the standard thing to do is to group all
> the input pins at the beginning and all the output pins at the end.
> However this is a pretty primitive codec so it is not a problem as it
> stands now.
>  
> > Charge pump could also be a supply for the Output Mixer. Have to find
> > out how to toggle two bits at once via dapm (preferably without
> > resorting to callbacks).
> 
> If they are in the same register and same type of widgets then as Mark
> mentioned the core guarantees that it'll be done in one register write.
> 
> I forgot to mention in the previous e-mail, that if you add the cache
> syncing support during resume or whenever we go from BIAS_OFF to
> STANDBY use the standard ASoC function for that, snd_soc_cache_sync().
> Just in case you are looking at older examples.
> 

Do I understand it correctly, that all register writes that I do in the
probe function would be overridden by the syncing so they would have to
be moved to the standby code or put into the register cache array as
default values?

> Thanks,
> Dimitris
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
