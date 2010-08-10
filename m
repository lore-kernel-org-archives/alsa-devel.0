From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: i.MX SDMA support
Date: Tue, 10 Aug 2010 14:39:06 +0100
Message-ID: <20100810133906.GB6416@rakim.wolfsonmicro.main>
References: <20100809091157.GC20065@pengutronix.de>
	<1281350823.3035.54.camel@odin>
	<20100809121956.GA27749@pengutronix.de>
	<64008892-3D75-4309-A623-CCE9B335F77F@opensource.wolfsonmicro.com>
	<20100810131527.GK27749@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C107024385
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Aug 2010 15:39:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100810131527.GK27749@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 10, 2010 at 03:15:27PM +0200, Sascha Hauer wrote:

> Linus Walleij just proposed to implement the SDMA engine as part of the
> dmaengine API, so expect some delays here.

I saw.  I suspect it might be sensible to merge SDMA support and then do
updates for DMAENGINE as followup work, the lack of it is painful enough
to make the feature worth the win.

> I just looked at the i.MX part in the multi-component update and this
> is currently far from being in a working state, so there's still some
> work to do before thinking about possible conflicts...

Oh dear.  It has been difficult to get testers, unfortunately.
