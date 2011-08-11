From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: snd soc spi read/write
Date: Thu, 11 Aug 2011 05:09:14 +0200
Message-ID: <4E4347DA.5000800@metafoo.de>
References: <20110809160447.GM15861@opensource.wolfsonmicro.com>	<s5hwrela3d8.wl%tiwai@suse.de>	<20110810145549.GA5724@opensource.wolfsonmicro.com>	<s5hk4al9uql.wl%tiwai@suse.de>	<20110810150316.GF5724@opensource.wolfsonmicro.com>	<s5hhb5p9u2e.wl%tiwai@suse.de>	<20110810153457.GG5724@opensource.wolfsonmicro.com>	<4E42F89A.2020008@metafoo.de>	<20110811003311.GA10574@opensource.wolfsonmicro.com>	<4E433569.7000702@metafoo.de>
	<20110811024638.GA14592@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
	(mailhost.informatik.uni-hamburg.de [134.100.9.70])
	by alsa0.perex.cz (Postfix) with ESMTP id 8ECD024333
	for <alsa-devel@alsa-project.org>;
	Thu, 11 Aug 2011 05:11:20 +0200 (CEST)
In-Reply-To: <20110811024638.GA14592@opensource.wolfsonmicro.com>
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

On 08/11/2011 04:46 AM, Mark Brown wrote:
> On Thu, Aug 11, 2011 at 03:50:33AM +0200, Lars-Peter Clausen wrote:
>> On 08/11/2011 02:33 AM, Mark Brown wrote:
> [...]
> 
>> Yes, I had a look at the rbcache the other day. The current code doesn't seem
>> to be optimal. For example adjacent don't seem to be joined, so for example if
>> I have 3 registers and write them in the order 0,2,1 I'll still end up with 2
>> blocks. But that's of course something that can be fixed. And I had almost been
>> sold on it, if there wasn't the default register issue.
> 
> None of the current ASoC code will coalesce register writes at all, and
> in the case where you're doing writes to registers that aren't actually
> adjacent it's going to be marginal if it's better to transmit the
> intervening register or transmit another register address.  That only
> really makes a difference during cache sync anyway.

I was think more in terms of in memory consumption and lookup time of the cache
compared to a flat cache. If you have two blocks which have a gap of one
register between them and that register gets inserted into the cache, ideally
those two blocks would be merged, which doesn't seem to be the case currently.
So instead of one rbnode with a block covering the whole register space you'll
end up with a lot of smaller rbnodes.

> 
>>> If we also provide a more compact way of
>>> representing the defaults that devices with sparse registers can use
>>> then that problem will go away too.
> 
>> What do you have in mind for this? An array of pairs of register and value?
> 
> Yes, as I said in one of the earlier messages in this thread.  It seems
> like a good combination of being writable/legible and compact.

Hm, ok I'll give it a try. Though I'm not sure yet how to efficiently implement
the default register lookup when syncing the cache.

- Lars
