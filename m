From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: snd soc spi read/write
Date: Thu, 11 Aug 2011 11:46:40 +0900
Message-ID: <20110811024638.GA14592@opensource.wolfsonmicro.com>
References: <20110809160447.GM15861@opensource.wolfsonmicro.com>
	<s5hwrela3d8.wl%tiwai@suse.de>
	<20110810145549.GA5724@opensource.wolfsonmicro.com>
	<s5hk4al9uql.wl%tiwai@suse.de>
	<20110810150316.GF5724@opensource.wolfsonmicro.com>
	<s5hhb5p9u2e.wl%tiwai@suse.de>
	<20110810153457.GG5724@opensource.wolfsonmicro.com>
	<4E42F89A.2020008@metafoo.de>
	<20110811003311.GA10574@opensource.wolfsonmicro.com>
	<4E433569.7000702@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AC3B7244A4
	for <alsa-devel@alsa-project.org>;
	Thu, 11 Aug 2011 04:46:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E433569.7000702@metafoo.de>
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

On Thu, Aug 11, 2011 at 03:50:33AM +0200, Lars-Peter Clausen wrote:
> On 08/11/2011 02:33 AM, Mark Brown wrote:

> > Like I say I'm really not happy about adding further non-standard driver
> > specifics to the Analog drivers, they're already not the best and they
> > don't really seem to be getting much attention from anyone so I'm not
> > confident anyone will come along and reverse any temporary bodges.  I'd
> > be reasonably happy with something temporary for 3.1 if we already have
> > a fix in place for 3.2 but I don't have much confidence that anyone will
> > work on that.

> So, just switch the ad193x driver to a rbcache.

That's one of the suggestions I made earlier, obviously it's painful for
the register default table at present though.

> >> And if we have to add our own read function we could as very well add our own
> >> write function which simply reinstates the old caching behavior.
> > 
> > If the driver needs its own custom I/O it should do both read and write.

> We don't need reads if we cache writes. In the old ASoC IO code there wasn't
> even SPI read support.

Yeah, that's for the volatile case where we skip having a cache at all.

> Yes, I had a look at the rbcache the other day. The current code doesn't seem
> to be optimal. For example adjacent don't seem to be joined, so for example if
> I have 3 registers and write them in the order 0,2,1 I'll still end up with 2
> blocks. But that's of course something that can be fixed. And I had almost been
> sold on it, if there wasn't the default register issue.

None of the current ASoC code will coalesce register writes at all, and
in the case where you're doing writes to registers that aren't actually
adjacent it's going to be marginal if it's better to transmit the
intervening register or transmit another register address.  That only
really makes a difference during cache sync anyway.

> > If we also provide a more compact way of
> > representing the defaults that devices with sparse registers can use
> > then that problem will go away too.

> What do you have in mind for this? An array of pairs of register and value?

Yes, as I said in one of the earlier messages in this thread.  It seems
like a good combination of being writable/legible and compact.
