From: Ian Molton <ian@mnementh.co.uk>
Subject: Re: [Pull request] Support for wm9705 codec and two
 machines that use it.
Date: Fri, 16 Jan 2009 15:00:35 +0000
Message-ID: <4970A113.3060800@mnementh.co.uk>
References: <496E8DD0.4090006@mnementh.co.uk> <s5hfxjl3v6s.wl%tiwai@suse.de>
	<496F0ABD.4080207@mnementh.co.uk>
	<s5hk58v4inq.wl%tiwai@suse.de> <497070D1.50301@mnementh.co.uk>
	<20090116115408.GB7554@sirena.org.uk>
	<49708E21.1060800@mnementh.co.uk>
	<20090116143135.GG7554@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mnementh.co.uk (mail.mnementh.co.uk [173.45.232.4])
	by alsa0.perex.cz (Postfix) with ESMTP id 9069E10380D
	for <alsa-devel@alsa-project.org>; Fri, 16 Jan 2009 16:00:07 +0100 (CET)
In-Reply-To: <20090116143135.GG7554@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Fri, Jan 16, 2009 at 01:39:45PM +0000, Ian Molton wrote:

> Oh, there's a lot of stuff that could be factored out but the whole
> register access area needs a good looking at.

I dont mind consolidating the cache handling code if its worth the 
effort (IOW its not scheduled to get totally re-written)

> It should be the register address as you'd see it in the datasheet
> unless there's a *very* good reason for it to be something else.  It's
> entirely private to the codec driver what the register parameter means,
> the rest of the code only works with values that were given to it by the
> codec driver.

some of the core code for dumping the codecs reg_cache looks quite 
broken... at least its only debug code, but broken debug code is worse 
than useless...

>> If the former, then the caching in my wm9705 and a few other drivers is
>> broken. These treat reg as a register _address_ and shift it right by 1
>> to get the reg number and thus index into the reg cache.
> 
> Neither scheme is broken.

I guess  not as its codec specific (wit the exception noted above)

 > The AC97 parts are special because AC97 only
> has even numbered registers so they're saving a bit of memory by only
> having cache space for registers that actually exist and cutting down on
> noise by only showing those registers in the debug output.  It's not a
> big saving but it's there.

Actually they arent. the regs are 16 bit anyway for the most part so 
there is no saving - Just confusion over the meaning of the 'reg' parameter.

Basically we've got two codec types. BOTH have 16 bit regs, but on some 
the 'reg' parameter is a register address, and on some its the register 
number.

This is fine I supppose if the semantics for the underlying bus are the 
same, eg. the PXA AC97 bus takes reg as an address.

I havent checked to see if any AC97 codecs are passing reg as a register 
number - if they are then thats a clear bug as its not what the AC97 bus 
driver expects.

>>> Please post an incremental patch with your other changes.
> 
>> Attached below for review.
> 
> Doesn't seem to include the kmemdup() fix for WM9705

Whoops. Fixed.

> - if you could post
> the WM9705 changes only together with your signoff I can push the queue
> I'm sitting on to Takashi?

Sure, but I really think the other changes noted below need to  go in 
ASAP as AFAICT they are clearly bogus.

> Undefined register access is often a deliberate decision in order to
> allow access to functionality of the chip outside the fully documented
> sections of the register space.

Yes, I understand that.

> Having the cache there may not be safe
> depending on the behaviour of the undocumented registers.

Of course, but drivers calling ac97_write need to get clear errors back, 
IMHO.

> Yes, though it's less bad than it looks since each codec driver only has
> to agree with itself.

True.

>> This patch takes fixes a number of bugs in the caching code used by
>> several ASoC codec drivers. Mostly off-by-one fixes.
> 
> This looks reasonable, though I didn't go through it completely
> carefully due to the lack of signoff.

I think it needs to get in ASAP. I'll send it along with the wm9705 
stuff again, with my SOB (I've read through it again), but as a seperate 
patchset.

Patches to follow shortly.

-Ian
