From: Krzysztof Helt <krzysztof.h1@gmail.com>
Subject: Re: [PATCH] ad1838/cs4231 -- fix MCE timeout upon
 initial load
Date: Mon, 17 Sep 2007 23:47:39 +0200
Message-ID: <20070917234739.a674bf7b.krzysztof.h1@gmail.com>
References: <46E58D01.9080809@gmail.com>
	<Pine.LNX.4.58.0709170325380.27377@shell4.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.188])
	by alsa0.perex.cz (Postfix) with ESMTP id 7B2D7243DC
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Sep 2007 23:40:19 +0200 (CEST)
Received: by nf-out-0910.google.com with SMTP id b21so1106905nfd
	for <alsa-devel@alsa-project.org>; Mon, 17 Sep 2007 14:40:19 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.58.0709170325380.27377@shell4.speakeasy.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Trent Piepho <xyzzy@speakeasy.org>
Cc: Takashi Iwai <tiwai@suse.de>, devel <alsa-devel@alsa-project.org>, ALSA@alsa-project.org, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 17 Sep 2007 14:04:21 -0700 (PDT)
Trent Piepho <xyzzy@speakeasy.org> wrote:

> 
> First, you call msleep(1) while holding reg_lock with interrupts disabled.
> That's sleeping while atomic.  You should drop the lock first, or use
> mdelay().
> 
Good catch. If we are going after cs4231_lib, we can drop lock in loops
of the mce_down function (the driver only reads registers).

> Second, schedule_timeout() returns immediately unless you have set the task
> state to TASK_UNINTERRUPTIBLE or TASK_INTERRUPTIBLE.  I don't see anywhere
> where this is done, so the 250ms delay is in fact a busy loop.  The call to
> schedule_timeout() appears to be quite pointless.
> 

Please check out current alsa-kernel tree. The ad1848 now waits as the cs4231 does.
Loops have 1ms delay and there is one 1ms delay before the first loop.

> This would explain what is happening when Krzysztof said, "The waiting loop
> was passed 340 times after mce was down with msleep(1)." 340 loops at 250 ms
> per loop is 85 seconds.  That would mean a call to hw_params() takes 85
> seconds, and open(), with three mce_downs, would take over four minutes!
> 

No, the loop never had the 250ms delay. The whole loop (all iterations) was 250ms delay.

> I looked at the ad1848 datasheet, and it says the auto-calibration should take
> about 384 samples (or ~128, which I think is the time it takes ACI to go low
> when auto-calibration is not on).  That would be 70 ms at the high end and
> typically more like 3 ms.  

The smallest value for ad1848 is over 7ms (from experiments). 
It is about 384 samples at 48kHz.

> A 250 ms polling interval seems to be quite long.

The interval was 10ms in the original cs4231 and no delay in ad1848.

> The wait for the init bit to be off after the check for ACI seems unneeded
> too.  snd_ad1848_in(), called while waiting for ACI to go low, does the exact
> same thing when it calls snd_ad1848_wait().  So the INIT bit is already off at
> this point.
> 

Good catch again. Just look into the "Changing sample rates" section.
Maybe waiting loop for the init bit off should be the first?

> Here is a patch to fix all these problems and simplify the code in the
> process.  I picked a value of 3 ms for the polling interval.  Obviously, there
> is a trade-off in selecting the value.  The smaller the delay, the less wasted
> time from when ACI goes low to when it is detected.  But it also means more
> iterations of the loop, and thus more scheduling and interrupt disabling.
> 

We may drop interrupts disabling in waiting loops, because inside them the
driver only reads registers.

> I think a good way to pick a value, is to try select the smallest value such
> that 90% of the time the loop will finish on the first check.  It seems like 3
> or maybe 4 would do that.
> 

This is not optimal from the latency point of view. The 3ms delay inside the loop
means that one must wait either 3 or 6 or 9 ms. Event if the real hardware answers
correctly after 4ms.

> If you're not concerned much about efficiency, and just want to detect ACI low
> as soon as possible, you'd use 1 ms.  Or if you want to get more complicated,
> delay 3 ms on the first iteration, and 1 ms thereafter.

The whole point of sleep before loop is to make this first iteration outside the loop
so it is not obscured by any special condition.

Take into account that this driver is used also for ad1847, cs4248 and cmi8330.
This means that the perfect delays for the ad1848 may be not optimal for all of them.

I would like to see the patch which fixes this locked msleep and maybe even remove
locks from inside loops.

Any improvement is welcome,
Krzysztof
