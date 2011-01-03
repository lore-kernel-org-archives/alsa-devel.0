From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] ASoC sst: Add msic codec driver
Date: Mon, 3 Jan 2011 15:44:30 +0000
Message-ID: <20110103154430.GD6783@opensource.wolfsonmicro.com>
References: <1293707551-8308-1-git-send-email-vinod.koul@intel.com>
	<20110102133322.GC4935@opensource.wolfsonmicro.com>
	<438BB0150E931F4B9CE701519A44630104C10F2BD7@bgsmsx502.gar.corp.intel.com>
	<20110103152535.GA6783@opensource.wolfsonmicro.com>
	<438BB0150E931F4B9CE701519A44630104C10F2EC1@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B309B2414A
	for <alsa-devel@alsa-project.org>; Mon,  3 Jan 2011 16:44:12 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <438BB0150E931F4B9CE701519A44630104C10F2EC1@bgsmsx502.gar.corp.intel.com>
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
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "alan@linux.intel.com" <alan@linux.intel.com>, "Harsha,
	Priya" <priya.harsha@intel.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 03, 2011 at 09:06:56PM +0530, Koul, Vinod wrote:

> > There's quite a few places where there are coding style issues, in
> > general if your code doesn't look like other kernel code that's a
> > problem.  One of the most frequent issues was that you weren't using
> > spaces around /* and */.

> Checkpatch doesn't seem to catch these, have fixed them now.
> Any other inconsistency you noted which may not be detected by checkpatch

I'll point them out when I notice them; like I say this is something you
should be able to check by comparing with other code.
