From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC - Support for multiple components
Date: Mon, 26 Apr 2010 15:24:01 +0100
Message-ID: <20100426142401.GA12539@rakim.wolfsonmicro.main>
References: <1271686144.3208.305.camel@odin>
	<201004201017.47719.peter.ujfalusi@nokia.com>
	<1271760367.3234.159.camel@odin>
	<20100426104939.GC2035@sirena.org.uk>
	<1272280647.3208.6.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1BC3E10382E
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Apr 2010 16:24:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1272280647.3208.6.camel@odin>
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
Cc: vbarinov <vbarinov@embeddedalley.com>, Cliff Cai <cliff.cai@analog.com>, Joonyoung Shim <jy0922.shim@samsung.com>, alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "Candelaria Villareal,
	Jorge" <jorge.candelaria@ti.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, "dg@emlix.com" <dg@emlix.com>, Grant Likely <grant.likely@secretlab.ca>, Sedji Gaouaou <sedji.gaouaou@atmel.com>, "kyungmin.park" <kyungmin.park@samsung.com>, ben-linux <ben-linux@fluff.org>, Kuninori Morimoto <morimoto.kuninori@renesas.com>, "mano@roarinelk.homelinux.net" <mano@roarinelk.homelinux.net>, Timur Tabi <timur@freescale.com>, "anemo@mba.ocn.ne.jp" <anemo@mba.ocn.ne.jp>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 26, 2010 at 12:17:27PM +0100, Liam Girdwood wrote:

> So I think here we can have an optional 'identifier' that could be used
> to describe the intended use case better (like the "Left" and "Right"
> above). If the string ID is not supplied we can revert back to the
> number or nothing at all i.e. if the system is a simple single codec
> design.

Yes, that was pretty much what I was thinking.  Or use the deV_name()
instead of the number, I guess.
