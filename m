From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC - Support for multiple components
Date: Thu, 22 Apr 2010 02:41:59 +0900
Message-ID: <20100421174158.GA19576@opensource.wolfsonmicro.com>
References: <1271686144.3208.305.camel@odin>
	<201004201017.47719.peter.ujfalusi@nokia.com>
	<1271760367.3234.159.camel@odin>
	<201004210853.09498.peter.ujfalusi@nokia.com>
	<1271834326.3234.27.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A6DAE2456C
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Apr 2010 19:42:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1271834326.3234.27.camel@odin>
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
Cc: vbarinov <vbarinov@embeddedalley.com>, Cliff Cai <cliff.cai@analog.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Timur Tabi <timur@freescale.com>, Sascha Hauer <s.hauer@pengutronix.de>, "Candelaria Villareal,
	Jorge" <jorge.candelaria@ti.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, "dg@emlix.com" <dg@emlix.com>, Grant Likely <grant.likely@secretlab.ca>, Sedji Gaouaou <sedji.gaouaou@atmel.com>, "kyungmin.park" <kyungmin.park@samsung.com>, ben-linux <ben-linux@fluff.org>, Kuninori Morimoto <morimoto.kuninori@renesas.com>, "mano@roarinelk.homelinux.net" <mano@roarinelk.homelinux.net>, "anemo@mba.ocn.ne.jp" <anemo@mba.ocn.ne.jp>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 21, 2010 at 08:18:46AM +0100, Liam Girdwood wrote:
> On Wed, 2010-04-21 at 08:53 +0300, Peter Ujfalusi wrote:

> > I see. How these IDs will be added?
> > Will does are given by the core automatically based on device load order, or 
> > will the machine driver have the ability to specify the ID for a codec?

> The machine driver will be able to specify the ID.

I guess for the default we could do something like sort by the
dev_name() of the CODEC or something.

> > Another question: how the PCM interfaces will be seen when we have multiple 
> > codec/dai in a card?
> > I suppose we will have multiple PCMs in a card, when we have multiple codec 
> > (multiple dai pairs)..?

> Yes, that's correct. We already support many cards with multiple PCMs
> atm. e.g. some WM9713 based cards already support 3 PCMs - 1 HiFi, 1
> voice and 1 System.

Pandora is another example in mainline.
