From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: snd soc spi read/write
Date: Thu, 11 Aug 2011 03:50:33 +0200
Message-ID: <4E433569.7000702@metafoo.de>
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
	<20110811003311.GA10574@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
	(mailhost.informatik.uni-hamburg.de [134.100.9.70])
	by alsa0.perex.cz (Postfix) with ESMTP id 227552441C
	for <alsa-devel@alsa-project.org>;
	Thu, 11 Aug 2011 03:52:53 +0200 (CEST)
In-Reply-To: <20110811003311.GA10574@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, uclinux-dist-devel@blackfin.uclinux.org, Scott Jiang <scott.jiang.linux@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 08/11/2011 02:33 AM, Mark Brown wrote:
> On Wed, Aug 10, 2011 at 11:31:06PM +0200, Lars-Peter Clausen wrote:
> 
> That's not complicated, though - like I'm sure I've said to you before
> it seems like we just need to make the read bit controllable by drivers.
> Some other devices need that too, and a shift of the address also
> (there's one 7 bit address device I saw recently which has the address
> in the top 7 bits of an 8 bit value).
> 

Yes, I think I brought it up during the regmap review.

> Like I say I'm really not happy about adding further non-standard driver
> specifics to the Analog drivers, they're already not the best and they
> don't really seem to be getting much attention from anyone so I'm not
> confident anyone will come along and reverse any temporary bodges.  I'd
> be reasonably happy with something temporary for 3.1 if we already have
> a fix in place for 3.2 but I don't have much confidence that anyone will
> work on that.

So, just switch the ad193x driver to a rbcache.

> 
>> And if we have to add our own read function we could as very well add our own
>> write function which simply reinstates the old caching behavior.
> 
> If the driver needs its own custom I/O it should do both read and write.

We don't need reads if we cache writes. In the old ASoC IO code there wasn't
even SPI read support.

>> In my opinion it would be nice if we could add a register cache base address,
>> which specifies the offset at which the cache-able registers start. For example
>> I have a codec driver in the queue where all non-volatile registers at 0x8000
>> and I don't really want to add 16k of zeros to the driver for the default
>> register cache.
> 
> I don't think it's worth adding a special case like that when fixing the
> more general issues for sparse registers also solves these problems - we
> still need to fix the sparse register maps anyway.  Blocking registers
> together in rbtree (which we do already) means that if you've got one
> block of registers at a massive offset then the block with an offset
> just flops out of the code.

Yes, I had a look at the rbcache the other day. The current code doesn't seem
to be optimal. For example adjacent don't seem to be joined, so for example if
I have 3 registers and write them in the order 0,2,1 I'll still end up with 2
blocks. But that's of course something that can be fixed. And I had almost been
sold on it, if there wasn't the default register issue.

> If we also provide a more compact way of
> representing the defaults that devices with sparse registers can use
> then that problem will go away too.

What do you have in mind for this? An array of pairs of register and value?

- Lars
