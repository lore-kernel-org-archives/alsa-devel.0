From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH v5 1/2] ASoC: fsl: Add S/PDIF CPU DAI driver
Date: Sat, 17 Aug 2013 14:28:04 +0200
Message-ID: <2805432.jMVhHxhr1m@flatron>
References: <cover.1376565456.git.b42378@freescale.com>
 <20130816095357.GA4694@MrMyself> <20130816101151.GQ26614@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f53.google.com (mail-bk0-f53.google.com
 [209.85.214.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F20B26031E
 for <alsa-devel@alsa-project.org>; Sat, 17 Aug 2013 14:28:09 +0200 (CEST)
Received: by mail-bk0-f53.google.com with SMTP id d7so911943bkh.40
 for <alsa-devel@alsa-project.org>; Sat, 17 Aug 2013 05:28:09 -0700 (PDT)
In-Reply-To: <20130816101151.GQ26614@pengutronix.de>
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lars@metafoo.de, ian.campbell@citrix.com, pawel.moll@arm.com, swarren@wwwdotorg.org, festevam@gmail.com, Nicolin Chen <b42378@freescale.com>, timur@tabi.org, rob.herring@calxeda.com, broonie@kernel.org, p.zabel@pengutronix.de, galak@codeaurora.org, shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Friday 16 of August 2013 12:11:51 Sascha Hauer wrote:
> On Fri, Aug 16, 2013 at 05:53:58PM +0800, Nicolin Chen wrote:
> > On Fri, Aug 16, 2013 at 10:56:32AM +0200, Sascha Hauer wrote:
> > > > "tx<0-8>"	Optional	Tx clock source for spdif 
playback.
> > > > 
> > > > 				If absent, will use core clock.
> > > > 				The index from 0 to 8 is identical
> > > > 				to the clock source list described
> > > > 				in TxClk_Source bit of register 
STC.
> > > > 				Multiple clock source are allowed
> > > > 				for this tx clock source. The 
driver
> > > > 				will select one source from them 
for
> > > > 				each supported sample rate 
according
> > > > 				to the clock rates of these 
provided
> > > > 				clock sources.
> > > 
> > > You mean tx<0-7>
> > 
> > Yes. Thank you.
> > 
> > > Also I would make this option required. Use a dummy clock for mux
> > > inputs that are grounded for a specific SoC.
> > 
> > Some clocks are not from CCM and we haven't defined in imx6q-clk.txt,
> > so in most cases we can't provide a phandle for them, eg: spdif_ext.
> > I think it's a bit hard to force it to be 'required'. An 'optional'
> > looks more flexible to me and a default one is ensured even if it's
> > missing.
> 
> <&clks 0> is the dummy clock. This can be used for all input clocks not
> defined by the SoC.

Where does this assumption come from? Is it documented anywhere? What 
about cases when you have full description of clocks in device tree, with 
one node per clock and #clock-cells = <0>?

Best regards,
Tomasz
