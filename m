From: Ioan-Adrian Ratiu <adi@adirat.com>
Subject: Re: [PATCH v2 1/2] ALSA: usb-audio: Fix irq/process data synchronization
Date: Wed, 04 Jan 2017 11:15:58 +0200
Message-ID: <87y3yrdw35.fsf@adiPC.i-did-not-set--mail-host-address--so-tickle-me>
References: <20170102155031.3638-1-adi@adirat.com> <20170102155031.3638-2-adi@adirat.com> <s5h7f6bmj8z.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5h7f6bmj8z.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: perex@perex.cz, o-takashi@sakamocchi.jp, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, 04 Jan 2017, Takashi Iwai <tiwai@suse.de> wrote:
> On Mon, 02 Jan 2017 16:50:30 +0100,
> Ioan-Adrian Ratiu wrote:
>> 
>> --- a/sound/usb/pcm.c
>> +++ b/sound/usb/pcm.c
> (snip)
>> @@ -850,7 +850,7 @@ static int snd_usb_pcm_prepare(struct snd_pcm_substream *substream)
>>  	/* for playback, submit the URBs now; otherwise, the first hwptr_done
>>  	 * updates for all URBs would happen at the same time when starting */
>>  	if (subs->direction == SNDRV_PCM_STREAM_PLAYBACK)
>> -		ret = start_endpoints(subs, true);
>> +		return start_endpoints(subs);
>
> Here you miss the unlock below.
>
>>  
>>   unlock:
>>  	snd_usb_unlock_shutdown(subs->stream->chip);
>
> ... and this must be the reason of the hang up at disconnection, where
> the driver ways forever at wait_event() in usb_audio_disconnect().
>
> Could you fix this and resubmit v3?  Other than that, it looks OK.

Sure, I'll resubmit v3 by tonight hopefully.

Thank you for taking a look at this, I didn't have a chance to look it
again since I posted v2.

Ionel

>
>
> thanks,
>
> Takashi
