From: Juergen Beisert <jbe@pengutronix.de>
Subject: Re: SoC sound support for imx27
Date: Mon, 5 May 2008 14:55:04 +0200
Message-ID: <200805051455.05277.jbe@pengutronix.de>
References: <200804231654.44526.jbe@pengutronix.de>
	<200805051256.38153.jbe@pengutronix.de>
	<20080505124233.GE3426@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by alsa0.perex.cz (Postfix) with ESMTP id 843DE243E0
	for <alsa-devel@alsa-project.org>;
	Mon,  5 May 2008 14:55:10 +0200 (CEST)
In-Reply-To: <20080505124233.GE3426@sirena.org.uk>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Monday 05 May 2008 14:42, Mark Brown wrote:
> On Mon, May 05, 2008 at 12:56:37PM +0200, Juergen Beisert wrote:
> > Hmm, I did a deeper look into this code. Why - for example - does the
> > file mx31ads-wm8753.c does the job of the BSP file? Why it registers
> > devices? For my board I want to register platform_devices only in
> > arc/arm/mach-mx2/pcm038.c. Nowhere else. If there is some glue required
> > to bring components together, IMHO also arc/arm/mach-mx2/pcm038.c is the
> > correct place to do so. Why you did it in sound/ ? If you do it in soun=
d/
> > , you always need two locations to maintain. On in the arch/, one in
> > sound/ .
>
> The model which the existing ASoC platform code is using is that the
> sound subsystem of the device is frequently involved enough to justify
> thinking of it as a discrete "sound card", even if physically it is part
> of the same board.  This is partly inherited from ASoC v1 where the way
> things are registered is less than ideal (it doesn't use the device
> model) and partly due to the fact that some machine definitions can get
> fairly large, especially with more complex board designs.
>
> That said, you don't need to do things this way, especially with ASoC v2
> where even if you do separate out the machine driver you can still
> register everything in your architecture code including a platform
> device for the machine driver.

Hmm, how far away is ASoC v2 from mainline? When I start to develop the dri=
ver =

right now, what version I should use?

Juergen
-- =

Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
=A0Pengutronix - Linux Solutions for Science and Industry
=A0   Handelsregister: Amtsgericht Hildesheim, HRA 2686
=A0 =A0 =A0    Vertretung Sued/Muenchen, Germany
   Phone: +49-8766-939 228 |  Fax: +49-5121-206917-9
