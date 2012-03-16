From: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH v3 09/11] ASoC: fsl: remove the fatal error
 checking on codec-handle
Date: Fri, 16 Mar 2012 01:55:01 +0000
Message-ID: <4F629D71.3050102@freescale.com>
References: <20120309013216.GH2499@S2101-09.ap.freescale.net>
	<4F5FD706.8040209@freescale.com>
	<20120313234638.GY3177@opensource.wolfsonmicro.com>
	<4F6008FA.3040805@freescale.com>
	<20120314122723.GC3133@opensource.wolfsonmicro.com>
	<4F612319.50302@freescale.com>
	<20120315130253.GA6065@S2101-09.ap.freescale.net>
	<4F61F080.4090800@freescale.com>
	<20120315142115.GB6065@S2101-09.ap.freescale.net>
	<4F621D09.2080806@freescale.com>
	<20120316012711.GD6065@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
	(va3ehsobe006.messaging.microsoft.com [216.32.180.16])
	by alsa0.perex.cz (Postfix) with ESMTP id 25D98243A6
	for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2012 02:55:12 +0100 (CET)
In-Reply-To: <20120316012711.GD6065@S2101-09.ap.freescale.net>
Content-Language: en-US
Content-ID: <68FE3581C7DF4940B8EED6F6BF6AB9F9@mgd.freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

Shawn Guo wrote:
> Hmm, Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.txt
> is the binding document specifically for imx-sgtl5000 driver rather
> than for all fsl_ssi based machine drivers.  Since I have never seen
> and doubt will ever see the setup that two SSIs connect to two
> sgtl5000 codecs on any imx board, I do not see much point to update
> the documentation for that.
>
> If this is indeed a practical setup for PowerPC, it can be documented
> in the binding for PowerPC machine driver when there is future PowerPC
> machine drivers adopting the new binding.

Ok.  I was going to say that I'd like to see a template that applies to 
all SOCs with an SSI, but I guess that won't be that useful.

I'm just concerned that if there's no standard way to create bindings for 
machine drivers, we're going to end up with some kind of mess down the road.

-- 
Timur Tabi
Linux kernel developer at Freescale
