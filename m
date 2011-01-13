From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: Make register_card API available to
 drivers
Date: Thu, 13 Jan 2011 22:43:30 +0530
Message-ID: <438BB0150E931F4B9CE701519A4463010844672070@bgsmsx502.gar.corp.intel.com>
References: <1294901358-14364-1-git-send-email-vinod.koul@intel.com>
	<20110113112607.GA9936@opensource.wolfsonmicro.com>
	<438BB0150E931F4B9CE701519A4463010844671F9B@bgsmsx502.gar.corp.intel.com>
	<20110113114203.GA30351@opensource.wolfsonmicro.com>
	<438BB0150E931F4B9CE701519A4463010844671FD1@bgsmsx502.gar.corp.intel.com>
	<20110113133435.GC30351@opensource.wolfsonmicro.com>
	<438BB0150E931F4B9CE701519A4463010844671FDC@bgsmsx502.gar.corp.intel.com>
	<20110113150811.GE30351@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 6822D24681
	for <alsa-devel@alsa-project.org>; Thu, 13 Jan 2011 18:14:09 +0100 (CET)
In-Reply-To: <20110113150811.GE30351@opensource.wolfsonmicro.com>
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

> 
> > Above works well for probe, but not sure if that is intention for remove().
> > Do you expect the machine driver to call codec and platform remove before it
> > unregisters the card.
> > The code inside:
> > 	if (card->instantiated)
> 
> No, the core code needs to do that as part of removing the card.
Agreed, sending you're the split patchset, code is almost same

~Vinod
