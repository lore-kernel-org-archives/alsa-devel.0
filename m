From: Richard Fitzgerald <rf-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH 7/8] ASoC: wm8998: Initial WM8998 codec driver
Date: Thu, 23 Apr 2015 15:28:23 +0100
Message-ID: <20150423142823.GB17323@opensource.wolfsonmicro.com>
References: <1429619636-25478-1-git-send-email-rf@opensource.wolfsonmicro.com> <1429619636-25478-8-git-send-email-rf@opensource.wolfsonmicro.com> <20150422110030.GQ22845@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150422110030.GQ22845-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 22, 2015 at 12:00:30PM +0100, Mark Brown wrote:
> On Tue, Apr 21, 2015 at 01:33:55PM +0100, Richard Fitzgerald wrote:
> 
> > +static int wm8998_in1mux_ev(struct snd_soc_dapm_widget *w,
> > +				struct snd_kcontrol *kcontrol,
> > +				int event)
> > +{
> > +	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
> > +	struct arizona *arizona = dev_get_drvdata(codec->dev->parent);
> > +	unsigned int left_mux, right_mux, in1mode, old;
> > +
> > +	switch (event) {
> > +	case SND_SOC_DAPM_PRE_PMU:
> > +		/* Validate the mux configuration */
> > +		left_mux = snd_soc_read(codec, ARIZONA_ADC_DIGITAL_VOLUME_1L) &
> > +				  ARIZONA_IN1L_SRC_MASK;
> > +		right_mux = snd_soc_read(codec, ARIZONA_ADC_DIGITAL_VOLUME_1R) &
> > +				  ARIZONA_IN1R_SRC_MASK;
> > +
> > +		/* Only IN1A can be digital, IN1B is always analogue */
> > +		in1mode = (arizona->pdata.inmode[0] & 2)
> > +				<< (ARIZONA_IN1_MODE_SHIFT - 1);
> > +
> > +		if (in1mode != 0) {
> > +			/* if IN1A is digital, the only valid mux configs
> > +			 * are both channels A or both channels B.
> > +			 */
> > +			if (left_mux != right_mux) {
> > +				dev_err(arizona->dev,
> > +					"IN1=DMIC and IN1L Mux != IN1R Mux");
> > +				return -EINVAL;
> > +			}
> 
> This (or at least some of it) seems like something we should be doing by
> registering different widgets and routing at device probe time.

I'm not sure this is really a routing or widget problem. Problem is that
if the muxed inputs are analogue we need to provide separate ALSA controls
for the left and right mux because it is allowed to use them as two
independant mono channels with separate muxing. But if they are
configured as digital the mux controls are ganged so must be set the
same. I don't feel good about registering a single mux control if its
digital and two if its analogue because that means the codec's control
list depends on a pdata option. I could implement the control pair
so that if the input is digital changing one control always changes
the other so they will always be forced to the same setting. Any
better options?

> 
> > +		old = snd_soc_read(codec, ARIZONA_IN1L_CONTROL) &
> > +					ARIZONA_IN1_MODE_MASK;
> 
> > +		if (old != in1mode)
> > +			snd_soc_update_bits(codec, ARIZONA_IN1L_CONTROL,
> > +						ARIZONA_IN1_MODE_MASK, in1mode);
> 
> Why bother with the read into old here?  Suppressing redundant updates
> is part of the point of snd_soc_update_bits().

Agreed, probably a legacy of an earlier implementation that's now redundant.


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
