From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: integration into ASoC
Date: Mon, 10 Mar 2014 11:11:53 +0100
Message-ID: <20140310101153.GD2815@lukather>
References: <20140307165335.GT607@lukather> <5319FE01.3070909@metafoo.de>
 <20140309074853.GI28112@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1147056361800400340=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (top.free-electrons.com [176.31.233.9])
 by alsa0.perex.cz (Postfix) with ESMTP id 2379C265662
 for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2014 11:15:13 +0100 (CET)
In-Reply-To: <20140309074853.GI28112@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, zhuzhenhua@allwinnertech.com, kevin.z.m.zh@gmail.com, sunny@allwinnertech.com, shuge@allwinnertech.com
List-Id: alsa-devel@alsa-project.org


--===============1147056361800400340==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W5WqUoFLvi1M7tJE"
Content-Disposition: inline


--W5WqUoFLvi1M7tJE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 09, 2014 at 07:48:53AM +0000, Mark Brown wrote:
> On Fri, Mar 07, 2014 at 06:12:33PM +0100, Lars-Peter Clausen wrote:
> > On 03/07/2014 05:53 PM, Maxime Ripard wrote:
>=20
> > >I have a sound IP that is part of an SoC that I'm willing to write a
> > >driver for.
>=20
> > Which SoC is this?
>=20
> I'm going to guess it's the Allwinner stuff.

Yep.

> > >Should such a hardware block be handled into ASoC, and if yes, how?
> > >If not, which other framework should be used?
>=20
> > It makes sense to use ASoC if there are components where the driver
> > can be shared e.g. the DMA in your case. Otherwise you can also use
> > plain old ALSA.
>=20
> Right, though one thing to consider here is if the device is typically
> used with external components - some of these systems provide a line
> output which is then connected to external speaker and headphone
> amplifiers which can be things that have ASoC drivers.

Ah, yes. Good to know.

Thanks!

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--W5WqUoFLvi1M7tJE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTHY/pAAoJEBx+YmzsjxAgXAQQAKShgbkJsbehde64MCCf8CTz
HRUEpVXbon4qw3//55LFlmzxEQpsV8HYcKoQF9fhRZfp/4sPB0FYIYaM/rol1YBz
BnSIxzC9dMipH0nDPwgAJCY54iKUwOMIh4tdwUQx0hD0ctEo45pZGlBOIRddkQ9r
7UsiFarJgs6pFOIt9Dcg6NbyPln8E+vDCedw9BrBMrp12E5SiUFmtm1TAyaJWuTs
LNJg7fDYIoi0VB8bqmiFZFyUTGl5O/+xXJWelml3RlZNvPsmXh7Mkl0atZGALur1
o+cIufjemc+SOegMzdHhYKf6jJf43d0BBxcb+cWcBRvTcah1tzTfPdao+GzwlQIb
uTUQhjL8N6ArN2et7zBO/QvOlhe0OY6sg7ttvtKxqOUtHRvJmK3cFpB23/fiker5
SILaON0J0nAgga/HfUdm1OfxxEEnwwQM/mNt6fLElNOiCD/SK6xedaZG/WlyRss6
4duIuyjL6XP+7vnJ5T2Fs73+RaESqiDWKYOZ31FKzeZbB/pgXWzkS868uiFPW9Zm
2QhZmPI94R6TWV1MJrAZgWedwwamt+xj2o3YudyXWKq2N9TBLegTXqAWC/MeJzSd
RAZ4H791Yaim6Hv0NAP0TZL6Hlm2msaixODrN+tBIGWd0tkaifZX8deVKGjzPPE0
ULlsknW4QV5OUufuSujk
=o3OQ
-----END PGP SIGNATURE-----

--W5WqUoFLvi1M7tJE--

--===============1147056361800400340==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1147056361800400340==--
