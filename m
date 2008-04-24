From: Juergen Beisert <jbe@pengutronix.de>
Subject: Re: SoC sound support for imx27
Date: Thu, 24 Apr 2008 13:19:39 +0200
Message-ID: <200804241319.40134.jbe@pengutronix.de>
References: <200804231654.44526.jbe@pengutronix.de>
	<1208964986.3286.62.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by alsa0.perex.cz (Postfix) with ESMTP id AC1A624516
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Apr 2008 13:19:47 +0200 (CEST)
In-Reply-To: <1208964986.3286.62.camel@localhost.localdomain>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Wednesday 23 April 2008 17:36, Liam Girdwood wrote:
> On Wed, 2008-04-23 at 16:54 +0200, Juergen Beisert wrote:
> > Hi,
> >
> > I'm going to adapt Freescale's i.MX27 CPU to the SoC sound support via
> > I2S. I found the imx21 already in the repository (may it will help for =
my
> > job). Is anybody else working on i.MX27 support (to avoid to reinvention
> > everything)?
>
> It's not fully supported atm. However I've had interest from a few folks
> who are interested in completing support.
>
> Currently working :-
>
>  o i.MX2x SSI is complete (same as i.MX3)

But why there are different files for different CPUs when their hardware "o=
n =

chip" is the same?

> Todo:
>
>  o i.MX2x DMA is not completed. There is a half ASoC ported OSS based
> implementation in git atm, although it's not complete due to my only
> remaining i.MX21 board dying. Should be only about 1 weeks effort to
> complete this.

I have an i.MX27 and i.MX31 board here. Question is, what kind of =

CPU/architecture support you are using for i.MX21? The one from arch/arm/im=
x? =

Or something from arch/arm/mxc3, arch/arm/plat-mxc?

So now we have a few (nearly working) implementations. What should be used? =

The implementations from soc/imx or from soc/fsl?

Juergen

-- =

Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
=A0Pengutronix - Linux Solutions for Science and Industry
=A0   Handelsregister: Amtsgericht Hildesheim, HRA 2686
=A0 =A0 =A0    Vertretung Sued/Muenchen, Germany
   Phone: +49-8766-939 228 |  Fax: +49-5121-206917-9
