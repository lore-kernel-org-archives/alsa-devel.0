From: Appalayagari Sreedhar <sreecha01@gmail.com>
Subject: Re: pcm timer resolution out of range (rate = 0,
 period_size = 1), Division by zero in kernel
Date: Fri, 30 Dec 2011 16:01:14 +0530
Message-ID: <CAODvfaH3h1BYT_-gnbvsaNt_LEEPhhXLTjia9G=6v39CWppqzQ@mail.gmail.com>
References: <CAODvfaGXziDeSAic-Rg_dBJYWeObgcQhmcy4=vNBL30Mc6GQQg@mail.gmail.com>
	<CAN8cciaqyw=OJ3+2GbM6rqaQ+VLDbfijqgMZTODnQ-PffzDyaQ@mail.gmail.com>
	<CAODvfaEX3A+Umgqw9eLoY-xe_NxC_yDnRNvRWk=NrGQ5-KP1Wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 0CC26243BF
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2011 11:31:15 +0100 (CET)
Received: by ggnv5 with SMTP id v5so8824663ggn.38
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2011 02:31:15 -0800 (PST)
In-Reply-To: <CAODvfaEX3A+Umgqw9eLoY-xe_NxC_yDnRNvRWk=NrGQ5-KP1Wg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

any suggestion for me to resolve this issue?

-Sreedhar


On 12/23/11, Appalayagari Sreedhar <sreecha01@gmail.com> wrote:
> Hi Raymond,
>
> We are working with DM368 processor and cx20709 conexant external
> codec interfaced via McBSP.
>
> The davinci pcm hw params is below. (from davinci-pcm.c file)
>
> static struct snd_pcm_hardware davinci_pcm_hardware = {
>         .info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER
> |
>                  SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID |
>                  SNDRV_PCM_INFO_PAUSE),
>         .formats = (SNDRV_PCM_FMTBIT_S16_LE),
>         .rates = (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |
>                   SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_32000 |
>                   SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
>                   SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000 |
>                   SNDRV_PCM_RATE_KNOT),
>         .rate_min = 8000,
>         .rate_max = 96000,
>         .channels_min = 2,
>         .channels_max = 2,
>         .buffer_bytes_max = 128 * 1024,
>         .period_bytes_min = 32,
>         .period_bytes_max = 8 * 1024,
>         .periods_min = 16,
>         .periods_max = 255,
>         .fifo_size = 0,
> };
>
> and we are configuring from user space using OSS ioctl for Speed.
> Format and Bits Per Sample.
>
> Speed = 8kHz/16kHz
> Format = AFMT_S16LE
> Bits Per Sample = 16
> Channels = Stereo/Mono
>
> I am new to ALSA and OSS. Please let me know if you need further details.
>
> Thank you,
> Sreedhar.
>
>
> On 12/23/11, Raymond Yau <superquad.vortex2@gmail.com> wrote:
>> 2011/12/22, Appalayagari Sreedhar <sreecha01@gmail.com>:
>>> Hi,
>>>
>>> We are working with 2.6.32 kernel. we are working with ALSA model
>>> codec driver for conexant chipset. we are using OSS emulation for
>>> audio playback and recording.
>>>
>>> we are not setting the fragmenttaion block using OSS ioctl function
>>> (SNDCTL_DSP_SETFRAGMENT) , assuming that it will be taken care by the
>>> ALSA framework based on the sampling rate, bits per sample etc.
>>>
>>> we are facing the below issue randomly.
>>>
>>> ALSA sound/core/pcm_timer.c:71: -calling VIDIOC_pcm timer resolution
>>> out of range (rate = 0, period_size = 1)
>>> Division by zero in kernel.
>>
>> Do your controller really support 1 frame per period (period_size = 1) ?
>>
>> What is the value of .period_bytes_min and other parameters in
>> snd_pcm_hardware and format supported ?
>>
>>>
>>> We tried to program the fragmentation block after the sampling rate,
>>> bits per sample etc are configured. it is working fine for 5 or 6
>>> iterations for recording and playback.
>>>
>>> after that the audio quality is gone bad. the audio is not smooth and
>>> it is sharp.
>>>
>>> could you please help to resolve this problem.
>>>
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
>
