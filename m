From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: How to pair Wine with ALSA? part2: buffer&period
 size / blocking / mmap (long)
Date: Sun, 14 Aug 2011 14:23:02 +0200
Message-ID: <4E47BE26.7060705@ladisch.de>
References: <8E4C156DA5797D418DBFADFD8CE655A4138FB4724E@HE113481.emea1.cds.t-internal.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 622912489A
	for <alsa-devel@alsa-project.org>;
	Sun, 14 Aug 2011 14:23:21 +0200 (CEST)
In-Reply-To: <8E4C156DA5797D418DBFADFD8CE655A4138FB4724E@HE113481.emea1.cds.t-internal.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Joerg-Cyril.Hoehle@t-systems.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Joerg-Cyril.Hoehle@t-systems.com wrote:
 > Topic T2 period and buffer size and time
 >
 > Wine apps using the old winmm API cannot tell at waveOutOpen time
 > "give me a large buffer" or "give me fast reaction to explosions".

AFAIK the WinMM API allows to vary the number and size of submitted
buffers arbitrarily even while the stream is running.  This was designed
for hardware that is reprogrammed after each buffer anyway (ISA DMA) or
that allows dynamic buffers (e.g. ICH AC'97, which was designed for
WinMM).

 > R6 A good compromise is needed for when Wine opens ALSA on behalf of winmm.

Let's assume that ALSA is configured for a certain buffer size.  If the
application does not submit as much data, the ALSA buffer is never full.
(This is not a problem, except that the time until an xrun happens is,
of course, shorter.  PulseAudio does exactly this if it wants to
decrease latency dynamically.)  OTOH, if the application submits more
data than fits into the buffer, Wine must write the remaining data when
some space has become available.

This suggests to use a buffer as big as possible (for the hardware).

 > Years later, the mmdevapi introduced with Vista provides "period"
 > and duration parameters.  It also implements sort of a
 > dmix device: it appears to mix at a fixed rate (48000 or 44100
 > samples/sec, user settable) and to mix data in packets of 10ms.
 > Incidentally, that's why MS claims 10ms latency.
 > For compatibility, Wine should match that rate -- at least when
 > accessing the "default" device.
 >
 > Does that really translate to set_period_time?  I doubt it.
 > [...]
 > I expect that setting Wine's timer period to at least ALSA's allows it
 > to actually find room for new data each turn.

The meaning of ALSA's periods is as follows:
1) The hardware is configured to generate an interrupt every period_size
    samples.  (Please note that the buffer size is not necessarily
    an integer multiple of that.)
2) When ALSA is blocked (in snd_pcm_write* or in poll), it checks
    whether to wake up the application only when an interrupt arrives.

 > [...] Finally, there's that snd_pcm_sw_params_set_avail_min
 > whose purpose I cannot figure out.  Should Wine call
 > snd_pcm_sw_params_set_avail_min(1); or
 > snd_pcm_sw_params_set_avail_min(0);
 > or not at all?

This is an additional restriction on when to wake up.

The device is considered 'ready' (i.e., the application is to be woken
up so that new data can be written) if the number of available (free)
samples in the buffer is at least avail_min.  avail_min=0 does not make
sense.

 > Topic T2.b Duration / buffer size
 >
 > mmdevapi's Initialize method receives a duration parameter as a hint
 > towards either small latency or large buffering.  One would think that
 > it makes perfect sense to forward that to snd_pcm_set_buffer_time.
 >
 > *However*, mmdevapi also requires to hand out a pointer to a buffer
 > that large (GetBuffer).  Thus Wine must maintain a buffer that large
 > (possibly even two of them, for reasons not relevant here).
 > Now should ALSA really keep yet another buffer that large?

Can't you hand out a pointer to ALSA's buffer?

 > I'm wondering whether Wine should solely rely on its periodic timer to
 > regularly submit data and e.g. ask ALSA to use a buffer 3 times the
 > period?
 > 30ms (3x10ms) seems to play a role in MS systems.
 > Dmix seems to prefer 4 to 6 times period size.

Now you are trying to do what PulseAudio does.
Why not simply use PA instead of ALSA?

 > Unfortunately, snd_pcm_get_period_time may be known only after
 > invoking snd_pcm_hw_params(),

Indeed.

 > so I can't express:
 > set_period_time_near(10ms);
 > set_buffer_time_near(3 x actual_period);

Yes you can:
   set_period_time_near(10ms);
   set_periods_near(3);

 > Topic T3 blocking or not
 >
 > Wine has traditionally used ALSA in non-blocking mode, which ALSA
 > people recommended against (still?).

Non-blocking mode is perfectly fine if you're using poll() to wait for
other events at the same time.

 > I've read that snd_pcm_open() may be delayed because of networking
 > issues, which I want to avoid in the audio thread.

This has nothing to do with networking; snd_pcm_open without NONBLOCK
just waits for the device to be closed.  This behaviour is there for
historical reasons; in practice, you always want NONBLOCK.

 > Therefore I'm considering using:
 >
 > snd_pcm_open(SND_PCM_NONBLOCK);
 > ... setup hw&sw_params
 > snd_pcm_prepare()
 > snd_pcm_nonblock(0); /* or should it be called before prepare? */

You can call nonblock(0) immediately after open.
But if your code never actually blocks, why bother to set it?

 > Topic T4 mmap
 > [...]
 > Hence, as an optimization, one could imagine a driver using mmap,

What exactly gets optimized with mmap?  Please note that snd_pcm_write*
copies the data from the supplied buffer into ALSA's buffer; if your
code does the same, it is not the slightest bit faster.


Regards,
Clemens
