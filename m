From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [RFC] disabling ALSA period interrupts
Date: Thu, 13 May 2010 08:37:12 +0800
Message-ID: <AANLkTinHc24MCBc0vBQB3WARiIfcYMRQ_WCKabKUtEIc@mail.gmail.com>
References: <h2l6160a5131004291538w6c7891fbn2db3425846aefd60@mail.gmail.com>
	<20100507232516.GB16910@tango.0pointer.de>
	<AANLkTil2wLMXsRwNGpeCfduwK-hmtbYyN4tki51m-S0X@mail.gmail.com>
	<AANLkTimBQOoQGFoPZ8T7nRrDKhsylLNiqkeQ-HinIeyV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f179.google.com (mail-px0-f179.google.com
	[209.85.212.179])
	by alsa0.perex.cz (Postfix) with ESMTP id EB93024604
	for <alsa-devel@alsa-project.org>;
	Thu, 13 May 2010 02:37:13 +0200 (CEST)
Received: by pxi13 with SMTP id 13so372499pxi.38
	for <alsa-devel@alsa-project.org>; Wed, 12 May 2010 17:37:12 -0700 (PDT)
In-Reply-To: <AANLkTimBQOoQGFoPZ8T7nRrDKhsylLNiqkeQ-HinIeyV@mail.gmail.com>
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

2010/5/12 pl bossart <bossart.nospam@gmail.com>

> > Some care would need to be taken with regards to detecting xruns.
> > I think the alsa code currently uses the interrupt callback to detect
> this.
> > I have seen a Windows 7 machine happily loop the audio buffer
> > uncontrollably, so I assume it has problems detecting xruns as well.
>
> When the PulseAudio timer fires, the use of snd_pcm_avail() will force
> a call to .pointer and will detect underflows. PulseAudio modilfies
> its watermark when underflows occur so that more time is allocated to
> refilling the ring buffer.
> There are probably some cases I didn't plan for, but on paper I don't
> really see a show-stopper here.
>
> > Some sound card hardware only updates the hw pointer at around dma
> > interrupt event time, so again using the interrupt is used to improve
> > the accuracy of the hw pointer with interpolation used between
> > interrupts.
>
> If the hardware doesn't provide an accurate hw pointer, then the
> timer-based scheduling should not be used I agree.
>

How accurate do timer-based scheduling need ?

e.g. accuracy up to +/- 5% of period size

or the watermark is too low for those sound card

can PA provide option to change the initial watermark ?


>
> > Some sound card hardware has very small hardware buffers, so PA will
> > have to be waking up as often as the dma interrupts in order to keep
> > the audio hardware buffers full enough.
> > In how many cased would PA have to wake up less often than the DMA
> interrupt?
>
> This patch is mainly for music playback where you have more than 2s
> buffered in the ring buffer.


Do you mean that  those application require low latency will fail with
underrun ?

seem the usuage of PA is quite limited

Can PA provide an option to increase the number of wake up for those desktop
user which power consumption is not important ? ( default- fragments )

it seem (disable timer option ) of new PA version is not as same as the
Traditional mode of old PA version anymore


> PulseAudio will wake-up after 1.9s or so,
> as the ring buffer becomes empty, and when it does the wake-up may be
> grouped with other system events with the timer slack. Having one or
> more interrupts in the middle or the ring buffer will reduce the
> efficiency of sleep modes that are being introduced with Moorestown
> and future Atom-based SOCs.
> So again this patch isn't for everyone. All standard disclaimers
> apply, if you have a pre-existing conditon tell your doctor etc. If
> there's a 4K ring buffer, this is not useful.


au88x0 has 4 set of hardware registers each with 4 K buffers ( i.e. total 16
K bytes)

PA work quite nicely with 2 periods per buffer on PA 1.0.13 but some user
reported cracking noise when new PA 1.0.14 or later version use 8 periods
per buffer


> If your hardware is
> broken, stay the course with the current solution. If PulseAudio is
> disabled in your distro, this is of no interest to you. In all these
> cases, this patch doesn't change anything, the behavior is the same.
> But if you want to optimize for power and latency isn't a concern,
> then these interrupts can be disabled and need to.
>
>
