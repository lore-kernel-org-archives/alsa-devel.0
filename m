From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC - Support for multiple components
Date: Mon, 26 Apr 2010 14:13:31 +0100
Message-ID: <20100426131331.GA11022@rakim.wolfsonmicro.main>
References: <1271686144.3208.305.camel@odin>
	<201004201017.47719.peter.ujfalusi@nokia.com>
	<1271760367.3234.159.camel@odin>
	<20100426104939.GC2035@sirena.org.uk>
	<o2ked82fe3e1004260505jf33b4456g760b139de341ea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D98B710381C
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Apr 2010 15:13:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <o2ked82fe3e1004260505jf33b4456g760b139de341ea@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: vbarinov <vbarinov@embeddedalley.com>, Cliff Cai <cliff.cai@analog.com>, Joonyoung Shim <jy0922.shim@samsung.com>, alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "Candelaria Villareal,
	Jorge" <jorge.candelaria@ti.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, "dg@emlix.com" <dg@emlix.com>, Grant Likely <grant.likely@secretlab.ca>, Sedji Gaouaou <sedji.gaouaou@atmel.com>, "kyungmin.park" <kyungmin.park@samsung.com>, ben-linux <ben-linux@fluff.org>, Kuninori Morimoto <morimoto.kuninori@renesas.com>, "mano@roarinelk.homelinux.net" <mano@roarinelk.homelinux.net>, "anemo@mba.ocn.ne.jp" <anemo@mba.ocn.ne.jp>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 26, 2010 at 07:05:41AM -0500, Timur Tabi wrote:
> On Mon, Apr 26, 2010 at 5:49 AM, Mark Brown

> > It occurs to me that we probably want something a bit more flexible
> > here than just a numeric ID - most of the use cases for having more than
> > one of the same device are for things like 5.1 or dual speaker amps for
> > stereo where it'd be much more convenient to have the machine driver be
> > able to add text based prefixes to the control names (eg, "Left" and
> > "Right").

> How about instead of a string + id, we just have a string, and then
> define a convention for various devices.  For instance, the codec
> could be "name@bus-addr", so my cs4270 driver would register something
> like "cs4270@0-004f".

Well, we already have a struct device for the actual chip so we can just
dev_name() away.  The problem is presenting the results to userspace in
a useful fashion.
