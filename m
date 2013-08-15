From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v4 1/2] ASoC: fsl: Add S/PDIF CPU DAI driver
Date: Thu, 15 Aug 2013 17:24:30 +0800
Message-ID: <20130815092428.GI16915@S2101-09.ap.freescale.net>
References: <1376308870-14232-1-git-send-email-b42378@freescale.com>
 <1376308870-14232-2-git-send-email-b42378@freescale.com>
 <CAOMZO5A7noEb98yuCPY6o2mf-FikFcMYiDLpg3huPKHMO7Fwdw@mail.gmail.com>
 <20130814032658.GA16915@S2101-09.ap.freescale.net>
 <20130814053016.GF31651@MrMyself>
 <20130814063931.GB31141@S2101-09.ap.freescale.net>
 <20130814063444.GG31651@MrMyself>
 <20130814081445.GC31141@S2101-09.ap.freescale.net>
 <520BA687.4030905@wwwdotorg.org> <20130815021823.GA1846@MrMyself>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 by alsa0.perex.cz (Postfix) with ESMTP id F1031261599
 for <alsa-devel@alsa-project.org>; Thu, 15 Aug 2013 11:24:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130815021823.GA1846@MrMyself>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <b42378@freescale.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lars@metafoo.de, Stephen Warren <swarren@wwwdotorg.org>, linuxppc-dev@lists.ozlabs.org, timur@tabi.org, rob.herring@calxeda.com, broonie@kernel.org, p.zabel@pengutronix.de, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 15, 2013 at 10:18:23AM +0800, Nicolin Chen wrote:
> Hi Stephen,
> 
> On Wed, Aug 14, 2013 at 09:47:19AM -0600, Stephen Warren wrote:
> > If the clock source name list is different, then it needs a different
> > compatible value, so that each compatible value can specify which clock
> > names are required.
> > 
> > Also, the compatible value itself should always include the exact HW
> > that's present (most specific HW version), as well as any other HW it's
> > compatible with.
>  
> Thank you for the comments. Yes, I did so in v1-v3, but after rethinking
> about the situation (Actually both the HW version and the clock mux itself
> are same, just the clock sources connecting to the mux might be different),
> so I decided to do this by abstracting the driver from those source info
> and letting DT binding to pass such information. Because I think putting 
> the clock sources into the driver differed by compatible value would make
> the driver more like SoC-specified, not the ideal way -- SoC-independent,
> since the clock sources are based on SoC design, not on itself.

+1

It's pretty much the differences at SoC integration level not the IP
itself, and it just happens to be handled in a register of the IP.

Shawn
