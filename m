From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: ASoC: no-pcm (backend) error propagation
Date: Fri, 01 Mar 2013 21:25:13 +0000
Message-ID: <1362173113.4439.46.camel@loki>
References: <190351B32828744FBA3BD9565204D27B01CA3AF2@NA-MBX-03.mgc.mentorg.com>
 <1361953433.28121.33.camel@vega> <512E29B8.8050708@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id E871526036C
 for <alsa-devel@alsa-project.org>; Fri,  1 Mar 2013 22:25:18 +0100 (CET)
In-Reply-To: <512E29B8.8050708@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, "Frkuska, Joshua" <Joshua_Frkuska@mentor.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2013-02-27 at 09:43 -0600, Pierre-Louis Bossart wrote:
> > It was originally intended that any underrun / overrun issues in a BE
> > DAI would be handled internally by the audio DSP (and this worked well
> > with the OMAP4 ABE). However, it is probably a good a idea to have a
> > better mechanism for reporting BE xrun issues up the stack to the host
> > CPU side too.
> >
> > Currently the FE PCM xrun mechanism and FE pointer() callback could be
> > used by the host to get the size of any FE:BE underrun/overrun. This
> > isn't ideal and wont work when there can be multiple BEs for a FE.
> >
> > It looks like some new code is required here to get this working
> > correctly for BEs.
> 
> 
> My view is that that underruns at the DSP level are fatal anyway, and 
> that they a) should be avoided with proper real-time designs and b) they 
> should be logged as error conditions to debug should they occur, not be 
> tied to a FE. It would be really complicated to add code to 
> back-propagate the errors, and if you have mixing/routing what 
> individual FEs would do when this is a system error really.
> -Pierre

I agree, it would mostly be useful for DSP debug purposes e.g. things
like DSP clock scaling/gating, FW errors. It was certainly never an
issue with the OMAP ABE and we wont need it for SST audio either.

Fwiw, it may not even be too complicated to implement since the BE PCM
is a subset of the standard PCM and there is some code that already back
propagates the routing when we re-parent BE's. It really depends on
whether anyone cares enough to scope out a solution.

Liam 
