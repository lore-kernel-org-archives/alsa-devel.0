From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [PATCH] ASoC: cs42888: Add codec driver support
Date: Tue, 25 Feb 2014 10:38:41 +0800
Message-ID: <20140225023840.GB7229@MrMyself>
References: <1393224929-7555-1-git-send-email-Guangyu.Chen@freescale.com>
 <20140224113011.GE25940@sirena.org.uk>
 <B745DBDD-8A64-4B98-819B-72F8AFF602DE@cirrus.com>
 <20140224160648.GC6132@MrMyself>
 <20140225000027.GI25940@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140225000027.GI25940@sirena.org.uk>
Sender: linux-doc-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "Austin, Brian" <Brian.Austin@cirrus.com>, "Handrigan, Paul" <Paul.Handrigan@cirrus.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "rob@landley.net" <rob@landley.net>, Liam Girdwood <lgirdwood@gmail.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 25, 2014 at 09:00:27AM +0900, Mark Brown wrote:
> On Tue, Feb 25, 2014 at 12:06:49AM +0800, Nicolin Chen wrote:
> > On Mon, Feb 24, 2014 at 03:52:24PM +0000, Austin, Brian wrote:
> 
> > Wait...Regarding this clock part, I just forgot the reason I put the code:
> 
> > 385         cs42888->clk = devm_clk_get(&i2c->dev, "mclk");
> > 386         if (IS_ERR(cs42888->clk))
> > 387                 dev_warn(&i2c->dev, "failed to get the clock: %ld\n",
> > 388                                 PTR_ERR(cs42888->clk));
> 
> > was because the MCLK might be provided from SoC (DAI master) so it could
> > be totally controlled by CPU DAI driver, ESAI for example has its own
> > dividers to derive the HCKT clock (MCLK for Tx) from ahb clock in SoC
> > clock tree, in which case we might not easily pass a valid clock phandle
> > via DT. (RFC to this thought.)
> 
> We should be getting those clocks visible in the clock API rather than
> doing this.

Hmm...my words might not be so clear last time: we have to handle the dividers
of ESAI in ESAI driver because the dividers is in the ESAI's IP, not in the SoC
clock controlling unit. So it's hard to get them visible in the clock tree.

Thank you,
Nicolin



