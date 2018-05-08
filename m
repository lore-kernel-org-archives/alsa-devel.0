From: Vinod Koul <vinod.koul@linaro.org>
Subject: Re: [PATCH 2/4] ASoC: compress: Clarify the intent of
 current compressed ops handling
Date: Tue, 8 May 2018 17:34:53 +0530
Message-ID: <20180508120453.GA22536@vkoul-mobl>
References: <20180426163007.5632-1-ckeepax@opensource.cirrus.com>
 <20180426163007.5632-2-ckeepax@opensource.cirrus.com>
 <20180503162714.GX6014@localhost>
 <20180504115922.GK20410@imbe.wolfsonmicro.main>
 <20180508083319.GA4519@vkoul-mobl>
 <20180508105253.GM20410@imbe.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl0-f66.google.com (mail-pl0-f66.google.com
 [209.85.160.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 176F9266F69
 for <alsa-devel@alsa-project.org>; Tue,  8 May 2018 14:04:57 +0200 (CEST)
Received: by mail-pl0-f66.google.com with SMTP id a39-v6so2112826pla.10
 for <alsa-devel@alsa-project.org>; Tue, 08 May 2018 05:04:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20180508105253.GM20410@imbe.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com, Vinod Koul <vinod.koul@intel.com>, patches@opensource.cirrus.com, lgirdwood@gmail.com, vkoul@kernel.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On 08-05-18, 11:52, Charles Keepax wrote:
> On Tue, May 08, 2018 at 02:03:19PM +0530, Vinod Koul wrote:
> > On 04-05-18, 12:59, Charles Keepax wrote:
> > > On Thu, May 03, 2018 at 09:57:14PM +0530, Vinod Koul wrote:
> > > > On Thu, Apr 26, 2018 at 05:30:05PM +0100, Charles Keepax wrote:
> > > That said however, thinking about it more I do think there are
> > > pretty reasonable systems that have multiple components on a
> > > compressed DAI. For example I could imagine a system where you
> > > have a DSP on both the AP and CODEC ends of the DAI link and
> > > they split the decode doing some work on each. In that case
> > > one would want calls like open and set_params to go to both
> > > components.
> > 
> > Am not sure if we can split the decode into multiple DSPs like
> > this :) Yes one can do processing and one can decode if both have
> > the capability but I don't forsee that being split, so not sure
> > if we need it!!!
> >
> 
> I think you definitely could split the decode across multiple
> DSPs like that, we have had processing split across multiple
> cores for various things on the CODECs. That said "Need it"
> is very strong, I would say such a system is plausible but
> not something I am aware anyone is actually building right now.

well processing is different, we are dealing with PCM data.
Decode is one shot, you get PCM output and then can do whatever
you want with it.

If decode is split what is the output format ;-)

> I guess my thinking was that the system is basically already
> supporting multiple components so it seemed like a step
> backwards to rip it out given there are plausible systems were
> it might be useful. And this patch is really just tidying up
> the already submitted code a little rather than changing the
> functionality in any substancial way.
> 
> That said if you feel strongly about it, I certainly don't
> need the support in the foreseeable future. I am happy to
> go back to something similar to my earlier patch that just
> locates the first device with compressed ops and calls the
> ops on that?  Although it might still be worth merging this
> one as an intermediate tidy up in that case.

Going back would be better, I leave it upto Mark on how he wants
to do this, either way am fine if end goal is met :)

> 
> Thanks,
> Charles

-- 
-- 
~Vinod
