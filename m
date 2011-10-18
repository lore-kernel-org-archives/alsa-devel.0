From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [PATCH v4 3/7] ASoC: da7210: Add support for mute
 and zero cross controls
Date: Tue, 18 Oct 2011 13:31:24 +0100
Message-ID: <20111018123124.GC28501@opensource.wolfsonmicro.com>
References: <1318670595.613.42.camel@matrix>
 <20111017214242.GD5200@opensource.wolfsonmicro.com>
 <1318938548.13721.23.camel@matrix>
 <20111018120841.GA28501@opensource.wolfsonmicro.com>
 <1318940943.13721.25.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1318940943.13721.25.camel@matrix>
Sender: linux-kernel-owner@vger.kernel.org
To: Ashish Chavan <ashish.chavan@kpitcummins.com>
Cc: lrg <lrg@ti.com>, alsa-devel <alsa-devel@alsa-project.org>, David Dajun Chen <david.chen@diasemi.com>, "kuninori.morimoto.gx" <kuninori.morimoto.gx@renesas.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 18, 2011 at 05:59:03PM +0530, Ashish Chavan wrote:
> On Tue, 2011-10-18 at 13:08 +0100, Mark Brown wrote:
> > On Tue, Oct 18, 2011 at 05:19:08PM +0530, Ashish Chavan wrote:

> > > 	SOC_DOUBLE_R("Mic Capture Switch", ...),
> > > 	SOC_SINGLE("Aux2 Capture Switch", ...),

> > > 	SOC_DOUBLE_R_TLV("Mic Capture Volume", ...),
> > > 	SOC_SINGLE_TLV("Aux2 Capture Volume", ...),

> > I don't see any conflict in the above?

> If I add these two, alsamixer and amixer shows only one of them (one
> which is added first). Is that fine?

Eh?  One is a Volume, the other is a Switch.  Note that alsamixer does
render the two stacked on top of each other in the UI.
