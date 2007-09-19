From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [PATCH] ad1838/cs4231 -- fix MCE timeout upon
 initial load
Date: Wed, 19 Sep 2007 04:48:28 +0200
Message-ID: <46F08DFC.7000803@gmail.com>
References: <46E58D01.9080809@gmail.com>
	<Pine.LNX.4.58.0709170325380.27377@shell4.speakeasy.net>
	<20070917234739.a674bf7b.krzysztof.h1@gmail.com>
	<Pine.LNX.4.58.0709171522360.27377@shell4.speakeasy.net>
	<20070918092046.f52e8877.krzysztof.h1@gmail.com>
	<Pine.LNX.4.58.0709181634550.27377@shell4.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.tilbu1.nb.home.nl (smtpq2.tilbu1.nb.home.nl
	[213.51.146.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 427AE2456C
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Sep 2007 04:49:31 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.58.0709181634550.27377@shell4.speakeasy.net>
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
Cc: Krzysztof Helt <krzysztof.h1@gmail.com>, Takashi Iwai <tiwai@suse.de>, devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 09/19/2007 03:27 AM, Trent Piepho wrote:

> On the other hand, cpu_relax() is totally different.  It's basically a
> hint to the processor to lower the clock speed/power consumption or give 
> resources to a sibling virtual processor in hyper-threading.  i.e., it's
> ok to call cpu_relax() from an interrupt or while atomic.
> 
> Might be a good idea in the non-sleeping busy loops, like the one in 
> snd_ad1848_wait(), but I bet the udelay() already does that.

It does (when using the TSC).

>> The original idea was to make this first waiting longer than loop
>> granularity. 7ms before the loop than 1ms granularity inside the loop. 
>> Rene Herman was against it so he changed it to be the same as 1ms
>> inside the loop.

Well, at that time, it still was first the 1 and then a full 250 -- or at 
least in my 2.6.22.x schedule_timeout_interruptible() version that actually 
scheduled...

> With the delay time being dependent on sample rate, and with different 
> chips being considerably faster than others, picking a good value for the
> first iteration is complicated.  If one could avoid 70 ms of busy
> looping in the kernel by doing so, then that might be worth it.  But we
> don't busy loop, just poll once per ms (even less when HZ<1000), so it
> seems that there is very little to gain here to justify the extra
> complexity.

Quite -- I plan on being around sound/isa/ for some time and am as such also 
already concerned with maintainability. If there's one thing I do know, it's 
that obviousness is an extremely important factor in that. So if the 
datasheet and hardware say 5 sample periods are enough, so be they...

>> Break this long line. You may calculate "regsel &
>> AD1848_CALIB_IN_PROGRESS"
> 
> Good idea, I've done that.

No goto? :-)

Rene.
