From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASOC - Codecs : Renaming of spdif_tranceiver.c
Date: Wed, 7 Mar 2012 17:09:04 +0000
Message-ID: <20120307170903.GR3107@opensource.wolfsonmicro.com>
References: <CAJDSjBikNPj_EExz_XojUOT0c4ip8MG3kEf+dzbcW1s_73SbeA@mail.gmail.com>
	<20120307134310.GK3107@opensource.wolfsonmicro.com>
	<CAJDSjBhYdsxh+=LEfatCLrydSDm_KLCVqfptBkOBStNpZJgS4A@mail.gmail.com>
	<20120307142447.GM3107@opensource.wolfsonmicro.com>
	<CAJDSjBhXpViZ=RDEvuQXjmrWGqtJK6v7ds=z4Lwd4UPUbH04DA@mail.gmail.com>
	<20120307153944.GO3107@opensource.wolfsonmicro.com>
	<CAJDSjBhUvJTM5XXxpU3W0nc2PAWGpZ0ScSCWgr=WhNTGM075fA@mail.gmail.com>
	<20120307163456.GQ3107@opensource.wolfsonmicro.com>
	<CAJDSjBgM1pFmwS3NZHtv4EdLWN3aof4JJtjmgS+4fUx+jca2uQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3050339405545740453=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4FEAC1040F8
	for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2012 18:09:06 +0100 (CET)
In-Reply-To: <CAJDSjBgM1pFmwS3NZHtv4EdLWN3aof4JJtjmgS+4fUx+jca2uQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Nitin PAI <nitinmpai@gmail.com>
Cc: alsa-devel@alsa-project.org, swarren@nvidia.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============3050339405545740453==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E1BPhOSoTthPQdPL"
Content-Disposition: inline


--E1BPhOSoTthPQdPL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 07, 2012 at 10:23:59PM +0530, Nitin PAI wrote:

Please fix your quoting, you're not attributing and you're double
quoting things.

> >>Well, just write a CODEC driver that matches what you've got down on
> >>your boards.  Usually the driver does need to enforce some kind of
> >>limits (on input format and sample rate normally) even for a simple
> >>device with no software control otherwise the device can get driven
> >>out of spec.

> The CODEC is part of the system integration process. From SOC standpoint
> the machine driver is what needs to be delivered.
> I dont know finally what the final codec will be, its upto the integrator
> to write.  May be he can pick the ones from the asoc:codecs list.

Well, quite - if you're working with a system then you need a machine
driver.

> I dont like the dependency of the machine driver with the codec driver for
> enumeration. Machine driver can self exist without having for the codec
> driver. [USB, PCi, HDMI, S/PDIF]  However the vice-versa is not true and is

In the USB case we're going to be going nowhere near ASoC anyway,
there's a totally orthogonal hardware design and set of drivers at the
ALSA level.  Similarly for PCI, though obviously it's possible to make a
PCI card which is decomposed enough to make sense to support via ASoC.

In the S/PDIF case you do actually have a CODEC - while it's common for
this to be a fixed function hardware CODEC (in which case you need a
stub driver saying what it looks like within the system as I said above)
this isn't always the case.  For example, the WM8804 in mainline is a
S/PDIF transciever with register control.  The effort required to bolt
on fixed function drivers (or try to parameterise a generic one if
someone wants to do that) is so trivial it really doesn't seem worth
caring about.  HDMI is broadly similar to S/PDIF here.

> of no use.  Binding them together will make the usecases easy (power for
> instance, user interaction), but should not have been a hardlimit.  Given
> the thought process, ALSA should allow dummy_codec drivers which it does
> (from spdif_tranceiver.c),  but why not make it completely generic? (remove
> the s/pdif keywords).

Allow me to suggest again (as I did earlier in this thread) munging all
these dumb drivers together so you just have a bunch of things in the
one driver which the driver distinguishes by ID.  To repeat once more
you're always going to need to put in at least some information about
the limits the device has.

--E1BPhOSoTthPQdPL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPV5YnAAoJEBus8iNuMP3dgzQP/A4YSbGH7UtzNZ442rMI35md
5+ofLukQfbZApW5XjwnMeXTpD58zkUFLIOoBU+Pb1FmmXW6ZmWYtmn5s/xA5X6FT
2BoOfrP+3A4vTXFp7gQ/IXQVWG1edeJ53i3AdmIttW7sENYCY00cQSH4mA1r4yUD
bKSczLafZgfh46tuB6RKNZ3rL15aXcAOwlfd86O5YZyyaNnDONkj/YYUUQa7zEMm
FMN1A422XW16KAAZveS23il6aLkPAwoxP3xt/7Pdhef73C1suJrIB+xmwvqkKeFn
y/72BZAO337fAeFmOsSSspFADVhqRCbOb/6LUpTPeUAD6qTrWD+X2kabLRAK4vCW
KLfwA1gwnj7ZtxZ5iH3vrCYaa/xZGXIjg0CXYGZhA7CVELsEM0YvYqCjQLAePGWT
HYLgs01XfcrIfvIhFvbg4tIt3Eo0Dw6sqmqEG7WLsVuuIZGW+HmjeLkk/Y+ufrMH
uzUyxEDCIwcXC0EN9/MMEkBra9f6J43QU1vt8BL1iYIKHUvnFfQ3pfwGU7+iJYjp
eHhwaf4/JU57Z0EaD3/2uAf8UtMDX2p8VK8w7PN2loMoot8PS9Pkjmevdy7njkTr
76yH4O/V+quXPfmWTBPoZHVUItFK9mJwcI0gfvJS83OuBilI9L1x5ex8jKqqi8h9
CEPAJYjDkFs8+91nbf4G
=5j3Z
-----END PGP SIGNATURE-----

--E1BPhOSoTthPQdPL--

--===============3050339405545740453==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3050339405545740453==--
