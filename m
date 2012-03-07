From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASOC - Codecs : Renaming of spdif_tranceiver.c
Date: Wed, 7 Mar 2012 16:34:56 +0000
Message-ID: <20120307163456.GQ3107@opensource.wolfsonmicro.com>
References: <CAJDSjBikNPj_EExz_XojUOT0c4ip8MG3kEf+dzbcW1s_73SbeA@mail.gmail.com>
	<20120307134310.GK3107@opensource.wolfsonmicro.com>
	<CAJDSjBhYdsxh+=LEfatCLrydSDm_KLCVqfptBkOBStNpZJgS4A@mail.gmail.com>
	<20120307142447.GM3107@opensource.wolfsonmicro.com>
	<CAJDSjBhXpViZ=RDEvuQXjmrWGqtJK6v7ds=z4Lwd4UPUbH04DA@mail.gmail.com>
	<20120307153944.GO3107@opensource.wolfsonmicro.com>
	<CAJDSjBhUvJTM5XXxpU3W0nc2PAWGpZ0ScSCWgr=WhNTGM075fA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3284223827517713274=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C22A724502
	for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2012 17:34:58 +0100 (CET)
In-Reply-To: <CAJDSjBhUvJTM5XXxpU3W0nc2PAWGpZ0ScSCWgr=WhNTGM075fA@mail.gmail.com>
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


--===============3284223827517713274==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="chReQkDOePndSGWY"
Content-Disposition: inline


--chReQkDOePndSGWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 07, 2012 at 09:58:56PM +0530, Nitin PAI wrote:

> >You can add debugfs information to dump the capabilities and whatnot if
> >>that's useful to you...

> If the cards are not enumerated all these dont make any sense.

The DAI and so on drivers come up all by themselves and need to do so
prior to the cards actually instantiating so we can create debugfs stuff
for them as soon as they register if we want to.

> >>You'd still need to do things like set up the clocking even
> >>for the SoC loopback case, everything is going to need to agree on where
> >>the clocks come from and how they flow.

> Clocks need not come from the codec, it can come from on of the other
> masters in the system.

Right, exactly - the point is that the machine driver makes the decision
about the clocking architecture of the given system, the individual
drivers can't reasonably make that decision themselves.

> >>Honestly it just sounds like you want to write some machine drivers for
> >>your systems.

> Yes, thats the purpose, but I want to ship them to for the reasons I
> mentioned above.
> Since the enumeration of the machine driver depends on the linkage with the
> codec driver its not possible for me to write.
> I wish that the spdif_tranceiver was written for more generalized cases and
> not just spdif.

Well, just write a CODEC driver that matches what you've got down on
your boards.  Usually the driver does need to enforce some kind of
limits (on input format and sample rate normally) even for a simple
device with no software control otherwise the device can get driven
out of spec.

--chReQkDOePndSGWY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPV44lAAoJEBus8iNuMP3d+UAP/2FX6K5/jC66k/Ht/lpWh69V
9JHcS1ZGb3JZGbpma0tSyNhnb0DiaajrEoCniNgdTVdDsBcCvoDPbAedQiXoqcPC
GkOoJfoHsDWikl16SzlfBoScClv6zwhtqo6bPLIyYn990CKL/+mZbpAXgo42HNVT
0Lrg70WoU9vMfQ8Sk79+2XMj3pVbJoc+yxiGf10aWaTCzrwcdZDBjzIl0KPOENlT
F5c81iyMBFHECk+X/Jv/qZmLE75Dt9xjPPiNEOxxZjcyW1Y4dnsQi957oLK6mbtU
A1DisZTXSPZ2aHR0KCu3pVbrTbFosRQBySjyn3tKLg/mBuELJ5sJbkv7rvIIOBtB
TGBl+lS7YOy0NIH/5tOSBczoJwBwhpZWHFkYhLnJzKr7fGDNJHX/daWvzhdfWNiH
45Vkh5eXKisCqIqtNWKzFapnvlfaPCQIp9SBUl0WRTqXA6eUf53EF9g819jw6nln
vkjWsA0+O3drqCZ6y+CnvLdtXyvEXT9ajw5a05TPrILfyPCrd4e6xi6zNVvrGXP8
cYHsJmrQSpFdvk9TkXsFxI69/QUrDisdkDFFp4+uFHqhwC+OclQ7uSOozELnqNqZ
8ks24uEHxbSV/oMXTpI0QpqSgYejpWn6S8tF7loBlFVXV4TS8LS2vPOo+UdtwU3w
9sTsfu83LBKL44XLAKBI
=yFzm
-----END PGP SIGNATURE-----

--chReQkDOePndSGWY--

--===============3284223827517713274==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3284223827517713274==--
