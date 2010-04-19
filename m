From: Timur Tabi <timur@freescale.com>
Subject: Re: ASoC - Support for multiple components
Date: Mon, 19 Apr 2010 09:14:47 -0500
Message-ID: <4BCC6557.1030703@freescale.com>
References: <1271686144.3208.305.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 7A0D61037F8
	for <alsa-devel@alsa-project.org>;
	Mon, 19 Apr 2010 16:14:50 +0200 (CEST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o3JEEmBp020152
	for <alsa-devel@alsa-project.org>; Mon, 19 Apr 2010 07:14:49 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o3JENxCp025574
	for <alsa-devel@alsa-project.org>; Mon, 19 Apr 2010 09:24:00 -0500 (CDT)
In-Reply-To: <1271686144.3208.305.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: vbarinov <vbarinov@embeddedalley.com>, alsa-devel <alsa-devel@alsa-project.org>, Joonyoung Shim <jy0922.shim@samsung.com>, mano@roarinelk.homelinux.net, Mark Brown <broonie@opensource.wolfsonmicro.com>, Cliff Cai <cliff.cai@analog.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, dg@emlix.com, Grant Likely <grant.likely@secretlab.ca>, Sedji Gaouaou <sedji.gaouaou@atmel.com>, "kyungmin.park" <kyungmin.park@samsung.com>, "Candelaria Villareal, Jorge" <jorge.candelaria@ti.com>, ben-linux <ben-linux@fluff.org>, Kuninori Morimoto <morimoto.kuninori@renesas.com>, Sascha Hauer <s.hauer@pengutronix.de>, anemo@mba.ocn.ne.jp
List-Id: alsa-devel@alsa-project.org

Liam Girdwood wrote:
> Currently ASoC is designed around a single CODEC and a single platform
> DMA engine in every sound card instance. This is fine for most embedded
> devices but current smart phone and STB designs are starting to outgrow
> this architecture. 
> 
> I'm currently working on adding ASoC support for multiple different
> CODECs and Platforms (DMA, Audio Engines) into a single sound card
> instance. This work will allow ASoC to support N CODECs and N platforms
> per sound card instance and also allow better integration of audio
> components from GSM MODEMs, BT, FM transceivers and PCM DSPs.

Yea!

> I've now split each ASoC component (i.e. DMA, CODEC, DAI) into driver
> and device structures. This now means each ASoC component is a regular
> kernel device and can have private device data and platform_data. It
> should also provide better support for open firmware and flattened
> device tree.

Yea!

> I've CC'ed folks on this mail who have either contributed or maintain
> ASoC architecture code. Please have a look at your architecture and test
> if you can. I only have access to OMAP and pxa3xx hardware and as such
> have only tested the changes on these two architectures only. I'd
> appreciated anyone else testing on the other architectures too.

I'll take a look at it this week or next.

> The changes are all purely mechanical to component registration and
> component private data only. However, some architectures (txx9, imx,
> s3c) required some extra effort to use the device model as they had (to
> varying degrees) coupled their DMA and DAI code more tightly. The fsl
> platform also required extra work around the open firmware interface.
> Grant/Timur do we still need soc-of-simple now that all components are
> regular devices ?

I've never looked at soc-of-simple before, so I can't say.  Obviously, I've never needed it, and I never planned to use it.

> The code is in my topic/multi-component branch here :-
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/lrg/asoc-2.6.git
> 
> It's currently a patch for each component for easier review atm but will
> be rebased into a single commit when it's ready for upstream so it won't
> break bisect.
> 
> If the testing can be done quickly then we can go for 2-6.35 otherwise
> we are looking at 2.6.36.

Ok.

-- 
Timur Tabi
Linux kernel developer at Freescale
