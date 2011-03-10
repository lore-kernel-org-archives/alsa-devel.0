From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: snd_pcm_hw_params_set_buffer_time_near: invalid
	argument
Date: Thu, 10 Mar 2011 08:44:54 +0800
Message-ID: <AANLkTi=J=T=054UNrX1DMX=QioNEJKOmDZqbJ41OxYx5@mail.gmail.com>
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
	by alsa0.perex.cz (Postfix) with ESMTP id F163F1039E1
	for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2011 01:44:54 +0100 (CET)
Received: by fxm11 with SMTP id 11so1076218fxm.38
	for <alsa-devel@alsa-project.org>; Wed, 09 Mar 2011 16:44:54 -0800 (PST)
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
>                                        Jaroslav
>

According to your explanation,  it should fail at 500ms buffer time when
rate is 11025Hz and dir=0 or NULL, since half of 11025 is  5512.5

but

alsa-lib/test/pcm -v -Dhw:CARD=Intel,DEV=0 -r 11025 -c 2 -b 500000

Playback device is hw:CARD=Intel,DEV=0
Stream parameters are 11025Hz, S16_LE, 2 channels
Sine wave rate is 440.0000Hz
Using transfer method: write
Hardware PCM card 1 'HDA Intel' device 0 subdevice 0
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 11025
  exact rate   : 11025 (11025/1)
  msbits       : 16
  buffer_size  : 5504
  period_size  : 1376
  period_time  : 124807
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 1376
  period_event : 0
  start_threshold  : 5504
  stop_threshold   : 5504
  silence_threshold: 0
  silence_size : 0
  boundary     : 1442840576
  appl_ptr     : 0
  hw_ptr       : 0
