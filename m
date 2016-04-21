From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [alsa-devel] [PATCH 4/4] ASoC: simple-card: Support for
 selecting system clocks by ID
Date: Thu, 21 Apr 2016 15:29:11 -0700
Message-ID: <20160421222911.GE13149@codeaurora.org>
References: <1455545495-20292-5-git-send-email-peter.ujfalusi@ti.com>
 <20160215152635.GN18988@sirena.org.uk>
 <56C2F00C.8080809@ti.com>
 <20160216134233.GN18327@sirena.org.uk>
 <20160216191346.2278.725@quark.deferred.io>
 <56C42BAF.3050900@ti.com>
 <20160217120759.GO7544@sirena.org.uk>
 <56C4CF8B.5010005@ti.com>
 <5715025C.7070108@ti.com>
 <20160418162910.GG3217@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160418162910.GG3217@sirena.org.uk>
Sender: linux-clk-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Michael Turquette <mturquette@baylibre.com>, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Kristo, Tero" <t-kristo@ti.com>, linux-clk@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 04/18, Mark Brown wrote:
> On Mon, Apr 18, 2016 at 06:50:52PM +0300, Peter Ujfalusi wrote:
> > On 02/17/2016 09:52 PM, Peter Ujfalusi wrote:
> 
> > > On the other hand this ABI is backwards compatible since if it is missing it
> > > will default to the configuration we right now have regarding to sysclk_dir
> > > and sysclk_id.
> 
> > > I will look at the CCF implementation for McASP first then for aic3x.
> 
> > The first issue with converting the McASP to use CCF internally for clock
> > selection, muxing and rate configuration is that the daVinci platform does not
> > use CCF at all. Given that the davinci-mcasp driver is used by daVinci, we
> > need to have non CCF way supported in ASoC...
> 
> Well, at least long term we do need daVinci converting to CCF - this is
> going to continue to cause problems, devices not part of the SoC can and
> do contain clocks and are going to end up being supported via the clock
> API.

Does anyone here know what's involved in converting daVinci to
CCF? It doesn't look too far off from what is in the CCF today,
so I'm not sure what's blocking the transition.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
