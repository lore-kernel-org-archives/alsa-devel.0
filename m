From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: Re: snd soc spi read/write
Date: Wed, 17 Aug 2011 10:16:06 +0100
Message-ID: <20110817091606.GA6327@opensource.wolfsonmicro.com>
References: <s5hk4al9uql.wl%tiwai@suse.de>
	<20110810150316.GF5724@opensource.wolfsonmicro.com>
	<s5hhb5p9u2e.wl%tiwai@suse.de>
	<20110810153457.GG5724@opensource.wolfsonmicro.com>
	<4E42F89A.2020008@metafoo.de>
	<20110811003311.GA10574@opensource.wolfsonmicro.com>
	<4E433569.7000702@metafoo.de>
	<20110811024638.GA14592@opensource.wolfsonmicro.com>
	<4E4347DA.5000800@metafoo.de>
	<20110811053246.GA16655@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 51A471038D4
	for <alsa-devel@alsa-project.org>;
	Wed, 17 Aug 2011 11:16:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110811053246.GA16655@opensource.wolfsonmicro.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, uclinux-dist-devel@blackfin.uclinux.org, Scott Jiang <scott.jiang.linux@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 11, 2011 at 02:32:53PM +0900, Mark Brown wrote:
> On Thu, Aug 11, 2011 at 05:09:14AM +0200, Lars-Peter Clausen wrote:
> > On 08/11/2011 04:46 AM, Mark Brown wrote:
> 
> > > None of the current ASoC code will coalesce register writes at all, and
> > > in the case where you're doing writes to registers that aren't actually
> > > adjacent it's going to be marginal if it's better to transmit the
> > > intervening register or transmit another register address.  That only
> > > really makes a difference during cache sync anyway.
> 
> > I was think more in terms of in memory consumption and lookup time of the cache
> > compared to a flat cache. If you have two blocks which have a gap of one
> > register between them and that register gets inserted into the cache, ideally
> > those two blocks would be merged, which doesn't seem to be the case currently.
> > So instead of one rbnode with a block covering the whole register space you'll
> > end up with a lot of smaller rbnodes.

Yes, that's true.  I've got that in my TODO somewhere.  It was not
important enough during initial implementation.

> Dimitris had done an initial version of the move of the cache over,
> though I didn't review it properly yet and he's on holiday now.  I might
> repost it, there were a few issues but it's at least 90% of the way
> there IIRC from the time I had to look at it.

I'll be looking into this soon, there are a few issues to be resolved
regarding the LZO code at the moment.

Thanks,
Dimitris
