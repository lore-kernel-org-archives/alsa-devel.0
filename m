From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: snd_dmaengine: add common api for
 pcm_mmap
Date: Fri, 29 Jun 2012 18:42:23 +0200
Message-ID: <4FEDDAEF.5020609@metafoo.de>
References: <1340866886-24432-1-git-send-email-ldewangan@nvidia.com>
	<4FEC3B70.5030902@metafoo.de> <s5hobo3zl79.wl%tiwai@suse.de>
	<20120628121816.GB21029@sirena.org.uk>
	<4FEC4E62.3020101@metafoo.de>
	<20120628122830.GJ28922@opensource.wolfsonmicro.com>
	<4FEC4FA9.20004@nvidia.com> <s5hlij7zja0.wl%tiwai@suse.de>
	<4FEC5642.9080908@nvidia.com> <s5hk3yrzhte.wl%tiwai@suse.de>
	<4FEC5DC7.5060600@nvidia.com> <s5hd34jzgs0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-132.synserver.de (smtp-out-134.synserver.de
	[212.40.185.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 0CCAA11CFBE
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Jun 2012 18:38:34 +0200 (CEST)
In-Reply-To: <s5hd34jzgs0.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Stephen Warren <swarren@nvidia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>, "lrg@ti.com" <lrg@ti.com>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: alsa-devel@alsa-project.org

On 06/28/2012 03:51 PM, Takashi Iwai wrote:
> At Thu, 28 Jun 2012 19:06:07 +0530,
> Laxman Dewangan wrote:
> [...]
> 
> But, still we need to be careful about this.  As mentioned, there is
> no flag to know the possibility of writecombine mmap beforehand.
> It'd be nice if we have either a compile-time or a run-time flag /
> function to check that.  Then the driver can also expose the mmap
> capability to user-space depending on the flag.
> 

If writecombine is not supported it will fallback to a "normal" mmap.
Here's an excerpt from the DMA mapping documentation:

DMA_ATTR_WRITE_COMBINE
----------------------

DMA_ATTR_WRITE_COMBINE specifies that writes to the mapping may be
buffered to improve performance.

Since it is optional for platforms to implement DMA_ATTR_WRITE_COMBINE,
those that do not will simply ignore the attribute and exhibit default
behavior.

- Lars
