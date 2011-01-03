From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: Re: [PATCH 1/4] ASoC sst: Add msic codec driver
Date: Mon, 3 Jan 2011 21:06:56 +0530
Message-ID: <438BB0150E931F4B9CE701519A44630104C10F2EC1@bgsmsx502.gar.corp.intel.com>
References: <1293707551-8308-1-git-send-email-vinod.koul@intel.com>
	<20110102133322.GC4935@opensource.wolfsonmicro.com>
	<438BB0150E931F4B9CE701519A44630104C10F2BD7@bgsmsx502.gar.corp.intel.com>
	<20110103152535.GA6783@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id E142210387D
	for <alsa-devel@alsa-project.org>; Mon,  3 Jan 2011 16:37:16 +0100 (CET)
In-Reply-To: <20110103152535.GA6783@opensource.wolfsonmicro.com>
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

> > > This looks mostly OK, but you probably want to run it through
> > > checkpatch.pl.  For quite a few of the debug prints you've got here
> > > you're replicating stuff that's in the core as standard - if you turn on
> > > debug logs from the core you should get equivalent logging.
> 
> > Yes we have run checkpatch. Currently yes we have quite a few logs, we will
> 
> There's quite a few places where there are coding style issues, in
> general if your code doesn't look like other kernel code that's a
> problem.  One of the most frequent issues was that you weren't using
> spaces around /* and */.
Checkpatch doesn't seem to catch these, have fixed them now.
Any other inconsistency you noted which may not be detected by checkpatch

> > remove them later when we add the capture, jack detection etc. It would be
> > nice to have these logs on.
> 
> It would be good if you could at least make the logging consistent with
> the rest of the subsystem, and as I say avoid replicating logging which
> is already provided by the subsystem.  The point is not that this stuff
> exists, the point is that it's replicating a facility that's already
> there.
Agreed, I have removed the duplication of what is there already in soc-core

~Vinod
