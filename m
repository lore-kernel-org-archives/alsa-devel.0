From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: Re: [PATCH 3/4] ASoC sst: Add mid machine driver
Date: Mon, 3 Jan 2011 11:09:16 +0530
Message-ID: <438BB0150E931F4B9CE701519A44630104C10F2BEE@bgsmsx502.gar.corp.intel.com>
References: <1293707593-8372-1-git-send-email-vinod.koul@intel.com>
	<20110102134715.GE4935@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 7EC4D10386A
	for <alsa-devel@alsa-project.org>; Mon,  3 Jan 2011 06:39:42 +0100 (CET)
In-Reply-To: <20110102134715.GE4935@opensource.wolfsonmicro.com>
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
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "alan@linux.intel.com" <alan@linux.intel.com>, "Harsha,
	Priya" <priya.harsha@intel.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

> > This patch adds the mic machine driver
> > The mid machine driver glues the msic and mid_platfrom driver to form the
> asoc sound driver
> 
> So, this isn't actually doing any sort of interface with your BIOS or
> otherwise doing anything system-specific.  
It is not

> If this is intended to be
> a generic driver that manages the interaction with your BIOS then I'd
> expect to see something like that.  If it's a driver for a specific
> system then I'd expect the driver to say what it's a driver for.
No, per your suggestion we made it machine specific driver. Yes will rename it
to mid_machine_mfld as this is Medfield specific machine driver
Does that fix your concern?
 
> Also, looking at your CODEC driver I'm not seeing anything that looks
> like the handling for the three "nameless" CODEC vendors you've got -
> given that you've got vendor workarounds in the code there this is
> really surprising.
The msic.c is msic codec which is specific to Medfield platform only. The other
three codecs are for Moorestown and we will add them ( 3 separate codec drivers)
when we add Moorestown machine (next after completing this)

~Vinod
