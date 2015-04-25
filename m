From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: Re: Pop noise on startup when headphones are plugged
	in (Dell XPS13 9333)
Date: Sat, 25 Apr 2015 15:57:15 +0200
Message-ID: <1993280.RJlmSdruKz@xps13>
References: <23057263.IjMh4t6SYF@xps13> <s5h1tj9o7z2.wl-tiwai@suse.de>
 <2264204.W7vnUSq2WO@xps13>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f181.google.com (mail-wi0-f181.google.com
 [209.85.212.181])
 by alsa0.perex.cz (Postfix) with ESMTP id CE56C261A34
 for <alsa-devel@alsa-project.org>; Sat, 25 Apr 2015 15:57:19 +0200 (CEST)
Received: by wicmx19 with SMTP id mx19so53083722wic.1
 for <alsa-devel@alsa-project.org>; Sat, 25 Apr 2015 06:57:17 -0700 (PDT)
In-Reply-To: <2264204.W7vnUSq2WO@xps13>
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

On Saturday 25 April 2015 13:51:33 Gabriele Mazzotta wrote:
> Hi,
> 
> I think this the patch here below is simpler than the other I sent.
> snd_hda_get_default_vref() guesses the vref input pins. We know that
> some of these are for headphones/headset mics, so we could set the
> vref to HIZ for these.
> 
> Are there systems that would misbehave with this change?
> 
> Gabriele
> 
> ---
> diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
> index 3d2597b..081db8b 100644
> --- a/sound/pci/hda/hda_generic.c
> +++ b/sound/pci/hda/hda_generic.c
> @@ -3257,7 +3257,9 @@ static int create_input_ctls(struct hda_codec *codec)
>  			continue;
>  
>  		val = PIN_IN;
> -		if (cfg->inputs[i].type == AUTO_PIN_MIC)
> +		if (cfg->inputs[i].type == AUTO_PIN_MIC &&
> +		    !cfg->inputs[i].is_headset_mic &&
> +		    !cfg->inputs[i].is_headphone_mic)
>  			val |= snd_hda_get_default_vref(codec, pin);
>  		if (pin != spec->hp_mic_pin)
>  			set_pin_target(codec, pin, val, false);

Sorry, I think I misunderstood the meaning of the two flags and they
can't be used like that.
