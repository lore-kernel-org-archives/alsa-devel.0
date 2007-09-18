From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [PATCH] ad1838/cs4231 -- fix MCE timeout upon
 initial load
Date: Tue, 18 Sep 2007 02:17:03 +0200
Message-ID: <46EF18FF.7070906@gmail.com>
References: <46E58D01.9080809@gmail.com>
	<Pine.LNX.4.58.0709170325380.27377@shell4.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl
	[213.51.146.200])
	by alsa0.perex.cz (Postfix) with ESMTP id EC16D24420
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Sep 2007 02:17:53 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>, Krzysztof Helt <krzysztof.h1@gmail.com>, ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 09/17/2007 11:04 PM, Trent Piepho wrote:

> On Mon, 10 Sep 2007, Rene Herman wrote:

>> When the ad1848/cs2431 is first being initialized, auto-calibration may
>> not be set causing a timeout waiting for it in
>> snd_ad1848/cs4231_mce_down().
>> 
>> This has no dire consequences other than an alarming printk, but since
>> what we need to wait for is for the calibration to _finish_, let's just
>> check for that instead.
>> 
>> The early chips need a slight delay (as commented -- 5 sample periods)
>> to be sure that _if_ calibration is going to happen, it has started
>> when we check While the CS4231A datasheet implies it'll happen
>> immediately on downing MCE, some testing is showing that there's a
>> window there as well, so just do the delay everywhere.
> 
> I don't think this code is doing what you think it does.
> 
> First, you call msleep(1) while holding reg_lock with interrupts
> disabled. That's sleeping while atomic.  You should drop the lock first,
> or use mdelay().

Yes, fuckup. Apologies -- had an mdelay(1) in there originally.

> Second, schedule_timeout() returns immediately unless you have set the
> task state to TASK_UNINTERRUPTIBLE or TASK_INTERRUPTIBLE.  I don't see
> anywhere where this is done, so the 250ms delay is in fact a busy loop.
> The call to schedule_timeout() appears to be quite pointless.

That mce_down code was changed over the last week by Krzysztof, myself and 
Takashi so not sure what version you've been looking at, but the (original) 
version that the quoted patch was against didn't use schedule_timeout, but a 
timeout based sleeping loop for cs4231 and schedule_timeout_interruptible() 
for ad1848 which sets the state itself.

(and since then, it has been changed to use a timeout based sleeping loop 
for ad1848 as well by Krzysztof which I see is the version your patch is 
against, so not sure what you mean).

[ ... ]

> I looked at the ad1848 datasheet, and it says the auto-calibration should
> take about 384 samples (or ~128, which I think is the time it takes ACI
> to go low when auto-calibration is not on).  That would be 70 ms at the
> high end and typically more like 3 ms.  A 250 ms polling interval seems
> to be quite long.

Oh, quite. Didn't change it from the original though -- this code is used 
by a number of different chips so need to be careful. 250 seems a little 
silly yes, but given that it's (now) at a 1ms granularity it's okay as far 
as I'm concerned.

[ ... ]

> The wait for the init bit to be off after the check for ACI seems unneeded
> too.  snd_ad1848_in(), called while waiting for ACI to go low, does the exact
> same thing when it calls snd_ad1848_wait().  So the INIT bit is already off at
> this point.

Ack.

> Here is a patch to fix all these problems and simplify the code in the
> process.

I looked at it, but am not sure what version it is against. It seems to 
msleep(3) still under lock. As you said, the minimal fix right now is to 
bracket that initial msleep(1) delay with a spin_unlock_irqrestore / 
spin_lock_irqsave pair or just make it be mdelay(1). Could you do that 
against current HG and then do other possible changes incrementally on top?

Rene.
