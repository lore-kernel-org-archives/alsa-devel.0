From: Trent Piepho <xyzzy@speakeasy.org>
Subject: Re: [PATCH] ad1838/cs4231 -- fix MCE timeout upon
 initial load
Date: Tue, 18 Sep 2007 18:27:45 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0709181634550.27377@shell4.speakeasy.net>
References: <46E58D01.9080809@gmail.com>
	<Pine.LNX.4.58.0709170325380.27377@shell4.speakeasy.net>
	<20070917234739.a674bf7b.krzysztof.h1@gmail.com>
	<Pine.LNX.4.58.0709171522360.27377@shell4.speakeasy.net>
	<20070918092046.f52e8877.krzysztof.h1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail8.sea5.speakeasy.net (mail8.sea5.speakeasy.net
	[69.17.117.10]) by alsa0.perex.cz (Postfix) with ESMTP id 2BF5D243D7
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Sep 2007 03:27:47 +0200 (CEST)
In-Reply-To: <20070918092046.f52e8877.krzysztof.h1@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Krzysztof Helt <krzysztof.h1@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, devel <alsa-devel@alsa-project.org>, Rene@alsa-project.org, Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 18 Sep 2007, Krzysztof Helt wrote:
> On Mon, 17 Sep 2007 18:18:27 -0700 (PDT)
> Trent Piepho <xyzzy@speakeasy.org> wrote:
> > for(time = 250; time > 0 ; ) time = schedule_timeout(time);
> >
> > Unless you set the task state first, that line is an infinite busy loop.
>
> This may be not true. If you compare schedule_timeout() with cpu_relax()
> you will see that schedule_timeout() is slower. I am not expert on this,
> but I think that the schedule_timeout() switches tasks and returns
> which is not busy waiting (like userland sleep(0) function does).
> It would make it close to the cpu_relax().

I had tested it and that wasn't the case, but I didn't have more runable tasks
than CPUs while testing.  I think if I had done that, you'd be right and a task
switch might occur.

On the other hand, cpu_relax() is totally different.  It's basically a hint
to the processor to lower the clock speed/power consumption or give
resources to a sibling virtual processor in hyper-threading.  i.e., it's ok
to call cpu_relax() from an interrupt or while atomic.

Might be a good idea in the non-sleeping busy loops, like the one in
snd_ad1848_wait(), but I bet the udelay() already does that.

> The original idea was to make this first waiting longer than loop granularity.
> 7ms before the loop than 1ms granularity inside the loop.
> Rene Herman was against it so he changed it to be the same as 1ms inside
> the loop.

With the delay time being dependent on sample rate, and with different
chips being considerably faster than others, picking a good value for the
first iteration is complicated.  If one could avoid 70 ms of busy looping
in the kernel by doing so, then that might be worth it.  But we don't busy
loop, just poll once per ms (even less when HZ<1000), so it seems that
there is very little to gain here to justify the extra complexity.

> > The polling loop to check for ACI to go down was more convoluted than it
> > needed to be.  New loop should be more efficient and it is a lot simpler.  The
> > old loop checked for a timeout before checking for ACI down, which could
> > result in an erroneous timeout.  It's only a failure if the timeout expires
> > _and_ ACI is still high.  There is nothing wrong with the timeout expiring
> > while the task is sleeping if ACI went low.
> >
>
> This was already fixed by Rene's patch. You only simplified it.

No, that problem was still there.  If you look at the code patched:
-     while (snd_ad1848_in(chip, AD1848_TEST_INIT) & AD1848_CALIB_IN_PROGRESS) {
              spin_unlock_irqrestore(&chip->reg_lock, flags);
-             if (time_after(jiffies, end_time)) {
-                     snd_printk(KERN_ERR "mce_down - auto calibration time out (2)\n");

If the CPU is interrupted between the spin_unlock_irqrestore() and the next
line, a timeout will be detected, even though ACI may have already gone low.

> > +     } while ((regsel & AD1848_CALIB_IN_PROGRESS) && time_before(jiffies, timeout));
> Break this long line. You may calculate "regsel & AD1848_CALIB_IN_PROGRESS"

Good idea, I've done that.
