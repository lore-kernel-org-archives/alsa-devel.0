From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: safe support for rewind in ALSA
Date: Tue, 9 Feb 2010 06:59:45 +0800
Message-ID: <4f3252891002081459q29f02414hf168a596ab641995@mail.gmail.com>
References: <6160a5131002010920j4417a34ai9f410fb500f7f305@mail.gmail.com>
	<20100201180139.GC15509@sirena.org.uk>
	<alpine.LNX.2.00.1002011903330.25340@eeebox2.perex-int.cz>
	<alpine.DEB.1.10.1002012239220.3125@ecabase.localdomain>
	<alpine.DEB.1.10.1002012328440.3125@ecabase.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f171.google.com (mail-pz0-f171.google.com
	[209.85.222.171])
	by alsa0.perex.cz (Postfix) with ESMTP id C1D46103805
	for <alsa-devel@alsa-project.org>; Mon,  8 Feb 2010 23:59:46 +0100 (CET)
Received: by pzk1 with SMTP id 1so570123pzk.16
	for <alsa-devel@alsa-project.org>; Mon, 08 Feb 2010 14:59:45 -0800 (PST)
In-Reply-To: <alpine.DEB.1.10.1002012328440.3125@ecabase.localdomain>
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

2010/2/2 Kai Vehmanen <kvehmanen@eca.cx>

> Hi all,
>
> and then about the "other problem", e.g. of rewinding with drivers/HW that
> do burst transfers of samples from ALSA ringbuffer to a separate HW
> buffer. Uh oh, and what the subject says this thread is ought to be
> about.:)
>
> On Mon, 1 Feb 2010, Kai Vehmanen wrote:
>
> > So while snd_pcm_delay() provides a snapshot of the delay at the last DMA
> > burst/block-transfer (when hw_ptr+runtime->delay were last updated in the
> > driver), the information may be refined with snd_pcm_status_get_tstamp(),
> > which essentially tells the diff between T1&T3. So essentially what the
> > application is looking for is 'snd_pcm_delay()-(T3-T1)'.
> [...]
> > One idea is to tie this to the existing SNDRV_PCM_INFO_BATCH flag (e.g.
> > quoting existing documentation in pcm_local.h -> "device transfers
> samples in
> > batch"). So if the PCM has this flag set, application should interpret
> > snd_pcm_delay() results as referring to the last batch.
>
> Maybe the same INFO_BATCH flag could be used to help solve the rewind
> problem as well. If set, it is a signal that a segment of the ringbuffer
> (N samples after current hw_ptr) may have been already transferred, or is
> currently in transfer, and cannot be rewound (without stopping the stream
> and causing a glitch), but the elapsed callback and hw_ptr have not yet
> occured. And most importantly, when pointer() cb reports that hw_ptr jumps
> in bursts, so current snd_pcm_rewindable() implementation may not be
> accurate with these drivers.
>
> But then how much is N? I guess we can't assume N=period-size (does not
> apply for e.g. how pulseaudio uses ALSA in glitch free mode).
> Sw-params:xfer-align is not the same thing plus it's now deprecated. Any
> ideas?
>
> Hmm, or on a second though, maybe N=period-size is a good idea after all.
> E.g. drivers would configure the DMA transfers according to the
> hwparams:period-size, and apps such as pulseaudio could decide (by setting
> the period-size) how close to hw-ptr it wants to live (and still rewind if
> needed). Of course, it's not obvious how useful PA glitch-free is if used
> in this way...
>
> For applications, this would be hidden in the implementation of
> snd_pcm_rewindable() and snd_pcm_rewind() (they would check for
> INFO_BATCH and limit rewinding appropriately).
>
> PS Like with my earlier mail, I'm not 100% convinced this is a generic
>    enough approach (or if the wider community thinks this is
>    a serious enough of a problem), but with these proposals I'm
>    thinking what can be done within the scope of current (driver)
>    APIs...
>
>
>>  - at T3, application calls snd_pcm_delay() to query how many samples
>>   of delay there is currently (e.g. if it write a sample to ALSA
>>   PCM device now, how long before it hits the speaker)

No, your assumption (how long before it hits the speaker ) is wrong , refer
to

http://www.alsa-project.org/alsa-doc/alsa-lib/group___p_c_m.html

For playback the delay is defined as the time that a frame that is written
to the PCM stream shortly after this call will take to be actually audible.
It is as such the overall latency from the write call to the final DAC.

For capture the delay is defined as the time that a frame that was digitized
by the audio device takes until it can be read from the PCM stream shortly
after this call returns. It is as such the overall latency from the initial
ADC to the read call.
(e.g. the latency of decoding those AC3 or DTS pass through spdif by the
digital receiver is not included)

How about those sound cards which only support non-inteleaved mode ?

why do PA insist to use one period per buffer when only those ISA drivers
and intel8x0 have periods_min =1 , the most common HDA driver and most sound
cards have periods_min =2 ?
