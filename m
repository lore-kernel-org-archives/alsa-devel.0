From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: ASoC - Support for multiple components
Date: Mon, 19 Apr 2010 15:09:04 +0100
Message-ID: <1271686144.3208.305.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f218.google.com (mail-bw0-f218.google.com
	[209.85.218.218])
	by alsa0.perex.cz (Postfix) with ESMTP id 234C824746
	for <alsa-devel@alsa-project.org>;
	Mon, 19 Apr 2010 16:09:13 +0200 (CEST)
Received: by bwz10 with SMTP id 10so4894379bwz.4
	for <alsa-devel@alsa-project.org>; Mon, 19 Apr 2010 07:09:12 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
Cc: vbarinov <vbarinov@embeddedalley.com>, Cliff Cai <cliff.cai@analog.com>, Sascha Hauer <s.hauer@pengutronix.de>, Joonyoung Shim <jy0922.shim@samsung.com>, mano@roarinelk.homelinux.net, Mark Brown <broonie@opensource.wolfsonmicro.com>, "Candelaria Villareal, Jorge" <jorge.candelaria@ti.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, dg@emlix.com, Grant Likely <grant.likely@secretlab.ca>, Sedji Gaouaou <sedji.gaouaou@atmel.com>, "kyungmin.park" <kyungmin.park@samsung.com>, ben-linux <ben-linux@fluff.org>, Kuninori Morimoto <morimoto.kuninori@renesas.com>, Timur Tabi <timur@freescale.com>, anemo@mba.ocn.ne.jp, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Currently ASoC is designed around a single CODEC and a single platform
DMA engine in every sound card instance. This is fine for most embedded
devices but current smart phone and STB designs are starting to outgrow
this architecture. 

I'm currently working on adding ASoC support for multiple different
CODECs and Platforms (DMA, Audio Engines) into a single sound card
instance. This work will allow ASoC to support N CODECs and N platforms
per sound card instance and also allow better integration of audio
components from GSM MODEMs, BT, FM transceivers and PCM DSPs.

I've now split each ASoC component (i.e. DMA, CODEC, DAI) into driver
and device structures. This now means each ASoC component is a regular
kernel device and can have private device data and platform_data. It
should also provide better support for open firmware and flattened
device tree.

I've CC'ed folks on this mail who have either contributed or maintain
ASoC architecture code. Please have a look at your architecture and test
if you can. I only have access to OMAP and pxa3xx hardware and as such
have only tested the changes on these two architectures only. I'd
appreciated anyone else testing on the other architectures too.

The changes are all purely mechanical to component registration and
component private data only. However, some architectures (txx9, imx,
s3c) required some extra effort to use the device model as they had (to
varying degrees) coupled their DMA and DAI code more tightly. The fsl
platform also required extra work around the open firmware interface.
Grant/Timur do we still need soc-of-simple now that all components are
regular devices ?

The code is in my topic/multi-component branch here :-

git://git.kernel.org/pub/scm/linux/kernel/git/lrg/asoc-2.6.git

It's currently a patch for each component for easier review atm but will
be rebased into a single commit when it's ready for upstream so it won't
break bisect.

If the testing can be done quickly then we can go for 2-6.35 otherwise
we are looking at 2.6.36.

Thanks

Liam

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
