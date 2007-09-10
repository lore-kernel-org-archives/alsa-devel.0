From: "Krzysztof Helt" <krzysztof.h1@gmail.com>
Subject: Re: [PATCH] ad1848 and cs4231 busy loop replacement
Date: Mon, 10 Sep 2007 09:08:56 +0200
Message-ID: <8c74410a0709100008v5497e870j7495b3ea054ae00b@mail.gmail.com>
References: <20070909001208.b2e54c13.krzysztof.h1@gmail.com>
	<46E46109.5040704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.190])
	by alsa0.perex.cz (Postfix) with ESMTP id BC149103864
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Sep 2007 09:08:57 +0200 (CEST)
Received: by rv-out-0910.google.com with SMTP id k20so929987rvb
	for <alsa-devel@alsa-project.org>; Mon, 10 Sep 2007 00:08:56 -0700 (PDT)
In-Reply-To: <46E46109.5040704@gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Rene wrote:

> As you say, the next loop is waiting for the auto-calibration bit to go down
> again, so here we should be waiting (the maximum time needed) for it to come
> up after dropping the MCE bit. You do a msleep(7), which I assume is derived
> (somehow...) from the 384 cycles mentioned in the spec, at 48kHz, but that's
> the time the auto-calibration bit will stay up after _having_ come up.
>
> On page 24 of the AD1848K spec (2nd column, near top) we have:
>
>    * Clear the Mode Change Enable (MCE) bit
>
>    * The Autocalibrate-In-Progrss (ACI) bit will transition from LO to
>      HI within 5 sample periods. [ ... ]
>
> Which seems to be saying that we should be waiting for only 5 cycles at that
> point. With the slowest (!) possible sampling rate of 5.5125 kHz that would
> mean 907 us, or sligtly under 1 ms.
>

It does not matter. If you have to wait for the start of the
auto-calibration then for the end of auto-calibration you may as well
wait for the end of the auto-calibration only (unless you want to
follow the auto-calibration to the very single clock pulse ;-). The
delay here is simple to assure that auto-calibration started (and
probably is already under way). It may be longer then the start but it
should not be longer than whole auto-calibration.
I simply tried to do as long msleep as possible to allow other tasks
using CPU and decrease number of waiting loop iterations.

I tested on the AD1848 before I posted it. The 7ms delay was never
enough for auto-calibration to complete. Even at 48kHz, tens of
waiting loops iterations happened on my SC-6000. Tens of waiting loops
is much less than 1 jiffy, and msleep(2) is 2 jiffies.
Och, and my AD1848 returns 0xA revision which means it is AD1848K
despite it is marked as AD1848 only.

> fine. Also delaying for 1ms in cs2431 would be fine by me as well...
>

I tested this on SPARC cs4231. The 2ms and 1ms gives the same results
which may be attributed to kernel timer resolution (2 jiffies for
msleep(1) and msleep(2)). It was enough for the whole autocalibration
(no waiting loop iterations at 48kHz). I got 2.8ms delay at 48kHz when
I calculated it from the specs. I will retest it with kernel set to
1000 Hz to confirm if the  2ms is too long (it should not be we are
below kernel timer resolution).

I will post SPARC cs4231 patch (with sleep and improved waiting) when
Takashi will say if the kernel or alsa version of the driver is
correct.

> > Rene, please test this patch on the cs4231 codec.
>
> Given that the only difference is that I wait less, yours would've worked as
> well -- thanks for looking into this! And could you viceversa test this on
> AD1848 and perhaps resubmit if you agree?
>

Thanks,
Krzysztof
