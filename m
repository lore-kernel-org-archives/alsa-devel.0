From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: Re: [PATCH] ALSA: hda - Mute headphone pin on suspend on XPS13 9333
Date: Mon, 20 Apr 2015 21:41:16 +0200
Message-ID: <2009458.GkX53X9aRj@xps13>
References: <1429462840-24143-1-git-send-email-gabriele.mzt@gmail.com> <s5h383vw9qi.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5h383vw9qi.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: perex@perex.cz, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Monday 20 April 2015 09:16:05 Takashi Iwai wrote:
> At Sun, 19 Apr 2015 19:00:40 +0200,
> Gabriele Mazzotta wrote:
> > 
> > Muting the headphone output pin right before the codec suspension
> > prevents pop noises when headphones are plugged in (except for a
> > barely audible click noise).
> > This solution allows to truly save some power when headphones are
> > plugged in unlike the previous solution (033b0a7ca9c:
> > "ALSA: hda - Pop noises fix for XPS13 9333")
> 
> Great.  But this doesn't fix the issue (noise at the first headphone
> plug), right?

There's a bit of crackling noise when the headphones are inserted, but
that doesn't go away even disabling the power saving mode.

> In anyway, I applied the patch now.  Thanks.
> 
> 
> Takashi
> 
> > 
> > Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
> > ---
> >  sound/pci/hda/patch_realtek.c | 17 +++++++----------
> >  1 file changed, 7 insertions(+), 10 deletions(-)
> > 
> > diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> > index b18b9c6..231d0e4 100644
> > --- a/sound/pci/hda/patch_realtek.c
> > +++ b/sound/pci/hda/patch_realtek.c
> > @@ -4176,17 +4176,15 @@ static void alc_fixup_disable_aamix(struct hda_codec *codec,
> >  	}
> >  }
> >  
> > -static unsigned int alc_power_filter_xps13(struct hda_codec *codec,
> > -				hda_nid_t nid,
> > -				unsigned int power_state)
> > +static void alc_shutup_dell_xps13(struct hda_codec *codec)
> >  {
> >  	struct alc_spec *spec = codec->spec;
> > +	int hp_pin = spec->gen.autocfg.hp_pins[0];
> >  
> > -	/* Avoid pop noises when headphones are plugged in */
> > -	if (spec->gen.hp_jack_present)
> > -		if (nid == codec->core.afg || nid == 0x02 || nid == 0x15)
> > -			return AC_PWRST_D0;
> > -	return snd_hda_gen_path_power_filter(codec, nid, power_state);
> > +	/* Prevent pop noises when headphones are plugged in */
> > +	snd_hda_codec_write(codec, hp_pin, 0,
> > +			    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
> > +	msleep(20);
> >  }
> >  
> >  static void alc_fixup_dell_xps13(struct hda_codec *codec,
> > @@ -4197,8 +4195,7 @@ static void alc_fixup_dell_xps13(struct hda_codec *codec,
> >  		struct hda_input_mux *imux = &spec->gen.input_mux;
> >  		int i;
> >  
> > -		spec->shutup = alc_no_shutup;
> > -		codec->power_filter = alc_power_filter_xps13;
> > +		spec->shutup = alc_shutup_dell_xps13;
> >  
> >  		/* Make the internal mic the default input source. */
> >  		for (i = 0; i < imux->num_items; i++) {
> 
