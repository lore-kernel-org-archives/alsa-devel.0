From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH v5 1/2] ASoC: fsl: Add S/PDIF CPU DAI driver
Date: Sat, 17 Aug 2013 17:17:18 +0200
Message-ID: <8770601.066pCcRnTh@flatron>
References: <cover.1376565456.git.b42378@freescale.com>
 <2805432.jMVhHxhr1m@flatron> <20130817145316.GT26614@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f46.google.com (mail-bk0-f46.google.com
 [209.85.214.46])
 by alsa0.perex.cz (Postfix) with ESMTP id A8AFB2607BB
 for <alsa-devel@alsa-project.org>; Sat, 17 Aug 2013 17:17:22 +0200 (CEST)
Received: by mail-bk0-f46.google.com with SMTP id 6so949934bkj.5
 for <alsa-devel@alsa-project.org>; Sat, 17 Aug 2013 08:17:22 -0700 (PDT)
In-Reply-To: <20130817145316.GT26614@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lars@metafoo.de, mturquette@linaro.org, ian.campbell@citrix.com, pawel.moll@arm.com, swarren@wwwdotorg.org, festevam@gmail.com, Nicolin Chen <b42378@freescale.com>, timur@tabi.org, rob.herring@calxeda.com, broonie@kernel.org, p.zabel@pengutronix.de, galak@codeaurora.org, shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Saturday 17 of August 2013 16:53:16 Sascha Hauer wrote:
> On Sat, Aug 17, 2013 at 02:28:04PM +0200, Tomasz Figa wrote:
> > > > > Also I would make this option required. Use a dummy clock for
> > > > > mux
> > > > > inputs that are grounded for a specific SoC.
> > > > 
> > > > Some clocks are not from CCM and we haven't defined in
> > > > imx6q-clk.txt,
> > > > so in most cases we can't provide a phandle for them, eg:
> > > > spdif_ext.
> > > > I think it's a bit hard to force it to be 'required'. An
> > > > 'optional'
> > > > looks more flexible to me and a default one is ensured even if
> > > > it's
> > > > missing.
> > > 
> > > <&clks 0> is the dummy clock. This can be used for all input clocks
> > > not
> > > defined by the SoC.
> > 
> > Where does this assumption come from? Is it documented anywhere?
> 
> This is how all i.MX clock bindings currently are. See
> Documentation/devicetree/bindings/clock/imx*-clock.txt

OK, thanks.

I guess we need some discussion on dummy clocks vs skipped clocks. I think 
we want some consistency on this, don't we?

If we really need a dummy clock, then we might also want a generic way to 
specify it.

Best regards,
Tomasz
