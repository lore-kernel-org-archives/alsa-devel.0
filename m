From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: Re: [PATCH] ALSA: vx: vx_pcm: constify vx_pcm_playback_ops and
 vx_pcm_capture_ops.
Date: Fri, 9 Jun 2017 12:43:14 +0530
Message-ID: <89a6fe9e-1d80-826e-e287-d49f2a3fe03b@gmail.com>
References: <7c7f41b54273dab90edf67c8fb4ce758a83929ce.1496991874.git.arvind.yadav.cs@gmail.com>
 <s5hink51vs3.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hink51vs3.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: perex@perex.cz, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

hi,
Sure, Rest other I will send at once shot.

Thanks
~arvind

On Friday 09 June 2017 12:40 PM, Takashi Iwai wrote:
> On Fri, 09 Jun 2017 09:05:43 +0200,
> Arvind Yadav wrote:
>> File size before:
>>     text	   data	    bss	    dec	    hex	filename
>>     7126	    240	      0	   7366	   1cc6	sound/drivers/vx/vx_pcm.o
>>
>> File size After adding 'const':
>>     text	   data	    bss	    dec	    hex	filename
>>     7382	      0	      0	   7382	   1cd6	sound/drivers/vx/vx_pcm.o
>>
>> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> If you're going to send more similar patches like this and previous
> one of pcsp, could you create a patchset containing all and send at
> once?
>
>
> thanks,
>
> Takashi
>
>> ---
>>   sound/drivers/vx/vx_pcm.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/sound/drivers/vx/vx_pcm.c b/sound/drivers/vx/vx_pcm.c
>> index ea7b377..d318a33 100644
>> --- a/sound/drivers/vx/vx_pcm.c
>> +++ b/sound/drivers/vx/vx_pcm.c
>> @@ -873,7 +873,7 @@ static int vx_pcm_prepare(struct snd_pcm_substream *subs)
>>   /*
>>    * operators for PCM playback
>>    */
>> -static struct snd_pcm_ops vx_pcm_playback_ops = {
>> +static const struct snd_pcm_ops vx_pcm_playback_ops = {
>>   	.open =		vx_pcm_playback_open,
>>   	.close =	vx_pcm_playback_close,
>>   	.ioctl =	snd_pcm_lib_ioctl,
>> @@ -1095,7 +1095,7 @@ static snd_pcm_uframes_t vx_pcm_capture_pointer(struct snd_pcm_substream *subs)
>>   /*
>>    * operators for PCM capture
>>    */
>> -static struct snd_pcm_ops vx_pcm_capture_ops = {
>> +static const struct snd_pcm_ops vx_pcm_capture_ops = {
>>   	.open =		vx_pcm_capture_open,
>>   	.close =	vx_pcm_capture_close,
>>   	.ioctl =	snd_pcm_lib_ioctl,
>> -- 
>> 1.9.1
>>
>>
