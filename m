From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: [RFC] disabling ALSA period interrupts
Date: Fri, 14 May 2010 08:36:56 -0500
Message-ID: <AANLkTiljN2IuWnI1g3BsVux33VcnMeCAwBZl7kexDPvU@mail.gmail.com>
References: <h2l6160a5131004291538w6c7891fbn2db3425846aefd60@mail.gmail.com>
	<4BDABDDD.4050502@ladisch.de>
	<w2s6160a5131004300644o3aedd30bvf0d13a7f9e758575@mail.gmail.com>
	<s5hsk5uq4u4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id BD94A2453B
	for <alsa-devel@alsa-project.org>;
	Fri, 14 May 2010 15:36:58 +0200 (CEST)
Received: by gyd10 with SMTP id 10so1129894gyd.38
	for <alsa-devel@alsa-project.org>; Fri, 14 May 2010 06:36:57 -0700 (PDT)
In-Reply-To: <s5hsk5uq4u4.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: General PulseAudio Discussion <pulseaudio-discuss@mail.0pointer.de>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

> The biggest problem I can foresee is the handling of PCM position.
> In the current implementation, the PCM position continues to go over
> the buffer size until the certain boundary that is close to long int
> max. =A0Without interrupts (i.e. snd_pcm_period_elapsed()), this
> position update won't work reliably. =A0If we reduce boundary size as
> buffer size, certainly some code in alsa-lib (or kernel PCM) would be
> confused.

Good catch. I thought the processing was the same whether you called
snd_pcm_period_elapsed or snd_pcm_avail when the timer fires, since in
both cases you call the .pointer routine, but there's some code in
snd_pcm_update_hw_ptr0 that is only executed in an interrupt context.
Likewise there are a bunch of fixes for hw_ptr position that make use
of this boundary field (which I have to admit I don't understand too
much).

> BTW, I'm still wondering whether disabling the IRQ would really give
> so much gain compared with periods=3D1 or 2 case. =A0I thought all this
> was about the power-saving, no? =A0Did someone measure a significant
> difference between periods=3D0 and periods=3D2 in this regard?

I don't have data I can post on this mailing list without running into
trouble with legal. For low-power playback where we chase milliwatts,
waking up for no good reason isn't very compatible with the S0i2 modes
defined from Moorestown onwards. In S0i2 the platform is mostly off
which the exception of the audio rendering cluster that is
clocked/powered independently. The entry/exit latency is higher than
for regular C states and the transition costs make you want avoid
isolated interrupts. There's a slew of patches coming from Intel to
introduce timer slacks everywhere, my proposal follows the same idea
of avoiding wakeups and grouping events.
We also have a different use case where we want the ring buffer to be
refilled when a modem provides data. The modem events and ALSA periods
may not be aligned, the delta between events isn't predictable, and
that leads to doubling the number of wake-ups since we need to handle
modem events and ALSA events. Again this interferes with cpuidle
heuristics and prevents the entry in sleep states.
