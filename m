From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Add MAX9850 codec driver
Date: Tue, 8 Mar 2011 10:14:50 +0000
Message-ID: <20110308101450.GA11205@opensource.wolfsonmicro.com>
References: <1299501913-3772-1-git-send-email-christian.glindkamp@taskit.de>
	<20110307134857.GA16691@opensource.wolfsonmicro.com>
	<20110307170420.GC7619@taskit.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EA9642455E
	for <alsa-devel@alsa-project.org>; Tue,  8 Mar 2011 11:14:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20110307170420.GC7619@taskit.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Christian Glindkamp <christian.glindkamp@taskit.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 07, 2011 at 06:04:20PM +0100, Christian Glindkamp wrote:
> > > +static const struct snd_soc_dapm_widget max9850_dapm_widgets[] = {
> > > +SND_SOC_DAPM_DAC("DAC", "HiFi Playback", MAX9850_ENABLE, 0, 0),
> > > +SND_SOC_DAPM_SUPPLY("MCLK", MAX9850_ENABLE, 6, 0, NULL, 0),
> > > +SND_SOC_DAPM_OUTPUT("OUTL"),
> > > +SND_SOC_DAPM_OUTPUT("OUTR"),
> > > +SND_SOC_DAPM_OUTPUT("HPL"),
> > > +SND_SOC_DAPM_OUTPUT("HPR"),
> > > +SND_SOC_DAPM_INPUT("INL"),
> > > +SND_SOC_DAPM_INPUT("INR"),
> > > +SND_SOC_DAPM_PGA("Headphone Output", MAX9850_ENABLE, 3, 0, NULL, 0),
> > > +SND_SOC_DAPM_MIXER("Line Input", SND_SOC_NOPM, 0, 0, NULL, 0),
> > > +SND_SOC_DAPM_MIXER_NAMED_CTL("Output Mixer", MAX9850_ENABLE, 2, 0,
> > > +		&max9850_mixer_controls[0],
> > > +		ARRAY_SIZE(max9850_mixer_controls)),
> > > +};
> > 
> > Consider grouping the input and output pins logically separately.
> > 
> 
> Do you mean something like that?
> 
> SND_SOC_DAPM_SUPPLY("MCLK", MAX9850_ENABLE, 6, 0, NULL, 0),
> SND_SOC_DAPM_MIXER_NAMED_CTL("Output Mixer", MAX9850_ENABLE, 2, 0,
> 		&max9850_mixer_controls[0],
> 		ARRAY_SIZE(max9850_mixer_controls)),
> SND_SOC_DAPM_PGA("Headphone Output", MAX9850_ENABLE, 3, 0, NULL, 0),
> SND_SOC_DAPM_DAC("DAC", "HiFi Playback", MAX9850_ENABLE, 0, 0),
> SND_SOC_DAPM_OUTPUT("OUTL"),
> SND_SOC_DAPM_OUTPUT("HPL"),
> SND_SOC_DAPM_OUTPUT("OUTR"),
> SND_SOC_DAPM_OUTPUT("HPR"),
> SND_SOC_DAPM_MIXER("Line Input", SND_SOC_NOPM, 0, 0, NULL, 0),
> SND_SOC_DAPM_INPUT("INL"),
> SND_SOC_DAPM_INPUT("INR"),

Yea, that's fine.  Although the standard thing to do is to group all
the input pins at the beginning and all the output pins at the end.
However this is a pretty primitive codec so it is not a problem as it
stands now.
 
> Charge pump could also be a supply for the Output Mixer. Have to find
> out how to toggle two bits at once via dapm (preferably without
> resorting to callbacks).

If they are in the same register and same type of widgets then as Mark
mentioned the core guarantees that it'll be done in one register write.

I forgot to mention in the previous e-mail, that if you add the cache
syncing support during resume or whenever we go from BIAS_OFF to
STANDBY use the standard ASoC function for that, snd_soc_cache_sync().
Just in case you are looking at older examples.

Thanks,
Dimitris
