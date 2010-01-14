From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: capturing data from the microphone
Date: Thu, 14 Jan 2010 15:49:31 +0800
Message-ID: <4f3252891001132349j1cbe2572xc96bf3ac3d6cc210@mail.gmail.com>
References: <4B4227BC.70705@gmail.com>
	<6160a5131001050848r48f9c6ecw4db2e56bb6fd7533@mail.gmail.com>
	<4B43B949.5010702@gmail.com>
	<4f3252891001061559p71933643wcbb59ede24ac29aa@mail.gmail.com>
	<4B46293A.3040600@gmail.com> <4B4B2EA7.2080504@gmail.com>
	<alpine.LNX.2.00.1001111500470.4210@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f53.google.com (mail-pw0-f53.google.com
	[209.85.160.53])
	by alsa0.perex.cz (Postfix) with ESMTP id BADEE10385E
	for <alsa-devel@alsa-project.org>; Thu, 14 Jan 2010 08:49:32 +0100 (CET)
Received: by pwj3 with SMTP id 3so4906721pwj.32
	for <alsa-devel@alsa-project.org>; Wed, 13 Jan 2010 23:49:31 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1001111500470.4210@eeebox2.perex-int.cz>
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

2010/1/11 Jaroslav Kysela <perex@perex.cz>

> On Mon, 11 Jan 2010, Riccardo Magliocchetti wrote:
>
> > Riccardo Magliocchetti ha scritto:
> >> Raymond Yau ha scritto:
> >>> 2010/1/6 Riccardo Magliocchetti <riccardo.magliocchetti@gmail.com>
> >>>
> >>>> Hi Pierre,
> >>>>
> >>>> pl bossart ha scritto:
> >>>>> You haven't specified the buffer/period size in the hw params. See
> >>>>> alsa-lib/test/pcm.c
> >>>>> - Pierre
> >>>> They fail when opening default device so I had to remove them, work
> fine
> >>>> when opening
> >>>> plughw:0,0 though.
> >>>>
> >>>>> On Mon, Jan 4, 2010 at 11:39 AM, Riccardo Magliocchetti
> >>>>> <riccardo.magliocchetti@gmail.com> wrote:
> >>>>>> [the same message is waiting in moderator queue, sorry if you
> >>>>>> receive it
> >>>> two times]
> >>>>>> Hello,
> >>>>>>
> >>>>>> i'm trying to capture audio data from the microphone, but i'm not
> able
> >>>> to
> >>>>>> read any frames.
> >>>>>> The frames are always 0 and delay is fixed to 2730. I've tried
> calling
> >>>>>> snd_pcm_avail_delay,  snd_pcm_avail_update but does not make a
> >>>> difference.
> >>>>>> The soundcard is driven by  snd_hda_intel. The code is more or less
> >>>>>> the
> >>>>>> same as Paul Davis' tutorial on using the alsa api.
> >>
> >>>
> >>> Even 4096 bytes is x86 DMA page size , seem to be a good choice for
> those
> >>> PCI sound cards, however you cannot assume all sound cards/plugins
> >>> support
> >>> this buffer size
> >>>
> >>> If you did not set period_size, buffer_size or periods (period_time,
> >>> buffer_time or periods)  , you should call
> >>> snd_pcm_hw_params_get_buffer_size() and
> >>> snd_pcm_hw_params_get_period_size()
> >>> after snd_pcm_hw_params()
> >>
> >> Thank you both Pierre and Raymond, using the get functions after
> >> snd_pcm_hw_params() is working, now i have some concurrency issues to
> >> resolve before i can say everything is working properly.
> >
> > The init works fine but snd_pcm_avail() always returns 0, full code is
> here
> > http://pastebin.com/f687bf37a
>
> The PCM stream must be triggered via snd_pcm_start() or using
> snd_pcm_read*() when sw_param->start_threshold is set appropriately.
>
>                                        Jaroslav
>
>

Are there any PCM state diagram ?

http://equalarea.com/paul/alsa-audio.html

http://www.alsa-project.org/main/index.php/Tutorials_and_Presentations

The tutorial program call snd_pcm_hw_params_free() before any playback and
capture, this cause au88x0 fail since callback snd_vortex_pcm_hw_free()
delete the dynamic route between SRC , mixer


		if ((err = snd_pcm_hw_params (playback_handle, hw_params)) < 0) {
			fprintf (stderr, "cannot set parameters (%s)\n",
				 snd_strerror (err));
			exit (1);
		}
	
		snd_pcm_hw_params_free (hw_params);
	
		if ((err = snd_pcm_prepare (playback_handle)) < 0) {
			fprintf (stderr, "cannot prepare audio interface for use (%s)\n",
				 snd_strerror (err));
			exit (1);
		}
