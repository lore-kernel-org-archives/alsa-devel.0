From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [RFC 7/7] ASoC: ep93xx-pcm: Use dmaengine PCM
 helper functions
Date: Tue, 28 Feb 2012 15:17:06 +0100
Message-ID: <4F4CE1E2.80404@metafoo.de>
References: <1329904151-5927-1-git-send-email-lars@metafoo.de>
	<1329904151-5927-8-git-send-email-lars@metafoo.de>
	<20120227081933.GA3868@mwesterb-mobl.ger.corp.intel.com>
	<4F4B442D.2050902@metafoo.de>
	<20120227190159.GC3868@mwesterb-mobl.ger.corp.intel.com>
	<4F4C94B6.4050508@metafoo.de>
	<20120228125244.GK3683@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
	(mailhost.informatik.uni-hamburg.de [134.100.9.70])
	by alsa0.perex.cz (Postfix) with ESMTP id 8219324671
	for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2012 15:17:17 +0100 (CET)
In-Reply-To: <20120228125244.GK3683@opensource.wolfsonmicro.com>
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
Cc: Vinod Koul <vinod.koul@linux.intel.com>, Russell King <linux@arm.linux.org.uk>, Ryan Mallon <rmallon@gmail.com>, Liam Girdwood <lrg@ti.com>, Sascha Hauer <s.hauer@pengutronix.de>, alsa-devel@alsa-project.org, Wolfram Sang <w.sang@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Mika Westerberg <mika.westerberg@iki.fi>
List-Id: alsa-devel@alsa-project.org

On 02/28/2012 01:52 PM, Mark Brown wrote:
> On Tue, Feb 28, 2012 at 09:47:50AM +0100, Lars-Peter Clausen wrote:
>> On 02/27/2012 08:01 PM, Mika Westerberg wrote:
> 
>>> However, I noticed that prtd->pos was never set to zero as it was in the
>>> original ep93xx-pcm driver. With following addition to your patch, playback
>>> works fine.
> 
>> Ah, nice :)
> 
> Looking good.  Can you please resend the series with this fix applied
> and all the acks you've collected?

I don't think there were any Acked-bys, just a Tested-by from Shawn Guo.

Mika, can I get a Tested-by or Acked-by for this patch from you?

Thanks,
- Lars
