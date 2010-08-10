From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: i.MX SDMA support
Date: Tue, 10 Aug 2010 15:15:27 +0200
Message-ID: <20100810131527.GK27749@pengutronix.de>
References: <20100809091157.GC20065@pengutronix.de>
	<1281350823.3035.54.camel@odin>
	<20100809121956.GA27749@pengutronix.de>
	<64008892-3D75-4309-A623-CCE9B335F77F@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id C78572436C
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Aug 2010 15:15:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <64008892-3D75-4309-A623-CCE9B335F77F@opensource.wolfsonmicro.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 09, 2010 at 03:09:44PM +0100, Mark Brown wrote:
> On 9 Aug 2010, at 13:19, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> 
> > On Mon, Aug 09, 2010 at 11:47:03AM +0100, Liam Girdwood wrote:
> >> 
> >> Yeah, that should be OK. However, we do have a ASoC core multi-component
> >> update merging later this week. This may conflict with some of your SDMA
> >> updates, although the multi-component support only really affects ASoC
> >> component probe() and remove() as every component is a regular Linux
> >> device now (with platform data, etc) and private data access.
> > 
> > That won't be a problem. The SDMA code will wait until the next merge
> > window anyway, I will rebase it after the multi-compoment merge if
> > necessary.
> 
> This is precisely the issue - multi component will go in 2.6.37 too,
> meaning conflicts in -next unless one tree is pulled into the other
> during the release cycle.

Linus Walleij just proposed to implement the SDMA engine as part of the
dmaengine API, so expect some delays here.
I just looked at the i.MX part in the multi-component update and this
is currently far from being in a working state, so there's still some
work to do before thinking about possible conflicts...

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
