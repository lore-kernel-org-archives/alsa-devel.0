From: Kailang <kailang@realtek.com>
Subject: RE: [PATCH] ALSA: hda - Add a de-pop quirk for some HP machines
Date: Fri, 29 Aug 2014 08:29:52 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A17060396@RTITMBSA.realtek.com.tw>
References: <1409298425-9697-1-git-send-email-hui.wang@canonical.com>
 <s5hfvgfsoye.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <s5hfvgfsoye.wl-tiwai@suse.de>
Content-Language: zh-TW
Sender: stable-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, Hui Wang <hui.wang@canonical.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

 

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de] 
> Sent: Friday, August 29, 2014 4:03 PM
> To: Hui Wang
> Cc: alsa-devel@alsa-project.org; Kailang; stable@vger.kernel.org
> Subject: Re: [PATCH] ALSA: hda - Add a de-pop quirk for some 
> HP machines
> 
> At Fri, 29 Aug 2014 15:47:05 +0800,
> Hui Wang wrote:
> > 
> > On some HP machines, there will be pop noise when the machine is 
> > shutting down, rebooting or booting up from poweroff state.
> > 
> > Set EAPD enable only when stream starts can help to fix 
> this problem.
> > 
> > [The patch was originally written by Kailang, we tested it 
> and rebased 
> > it on latest kernel.]
> > 
> > Signed-off-by: Kailang Yang <kailang@realtek.com>
> > Signed-off-by: Hui Wang <hui.wang@canonical.com>
> > ---
> >  sound/pci/hda/patch_realtek.c | 55 
> > ++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 52 insertions(+), 3 deletions(-)
> > 
> > diff --git a/sound/pci/hda/patch_realtek.c 
> > b/sound/pci/hda/patch_realtek.c index 48d6d10..51811a6 100644
> > --- a/sound/pci/hda/patch_realtek.c
> > +++ b/sound/pci/hda/patch_realtek.c
> > @@ -4282,6 +4282,47 @@ static void 
> alc290_fixup_mono_speakers(struct hda_codec *codec,
> >  	}
> >  }
> >  
> > +/*
> > + * ALC290 PCM hooks
> > + */
> > +static void alc290_playback_pcm_hook(struct hda_pcm_stream *hinfo,
> > +				     struct hda_codec *codec,
> > +				     struct snd_pcm_substream 
> *substream,
> > +				     int action)
> > +{
> > +	int val;
> > +
> > +	switch (action) {
> > +	case HDA_GEN_PCM_ACT_OPEN:
> > +		val = alc_read_coef_idx(codec, 0x4); /* EAPD 
> manual high */
> > +		if ((val & 0xc000) != 0xc000)
> > +			alc_write_coef_idx(codec, 0x4, val | (1<<14));
> > +		break;
> > +	}
> > +}
> > +
> > +static void alc290_fixup_pop_noise(struct hda_codec *codec,
> > +				   const struct hda_fixup *fix, 
> int action) {
> > +	struct alc_spec *spec = codec->spec;
> > +	int val;
> > +
> > +	switch (action) {
> > +	case HDA_FIXUP_ACT_PRE_PROBE:
> > +		snd_hda_codec_write(codec, 0x17, 0,
> > +				    
> AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT);
> 
> Why do you need this...

This is reauest by HP. They say Keep this to output will lower pop noise from woofer speaker.

> 
> > +		val = alc_read_coef_idx(codec, 0x4);
> > +		if ((val & 0xc000) != 0xc000)
> > +			alc_write_coef_idx(codec, 0x4, val | 
> (3<<14)); /* EAPD low */
> > +		spec->gen.pcm_playback_hook = alc290_playback_pcm_hook;
> > +		break;
> > +	case HDA_FIXUP_ACT_INIT:
> > +		snd_hda_codec_write(codec, 0x17, 0,
> > +				    
> AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT);
> 
> ... and this?  There is no explanation about this change.
> 
> Also, can't you just set EAPD low in the shutdown callback instead?
> 
> In your patch, if the machine goes shutdown/reboot while 
> playing a stream (or before runtime PM), it's still EAPD 
> high, so the noise should be heard, if I understand correctly.
> 

EAPD keep high, no change state will no pop noise. EC will control the delay for 30s to do AMP pin to high.
When it enter to S3, EAPD will go low. Resume back, the eapd will go high. It will show pop noise.
This is not have method to improve for this hardware issue in this state.

> 
> Takashi
> 
> ------Please consider the environment before printing this e-mail.
> 