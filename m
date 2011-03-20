From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: snd_pcm_hw_params_set_buffer_time_near: invalid
	argument
Date: Sun, 20 Mar 2011 10:01:54 +0800
Message-ID: <AANLkTim-Y=KVqRtMwBa6T0=PjEybDjLTK2TB5Zqvy4jp@mail.gmail.com>
References: <AANLkTik5sX_DWLsN3y_7ANpoF5rgeCNZY7gm=+rFhCsy@mail.gmail.com>
	<AANLkTimfZwH+dqsPZaifekmmctrARdE0DoK5nHoW1Fu_@mail.gmail.com>
	<AANLkTinNhknw6h81zkqhhXQwYyrKGs0mVjYpjYvZuNa=@mail.gmail.com>
	<AANLkTi=WkvaM+oLDAzyvcBzeg_kuB=33esFVXDZn1M48@mail.gmail.com>
	<AANLkTik+ecGzz+yCoYhYCxHEJrsof5Eo_cxgnEU84wZm@mail.gmail.com>
	<alpine.LNX.2.00.1103091326380.4805@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 7A5141037E3
	for <alsa-devel@alsa-project.org>; Sun, 20 Mar 2011 03:01:54 +0100 (CET)
Received: by fxm6 with SMTP id 6so4453188fxm.38
	for <alsa-devel@alsa-project.org>; Sat, 19 Mar 2011 19:01:54 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1103091326380.4805@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/3/9 Jaroslav Kysela <perex@perex.cz>

> On Wed, 9 Mar 2011, Jean-Yves Avenard wrote:
>
>  Hi
>>
>> On Wednesday, 9 March 2011, Raymond Yau <superquad.vortex2@gmail.com>
>> wrote:
>>
>>  hda-intel.c only allocate 64Kbytes
>>>
>>>     /* buffer pre-allocation */
>>>     snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV_SG,
>>>                           snd_dma_pci_data(chip->pci),
>>>                           1024 * 64, 32 * 1024 * 1024);
>>>
>>> user or distribution need to change "prealloc" from 64 to a higher value
>>> for
>>> getting 500ms buffer
>>>
>>> echo 1024 > /proc/asound/Intel/pcm0p/sub0/prealloc
>>>
>>
>> It seems you misunderstood my first message.
>>
>> For a start, the default memory allocated to alsa in ubuntu is 4096kB.
>> so the amount of ram isn't the problem.
>>
>> Setting a buffer of
>> 200ms: ok
>> 300ms: ok
>> 400ms: not ok (invalid argument)
>> 500ms: ok
>>
>> Why would 400ms gives invalid argument, when 500ms doesn't nor 300.
>> Memory available is obviously not the issue.
>>
>> If only 64kB is allocated, requesting 200ms gives you 200ms
>> 300ms -> 300ms
>> 400ms -> invalid argument
>> 500ms -> 371ms
>> 600ms -> 371ms
>>
>> You would assume that requesting 400ms would work or return what can
>> fit in what has been pre-allocated.
>>
>
> What is your dir argument (last one) for the near functions? If it's NULL
> or value is zero, it means you request the exact value which may not be
> available. Use -1 to request specified or smaller value or 1 to request
> specified or bigger value.
>
>
Take another example from alsa-lib/test

Try many parameters but still cannot let alsa-lib/test/latency.c work with
alsa-pulse plugin  and latency stop without any error message

alsa-lib/test/latency -P pulse -C pulse

adding some debug statement and find that it alway fail in setparams()


    if (*bufsize > latency_max) {
+        printf("*bufsize %d > latency_max %d\n",*bufsize,latency_max);
        return -1;
        }
