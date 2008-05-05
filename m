From: Juergen Beisert <jbe@pengutronix.de>
Subject: Re: SoC sound support for imx27
Date: Mon, 5 May 2008 12:56:37 +0200
Message-ID: <200805051256.38153.jbe@pengutronix.de>
References: <200804231654.44526.jbe@pengutronix.de>
	<200804241611.21072.jbe@pengutronix.de>
	<1209047409.3286.111.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by alsa0.perex.cz (Postfix) with ESMTP id 7C524243B6
	for <alsa-devel@alsa-project.org>;
	Mon,  5 May 2008 12:56:44 +0200 (CEST)
In-Reply-To: <1209047409.3286.111.camel@localhost.localdomain>
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
List-Id: alsa-devel@alsa-project.org

On Thursday 24 April 2008 16:30, Liam Girdwood wrote:
> On Thu, 2008-04-24 at 16:11 +0200, Juergen Beisert wrote:
> > On Wednesday 23 April 2008 17:36, Liam Girdwood wrote:
> > > On Wed, 2008-04-23 at 16:54 +0200, Juergen Beisert wrote:
> > > > Hi,
> > > >
> > > > I'm going to adapt Freescale's i.MX27 CPU to the SoC sound support
> > > > via I2S. I found the imx21 already in the repository (may it will
> > > > help for my job). Is anybody else working on i.MX27 support (to avo=
id
> > > > to reinvention everything)?
> > >
> > > It's not fully supported atm. However I've had interest from a few
> > > folks who are interested in completing support.
> > >
> > > Currently working :-
> > > [...]
> >
> > Working in what tree? In the git repository I did not found a "struct
> > dma_channel_params" for imx. I'm confused.
>
> http://opensource.wolfsonmicro.com/cgi-bin/gitweb.cgi?p=3Dlinux-2.6-asoc.=
git;
>a=3Dsummary
>
> (dev branch)
>
> It's currently based on the 2.6.22 Freescale kernel (i.e. arch/arm/mxc)
> from their i.MX31ADS board's BSP.
>
> Fwiw, I will be updating stuff as more i.MX code goes upstream, it's
> just a matter of time.

Hmm, I did a deeper look into this code. Why - for example - does the file =

mx31ads-wm8753.c does the job of the BSP file? Why it registers devices? Fo=
r =

my board I want to register platform_devices only in =

arc/arm/mach-mx2/pcm038.c. Nowhere else. If there is some glue required to =

bring components together, IMHO also arc/arm/mach-mx2/pcm038.c is the corre=
ct =

place to do so. Why you did it in sound/ ? If you do it in sound/ , you =

always need two locations to maintain. On in the arch/, one in sound/ .

Juergen

-- =

Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
=A0Pengutronix - Linux Solutions for Science and Industry
=A0   Handelsregister: Amtsgericht Hildesheim, HRA 2686
=A0 =A0 =A0    Vertretung Sued/Muenchen, Germany
   Phone: +49-8766-939 228 |  Fax: +49-5121-206917-9
