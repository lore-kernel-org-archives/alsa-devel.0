From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/6] ASoC/mpc5200: get rid of the appl_ptr
	tracking nonsense
Date: Sat, 7 Nov 2009 11:51:16 -0700
Message-ID: <fa686aa40911071051y3cf63e55ibe7fbc65c30bd15e@mail.gmail.com>
References: <20091107081631.18908.82921.stgit@angua>
	<20091107083358.18908.10635.stgit@angua>
	<9e4733910911070451y28073dbeke6ced6246f5a5c24@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f196.google.com (mail-yx0-f196.google.com
	[209.85.210.196])
	by alsa0.perex.cz (Postfix) with ESMTP id DFA2F24691
	for <alsa-devel@alsa-project.org>; Sat,  7 Nov 2009 19:51:37 +0100 (CET)
Received: by yxe34 with SMTP id 34so1747524yxe.16
	for <alsa-devel@alsa-project.org>; Sat, 07 Nov 2009 10:51:36 -0800 (PST)
In-Reply-To: <9e4733910911070451y28073dbeke6ced6246f5a5c24@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: John Bonesio <bones@secretlab.ca>, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, linuxppc-dev@lists.ozlabs.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Sat, Nov 7, 2009 at 5:51 AM, Jon Smirl <jonsmirl@gmail.com> wrote:
> On Sat, Nov 7, 2009 at 3:34 AM, Grant Likely <grant.likely@secretlab.ca> =
wrote:
>> Sound drivers PCM DMA is supposed to free-run until told to stop
>> by the trigger callback. =A0The current code tries to track appl_ptr,
>> to avoid stale buffer data getting played out at the end of the
>> data stream. =A0Unfortunately it also results in race conditions
>> which can cause the audio to stall.
>
> I leave in an hour and I will be off net for a week so I can't look at th=
ese.

Okay, no problem.  I can be patient.

> The problem at end of stream works like this:
>
> last buffer containing music plays
> this buffer has been padded with zero to make a full sample
> interrupt occurs at end of buffer
> =A0--- at this point the next chained buffer starts playing, it is full o=
f junk
> =A0--- this chaining happens in hardware
> Alsa processes the callback and sends stop stream
> --- oops, too late, buffer full of noise has already played several sampl=
es
> --- these samples of noise are clearly audible.
> --- they are usually a fragment from earlier in the song.

I'm not yet convinced that this sequence is correct.  Well, I mean,
I'm not convinced about the buffer only being filled to top up the
current period.  My understanding of ALSA is that the application is
supposed to make sure there is enough silence in the buffer to handle
the lag between notification that the last period with valid data has
been played out and the stop trigger.

> Using aplay with short clips like the action sounds for pidgin, etc
> makes these noise bursts obviously visible.

Yup, I've got a bunch of clips that I can reproduce the problem with,
and I can reproduce it reliably using aplay.  However, the problem I'm
seeing seems to be related to a dev_dbg() call in the trigger stop
path.  When KERN_DEBUG messages get sent to the console, and the
console is one of the PSC ports, then I get the replayed sample
artifact at the end.  However, if I 'tail -f /var/log/kern.log', then
I still get to see the debug output, but the audible artifact doesn't
occur.  That says to me that the real problem is an unbounded latency
caused by another part of the kernel (the tty console in this case).

It seems to me that aplay doesn't silence out very many buffers past
the end of the sample, but I won't know for sure until I instrument it
to see what data is present in the buffers.  I'll do that next week.
>
> To fix this you need a mechanism to determine where the valid data in
> the buffering system ends and noise starts. Once you know the extent
> of the valid data we can keep the DMA channel programmed to not play
> invalid data. You can play off the end of valid data two ways; under
> run when ALSA doesn't supply data fast enough and end of buffer.

Underrun is a realtime failure.  ALSA handles it by triggering STOP
and START of the stream AFAIKT.  Just about all ALSA drivers using DMA
will end up replaying buffers if the kernel cannot keep up with
hardware.

End of buffer seems to be the responsibility of userspace, but I need
to investigate this more.

My experiments to this point seems to suggest that when you hear the
artifacts it is due to both the end of buffer condition, and a
realtime failure in executing the stop trigger.

> ALSA does not provide information on where valid data ends in easily
> consumable form so I've been trying to reconstruct it from appl_ptr.
> A much cleaner solution would be for ALSA to provide a field that
> indicates the last valid address in the ring buffer system. Then in
> the driver's buffer complete callback I could get that value and
> reprogram the DMA engine not to run off the end of valid data. As each
> buffer completes I would reread the value and update the DMA stop
> address. You also need the last valid address field when DMA is first
> started.

... assuming that audio needs to stop exactly at the end of valid
data.  But if the last few periods are silence, then this assumption
isn't true.

g.

-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
