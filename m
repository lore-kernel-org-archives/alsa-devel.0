From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: For firewire drivers,
	reduce period time down to 2msec?
Date: Mon, 21 Apr 2014 22:28:31 +0200
Message-ID: <53557F6F.8080701@ladisch.de>
References: <5355033F.7060606@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id C34FD2610D6
 for <alsa-devel@alsa-project.org>; Mon, 21 Apr 2014 22:28:46 +0200 (CEST)
In-Reply-To: <5355033F.7060606@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> Currently I'm working for next patchsets and I'll post them in Friday.

I should be healthy again by then.

> The patchset also includes my idea to apply common PCM hw constraints to
> dice/speakers(oxfw)/fireworks/bebob. Currently the constraints includes:
> 1.Maximum bits for PCM sample is limited by 24.
> 2.Minimum time for period is currently 2msec.
> 3.In blocking mode, frames per period/buffer is aligned to SYT_INTERVAL
>
> I think you'll agree with 1 and 3.

Yes.

> So I want to discuss the second one beforehand.
>
> Currently dice/speakers driver apply 5msec for period time.

This is just because of the fixed INTERRUPT_INTERVAL, plus lots of
safety margin to reduce the relative jitter of the period interrupt.
(If the interrupt interval were dynamic, it should be possible to
reduce periods to about 0.25 ms.)

> I want to reduce this to 2msec. The reason of this '2msec' is:
>  - Currently firewire-lib process 16 packets in one time.
>  - This equals to 2msec (= INTERRUPT_INTERVAL / 8000 * 1000)
>  - During this 2msec, when pcm_period_pointer passes through period
> boundary, snd_pcm_period_elapsed() is scheduled with tasklet.
>  - But tasklet can execute one time even if the function is scheduled
> several times before executing it.
>  - The packetizing process is enough fast so the function can be
> scheduled before executing.
>  - As a result, snd_pcm_period_elapsed() can be called one time every 2msec.
>
> Actually my devices can work fine with period == 2msec or less than
> 5msec, without any disadvantage.

ALSA actually uses a fixed period _size_.  When the period length is set
to exactly 2 ms, but the 16 packets between two FireWire interrupts
contain one sample less than needed, the ALSA period interupt is delayed
until the next FireWire interrupt.  In that case, Jack with two periods
is likely to underrun.

The minimum time should be increased so that at least one FireWire
interrupt is guaranteed to happen for each period, even when there are
rounding errors and clock differences.


Regards,
Clemens
