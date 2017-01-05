From: Ricardo Biehl <rbpoficial@gmail.com>
Subject: Re: what is exactly pcm.boundary?
Date: Thu, 5 Jan 2017 19:14:47 -0200
Message-ID: <CAAu8FscDY1R7EG2GsTmV9=JUWGh3K3HEw4RdF-g8NHjzFNYO8w@mail.gmail.com>
References: <CAAu8Fse4GcOV5PkgnWQfBSQjM3SoiEurVuhvuNgQ3zD_8TeHbw@mail.gmail.com>
 <cf5b8891-5d8e-9df1-dbfa-b4471ef32f55@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f65.google.com (mail-wm0-f65.google.com [74.125.82.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D4832670B8
 for <alsa-devel@alsa-project.org>; Thu,  5 Jan 2017 22:14:48 +0100 (CET)
Received: by mail-wm0-f65.google.com with SMTP id m203so440007wma.3
 for <alsa-devel@alsa-project.org>; Thu, 05 Jan 2017 13:14:48 -0800 (PST)
In-Reply-To: <cf5b8891-5d8e-9df1-dbfa-b4471ef32f55@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2017-01-05 18:36 GMT-02:00, Takashi Sakamoto <o-takashi@sakamocchi.jp>:
> Hi,
>
> On Jan 6 2017 03:10, Ricardo Biehl wrote:
>> Well, in src/pcm/pcm_local.h  line ~469:
>>
>> 1	static inline snd_pcm_uframes_t snd_pcm_mmap_playback_avail(snd_pcm_t
>> *pcm)
>> 2	{
>> 3		snd_pcm_sframes_t avail;
>> 4		avail = *pcm->hw.ptr + pcm->buffer_size - *pcm->appl.ptr;
>> 5		if (avail < 0)
>> 6			avail += pcm->boundary;
>> 7		else if ((snd_pcm_uframes_t) avail >= pcm->boundary)
>> 8			avail -= pcm->boundary;
>> 9		return avail;
>> 10	}
>>
>> First, I assumed that both hw_ptr and appl_ptr always points to addresses
>> inside
>> a REGION of memory that is exactly the size of buffer = (period_size *
>> periods).
>
> No. Both of the 'appl_ptr' and 'hw_ptr' is not within the size of
> buffer. They round up to the size of boundary. The size of boundary is
> calculated in these lines.
>
> https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/tree/sound/core/pcm_native.c?h=v4.10-rc2#n590
>
> 590	while (runtime->boundary * 2 <= LONG_MAX - runtime->buffer_size)
> 591		runtime->boundary *= 2;
>
> You can also see current value of the boundary in PCM substream via
> procfs, like:
> $ cat /proc/asound/card0/pcm0p/sub0/sw_params
> tstamp_mode: ENABLE
> period_step: 1
> avail_min: 1088
> start_threshold: 18446744073709551615
> stop_threshold: 4971973988617027584
> silence_threshold: 0
> silence_size: 0
> boundary: 4971973988617027584
>
> You can see it's not the size of allocated memory because it's quite large.
>
> The size of boundary is always multiple of the size of period in
> intermediate buffer for user space, up to UINT_MAX. Both of 'hw_ptr' and
> 'appl_ptr' means total number of processed PCM frames in current PCM
> substream. They're not directly related to dedicated buffer for data
> transmission.
>

Oh Thanks :-)
I was so far from the answer ...

In this way, can I get the offset of hardware pointer in my pcm char device
mmaped area with:

	offset_in_buffer = hw_ptr % buffer_size;  ?

>
> Regards
>
> Takashi Sakamoto
>

--
Ricardo Biehl Pasquali
