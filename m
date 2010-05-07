From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: [alsa-devel] [RFC] disabling ALSA period
	interrupts
Date: Sat, 8 May 2010 01:25:16 +0200
Message-ID: <20100507232516.GB16910@tango.0pointer.de>
References: <h2l6160a5131004291538w6c7891fbn2db3425846aefd60@mail.gmail.com>
Reply-To: General PulseAudio Discussion <pulseaudio-discuss@mail.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <pulseaudio-discuss-bounces@mail.0pointer.de>
Content-Disposition: inline
In-Reply-To: <h2l6160a5131004291538w6c7891fbn2db3425846aefd60@mail.gmail.com>
List-Unsubscribe: <https://tango.0pointer.de/mailman/options/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@mail.0pointer.de?subject=unsubscribe>
List-Archive: <https://tango.0pointer.de/pipermail/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@mail.0pointer.de>
List-Help: <mailto:pulseaudio-discuss-request@mail.0pointer.de?subject=help>
List-Subscribe: <https://tango.0pointer.de/mailman/listinfo/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@mail.0pointer.de?subject=subscribe>
Sender: pulseaudio-discuss-bounces@mail.0pointer.de
Errors-To: pulseaudio-discuss-bounces@mail.0pointer.de
To: pl bossart <bossart.nospam@gmail.com>
Cc: General PulseAudio Discussion <pulseaudio-discuss@mail.0pointer.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 29.04.10 17:38, pl bossart (bossart.nospam@gmail.com) wrote:

> Howdy,
> When PulseAudio is used and all PCM is routed through PulseAudio
> (Fedora, Meego, etc), the notion of ALSA periods isn't very useful.
> PulseAudio uses a timer to refill buffers and the period interrupts
> are not used at all.

This patch looks very interesting and desirable. This is something have
long been waiting for.

I wonder how this actually relates to
snd_pcm_sw_params_set_period_event() though.

> So why not disable them entirely to reduce the number of wakeups? This
> is possible with a number of existing DMA controllers. The simple
> patch attached shows a proof-of-concept on HDAudio, it's been working
> for 5 hours on my Fedora12 laptop without any glitches and powertop
> does show _zero_ wakeups from the HDAudio controller (except on
> startup). I am told by my colleagues working in Windows environments
> that this is what's done on Vista/Windows7 btw. This isn't to say
> Windows is great but that artificial generation of not-needed
> interrupts is avoidable.
> 
> There are probably some cases where you don't want this type of
> behavior (broken hardware, legacy code with multiple-buffering,
> disabled timer in PulseAudio), so I think it would make sense to
> request the disabling of interrupts when hw_params are set, since this
> is also the time when period sizes are set. I am aware that some
> changes would be needed in pcm_lib.c, where all the error checks are
> done. Takashi, Jaroslav, Lennart, what do you think?

I am sold!

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
