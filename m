From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Make register_card API available to
 drivers
Date: Thu, 13 Jan 2011 13:34:36 +0000
Message-ID: <20110113133435.GC30351@opensource.wolfsonmicro.com>
References: <1294901358-14364-1-git-send-email-vinod.koul@intel.com>
	<20110113112607.GA9936@opensource.wolfsonmicro.com>
	<438BB0150E931F4B9CE701519A4463010844671F9B@bgsmsx502.gar.corp.intel.com>
	<20110113114203.GA30351@opensource.wolfsonmicro.com>
	<438BB0150E931F4B9CE701519A4463010844671FD1@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C19E310385E
	for <alsa-devel@alsa-project.org>; Thu, 13 Jan 2011 14:36:51 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <438BB0150E931F4B9CE701519A4463010844671FD1@bgsmsx502.gar.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Koul, Vinod" <vinod.koul@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Harsha,
	Priya" <priya.harsha@intel.com>, "Bensaid,
	Selma" <selma.bensaid@intel.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 13, 2011 at 06:54:52PM +0530, Koul, Vinod wrote:

> > My plan for this when I originally wrote the comment had been to make
> > the contents of the soc-audio device probe and removal look exactly like
> > what you'd write directly in a machine driver so no code except for the
> > code doing the soc-audio device had any idea it was there.  This would
> > keep backwards compatiblity without special casing, making things more
> > maintainable.

> Hmmmm, I didn't want to change the current machine drivers yet, hence tried to
> move the code of soc_probe into card_register.
> So that works neatly (doesn't matter who is doing, machine or core)
> Only thing which I kept is to check for card pointer and if valid then call
> register (assuming someone is still using old method) which we should mark
> deprecated

The above doesn't require any change in existing machine drivers - they
still pass the card data structure into the soc-audio device which then
registers with the core.  This the whole point, move the soc-audio
device over to using an API that can also be used externally then
convert the machine drivers to stop using the soc-audio device.

> Btw this make me wonder what will soc_probe be used (it is not doing anything)
> Do we still need this and creating soc-audio device?

That's the point I'm making above.  It shouldn't be involved at all
except as part of the soc-audio device code, anything registering a card
directly should never call it.
