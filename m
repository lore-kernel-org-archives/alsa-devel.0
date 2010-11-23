From: Radivoje Jovanovic <radivojejovanovic@gmail.com>
Subject: Re: ALSA throwing buffers away?
Date: Tue, 23 Nov 2010 09:25:51 -0800
Message-ID: <AANLkTinShg1ZAnew63WL8h0BRZszsh5W0f4owp_OAkMA@mail.gmail.com>
References: <AANLkTikppY6oP0Ha7_Hej9uNBubbOUs87cp85yq3SS-X@mail.gmail.com>
	<4CEBF3C5.2050108@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f179.google.com (mail-px0-f179.google.com
	[209.85.212.179])
	by alsa0.perex.cz (Postfix) with ESMTP id EA02D10390A
	for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2010 18:25:58 +0100 (CET)
Received: by pxi20 with SMTP id 20so2407045pxi.38
	for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2010 09:25:57 -0800 (PST)
In-Reply-To: <4CEBF3C5.2050108@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>
> Radivoje Jovanovic wrote:
> > I am developing driver for a really simple hardware. Hardware has codec
> that
> > supports mono/stereo and the amplifier that supports only one speaker so
> the
> > driver has to be mono driver and the codec is setup to manage mono data.
> I
> > have setup ALSA with following parameters:
> >
> > .info =            (SNDRV_PCM_INFO_NONINTERLEAVED |
>
> > Better use SNDRV_PCM_INFO_INTERLEAVED; this is the format used by almost
> > all (stereo) sound cards, and so it is expected even for mono files
> > (where there actually isn't any difference).
>

I am worried about this approach since if I want to play stereo sound  I
would have to increase .channels_max = 2, since if I keep it to 1 ALSA will
report that hw configuration does not match and it will not play stereo at
all. If I increase .channels_max=2 am I going to get only L or R channel for
my mono therefore I will be throwing one channel away?

>

> > after each buffer iteration ALSA skips the buffer length of the data?!
>
> > This might be a problem with the reporting of the DMA pointer.
>
> > Please explain (or show) how your DMA works and how the pointer callback
> > is implemented.
>

       Here is my pointer callback:

     offset=READ_REG16(AUDIO_
CONFIG_DMA_CUR_ADDR_HIGH))<<16) | READ_REG16(AUDIO_CONFIG_DMA_CUR_ADDR_LOW);

    offset = offset - substream->runtime->dma_addr;

    if (offset >= runtime->buffer_size)
        offset = 0;
    return offset;

I am also collecting the data in each interrupt routine from the hardware:

trip:9dc04000 next_trip:9dc08000 current_DMA_Location:9dc04000
ALSA reports from snd_pcm_lib_write1 that is filling the buffer from
0-16384. The first byte of the data ALSA fills is buffer away from where it
should be which is wrong.

trip:9dc08000 next_trip:9dc0c000 current_DMA_Location:9dc08000
ALSA reports from snd_pcm_lib_write1 that is filling the buffer from 16384 -
2*16384. The first byte of the data is exactly 16384 away from the first
byte of previous fill which is 100% correct.

trip:9dc0c000 next_trip:9dc10000  current_DMA_Location:9dc0c000
ALSA reports from snd_pcm_lib_write1 that is filling the buffer from 2*16384
- 3*16384. The first byte of the data is exactly 16384 away from the first
byte of previous fill which is 100% correct.

trip:9dc10000 next_trip:9dc14000 current_DMA_Location:9dc10000
ALSA reports that is filling the buffer from 3*16384 - 4*16384. The first
byte of the data is exactly 16384 away from the first byte of previous fill
which is 100% correct.

trip:9dc14000 next_trip:9dc18000 current_DMA_Location:9dc14000
ALSA reports from snd_pcm_lib_write1 that is filling the buffer from 4*16384
- 5*16384. The first byte of the data is exactly 16384 away from the first
byte of previous fill which is 100% correct.

and this continues to the end of the buffer like this. The buffer size is
524288, period size is 16384 and the interrupts are generated every period
size. All of the info has the jiffies time stamp as well. Out of here I can
see that the hardware is following the buffer correctly and that ALSA is
correctly filling the buffer, but with wrong data.

~cheers,
Ogi


On Tue, Nov 23, 2010 at 9:03 AM, Clemens Ladisch <clemens@ladisch.de> wrote:

> Radivoje Jovanovic wrote:
> > I am developing driver for a really simple hardware. Hardware has codec
> that
> > supports mono/stereo and the amplifier that supports only one speaker so
> the
> > driver has to be mono driver and the codec is setup to manage mono data.
> I
> > have setup ALSA with following parameters:
> >
> > .info =            (SNDRV_PCM_INFO_NONINTERLEAVED |
>
> Better use SNDRV_PCM_INFO_INTERLEAVED; this is the format used by almost
> all (stereo) sound cards, and so it is expected even for mono files
> (where there actually isn't any difference).
>
> > after each buffer iteration ALSA skips the buffer length of the data?!
>
> This might be a problem with the reporting of the DMA pointer.
>
> Please explain (or show) how your DMA works and how the pointer callback
> is implemented.
>
> > I have tried SNDRV_PCM_INFO_INTERLEAVED with the same results (in this
> > case ALSA will not even try to play stereo files using my mono driver).
>
> When using the "default" or "plughw" device, alsa-lib will automatically
> convert the sample format.
>
>
> Regards,
> Clemens
>
