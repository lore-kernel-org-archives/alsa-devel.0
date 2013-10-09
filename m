From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: firewire amdtp details
Date: Wed, 09 Oct 2013 20:36:38 +0200
Message-ID: <5255A236.6040703@ladisch.de>
References: <525572E5.3040600@weiss.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 83335261605
 for <alsa-devel@alsa-project.org>; Wed,  9 Oct 2013 20:36:52 +0200 (CEST)
In-Reply-To: <525572E5.3040600@weiss.ch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Uli Franke <uli.franke@weiss.ch>
Cc: Daniel Weiss <weiss@weiss.ch>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Rolf Anderegg <Rolf.Anderegg@weiss.ch>
List-Id: alsa-devel@alsa-project.org

Uli Franke wrote:
> from amdtp_stream_set_parameters:
>
>   /* default buffering in the device */
>   s->transfer_delay = TRANSFER_DELAY_TICKS - TICKS_PER_CYCLE;
>   if (s->flags & CIP_BLOCKING)
>       /* additional buffering needed to adjust for no-data packets */
>       s->transfer_delay += TICKS_PER_SECOND * amdtp_syt_intervals[sfc] /
>                            rate;
>
> which sets a global transfer delay. But later in calculate_syt I get the
> impression that (not exactly) the same operations are performed again
> accidentally:
>
>   if (syt_offset < TICKS_PER_CYCLE) {
>       syt_offset += TRANSFER_DELAY_TICKS - TICKS_PER_CYCLE;
>       if (s->flags & CIP_BLOCKING)
>           syt_offset += s->transfer_delay;
>       syt = (cycle + syt_offset / TICKS_PER_CYCLE) << 12;
>       syt += syt_offset % TICKS_PER_CYCLE;
>
>       return syt & 0xffff;
>   }
>
> When I interpret the code from set_parameters as some sort of
> precomputation, the code in calculate_syt should be something like this:
>
>   if (syt_offset < TICKS_PER_CYCLE) {
>       syt_offset += s->transfer_delay;
>       syt = (cycle + syt_offset / TICKS_PER_CYCLE) << 12;
>       syt += syt_offset % TICKS_PER_CYCLE;
>
>       return syt & 0xffff;
>   }

Yes; the latter code is correct.

> Therefore I'm a bit curious if you could enlighten me about this

This is the code in the current kernel (non-blocking only, without
precomputation):
<http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/sound/firewire/amdtp.c#n249>

	if (syt_offset < TICKS_PER_CYCLE) {
		syt_offset += TRANSFER_DELAY_TICKS - TICKS_PER_CYCLE;
		syt = (cycle + syt_offset / TICKS_PER_CYCLE) << 12;
		syt += syt_offset % TICKS_PER_CYCLE;

		return syt & 0xffff;
	}

This is my current development code, after the introduction of
blocking mode:
<http://git.alsa-project.org/?p=alsa-kprivate.git;a=commitdiff;h=7365ec51bd8653d141bc98b5632f2c53580d2b36>

        if (syt_offset < TICKS_PER_CYCLE) {
                syt_offset += s->transfer_delay;
                syt = (cycle + syt_offset / TICKS_PER_CYCLE) << 12;
                syt += syt_offset % TICKS_PER_CYCLE;

                return syt & 0xffff;
        }


I've never before seen the code you have.  It looks like a wrong merge.


> Additionally I appreciate any justifications for the subtraction of
> TICKS_PER_CYCLE from the global transfer delay.

The standard's TRANSFER_DELAY is defined as the interval between the
time when a sample arrives at the transmitter (i.e., is captured by some
ADC) and the time when this sample is to be played by the receiver.

This driver does not have arrival time stamps; instead it calculates
the SYT based on the start time of the cycle in which the packet is
scheduled to be transferred ("cycle").  The first half of calculate_syt()
computes a syt_offset value that is measured from the start of a cycle
_forwards_; to get an assumed timestamp that lies _before_ the cycle
start, we have to subtract one cycle.



BTW: I'm planning to submit the playback-only Weiss-only driver (more or
less the current state of the firewire-kernel-streaming branch) to the
kernel this weekend.  I guess the driver you're working on will not be
ready before the 3.13 merge window (about mid-November)?


Regards,
Clemens
