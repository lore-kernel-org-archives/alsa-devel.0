From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [Pull request] Support for wm9705 codec and two
	machines that use it.
Date: Fri, 16 Jan 2009 14:31:36 +0000
Message-ID: <20090116143135.GG7554@sirena.org.uk>
References: <496E8DD0.4090006@mnementh.co.uk> <s5hfxjl3v6s.wl%tiwai@suse.de>
	<496F0ABD.4080207@mnementh.co.uk>
	<s5hk58v4inq.wl%tiwai@suse.de> <497070D1.50301@mnementh.co.uk>
	<20090116115408.GB7554@sirena.org.uk>
	<49708E21.1060800@mnementh.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id A9D9B24400
	for <alsa-devel@alsa-project.org>; Fri, 16 Jan 2009 15:31:37 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <49708E21.1060800@mnementh.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ian Molton <ian@mnementh.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 16, 2009 at 01:39:45PM +0000, Ian Molton wrote:

> It looks to me like most chips could be handled with little difficulty -
> a reg mask for some chips that have eg. 9 bit registers represented in a
> u16, a reg_step to allow easy handling of different reg sizes, and an
> array of register numbers for which the core should not cache values.

> Easily 10 chips presently supported could use that scheme, whilst
> leaving the function pointer based system available for the few really
> weird chips.

Oh, there's a lot of stuff that could be factored out but the whole
register access area needs a good looking at.  It's just not the highest
priority cleanup - that's getting the card registration API converted
over to V2 so we can have multiple cards in one system.

> What does seem to be clear though is that there seems to be some
> confusion as to what the 'reg' parameter to codec->read should be -
> should it be a register _address_, or a register _number_.

It should be the register address as you'd see it in the datasheet
unless there's a *very* good reason for it to be something else.  It's
entirely private to the codec driver what the register parameter means,
the rest of the code only works with values that were given to it by the
codec driver.

> If the former, then the caching in my wm9705 and a few other drivers is
> broken. These treat reg as a register _address_ and shift it right by 1
> to get the reg number and thus index into the reg cache.

Neither scheme is broken.  Most codecs have no gaps in the register
space and therefore just use a straight array with a 1:1 mapping between
registers and cache slots.  The AC97 parts are special because AC97 only
has even numbered registers so they're saving a bit of memory by only
having cache space for registers that actually exist and cutting down on
noise by only showing those registers in the debug output.  It's not a
big saving but it's there.  

> >Please post an incremental patch with your other changes.

> Attached below for review.

Doesn't seem to include the kmemdup() fix for WM9705 - if you could post
the WM9705 changes only together with your signoff I can push the queue
I'm sitting on to Takashi?

> I haven't added my SoB: as I havent tested it.

> As you can see, the cache handling is done in several ways by different 
> codecs, with inconsistent semantics and return codes (some BUG, some 

Yes.  Broadly, writing outside of the register space the driver wants to
support is a clear bug, but the driver can choose to cache some or none
of the registers.  This makes the specifics of the error handling less
important for the system as a whole.

> return 1 some -1 some -EIO. Some wont allow undefined reg access, some 
> do, but only uncached.) This seems like ripe territory for bugs (albeit 

Undefined register access is often a deliberate decision in order to
allow access to functionality of the chip outside the fully documented
sections of the register space.  Having the cache there may not be safe
depending on the behaviour of the undocumented registers.

> fairly harmless ones, but bugs nontheless).

Yes, though it's less bad than it looks since each codec driver only has
to agree with itself.

This is why I'm saying the whole area needs going over fairly carefully
- there's useful cleanups that can be done but it needs a degree of care
due to the way the code is now in order to ensure that existing
functionality doesn't get broken.  Fortunately much of the care should
scale well over doing cleanups of the whole area since everything is
private to the individual codec drivers.

> This patch takes fixes a number of bugs in the caching code used by
> several ASoC codec drivers. Mostly off-by-one fixes.

This looks reasonable, though I didn't go through it completely
carefully due to the lack of signoff.
