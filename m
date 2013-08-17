From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v5 1/2] ASoC: fsl: Add S/PDIF CPU DAI driver
Date: Sat, 17 Aug 2013 16:53:16 +0200
Message-ID: <20130817145316.GT26614@pengutronix.de>
References: <cover.1376565456.git.b42378@freescale.com>
 <20130816095357.GA4694@MrMyself>
 <20130816101151.GQ26614@pengutronix.de>
 <2805432.jMVhHxhr1m@flatron>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 994CB2607BB
 for <alsa-devel@alsa-project.org>; Sat, 17 Aug 2013 16:53:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <2805432.jMVhHxhr1m@flatron>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lars@metafoo.de, ian.campbell@citrix.com, pawel.moll@arm.com, swarren@wwwdotorg.org, festevam@gmail.com, Nicolin Chen <b42378@freescale.com>, timur@tabi.org, rob.herring@calxeda.com, broonie@kernel.org, p.zabel@pengutronix.de, galak@codeaurora.org, shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Sat, Aug 17, 2013 at 02:28:04PM +0200, Tomasz Figa wrote:
> > > > Also I would make this option required. Use a dummy clock for mux
> > > > inputs that are grounded for a specific SoC.
> > > 
> > > Some clocks are not from CCM and we haven't defined in imx6q-clk.txt,
> > > so in most cases we can't provide a phandle for them, eg: spdif_ext.
> > > I think it's a bit hard to force it to be 'required'. An 'optional'
> > > looks more flexible to me and a default one is ensured even if it's
> > > missing.
> > 
> > <&clks 0> is the dummy clock. This can be used for all input clocks not
> > defined by the SoC.
> 
> Where does this assumption come from? Is it documented anywhere?

This is how all i.MX clock bindings currently are. See
Documentation/devicetree/bindings/clock/imx*-clock.txt

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
