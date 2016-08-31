From: Danny Milosavljevic <dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org>
Subject: Re: [PATCH v9 2/2] Add mixer controls: Line-In, FM-In,
 Mic 2, Capture Source, Differential Line-In.
Date: Wed, 31 Aug 2016 09:17:59 +0200
Message-ID: <20160831091759.6ba20d1c@scratchpost.org>
References: <20160830054403.7878-1-dannym@scratchpost.org>
	<20160830054403.7878-3-dannym@scratchpost.org>
	<CAGb2v64zA3iSOe7ku=pF0RhJkvErxt_tbPWG4H8D6r5UEUJAMQ@mail.gmail.com>
Reply-To: dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCPKHTHNWIPBBLUJTK7AKGQE4MRRLCA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <CAGb2v64zA3iSOe7ku=pF0RhJkvErxt_tbPWG4H8D6r5UEUJAMQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Hi Chen-Yu,

> > +static const char * const sun4i_codec_difflinein_capture_source[] = {
> > +       "Non-Differential",
> > +       "Differential",  
> 
> How about "Stereo"? And possibly "Mono Differential"? or just "Mono".

> A differential input can be used single-ended by grounding one side.

Yes, but that's interpretation of what it's going to be used for. 
The hardware either subtracts or not, nothing more.
That said, I'll change it to "Stereo" and "Mono Differential".

> > +       SOC_SINGLE_TLV("Line Capture Volume", \
> > +                      SUN4I_CODEC_ADC_ACTL, \
> > +                      SUN4I_CODEC_ADC_ACTL_LNPREG, \
> > +                      7, \
> > +                      0, \
> > +                      sun4i_codec_linein_preamp_gain_scale)  
> 
> Nope. This is a pre-gain or boost. It affects both playback and
> capture. "Line Boost Volume" would be better.

According to Documentation/sound/alsa/ControlNames.txt that is not a valid name.
Also alsa-lib does special things depending on the control name so we are not 
free to choose here. If it were me freely choosing the names then half the
control names in this module would change.

> Same for the Mic pre-amp gain controls.

Likewise. I can see that it's confusing... but what should we do?

> I have a few patches that introduce SOC_DAPM_DOUBLE, so you can share a
> control between left/right channels. IMHO it makes the userspace mixer
> less confusing.

I agree. It would be nice to use this in the future when it's merged.
Will you post it?

> > +       /* MUX */
> > +       SND_SOC_DAPM_MUX("Left Capture Select", SND_SOC_NOPM, 0, 0,
> > +                        &sun4i_codec_capture_source_controls),
> > +       SND_SOC_DAPM_MUX("Right Capture Select", SND_SOC_NOPM, 0, 0,
> > +                        &sun4i_codec_capture_source_controls),
> > +       SND_SOC_DAPM_MUX("Differential Line Capture Switch", SND_SOC_NOPM,
> > +                        0,
> > +                        0,
> > +                        &sun4i_codec_difflinein_capture_source_controls),  
> 
> The proper function suffix is "Route", not "Select".

Indeed. Also for "Differential Line Capture Switch" except for the enum, I suppose.

> > +       /* Inputs */
> >         SND_SOC_DAPM_INPUT("Mic1"),
> > +       SND_SOC_DAPM_INPUT("Mic2"),  
> 
> How about SND_SOC_DAPM_MIC? 

What does it do differently? Seems to use different callback and all.
Is it worth changing an extensively tested patch because of it?

>And what about microphone bias?

The User Manual mentions microphone bias exactly once - in the summary.

Searching for just "bias", there's AC_ADDA_BIAS_CTRL "for DAC/ADC
performance tuning" and AC_DAC_CAL BIASCALI.
Is it one of those? How does it work?

> > +       SND_SOC_DAPM_INPUT("Line Right"),
> > +       SND_SOC_DAPM_INPUT("Line Left"),
> > +       SND_SOC_DAPM_INPUT("FM Right"),
> > +       SND_SOC_DAPM_INPUT("FM Left"),  
> 
> Why the left/right channels? 

Because they exist in hardware.
Also Mic1 and Mic2 are listed as well, so for symmetry.

> You aren't doing anything special for
> them. You could just have one Line and one FM, and have routes to
> left/right mixers.

> >  static struct snd_soc_codec_driver sun7i_codec_codec = {
> >         .component_driver = {
> > -               .controls               = sun7i_codec_controls,
> > -               .num_controls           = ARRAY_SIZE(sun7i_codec_controls),
> > -               .dapm_widgets           = sun4i_codec_codec_dapm_widgets,
> > -               .num_dapm_widgets       = ARRAY_SIZE(sun4i_codec_codec_dapm_widgets),
> > -               .dapm_routes            = sun4i_codec_codec_dapm_routes,
> > -               .num_dapm_routes        = ARRAY_SIZE(sun4i_codec_codec_dapm_routes),
> > +               .controls         = sun7i_codec_controls,
> > +               .num_controls     = ARRAY_SIZE(sun7i_codec_controls),
> > +               .dapm_widgets     = sun4i_codec_codec_dapm_widgets,
> > +               .num_dapm_widgets = ARRAY_SIZE(sun4i_codec_codec_dapm_widgets),
> > +               .dapm_routes      = sun4i_codec_codec_dapm_routes,
> > +               .num_dapm_routes  = ARRAY_SIZE(sun4i_codec_codec_dapm_routes),  
> 
> You should put these changes in the first patch.

Indeed.

Cheers,
   Danny
