From: Joerg-Cyril.Hoehle@t-systems.com
Subject: How to pair Wine with ALSA? part2: buffer&period size
 / blocking / mmap (long)
Date: Fri, 12 Aug 2011 14:24:43 +0200
Message-ID: <8E4C156DA5797D418DBFADFD8CE655A4138FB4724E@HE113481.emea1.cds.t-internal.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tcmail53.telekom.de (tcmail53.telekom.de [217.5.214.110])
	by alsa0.perex.cz (Postfix) with ESMTP id EC1392437E
	for <alsa-devel@alsa-project.org>;
	Fri, 12 Aug 2011 14:24:55 +0200 (CEST)
Content-Language: de-DE
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

Dear ALSA developers,

[Please refer to part1:intro & underruns for the introductory text]
http://mailman.alsa-project.org/pipermail/alsa-devel/2011-August/042746.html

Topic T2 period and buffer size and time

Wine apps using the old winmm API cannot tell at waveOutOpen time
"give me a large buffer" or "give me fast reaction to explosions".

R6 A good compromise is needed for when Wine opens ALSA on behalf of winmm.

Years later, the mmdevapi introduced with Vista provides "period"
and duration parameters.  It also implements sort of a
dmix device: it appears to mix at a fixed rate (48000 or 44100
samples/sec, user settable) and to mix data in packets of 10ms.
Incidentally, that's why MS claims 10ms latency.
For compatibility, Wine should match that rate -- at least when
accessing the "default" device.

Does that really translate to set_period_time?  I doubt it.
I wonder why Wine up to now insists on particular ALSA buffer and
period sizes.  I tend to consider it's none of its business.

It might make sense for Wine to use a periodic timer that calls
snd_pcm_write (see T3 below).  *That* timer should be set to
mmdevapi's 10ms.
Doesn't that translate to set_period_time_*max*(10ms)?
However if ALSA wants/requires 50ms, why not?

Furthermore, if the app wants to use large buffers, why insist on a
tiny period on the ALSA side?  (MS appears to stick to
10ms packets regardless of the app's requested buffer size).

I expect that setting Wine's timer period to at least ALSA's allows it
to actually find room for new data each turn.

So here's what makes sense to me:
if (shared_mode && device=3D=3D"default")
   set_period_time_near(10ms);
else if (exclusive_mode)
   /* mmdevapi:Initialize receives period from the app */
   set_period_time_near(clamp(3ms, app's wish in mmdevapi:Intialize, 100ms)=
);
   /* 100ms is arbitrary, why not 1s? */
snd_pcm_hw_params()
wine_set_timer_rate(clamp(3ms, snd_pcm_get_period_time(), 0.5s))


Topic T2.b Duration / buffer size

mmdevapi's Initialize method receives a duration parameter as a hint
towards either small latency or large buffering.  One would think that
it makes perfect sense to forward that to snd_pcm_set_buffer_time.

*However*, mmdevapi also requires to hand out a pointer to a buffer
that large (GetBuffer).  Thus Wine must maintain a buffer that large
(possibly even two of them, for reasons not relevant here).
Now should ALSA really keep yet another buffer that large?
Isn't that precisely why people have gripes with PA's 2s buffer?

I'm wondering whether Wine should solely rely on its periodic timer to
regularly submit data and e.g. ask ALSA to use a buffer 3 times the
period?
30ms (3x10ms) seems to play a role in MS systems.
Dmix seems to prefer 4 to 6 times period size.

Unfortunately, snd_pcm_get_period_time may be known only after
invoking snd_pcm_hw_params(), so I can't express:
set_period_time_near(10ms);
set_buffer_time_near(3 x actual_period);

Prefer
set_buffer_time_near(3 x period_above); or
simply not call set_buffer at all?


Finally, there's that snd_pcm_sw_params_set_avail_min
whose purpose I cannot figure out.  Should Wine call
snd_pcm_sw_params_set_avail_min(1); or
snd_pcm_sw_params_set_avail_min(0);
or not at all?


Topic T3 blocking or not

Wine has traditionally used ALSA in non-blocking mode, which ALSA
people recommended against (still?).  Now suppose every write is
preceded with avail_update, for reasons I gave in part1: underruns.

Remember my example from part 1, slightly refined:
if (snd_pcm_avail_update(&avail) > buffer_size)
   snd_pcm_reset() /* skip over late samples */
   /* should be equivalent to snd_pcm_forward(avail) */
written =3D snd_pcm_write(min(avail,frames));

My understanding of the semantics is that write(<avail) will not block,
thus Wine could as well dispose of SND_PCM_NONBLOCK.

In the NONBLOCK case, this could be simplified to
written =3D snd_pcm_write(frames);
since I discovered that ALSA can write a little more than what avail
returns, and NONBLOCK implies it'll not wait in an attempt to write a
2s data buffer, but return written < frames instead.

Actually, I've a slightly more elaborate sequence in mind.  I've read
that snd_pcm_open() may be delayed because of networking issues, which
I want to avoid in the audio thread.  Therefore I'm considering using:

snd_pcm_open(SND_PCM_NONBLOCK);
... setup hw&sw_params
snd_pcm_prepare()
snd_pcm_nonblock(0); /* or should it be called before prepare? */

I.e. allow blocking while playing, which does not actually happen
thanks to avail_update() and a push model based on periodic timers to
feed data with pcm_write().

Note that so far, I've not questioned whether a timer-based push model
actually makes sense for Wine with ALSA...


Topic T4 mmap

After I re-read the mmdevapi documentation, I believe that mmdevapi's
GetBuffer/ReleaseBuffer rendering protocol may be compatible with
ALSA's snd_pcm_mmap_begin+commit after all.  It all depends on whether
ALSA grants requests for sizes as large as buffer_size, with
buffer_size up to 2 seconds * samples/sec.

Hence, as an optimization, one could imagine a driver using mmap, like
Winealsa used to have prior to the 2011 rewrite.  Yet it always had
the fallback without mmap, so let's concentrate on the non-mmap case
initially and get that right.

Thank you for your help and for reading up to this point,
      J=F6rg H=F6hle
