From: Nicolin Chen <b42378@freescale.com>
Subject: Re: [PATCH v5 1/2] ASoC: fsl: Add S/PDIF CPU DAI driver
Date: Fri, 16 Aug 2013 18:16:18 +0800
Message-ID: <20130816101617.GB4694@MrMyself>
References: <cover.1376565456.git.b42378@freescale.com>
 <4eb991fafc171305ebc71847fecb7bdae0ede927.1376565456.git.b42378@freescale.com>
 <2188999.03O3zirCAO@flatron> <20130816044330.GD1846@MrMyself>
 <20130816070818.GM26614@pengutronix.de>
 <20130816080124.GE1846@MrMyself>
 <20130816085632.GO26614@pengutronix.de>
 <20130816095357.GA4694@MrMyself>
 <20130816101151.GQ26614@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe002.messaging.microsoft.com [216.32.180.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 53800261694
 for <alsa-devel@alsa-project.org>; Fri, 16 Aug 2013 12:18:27 +0200 (CEST)
Content-Disposition: inline
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lars@metafoo.de, ian.campbell@citrix.com, pawel.moll@arm.com, swarren@wwwdotorg.org, festevam@gmail.com, Tomasz Figa <tomasz.figa@gmail.com>, rob.herring@calxeda.com, timur@tabi.org, broonie@kernel.org, p.zabel@pengutronix.de, galak@codeaurora.org, shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 16, 2013 at 12:11:51PM +0200, Sascha Hauer wrote:
> > Some clocks are not from CCM and we haven't defined in imx6q-clk.txt,
> > so in most cases we can't provide a phandle for them, eg: spdif_ext.
> > I think it's a bit hard to force it to be 'required'. An 'optional'
> > looks more flexible to me and a default one is ensured even if it's
> > missing.
> 
> <&clks 0> is the dummy clock. This can be used for all input clocks not
> defined by the SoC.

That's feasible, thank you.

> spdif_ext would be a fixed clock on boards which provide it, but wiring
> this up would be the job of the board maintainer.

Understood.

> Look, it's really simple. Define the binding in a way that describes the
> hardware. Then use some sensible default in the driver for which clock
> to use. This doesn't have to cover all possible usecases, it only has
> to work. This is all that is necessary to get this driver mainline and
> will make most users happy. Then, later, someone might come along who
> needs more fine grained control over the clocks, but this guy is then
> able to justify *why* more control is needed.
> 
> This is not about getting a full featured driver into mainline. Get
> a basic driver into mainline and improve it later. You'll make it
> easier for us all.

Thank you for explain all these to the despicable me.
I'll try to make myself more comfortable with rules here.

Best regards,
Nicolin Chen
