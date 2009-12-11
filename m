From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: hw_ptr accuracy with intel8x0 -> PulseAudio issue
Date: Fri, 11 Dec 2009 09:14:48 +0800
Message-ID: <4f3252890912101714l1fe24128y4b527a7f10fa7a85@mail.gmail.com>
References: <6160a5130912020115t45bd4635hceb0ac3de4fb1efe@mail.gmail.com>
	<6160a5130912030828m5b2401f3w31a67b6b51e8d8b6@mail.gmail.com>
	<4f3252890912031442i56ccc905g935a4d6ed48f40c6@mail.gmail.com>
	<6160a5130912031650u5949c921jc86d0847b2844803@mail.gmail.com>
	<4f3252890912041817u7ab83a3eh7643476d64d709f3@mail.gmail.com>
	<s5h4oo1sisn.wl%tiwai@suse.de>
	<4f3252890912090355n70a2b5cfu4fbb74d473480a94@mail.gmail.com>
	<s5hr5r4ntus.wl%tiwai@suse.de>
	<4f3252890912091941y34509e3brd235360485c8c967@mail.gmail.com>
	<6160a5130912100644m7f090fdaxaa193737441c337d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f53.google.com (mail-pw0-f53.google.com
	[209.85.160.53])
	by alsa0.perex.cz (Postfix) with ESMTP id CB9071037EE
	for <alsa-devel@alsa-project.org>; Fri, 11 Dec 2009 02:14:49 +0100 (CET)
Received: by pwi18 with SMTP id 18so722225pwi.32
	for <alsa-devel@alsa-project.org>; Thu, 10 Dec 2009 17:14:48 -0800 (PST)
In-Reply-To: <6160a5130912100644m7f090fdaxaa193737441c337d@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2009/12/10 pl bossart <bossart.nospam@gmail.com>

> > 2) why PA use  snd_pcm_hw_params_get_buffer_size_max() instead of
> > snd_pcm_hw_params_get_buffer_size() after snd_pcm_hw_params() ?
>
> Precisely to use the maximum preallocated buffer size.
>

The driver only allocate 8K bytes for the substream when the application
request 2 fragments and 64 Kbytes when the application request 16 fragments

It is wrong for PA to think that 371ms is the buffer size on pulseaudio
0.9.21

If the user select 8 fragements in deamon.conf , the pulseaudio-0.9.21 still
calculated the wrong buffer time and wakeup time.

Do you know what is PA 's "hwbuf_unused_frames"  ?


/* hw_params callback */
static int
snd_vortex_pcm_hw_params(struct snd_pcm_substream *substream,
			 struct snd_pcm_hw_params *hw_params)
{
	vortex_t *chip = snd_pcm_substream_chip(substream);
	stream_t *stream = (stream_t *) (substream->runtime->private_data);
	int err;

	// Alloc buffer memory.
	err =
	    snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params));




>
> > I: module-alsa-sink.c: Using 2 fragments of size 4096 bytes, buffer time
> is
> > 46.44ms
> > D: alsa-util.c:   buffer_size  : 2048
> > D: alsa-util.c:   period_size  : 1024
>
> With small buffers like this, I don't see the point of the timer-based
> scheduling, you will have one interrupt every 23ms.
>
>
au8810, au8820 and au8830 were designed for those 3D sound game (low
latency) and support multiple DMA connections (i.e. hardware mixing ) , they
does not need any sound server (software mixing) at all.


>
> > 5) it seem bug in snd_pcm_sw_params_set_avail_min() since 4661 is larger
> > than the buffer size 2048 since PA still think that 371ms is the maximum
> > buffer size
> >
> >
> > D: alsa-util.c:   buffer_size  : 2048
> > D: alsa-util.c:   period_size  : 1024
> > D: alsa-util.c:   period_time  : 23219
> > D: alsa-util.c:   tstamp_mode  : NONE
> > D: alsa-util.c:   period_step  : 1
> > D: alsa-util.c:   avail_min    : 4661
>
> This doesn't make sense. But avail_min isn't really used with the
> timer-based scheduling
>
>
Are you sure ?


> >
> > For pulseaudio-0.9.14 on Fedora 10
>
> Man, you are using an old version here, the alsa sink code was changed
> several times already.
>

PA 0.9.14 run quite well with my au8830 with 2 fragements on Fedora 10 but
PA 0.9.19 run badly on hypersonic 's au8830 on Karmic

It seem to be regression of PA

The possible reasons may be

1) PA 's 20ms process time  may not enough for hyper_sonic 's CPU ( ICH2 or
ICH4 since he is using intelx8x0)  and  I am a faster CPU since my
motherboard is using HDA ( ICH8)

2) PA may only handle 1 or 2 periods or use the wrong buffer size in
calculating the watermark

3) snd_pcm_rewindable() is returning a wrong value since au88x0 has FIFO
buffer as described in the patent )

http://0pointer.de/blog/projects/pulse-glitch-free.html

The rewriting of the client buffers causing rewriting of the hardware buffer
complicates the resampling/converting step immensly. In general the code to
implement this model is more complex than for the traditional model. Also,
ALSA has not really been designed with this design in mind, which makes some
things very hard to get right and suboptimal.

The transfer of the audio data (48000Hz) only occur at ac97 link between
AC97 codec and AC97 controller. The AC97 controller fetch audio from memory
at the rate of PCI bus instead of the sampling rate of the audio. Therefore
rewind the application pointer to hardware pointer and immediate rewrite  is
almost impossible

4) the default fragments in daemon.conf seem oboselte in PA 0.9.21 but there
is no proper documentation
