From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: SoC sound support for imx27
Date: Thu, 24 Apr 2008 15:26:11 +0100
Message-ID: <1209047171.3286.106.camel@localhost.localdomain>
References: <200804231654.44526.jbe@pengutronix.de>
	<1208964986.3286.62.camel@localhost.localdomain>
	<200804241319.40134.jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5616F24585
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Apr 2008 16:26:13 +0200 (CEST)
In-Reply-To: <200804241319.40134.jbe@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Juergen Beisert <jbe@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2008-04-24 at 13:19 +0200, Juergen Beisert wrote:
> On Wednesday 23 April 2008 17:36, Liam Girdwood wrote:
> > On Wed, 2008-04-23 at 16:54 +0200, Juergen Beisert wrote:
> > > Hi,
> > >
> > > I'm going to adapt Freescale's i.MX27 CPU to the SoC sound support via
> > > I2S. I found the imx21 already in the repository (may it will help for my
> > > job). Is anybody else working on i.MX27 support (to avoid to reinvention
> > > everything)?
> >
> > It's not fully supported atm. However I've had interest from a few folks
> > who are interested in completing support.
> >
> > Currently working :-
> >
> >  o i.MX2x SSI is complete (same as i.MX3)
> 
> But why there are different files for different CPUs when their hardware "on 
> chip" is the same?

Not sure what you mean. The only different files we have here is for the
DMA :-

http://opensource.wolfsonmicro.com/cgi-bin/gitweb.cgi?p=linux-2.6-asoc.git;a=tree;f=sound/soc/imx;h=e9d47b278cfded4ebdb4a4b8541298b7ece886e9;hb=dev


> 
> > Todo:
> >
> >  o i.MX2x DMA is not completed. There is a half ASoC ported OSS based
> > implementation in git atm, although it's not complete due to my only
> > remaining i.MX21 board dying. Should be only about 1 weeks effort to
> > complete this.
> 
> I have an i.MX27 and i.MX31 board here. Question is, what kind of 
> CPU/architecture support you are using for i.MX21? The one from arch/arm/imx? 
> Or something from arch/arm/mxc3, arch/arm/plat-mxc?
> 

I was using an old 2.4 oss kernel (iirc from mv) for the i.MX21 work
until the board died. All the new i.MX work is based on the FSL kernel
i.e. arch/arm/mxc, arch/arm/plat-mxc

> So now we have a few (nearly working) implementations. What should be used? 
> The implementations from soc/imx or from soc/fsl?
> 

imx for ARM, fsl for PPC.

Liam
