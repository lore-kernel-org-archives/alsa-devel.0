From: Jiada Wang <jiada_wang@mentor.com>
Subject: Re: [PATCH 1/3 v1] ALSA: usb-audio: more tolerant packetsize
Date: Thu, 1 Dec 2016 16:04:26 +0900
Message-ID: <14a10709-4d7d-1b51-f754-92c722c115d2@mentor.com>
References: <20161130075923.15205-1-jiada_wang@mentor.com>
 <20161130075923.15205-2-jiada_wang@mentor.com> <s5hwpfl2vre.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hwpfl2vre.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: perex@perex.cz, alsa-devel@alsa-project.org, apape@de.adit-jv.com, Mark_Craske@mentor.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hello Takashi

On 11/30/2016 05:54 PM, Takashi Iwai wrote:
> On Wed, 30 Nov 2016 08:59:21 +0100,
> Jiada Wang wrote:
>>
>> From: Andreas Pape <apape@de.adit-jv.com>
>>
>> since commit 57e6dae1087bbaa6b33d3dd8a8e90b63888939a3 the expected packetsize is always limited to
>
> Please use a form with 12 chars SHA ID plus the commit subject, e.g.
> 1234567890ab ("blah blah...")
I will update changelog as you have suggested in v2.
>
>> nominal + 25%. It was discovered, that some devices have a much higher jitter
>> in used packetsizes than 25% which would result in BABBLE condition and dropping of packets.
>> A better solution is so assume the jitter to be the nominal packetsize:
>> -one nearly empty packet followed by a almost double sized one.
>
> The increase of the max frequency is supposedly OK.
> A remaining question is whether this should be included in stable
> kernel.  It fixes in one side, but it's quite untested in another
> side.  Maybe we queue this for 4.10, and later on notify to stable
> maintainer once when it's confirmed to work and be harmless.
>
>
this makes sense to me

Thanks,
Jiada
> thanks,
>
> Takashi
>
>>
>> Signed-off-by: Andreas Pape <apape@de.adit-jv.com>
>> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
>> ---
>>  sound/usb/endpoint.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
>> index c470251..2f592dd 100644
>> --- a/sound/usb/endpoint.c
>> +++ b/sound/usb/endpoint.c
>> @@ -632,8 +632,8 @@ static int data_ep_set_params(struct snd_usb_endpoint *ep,
>>  	ep->stride = frame_bits >> 3;
>>  	ep->silence_value = pcm_format == SNDRV_PCM_FORMAT_U8 ? 0x80 : 0;
>>
>> -	/* assume max. frequency is 25% higher than nominal */
>> -	ep->freqmax = ep->freqn + (ep->freqn >> 2);
>> +	/* assume max. frequency is double than nominal */
>> +	ep->freqmax = ep->freqn * 2;
>>  	/* Round up freqmax to nearest integer in order to calculate maximum
>>  	 * packet size, which must represent a whole number of frames.
>>  	 * This is accomplished by adding 0x0.ffff before converting the
>> --
>> 2.9.3
>>
>>
