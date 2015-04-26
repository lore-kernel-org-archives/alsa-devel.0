From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: Re: Pop noise on startup when headphones are plugged
	in (Dell XPS13 9333)
Date: Sun, 26 Apr 2015 19:05:18 +0200
Message-ID: <2856179.MdfUFTz22r@xps13>
References: <23057263.IjMh4t6SYF@xps13> <1993280.RJlmSdruKz@xps13>
 <s5hpp6qhn3g.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f171.google.com (mail-wi0-f171.google.com
 [209.85.212.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 98D9926148F
 for <alsa-devel@alsa-project.org>; Sun, 26 Apr 2015 19:05:20 +0200 (CEST)
Received: by wizk4 with SMTP id k4so74120372wiz.1
 for <alsa-devel@alsa-project.org>; Sun, 26 Apr 2015 10:05:20 -0700 (PDT)
In-Reply-To: <s5hpp6qhn3g.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Raymond Yau <superquad.vortex2@gmail.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sunday 26 April 2015 18:26:59 Takashi Iwai wrote:
> At Sat, 25 Apr 2015 15:57:15 +0200,
> Gabriele Mazzotta wrote:
> > 
> > On Saturday 25 April 2015 13:51:33 Gabriele Mazzotta wrote:
> > > Hi,
> > > 
> > > I think this the patch here below is simpler than the other I sent.
> > > snd_hda_get_default_vref() guesses the vref input pins. We know that
> > > some of these are for headphones/headset mics, so we could set the
> > > vref to HIZ for these.
> > > 
> > > Are there systems that would misbehave with this change?
> > > 
> > > Gabriele
> > > 
> > > ---
> > > diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
> > > index 3d2597b..081db8b 100644
> > > --- a/sound/pci/hda/hda_generic.c
> > > +++ b/sound/pci/hda/hda_generic.c
> > > @@ -3257,7 +3257,9 @@ static int create_input_ctls(struct hda_codec *codec)
> > >  			continue;
> > >  
> > >  		val = PIN_IN;
> > > -		if (cfg->inputs[i].type == AUTO_PIN_MIC)
> > > +		if (cfg->inputs[i].type == AUTO_PIN_MIC &&
> > > +		    !cfg->inputs[i].is_headset_mic &&
> > > +		    !cfg->inputs[i].is_headphone_mic)
> > >  			val |= snd_hda_get_default_vref(codec, pin);
> > >  		if (pin != spec->hp_mic_pin)
> > >  			set_pin_target(codec, pin, val, false);
> > 
> > Sorry, I think I misunderstood the meaning of the two flags and they
> > can't be used like that.
> 
> Yeah, it's a slight abuse.
> 
> How about a patch like below?  This doesn't add any flag but it sets
> the default pin target value explicitly by the driver beforehand, and
> let the generic parser setting up only when uninitialized.

It's working perfectly, thanks.

Gabriele

> Takashi
> 
> ---
> diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
> index 3d2597b7037b..788f969b1a68 100644
> --- a/sound/pci/hda/hda_generic.c
> +++ b/sound/pci/hda/hda_generic.c
> @@ -3259,7 +3259,8 @@ static int create_input_ctls(struct hda_codec *codec)
>  		val = PIN_IN;
>  		if (cfg->inputs[i].type == AUTO_PIN_MIC)
>  			val |= snd_hda_get_default_vref(codec, pin);
> -		if (pin != spec->hp_mic_pin)
> +		if (pin != spec->hp_mic_pin &&
> +		    !snd_hda_codec_get_pin_target(codec, pin))
>  			set_pin_target(codec, pin, val, false);
>  
>  		if (mixer) {
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index 06199e4e930f..bd661ca62092 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -4190,11 +4190,15 @@ static void alc_shutup_dell_xps13(struct hda_codec *codec)
>  static void alc_fixup_dell_xps13(struct hda_codec *codec,
>  				const struct hda_fixup *fix, int action)
>  {
> -	if (action == HDA_FIXUP_ACT_PROBE) {
> -		struct alc_spec *spec = codec->spec;
> -		struct hda_input_mux *imux = &spec->gen.input_mux;
> -		int i;
> +	struct alc_spec *spec = codec->spec;
> +	struct hda_input_mux *imux = &spec->gen.input_mux;
> +	int i;
>  
> +	switch (action) {
> +	case HDA_FIXUP_ACT_PRE_PROBE:
> +		snd_hda_codec_set_pin_target(codec, 0x19, PIN_VREFHIZ);
> +		break;
> +	case HDA_FIXUP_ACT_PROBE:
>  		spec->shutup = alc_shutup_dell_xps13;
>  
>  		/* Make the internal mic the default input source. */
> @@ -4204,6 +4208,7 @@ static void alc_fixup_dell_xps13(struct hda_codec *codec,
>  				break;
>  			}
>  		}
> +		break;
>  	}
>  }
>  
