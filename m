From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH] ALSA: ASoC: fix PXA SSP port resume
Date: Fri, 29 Jan 2010 12:08:36 +0100
Message-ID: <20100129110836.GV28972@buzzloop.caiaq.de>
References: <1264674858-27461-1-git-send-email-daniel@caiaq.de>
	<20100129101307.GA3201@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 06DEF1038F5
	for <alsa-devel@alsa-project.org>; Fri, 29 Jan 2010 12:08:40 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20100129101307.GA3201@rakim.wolfsonmicro.main>
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
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 29, 2010 at 10:13:08AM +0000, Mark Brown wrote:
> On Thu, Jan 28, 2010 at 06:34:18PM +0800, Daniel Mack wrote:
> > Invalidate the cached hardware format on resume for PXA SSP ports.
> > Otherwise hw_params() will bail out early at the next stream start,
> > leaving the registers in a bogus state.
> 
> Would it not be better to write the cached state back to the hardware?
> Putting an invalid value in the cache seems like asking for trouble.

Hmm. I considered that, but the reason why the system failed to resume
in my case was that the ssp port was not active at this time. Otherwise,
the suspend/resume code would have already done the right thing.

And as the next client will indirectly call hw_params() again, the code
there will do the right thing with the invalidated cache.

Restoring the register values from priv->dai_fmt would imply adding code
to do everything what the other bit-fiddling functions do in a reverse
manner. Which is something I'd like to avoid :)

Another idea is to unconditionally save and restore the register set,
and deal with possible side-effects. Not sure what's really better.

Daniel
