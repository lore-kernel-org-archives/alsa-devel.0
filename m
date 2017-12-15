From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: About ASoC DAIs cleanup
Date: Fri, 15 Dec 2017 09:50:53 +0530
Message-ID: <20171215042053.GA18649@localhost>
References: <87fu8lio74.wl%kuninori.morimoto.gx@renesas.com>
 <20171208105545.GE18649@localhost>
 <87shciup8e.wl%kuninori.morimoto.gx@renesas.com>
 <87r2s2uo55.wl%kuninori.morimoto.gx@renesas.com>
 <87o9n6ukyg.wl%kuninori.morimoto.gx@renesas.com>
 <87r2rzqf1q.wl%kuninori.morimoto.gx@renesas.com>
 <20171213155952.GL6416@sirena.org.uk>
 <87wp1qow1q.wl%kuninori.morimoto.gx@renesas.com>
 <20171214050648.GU18649@localhost>
 <20171214113718.GB9788@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id CF2E8266BF5
 for <alsa-devel@alsa-project.org>; Fri, 15 Dec 2017 05:17:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20171214113718.GB9788@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter <lars@metafoo.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Shreyas NC <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 14, 2017 at 11:37:18AM +0000, Mark Brown wrote:
> On Thu, Dec 14, 2017 at 10:36:48AM +0530, Vinod Koul wrote:
> > On Thu, Dec 14, 2017 at 03:07:30AM +0000, Kuninori Morimoto wrote:
> 
> > > > Cleaning things up so we don't need to use rtd->cpu_dai and rtd->codec_dai
> > > > would definitely be nice, it's also useful for CODEC<->CODEC links.  Off
> > > > the top of my head wrapping the accesses with macros/functions then
> > > > implementing a way of getting the DAI behind them would be tractable?
> 
> > Yes but one of the problems I see that we have specific ordering on the
> > DAI ops between various components, is that a specific requirement?
> 
> It's designed to minimize pops, it's not a hard requirement but changing
> it might break things for existing systems.

Yes that was my hunch too, so lets keep the order unchanged.

> > > 	3rd step: think about No-Categorized DAI (if possible)
> > > Because many drivers are directly using rtd->cpu_dai, rtd->codec_dai
> 
> > We should fix that part while at it. I guess drivers needs own dai,
> > possibly for name or some data, so if they have helpers for that, we
> > should be able to remove those..
> 
> The drivers need some way to get their driver data back and to know
> which DAI to address on multi device hardware.  Most of the callbacks
> get the DAI passed in directly, that's the simplest thing.

Precisely :)

-- 
~Vinod
