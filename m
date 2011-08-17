From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] ASoC: Fix check for symmetric rate
	enforcement
Date: Wed, 17 Aug 2011 09:11:23 +0200
Message-ID: <20110817071123.GF31404@pengutronix.de>
References: <20110817062753.GB31404@pengutronix.de>
	<20110817065014.GB12344@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 6EC8D1038BC
	for <alsa-devel@alsa-project.org>;
	Wed, 17 Aug 2011 09:11:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110817065014.GB12344@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Lambrecht =?iso-8859-15?Q?J=FCrgen?= <J.Lambrecht@TELEVIC.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 17, 2011 at 03:50:16PM +0900, Mark Brown wrote:
> On Wed, Aug 17, 2011 at 08:27:53AM +0200, Sascha Hauer wrote:
> 
> > The ASoC core tries to not enforce symmetric rates when
> > two streams open simultaneously. It does so by checking
> > rtd->rate being zero. This works exactly once after booting
> > because it is not set to zero again when the streams close.
> > Fix this by clearing rtd->rate when no active stream is left.
> 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> 
> Applied, thanks.  Though I suspect that in practice this may actually be
> less robust due to the general raciness of the way we configure and
> start the streams - I seem to recall the code works this way semi
> deliberately so that we always have a rate selected; most systems only
> ever use one rate on symmetric audio interfaces.

I looked into it yesterday and I found no way to fix this properly :(

The original problem I had was subsequent calls of:

arecord -r 16000 | aplay
arecord -r 8000 | aplay

The first call after booting worked, but then strange things happen.
rtd->rate is still 16000 when arecord opens. Then aplay opens and
the ASoC core forces 16000Hz because of rtd->rate still being 16000.
arecord can change the rate to 8000Hz because the minmax constraint
was not present at open time. aplay then switches the rate back
to 16000Hz which results in an inconsistent state. I think this
is only one variant of the game.

With my patch applied we get the "Not enforcing symmetric rates.."
warning each time with arecord | aplay which is not nice either.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
