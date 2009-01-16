From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [Pull request] Support for wm9705 codec and two
	machines that use it.
Date: Fri, 16 Jan 2009 16:00:46 +0000
Message-ID: <20090116160045.GI7554@sirena.org.uk>
References: <496E8DD0.4090006@mnementh.co.uk> <s5hfxjl3v6s.wl%tiwai@suse.de>
	<496F0ABD.4080207@mnementh.co.uk>
	<s5hk58v4inq.wl%tiwai@suse.de> <497070D1.50301@mnementh.co.uk>
	<20090116115408.GB7554@sirena.org.uk>
	<49708E21.1060800@mnementh.co.uk>
	<20090116143135.GG7554@sirena.org.uk>
	<4970A113.3060800@mnementh.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 8D6D424151
	for <alsa-devel@alsa-project.org>; Fri, 16 Jan 2009 17:00:47 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4970A113.3060800@mnementh.co.uk>
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

On Fri, Jan 16, 2009 at 03:00:35PM +0000, Ian Molton wrote:
> Mark Brown wrote:
> >On Fri, Jan 16, 2009 at 01:39:45PM +0000, Ian Molton wrote:

> >Oh, there's a lot of stuff that could be factored out but the whole
> >register access area needs a good looking at.

> I dont mind consolidating the cache handling code if its worth the 
> effort (IOW its not scheduled to get totally re-written)

It's not likely to be rewritten dramatically, like I say it's more about
the effort taken to do it - I know there's a bunch of people who really
want multiple cards.

> some of the core code for dumping the codecs reg_cache looks quite 
> broken... at least its only debug code, but broken debug code is worse 
> than useless...

Could you be more specific, please?  The read interface is in rather
active use.  The only thing I'm aware of is that only things marked as
cached are visible.  The read interface certainly gets a lot of use, the
write interface less so but still.

> > The AC97 parts are special because AC97 only
> >has even numbered registers so they're saving a bit of memory by only
> >having cache space for registers that actually exist and cutting down on
> >noise by only showing those registers in the debug output.  It's not a
> >big saving but it's there.

> Actually they arent. the regs are 16 bit anyway for the most part so 
> there is no saving - Just confusion over the meaning of the 'reg' parameter.

There is.  The natural layout would be to just have an array of u16s
which gives us an array of 16 bit register slots like this:

  [0][1][2][3][4][5]..

but we're actually storing:

  [0][2][4]...

since we know that the odd numbered registers don't exist.

> Basically we've got two codec types. BOTH have 16 bit regs, but on some 
> the 'reg' parameter is a register address, and on some its the register 
> number.

The registers referred to by ASoC are *always* register numbers as you'd
see in the chip documentation; the storage method used for any register
cache is entirely up to the codec drivers and is not something that the
core concerns itself with.  The core is also unaware of the actual width
of the registers.

You're confusing yourself here by thinking of these things memory mapped
devices - they aren't.  How software chooses to lay out any view it has
of the registers in memory has no meaning in hardware since there is, in
general, no way to interact with the hardware with a resolution less
than a full register.

> This is fine I supppose if the semantics for the underlying bus are the 
> same, eg. the PXA AC97 bus takes reg as an address.

For marshalling purposes all the I2C and SPI codecs are their own "bus
driver" - the only external thing that cares is the hardware itself, the
I2C and SPI bus drivers just deal in byte streams.  AC97 is the only
actual bus in use here and it has the same register number interface
that ASoC uses.

> I havent checked to see if any AC97 codecs are passing reg as a register 
> number - if they are then thats a clear bug as its not what the AC97 bus 
> driver expects.

All the AC97 codecs are using reg as a register number because that is
what both ASoC and the AC97 bus drivers expect.  Note that the AC97 bus
drivers have no idea that the codecs have caches, they just work with
register/value pairs.

> >the WM9705 changes only together with your signoff I can push the queue
> >I'm sitting on to Takashi?

> Sure, but I really think the other changes noted below need to  go in 
> ASAP as AFAICT they are clearly bogus.

They're not *that* urgent given how long they've been there - it's a
nice cleanup not something I'd push to Linus unless they fixed issues on
live systems (in which case I'd really expect to see patches to fix the
callers as well).  The risk/reward doesn't seem worth it.

> >Having the cache there may not be safe
> >depending on the behaviour of the undocumented registers.

> Of course, but drivers calling ac97_write need to get clear errors back, 
> IMHO.

Hardware I/O is a different matter - the error codes there are more
interesting since that could realistically go wrong at runtime.
Accessing invalid registers is a clear coding error, but it's possible
that something is relying on the fact that errors aren't reported
(probably by completely ignoring the return values) so it needs a bit of
care to actually change anything.
