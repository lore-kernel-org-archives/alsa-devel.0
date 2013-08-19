From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v5 1/2] ASoC: fsl: Add S/PDIF CPU DAI driver
Date: Mon, 19 Aug 2013 10:35:43 +0100
Message-ID: <20130819093543.GF3719@e106331-lin.cambridge.arm.com>
References: <cover.1376565456.git.b42378@freescale.com>
 <2805432.jMVhHxhr1m@flatron>
 <20130817145316.GT26614@pengutronix.de>
 <8770601.066pCcRnTh@flatron>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
Content-Disposition: inline
In-Reply-To: <8770601.066pCcRnTh@flatron>
Content-Language: en-US
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "mturquette@linaro.org" <mturquette@linaro.org>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, Pawel Moll <Pawel.Moll@arm.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "festevam@gmail.com" <festevam@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Nicolin Chen <b42378@freescale.com>, "timur@tabi.org" <timur@tabi.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "broonie@kernel.org" <broonie@kernel.org>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "galak@codeaurora.org" <galak@codeaurora.org>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Aug 17, 2013 at 04:17:18PM +0100, Tomasz Figa wrote:
> On Saturday 17 of August 2013 16:53:16 Sascha Hauer wrote:
> > On Sat, Aug 17, 2013 at 02:28:04PM +0200, Tomasz Figa wrote:
> > > > > > Also I would make this option required. Use a dummy clock for
> > > > > > mux
> > > > > > inputs that are grounded for a specific SoC.
> > > > > 
> > > > > Some clocks are not from CCM and we haven't defined in
> > > > > imx6q-clk.txt,
> > > > > so in most cases we can't provide a phandle for them, eg:
> > > > > spdif_ext.
> > > > > I think it's a bit hard to force it to be 'required'. An
> > > > > 'optional'
> > > > > looks more flexible to me and a default one is ensured even if
> > > > > it's
> > > > > missing.
> > > > 
> > > > <&clks 0> is the dummy clock. This can be used for all input clocks
> > > > not
> > > > defined by the SoC.
> > > 
> > > Where does this assumption come from? Is it documented anywhere?
> > 
> > This is how all i.MX clock bindings currently are. See
> > Documentation/devicetree/bindings/clock/imx*-clock.txt
> 
> OK, thanks.
> 
> I guess we need some discussion on dummy clocks vs skipped clocks. I think 
> we want some consistency on this, don't we?
> 
> If we really need a dummy clock, then we might also want a generic way to 
> specify it.

What do we actually mean by a "dummy clock"? We already have bindings
for "fixed-clock" and co friends describe relatively simple
preconfigured clocks.

If a clock isn't actually wired, we shouldn't describe it at all, or
we're describing what Linux wants to think rather than what the hardware
actually is. That can easily be handled with clock-names.

Thanks,
Mark.
