From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Misusing snd_pcm_avail_update()
Date: Tue, 20 Jan 2009 09:29:37 +0100
Message-ID: <49758B71.8090605@ladisch.de>
References: <20090120025727.GA30499@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id CFFA91037E3
	for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2009 09:29:40 +0100 (CET)
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 88DC32300A8
	for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2009 03:29:39 -0500 (EST)
Received: from [10.1.2.151] (srv004.schk01.int.dmc-one.com [85.232.8.141])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D31FA111D9
	for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2009 03:29:38 -0500 (EST)
In-Reply-To: <20090120025727.GA30499@tango.0pointer.de>
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

Lennart Poettering wrote:
> Currently in the 'glitch-free' logic of PulseAudio I use
> snd_pcm_avail_update() to estimate how I need to program my system
> timers for the next wake-up for the next buffer fill-up. For that I
> assume that the current fill level of the hardware buffer is the
> hardware buffer size minus what s_p_a_u() returns. I then convert that
> fill level from sample units to time units, and fix it up by the
> deviation of the sound card time from the system time. Finally I
> substract some extra margin just to make sure.
>
> This I assumed would tell me how much time will pass until an underrun
> happens if I don't write anything.
>
> Mostly this logic works fine. But on some setups and cases it
> doesn't. ALSA will signal an underrun much much earlier than what I
> estimated like this.
>
> I am now wondering why? One possibility of course is that s_p_a_u() is
> not reliable, due to driver issues (there were problems in the HDA
> driver about this, right?).

Some hardware doesn't realiably tell the current position in the buffer.

> Also, s_p_a_u() might simply lag behind quite a bit,

In the case above, when a driver detects that the hardware position is
incorrect, it uses the last known value.  Usually, this isn't off more
than a few samples.

There is hardware that does not allow reading the current position.
With such a device, the position you get is computed at every interrupt,
i.e., you get the last period boundary.

> or -- what I think is most likely -- because samples are
> popped in larger blocks form the hw playback buffer we reach the
> underrun much earlier than expected.

This happens, too.  Many PCI devices read PCM data in blocks of 32 or
64 bytes.  Many wavetable chips (Emu10k1, DS-1, CS46xx) read sample data
in blocks of 256 or 512 samples.  USB transfers blocks of at least 1 ms
length, but often a multiple of that to reduce the number of USB
completion interrupts.

After choosing hardware parameters, you can call
snd_pcm_hw_params_is_block_transfer() to determine if the device
transfers samples in comparatively large blocks.  (The wavetable and
USB drivers set this flag.)  There is currently no function to determine
the block size.

In the worst case, the current position isn't guaranteed to be more
accurate than the last period boundary.

> I do acknowledge that the way i use s_p_a_u() is probably a misuse of
> the API.

The API was primarily designed for applications that are woken up at
period boundaries.  Using s_p_a_u() to bypass the synchronization
implied by period interrupts _is_ possible, but it cannot give you more
precision than the hardware supports.

> Now, considering all this I'd like to ask for a new API function that
> tells me how much time I really have before the next underrun.

Well, you could make the "some extra margin" above larger than one period.

Or monitor the device over some time and see what the smallest increment
is you get in successive s_p_a_u() return values.


Best regards,
Clemens
