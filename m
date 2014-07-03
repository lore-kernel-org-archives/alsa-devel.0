From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v4 6/8] ASoC: compress: Add support for DAI
 multicodec
Date: Thu, 3 Jul 2014 21:45:17 +0530
Message-ID: <20140703161517.GQ2296@intel.com>
References: <20140701164134.GH2296@intel.com> <53B400DE.3040205@baylibre.com>
 <20140703064147.GK2296@intel.com> <53B539E8.1000301@baylibre.com>
 <53B53C6B.8020707@metafoo.de> <53B540EE.30009@baylibre.com>
 <53B541F0.1040105@metafoo.de> <53B5428F.9050100@baylibre.com>
 <20140703120613.GP2296@intel.com>
 <20140703121846.GB410@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7841053771660829654=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 2EAF12658F4
 for <alsa-devel@alsa-project.org>; Thu,  3 Jul 2014 18:16:38 +0200 (CEST)
In-Reply-To: <20140703121846.GB410@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, misael.lopez@ti.com, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com, Benoit Cousson <bcousson@baylibre.com>
List-Id: alsa-devel@alsa-project.org


--===============7841053771660829654==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XvKFcGCOAo53UbWW"
Content-Disposition: inline


--XvKFcGCOAo53UbWW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 03, 2014 at 01:18:46PM +0100, Mark Brown wrote:
> > BUT Now thinking over this again, does this make sense do do with multi=
ple
> > codecs??
>=20
> > For folks haveing decoders in DSP inside SoC, the compressed device wil=
l be
> > actually a FE. The BE will be PCM to which codec would be linked. The f=
olks
> > supporting decoders inside codec like WM wont ever need this.
>=20
> > Mark, do you agree to this?
>=20
> > So re-thinking again on why we need this??
>=20
> The use case tends to be for applications that have one device per
> physical output.  This isn't normally mobile, it's normally high
> performance audio applications where people are doing things to try to
> electrically isolate the analogue outputs or dealing with high power so
> need to keep speaker outputs physically separate.  I can imagine set top
> box type applications (which do use offloaded media decode) doing this.

Not sure if I follow you, I have no idea of how these systems work.

But if sound card has compressed device it would need to represent using DP=
CM as
we don't know the decoder PCM output. The multiple codecs would then connec=
t to
the PCM BE.=20
So on Compressed FE, we wont have multiple codecs.

For codecs, the compressed audio will go to one codec, multiple ones wont m=
ake
sense.

So how can we have a situation where we have compressed device linked to
multiple codecs?

--=20
~Vinod

--XvKFcGCOAo53UbWW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJTtYGVAAoJEHwUBw8lI4NHwh0P/37pJCCpGpxt82/d7vSu9CRn
Zrcq6LEH21GPGHS29USpB5G4yZ5KYDhij5lva26Bzu09Zz+1BTeYJLgWho5Iyhbt
YdAdp3WyWdyqQzj1MFLcybEvmsrGc/qy8O19DAiJoCC6OG8MrmMdQ120pSEvK88F
CYNyQoDfcrV/UiBI3r5B5q8fO43ePaC7vcjN/mGq/dWvAjTrQyZjEVrGNZhkiKlI
qM8/3ZOd1CW2hGpbuPJDA9uXoTKs1DI1a+yJUcOCOjXNm9gZsE/+CMLg7HKCv/1i
UVe5oN2X8w8hh9eex8x3ww5IFTGR8CcZHpY557IuO2L+vm1lSKUQf7YNkR7Lzzf3
14bLoeRAYv7ThcCUfB+qxY42q26p1Z9BKplOeWupl6wKt3WAXT+sUp4Uc3qeX6IW
NftTc+13MnwLJOqDSPKGl0yehbKQ3GCz+tZAGwN5D15f9Ff3NrR8oRSh/UdRVjYQ
HARqfovrtvq39Pd/IclyHHygmXL1pBpZMBIgPhXQZZegm2M5lnI6qPE06ynGqM1I
rvj2KHs0zrDm3UMXZ8aqLtXROnyhhKeJ8B5Z8arj6XLFrh7BMyhL5esUgHOeCCSv
+KhvhVOyilf2DMVxZ7SD4MQ/PDI5eahvmb6grZEhdpcNaFQpVLJbTx/ZqXUSPzqw
PYLttfYGZ916wHDSZfou
=P34D
-----END PGP SIGNATURE-----

--XvKFcGCOAo53UbWW--

--===============7841053771660829654==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7841053771660829654==--
