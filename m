From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Misusing snd_pcm_avail_update()
Date: Tue, 20 Jan 2009 15:26:14 +0100
Message-ID: <20090120142614.GA27494@tango.0pointer.de>
References: <20090120025727.GA30499@tango.0pointer.de>
	<49758B71.8090605@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 25DD71037F3
	for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2009 15:26:15 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <49758B71.8090605@ladisch.de>
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

On Tue, 20.01.09 09:29, Clemens Ladisch (clemens@ladisch.de) wrote:

> > I am now wondering why? One possibility of course is that s_p_a_u() is
> > not reliable, due to driver issues (there were problems in the HDA
> > driver about this, right?).
> 
> Some hardware doesn't realiably tell the current position in the
> buffer.

Hence it would be good to at least know the range of the current
buffer index. i.e. s_p_a_u() is something like the lower bound where
the playback index might be. With the function I am suggesting it
would then be possible to basically query the upper bound wherhe the
index might be.

> > Also, s_p_a_u() might simply lag behind quite a bit,
> 
> In the case above, when a driver detects that the hardware position is
> incorrect, it uses the last known value.  Usually, this isn't off more
> than a few samples.
> 
> There is hardware that does not allow reading the current position.
> With such a device, the position you get is computed at every interrupt,
> i.e., you get the last period boundary.

In this case too it would be good to know how reliable the value is
and have it as a range (i.e. two values), not just a lower bound.

> > or -- what I think is most likely -- because samples are
> > popped in larger blocks form the hw playback buffer we reach the
> > underrun much earlier than expected.
> 
> This happens, too.  Many PCI devices read PCM data in blocks of 32 or
> 64 bytes.  Many wavetable chips (Emu10k1, DS-1, CS46xx) read sample data
> in blocks of 256 or 512 samples.  USB transfers blocks of at least 1 ms
> length, but often a multiple of that to reduce the number of USB
> completion interrupts.

Particularly with USB I experience that right after the device is
started data is read much much faster from the playback buffer than
expected. This feels as if the USB driver would at the beginning take
all data from the playback buffer and copy it to some other buffer
which was previously completely empty. Then after that second buffer
is filled up the copying slows down to the expected speed. I currently
deal with this by always halving the first wakeup time -- which works
most of the time but is a hack.

With the function I suggest I'd be able to explicitly query how much
time I have before I need to wake up. 

> After choosing hardware parameters, you can call
> snd_pcm_hw_params_is_block_transfer() to determine if the device
> transfers samples in comparatively large blocks.  (The wavetable and
> USB drivers set this flag.)  There is currently no function to determine
> the block size.

I think Takashi mentioned that s_p_h_i_b_t() is not really reliable
and shouldn't be used --- it isn't that useful anyway if the block
size isn't known.

> In the worst case, the current position isn't guaranteed to be more
> accurate than the last period boundary.

> > I do acknowledge that the way i use s_p_a_u() is probably a misuse of
> > the API.
> 
> The API was primarily designed for applications that are woken up at
> period boundaries.  Using s_p_a_u() to bypass the synchronization
> implied by period interrupts _is_ possible, but it cannot give you more
> precision than the hardware supports.
> 
> > Now, considering all this I'd like to ask for a new API function that
> > tells me how much time I really have before the next underrun.
> 
> Well, you could make the "some extra margin" above larger than one
> period.

To save power I want to disable interrupts from the sound cards as
much as possible. I.e. I set the minimal number of periods I can
set. Usually that measn 1 or 2 periods. Having an extra margin that
large would defeat the whole point of the "glitch-free" logic.

> Or monitor the device over some time and see what the smallest increment
> is you get in successive s_p_a_u() return values.

Humpf, that seems like a hack to me. 

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
