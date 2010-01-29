From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: ASoC: fix PXA SSP port resume
Date: Fri, 29 Jan 2010 14:00:01 +0000
Message-ID: <20100129140001.GB4768@rakim.wolfsonmicro.main>
References: <1264674858-27461-1-git-send-email-daniel@caiaq.de>
	<20100129101307.GA3201@rakim.wolfsonmicro.main>
	<20100129110836.GV28972@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3CA491038FA
	for <alsa-devel@alsa-project.org>; Fri, 29 Jan 2010 15:00:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20100129110836.GV28972@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 29, 2010 at 12:08:36PM +0100, Daniel Mack wrote:

> And as the next client will indirectly call hw_params() again, the code
> there will do the right thing with the invalidated cache.

Yeah, I know the code is actually reasonably safe - it just doesn't give
me the warm and fuzzies to do the invalidation by programming a random
value in there simply on the off chance that at some point in the future
that winds up being a valid value and so the same problem recurs.

> Restoring the register values from priv->dai_fmt would imply adding code
> to do everything what the other bit-fiddling functions do in a reverse
> manner. Which is something I'd like to avoid :)

Oh, right.  I'd forgotten that that was what it was actually storing.

> Another idea is to unconditionally save and restore the register set,
> and deal with possible side-effects. Not sure what's really better.

I think that'd be the the most robust solution with the way things are
structured in the driver.
