From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [RFC 4/7] ASoC: Add dmaengine PCM helper functions
Date: Mon, 05 Mar 2012 13:30:42 +0100
Message-ID: <4F54B1F2.70508@metafoo.de>
References: <1329904151-5927-1-git-send-email-lars@metafoo.de>
	<1329904151-5927-5-git-send-email-lars@metafoo.de>
	<20120302135959.GG3230@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-211.synserver.de (smtp-out-212.synserver.de
	[212.40.185.212])
	by alsa0.perex.cz (Postfix) with ESMTP id 0F4B5244C9
	for <alsa-devel@alsa-project.org>; Mon,  5 Mar 2012 13:28:56 +0100 (CET)
In-Reply-To: <20120302135959.GG3230@opensource.wolfsonmicro.com>
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
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Vinod Koul <vinod.koul@linux.intel.com>, Russell King <linux@arm.linux.org.uk>, Ryan Mallon <rmallon@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mika Westerberg <mika.westerberg@iki.fi>, alsa-devel@alsa-project.org, Wolfram Sang <w.sang@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 03/02/2012 02:59 PM, Mark Brown wrote:
> On Wed, Feb 22, 2012 at 10:49:08AM +0100, Lars-Peter Clausen wrote:
>> This patch adds a set of functions which are intended to be used when
>> implementing a dmaengine based sound PCM driver.
> 
> Having this framework is a substantial win and I got bored waiting for
> the repost of this and the subsequent patches (especially given that the
> merge window is drawing nearer).  Since the fix for ep93xx is so simple
> and it works on i.MX I went ahead and applied everything except the
> ep93xx conversion.  Thanks!
> 
> Please resend the ep93xx conversion along with the tweak to the core so
> we can get that working. 

I was at trade show for the rest of last week, without much time for
anything else. I will submit the missing patches in a moment.

> It would also be good to update FSI to use this library as it's also
> using dmaengine (the patch having been merged just before this one it
> got missed in the updates I expect).

I've had a look at the FSI dmaengine driver and it is not straight forward
to convert. For one it does not use cyclic dma transfers so it is more
something for Russel's patch and on the other hand the FSI PCM driver
introduces another layer of indirection which is used to be able to switch
between PIO and DMA. But as a result the functions the dmaengine PCM
framework provides don't really fit anymore.

- Lars
