From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH 2/2] ALSA: snd-usb: use strncpy() in
	mixer_quirks.c
Date: Mon, 20 Oct 2014 16:47:25 +0200
Message-ID: <5445207D.6070009@zonque.org>
References: <1413702686-8751-1-git-send-email-daniel@zonque.org>	<1413702686-8751-2-git-send-email-daniel@zonque.org>	<s5ha94stn4d.wl-tiwai@suse.de>
 <s5h38ails8g.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id F3286260605
 for <alsa-devel@alsa-project.org>; Mon, 20 Oct 2014 16:47:26 +0200 (CEST)
In-Reply-To: <s5h38ails8g.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 10/20/2014 04:40 PM, Takashi Iwai wrote:
> At Sun, 19 Oct 2014 11:38:58 +0200,
> Takashi Iwai wrote:
>>
>> At Sun, 19 Oct 2014 09:11:26 +0200,
>> Daniel Mack wrote:
>>>
>>> Out of principles, use strncpy() in favor of strcpy().
>>> That is, however, an insignificant detail here.
>>>
>>> Signed-off-by: Daniel Mack <daniel@zonque.org>
>>
>> Well, blindly doing this isn't optimal, IMO.
>> First off, strlcpy() is a better one.  And, in the code you patched,
>> we already know all strings to be passed.  That is, if anything is
>> over the buffer size, it's a clear bug.  This can be caught by static
>> analyzers, or put some debug codes (either for build time or compile
>> time) instead of silently trimming the string.
> 
> BTW, there is already a nice helper function, snd_ctl_enum_info(), for
> the safe enum info setup.  Then the patch would become even more
> reducing, something like below.  We can cover many other places in
> similar ways.
> 
> A further step would be to add a kernel warning when the given string
> is too long as an enum item string.  Then we can catch the buggy
> driver, too.  I'll cook up the patch.

Sounds good to me. And yes, we know which values we write to that buffer
and that they can't possibly explode it. I was just thinking of the next
reader of the code who might be quicker in the review with some obvious
guards in place.


Thanks,
Daniel


> 
> 
> Takashi
> 
> ---
> diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
> index f119a41ed9a9..dd4d5bdea423 100644
> --- a/sound/usb/mixer_quirks.c
> +++ b/sound/usb/mixer_quirks.c
> @@ -441,15 +441,7 @@ static int snd_emu0204_ch_switch_info(struct snd_kcontrol *kcontrol,
>  				       "3/4"
>  	};
>  
> -	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
> -	uinfo->count = 1;
> -	uinfo->value.enumerated.items = 2;
> -	if (uinfo->value.enumerated.item > 1)
> -		uinfo->value.enumerated.item = 1;
> -	strcpy(uinfo->value.enumerated.name,
> -		texts[uinfo->value.enumerated.item]);
> -
> -	return 0;
> +	return snd_ctl_enum_info(uinfo, 1, ARRAY_SIZE(texts), texts);
>  }
>  
>  static int snd_emu0204_ch_switch_get(struct snd_kcontrol *kcontrol,
> @@ -745,15 +737,7 @@ static int snd_ftu_eff_switch_info(struct snd_kcontrol *kcontrol,
>  				       "Echo"
>  	};
>  
> -	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
> -	uinfo->count = 1;
> -	uinfo->value.enumerated.items = 8;
> -	if (uinfo->value.enumerated.item > 7)
> -		uinfo->value.enumerated.item = 7;
> -	strcpy(uinfo->value.enumerated.name,
> -		texts[uinfo->value.enumerated.item]);
> -
> -	return 0;
> +	return snd_ctl_enum_info(uinfo, 1, ARRAY_SIZE(texts), texts);
>  }
>  
>  static int snd_ftu_eff_switch_get(struct snd_kcontrol *kctl,
> 
