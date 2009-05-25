From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: Re: Question about snd_dma_buffer  bytes field
Date: Mon, 25 May 2009 14:15:44 -0700
Message-ID: <4A1B0A80.3090600@boundarydevices.com>
References: <4A1A01E2.608@boundarydevices.com> <s5hmy91d9c9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpauth02.csee.onr.siteprotect.com
	(smtpauth02.csee.onr.siteprotect.com [64.26.60.136])
	by alsa0.perex.cz (Postfix) with ESMTP id E09812454E
	for <alsa-devel@alsa-project.org>;
	Mon, 25 May 2009 23:15:59 +0200 (CEST)
In-Reply-To: <s5hmy91d9c9.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Sun, 24 May 2009 19:26:42 -0700,
> Troy Kisky wrote:
>> Does
>>
>> (substream->dma_buffer.bytes) need to equal (snd_pcm_lib_period_bytes(substream) * runtime->periods) ?
>>
>> When this is not true, it seems like the buffer is not being filled correctly.
>>
>>
>> for testing, this works
>> 	.buffer_bytes_max = 16 * 7 * 512,
>> 	.period_bytes_min = 32,
>> 	.period_bytes_max = 7 * 512,	/* This is size of ping + pong buffer*/
>>
>> and this doesn't.
>> 	.buffer_bytes_max = 16 * 7 * 512 + 512,
>> 	.period_bytes_min = 32,
>> 	.period_bytes_max = 7 * 512,	/* This is size of ping + pong buffer*/
>>
>>
>> When playing back a sine wave, I can hear breaks.
> 
> Well, there are two misunderstandings here:
> 
> - substream->dma_buffer.bytes doesn't define the actual buffer size.
>   It's substream->runtime->buffer_size (in frames).  The former is the
>   allocated buffer size which can be larger.
> 
> - The buffer size doesn't have to be aligned to period_size as default,
>   i.e. it's not always equal with period_size * periods, and periods
>   isn't always an integer.
> 
>   To align the buffer size to period size, call below in the open
>   callback
> 	snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS);
> 
> 
> HTH,
> 
> Takashi
> 
Yes, that fixed my problem.


Thanks you
Troy
