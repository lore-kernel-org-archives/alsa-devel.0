From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: About ASoC DAIs cleanup
Date: Thu, 14 Dec 2017 10:36:48 +0530
Message-ID: <20171214050648.GU18649@localhost>
References: <20171208084103.GC18649@localhost>
 <87fu8lio74.wl%kuninori.morimoto.gx@renesas.com>
 <20171208105545.GE18649@localhost>
 <87shciup8e.wl%kuninori.morimoto.gx@renesas.com>
 <87r2s2uo55.wl%kuninori.morimoto.gx@renesas.com>
 <87o9n6ukyg.wl%kuninori.morimoto.gx@renesas.com>
 <87r2rzqf1q.wl%kuninori.morimoto.gx@renesas.com>
 <20171213155952.GL6416@sirena.org.uk>
 <87wp1qow1q.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 2DA8A266D71
 for <alsa-devel@alsa-project.org>; Thu, 14 Dec 2017 06:03:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <87wp1qow1q.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Lars-Peter <lars@metafoo.de>, Shreyas NC <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 14, 2017 at 03:07:30AM +0000, Kuninori Morimoto wrote:
> 
> Hi Mark
> 
> Thank you for your feedback
> 
> > > Because many drivers are directly using rtd->codec_dai / rtd->cpu_dai,
> > > and it is difficult to lookup CPU/Codec DAI from non categorize DAIs.
> > > Thus, we can't support non-categorized DAI at this point.
> > 
> > > Now Vinod want to use Multi CPU DAI.
> > > If we can support Multi CPU DAI / Multi Codec DAI,
> > > we can cleanup current DAI code more.
> > > But what do you think ?

Thanks Morimoto San for initiating the thread,

> > 
> > Cleaning things up so we don't need to use rtd->cpu_dai and rtd->codec_dai
> > would definitely be nice, it's also useful for CODEC<->CODEC links.  Off
> > the top of my head wrapping the accesses with macros/functions then
> > implementing a way of getting the DAI behind them would be tractable?

Yes but one of the problems I see that we have specific ordering on the
DAI ops between various components, is that a specific requirement?

> About cleanup rtd->cpu_dai / rtd->codec_dai topic,
> I don't know we can do it at this point.
> But, I'm happy to think about it.
> I'm thinking like this
> 	1st step: add Multi CPU support

Okay we will send the patches for this by next week or so...

> 	2nd step: Share code between CPU/Codec DAI

And then discuss how to make it common

> 	3rd step: think about No-Categorized DAI (if possible)
> Because many drivers are directly using rtd->cpu_dai, rtd->codec_dai

We should fix that part while at it. I guess drivers needs own dai,
possibly for name or some data, so if they have helpers for that, we
should be able to remove those..

-- 
~Vinod
