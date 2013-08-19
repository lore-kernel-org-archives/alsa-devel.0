From: Nicolin Chen <b42378@freescale.com>
Subject: Re: [PATCH v6 1/2] ASoC: fsl: Add S/PDIF CPU DAI driver
Date: Mon, 19 Aug 2013 14:44:41 +0800
Message-ID: <20130819064440.GA10950@MrMyself>
References: <cover.1376657643.git.b42378@freescale.com>
 <df3c09cd5679649b144bb45dfd5fc746628266d4.1376657643.git.b42378@freescale.com>
 <6A3DF150A5B70D4F9B66A25E3F7C888D07114BC3@039-SN2MPN1-013.039d.mgd.msft.net>
 <20130819030743.GA10544@MrMyself>
 <6A3DF150A5B70D4F9B66A25E3F7C888D07116BA7@039-SN2MPN1-013.039d.mgd.msft.net>
 <20130819062438.GB10544@MrMyself>
 <6A3DF150A5B70D4F9B66A25E3F7C888D07116CDE@039-SN2MPN1-013.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 35757260895
 for <alsa-devel@alsa-project.org>; Mon, 19 Aug 2013 08:44:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <6A3DF150A5B70D4F9B66A25E3F7C888D07116CDE@039-SN2MPN1-013.039d.mgd.msft.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bhushan Bharat-R65777 <R65777@freescale.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "timur@tabi.org" <timur@tabi.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "tomasz.figa@gmail.com" <tomasz.figa@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "festevam@gmail.com" <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 19, 2013 at 02:31:47PM +0800, Bhushan Bharat-R65777 wrote:
> > > > We here suppose the reset bit would be cleared -- "The software
> > > > reset will last
> > > > 8 cycles." from RM, so if this happened to be a failure, the whole
> > > > IP module won't be normally working as well.
> > >
> > > Also add a comment describing this against why cycle = 1000 is selected.
> > 
> > If it is done in 8 cycles, 1000-cycle will be surely a safe value for it.
> > As long as it finished in 8 cycles, it would quit anyway. Why against?
> 
> I am not against, I am saying why it was not 200 or 50 or 20 etc. I am saying that write a comment saying this much is sufficient as per specification and so keep 1000/etc as preservative.

I did't mean that. The 'against' is from

 "Also add a comment describing this 'against' why cycle = 1000 is selected."

Well, if you insist this extra comment for easy-understand, I'll add them

Thank you.
Nicolin Chen
