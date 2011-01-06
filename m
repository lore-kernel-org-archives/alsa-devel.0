From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: Re: regarding references taken on platform and codec
 driver modules
Date: Thu, 6 Jan 2011 14:41:29 +0530
Message-ID: <438BB0150E931F4B9CE701519A44630104C119C43D@bgsmsx502.gar.corp.intel.com>
References: <98769532B4BB14429434178695419EAE053BF51941@bgsmsx501.gar.corp.intel.com>
	<20110103155454.GE6783@opensource.wolfsonmicro.com>
	<98769532B4BB14429434178695419EAE053BF51B26@bgsmsx501.gar.corp.intel.com>
	<20110103163532.GB7370@opensource.wolfsonmicro.com>
	<98769532B4BB14429434178695419EAE053BF51BC3@bgsmsx501.gar.corp.intel.com>
	<20110104154825.GF24774@opensource.wolfsonmicro.com>
	<98769532B4BB14429434178695419EAE053BFABE47@bgsmsx501.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id B5A0A243BE
	for <alsa-devel@alsa-project.org>; Thu,  6 Jan 2011 10:12:56 +0100 (CET)
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
To: "Harsha, Priya" <priya.harsha@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

> During the testing codec driver probe was failing and this results in wrong
> reference of platform driver .
> 
> On investigating the issue is in soc_bind_dai_link()
> 
> It takes the reference of cpu_dai and adds the dai in the runtime structure.
> But since the codec was not found these references are kept and modules cant be
> unloaded.
> 
> Now thinking on this and other reference patch recently applied, IMO we can
> instead of taking the module reference check if cpu_dai is probed.
> If probed then only go ahead otherwise return error
> 
This won't work either as cpu_dai is probed after bind_dai_link()

This issue is on removal of soc_remove() it doesn't free up the reference if the card is not instantiated
So in case one of the probes fails we should handle this in soc_remove in else for instantated
 
		    if (rtd->codec->probed)
                        module_put(rtd->codec->dev->driver->owner);
                if (rtd->platform->probed)
                        module_put(rtd->platform->dev->driver->owner);
                for (i = 0; i < card->num_rtd; i++)
                        module_put(rtd[i].cpu_dai->dev->driver->owner);

Would this be the correct way to solve this?

~Vinod
