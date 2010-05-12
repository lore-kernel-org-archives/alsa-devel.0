From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: Re: [RFC] disabling ALSA period interrupts
Date: Wed, 12 May 2010 08:22:19 +0100
Message-ID: <AANLkTil2wLMXsRwNGpeCfduwK-hmtbYyN4tki51m-S0X@mail.gmail.com>
References: <h2l6160a5131004291538w6c7891fbn2db3425846aefd60@mail.gmail.com>
	<20100507232516.GB16910@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 4224B2495B
	for <alsa-devel@alsa-project.org>;
	Wed, 12 May 2010 09:22:20 +0200 (CEST)
Received: by fxm2 with SMTP id 2so4057610fxm.38
	for <alsa-devel@alsa-project.org>; Wed, 12 May 2010 00:22:20 -0700 (PDT)
In-Reply-To: <20100507232516.GB16910@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pl bossart <bossart.nospam@gmail.com>, alsa-devel@alsa-project.org, General PulseAudio Discussion <pulseaudio-discuss@mail.0pointer.de>
List-Id: alsa-devel@alsa-project.org

On 8 May 2010 00:25, Lennart Poettering <mznyfn@0pointer.de> wrote:
> On Thu, 29.04.10 17:38, pl bossart (bossart.nospam@gmail.com) wrote:
>
>> Howdy,
>> When PulseAudio is used and all PCM is routed through PulseAudio
>> (Fedora, Meego, etc), the notion of ALSA periods isn't very useful.
>> PulseAudio uses a timer to refill buffers and the period interrupts
>> are not used at all.
>
> This patch looks very interesting and desirable. This is something have
> long been waiting for.
>
> I wonder how this actually relates to
> snd_pcm_sw_params_set_period_event() though.
>
>> So why not disable them entirely to reduce the number of wakeups? This
>> is possible with a number of existing DMA controllers. The simple
>> patch attached shows a proof-of-concept on HDAudio, it's been working
>> for 5 hours on my Fedora12 laptop without any glitches and powertop
>> does show _zero_ wakeups from the HDAudio controller (except on
>> startup). I am told by my colleagues working in Windows environments
>> that this is what's done on Vista/Windows7 btw. This isn't to say
>> Windows is great but that artificial generation of not-needed
>> interrupts is avoidable.
>>
>> There are probably some cases where you don't want this type of
>> behavior (broken hardware, legacy code with multiple-buffering,
>> disabled timer in PulseAudio), so I think it would make sense to
>> request the disabling of interrupts when hw_params are set, since this
>> is also the time when period sizes are set. I am aware that some
>> changes would be needed in pcm_lib.c, where all the error checks are
>> done. Takashi, Jaroslav, Lennart, what do you think?
>
> I am sold!
>
> Lennart
>

Some care would need to be taken with regards to detecting xruns.
I think the alsa code currently uses the interrupt callback to detect this.
I have seen a Windows 7 machine happily loop the audio buffer
uncontrollably, so I assume it has problems detecting xruns as well.
Some sound card hardware only updates the hw pointer at around dma
interrupt event time, so again using the interrupt is used to improve
the accuracy of the hw pointer with interpolation used between
interrupts.
Some sound card hardware has very small hardware buffers, so PA will
have to be waking up as often as the dma interrupts in order to keep
the audio hardware buffers full enough.
In how many cased would PA have to wake up less often than the DMA interrupt?
