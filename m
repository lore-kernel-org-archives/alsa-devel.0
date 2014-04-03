From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: jack: export gpio detect
Date: Thu, 3 Apr 2014 23:07:15 +0100
Message-ID: <20140403220715.GG14763@sirena.org.uk>
References: <1396562635-9753-1-git-send-email-cfreeman@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7167480880432282984=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BD6E62656F1
 for <alsa-devel@alsa-project.org>; Fri,  4 Apr 2014 00:07:25 +0200 (CEST)
In-Reply-To: <1396562635-9753-1-git-send-email-cfreeman@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: cfreeman@nvidia.com
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============7167480880432282984==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6S+CllbbV/7E5K18"
Content-Disposition: inline


--6S+CllbbV/7E5K18
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 03, 2014 at 03:03:55PM -0700, cfreeman@nvidia.com wrote:
> From: Christopher Freeman <cfreeman@nvidia.com>
>=20
> Export the gpio detect function so machine drivers
> may call it.  Interrupts for the jack may be disabled
> during sleep, so this allows a machine driver to have
> the jack status updated during resume.

It seems better to have explicit callbacks for this doesn't it, ideally
ones that get triggered by the core without the machine driver having to
do anything?  This is a common need so having to open code it would be a
bit depressing.

--6S+CllbbV/7E5K18
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTPduQAAoJELSic+t+oim9fJcP/0oNXIvdjMFEjIUCk/UafvAx
Wt9FLJMfIzi8aFw/1uqdwbbWBoQ7zDrbeKXoyileG5QPiJhLq7NvSXVNOpr7UAUG
3Sd5q2PhNUFgfwO14gOfV40NsWmwaUG1zYUb9a5T36NTAOScyBU3Ol0t8+oXqP3H
qCInx+3AX7IDkKz1mWvBCAHcEuHwRg7kHMUkwojHiXyRxV3FwbeuyBjAeuuu0nxk
n7OHY4U/MyIADvxc0PTQ4sARYaTaWavs96CA7hOX2Gh9X3cQ4mRxpAP4PeoBI6qr
71tAOwDDz9cLKHg0XaUOmmqNWhPo31Xr/xZFiprzoZVSJdMkK83aG9u3XV1YHWPB
P5S2DYBhYwqCKwAO2F0ekQ3FcSpnmyyg2I379haxsijF+KjhTTumT6SBEw49WsMc
62iS0SkGk/sW1rFDETeJ0HRETGtVVN2WKMz50FPMp2VNOh3/lnGOSYUw/yaxBoqD
zOluA7mpzNCpIjm9r7GYsGu6eNDGtiovn0CtJVFFEU1m77ysg5u9WLjqTesco+pV
+GHMIXHyZFmbXO4wa4xZdsRFeFJU6dZrmz5DhEKQE1EiXJ/Pb9RF4lJ/D2gfETuV
+fVrMAjdG+r8V4I9vhFiC4BIlIWhZQq3foNPaC1DKc8mFGaIRHjnAERuvNSW21QF
WBAD9XKJqSrxJDuI4uA2
=M23I
-----END PGP SIGNATURE-----

--6S+CllbbV/7E5K18--

--===============7167480880432282984==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7167480880432282984==--
