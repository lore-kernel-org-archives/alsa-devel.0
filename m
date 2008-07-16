From: Juergen Beisert <jbe@pengutronix.de>
Subject: Re: CS5530 on Geode GX1 won't work
Date: Wed, 16 Jul 2008 17:42:52 +0200
Message-ID: <200807161742.54249.jbe@pengutronix.de>
References: <200807152315.23490.georg.brand@web.de>
	<487DB4AE.4070901@ladisch.de>
	<200807161629.43001.georg.brand@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by alsa0.perex.cz (Postfix) with ESMTP id C376C244C5
	for <alsa-devel@alsa-project.org>;
	Wed, 16 Jul 2008 17:43:58 +0200 (CEST)
In-Reply-To: <200807161629.43001.georg.brand@web.de>
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
Cc: georg <georg.brand@web.de>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Mittwoch, 16. Juli 2008, georg wrote:
> Hello
>
> > > root@tux:~# aplay foo.wav
> > > aplay: main:546: audio open error: Device or resource busy
> > > ...
> > > root@tux:~# lsof | grep -i pcmC0D0p
> >
> > It's possible that the device has been opened with OSS (i.e., /dev/dsp*)
> > or that somebody has opened the capture device (SB doesn't do full
> > duplex).  Is there anything in /dev/ that is being used?
> [...]
> Any further suggestions?

As the sb16 is fully emulated on Geode GX1/CS5530 based systems, it could a=
lso =

be a bug in the system management code (SMM or VSA)?

Juergen
-- =

Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
=A0Pengutronix - Linux Solutions for Science and Industry
=A0   Handelsregister: Amtsgericht Hildesheim, HRA 2686
=A0 =A0 =A0    Vertretung Sued/Muenchen, Germany
   Phone: +49-8766-939 228 |  Fax: +49-5121-206917-9
