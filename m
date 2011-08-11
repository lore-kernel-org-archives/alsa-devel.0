From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: snd soc spi read/write
Date: Thu, 11 Aug 2011 09:33:12 +0900
Message-ID: <20110811003311.GA10574@opensource.wolfsonmicro.com>
References: <20110805083058.GB4977@opensource.wolfsonmicro.com>
	<CAHG8p1AG2mteW0Bw6ScHCsM5okLr7Vd7Hqy=T8zz+C746qpn+g@mail.gmail.com>
	<20110809160447.GM15861@opensource.wolfsonmicro.com>
	<s5hwrela3d8.wl%tiwai@suse.de>
	<20110810145549.GA5724@opensource.wolfsonmicro.com>
	<s5hk4al9uql.wl%tiwai@suse.de>
	<20110810150316.GF5724@opensource.wolfsonmicro.com>
	<s5hhb5p9u2e.wl%tiwai@suse.de>
	<20110810153457.GG5724@opensource.wolfsonmicro.com>
	<4E42F89A.2020008@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A5D31243C4
	for <alsa-devel@alsa-project.org>;
	Thu, 11 Aug 2011 02:33:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E42F89A.2020008@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Takashi Iwai <tiwai@suse.de>, uclinux-dist-devel@blackfin.uclinux.org, Scott Jiang <scott.jiang.linux@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 10, 2011 at 11:31:06PM +0200, Lars-Peter Clausen wrote:

> The problem is that there is no read-back support out of the box. Readback
> requires setting the read bit in the registers address. Since this is not the
> upper-most bit, the default regmap spi read wont work.

Ah, so read and write aren't symmetric?  That wasn't clear.

That's not complicated, though - like I'm sure I've said to you before
it seems like we just need to make the read bit controllable by drivers.
Some other devices need that too, and a shift of the address also
(there's one 7 bit address device I saw recently which has the address
in the top 7 bits of an 8 bit value).

Like I say I'm really not happy about adding further non-standard driver
specifics to the Analog drivers, they're already not the best and they
don't really seem to be getting much attention from anyone so I'm not
confident anyone will come along and reverse any temporary bodges.  I'd
be reasonably happy with something temporary for 3.1 if we already have
a fix in place for 3.2 but I don't have much confidence that anyone will
work on that.

> And if we have to add our own read function we could as very well add our own
> write function which simply reinstates the old caching behavior.

If the driver needs its own custom I/O it should do both read and write.

> In my opinion it would be nice if we could add a register cache base address,
> which specifies the offset at which the cache-able registers start. For example
> I have a codec driver in the queue where all non-volatile registers at 0x8000
> and I don't really want to add 16k of zeros to the driver for the default
> register cache.

I don't think it's worth adding a special case like that when fixing the
more general issues for sparse registers also solves these problems - we
still need to fix the sparse register maps anyway.  Blocking registers
together in rbtree (which we do already) means that if you've got one
block of registers at a massive offset then the block with an offset
just flops out of the code.  If we also provide a more compact way of
representing the defaults that devices with sparse registers can use
then that problem will go away too.
