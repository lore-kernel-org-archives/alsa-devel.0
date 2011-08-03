From: Dong Aisheng-B29396 <B29396@freescale.com>
Subject: Re: [PATCH 1/1] ASoC: core: cache index fix
Date: Wed, 3 Aug 2011 07:03:54 +0000
Message-ID: <65EE16ACC360FA4D99C96DC085B3F7721F4ED6@039-SN1MPN1-002.039d.mgd.msft.net>
References: <65EE16ACC360FA4D99C96DC085B3F7721F43AA@039-SN1MPN1-002.039d.mgd.msft.net>
	<s5hoc08nk7t.wl%tiwai@suse.de>
	<65EE16ACC360FA4D99C96DC085B3F7721F443D@039-SN1MPN1-002.039d.mgd.msft.net>
	<s5hlivcnhe2.wl%tiwai@suse.de>
	<65EE16ACC360FA4D99C96DC085B3F7721F45A8@039-SN1MPN1-002.039d.mgd.msft.net>
	<s5haabsnfg2.wl%tiwai@suse.de>
	<20110802154815.GE25884@opensource.wolfsonmicro.com>
	<s5hipqfn65k.wl%tiwai@suse.de>
	<20110802164005.GI25884@opensource.wolfsonmicro.com>
	<s5h4o1zsn6o.wl%tiwai@suse.de>
	<20110803052333.GA16141@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from VA3EHSOBE007.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) by alsa0.perex.cz (Postfix) with ESMTP id 328292458E
	for <alsa-devel@alsa-project.org>;
	Wed,  3 Aug 2011 09:04:08 +0200 (CEST)
In-Reply-To: <20110803052333.GA16141@opensource.wolfsonmicro.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "w.sang@pengutronix.de" <w.sang@pengutronix.de>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "lrg@ti.com" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com]
> Sent: Wednesday, August 03, 2011 1:24 PM
> To: Takashi Iwai
> Cc: Dong Aisheng-B29396; alsa-devel@alsa-project.org;
> s.hauer@pengutronix.de; lrg@ti.com; linux-arm-kernel@lists.infradead.org;
> w.sang@pengutronix.de
> Subject: Re: [alsa-devel] [PATCH 1/1] ASoC: core: cache index fix
> 
> On Tue, Aug 02, 2011 at 08:06:23PM +0200, Takashi Iwai wrote:
> 
> > example.  So, alternatively, we can put the condition in some generic
> > filter function like readable/writeble things.
> 
> Yes, I suggested that already, these are just unreadable and unwritable
> registers :/

For padded cache array, the unreadable & unwritable function is correct
as Takashi indicated accessing the odd number of register index is invalid with
step = 2.
But for packed cache array...

There's a few confuse on the using of reg_cache_size and reg_cache_step
in current kernel. 
(like some drivers use packed cache while some use padded)

Maybe we need to first unify it.
