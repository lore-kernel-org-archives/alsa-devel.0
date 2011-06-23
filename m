From: ashwanik <ashwani.kumar@freesystems.biz>
Subject: Re: snd_pcm_link : Function not implemented
Date: Thu, 23 Jun 2011 18:36:34 +0530
Message-ID: <4E033A5A.9030309@freesystems.biz>
References: <4DF1B8A7.3090408@freesystems.biz>	<loom.20110615T074514-791@post.gmane.org>	<s5hei2u83aj.wl%tiwai@suse.de>	<4DF9E450.8090903@freesystems.biz>
	<s5haadi80tr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.freesystems.biz (unknown [124.30.7.148])
	by alsa0.perex.cz (Postfix) with ESMTP id D6F7E2439C
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Jun 2011 15:06:50 +0200 (CEST)
In-Reply-To: <s5haadi80tr.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thursday 16 June 2011 05:06 PM, Takashi Iwai wrote:
> At Thu, 16 Jun 2011 16:39:04 +0530,
> ashwanik wrote:
>>
>>
>>
>> On Thursday 16 June 2011 04:13 PM, Takashi Iwai wrote:
>>> At Wed, 15 Jun 2011 05:50:29 +0000 (UTC),
>>> Ashwani Kumar wrote:
>>>> ashwanik<ashwani.kumar<at>   freesystems.biz>   writes:
>>>>
>>>>> Hi All,
>>>>>
>>>>> I have download and compile latency.c application from
>>>>> http://www.alsa-project.org/alsa-doc/alsa-lib/_2test_2latency_8c-example.html.
>>>>> This application is  working fine on  Linux PC.
>>>>> But when I am using this application on my omap4 board(using
>>>>> ubuntu10.10) is not working.
>>>>>
>>>>> I am getting"Streams link error: Function not implemented" error. I
>>>>> debug the application and found this error coming from the
>>>>> *snd_pcm_link* function.
>>>>> I am using ALSA Driver Version 1.0.23.
>>>>>
>>>>> please find pointers.
>>>>>
>>>>> Thanks in Advance
>>>>> Ashwani
>>>>>
>>>>>
>>>> Hi,
>>>> Bringing to Top ,anyone faced similar problem of "snd_pcm_link" returning error
>>>> val=-38 and prints "Streams link error: Function not implemented".
>>> I don't know of such a problem.  Better to check what went wrong via
>>> strace or such.
>>>
>>>
>>> Takashi
>> Thanks for your reply,
>>
>> I left that application(latency.c).
>> now i have merged alsa playback and capture application and thats
>> working with following issue on omap4 board:
>>   >  when i am executing this apps getting "underrun occurred" error
> This is usually a driver issue.
>
>>   >  CPU consumption very high 22 - 27%.
> This is normal.  It's a sort of stress-test, after all.
>
>
> Takashi
Thanks takashi.

I tried to reduce cpu consumption by simple capture & playback 
application but no success.

In my capture & playback application set sample rate to 44100 bits/sec. 
looking alsa mix upsample the 44100 rate to 48000 bits/sec. I tried to 
change defaults.pcm.dmix.rate 44100 in alsa.conf but this change doesn't 
reflected in /proc/asound/card0/pcm0c/sub0/hw_params .

access: MMAP_INTERLEAVED
format: S32_LE
subformat: STD
channels: 2
rate: 48000 (48000/1)
period_size: 35
buffer_size: 6720

Please suggest me how to change hw_params.


Thanks in Advance
Ashwani
