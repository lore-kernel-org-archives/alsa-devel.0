From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [RFC 4/7] ASoC: Add dmaengine PCM helper functions
Date: Wed, 22 Feb 2012 13:52:33 +0100
Message-ID: <4F44E511.2040404@metafoo.de>
References: <1329904151-5927-1-git-send-email-lars@metafoo.de>
	<1329904151-5927-5-git-send-email-lars@metafoo.de>
	<20120222100150.GW22562@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-093.synserver.de (smtp-out-096.synserver.de
	[212.40.185.96])
	by alsa0.perex.cz (Postfix) with ESMTP id 95CB1103EDE
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2012 13:50:59 +0100 (CET)
In-Reply-To: <20120222100150.GW22562@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Vinod Koul <vinod.koul@linux.intel.com>, Ryan Mallon <rmallon@gmail.com>, alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Wolfram Sang <w.sang@pengutronix.de>, Mika Westerberg <mika.westerberg@iki.fi>, Shawn Guo <shawn.guo@linaro.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 02/22/2012 11:01 AM, Russell King - ARM Linux wrote:
> On Wed, Feb 22, 2012 at 10:49:08AM +0100, Lars-Peter Clausen wrote:
>> This patch adds a set of functions which are intended to be used when
>> implementing a dmaengine based sound PCM driver.
> 
> This isn't going to be usable on sa11x0 platforms, because we need to
> know the struct device underlying the DMA device before we allocate
> the buffers.

Which means the dma channel has to be requested before allocating the
buffers. Which can be done. Not with the current code but it can be
implemented on top of it.

I had a look at your 'generic' dmaengine PCM driver patch. And it looks like
you went to opposite way as I did in this patch. You implemented one driver
which is supposed to work for all cases, while my patch provides a set of
helper functions which can be used to implement a PCM driver. Your patch
only supports non-cyclic transfers, mine only supports cyclic transfers.

Your driver emulates cyclic transfers using non-cyclic transfers, in my
opinion it is better to add such a emulation layer to the dmaengine core
itself. This will allow other users to benefit from this as well and it
doesn't have to be reimplemented in other subsystems/driver. Also users
don't have to be updated if a dmaengine driver gets native support for
cyclic transfers. But, well, the code exists and it is a step in the right
direction so we should probably use it.

I suppose we could rearrange the code so that we can share most of it
between the cyclic and non-cyclic case. The non-cyclic case needs special
handling everywhere, which can be made conditional.

- Lars
