From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: i.MX SDMA support
Date: Mon, 9 Aug 2010 14:19:56 +0200
Message-ID: <20100809121956.GA27749@pengutronix.de>
References: <20100809091157.GC20065@pengutronix.de>
	<1281350823.3035.54.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 14A83103806
	for <alsa-devel@alsa-project.org>;
	Mon,  9 Aug 2010 14:19:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1281350823.3035.54.camel@odin>
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
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 09, 2010 at 11:47:03AM +0100, Liam Girdwood wrote:
> On Mon, 2010-08-09 at 11:11 +0200, Sascha Hauer wrote:
> > Hi,
> > 
> > I just posted a series adding SDMA support for i.MX to the Arm Linux
> > Kernel mailing list.
> 
> I noticed. It's good to see SDMA support going upstream :) 
> 
> >  It also contains a patch for adding SDMA support
> > to the i.MX SSI units. I haven't cc'd alsa-devel because most of the
> > stuff is not sound related. I know at least Mark and Liam are
> > interested, so I leave a pointer here. The sound stuff needs to be
> > synchronized with the other patches, so it's probably best if all
> > patches go via my tree.
> 
> Yeah, that should be OK. However, we do have a ASoC core multi-component
> update merging later this week. This may conflict with some of your SDMA
> updates, although the multi-component support only really affects ASoC
> component probe() and remove() as every component is a regular Linux
> device now (with platform data, etc) and private data access.

That won't be a problem. The SDMA code will wait until the next merge
window anyway, I will rebase it after the multi-compoment merge if
necessary.

> 
> The multi-component branch is here:-
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/lrg/asoc-2.6.git topic/multi-component
> 
> I did have to make some changes to i.MX ASoC in order to de-couple some
> of the components in order for them to be distinct kernel devices. Any
> chance you could give this a test with the new SDMA code ?

Yes, will do later today or tomorrow. In fact, I wanted to do earlier, but
didn't find the time.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
