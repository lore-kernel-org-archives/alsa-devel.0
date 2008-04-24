From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: SoC sound support for imx27
Date: Thu, 24 Apr 2008 15:30:09 +0100
Message-ID: <1209047409.3286.111.camel@localhost.localdomain>
References: <200804231654.44526.jbe@pengutronix.de>
	<1208964986.3286.62.camel@localhost.localdomain>
	<200804241611.21072.jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D6E941037EC
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Apr 2008 16:30:10 +0200 (CEST)
In-Reply-To: <200804241611.21072.jbe@pengutronix.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2008-04-24 at 16:11 +0200, Juergen Beisert wrote:
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
> > [...]
> 
> Working in what tree? In the git repository I did not found a "struct 
> dma_channel_params" for imx. I'm confused.

http://opensource.wolfsonmicro.com/cgi-bin/gitweb.cgi?p=linux-2.6-asoc.git;a=summary

(dev branch)

It's currently based on the 2.6.22 Freescale kernel (i.e. arch/arm/mxc)
from their i.MX31ADS board's BSP. 

Fwiw, I will be updating stuff as more i.MX code goes upstream, it's
just a matter of time.

Liam
