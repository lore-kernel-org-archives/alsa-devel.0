From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: Make register_card API available to
 drivers
Date: Thu, 13 Jan 2011 19:31:48 +0530
Message-ID: <438BB0150E931F4B9CE701519A4463010844671FDC@bgsmsx502.gar.corp.intel.com>
References: <1294901358-14364-1-git-send-email-vinod.koul@intel.com>
	<20110113112607.GA9936@opensource.wolfsonmicro.com>
	<438BB0150E931F4B9CE701519A4463010844671F9B@bgsmsx502.gar.corp.intel.com>
	<20110113114203.GA30351@opensource.wolfsonmicro.com>
	<438BB0150E931F4B9CE701519A4463010844671FD1@bgsmsx502.gar.corp.intel.com>
	<20110113133435.GC30351@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id CEEA6103873
	for <alsa-devel@alsa-project.org>; Thu, 13 Jan 2011 15:01:58 +0100 (CET)
In-Reply-To: <20110113133435.GC30351@opensource.wolfsonmicro.com>
Content-Language: en-US
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Harsha,
	Priya" <priya.harsha@intel.com>, "Bensaid,
	Selma" <selma.bensaid@intel.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

> The above doesn't require any change in existing machine drivers - they
> still pass the card data structure into the soc-audio device which then
> registers with the core.  This the whole point, move the soc-audio
> device over to using an API that can also be used externally then
> convert the machine drivers to stop using the soc-audio device.
> 
> > Btw this make me wonder what will soc_probe be used (it is not doing anything)
> > Do we still need this and creating soc-audio device?
> 
> That's the point I'm making above.  It shouldn't be involved at all
> except as part of the soc-audio device code, anything registering a card
> directly should never call it.
Agreed :)
Knowing the context helps...

Above works well for probe, but not sure if that is intention for remove().
Do you expect the machine driver to call codec and platform remove before it
unregisters the card.
The code inside: 
	if (card->instantiated)

~Vinod
