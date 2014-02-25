From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [PATCH] ASoC: cs42888: Add codec driver support
Date: Tue, 25 Feb 2014 11:13:14 +0800
Message-ID: <20140225031313.GA7343@MrMyself>
References: <1393224929-7555-1-git-send-email-Guangyu.Chen@freescale.com>
 <20140224113011.GE25940@sirena.org.uk>
 <B745DBDD-8A64-4B98-819B-72F8AFF602DE@cirrus.com>
 <20140224160648.GC6132@MrMyself>
 <20140225000027.GI25940@sirena.org.uk>
 <20140225023840.GB7229@MrMyself>
 <20140225030947.GO25940@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140225030947.GO25940@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "Austin, Brian" <Brian.Austin@cirrus.com>, "Handrigan, Paul" <Paul.Handrigan@cirrus.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "rob@landley.net" <rob@landley.net>, Liam Girdwood <lgirdwood@gmail.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 25, 2014 at 12:09:47PM +0900, Mark Brown wrote:
> On Tue, Feb 25, 2014 at 10:38:41AM +0800, Nicolin Chen wrote:
> 
> > Hmm...my words might not be so clear last time: we have to handle the dividers
> > of ESAI in ESAI driver because the dividers is in the ESAI's IP, not in the SoC
> > clock controlling unit. So it's hard to get them visible in the clock tree.
> 
> We should be able to arrange to have the ESAI be a clock provider
> shouldn't we?  If the clocks need to interface to other things (and they
> do) then we should be able to use the standard interface we have to
> clocks.

Excuse me, I think I just don't get the approach how to use clock API to
standardize the MCLK derived from ESAI IP: it's surely not a fixed-clock
so we couldn't register in DT and it's not SoC internal clock which means
we couldn't register it in the SoC clock driver either.

Could you please shed me some light on it?

Thank you,
Nicolin Chen
